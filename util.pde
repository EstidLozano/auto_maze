import java.util.Iterator;
import java.util.NoSuchElementException;

public static class LinkedList<T> implements Iterable<T> {
  
  private static class Node<T> {
    
    T value;
    Node<T> prev, next;
    
    Node(T value, Node<T> prev, Node<T> next) {
      this.value = value;
      this.prev = prev;
      this.next = next;
      if (prev != null) prev.next = this;
      if (next != null) next.prev = this;
    }
    
  }
  
  private Node<T> first, last;
  
  private int size;
  
  public T getFirst() {
    if (size == 0) return null;
    return first.value;
  }
  
  public T getLast() {
    if (size == 0) return null;
    return last.value;
  }
  
  public T get(int index) {
    Node<T> n = getNode(index);
    return n == null ? null : n.value;
  }
  
  private Node<T> getNode(int index) {
    if (index < size / 2) {
      Node<T> i = first;
      while(index-- > 0) i = i.next;
      return i;
    } else {
      index = size - 1 - index;
      Node<T> i = last;
      while(index-- > 0) i = i.prev;
      return i;
    }
  }
  
  public void addFirst(T value) {
    first = new Node(value, null, first);
    if (size == 0) last = first;
    size++;
  }
  
  public void addLast(T value) {
    last = new Node(value, last, null);
    if (size == 0) first = last;
    size++;
  }
  
  public void removeFirst() {
    if (first == null) return;
    first = first.next;
    if (first != null) first.prev = null;
    size--;
  }
  
  public void removeLast() {
    if (last == null) return;
    last = last.prev;
    if (last != null) last.next = null;
    size--;
  }
  
  public void remove(int index) {
    if (index == 0) {
      removeFirst();
      return;
    }
    if (index == size - 1) {
      removeLast();
      return;
    }
    Node<T> node = getNode(index);
    node.prev.next = node.next;
    node.next.prev = node.prev;
    size--;
  }
  
  public void removeAll() {
    first = null;
    last = null;
    size = 0;
  }
  
  public int getSize() {
    return size;
  }
  
  public Iterator<T> iterator() {
        return new ListIterator(first);
  }

  private class ListIterator implements Iterator<T> {

        private Node<T> node;
        
        public ListIterator(Node<T> head) {
          this.node = head;
        }

        public boolean hasNext() {
            return node != null;
        }

        public T next() {
            if (hasNext()) {
              T val = node.value;
              node = node.next;
              return val;
            }
            throw new NoSuchElementException();
        }

        public void remove() {
            throw new UnsupportedOperationException("not supported yet");
        }
   }
  
}

public static class Point {

  float x, y;
  
  Point(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
}

public static class Dimension {

  float w, h;
  
  Dimension(float w, float h) {
    this.w = w;
    this.h = h;
  }
  
}

abstract class Button {
  
  Point pos;
  Dimension size;
  float stroke;
  int colBg, colHoverBg, colStroke, colHoverStroke, colTxt, colHoverTxt;
  String txt;
  
  Button(String txt, Point position, Dimension size) {
    this.txt = txt;
    this.pos = position;
    this.size = size;
    
    stroke = 2;
    
    colBg     = 0xffffffff;
    colStroke = 0xff888888;
    colTxt    = 0xff444444;
    
    colHoverBg     = 0xffcccccc;
    colHoverStroke = 0xff666666;
    colHoverTxt    = 0xff333333;
  }
  
  void draw() {
    strokeWeight(stroke);
    if (mouseHover()) {
      stroke(colHoverStroke);
      fill(colHoverBg);
      rect(pos.x, pos.y, size.w, size.h);
      fill(colHoverTxt);
    } else {
      stroke(colStroke);
      fill(colBg);
      rect(pos.x, pos.y, size.w, size.h);
      fill(colTxt);
    }
    textAlign(CENTER, CENTER);
    textSize(size.h * 0.7);
    text(txt, pos.x + size.w / 2, pos.y + size.h / 2);
  }
  
  abstract void onClick();
  
  boolean mouseHover() {
    return mouseX >= pos.x && mouseX <= pos.x + size.w
        && mouseY >= pos.y && mouseY <= pos.y + size.h;
  }
  
  boolean mouseClicked() {
    if (mouseHover()) {
      onClick();
      return true;
    }
    return false;
  }
  
}

class DropdownList {

  Dimension size;
  Point pos;
  
  String[] elements;
  private Button[] btns;
  private Button btnCurrent;
  
  int selection;
  boolean dropped;
  
  DropdownList (String[] elements, Point position, Dimension size) {
    this.elements = elements;
    this.size = size;
    this.pos = position;
    
    btns = new Button[elements.length];
    for (int i = elements.length - 1; i >= 0; i--) {
      final int fI = i;
      btns[i] = new Button(elements[i], new Point(pos.x, pos.y + size.h * (i + 1)), size) {
        void onClick() {
          selection = fI;
          btnCurrent.txt = btns[selection].txt;
          btnCurrent.onClick();
        }
      };
    }
    btnCurrent = new Button(btns[selection].txt, pos, size) {
      void onClick() {
        dropped = !dropped;
      }
    };
  }
  
  void draw() {
    if (dropped) {
      for(Button i : btns) i.draw();
    } else {
      btnCurrent.draw();
    }
    
  }
  
  boolean mouseClicked() {
    for (Button i : btns) {
      if (i.mouseClicked()) return true;
    }
    if (btnCurrent.mouseClicked()) return true;
    dropped = false;
    return false;
  }
  
}
