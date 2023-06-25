Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE5573D485
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 23:28:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDXGg-0005Xb-AX; Sun, 25 Jun 2023 17:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qDXGe-0005XS-Mu
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 17:27:32 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qDXGd-0003TN-39
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 17:27:32 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1b7f223994fso9910195ad.3
 for <qemu-devel@nongnu.org>; Sun, 25 Jun 2023 14:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687728450; x=1690320450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=woKauxxnRk032i0YAZuB3emU7zROXu8ro6a8hM18j5o=;
 b=W7BMKYkygNUIgxVdkALyUDChWylTA2HSNwkw/Ne6r1uPqc+aBcAYBaFZC/4MAi/pZ7
 lD15tySLYLsfafVnYsCDdXbKkUzsOrOEVCIMoHwUKDW/saaT9j1EnWU0KqUT0lavNFQo
 quorygBy14C3KUQdObkRT+LEFHeTA+whZ0TX/psKPqdGqNEY4oHxyy9GniHfa3NPs69f
 coTY5/bOT7pGzcYumWq3dlGK/Dms8dgmel+FLoK+cBLFoap0Ff0Aq0+skenco5bcp+D4
 4QzVqV9BQaJH+23s8A4+JkPOHZra+hkMpfsEnxhfR0POwqClIQAin/x9KOj6HpymNnko
 n8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687728450; x=1690320450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=woKauxxnRk032i0YAZuB3emU7zROXu8ro6a8hM18j5o=;
 b=LGq05u7UKFdhWbvRcZuu8JK++jO2yVogs8mYaULW43cCfAjTg6/K51WzoSu48fauK3
 WOHXxHm+05oLKAd9j3FDZ6pVyQyujSIo8IiTjsBRBLvzCWpsR5ciZNDXXskahrmJZtX+
 KvrSWMwBT3n0Ss7fuEC4ZAbKoYHCfH9BtG5P2eVMbn0ja7/tzeZoXp3q/6lFOHdlNCt6
 t73KhvSDirCe6G5U0Jukimt/riO9wb9Wpa3rRZJzvyxdFYOXit2Of43IRb4Ttepk3cnS
 dERSRQ6ylHpF/P3uQy0QXBeJxOFt507vOq3iFAXU4U+4LpC80vWURCgAvZhChByyIEQv
 pqrA==
X-Gm-Message-State: AC+VfDxseb81dW/hd7jMMSZVamXFNKzpUXzcTPPudMozloJw2RABhb6I
 FXe+V8iQWJzBfn0vam+9ekw=
X-Google-Smtp-Source: ACHHUZ5z1DMD4vOLhIuw1JKfxvDTtft+ji+RICMTE3cJ6X1nW+qTuLfnM797K3LYDFaHcVxNGZlDJw==
X-Received: by 2002:a17:902:eac4:b0:1b7:f063:301a with SMTP id
 p4-20020a170902eac400b001b7f063301amr3867022pld.24.1687728449803; 
 Sun, 25 Jun 2023 14:27:29 -0700 (PDT)
Received: from q1iq-virtual-machine.localdomain ([111.201.135.80])
 by smtp.gmail.com with ESMTPSA id
 je5-20020a170903264500b001b8004ff609sm761343plb.270.2023.06.25.14.27.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jun 2023 14:27:29 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>, Laurent Vivier <laurent@vivier.eu>
Subject: [RFC v3 05/10] linux-user: Implement native-bypass option support
Date: Mon, 26 Jun 2023 05:27:02 +0800
Message-Id: <20230625212707.1078951-6-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230625212707.1078951-1-fufuyqqqqqq@gmail.com>
References: <20230625212707.1078951-1-fufuyqqqqqq@gmail.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This commit implements the -native-bypass support in linux-user. The
native_calls_enabled() function can be true only when the
'-native-bypass' option is given.

Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
---
 linux-user/main.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/linux-user/main.c b/linux-user/main.c
index 5e6b2e1714..98e31c77d5 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -60,6 +60,13 @@
 #include "semihosting/semihost.h"
 #endif
 
+#if defined(CONFIG_NATIVE_CALL)
+#include "native/native-defs.h"
+
+static const char *native_lib;
+bool native_bypass_enabled;
+#endif
+
 #ifndef AT_FLAGS_PRESERVE_ARGV0
 #define AT_FLAGS_PRESERVE_ARGV0_BIT 0
 #define AT_FLAGS_PRESERVE_ARGV0 (1 << AT_FLAGS_PRESERVE_ARGV0_BIT)
@@ -125,6 +132,7 @@ static void usage(int exitcode);
 static const char *interp_prefix = CONFIG_QEMU_INTERP_PREFIX;
 const char *qemu_uname_release;
 
+
 #if !defined(TARGET_DEFAULT_STACK_SIZE)
 /* XXX: on x86 MAP_GROWSDOWN only works if ESP <= address + 32, so
    we allocate a bigger stack. Need a better solution, for example
@@ -293,6 +301,18 @@ static void handle_arg_set_env(const char *arg)
     free(r);
 }
 
+#if defined(CONFIG_NATIVE_CALL)
+static void handle_arg_native_bypass(const char *arg)
+{
+    if (access(arg, F_OK) != 0) {
+        fprintf(stderr, "native library %s does not exist\n", arg);
+        exit(EXIT_FAILURE);
+    }
+    native_lib = arg;
+    native_bypass_enabled = true;
+}
+#endif
+
 static void handle_arg_unset_env(const char *arg)
 {
     char *r, *p, *token;
@@ -522,6 +542,10 @@ static const struct qemu_argument arg_table[] = {
      "",           "Generate a /tmp/perf-${pid}.map file for perf"},
     {"jitdump",    "QEMU_JITDUMP",     false, handle_arg_jitdump,
      "",           "Generate a jit-${pid}.dump file for perf"},
+#if defined(CONFIG_NATIVE_CALL)
+    {"native-bypass", "QEMU_NATIVE_BYPASS", true, handle_arg_native_bypass,
+     "",           "native bypass for library calls in user mode only."},
+#endif
     {NULL, NULL, false, NULL, NULL, NULL}
 };
 
@@ -826,6 +850,18 @@ int main(int argc, char **argv, char **envp)
         }
     }
 
+#if defined(CONFIG_NATIVE_CALL)
+    /* Set the library for native bypass  */
+    if (native_bypass_enabled) {
+        GString *lib = g_string_new(native_lib);
+        lib = g_string_prepend(lib, "LD_PRELOAD=");
+        if (envlist_appendenv(envlist, g_string_free(lib, false), ":") != 0) {
+            fprintf(stderr,
+                    "failed to append the native library to environment.\n");
+            exit(EXIT_FAILURE);
+        }
+    }
+#endif
     target_environ = envlist_to_environ(envlist, NULL);
     envlist_free(envlist);
 
-- 
2.34.1


