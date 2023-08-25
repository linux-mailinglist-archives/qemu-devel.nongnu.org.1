Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0E97884D7
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 12:23:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZTy0-00078B-1P; Fri, 25 Aug 2023 06:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qZTxx-00077k-FV
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 06:22:57 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qZTxv-0004lm-0Q
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 06:22:57 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3a741f46fadso527227b6e.0
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 03:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692958974; x=1693563774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bID9qI0h3G1/dqYn59S/QrAa2isHzV5tXKIg0NXmPWU=;
 b=lKRU2MRyfvWIgfR9z8/urSCMjKiCgMbhIHW2vx6FCRO/WwQy22KHbLQlzb4Og+0Nde
 NcVlnN3mMvsSvwpSj6MEUo2gMiUyTcAuU7uAkCT1Jv2eGuLhc7SxTZs77TgKrXS9IHWp
 TL94oDh58Wehb1bh3l+K5t8ctwmwkGxknisjWTNw2t0KYSpg5NyheTHVQWOglwoa8wIV
 842z9QFFugeA+cAa3kLI+DwEtNvlEvy2Y3W8gX4eOLJ4/OjODKyxrWJZaNQ9Me3uxhOC
 /TvDEBVAMYwTQy9yiYfczsCwWrbqkUTz3MQBEqpg20aiKRPviTbXFeBeasKalnL7ZNDO
 H2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692958974; x=1693563774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bID9qI0h3G1/dqYn59S/QrAa2isHzV5tXKIg0NXmPWU=;
 b=NoJ7netvQCfk1cucCtwfn6Oa8NxitX97oD47b2khhfPK42F1Qs6278AopsBbuEn9w7
 jWcNLcbYZn9gurAs2ldb5Dm+GsyCef7vLKmrBRrJysIq0nYAI8rteGzgW5GrPH0QfUX4
 yeKOuLoClv28RG1uhfsJI+4+oVDpwtSt0QWGvGLgCmbQOORVEuHJM/9CljeKnoKdxVQZ
 68ncg5cXMelwrc1OfNynjGY6XxAUKHVgYUx5tP1lhnkJ2MPj+tP0O5y+SBATtjaTB4b+
 J9iQ6gRsOs1olCEjzG/KODUAJb8EGKfCHJnEoDuKOPxzoCn9hC3oXQeL+6p64wF3hgvS
 Xvig==
X-Gm-Message-State: AOJu0YyGN+Pi+jIp0g1LkKFqmzwGT14tnutuwtz8WfhyvKBtUlnP26pZ
 d8m6HRRdyJsQ6/eVHH4e16D95ZtQceVwbQ==
X-Google-Smtp-Source: AGHT+IGbcoD2kAcB0u8Yczp2FTlOTwz3CuaRM4YOv5othW6rSXgOeUTtJX4f1WscX7gRN1YHJuiZ3w==
X-Received: by 2002:a54:4890:0:b0:3a8:1727:5af4 with SMTP id
 r16-20020a544890000000b003a817275af4mr2171239oic.24.1692958973826; 
 Fri, 25 Aug 2023 03:22:53 -0700 (PDT)
Received: from localhost.localdomain ([223.104.40.15])
 by smtp.gmail.com with ESMTPSA id
 c5-20020aa781c5000000b0068a077847c7sm1220954pfn.135.2023.08.25.03.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 03:22:53 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>, Laurent Vivier <laurent@vivier.eu>
Subject: [RFC v5 04/10] linux-user: Implement native-bypass option support
Date: Fri, 25 Aug 2023 18:20:02 +0800
Message-Id: <20230825102009.1754699-5-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825102009.1754699-1-fufuyqqqqqq@gmail.com>
References: <20230825102009.1754699-1-fufuyqqqqqq@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=fufuyqqqqqq@gmail.com; helo=mail-oi1-x234.google.com
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

This commit implements the -native-bypass support in linux-user. The
native_calls_enabled() function can be true only when the
'-native-bypass' option is given.

Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
---
 include/native/native.h |  9 +++++++++
 linux-user/main.c       | 38 ++++++++++++++++++++++++++++++++++++++
 linux-user/syscall.c    | 21 +++++++++++++++++++++
 3 files changed, 68 insertions(+)
 create mode 100644 include/native/native.h

diff --git a/include/native/native.h b/include/native/native.h
new file mode 100644
index 0000000000..7d1baadfcf
--- /dev/null
+++ b/include/native/native.h
@@ -0,0 +1,9 @@
+/*
+ * Check if the native bypass feature is enabled.
+ */
+#if defined(CONFIG_USER_ONLY) && defined(CONFIG_NATIVE_CALL)
+extern char *native_lib_path;
+#define native_bypass_enabled() (native_lib_path != NULL)
+#else
+#define native_bypass_enabled() false
+#endif
diff --git a/linux-user/main.c b/linux-user/main.c
index dba67ffa36..5cf02c071b 100644
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
+    if (access(arg, F_OK) != 0) {
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
 
@@ -834,6 +854,24 @@ int main(int argc, char **argv, char **envp)
         }
     }
 
+#if defined(CONFIG_NATIVE_CALL)
+    /* Set the library for native bypass  */
+    if (native_lib_path) {
+        if (g_file_test(native_lib_path, G_FILE_TEST_IS_REGULAR)) {
+            GString *lib = g_string_new(native_lib_path);
+            lib = g_string_prepend(lib, "LD_PRELOAD=");
+            if (envlist_appendenv(envlist, g_string_free(lib, false), ":")) {
+                fprintf(stderr,
+                    "failed to append the native library to environment.\n");
+                exit(EXIT_FAILURE);
+            }
+        } else {
+            fprintf(stderr, "native library %s does not exist.\n",
+                    native_lib_path);
+            exit(EXIT_FAILURE);
+        }
+    }
+#endif
     target_environ = envlist_to_environ(envlist, NULL);
     envlist_free(envlist);
 
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 08162cc966..bd4c3045ff 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -143,6 +143,7 @@
 #include "fd-trans.h"
 #include "tcg/tcg.h"
 #include "cpu_loop-common.h"
+#include "native/native.h"
 
 #ifndef CLONE_IO
 #define CLONE_IO                0x80000000      /* Clone io context */
@@ -8626,6 +8627,7 @@ static int do_execveat(CPUArchState *cpu_env, int dirfd,
     abi_ulong addr;
     char **q;
     void *p;
+    unsigned int i;
 
     argc = 0;
 
@@ -8696,6 +8698,25 @@ static int do_execveat(CPUArchState *cpu_env, int dirfd,
         goto execve_efault;
     }
 
+    /*
+     * An error may occur when executing execv, stating that the
+     * shared library from LD_PRELOAD cannot be preloaded on a
+     * different arch. So, we find LD_PRELOAD and remove it from
+     * envp before executing the execv.
+     */
+    if (native_bypass_enabled()) {
+        i = 0;
+        while (envp[i] != NULL) {
+            if (strncmp(envp[i], "LD_PRELOAD=", 11) == 0) {
+                for (int j = i; envp[j] != NULL; j++) {
+                    envp[j] = envp[j + 1];
+                }
+            } else {
+                i++;
+            }
+        }
+    }
+
     if (is_proc_myself(p, "exe")) {
         ret = get_errno(safe_execveat(dirfd, exec_path, argp, envp, flags));
     } else {
-- 
2.34.1


