import type { Person } from "../interfaces/person.interface";
import api from "./api";

export const GetPersons = (searchTerm?: string) => {
  const searchParam = searchTerm
    ? `?search=${encodeURIComponent(searchTerm)}`
    : "";
  return api.get<Person[]>(`/people${searchParam}`);
};
