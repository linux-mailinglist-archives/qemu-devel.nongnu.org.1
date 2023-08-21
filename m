Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E567829D6
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 15:02:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY4XP-0001hq-Ub; Mon, 21 Aug 2023 09:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qY4Wd-0000Zb-5p
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 09:01:00 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qY4WQ-0001G6-CG
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 09:00:53 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fef56f7223so2089475e9.3
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 06:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692622833; x=1693227633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2emvSppPUAN2BQaD+odMmobapg0yAtZtyVccXkFX9fU=;
 b=MWvMd7e48PL32UgoBAiA1HJuQshk3FE/pVt1lWK5r8O+oEFQS46ifjy7V7UsvMKpdK
 AAaclzj3qdUJkMIX9mr+B2iTYll8O/BJwnD2h15pzl/hKzKesCjrHJir4ZN++wBY66+V
 Q9IHNEO+5s6rAMcNqVwje1PDc8Oxt+iAzwzowoASjwFSX4M6yHEjdpZtE3YukTkg0DmJ
 4z4gl9+By5TXSHsEpVXmr/3+W+uVEQCjzcibVBbmUYw8BQgeQwuU2LOP7w3ueUO+Eckb
 57DUhSijIH0107FQcCmERvUy7JuWbgn5ZBhPVwxD3bSS/4fO+R9dm89241X/782fAPkp
 ckKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692622833; x=1693227633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2emvSppPUAN2BQaD+odMmobapg0yAtZtyVccXkFX9fU=;
 b=Aqkhi7rSo3b2vhvxH76uAlPm0G4ANvJLgZJgFe4VnD0+VZVJ7DmA5VEQz8o/6a1P1B
 taWLDd7JZSA8YvjgtvEODVqChUA8GN/FhsNqtiXU9Zd/99NbV2cOs+C7f9Jnbl0ltcD0
 G9VApqG7XcT2ChBvdTWm8i7rW47qvEGwppUaa+rudtX9t0UV1DC+pgqNF8Ctk+hab545
 8KZ8jV+iqXw4TVamVLiazIsoUfyXzcBhR8dS9ZadXKDQCGMrYDB425ScFq3KFzUL5hPC
 ekkmsJOchhKtfujcTePETm613rHR92sbv9/W5RGbKuEAum8jeNt0NfKmA8LXkjmhrmWN
 z5dg==
X-Gm-Message-State: AOJu0YzBUxHUX7TyUHklBsG59Nkm3XUNtAW182eu00GOjcjhyYwTG5pW
 rAuRTO2YjiUJliBRexwA5syYb/6MSGbobn45oPk=
X-Google-Smtp-Source: AGHT+IGBpb1uJkywGfLYUM6FKoAVFEfY8j/MKi98YKWKF92YKl7qyX7GBHMPNJ3H2How4sg7IUEr1w==
X-Received: by 2002:a05:600c:364a:b0:3fe:d70f:b0a2 with SMTP id
 y10-20020a05600c364a00b003fed70fb0a2mr5580469wmq.6.1692622833766; 
 Mon, 21 Aug 2023 06:00:33 -0700 (PDT)
Received: from m1x-phil.lan (static-176-182-122-208.ncc.abo.bbox.fr.
 [176.182.122.208]) by smtp.gmail.com with ESMTPSA id
 21-20020a05600c22d500b003fee777fd84sm7809383wmg.41.2023.08.21.06.00.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 21 Aug 2023 06:00:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Jiajie Chen <c@jia.je>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Huacai Chen <chenhuacai@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 5/8] target/loongarch: Extract 64-bit specifics to
 loongarch64_cpu_class_init
Date: Mon, 21 Aug 2023 14:59:56 +0200
Message-ID: <20230821125959.28666-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821125959.28666-1-philmd@linaro.org>
References: <20230821125959.28666-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/cpu.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 34d6c5a31d..6384bda1bd 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
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
@@ -757,6 +763,7 @@ static const TypeInfo loongarch_cpu_type_infos[] = {
         .parent = TYPE_LOONGARCH_CPU,
 
         .abstract = true,
+        .class_init = loongarch64_cpu_class_init,
     },
     DEFINE_LOONGARCH_CPU_TYPE(64, "la464", loongarch_la464_initfn),
 };
-- 
2.41.0


