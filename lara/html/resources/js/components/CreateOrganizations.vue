<template>
    <div>
        <h3 class="text-center">Create Organization</h3>
        <div class="row">
            <div class="col-md-6">
                <form @submit.prevent="addOrganization">
                    <div class="form-group">
                        <label>Name</label>
                        <input type="text" name="name" class="form-control" v-model="organization.name">
                    </div>
                    <button type="submit" class="btn btn-primary">Create</button>
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
        methods: {
            addOrganization() {
                this.axios
                    .post('http://localhost:8000/api/organizations', this.organization)
                    .then(response => (
                        this.$router.push({ name: 'home' })
                    ))
                    .catch(err => console.log(err))
                    .finally(() => this.loading = false)
            }
        }
    }
</script>
