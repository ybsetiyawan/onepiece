import Vue from 'vue'
import VueRouter from 'vue-router'
import HomeView from '../views/HomeView.vue'
import LoginView from '../components/LoginView.vue'
import BranchV  from '../components/master/BranchV.vue'
import UserV  from '../components/master/UserV.vue'
import UnitV from '../components/master/UnitV.vue'
import ItemTypeV from '../components/master/ItemTypeV.vue'
import ItemV from '../components/master/ItemV.vue'
import SalesV from '../components/transactions/SalesV.vue'
import store from '../store'
import ItemBranchV from '@/components/master/ItemBranchV.vue'
import SalesReport from '@/components/report/SalesReport.vue'
Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'home',
    component: HomeView
  },
  {
    path: '/about',
    name: 'about',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "about" */ '../views/AboutView.vue')
  },
  {
    path: '/login',
    name: 'login',
    component: LoginView
  },
  {
    path: '/branch',
    name: 'branch',
    component: BranchV
  },
  {
    path: '/user',
    name: 'user',
    component: UserV
  },
  {
    path: '/unit',
    name: 'unit',
    component: UnitV
  },
  {
    path: '/itemtype',
    name: 'itemtype',
    component: ItemTypeV
  
  },
  {
    path: '/item',
    name: 'item',
    component: ItemV
  
  },
  {
    path: '/itembranch',
    name: 'item branch',
    component: ItemBranchV
  
  },
  {
    path: '/sales',
    name: 'sales',
    component: SalesV
  },
  {
    path: '/reportsales',
    name: 'reportsales',
    component: SalesReport
  }
  
  
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

router.beforeEach((to, from, next) => {
  const loggedInUser = store.getters.isLoggedIn;
  // console.log('loggedInUser', loggedInUser);
  if (!loggedInUser && to.path !== '/login') {
    next({
      path: '/login',
      query: { redirect: to.fullPath }
    });
  } else {
    next();
  }
});

export default router
