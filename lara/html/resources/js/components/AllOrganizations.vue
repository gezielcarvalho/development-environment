<template>
    <div>
        <h2 class="text-center">Organizations List</h2>
        <router-link :to="{name: 'create'}" class="btn btn-success">Create</router-link>
        <table class="table">
            <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <tr v-for="organization in organizations" :key="organization.id">
                <td>{{ organization.id }}</td>
                <td>{{ organization.name }}</td>
                <td>
                    <div class="btn-group" role="group">
                        <router-link :to="{name: 'edit', params: { id: organization.id }}" class="btn btn-success">Edit</router-link>
                        <button class="btn btn-danger" @click="deleteOrganization(organization.id)">Delete</button>
                    </div>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                organizations: []
            }
        },
        created() {
            this.axios
                .get('http://localhost:8000/api/organizations/')
                .then(response => {
                    console.log("inside created");
                    this.organizations = response.data;
                });
        },
        methods: {
            deleteOrganization(id) {
                this.axios
                    .delete(`http://localhost:8000/api/organizations/${id}`)
                    .then(response => {
                        let i = this.organizations.map(data => data.id).indexOf(id);
                        this.organizations.splice(i, 1)
                    });
            }
        }
    }
</script>
