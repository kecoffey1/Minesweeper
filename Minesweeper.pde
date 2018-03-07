import de.bezier.guido.*;
int NUM_ROWS = 20; 
int NUM_COLS = 20; 
int play = 0; 
private MSButton[][] buttons; //2d array of minesweeper buttons


private ArrayList <MSButton> bombs = new ArrayList();  //ArrayList of just the minesweeper buttons that are mined
void setup ()
{
  
    buttons = new MSButton[NUM_ROWS][NUM_COLS]; 
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    for (int x = 0; x < NUM_ROWS; x ++) { 
      for (int y = 0; y < NUM_COLS; y ++) {
         buttons[x][y] = new MSButton(x,y); 
      }
    }
    
    
    for (int i = 0; i < 20; i ++) {
    setBombs();
    }
}
public void setBombs()
{
    int x = (int)(Math.random() * NUM_ROWS); 
    int y = (int)(Math.random() * NUM_COLS); 
    if (bombs.contains(buttons[x][y]) == false) {
      bombs.add(buttons[x][y]); 
    }
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
   for(int r = 0; r < NUM_ROWS; r++)
    {
       for(int c = 0; c < NUM_COLS; c++)
        {
            if(!buttons[r][c].isClicked() && !bombs.contains(buttons[r][c]))
              {
                return false;
              }
        }
    }
    
    return true;
}
public void displayLosingMessage()
{
    play = 2; 
     
    buttons[NUM_ROWS/2][NUM_COLS/2-3].setLabel("Y");
   buttons[NUM_ROWS/2][NUM_COLS/2-2].setLabel("O");
   buttons[NUM_ROWS/2][NUM_COLS/2-1].setLabel("U");
   buttons[NUM_ROWS/2][NUM_COLS/2].setLabel("");
   buttons[NUM_ROWS/2][NUM_COLS/2+1].setLabel("L");
   buttons[NUM_ROWS/2][NUM_COLS/2+2].setLabel("O");
   buttons[NUM_ROWS/2][NUM_COLS/2+3].setLabel("S");
   buttons[NUM_ROWS/2][NUM_COLS/2+4].setLabel("E");
    
}
public void displayWinningMessage()
{
   play = 1; 
   fill(255,0,0); 
   buttons[NUM_ROWS/2][NUM_COLS/2-3].setLabel("Y");
   buttons[NUM_ROWS/2][NUM_COLS/2-2].setLabel("O");
   buttons[NUM_ROWS/2][NUM_COLS/2-1].setLabel("U");
   buttons[NUM_ROWS/2][NUM_COLS/2].setLabel("");
   buttons[NUM_ROWS/2][NUM_COLS/2+1].setLabel("W");
   buttons[NUM_ROWS/2][NUM_COLS/2+2].setLabel("I");
   buttons[NUM_ROWS/2][NUM_COLS/2+3].setLabel("N");
   
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
         height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
      if (play == 0){
        clicked = true;
      
        if (mouseButton == RIGHT) {
          
          if (marked == true)
            marked = false;
          if (marked == false)
            marked = true;  
            clicked = false; 
        }
        
        else if (bombs.contains(this)) {
        
          displayLosingMessage(); 
        }
        else if (countBombs(r,c) != 0)  {
           
          setLabel("" + countBombs(r,c));
        }
        else
        {
           
            if(isValid(r,c-1) && !buttons[r][c-1].isClicked())
            {
              
                buttons[r][c-1].mousePressed();
            }
            if(isValid(r-1,c-1) && !buttons[r-1][c-1].isClicked())
            {
                buttons[r-1][c-1].mousePressed();
            }
            if(isValid(r-1,c) && !buttons[r-1][c].isClicked())
            {
                buttons[r-1][c].mousePressed();
            }
            if(isValid(r,c+1) && !buttons[r][c+1].isClicked())
            {
                buttons[r][c+1].mousePressed();
            }
            if(isValid(r+1,c+1) && !buttons[r+1][c+1].isClicked())
            {
                buttons[r+1][c+1].mousePressed();
            }
            if(isValid(r+1,c) && !buttons[r+1][c].isClicked())
            {
                buttons[r+1][c].mousePressed();
            }
            if(isValid(r+1,c-1) && !buttons[r+1][c-1].isClicked())
            {
                buttons[r+1][c-1].mousePressed();
            }
            if(isValid(r-1,c+1) && !buttons[r-1][c+1].isClicked())
            {
                buttons[r-1][c+1].mousePressed();
            }
            
        }
    }}

    public void draw () 
    {    
        if (play == 1) 
          fill(0,255,0); 
        else if ( play == 2) 
            fill(255,100,100); 
        else if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int x, int y)
    {
        if(0 <= x && x < 20 && 0 <= y && y < 20) {
          return true;
        }
        return false;
    }
    public int countBombs(int x, int y)
    {
        int numBombs = 0;
        
          if (isValid(x,y-1) && bombs.contains(buttons[x][y-1])) {
            numBombs++; 
          }
          if (isValid(x-1,y-1) && bombs.contains(buttons[x-1][y-1])) {
            numBombs++; 
          }
          if (isValid(x-1,y) && bombs.contains(buttons[x-1][y])) {
            numBombs++; 
          }
          if (isValid(x-1,y+1) && bombs.contains(buttons[x-1][y+1])) {
            numBombs++; 
          }
          if (isValid(x,y+1) && bombs.contains(buttons[x][y+1])) {
            numBombs++; 
          }
          if (isValid(x+1,y+1) && bombs.contains(buttons[x+1][y+1])) {
            numBombs++; 
          }
          if (isValid(x+1,y) && bombs.contains(buttons[x+1][y])) {
            numBombs++; 
          }
          if (isValid(x+1,y-1) && bombs.contains(buttons[x+1][y-1])) {
            numBombs++; 
          }
          
        
        
        return numBombs;
    }
}