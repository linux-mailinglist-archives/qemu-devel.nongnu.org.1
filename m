Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A887399573D
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Oct 2024 20:55:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syFJf-0007WW-JK; Tue, 08 Oct 2024 14:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syFJR-0007SI-Id
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 14:52:02 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syFJL-0002SG-AI
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 14:52:00 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7db637d1e4eso4423333a12.2
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 11:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728413506; x=1729018306; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ieyGc0lcP2qslY/k/Zc8iH5sBXnxr9bzsD8Ux8bqk8s=;
 b=jXIRCvm0gkX77/oShekf80Q+AJ89BVl8pqpAkoOzx9h+cBwOuTzddiE/8hvJtHnJBT
 d9jDSmxnJdyRBcQb8DM7DKJZbvZs+deBJu5i+Qqy/SLyLt/n2wSuqrkVMqgRQ68VKcJH
 Lq06D75GqJskDeMT1nhiNWRjwLOglCjt0vv1mFBKxroijd02GnhUf+7Cqlm/7kZMIY7v
 SM4Ju4tqFGvLgbBLkcX2ZzMSLA4SYDTew0BphNxsG1W3PrmX0u6tu2xujoDY4uD0u0eu
 v/apMYQHsAplh53/j9/BkNzwLNws0noeYbXKVjT7NLBSig+VrAnIoyjmmjNaSmyA7DIq
 nGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728413506; x=1729018306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ieyGc0lcP2qslY/k/Zc8iH5sBXnxr9bzsD8Ux8bqk8s=;
 b=uFD9luVGLPn58AEXQhjRVYroNwThQwQ6Q3RkdgynKNQ8eQdlNo+n885YKHYSKwaEpv
 knQlFQRLDYIf35NK/qgAC5kRkdHfsIedf/Ljir/WTH8NYSxLxuVoTzdnGxNZ3mzcbdbY
 2siSXaPHhK4QVZkHLF6LVLA8GAfMfbnBVQK8pyXup2zQzlwv0h1qvpwvGi5gMhB6ua1d
 qhZEYyRU0SDrY1LEDk/sl6yZdc9c6Q0aRuZgzst+Fk+fVqXwrnSCk7O6uCDGHUD4P0fM
 I3sREIwQxLdZ6EmBPmX/BjwrH7NLX6UWXyUt57HwGnmbMwSy1+rNTdgb6GqsF09KXgJ/
 h/Xw==
X-Gm-Message-State: AOJu0Yzry8uh9979cwy13D7U8WwnUPBpPmpmuCfdPo4F539Bq0LbKnl3
 PRsi5WBtuQNWdj+wE8NLgN5S01hx79SADEkZjlqj+hSfbL4/co2heHktRA+TPIgHQpBRQ2kWznT
 X
X-Google-Smtp-Source: AGHT+IFNYFJU8dbK3EFFp4CetI0mAYhcX0/xd49fsH06WdT2TPaezJVd36MenSSTE0UROrv8qc7vug==
X-Received: by 2002:a17:902:ec90:b0:20b:c1e4:2d6c with SMTP id
 d9443c01a7336-20bff1d8123mr266668675ad.57.1728413506291; 
 Tue, 08 Oct 2024 11:51:46 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e9f6821c32sm7186818a12.33.2024.10.08.11.51.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 11:51:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Michael Vogt <mvogt@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 03/14] linux-user: add openat2 support in linux-user
Date: Tue,  8 Oct 2024 11:51:30 -0700
Message-ID: <20241008185141.20057-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241008185141.20057-1-richard.henderson@linaro.org>
References: <20241008185141.20057-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Michael Vogt <mvogt@redhat.com>

This commit adds support for the `openat2()` syscall in the
`linux-user` userspace emulator.

It is implemented by extracting a new helper `maybe_do_fake_open()`
out of the exiting `do_guest_openat()` and share that with the
new `do_guest_openat2()`. Unfortunately we cannot just make
do_guest_openat2() a superset of do_guest_openat() because the
openat2() syscall is stricter with the argument checking and
will return an error for invalid flags or mode combinations (which
open()/openat() will ignore).

The implementation is similar to SYSCALL_DEFINE(openat2), i.e.
a new `copy_struct_from_user()` is used that works the same
as the kernels version to support backwards-compatibility
for struct syscall argument.

Instead of including openat2.h we create a copy of `open_how`
as `open_how_ver0` to ensure that if the structure grows we
can log a LOG_UNIMP warning.

Note that in this commit using openat2() for a "faked" file in
/proc will honor the "resolve" flags for
RESOLVE_NO_{MAGIC,SYM}LINKS for path based access to /proc/self/exe
(which is the only magic link we support for faked files).
Note it will not catch special access via e.g. dirfd. This is not
great but it seems similar to the exiting behavior when openat()
is called with a dirfd to "/proc". Here too the fake file lookup
may not catch the special file because no dirfd is used to
determine if the path is in /proc.

Signed-off-by: Michael Vogt <mvogt@redhat.com>
Buglink: https://github.com/osbuild/bootc-image-builder/issues/619
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-ID: <1c2c8c9db3731ed4c6fd9b10c63637c3e4caf8f5.1727795334.git.mvogt@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall_defs.h |  13 +++++
 linux-user/syscall.c      | 105 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 116 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index e08d088740..de5091c977 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2748,4 +2748,17 @@ struct target_sched_param {
     abi_int sched_priority;
 };
 
+/* from kernel's include/uapi/linux/openat2.h */
+struct target_open_how_ver0 {
+    abi_ullong flags;
+    abi_ullong mode;
+    abi_ullong resolve;
+};
+#ifndef RESOLVE_NO_MAGICLINKS
+#define RESOLVE_NO_MAGICLINKS   0x02
+#endif
+#ifndef RESOLVE_NO_SYMLINKS
+#define RESOLVE_NO_SYMLINKS     0x04
+#endif
+
 #endif
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index a666986189..2febc3bc3f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -602,6 +602,34 @@ static int check_zeroed_user(abi_long addr, size_t ksize, size_t usize)
     return 1;
 }
 
+/*
+ * Copies a target struct to a host struct, in a way that guarantees
+ * backwards-compatibility for struct syscall arguments.
+ *
+ * Similar to kernels uaccess.h:copy_struct_from_user()
+ */
+static int
+copy_struct_from_user(void *dst, size_t ksize, abi_ptr src, size_t usize)
+{
+    size_t size = MIN(ksize, usize);
+    size_t rest = MAX(ksize, usize) - size;
+
+    /* Deal with trailing bytes. */
+    if (usize < ksize) {
+        memset(dst + size, 0, rest);
+    } else if (usize > ksize) {
+        int ret = check_zeroed_user(src, ksize, usize);
+        if (ret <= 0) {
+            return ret ?: -TARGET_E2BIG;
+        }
+    }
+    /* Copy the interoperable parts of the struct. */
+    if (copy_from_user(dst, src, size)) {
+        return -TARGET_EFAULT;
+    }
+    return 0;
+}
+
 #define safe_syscall0(type, name) \
 static type safe_##name(void) \
 { \
@@ -653,6 +681,15 @@ safe_syscall3(ssize_t, read, int, fd, void *, buff, size_t, count)
 safe_syscall3(ssize_t, write, int, fd, const void *, buff, size_t, count)
 safe_syscall4(int, openat, int, dirfd, const char *, pathname, \
               int, flags, mode_t, mode)
+
+struct open_how_ver0 {
+    __u64 flags;
+    __u64 mode;
+    __u64 resolve;
+};
+safe_syscall4(int, openat2, int, dirfd, const char *, pathname, \
+              const struct open_how_ver0 *, how, size_t, size)
+
 #if defined(TARGET_NR_wait4) || defined(TARGET_NR_waitpid)
 safe_syscall4(pid_t, wait4, pid_t, pid, int *, status, int, options, \
               struct rusage *, rusage)
@@ -8332,8 +8369,9 @@ static int open_net_route(CPUArchState *cpu_env, int fd)
 }
 #endif
 
-int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
-                    int flags, mode_t mode, bool safe)
+static int maybe_do_fake_open(CPUArchState *cpu_env, int dirfd,
+                              const char *fname, int flags, mode_t mode,
+                              int openat2_resolve, bool safe)
 {
     g_autofree char *proc_name = NULL;
     const char *pathname;
@@ -8370,6 +8408,12 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
     }
 
     if (is_proc_myself(pathname, "exe")) {
+        /* Honor openat2 resolve flags */
+        if ((openat2_resolve & RESOLVE_NO_MAGICLINKS) ||
+            (openat2_resolve & RESOLVE_NO_SYMLINKS)) {
+            errno = ELOOP;
+            return -1;
+        }
         if (safe) {
             return safe_openat(dirfd, exec_path, flags, mode);
         } else {
@@ -8416,6 +8460,17 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
         return fd;
     }
 
+    return -2;
+}
+
+int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *pathname,
+                    int flags, mode_t mode, bool safe)
+{
+    int fd = maybe_do_fake_open(cpu_env, dirfd, pathname, flags, mode, 0, safe);
+    if (fd > -2) {
+        return fd;
+    }
+
     if (safe) {
         return safe_openat(dirfd, path(pathname), flags, mode);
     } else {
@@ -8423,6 +8478,49 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
     }
 }
 
+
+static int do_openat2(CPUArchState *cpu_env, abi_long dirfd,
+                      abi_ptr guest_pathname, abi_ptr guest_open_how,
+                      abi_ulong guest_size)
+{
+    struct open_how_ver0 how = {0};
+    char *pathname;
+    int ret;
+
+    if (guest_size < sizeof(struct target_open_how_ver0)) {
+        return -TARGET_EINVAL;
+    }
+    ret = copy_struct_from_user(&how, sizeof(how), guest_open_how, guest_size);
+    if (ret) {
+        if (ret == -TARGET_E2BIG) {
+            qemu_log_mask(LOG_UNIMP,
+                          "Unimplemented openat2 open_how size: "
+                          TARGET_ABI_FMT_lu "\n", guest_size);
+        }
+        return ret;
+    }
+    pathname = lock_user_string(guest_pathname);
+    if (!pathname) {
+        return -TARGET_EFAULT;
+    }
+
+    how.flags = target_to_host_bitmask(tswap64(how.flags), fcntl_flags_tbl);
+    how.mode = tswap64(how.mode);
+    how.resolve = tswap64(how.resolve);
+    int fd = maybe_do_fake_open(cpu_env, dirfd, pathname, how.flags, how.mode,
+                                how.resolve, true);
+    if (fd > -2) {
+        ret = get_errno(fd);
+    } else {
+        ret = get_errno(safe_openat2(dirfd, pathname, &how,
+                                     sizeof(struct open_how_ver0)));
+    }
+
+    fd_trans_unregister(ret);
+    unlock_user(pathname, guest_pathname, 0);
+    return ret;
+}
+
 ssize_t do_guest_readlink(const char *pathname, char *buf, size_t bufsiz)
 {
     ssize_t ret;
@@ -9195,6 +9293,9 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         fd_trans_unregister(ret);
         unlock_user(p, arg2, 0);
         return ret;
+    case TARGET_NR_openat2:
+        ret = do_openat2(cpu_env, arg1, arg2, arg3, arg4);
+        return ret;
 #if defined(TARGET_NR_name_to_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
     case TARGET_NR_name_to_handle_at:
         ret = do_name_to_handle_at(arg1, arg2, arg3, arg4, arg5);
-- 
2.43.0


