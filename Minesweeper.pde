import de.bezier.guido.*;
private final static int NUM_ROWS = 20;
private final static int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList mines = new <MSButton> ArrayList(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
   buttons = new MSButton[NUM_ROWS][NUM_COLS];
      for(int i = 0; i < NUM_ROWS; i++){
     for(int g = 0; g < NUM_COLS; g++){
       buttons[i][g] = new MSButton(i, g);
     }
    
   }
   for(int i = 0; i < 24; i++){
    setMines();}
}
public void setMines()
{
    int row = (int)(Math.random()*NUM_ROWS);
    int col = (int)(Math.random()*NUM_COLS);
    if(!mines.contains(buttons[row][col]))
    mines.add(buttons[row][col]);
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
    for(int i = 0; i < NUM_ROWS; i++){
      for(int g = 0; g < NUM_COLS; g++){
        if(buttons[i][g].clicked == false && !mines.contains(buttons[i][g]))
        return false;
      }
    }
    return true;
}
public void displayLosingMessage()
{
    buttons[NUM_ROWS/2][NUM_COLS/2].myLabel = "You";
    buttons[NUM_ROWS/2][(NUM_COLS/2)+2].myLabel = "Lost";
   // exit();
}
public void displayWinningMessage()
{
    buttons[NUM_ROWS/2][NUM_COLS/2].myLabel = "You";
    buttons[NUM_ROWS/2][(NUM_COLS/2)+2].myLabel = "Won";
}
public boolean isValid(int r, int c)
{
    if((r >= 0 && r < NUM_ROWS) && (c >= 0 && c < NUM_COLS))
    return true;
    return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    for(int i = row-1; i <= row+1; i++){
      for(int g = col-1; g <= col+1; g++){
        if((isValid(i,g)==true) && (mines.contains(buttons[i][g]))){
          if(i != row || g != col)
          numMines++;
        }
      }
    } 
    return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
         width = 400/NUM_COLS;
         height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
        clicked = true;
        if(mouseButton == RIGHT){
        if(clicked == true)
        clicked = false;
        
        if(clicked == false)
        clicked = true;
      }
        if(mines.contains(buttons[myRow][myCol]))
        displayLosingMessage();
        
      if(countMines(myRow,myCol) > 0 && !mines.contains(buttons[myRow][myCol]))
       setLabel(countMines(myRow,myCol));
       
        else
        for(int r = myRow-1; r <= myRow+1; r++){
          for(int c = myCol-1; c <= myCol+1; c++){
            if(isValid(r,c) == true && buttons[r][c].clicked == false && !mines.contains(buttons[r][c]))
             buttons[r][c].mousePressed();
          }
        }
        
    }
    public void draw () 
    {    
        if (flagged)
            fill(0);
            
        else if( clicked && mines.contains(this) ) 
             fill(255,0,0);
             
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}
