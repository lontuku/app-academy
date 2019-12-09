class DOMNodeCollection {
  constructor(htmlElementArr) {
    this.elements = htmlElementArr;
  }

  html(string) {
    if (string !== undefined) {
      this.elements.forEach(element => element.innerHTML = string);
    } else {
      return this.elements[0].innerHTML;
    }
  }

  empty() {
    this.html('');
  }

  append(children) {
    if (typeof children === 'object' && !(children instanceof DOMNodeCollection)) {
      children = $l(children);
    }

    if (typeof children === 'string') {
      this.elements.forEach(element => element.innerHTML += children);
    } else if (children instanceof DOMNodeCollection) {
      this.elements.forEach((element) => {
        for (let i = 0; i < children.elements.length; i++) {
          const childElement = children.elements[i];
          element.innerHTML += childElement.outerHTML;
        }
      })
    }
  }

  attr(prop, val) {
    if (val) {
      this.elements.forEach(element => element.setAttribute(prop, val));
    } else {
      this.elements[0].getAttribute(prop);
    }
  }

  addClass(className) {
    this.elements.forEach(element => element.classList.add(className));
  }

  removeClass(className) {
    this.elements.forEach(element => element.classList.remove(className));
  }
}

module.exports = DOMNodeCollection;