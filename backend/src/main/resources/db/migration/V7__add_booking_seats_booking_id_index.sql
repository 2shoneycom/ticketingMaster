-- booking_seats 의 booking_id 인덱스 추가
-- V6 에서 UNIQUE (match_id, seat_id) 를 드롭할 때 Oracle 이 딸린 인덱스도 함께 제거함
-- Oracle 은 MySQL 과 달리 FK 컬럼에 인덱스를 자동 생성하지 않아 PK 외 인덱스가 없는 상태였음
-- BookingRepository 의 JOIN FETCH b.bookingSeats 조회가 booking_id 로 진입하므로 인덱스 없이는 매번 풀 스캔임

DECLARE
  v_count NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_count
  FROM user_indexes
  WHERE index_name = 'IDX_BOOKING_SEAT_BOOKING_ID'
    AND table_name = 'BOOKING_SEATS';
  IF v_count = 0 THEN
    EXECUTE IMMEDIATE 'CREATE INDEX idx_booking_seat_booking_id ON booking_seats (booking_id)';
  END IF;
END;
/
