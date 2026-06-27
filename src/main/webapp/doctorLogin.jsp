<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Doctor Login</title>
<script src="https://cdn.tailwindcss.com"></script>
<style>
  body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  }

  .bg-animate {
    animation: float 16s ease-in-out infinite;
  }

  .bg-animate-slow {
    animation: float 20s ease-in-out infinite reverse;
  }

  @keyframes float {
    0%, 100% { transform: translate3d(0, 0, 0) scale(1); }
    50% { transform: translate3d(20px, -20px, 0) scale(1.05); }
  }
</style>
</head>
<body class="min-h-screen bg-slate-950 text-slate-100">
  <div class="relative isolate min-h-screen overflow-hidden">
    <div class="absolute inset-0 bg-[radial-gradient(circle_at_top_left,_rgba(20,184,166,0.24),_transparent_35%),radial-gradient(circle_at_bottom_right,_rgba(99,102,241,0.24),_transparent_35%)]"></div>
    <div class="bg-animate absolute left-0 top-0 h-56 w-56 rounded-full bg-teal-400/25 blur-3xl"></div>
    <div class="bg-animate-slow absolute bottom-0 right-0 h-72 w-72 rounded-full bg-violet-500/20 blur-3xl"></div>

    <div class="relative z-10 flex min-h-screen items-center justify-center px-4 py-10 sm:px-6 lg:px-8">
      <div class="w-full max-w-md overflow-hidden rounded-[2rem] border border-white/10 bg-slate-900/70 p-6 shadow-2xl shadow-teal-500/10 backdrop-blur-xl sm:p-8">
        <div class="mb-8 text-center">
          <div class="mx-auto flex h-14 w-14 items-center justify-center rounded-2xl bg-teal-500/20 text-teal-300">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-7 w-7" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.8" d="M12 4v16m8-8H4" />
            </svg>
          </div>
          <h1 class="mt-4 text-3xl font-semibold text-white">Doctor Login</h1>
          <p class="mt-2 text-sm text-slate-400">Access your medical dashboard securely.</p>
        </div>

        <%
        if(request.getParameter("error")!=null){
        %>
        <div class="mb-4 rounded-2xl border border-rose-400/30 bg-rose-500/10 px-4 py-3 text-sm text-rose-200">
          Invalid Email or Password
        </div>
        <%
        }
        %>

        <form action="DoctorLoginServlet" method="post" class="space-y-4">
          <div>
            <label class="mb-2 block text-sm font-medium text-slate-300" for="email">Email Address</label>
            <input type="email" id="email" name="email" class="w-full rounded-2xl border border-slate-700 bg-slate-800/70 px-4 py-3 text-sm text-white placeholder:text-slate-400 outline-none transition focus:border-teal-400 focus:ring-2 focus:ring-teal-400/30" placeholder="Enter your email" required>
          </div>

          <div>
            <label class="mb-2 block text-sm font-medium text-slate-300" for="password">Password</label>
            <input type="password" id="password" name="password" class="w-full rounded-2xl border border-slate-700 bg-slate-800/70 px-4 py-3 text-sm text-white placeholder:text-slate-400 outline-none transition focus:border-teal-400 focus:ring-2 focus:ring-teal-400/30" placeholder="Enter your password" required>
          </div>

          <button type="submit" class="w-full rounded-2xl bg-gradient-to-r from-teal-500 to-violet-600 px-4 py-3 text-sm font-semibold text-white shadow-lg shadow-teal-500/20 transition hover:opacity-90">
            Sign In
          </button>
        </form>
      </div>
    </div>
  </div>
</body>
</html>
