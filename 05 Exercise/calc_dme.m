function dme = calc_dme(J, B)
    dme = pinv(J)' * B' * B * pinv(J);
end

% J = 6x3
% B = 3x3
% pinv(J) = 3x6
% pinv(J)' = 6x3
% pinv(J)'B' = 6x3 * 3x3
% pinv(J)'B'B = 6x3 * 3x3 * 3x3
% pinv(J)'B'Bpinv(J) = 6x3 * 3x3 * 3x3 * 3x6 = 6x6
