declare namespace schema {
	interface Deep {
		id: number;
		colString: string;
		colText: string;
		colInteger: number;
		colEnum: 'zero'|'one'|'two';
		colBigint: number;
		colFloat: number;
		colDecimal: number;
		colJson?: Record<string, any>;
		colJsonb?: Record<string, any>;
		colBinary?: string;
		colBoolean?: boolean;
		colDate?: string;
		colDatetime?: string;
		colTimestamp?: string;
		colInet?: string;
		colCidr?: string;
		colMacaddr?: string;
		one?: One;
		two?: Two;
		fours?: Four[];
		threes?: Three[];
		fives?: Five[];
	}

	interface Example {
		id: number;
		colString: string;
		colText: string;
		colInteger: number;
		colEnum: 'zero'|'one'|'two';
		colBigint: number;
		colFloat: number;
		colDecimal: number;
		colJson?: Record<string, any>;
		colJsonb?: Record<string, any>;
		colBinary?: string;
		colBoolean?: boolean;
		colDate?: string;
		colDatetime?: string;
		colTimestamp?: string;
		colInet?: string;
		colCidr?: string;
		colMacaddr?: string;
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

	interface Inherit {
		id: number;
		colString: string;
		colText: string;
		colInteger: number;
		colEnum: 'zero'|'one'|'two';
		colBigint: number;
		colFloat: number;
		colDecimal: number;
		colJson?: Record<string, any>;
		colJsonb?: Record<string, any>;
		colBinary?: string;
		colBoolean?: boolean;
		colDate?: string;
		colDatetime?: string;
		colTimestamp?: string;
		colInet?: string;
		colCidr?: string;
		colMacaddr?: string;
		one?: One;
		two?: Two;
		fours?: Four[];
		threes?: Three[];
		fives?: Five[];
	}

	interface One {
		id: number;
		exampleId: number;
		createdAt: string;
		updatedAt: string;
		example?: Example;
		two?: Two;
	}

	interface Override {
		id: number;
		password?: string;
		omit?: string;
		deep?: string;
		createdAt: string;
		updatedAt: string;
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
