interface IGameObject
{
  void afficher();
}

abstract class NonPlayableObject implements IGameObject
{
  abstract boolean collision();
}

abstract class PlayableObject implements IGameObject
{
  // Parameters
  int frequenceTirs = 0;
  int vie = 3;
  int degat = 0;
  int speed = 1;
  int score;
  int[] pos;
  int[] size;
  ArrayList<Tir> tirs = new ArrayList<Tir>();
  
  abstract void tirer();
}
