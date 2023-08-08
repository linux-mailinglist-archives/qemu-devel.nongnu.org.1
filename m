Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4C2773AA9
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 16:20:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTNYW-0001FK-KH; Tue, 08 Aug 2023 10:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qTNYQ-0001Dx-Vo
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 10:19:24 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qTNYN-0000G8-Gy
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 10:19:21 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bc7b25c699so9706935ad.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 07:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691504357; x=1692109157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7x2M2P5Izg3o7S+bwnSV9JjqJW9CHCr4Letv8ueV1xE=;
 b=fbcsjSpFKdrkiXnrm0vbD3hVuw/pRpypL4CPlSAP+zLFJWM9kj1r12j8yosFS30vEL
 j9qF2ZMbOuF2/yd84mvmk2oRvw9d8Q2Zy66elgWK2LpyqLnj9MVjAc4NVqfqDDPcj0ar
 nNkiQDX4S0XwivQv92WApcX8JG/o2OP1TkS9FtOUrd8jMhfqUcD+iwllh+sEKY6tmbqy
 CXxqck6v3ozwmsGz1Nj0xRvz+OmdVaCKJxeaB3iiHApiZudlwMHRHbV8rpGPxH1skxjw
 uhnwBUiEHmgRij96FohZi5M3PzzVZZ7rPHK27ZT4HHb0MfRldUjhql23qKPkjGqLWThH
 Lp4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691504357; x=1692109157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7x2M2P5Izg3o7S+bwnSV9JjqJW9CHCr4Letv8ueV1xE=;
 b=ktXsVHO0b4q7IowrIAxESZWP4ivhBONqD7e4IEbq69ZuhIosIVW2X51kOHzuUBDcNE
 N06XOvlUAvnh7j8CBFWYG+71ASy/GGLwl+p+ztV4l/txcYfvcvmAalhyWjtY8r69ieZG
 gWtRss/7mFCbAnzl4Z0K+mF+pDORFJlxG0V5So0BR5zCKUCMar4gZVbWOEG9yzAhhBDL
 ewHGNsJu3dW3u4x90Or42qL0EF+P2VJmHuwLOzw9Rz6fwxwcoVUKwrI6TEl0lEjFm61u
 rSe0+oZj05QVAENS6uSs1uGy7pTImfqbOxKHIqiIOhkjzhZgPiHfOtK0Iad020D1b3bA
 7csQ==
X-Gm-Message-State: AOJu0Yyi43P4PEhKdMCl2mZSRbzXgK81JcIawEgbbSciCxGQLE8TYhQj
 31TDfrKM4LK37TZULbXQ28Y=
X-Google-Smtp-Source: AGHT+IEmU6jdsLausXl506jEUb1C7pQKszBl3eewT1FLNLxlQODF6MngyFc6gVcrqMFH4LWL0gICdA==
X-Received: by 2002:a17:902:d4c1:b0:1bc:6dd9:82c3 with SMTP id
 o1-20020a170902d4c100b001bc6dd982c3mr6603133plg.37.1691504357067; 
 Tue, 08 Aug 2023 07:19:17 -0700 (PDT)
Received: from localhost.localdomain ([223.104.41.22])
 by smtp.gmail.com with ESMTPSA id
 c3-20020a170902b68300b001bb1f0605b2sm9043985pls.214.2023.08.08.07.19.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 07:19:16 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>, Laurent Vivier <laurent@vivier.eu>
Subject: [RFC v4 04/11] linux-user: Implement native-bypass option support
Date: Tue,  8 Aug 2023 22:17:32 +0800
Message-Id: <20230808141739.3110740-5-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808141739.3110740-1-fufuyqqqqqq@gmail.com>
References: <20230808141739.3110740-1-fufuyqqqqqq@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=fufuyqqqqqq@gmail.com; helo=mail-pl1-x62d.google.com
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
 2 files changed, 47 insertions(+)
 create mode 100644 include/native/native.h

diff --git a/include/native/native.h b/include/native/native.h
new file mode 100644
index 0000000000..62951fafb1
--- /dev/null
+++ b/include/native/native.h
@@ -0,0 +1,9 @@
+/*
+ * Check if the native bypass feature is enabled.
+ */
+#if defined(CONFIG_USER_ONLY) && defined(CONFIG_NATIVE_CALL)
+extern char *native_lib_path;
+#define native_bypass_enabled() native_lib_path ? true : false
+#else
+#define native_bypass_enabled() false
+#endif
diff --git a/linux-user/main.c b/linux-user/main.c
index dba67ffa36..86ea0191f7 100644
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
+    native_lib_path = strdup(arg);
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
+     "",           "native bypass for library calls in user mode only."},
+#endif
     {NULL, NULL, false, NULL, NULL, NULL}
 };
 
@@ -834,6 +854,24 @@ int main(int argc, char **argv, char **envp)
         }
     }
 
+#if defined(CONFIG_NATIVE_CALL)
+    /* Set the library for native bypass  */
+    if (native_lib_path) {
+        if (g_file_test(native_lib_path, G_FILE_TEST_EXISTS)) {
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
 
-- 
2.34.1


