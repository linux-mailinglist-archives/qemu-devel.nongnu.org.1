Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16232780D67
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 16:05:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX05w-00053O-KS; Fri, 18 Aug 2023 10:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWwog-0006ND-BN
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 06:34:55 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWwoc-0002xy-2Z
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 06:34:53 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fe32016bc8so6954515e9.1
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 03:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692354888; x=1692959688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IkmPByYqMTHfKD7x50TDBOyupt/4VUOGL0uYh2iijAE=;
 b=LW5Y12yEweki3nDnVUDoWQRPsG+CsPWs+xaaWO5H3gqcSQFHeLdpdkmYOkt1FUenLi
 1uf+F3B5v97uDtjcztl8GhFeegQJwOiZ+Jy4d+eNPaXtpL8Zip5Xsi/bgp+2yABAMhvB
 zi7lnZkYOvJbartRiMcY9FKe65NKn0apmAzCB/3sTx7qIk+20+WjWpBmks2GSytD/bDk
 40baAGgbb6HxVEwqlsc2399Q5xKEnxqELopFuN05mAb0GWknneDg0SETyI9no5QkQZyg
 xTQvUgCbbokGwLkPTddW9R3fZaxTivkACjYqxQvSaCh/w8LyRY6kSiqe8At4OQNpuzka
 i7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692354888; x=1692959688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IkmPByYqMTHfKD7x50TDBOyupt/4VUOGL0uYh2iijAE=;
 b=QwWKV/EOf0kyInryiMooIpGnuPLS1sdgwMLupiVnj8s3kXT5/SxhWp+DWE1qXLwnHl
 EYux6AdPdjzhRRncHwXCVkp77k40QcyEgAVKzaM/HDDS231nCLll3Tdte9Dtl+Xi+KRn
 dcvBYwj6JovAmZ8iBRMO/UWMxr0Dg6DkdRqoU7diue1fDAy4Uk0EhrspKLM9JZe6FNdj
 XfzCpyL8xUuc54Q87ZjGC5toI5q8+5gXJinO8fDckcCeuoJZyVP7mdnXIvKEj63QFHu4
 01C76AIUbvBNb31OOn5Ix2IW3Lkxlfy9y6ML/4sf7zsKH1Z62xgYTcxxgkOEd/z7GPxs
 hA7w==
X-Gm-Message-State: AOJu0YwxHyW41cR8rOS9WyyDw135PUYvi39j6WvoamyvO+FueRGiekBH
 uwYGFdJsihakDgTtZSP3p+m/d8RyLlRJcH8USsc=
X-Google-Smtp-Source: AGHT+IH5vHUowOwQb2y4jkEIq0UkaIK2TFqlwI+E/IDV/ozqiM+8ej943g0wtlrR9PAWy7UAt5bVYQ==
X-Received: by 2002:a05:600c:212:b0:3fe:212c:f790 with SMTP id
 18-20020a05600c021200b003fe212cf790mr1803146wmi.36.1692354888165; 
 Fri, 18 Aug 2023 03:34:48 -0700 (PDT)
Received: from localhost.localdomain ([92.88.170.41])
 by smtp.gmail.com with ESMTPSA id
 l3-20020a1ced03000000b003fe1a96845bsm5816099wmh.2.2023.08.18.03.34.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 18 Aug 2023 03:34:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Jiajie Chen <c@jia.je>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/4] target/loongarch: Rename 64-bit specific functions
Date: Fri, 18 Aug 2023 12:34:24 +0200
Message-ID: <20230818103425.16271-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230818103425.16271-1-philmd@linaro.org>
References: <20230818103425.16271-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

These functions are specific to loongarch64 cores. Rename
including the '64' suffix in preparation of supporting
loongarch32 cores.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/cpu.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index dc617be36f..19572e37ad 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -76,7 +76,7 @@ void G_NORETURN do_raise_exception(CPULoongArchState *env,
     cpu_loop_exit_restore(cs, pc);
 }
 
-static void loongarch_cpu_set_pc(CPUState *cs, vaddr value)
+static void loongarch64_cpu_set_pc(CPUState *cs, vaddr value)
 {
     LoongArchCPU *cpu = LOONGARCH_CPU(cs);
     CPULoongArchState *env = &cpu->env;
@@ -84,7 +84,7 @@ static void loongarch_cpu_set_pc(CPUState *cs, vaddr value)
     env->pc = value;
 }
 
-static vaddr loongarch_cpu_get_pc(CPUState *cs)
+static vaddr loongarch64_cpu_get_pc(CPUState *cs)
 {
     LoongArchCPU *cpu = LOONGARCH_CPU(cs);
     CPULoongArchState *env = &cpu->env;
@@ -356,7 +356,7 @@ static bool loongarch_cpu_has_work(CPUState *cs)
 #endif
 }
 
-static void loongarch_la464_initfn(Object *obj)
+static void loongarch64_la464_initfn(Object *obj)
 {
     LoongArchCPU *cpu = LOONGARCH_CPU(obj);
     CPULoongArchState *env = &cpu->env;
@@ -694,7 +694,7 @@ static const struct SysemuCPUOps loongarch_sysemu_ops = {
 };
 #endif
 
-static gchar *loongarch_gdb_arch_name(CPUState *cs)
+static gchar *loongarch64_gdb_arch_name(CPUState *cs)
 {
     return g_strdup("loongarch64");
 }
@@ -714,8 +714,8 @@ static void loongarch_cpu_class_init(ObjectClass *c, void *data)
     cc->class_by_name = loongarch_cpu_class_by_name;
     cc->has_work = loongarch_cpu_has_work;
     cc->dump_state = loongarch_cpu_dump_state;
-    cc->set_pc = loongarch_cpu_set_pc;
-    cc->get_pc = loongarch_cpu_get_pc;
+    cc->set_pc = loongarch64_cpu_set_pc;
+    cc->get_pc = loongarch64_cpu_get_pc;
 #ifndef CONFIG_USER_ONLY
     dc->vmsd = &vmstate_loongarch_cpu;
     cc->sysemu_ops = &loongarch_sysemu_ops;
@@ -726,14 +726,14 @@ static void loongarch_cpu_class_init(ObjectClass *c, void *data)
     cc->gdb_num_core_regs = 35;
     cc->gdb_core_xml_file = "loongarch-base64.xml";
     cc->gdb_stop_before_watchpoint = true;
-    cc->gdb_arch_name = loongarch_gdb_arch_name;
+    cc->gdb_arch_name = loongarch64_gdb_arch_name;
 
 #ifdef CONFIG_TCG
     cc->tcg_ops = &loongarch_tcg_ops;
 #endif
 }
 
-#define DEFINE_LOONGARCH_CPU_TYPE(model, initfn) \
+#define DEFINE_LOONGARCH64_CPU_TYPE(model, initfn) \
     { \
         .parent = TYPE_LOONGARCH_CPU, \
         .instance_init = initfn, \
@@ -751,7 +751,7 @@ static const TypeInfo loongarch_cpu_type_infos[] = {
         .class_size = sizeof(LoongArchCPUClass),
         .class_init = loongarch_cpu_class_init,
     },
-    DEFINE_LOONGARCH_CPU_TYPE("la464", loongarch_la464_initfn),
+    DEFINE_LOONGARCH64_CPU_TYPE("la464", loongarch64_la464_initfn),
 };
 
 DEFINE_TYPES(loongarch_cpu_type_infos)
-- 
2.41.0


