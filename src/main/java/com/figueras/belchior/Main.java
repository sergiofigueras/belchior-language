package com.figueras.belchior;

import java.io.IOException;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;

public class Main {

	public static void main(String[] args) throws IOException {
		// create a CharStream that reads from standard input:
		CharStream input = CharStreams.fromFileName(args[0]);
		// create a lexer that feeds off of input CharStream:
		BelchiorLexer lexer = new BelchiorLexer(input);
		// create a buffer of tokens pulled from the lexer:
		CommonTokenStream tokens = new CommonTokenStream(lexer);
		// create a parser that feeds off the tokens buffer:
		BelchiorParser parser = new BelchiorParser(tokens);
		ParseTree tree = parser.start(); // begin parsing at start rule
		// print LISP-style tree:
		System.out.println(tree.toStringTree(parser));
	}

}
