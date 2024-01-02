Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB79C82164D
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 03:03:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKU3o-0003mP-VR; Mon, 01 Jan 2024 20:59:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU3l-0003ku-10
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:59:13 -0500
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU3i-000765-EX
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:59:12 -0500
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2044d093b3fso6010981fac.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jan 2024 17:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704160749; x=1704765549; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=niLg9Fo3ohbp8xRcoT4yGSYdzX+fXCYm2yVgdAWEpSM=;
 b=Kbrn/QI2g285S3RS6kAJu/uo8GbEm/zQgRL5rSjWbXC7mEUkZX3yTGUTJiKfWAsDRA
 s6Ov2mOagUz5K1zCvoHmYmS6ggvce9z9s1F4vO98WMXBDDJiwoP6IpeXxXdjCjag5FUp
 /XggRl8Yb0WnDPeLHa41djmSIkXa5JbPqPLCAcTNZNBcYX5QBeCYOgJwB8k1oThAFncC
 be2oPHGSRXvF7NY+XDjsArZk2qpFJ8AsS22cgSWd2BOnumAnwX939lvsC8m2+gBfoOHB
 76RJ/gu1j/8xm7wyrVt1dgt9bhB/OlQr63lPvaQkviyIkgFo7XW5XR6MeSS4te9USKrO
 XGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704160749; x=1704765549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=niLg9Fo3ohbp8xRcoT4yGSYdzX+fXCYm2yVgdAWEpSM=;
 b=OpjQx4VGmyzjFPV39KS+icm53gtZRj59UPvW0WjUqqCfLXefQs5CKczND8C7eT3l3C
 mECSLzmV3inttILaQsB1zu8QcQXNUtY7+6545X7bUSKFo7Y2RKCtjs6Ezbb7snWw4ayk
 mejrfW0o4JhpNxd1SHe86jjZf9jrQNfwwyWOH5X5Cdn24Jk89rq/WkmDot1FlnPzWLPP
 hT8qdR1sKd1+icgLh1PmJ+lJzb/Hz4/NdCnO8LVYqe1nel40kzb7Nal6DT1qv+4+7UrZ
 JDfDtRHnUuXklSuJfjQYOjo6JteQ6XciusgPe1FuTlDLZVHT0zdyJ3b0fgZ5qz8FpYQx
 bpKQ==
X-Gm-Message-State: AOJu0YzpYEO6K6HHYtNYy2cjVJeACV0e4gEAp0wlcP+2vYgpQ55IDSPD
 rwJVGArlxARPEmqnCFsAIKmImZAX/ug2JK/aotr7CbFAbEo=
X-Google-Smtp-Source: AGHT+IFT+AtcmE56JpSbu3zbN9zL1ifGtUo3++vf8EPhE5i4RngjIZMhnoBB5IrmqSTnrPVgf4Nukw==
X-Received: by 2002:a05:6870:b1c5:b0:204:7385:31d2 with SMTP id
 x5-20020a056870b1c500b00204738531d2mr16338388oak.117.1704160749372; 
 Mon, 01 Jan 2024 17:59:09 -0800 (PST)
Received: from stoup.. (124-149-254-207.tpgi.com.au. [124.149.254.207])
 by smtp.gmail.com with ESMTPSA id
 g33-20020a635221000000b0058ee60f8e4dsm19561891pgb.34.2024.01.01.17.59.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jan 2024 17:59:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 27/33] cpu: Remove page_size_init
Date: Tue,  2 Jan 2024 12:58:02 +1100
Message-Id: <20240102015808.132373-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102015808.132373-1-richard.henderson@linaro.org>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x33.google.com
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

Move qemu_host_page_{size,mask} and HOST_PAGE_ALIGN into bsd-user.
It should be removed from bsd-user as well, but defer that cleanup.

Reviewed-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/qemu.h           |  7 +++++++
 include/exec/cpu-common.h |  7 -------
 include/hw/core/cpu.h     |  2 --
 accel/tcg/translate-all.c |  1 -
 bsd-user/main.c           | 12 ++++++++++++
 cpu-target.c              | 13 -------------
 system/vl.c               |  1 -
 7 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index dc842fffa7..c05c512767 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -39,6 +39,13 @@ extern char **environ;
 #include "qemu/clang-tsa.h"
 
 #include "qemu-os.h"
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
index 41115d8919..e5b4e062ae 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -29,13 +29,6 @@ typedef uint64_t vaddr;
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
index c0c8320413..61bc88a0a3 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1169,8 +1169,6 @@ bool target_words_bigendian(void);
 
 const char *target_name(void);
 
-void page_size_init(void);
-
 #ifdef NEED_CPU_H
 
 #ifndef CONFIG_USER_ONLY
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 79a88f5fb7..7c29dd97b2 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -256,7 +256,6 @@ bool cpu_unwind_state_data(CPUState *cpu, uintptr_t host_pc, uint64_t *data)
 
 void page_init(void)
 {
-    page_size_init();
     page_table_config_init();
 }
 
diff --git a/bsd-user/main.c b/bsd-user/main.c
index ba159d2984..184d94b0a4 100644
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
@@ -408,6 +418,8 @@ int main(int argc, char **argv)
         }
     }
 
+    qemu_host_page_mask = -qemu_host_page_size;
+
     /* init debug */
     {
         int mask = 0;
diff --git a/cpu-target.c b/cpu-target.c
index 508013e23d..ee04baae7b 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -411,16 +411,3 @@ const char *target_name(void)
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
diff --git a/system/vl.c b/system/vl.c
index 6b87bfa32c..d4f5a42075 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2108,7 +2108,6 @@ static void qemu_create_machine(QDict *qdict)
     }
 
     cpu_exec_init_all();
-    page_size_init();
 
     if (machine_class->hw_version) {
         qemu_set_hw_version(machine_class->hw_version);
-- 
2.34.1


