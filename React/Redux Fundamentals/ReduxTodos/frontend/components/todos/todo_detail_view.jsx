import React from 'react';

const TodoDetailView = ({ todo, removeTodo }) => {
  return (
    <ul>
      <li>{ todo.body }</li>
    </ul>
  )
};

export default TodoDetailView;
