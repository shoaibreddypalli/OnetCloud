/*University of Leicester
 * Module: Advanced Web Technologies
 * Course Work 2 _Group 25
 * Aim: Online Onet Web App 
 * Author: msr33
 * */
 
package com.onet.onetconnect;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/onet")
public class OnetController {

	@RequestMapping("/")
	public String init() {

		System.out.println("Hello Onet");

		return "onet";

	}

	@RequestMapping(value = "/checkValid", method = RequestMethod.POST)
	@ResponseBody
	public List<String> checkValid(@RequestParam("source") int source, @RequestParam("destination") int destination,
			@RequestParam("matrix[]") List<Integer> matrix) {

		System.out.println("Hi Server");
		System.out.println(source);
		System.out.println(destination);
		System.out.println(matrix);
		int x1 = source / 4 + 1;
		int y1 = source % 4 + 1;
		int x2 = destination / 4 + 1;
		int y2 = destination % 4 + 1;
		System.out.println(x1 + "," + y1);
		System.out.println(x2 + "," + y2);
		int[][] arr = new int[6][6];
		for (int[] arr1 : arr)
			Arrays.fill(arr1, -1);

		for (int i = 0; i < arr.length; i++) {
			for (int j = 0; j < arr[i].length; j++) {
				if (i == 0 || i == arr[i].length - 1 || j == 0 || j == arr[i].length - 1) {
					arr[i][j] = 0;
				}
			}
		}

		matrix.forEach(index -> {
			if (index != -1) {
				// index=index+1;
				arr[(index / 4) + 1][(index % 4) + 1] = 0;

			}
		});

		List<String> result = new ArrayList<String>();
		Cell cell = isValidSelection(arr, x1, y1, x2, y2);
		System.out.println(cell);

		while (cell != null) {

			result.add(cell.row + "," + cell.column);
			cell = cell.parent;

		}
		System.out.println(result);

		return result;

	}

	public static Cell isValidSelection(int[][] matrix, int x1, int y1, int x2, int y2) {

		int numberOfColumns = matrix.length;
		int numberOfRows = matrix[0].length;

		int[][] directions = { { 0, 1 }, { 0, -1 }, { 1, 0 }, { -1, 0 } };

		Queue<Cell> queue = new LinkedList<Cell>();

		Cell source = new Cell(x1, y1, 0, true, true, null);
		queue.add(source);
		boolean isInit = true;
		boolean isRowWise = false; // column should be same
		int turns = 0;
		while (queue.size() > 0) {
			Cell currentCell = queue.poll();
			System.out.println(currentCell);
			// Mark visited cell as -1
			matrix[currentCell.row][currentCell.column] = -1;

			// check is destination cell
			if (currentCell.row == x2 && currentCell.column == y2)
				return currentCell;

			// check adjacent cells
			for (int i = 0; i < 4; i++) {
				int adjRow = currentCell.row + directions[i][0];
				int adjCol = currentCell.column + directions[i][1];

				// check validity
				if (adjRow >= 0 && adjCol >= 0 && adjRow < numberOfRows && adjCol < numberOfColumns) {
					System.out.println("Adj:" + adjRow + "," + adjCol);

					if (adjRow == x2 && adjCol == y2) {

						System.out.print("Reached!!!!!");

						if (currentCell.isRowWise) {
							if (currentCell.row != adjRow) {
								isRowWise = false;
								turns = currentCell.turn + 1;
							} else {
								isRowWise = true;
								turns = currentCell.turn;
							}

						} else {
							if (currentCell.column != adjCol) {
								isRowWise = true;
								turns = currentCell.turn + 1;
							} else {
								isRowWise = false;
								turns = currentCell.turn;
							}

						}
						if (turns <= 2) {
							System.out.println("Turns:" + turns);
							return currentCell;
						} else {
							System.out.println("But, Many turns!!!!!!!!");
						}
					} else if (matrix[adjRow][adjCol] != -1) {
						if (isInit) {
							isRowWise = (currentCell.row == adjRow) ? true : false;
							turns = 0;

						} else {
							if (currentCell.isRowWise) {
								if (currentCell.row != adjRow) {
									isRowWise = false;
									turns = currentCell.turn + 1;
								} else {
									isRowWise = true;
									turns = currentCell.turn;
								}

							} else {
								if (currentCell.column != adjCol) {
									isRowWise = true;
									turns = currentCell.turn + 1;
								} else {
									isRowWise = false;
									turns = currentCell.turn;
								}

							}

						}

						if (turns <= 2 && matrix[adjRow][adjCol] != 1) {
							System.out.println(
									"Added:" + adjRow + "," + adjCol + " turns:" + turns + " rowwise : " + isRowWise);
							queue.add(new Cell(adjRow, adjCol, turns, isRowWise, true, currentCell));
							matrix[adjRow][adjCol] = 1;
						} else {
							System.out.println("Excluded:" + adjRow + "," + adjCol);
						}
					}

				}

			}
			isInit = false;

		}
		return null;

	}

}

class Cell {
	int row;
	int column;
	int turn;
	boolean isRowWise;
	boolean isInQueue;
	Cell parent;

	public Cell() {
		super();
	}

	public Cell(int row, int column, int turn, boolean isRowWise, boolean isInQueue, Cell parent) {
		super();
		this.row = row;
		this.column = column;
		this.turn = turn;
		this.isRowWise = isRowWise;
		this.isInQueue = isInQueue;
		this.parent = parent;
	}

	@Override
	public String toString() {
		return "Cell [row=" + row + ", column=" + column + ", turn=" + turn + ", isRowWise=" + isRowWise
				+ ", isInQueue=" + isInQueue + ", parent=" + parent + "]";
	}

}
