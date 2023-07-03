Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FB3745DE3
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:53:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGJzj-0000WK-7Y; Mon, 03 Jul 2023 09:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJzf-0000TL-S7
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:53:31 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJze-00081W-0u
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:53:31 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fbc12181b6so49761855e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 06:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688392408; x=1690984408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/yGVpWL1h/+IqCMQOCfJngBlrYt5BXqNJvwRRIuY57g=;
 b=n49eFMd4wsoc4kdl/Wv9g3JnFvKxwkDXKgxRn+RQGOjKKSlYIJaWZAE3Y/6E+IOoTJ
 /xAHwQeUaN7jur6IhG/cz7u2rA1QWEpDtvntwRi3HFQpQfstpI6xhqGRNYnODmabLBrC
 WM4Pz817eEUpcfJW21y0gek6I3Zo3qoU3SbpEo4TQB+X4Xd2qHVECtpdxUZwhhTu9yPe
 LNmvFSZjsv0bsY/BxpGrZIc0LkYtFIFJh8eXVJgJzfXjzD5fE6S5QGyPtAOoiM1DMQMz
 bWp5eSIXSJieOhwnJfGuW8w4VNC2pPWXpBdL3eXE+w+rFU0SUuNN0yg+4ZN060M19p4w
 mQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688392408; x=1690984408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/yGVpWL1h/+IqCMQOCfJngBlrYt5BXqNJvwRRIuY57g=;
 b=XWtn42bryM1FGPAfA36ETTjlbQkFH6kJL8bYdfPWO4TBLKq82nMw9EfqZuZrnuaKGt
 ksdJ3AWK6D58InkWOubV6AY8RlQ4IRKZRQcBYxj8q/KoQXTM/uKIwd65QpmJMZgqixiO
 3rWvFfyFZsbas4pPFZhuHtPZXl97W6RvDGq3ZtIyUp0AqToIP1/hYzPkIkDEogcR0gFF
 IgIwL++Uy2QahGmxH4g/VSgYwW1Do542CY7LQX+wkOVzL0CUPkY2oLY3RW/baxBOXAJu
 wkvEF2ust/PJHTWXCs7pQONTLll2iVpRSMdk99hRbYIMYCyjL9Cpl102k90FOdyopYNG
 g3YA==
X-Gm-Message-State: ABy/qLY7p2K0TKrRcvDlKp5V6pUv6facHAwTdPgP1wY4aHTSur8ZkKa3
 8HYlRZUGRlcs3QEXMV2RdWdbA8pfoUdcZJVQqrc=
X-Google-Smtp-Source: APBJJlErF4QONpj/AUEwtYU+APXkcecdUaiOabb1TD0g9DibYLlYAnhHQfbDviNYz2+EVuJ5iHlR3A==
X-Received: by 2002:a05:6000:545:b0:30e:3caa:971b with SMTP id
 b5-20020a056000054500b0030e3caa971bmr8957115wrf.51.1688392408096; 
 Mon, 03 Jul 2023 06:53:28 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 cw8-20020a056000090800b00311d8c2561bsm25559859wrb.60.2023.07.03.06.53.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 06:53:27 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6388B1FFD4;
 Mon,  3 Jul 2023 14:44:31 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 31/38] linux-user: Expose do_guest_openat() and
 do_guest_readlink()
Date: Mon,  3 Jul 2023 14:44:20 +0100
Message-Id: <20230703134427.1389440-32-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230703134427.1389440-1-alex.bennee@linaro.org>
References: <20230703134427.1389440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

These functions will be required by the GDB stub in order to provide
the guest view of /proc to GDB.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230621203627.1808446-2-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230630180423.558337-32-alex.bennee@linaro.org>

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 92f9f5af41..a5830ec239 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -165,6 +165,9 @@ typedef struct TaskState {
 } TaskState;
 
 abi_long do_brk(abi_ulong new_brk);
+int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *pathname,
+                    int flags, mode_t mode);
+ssize_t do_guest_readlink(const char *pathname, char *buf, size_t bufsiz);
 
 /* user access */
 
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f2cb101d83..fa83737192 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8448,7 +8448,8 @@ static int open_hardware(CPUArchState *cpu_env, int fd)
 }
 #endif
 
-static int do_openat(CPUArchState *cpu_env, int dirfd, const char *pathname, int flags, mode_t mode)
+int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *pathname,
+                    int flags, mode_t mode)
 {
     struct fake_open {
         const char *filename;
@@ -8520,6 +8521,36 @@ static int do_openat(CPUArchState *cpu_env, int dirfd, const char *pathname, int
     return safe_openat(dirfd, path(pathname), flags, mode);
 }
 
+ssize_t do_guest_readlink(const char *pathname, char *buf, size_t bufsiz)
+{
+    ssize_t ret;
+
+    if (!pathname || !buf) {
+        errno = EFAULT;
+        return -1;
+    }
+
+    if (!bufsiz) {
+        /* Short circuit this for the magic exe check. */
+        errno = EINVAL;
+        return -1;
+    }
+
+    if (is_proc_myself((const char *)pathname, "exe")) {
+        /*
+         * Don't worry about sign mismatch as earlier mapping
+         * logic would have thrown a bad address error.
+         */
+        ret = MIN(strlen(exec_path), bufsiz);
+        /* We cannot NUL terminate the string. */
+        memcpy(buf, exec_path, ret);
+    } else {
+        ret = readlink(path(pathname), buf, bufsiz);
+    }
+
+    return ret;
+}
+
 static int do_execveat(CPUArchState *cpu_env, int dirfd,
                        abi_long pathname, abi_long guest_argp,
                        abi_long guest_envp, int flags)
@@ -8994,7 +9025,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
     case TARGET_NR_open:
         if (!(p = lock_user_string(arg1)))
             return -TARGET_EFAULT;
-        ret = get_errno(do_openat(cpu_env, AT_FDCWD, p,
+        ret = get_errno(do_guest_openat(cpu_env, AT_FDCWD, p,
                                   target_to_host_bitmask(arg2, fcntl_flags_tbl),
                                   arg3));
         fd_trans_unregister(ret);
@@ -9004,7 +9035,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
     case TARGET_NR_openat:
         if (!(p = lock_user_string(arg2)))
             return -TARGET_EFAULT;
-        ret = get_errno(do_openat(cpu_env, arg1, p,
+        ret = get_errno(do_guest_openat(cpu_env, arg1, p,
                                   target_to_host_bitmask(arg3, fcntl_flags_tbl),
                                   arg4));
         fd_trans_unregister(ret);
@@ -10229,22 +10260,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
             void *p2;
             p = lock_user_string(arg1);
             p2 = lock_user(VERIFY_WRITE, arg2, arg3, 0);
-            if (!p || !p2) {
-                ret = -TARGET_EFAULT;
-            } else if (!arg3) {
-                /* Short circuit this for the magic exe check. */
-                ret = -TARGET_EINVAL;
-            } else if (is_proc_myself((const char *)p, "exe")) {
-                /*
-                 * Don't worry about sign mismatch as earlier mapping
-                 * logic would have thrown a bad address error.
-                 */
-                ret = MIN(strlen(exec_path), arg3);
-                /* We cannot NUL terminate the string. */
-                memcpy(p2, exec_path, ret);
-            } else {
-                ret = get_errno(readlink(path(p), p2, arg3));
-            }
+            ret = get_errno(do_guest_readlink(p, p2, arg3));
             unlock_user(p2, arg2, ret);
             unlock_user(p, arg1, 0);
         }
-- 
2.39.2


