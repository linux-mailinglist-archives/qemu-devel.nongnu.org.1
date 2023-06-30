Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AF97441F0
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 20:15:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFIdD-0005uS-Nf; Fri, 30 Jun 2023 14:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qFIco-0005b5-K9
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:13:47 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qFIci-0003Yu-Sm
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:13:41 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fbc244d3a8so16980445e9.2
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 11:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688148815; x=1690740815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eCS1WP/4CzEo+1xOyZvf30/WwlM8X9DNuki85IAdOWI=;
 b=Xy6k6gp6X142Qw/n69wK7eYUqHoFX1HR8YZmYN/71bNAjKsJ/4QHSR9j63Fm2eeGl7
 3JPZy+avHNgPqFAWwCUqjcfH731JIxleq5duRSlPtoAyi+hK0g6EsMFIGbQd5/0vS3/7
 98D/A/1uD5qAfStaAdTh28BtTqb0yBaI0qKyeVBGJAJ7OrN7bCQkhqnNOCmjlrmdAvfQ
 vTMHtkW/OhtPjhtvCRqzja6K2TmDhLrj0+fR9W+3F7IyFcBBZcuNLTXRYU0DzUBqf5zd
 nSBds3gSTkyU1coi145RQe4CM8TlVSmERk5sNAMWoM3FdI8VbiaJkjctsJuvRumtThpk
 5GdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688148815; x=1690740815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eCS1WP/4CzEo+1xOyZvf30/WwlM8X9DNuki85IAdOWI=;
 b=ZoV8wg3gcU17SXOXe/90OJwewvz0/kzWbcAsAf/zj9xVkJbNxAOrKscrs9ypDg7ZU6
 s/370xlyq6jl9HImS4j4TbwhpmzS5H5h+2cPrXUb50NdPZEIr0MtOnGuJkJ+9LCFxyre
 X1O6cUv9uvEDCNjzCW7p5zs34Vzdbbpdb2I5OwEtrKHaatOdo52rMO75HPglFSlI7LlR
 9RY/DzKlyWg1zrvS3L0lLco9psldUTDlta7p5+odYexMsYG4PxAAKG7Y0S9eTsQcotI3
 uB5Fcu9dl9oOGvtsWNFFyOYUDuswWIJIrmm2oAoRIXYcVk8p2zOKyENam6jC8nzT8F/k
 tJqQ==
X-Gm-Message-State: AC+VfDwqq68eXLreEiPujd8v8HDEmCvi9OBa8KbmoExV8BEXN7qmL6nI
 guDYXefe9U0pfdjbhhO0Zre1lw==
X-Google-Smtp-Source: ACHHUZ71wt6iLItu+9HKUkS6QbcIkQADIdXUBp7xkdOy4xEOjpRxNexFhabZP+AW9Uulv1sDBbeeTg==
X-Received: by 2002:a7b:c409:0:b0:3fb:41b5:52eb with SMTP id
 k9-20020a7bc409000000b003fb41b552ebmr2561476wmi.26.1688148815185; 
 Fri, 30 Jun 2023 11:13:35 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 c5-20020a5d4145000000b00314145e6d61sm4959242wrq.6.2023.06.30.11.13.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 11:13:33 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 849EF1FFD6;
 Fri, 30 Jun 2023 19:04:27 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Riku Voipio <riku.voipio@iki.fi>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Bandan Das <bsd@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-arm@nongnu.org,
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v4 31/38] linux-user: Expose do_guest_openat() and
 do_guest_readlink()
Date: Fri, 30 Jun 2023 19:04:16 +0100
Message-Id: <20230630180423.558337-32-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230630180423.558337-1-alex.bennee@linaro.org>
References: <20230630180423.558337-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
---
 linux-user/qemu.h    |  3 +++
 linux-user/syscall.c | 54 ++++++++++++++++++++++++++++----------------
 2 files changed, 38 insertions(+), 19 deletions(-)

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


