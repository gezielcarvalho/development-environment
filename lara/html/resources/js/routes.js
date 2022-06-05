
import AllOrganizations from './components/AllOrganizations.vue';
import CreateOrganizations from './components/CreateOrganizations.vue';
import EditOrganizations from './components/EditOrganizations.vue';

export const routes = [
    {
        name: 'home',
        path: '/',
        component: AllOrganizations
    },
    {
        name: 'create',
        path: '/create',
        component: CreateOrganizations
    },
    {
        name: 'edit',
        path: '/edit/:id',
        component: EditOrganizations
    }
];
