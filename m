Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F187D70F98E
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 17:01:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1py8-0006vB-HX; Wed, 24 May 2023 11:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1py6-0006tj-LP
 for qemu-devel@nongnu.org; Wed, 24 May 2023 11:00:02 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1py4-0006YU-S8
 for qemu-devel@nongnu.org; Wed, 24 May 2023 11:00:02 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3f603d4bc5bso12488475e9.3
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 08:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684940398; x=1687532398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mkUxPfgunl3171HVbZ04V4mGlWy5lVrjE2KtHggEcpE=;
 b=dsRaViDu/uGfGzKQ+/hybnBXxuMs8bn7JOsECmoJkLmcGCsHvYrAIQxdqlf0FZZj30
 NeoWdHbmpJUmpYKIxeFpnM2+ypHIm3laMcHCC8oUa3Mu2JS+NH5qBQF/hCiQKk4XGKF9
 XYZrCN6xpJQE7aTn1CalLBAzmnMl10c1pjaiJGyg4zSec7jiBuIuLJWKHEFoYmEhiwsz
 8OtjKjtZVV7u0lzZrlTy21jqooVYYbpPb4wKQ/6fXkyuPM8CVMwppSgIYt1nH2JeHZiL
 Y7JFgweZI60asp6uYctAuzRgAMHjsyTfjKJq9Vt8CiNyKTrua9anysZzQDkZa12x8m4/
 nQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684940398; x=1687532398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mkUxPfgunl3171HVbZ04V4mGlWy5lVrjE2KtHggEcpE=;
 b=QhszjcaDbPaYztjX7/93zBhnp4utG4l3IxZrivUYWPpOLEJwsg7+pKckBvOZK11zL+
 +B9EqGqVDh6KLTm5pcIobhKDBg0JLRvoTIWCbvlAAG1/JPLagPoVlllA9iHzqaiOzufZ
 lPocE3/AiVR2fs01PJLyTK2DFMSc7abyX/fp8vQPnD8pMpL6OhK9SH/qHYbrp/LcdE6+
 NbHZALWqU23fugik4mWEt7ifBDw07SEaIrKD8aNHcARrhNnfXePPFfnjgTn0d68g8ID3
 T0JcvKOBYC+TLzmXod1sQUWHXyaI/tYNIDFqDrtKE9srXXvck9MIW5Qa0MAscsdyC5ya
 R5rA==
X-Gm-Message-State: AC+VfDwZKG4Grsif9jopp6VYWJLjqHyT3e6aZ/nWvzeiPiqJtVSpTcrT
 3S8M6zK6gEoFI7UgWvL7OaaxZjQ025PG019cTAXMWA==
X-Google-Smtp-Source: ACHHUZ6hHmgA9Wcty0v3S3xc9zTTw3nhWtU+REJ4snF/otQ9yy7ZDVOIdCaizp0j5+elH6lZ//GCug==
X-Received: by 2002:a7b:c40a:0:b0:3f1:72fb:461a with SMTP id
 k10-20020a7bc40a000000b003f172fb461amr104066wmi.2.1684940398197; 
 Wed, 24 May 2023 07:59:58 -0700 (PDT)
Received: from localhost.localdomain
 (fac34-h02-176-184-31-193.dsl.sta.abo.bbox.fr. [176.184.31.193])
 by smtp.gmail.com with ESMTPSA id
 f21-20020a7bc8d5000000b003f60a446fe5sm2613241wml.29.2023.05.24.07.59.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 May 2023 07:59:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 09/10] hw/arm/realview: Use generic
 realview_common_machine_init()
Date: Wed, 24 May 2023 16:59:05 +0200
Message-Id: <20230524145906.33156-10-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230524145906.33156-1-philmd@linaro.org>
References: <20230524145906.33156-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The realview_board_type enum is now unused. Remove it and have
all instances use the common realview_common_machine_init()
method.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/realview.c | 46 ++--------------------------------------------
 1 file changed, 2 insertions(+), 44 deletions(-)

diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 917a1b22df..b7bb384000 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -54,13 +54,6 @@ static struct arm_boot_info realview_binfo = {
     .smp_bootreg_addr = SMP_BOOTREG_ADDR,
 };
 
-enum realview_board_type {
-    BOARD_EB,
-    BOARD_EB_MPCORE,
-    BOARD_PB_A8,
-    BOARD_PBX_A9,
-};
-
 static void split_irq_from_named(DeviceState *src, const char* outname,
                                  qemu_irq out1, qemu_irq out2) {
     DeviceState *splitter = qdev_new(TYPE_SPLIT_IRQ);
@@ -75,8 +68,7 @@ static void split_irq_from_named(DeviceState *src, const char* outname,
                                 qdev_get_gpio_in(splitter, 0));
 }
 
-static void realview_init(MachineState *machine,
-                          enum realview_board_type board_type)
+static void realview_common_machine_init(MachineState *machine)
 {
     RealviewMachineClass *rmc = REALVIEW_MACHINE_GET_CLASS(machine);
     ARMCPU *cpu = NULL;
@@ -103,17 +95,6 @@ static void realview_init(MachineState *machine,
     ram_addr_t low_ram_size;
     ram_addr_t ram_size = machine->ram_size;
 
-    switch (board_type) {
-    case BOARD_EB:
-        break;
-    case BOARD_EB_MPCORE:
-        break;
-    case BOARD_PB_A8:
-        break;
-    case BOARD_PBX_A9:
-        break;
-    }
-
     for (n = 0; n < smp_cpus; n++) {
         Object *cpuobj = object_new(machine->cpu_type);
 
@@ -381,30 +362,11 @@ static void realview_init(MachineState *machine,
     arm_load_kernel(ARM_CPU(first_cpu), machine, &realview_binfo);
 }
 
-static void realview_eb_init(MachineState *machine)
-{
-    realview_init(machine, BOARD_EB);
-}
-
-static void realview_eb_mpcore_init(MachineState *machine)
-{
-    realview_init(machine, BOARD_EB_MPCORE);
-}
-
-static void realview_pb_a8_init(MachineState *machine)
-{
-    realview_init(machine, BOARD_PB_A8);
-}
-
-static void realview_pbx_a9_init(MachineState *machine)
-{
-    realview_init(machine, BOARD_PBX_A9);
-}
-
 static void realview_common_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
+    mc->init = realview_common_machine_init;
     mc->ignore_memory_transaction_failures = true;
 }
 
@@ -414,7 +376,6 @@ static void realview_eb_class_init(ObjectClass *oc, void *data)
     RealviewMachineClass *rmc = REALVIEW_MACHINE_CLASS(oc);
 
     mc->desc = "ARM RealView Emulation Baseboard (ARM926EJ-S)";
-    mc->init = realview_eb_init;
     mc->block_default_type = IF_SCSI;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm926");
     rmc->board_id = 0x33b;
@@ -426,7 +387,6 @@ static void realview_eb_mpcore_class_init(ObjectClass *oc, void *data)
     RealviewMachineClass *rmc = REALVIEW_MACHINE_CLASS(oc);
 
     mc->desc = "ARM RealView Emulation Baseboard (ARM11MPCore)";
-    mc->init = realview_eb_mpcore_init;
     mc->block_default_type = IF_SCSI;
     mc->max_cpus = 4;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm11mpcore");
@@ -440,7 +400,6 @@ static void realview_pb_a8_class_init(ObjectClass *oc, void *data)
     RealviewMachineClass *rmc = REALVIEW_MACHINE_CLASS(oc);
 
     mc->desc = "ARM RealView Platform Baseboard for Cortex-A8";
-    mc->init = realview_pb_a8_init;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a8");
     rmc->board_id = 0x769;
     rmc->is_pb = true;
@@ -453,7 +412,6 @@ static void realview_pbx_a9_class_init(ObjectClass *oc, void *data)
     RealviewMachineClass *rmc = REALVIEW_MACHINE_CLASS(oc);
 
     mc->desc = "ARM RealView Platform Baseboard Explore for Cortex-A9";
-    mc->init = realview_pbx_a9_init;
     mc->max_cpus = 4;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a9");
     rmc->board_id = 0x76d;
-- 
2.38.1


