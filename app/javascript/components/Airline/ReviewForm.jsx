import React from 'react';

const ReviewForm = (props) => {
  const { review, attributes, handleSubmit, handleChange } = props;
  const ratingOptions = [5, 4, 3, 2, 1].map((score, _index) => {
    return (
      <React.Fragment>
        <input
          type="radio"
          value={score}
          name="rating"
          onChange={() => {
            console.log('selected:', score);
          }}
          id={`rating-${score}`}
        />
        ;<lable></lable>;
      </React.Fragment>
    );
  });

  return (
    <div className="wrapper">
      <form onSubmit={handleSubmit}>
        <div>
          Have an experience with ${attributes.name}? Share your review!
        </div>
        <div className="field">
          <input
            onChange={handleChange}
            value={review.title}
            type="text"
            name="title"
            placeholder="Review Title"
          />
        </div>
        <div className="field">
          <input
            onChange={handleChange}
            value={review.description}
            type="text"
            name="description"
            placeholder="Review Description"
          />
        </div>
        <div className="field">
          <div className="raiting-container">
            <div className="rating-title-text">Rate This Airline</div>
            {ratingOptions}
          </div>
        </div>
        <button type="submit">Submit Your Review</button>
      </form>
    </div>
  );
};

export default ReviewForm;
