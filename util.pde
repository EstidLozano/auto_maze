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

  int x, y;
  
  Point(int x, int y) {
    this.x = x;
    this.y = y;
  }
  
}

public static class Dimension {

  int w, h;
  
  Dimension(int w, int h) {
    this.w = w;
    this.h = h;
  }
  
}

abstract class Button {
  
  float x, y, w, h;
  String txt;
  
  Button(String txt, float x, float y, float w, float h) {
    this.txt = txt;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  void render() {
    fill(255, 255, 255);
    stroke(100);
    strokeWeight(2);
    rect(x, y, w, h);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(h * 0.7);
    text(txt, x + w / 2, y + h / 2);
  }
  
  abstract void onClick();
  
  void mouseClicked() {
    if (mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h) {
      onClick();
    }
  }
  
}
