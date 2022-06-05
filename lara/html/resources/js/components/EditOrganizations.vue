<template>
    <div>
        <h3 class="text-center">Edit Organization</h3>
        <div class="row">
            <div class="col-md-6">
                <form @submit.prevent="updateOrganization">
                    <div class="form-group">
                        <label>Name</label>
                        <input type="text" name="name" class="form-control" v-model="organization.name">
                    </div>
                    <button type="submit" class="btn btn-primary">Update</button>
                </form>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                organization: {}
            }
        },
        created() {
            console.log(this.$route.params.id);
            this.axios
                .get(`http://localhost:8000/api/organizations/${this.$route.params.id}`)
                .then((res) => {
                    console.log(res.data);
                    this.organization = res.data;
                });
        },
        methods: {
            updateOrganization() {
                this.axios
                    .patch(`http://localhost:8000/api/organizations/${this.$route.params.id}`, this.organization)
                    .then((res) => {
                        this.$router.push({ name: 'home' });
                    });
            }
        }
    }
</script>
