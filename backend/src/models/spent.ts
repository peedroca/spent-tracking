export interface CreateSpent {
    category: string;
    status: string;
    description: string;
    amount: number;
}

export interface UpdateSpent {
    idSpent: number;
    category: string;
    status: string;
    description: string;
    amount: number;
}