Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A8178F704
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 04:24:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbtpe-0007Zv-OS; Thu, 31 Aug 2023 22:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtpZ-0007Ah-Ja
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:24:17 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtpI-0001Sl-UG
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:24:11 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-68a41035828so1182381b3a.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 19:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693535034; x=1694139834; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g3/iatjXff6UUdz2cl7k/bF/yMUs8bwvdLM3Z+AtKOI=;
 b=J0rDxM6jGBYmkHZSIlGa37+7nlBgHAI2+laizxvHJqxkj8QIQSOo7pz2QOzv+ZVWYE
 63mX8dzYjCtklPCYzbDlkiZqj9Z5B52Q1WCWXFyFFJ5KxA/ARDDjYuzG4XkueUP+qiRb
 fkl/lpGQXLP1n8sl1s6wWRYW4V5ojpRrZzLAoCz6V27w93L1Yn7KT/GuNhPfTooSU+h1
 IYSCE+It6R/7g8lcaQH4N6TccRkEYKmDoULj297bQvwH1/rlx7fcDQBSJpeU6WQA/QO3
 n4FeHIAgAPcaWT9OoXPXGwNbn6O38IVwVUFp0iiVUXGuniT8Zx/hY9cvL2lHUk0yeIoW
 HDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693535034; x=1694139834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g3/iatjXff6UUdz2cl7k/bF/yMUs8bwvdLM3Z+AtKOI=;
 b=HwiXVJRzxoNJZRiguGh1PIgumInCfCA8Uq0TA6a2QnMSZE1GkyCzmdFy7pM3d6YHh1
 HQN2W1dDGMXP7ZYH9pu0kFXgIuIIJA+A0W8M8Qy64/qRxOiNd2WWjn2Wpz4/YtXKrQqP
 7ozh46F8uSGbAfJJoByUt8yveSqIksX6TmcNZhiJUiBItvV/vUxEodr8lGx3olmMj2Xz
 tSkzaCSgxeL5jEKmR+6weEpQ3AYxj8CyYKeVNMOoN4S1EmcV+xMIaux5aGhdAQ0AJ/i2
 CAxOK5YVv35ygtK3qjjPtmgYENPjK7856IcwX+Q8exdDt3BVP6H/4prfAEdf2FzBA4hF
 r4+w==
X-Gm-Message-State: AOJu0YxWcnOP0psaGClQhtDP7kICzeQ8OMvPkA7DYWY4VW2tlTcMVaT7
 6QhTFaBI0TP2CpG78S/ZXFKqJlFziH2lBT2/RhU=
X-Google-Smtp-Source: AGHT+IFV4PTpbDQ1XidVdKjc7jBwvSMVKrCtABdezjhFl2ncYvuUl8OIXKh33RpxEEW2wl7wgM5sKw==
X-Received: by 2002:a05:6a20:f39f:b0:14c:5f8:fb3e with SMTP id
 qr31-20020a056a20f39f00b0014c05f8fb3emr1444053pzb.38.1693535034680; 
 Thu, 31 Aug 2023 19:23:54 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 c25-20020aa781d9000000b0068a54866ca8sm1906977pfn.134.2023.08.31.19.23.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 19:23:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, alex.bennee@linaro.org, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 27/33] cpu: Remove page_size_init
Date: Thu, 31 Aug 2023 19:23:25 -0700
Message-Id: <20230901022331.115247-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901022331.115247-1-richard.henderson@linaro.org>
References: <20230901022331.115247-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Cc: Warner Losh <imp@bsdimp.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index d3158bc2ed..c53f06d3f6 100644
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
index 41788c0bdd..46b0abc918 100644
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
index f227d87834..ab389aa938 100644
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


