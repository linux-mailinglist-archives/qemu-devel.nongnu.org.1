Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 781EA781189
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:21:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX39i-0005Ko-Mn; Fri, 18 Aug 2023 13:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qX39c-00053r-59
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:20:56 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qX39Z-0001qj-Ua
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:20:55 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-51e28cac164so4683080a12.1
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 10:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692379252; x=1692984052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IoHDoN5cg3pTvtc6lY6oBNri3TvAxKVoaXExBdNi1sc=;
 b=fKI3FbqMUYRFbg6+QV9AIreKSqMnB87mlAgXj+spNzZ1vvrCHn84+cZpSlQeg33RqK
 VGMGPdXUzEQOGomVDALq+qAGJWR8AC2Mx7Y+mGb+NEBGIo3bmWZC+Dy3wWwP3zUCBsNh
 kA+j6rKHo312OYP9iS3Edv1VE/669Urlo4gRZ9cfWJGAxiGJuOlvgHPZC4DwuqIIWFWB
 nNE6RNhuJ1tF9OIwMeccbiCy3G/zWdca2deMQH8L/IEIVvk76socVBE/gytr9+MHrbSE
 ruD+CQeGqRX8biK1yIYe+wy0bSy32VgSVKBXLiN/TAWLyhhpHYipSxRIruolfsUDwlVo
 QD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692379252; x=1692984052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IoHDoN5cg3pTvtc6lY6oBNri3TvAxKVoaXExBdNi1sc=;
 b=j7jlpR9PwXD94w8DhtMpnPo3wLb2khJ+LLXIhE6He13B1liUY/ykI6ALGsIM48mFfR
 olSk6stzXAM/0RM+5my5GWt5EcxM6o+jkJmAvJrwvZDz/JZzczIQUI2RMIl91OSOJ955
 3XbeegKtu6sZkAsoi1qFUS+kMwnBv02w+USm2g8gj5ejVmtIigNbpkplP7UwjjSwBvGl
 KXN7+Or1S61Z4E7UvqA36kLAvECPKg48WXr95bDFVkCRr520e1HJXlDOWF3L08m1FkuR
 htF0dztnRqPUwDfppWk/dOMS9h2ragHq9saFPIF13/W0bEEN3wjU0QigFzB0p4ECuFj0
 BqsA==
X-Gm-Message-State: AOJu0Yz7xu9F8RpTNclxeb6CooN7xgG026wDy+Xlte8MIjygtoC5g9uZ
 jouK+LdHOSeTyPAN4KZVufFqtUjilceT3GcAZ/E=
X-Google-Smtp-Source: AGHT+IHRmoeiFH6s8Yip0g8bg6vCfRfYi5VdpTOlx0eqw3tCUmG9Cc0BahY2vYz37OKDr8BT9d/4Bg==
X-Received: by 2002:a17:906:8a51:b0:989:450:e565 with SMTP id
 gx17-20020a1709068a5100b009890450e565mr3344948ejc.23.1692379252378; 
 Fri, 18 Aug 2023 10:20:52 -0700 (PDT)
Received: from m1x-phil.lan (cnf78-h01-176-184-27-79.dsl.sta.abo.bbox.fr.
 [176.184.27.79]) by smtp.gmail.com with ESMTPSA id
 z14-20020a1709064e0e00b0099293cdbc98sm1427558eju.145.2023.08.18.10.20.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 18 Aug 2023 10:20:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jiajie Chen <c@jia.je>, Song Gao <gaosong@loongson.cn>
Subject: [PATCH v2 5/8] target/loongarch: Extract 64-bit specifics to
 loongarch64_cpu_class_init
Date: Fri, 18 Aug 2023 19:20:13 +0200
Message-ID: <20230818172016.24504-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230818172016.24504-1-philmd@linaro.org>
References: <20230818172016.24504-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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

In preparation of supporting loongarch32 cores, rename these
functions using the '64' suffix.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/cpu.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 34d6c5a31d..356d039560 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -356,7 +356,7 @@ static bool loongarch_cpu_has_work(CPUState *cs)
 #endif
 }
 
-static void loongarch_la464_initfn(Object *obj)
+static void loongarch64_la464_initfn(Object *obj)
 {
     LoongArchCPU *cpu = LOONGARCH_CPU(obj);
     CPULoongArchState *env = &cpu->env;
@@ -695,11 +695,6 @@ static const struct SysemuCPUOps loongarch_sysemu_ops = {
 };
 #endif
 
-static gchar *loongarch_gdb_arch_name(CPUState *cs)
-{
-    return g_strdup("loongarch64");
-}
-
 static void loongarch_cpu_class_init(ObjectClass *c, void *data)
 {
     LoongArchCPUClass *lacc = LOONGARCH_CPU_CLASS(c);
@@ -724,16 +719,27 @@ static void loongarch_cpu_class_init(ObjectClass *c, void *data)
     cc->disas_set_info = loongarch_cpu_disas_set_info;
     cc->gdb_read_register = loongarch_cpu_gdb_read_register;
     cc->gdb_write_register = loongarch_cpu_gdb_write_register;
-    cc->gdb_num_core_regs = 35;
-    cc->gdb_core_xml_file = "loongarch-base64.xml";
     cc->gdb_stop_before_watchpoint = true;
-    cc->gdb_arch_name = loongarch_gdb_arch_name;
 
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
+    cc->gdb_num_core_regs = 35;
+    cc->gdb_core_xml_file = "loongarch-base64.xml";
+    cc->gdb_arch_name = loongarch64_gdb_arch_name;
+}
+
 #define DEFINE_LOONGARCH_CPU_TYPE(size, model, initfn) \
     { \
         .parent = TYPE_LOONGARCH##size##_CPU, \
@@ -757,8 +763,9 @@ static const TypeInfo loongarch_cpu_type_infos[] = {
         .parent = TYPE_LOONGARCH_CPU,
 
         .abstract = true,
+        .class_init = loongarch64_cpu_class_init,
     },
-    DEFINE_LOONGARCH_CPU_TYPE(64, "la464", loongarch_la464_initfn),
+    DEFINE_LOONGARCH_CPU_TYPE(64, "la464", loongarch64_la464_initfn),
 };
 
 DEFINE_TYPES(loongarch_cpu_type_infos)
-- 
2.41.0


