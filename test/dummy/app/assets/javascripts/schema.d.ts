declare namespace schema {
	interface Example {
		id: number;
		colString: string;
		colText: string;
		colInteger: number;
		colEnum: 'zero' | 'one' | 'two';
		colBigint: number;
		colFloat: number;
		colDecimal: number;
		colJson?: Record<string, any> | null;
		colJsonb?: Record<string, any> | null;
		colBinary?: string | null;
		colBoolean?: boolean | null;
		colDate?: string | null;
		colDatetime?: string | null;
		colTimestamp?: string | null;
		colInet?: string | null;
		colCidr?: string | null;
		colMacaddr?: string | null;
		one?: One;
		two?: Two;
		fours?: Four[];
		threes?: Three[];
		fives?: Five[];
	}

	interface Five {
		id: number;
		createdAt: string;
		updatedAt: string;
		examples?: Example[];
	}

	interface Four {
		id: number;
		exampleId: number;
		threeId: number;
		createdAt: string;
		updatedAt: string;
		example?: Example;
		three?: Three;
	}

	interface One {
		id: number;
		exampleId: number;
		createdAt: string;
		updatedAt: string;
		example?: Example;
		two?: Two;
	}

	interface Three {
		id: number;
		createdAt: string;
		updatedAt: string;
		fours?: Four[];
		examples?: Example[];
	}

	interface Two {
		id: number;
		exampleId: number;
		createdAt: string;
		updatedAt: string;
		example?: Example;
	}


}
