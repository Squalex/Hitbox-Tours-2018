class Boss extends NonPlayableObject
{
  int[] pos = { width };
  int[] size = {300,300};
  PImage[] boss = new PImage[2];
  PImage deadBoss = new PImage();
  boolean goToTop=true;
  int vie;
  PImage[] attack = new PImage[5];
  ArrayList<Tir> tirs = new ArrayList<Tir>();

  SoundMaster soundMaster;
 
  Boss(SoundMaster p_soundMaster){
    soundMaster = p_soundMaster;
  }
  
  
  
  /******************************************************************************************/
  /*                                       DISPLAY                                          */
  /******************************************************************************************/

  void afficher()
  {
    tint(255, 255, 255);
    image(boss[(frameCount/5)%2],pos[0], pos[1], size[0], size[1]);
  }
  
  void afficherDeath()
  {
    image(deadBoss,pos[0], pos[1], size[0], size[1]);
  }
 
  /******************************************************************************************/
  /*                                         MOVE                                           */
  /******************************************************************************************/

  boolean moveDead()
  {
    if(size[1] + pos[1] > 0){
      pos[1] += 5;
    }
    return true;
  }
  
  void deplacer()
  {
    if(pos[0]+size[0]>width)
    {
      pos[0] -= 5;
    }
    else{ 
      // Go top
      if(goToTop)
      {
        if(pos[1]+size[1]>=height)
        {
          goToTop = !goToTop;
        }
        else
        {
          pos[1] += 5;
        }
      }
      // Go down
      else
      {
        if(pos[1]<0)
        {
          goToTop = !goToTop;
        }
        else
        {
          pos[1] -= 5;
        }
      }
    }   
  }
  
  /******************************************************************************************/
  /*                                        UTILITIES                                       */
  /******************************************************************************************/
  
  boolean collision()
  {
    // If the boss touch the player
    if(joueur.pos[0] < pos[0]+size[0] && joueur.pos[0]+joueur.size[0] > pos[0] && joueur.pos[1] < pos[1]+size[1] && joueur.pos[1]+joueur.size[1] > pos[1])   
    {
      joueur.degat();
      return true;
    }
    
    // If the boss receive a shot
    for (int i = 0; i < joueur.tirs.size(); i++)
    {
      if (joueur.tirs.get(i).pos[1] >= pos[1] && joueur.tirs.get(i).pos[1] < pos[1]+size[1] && joueur.tirs.get(i).pos[0] > pos[0] && joueur.tirs.get(i).pos[0]+joueur.tirs.get(i).size[0] < pos[0]+size[0])
      {
        joueur.tirs.remove(i);        
        soundMaster.playSoundEffect("ennemyHit");
        joueur.score++;
        return true;
      }
    }
    
    return false; 
  }
  
  void attack()
  {
    if (int(random(100)) == 0)
    {
       tirs.add(new Tir(pos[0], pos[1], size[0], size[1]));
       
    }
    
    attackCollision();
    
    for (Tir tir : tirs)
    {
      tir.moveLeft();
      tir.afficherImage(attack);
    }
     
  }
  
  
  void attackCollision()
  {
    // If the Player receive a shot
    if(tirs == null)
      return;
    for (int i = 0; i < tirs.size(); i++)
    {
      if (joueur.pos[1] >= tirs.get(i).pos[1] && joueur.pos[1] < tirs.get(i).pos[1]+tirs.get(i).size[1] && joueur.pos[0] > tirs.get(i).pos[0] && joueur.pos[0]+joueur.size[0] < tirs.get(i).pos[0]+tirs.get(i).size[0])
      {
        tirs.remove(i);
        joueur.degat();
        if (joueur.vie <= 0)
        {
          state = Scene.GameOver;
          joueur.resetPlayer();
        }
      }
    }
  }
  
}
