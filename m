Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE71780DAC
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 16:12:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX05n-0004yD-Ve; Fri, 18 Aug 2023 10:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWwol-0006Nr-2W
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 06:35:00 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWwoi-0002ye-6j
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 06:34:58 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fe1fc8768aso7190605e9.1
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 03:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692354894; x=1692959694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fW46fogpRD0z/3au3liqhnlpv4cot2Ttk3TraxBL1oU=;
 b=nHCqP+Xve8KUI4ERf6Zc+4QKEd6XZkDP7lTAPt7hPg/0n2oZDBL3Toa8jfRVJdJ84+
 deMkyuCZrwvFeOHBD+OyUd2AJ/hC0IJbRaQEfPvrytAK/36sb89oYM8MbCi8CrqA9efR
 pdFH7aPhDJCjmozd0KEoco/q/qdI0FPTEtQZhSJZl7Vp3NKV4Drp5p2GOhh+jqJf1lLG
 bCpLoTNoMFDaoCTfk2PCAQlaY/5cZDD80wvIl/c6k0WvqusCvKbcfynsvBpmUEdgjSzU
 h1BhkC8nJJAN4Wz0lejbscD1W64/wDRTLBaSJSpm0rqk0SWUPnEtTwXug2RLVCPbbQF4
 LXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692354894; x=1692959694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fW46fogpRD0z/3au3liqhnlpv4cot2Ttk3TraxBL1oU=;
 b=Wq79JMLqcHloGCABDG+YOJ5IED8q2EnwtnG6CbMmONwvCpfSTLoB7OfnX/JUbM5Oxc
 sETfaF/bkILxPVfW6v9p31UJPDsAlyk85v7OZMuW6ztSwE0TmPwC/EusYl9InAzZQwBI
 goN7FMQRsvMEwHekAfec6nxaggzKAEecUVsNhk+FRZMbCAx4/Jj6kDzyS1a26lfv7QcA
 NbnyRGsDw2taRrRkmfYDQjeQ46pU9a2IxC4Mmc1+Tiu1F8QS2XTXfkxX6RCOOu/+DoNr
 S5M/odYcDRoPbgDtYWXXWWHnJvnyVyJgLtz6xhPuDexAVKQFdnS9Gqfj/sFhir+c9r9I
 uejQ==
X-Gm-Message-State: AOJu0YzN7er5TtqyYBHPvkywNZhfAcl8b6Q4LKKg+WuaX6Jxi4uYzC/X
 AzvysPJRwZF7fLR2+fs2CfeiSYYcWFAMM+JalWo=
X-Google-Smtp-Source: AGHT+IHQIm9urRzeaZyic2I9sONKdzKjR5IN9T6/rZJIAaMNv+lwDjUtP7C7/96AMq9uxfz6No+ucw==
X-Received: by 2002:a1c:7c0f:0:b0:3f9:b244:c294 with SMTP id
 x15-20020a1c7c0f000000b003f9b244c294mr1934808wmc.35.1692354894139; 
 Fri, 18 Aug 2023 03:34:54 -0700 (PDT)
Received: from localhost.localdomain ([92.88.170.41])
 by smtp.gmail.com with ESMTPSA id
 n24-20020a7bc5d8000000b003fe17e04269sm2371236wmk.40.2023.08.18.03.34.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 18 Aug 2023 03:34:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Jiajie Chen <c@jia.je>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/4] target/loongarch: Extract 64-bit specifics to
 loongarch64_cpu_class_init
Date: Fri, 18 Aug 2023 12:34:25 +0200
Message-ID: <20230818103425.16271-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230818103425.16271-1-philmd@linaro.org>
References: <20230818103425.16271-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Extract loongarch64 specific code from loongarch_cpu_class_init()
to a new loongarch64_cpu_class_init().
Adapt DEFINE_LOONGARCH64_CPU_TYPE() macro.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/cpu.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 19572e37ad..6bd5ca93fd 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -694,11 +694,6 @@ static const struct SysemuCPUOps loongarch_sysemu_ops = {
 };
 #endif
 
-static gchar *loongarch64_gdb_arch_name(CPUState *cs)
-{
-    return g_strdup("loongarch64");
-}
-
 static void loongarch_cpu_class_init(ObjectClass *c, void *data)
 {
     LoongArchCPUClass *lacc = LOONGARCH_CPU_CLASS(c);
@@ -714,8 +709,6 @@ static void loongarch_cpu_class_init(ObjectClass *c, void *data)
     cc->class_by_name = loongarch_cpu_class_by_name;
     cc->has_work = loongarch_cpu_has_work;
     cc->dump_state = loongarch_cpu_dump_state;
-    cc->set_pc = loongarch64_cpu_set_pc;
-    cc->get_pc = loongarch64_cpu_get_pc;
 #ifndef CONFIG_USER_ONLY
     dc->vmsd = &vmstate_loongarch_cpu;
     cc->sysemu_ops = &loongarch_sysemu_ops;
@@ -723,21 +716,35 @@ static void loongarch_cpu_class_init(ObjectClass *c, void *data)
     cc->disas_set_info = loongarch_cpu_disas_set_info;
     cc->gdb_read_register = loongarch_cpu_gdb_read_register;
     cc->gdb_write_register = loongarch_cpu_gdb_write_register;
-    cc->gdb_num_core_regs = 35;
-    cc->gdb_core_xml_file = "loongarch-base64.xml";
     cc->gdb_stop_before_watchpoint = true;
-    cc->gdb_arch_name = loongarch64_gdb_arch_name;
 
 #ifdef CONFIG_TCG
     cc->tcg_ops = &loongarch_tcg_ops;
 #endif
 }
 
+static gchar *loongarch64_gdb_arch_name(CPUState *cs)
+{
+    return g_strdup("loongarch64");
+}
+
+static void loongarch64_cpu_class_init(ObjectClass *c, void *data)
+{
+    CPUClass *cc = CPU_CLASS(c);
+
+    cc->set_pc = loongarch64_cpu_set_pc;
+    cc->get_pc = loongarch64_cpu_get_pc;
+    cc->gdb_num_core_regs = 35;
+    cc->gdb_core_xml_file = "loongarch-base64.xml";
+    cc->gdb_arch_name = loongarch64_gdb_arch_name;
+}
+
 #define DEFINE_LOONGARCH64_CPU_TYPE(model, initfn) \
     { \
         .parent = TYPE_LOONGARCH_CPU, \
-        .instance_init = initfn, \
         .name = LOONGARCH_CPU_TYPE_NAME(model), \
+        .instance_init = initfn, \
+        .class_init = loongarch64_cpu_class_init, \
     }
 
 static const TypeInfo loongarch_cpu_type_infos[] = {
-- 
2.41.0


