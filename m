Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA1779DAEE
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 23:30:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgAwe-0000KK-Ef; Tue, 12 Sep 2023 17:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qgAwa-0000IK-Mo
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 17:29:12 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qgAwY-0007UC-8F
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 17:29:12 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-68fac346f6aso2976191b3a.3
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 14:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694554149; x=1695158949; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zzF82Li+3BaSw18Hc0Zjslvm+ZS4IHMgCBVxHce2BXw=;
 b=jhZExz3zfShZwzcnpLQbg4sHoiI6YSFKhe0xEzxLvhN5Xt50LNIiHMw0w+B3b6mrAH
 EDLkB28p4yYP6qWDMMo9HdslgkuLLzkkuOgD6JZcJbef+lr8FFNSEWQlQdVzgRZyWerP
 28hZAFie1mAmBsDpJc7TzB4vIfRMgxAl28g6i4YNdxP0kE2ys4tbTJLbXOQqlhVNtkf0
 QBJ9J65akBp1K93PjLAAOa3DXtGfTY46jDio+1RIQaYUWAYMOVFCtf97TNpk0s4FKi4+
 GT7oJE6HePVWJa9BBaqg6Rvy1dHNtyKc83kOS4f+T6fCvFMolAIHtSKRBCp//XMqIEKA
 kXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694554149; x=1695158949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zzF82Li+3BaSw18Hc0Zjslvm+ZS4IHMgCBVxHce2BXw=;
 b=eHsUBsy9kHrDM7l4XDSlbciz+eMYmd6FmINMpgu3k0+gaQO++q9WH1AilKzmzbZZOF
 awWl8CDwUA/6j3I4Dn/HxrTlM7SJIGfaCZKVdMNhVZt5i/5OyCVt5Jnl4fwXfVvA6n+p
 FaUsSFz26tlyFv8Z2QPhXaN6nFfdxddxQ8jSR47VmoPv2v9oVdVYgH8cGMuqhB+NeF/U
 8X2nq4F1twinjJL50ge6U1GRoasVpOq1QpFy2YZgrftxFXMdlxQkwLyOkoarSZVkssLq
 8pUuIC2Qx9g45WIlNkbdI9y1Erto352MXGcrflzrsQ3bAcngdDVnCKFIaShybSp30ZqH
 yf2w==
X-Gm-Message-State: AOJu0YysalMZUqOBuuLtevZcOyuPkqRGajizgyXoar4MrLkPkHb4sdtP
 5A0HjOl6BlwHnKXHeoKzT3g=
X-Google-Smtp-Source: AGHT+IHiqsP37Tw90wiNrfDB8QoEnz/Qmk8PE9lSYWbHEk0FbEBWpyEH6gAJDkKdj35h+5Y8LuCR7Q==
X-Received: by 2002:a05:6a20:12d6:b0:152:efa4:21b with SMTP id
 v22-20020a056a2012d600b00152efa4021bmr843732pzg.5.1694554148942; 
 Tue, 12 Sep 2023 14:29:08 -0700 (PDT)
Received: from q1iq-virtual-machine.. ([114.249.236.97])
 by smtp.gmail.com with ESMTPSA id
 u20-20020aa78394000000b0068be4ce33easm7930436pfm.96.2023.09.12.14.29.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 14:29:08 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>, Laurent Vivier <laurent@vivier.eu>
Subject: [RFC v6 3/9] linux-user: Implement native-bypass option support
Date: Wed, 13 Sep 2023 05:28:36 +0800
Message-Id: <20230912212842.658374-4-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912212842.658374-1-fufuyqqqqqq@gmail.com>
References: <20230912212842.658374-1-fufuyqqqqqq@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=fufuyqqqqqq@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This commit implements support for the native-bypass option
in linux-user. By utilizing this functionality, the specified
shared library can be loaded into the user program. This is
achieved by dynamically modifying the /etc/ld.so.preload file,
enabling the user program to load the shared library effortlessly.

Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
---
 include/native/native.h |  7 ++++++
 linux-user/main.c       | 20 +++++++++++++++
 linux-user/syscall.c    | 55 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+)
 create mode 100644 include/native/native.h

diff --git a/include/native/native.h b/include/native/native.h
new file mode 100644
index 0000000000..12462a261e
--- /dev/null
+++ b/include/native/native.h
@@ -0,0 +1,7 @@
+#if defined(CONFIG_USER_ONLY) && defined(CONFIG_NATIVE_CALL)
+extern char *native_lib_path;
+/* Check if the native-bypass option is enabled. */
+#define native_bypass_enabled() (native_lib_path != NULL)
+#else
+#define native_bypass_enabled() false
+#endif
diff --git a/linux-user/main.c b/linux-user/main.c
index dba67ffa36..4c1d515944 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -60,6 +60,11 @@
 #include "semihosting/semihost.h"
 #endif
 
+#if defined(CONFIG_NATIVE_CALL)
+#include "native/native.h"
+char *native_lib_path;
+#endif
+
 #ifndef AT_FLAGS_PRESERVE_ARGV0
 #define AT_FLAGS_PRESERVE_ARGV0_BIT 0
 #define AT_FLAGS_PRESERVE_ARGV0 (1 << AT_FLAGS_PRESERVE_ARGV0_BIT)
@@ -293,6 +298,17 @@ static void handle_arg_set_env(const char *arg)
     free(r);
 }
 
+#if defined(CONFIG_NATIVE_CALL)
+static void handle_arg_native_bypass(const char *arg)
+{
+    if (!g_file_test(arg, G_FILE_TEST_IS_REGULAR)) {
+        fprintf(stderr, "native library %s does not exist\n", arg);
+        exit(EXIT_FAILURE);
+    }
+    native_lib_path = g_strdup(arg);
+}
+#endif
+
 static void handle_arg_unset_env(const char *arg)
 {
     char *r, *p, *token;
@@ -522,6 +538,10 @@ static const struct qemu_argument arg_table[] = {
      "",           "Generate a /tmp/perf-${pid}.map file for perf"},
     {"jitdump",    "QEMU_JITDUMP",     false, handle_arg_jitdump,
      "",           "Generate a jit-${pid}.dump file for perf"},
+#if defined(CONFIG_NATIVE_CALL)
+    {"native-bypass", "QEMU_NATIVE_BYPASS", true, handle_arg_native_bypass,
+     "",           "native bypass for library calls"},
+#endif
     {NULL, NULL, false, NULL, NULL, NULL}
 };
 
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 08162cc966..7034f58373 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -143,6 +143,7 @@
 #include "fd-trans.h"
 #include "tcg/tcg.h"
 #include "cpu_loop-common.h"
+#include "native/native.h"
 
 #ifndef CLONE_IO
 #define CLONE_IO                0x80000000      /* Clone io context */
@@ -8503,6 +8504,40 @@ static int open_hardware(CPUArchState *cpu_env, int fd)
 }
 #endif
 
+#if defined(CONFIG_NATIVE_CALL)
+static int is_ld_so_preload(const char *filename, const char *entry)
+{
+    if (native_bypass_enabled() && !strcmp(filename, entry)) {
+        return 1;
+    }
+    return 0;
+}
+
+/* This function is only called when the "native-bypass" option is provided. */
+static int open_ld_so_preload(CPUArchState *cpu_env, int fd)
+{
+    FILE *fp;
+    char *line = NULL;
+    size_t len = 0;
+    ssize_t read;
+
+    dprintf(fd, "%s\n", native_lib_path);
+    fp = fopen("/etc/ld.so.preload", "r");
+    if (fp == NULL) {
+        return 0;
+    }
+
+    while ((read = getline(&line, &len, fp)) != -1) {
+        dprintf(fd, "%s", line);
+    }
+
+    free(line);
+    fclose(fp);
+
+    return 0;
+}
+#endif
+
 int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *pathname,
                     int flags, mode_t mode, bool safe)
 {
@@ -8527,6 +8562,9 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *pathname,
 #endif
 #if defined(TARGET_M68K)
         { "/proc/hardware", open_hardware, is_proc },
+#endif
+#if defined(CONFIG_NATIVE_CALL)
+        { "/etc/ld.so.preload", open_ld_so_preload, is_ld_so_preload },
 #endif
         { NULL, NULL, NULL }
     };
@@ -9523,6 +9561,11 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
             return -TARGET_EFAULT;
         }
         ret = get_errno(access(path(p), arg2));
+        if (ret != 0 && native_bypass_enabled()) {
+            if (strcmp(p, "/etc/ld.so.preload") == 0 && arg2 == R_OK) {
+                return 0;
+            }
+        }
         unlock_user(p, arg1, 0);
         return ret;
 #endif
@@ -9532,6 +9575,12 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
             return -TARGET_EFAULT;
         }
         ret = get_errno(faccessat(arg1, p, arg3, 0));
+        if (ret != 0 && native_bypass_enabled()) {
+            if (strcmp(p, "/etc/ld.so.preload") == 0 && arg1 == AT_FDCWD &&
+                arg3 == R_OK) {
+                return 0;
+            }
+        }
         unlock_user(p, arg2, 0);
         return ret;
 #endif
@@ -9541,6 +9590,12 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
             return -TARGET_EFAULT;
         }
         ret = get_errno(faccessat(arg1, p, arg3, arg4));
+        if (ret != 0 && native_bypass_enabled()) {
+            if (strcmp(p, "/etc/ld.so.preload") == 0 && arg1 == AT_FDCWD &&
+                arg3 == R_OK) {
+                return 0;
+            }
+        }
         unlock_user(p, arg2, 0);
         return ret;
 #endif
-- 
2.34.1


