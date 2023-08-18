Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 504E2781177
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:17:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX324-0008O5-6P; Fri, 18 Aug 2023 13:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX321-0008LE-Lp
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:13:05 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31y-000873-Bz
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:13:04 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bdbf10333bso9527515ad.1
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 10:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692378781; x=1692983581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ataiAyODkAIfirPwE5L7zXmqt5E+aKGaPeIxcvvLwCA=;
 b=RxyA+IzOJkq5H4JqMH+nJeDa8c4Gpswj3vP2L82POTv4+jGyKA4rJwMQKLVgN+CoFj
 gLRRG7Spfpw6E7ACF/lUCHXZz7KF/Zqo+WYzfcGRHF6nXOaEo5V7kJlUR8Ap7YpWp8i8
 PgD+WYQ8rkF9RJohhWglXkTs6Lsf9L+lEcK6Mxi/THj6yBFx/CqzxEI+9Cfgpl6Enlga
 qfYmJ5/o20MURjxb4fXvWjWVz6a4zskBtzAAP6+sAVdX5IZw7IjXZuZyq3062t4ZCxh6
 7/b3RArhUGZtAWGK4rmRU5YHcuYEDpbN7M2odWSHmAkQ1+dOU6O/JYh5ZxAADK+hHhHH
 rknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692378781; x=1692983581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ataiAyODkAIfirPwE5L7zXmqt5E+aKGaPeIxcvvLwCA=;
 b=OYOtzLVOJ4d0I+DY7kAIUc4GkKoSsJrwu6g18Zlrvfi0/V+sbLJVNEWpKmR/5r+IPi
 j1GvkAc6pDZiqAsJ3NOKSgshnUGyLGAWSkxmjfg4L/6PI7F/Bx4oT37OXdQD156zeezS
 3sxmGnksEsaPS0GDf5rKZedG+1307N1sOtIAz3L+itvszG3OwAoCzY95hkSa8tXkhQYe
 u6On8vsFcXabSDrfk2EowlXkpHah2b2rGL69MHrOl5wMo+UieCMNtWf1XQzbaCBSWCQb
 Mdryz3sLE4ILTpR5MHDplt23alWYDFVF13rFoPkP5IFhAov60Wi41Y/fcKnWe4pHgt0Q
 /ZGg==
X-Gm-Message-State: AOJu0YyWW0jFSSuiLWHNp7U19UO5uD7AzVTD/zA6yS0fHATKbrrc1yV1
 tIV71ck/j367yWqCvyFT2PpjKoYR1RejPyvQHIk=
X-Google-Smtp-Source: AGHT+IFmt0hS2hFURyI93ud/ENaIQexJw/sUwAzuLWroauE9gHroGcUStcieVd68TyBwoH3v9EaHSg==
X-Received: by 2002:a17:902:e850:b0:1b9:cf52:2bcf with SMTP id
 t16-20020a170902e85000b001b9cf522bcfmr3268637plg.0.1692378781190; 
 Fri, 18 Aug 2023 10:13:01 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 jw24-20020a170903279800b001adf6b21c77sm2020025plb.107.2023.08.18.10.13.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 10:13:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 27/33] cpu: Remove page_size_init
Date: Fri, 18 Aug 2023 10:12:21 -0700
Message-Id: <20230818171227.141728-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818171227.141728-1-richard.henderson@linaro.org>
References: <20230818171227.141728-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Move qemu_host_page_{size,mask} and HOST_PAGE_ALIGN into bsd-user.
It should be removed from bsd-user as well, but defer that cleanup.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/qemu.h           |  7 +++++++
 include/exec/cpu-common.h |  7 -------
 include/hw/core/cpu.h     |  2 --
 accel/tcg/translate-all.c |  1 -
 bsd-user/main.c           | 12 ++++++++++++
 cpu.c                     | 13 -------------
 softmmu/vl.c              |  1 -
 7 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 8f2d6a3c78..9fe4e70890 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -38,6 +38,13 @@ extern char **environ;
 #include "exec/gdbstub.h"
 #include "qemu/clang-tsa.h"
 
+/*
+ * TODO: Remove these and rely only on qemu_real_host_page_size().
+ */
+extern uintptr_t qemu_host_page_size;
+extern intptr_t qemu_host_page_mask;
+#define HOST_PAGE_ALIGN(addr) ROUND_UP((addr), qemu_host_page_size)
+
 /*
  * This struct is used to hold certain information about the image.  Basically,
  * it replicates in user space what would be certain task_struct fields in the
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 87dc9a752c..1bf4616fa3 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -22,13 +22,6 @@ typedef uint64_t vaddr;
 void cpu_exec_init_all(void);
 void cpu_exec_step_atomic(CPUState *cpu);
 
-/* Using intptr_t ensures that qemu_*_page_mask is sign-extended even
- * when intptr_t is 32-bit and we are aligning a long long.
- */
-extern uintptr_t qemu_host_page_size;
-extern intptr_t qemu_host_page_mask;
-
-#define HOST_PAGE_ALIGN(addr) ROUND_UP((addr), qemu_host_page_size)
 #define REAL_HOST_PAGE_ALIGN(addr) ROUND_UP((addr), qemu_real_host_page_size())
 
 /* The CPU list lock nests outside page_(un)lock or mmap_(un)lock */
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index fdcbe87352..66575eec73 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1025,8 +1025,6 @@ bool target_words_bigendian(void);
 
 const char *target_name(void);
 
-void page_size_init(void);
-
 #ifdef NEED_CPU_H
 
 #ifndef CONFIG_USER_ONLY
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index b2d4e22c17..d84558dd95 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -255,7 +255,6 @@ bool cpu_unwind_state_data(CPUState *cpu, uintptr_t host_pc, uint64_t *data)
 
 void page_init(void)
 {
-    page_size_init();
     page_table_config_init();
 }
 
diff --git a/bsd-user/main.c b/bsd-user/main.c
index 381bb18df8..3cb2b5f43c 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -49,6 +49,13 @@
 #include "host-os.h"
 #include "target_arch_cpu.h"
 
+
+/*
+ * TODO: Remove these and rely only on qemu_real_host_page_size().
+ */
+uintptr_t qemu_host_page_size;
+intptr_t qemu_host_page_mask;
+
 static bool opt_one_insn_per_tb;
 uintptr_t guest_base;
 bool have_guest_base;
@@ -308,6 +315,9 @@ int main(int argc, char **argv)
         (void) envlist_setenv(envlist, *wrk);
     }
 
+    qemu_host_page_size = getpagesize();
+    qemu_host_page_size = MAX(qemu_host_page_size, TARGET_PAGE_SIZE);
+
     cpu_model = NULL;
 
     qemu_add_opts(&qemu_trace_opts);
@@ -407,6 +417,8 @@ int main(int argc, char **argv)
         }
     }
 
+    qemu_host_page_mask = -qemu_host_page_size;
+
     /* init debug */
     {
         int mask = 0;
diff --git a/cpu.c b/cpu.c
index 1c948d1161..743c889ece 100644
--- a/cpu.c
+++ b/cpu.c
@@ -431,16 +431,3 @@ const char *target_name(void)
 {
     return TARGET_NAME;
 }
-
-void page_size_init(void)
-{
-    /* NOTE: we can always suppose that qemu_host_page_size >=
-       TARGET_PAGE_SIZE */
-    if (qemu_host_page_size == 0) {
-        qemu_host_page_size = qemu_real_host_page_size();
-    }
-    if (qemu_host_page_size < TARGET_PAGE_SIZE) {
-        qemu_host_page_size = TARGET_PAGE_SIZE;
-    }
-    qemu_host_page_mask = -(intptr_t)qemu_host_page_size;
-}
diff --git a/softmmu/vl.c b/softmmu/vl.c
index b0b96f67fa..bc2aab9aaa 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -2049,7 +2049,6 @@ static void qemu_create_machine(QDict *qdict)
     }
 
     cpu_exec_init_all();
-    page_size_init();
 
     if (machine_class->hw_version) {
         qemu_set_hw_version(machine_class->hw_version);
-- 
2.34.1


