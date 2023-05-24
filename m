Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D14AD70F9A8
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 17:03:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1pxt-0006VB-7g; Wed, 24 May 2023 10:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1pxl-0006Mg-7H
 for qemu-devel@nongnu.org; Wed, 24 May 2023 10:59:41 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1pxi-0006E9-5J
 for qemu-devel@nongnu.org; Wed, 24 May 2023 10:59:40 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-30a1fdde3d6so924128f8f.0
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 07:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684940376; x=1687532376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CfORvZBj5XwZqX1kEUcED15b0r2EiIZE5rk0MEhjkUo=;
 b=mq9JmfFVIPtMkazqFVBrVylL5+DHxpG5GJ4QiW7FgaaC9d400bIeiRKryf3Uexuf85
 avPFTOrfFNooiHadQFcUCWI+JgSPKvGMa0o5lQ2BwM5ZacfESNRffxQjjB94pBOvNOCb
 4GJfKMzezb+HmrbKepN0nRGAA6shDl2SvqRxPEkoBwOYibu4P4geCnPUpi1L/kMjf/Eg
 1zeKNdNbNCPnkkNgE4l17X1p+hQkOGYnKR2cFO9wnAuedj1Ly8UfrEqT5tykeR0+2m9l
 aNMKmFll2t67K8zyg0dHK8WtK82G431Qw4IjBGAfuyUBG19/HJM99vMlHQk1QGZHpp++
 pZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684940376; x=1687532376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CfORvZBj5XwZqX1kEUcED15b0r2EiIZE5rk0MEhjkUo=;
 b=FPvXhGoF1q+jVS0tJCa5VgxR44MIKuMLf0wHoBNbjwalVyPth8qIBoxnk8+jHC+rA+
 G5MJALuiKr25EI1CbHJUyDtkf2GFrfFxgiit+Nt9Wr5Q1HTE8uD/udbRlRYmzyLhH2cV
 3VK3yUHh+evtvHIcrDIWH1iD6lIrDOXTWAHZMViIp6WrUz1dVvT+aMCfCBj1sM/eOhBu
 9kYed+S0PIwp33Pl5pLlPLHcgNFxHVZWt9vXYZh8+wURgxVxHikHmjgNmyxcAuWL58wS
 BM26F9onSscoQRcKqaiTvnJGKYY0/3RTM/yEjovh9RfNWLp9AaBo/Xt8TCwLJxU89WLV
 97cw==
X-Gm-Message-State: AC+VfDzJSvn6ZClOmogc1QpUSeYhb1aTf35kzDAEqKYDYO0zX9mS2o90
 xS6WE5FJIkGnyR7O2ilZvW9T/NUt95hnGcb1jVAEaA==
X-Google-Smtp-Source: ACHHUZ51YxJ9h4vHHxxWjNXyWymAbvNYZ6zOmzmYLSCIhJ7MYfu77gWLQgYz9ix3Z3jb10hcsGfdnA==
X-Received: by 2002:a5d:6852:0:b0:2f9:4fe9:74bb with SMTP id
 o18-20020a5d6852000000b002f94fe974bbmr55626wrw.40.1684940376052; 
 Wed, 24 May 2023 07:59:36 -0700 (PDT)
Received: from localhost.localdomain
 (fac34-h02-176-184-31-193.dsl.sta.abo.bbox.fr. [176.184.31.193])
 by smtp.gmail.com with ESMTPSA id
 c14-20020a056000104e00b00307b5376b2csm14621462wrx.90.2023.05.24.07.59.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 May 2023 07:59:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 05/10] hw/arm/realview: Move 'board_id' to RealviewMachineClass
Date: Wed, 24 May 2023 16:59:01 +0200
Message-Id: <20230524145906.33156-6-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230524145906.33156-1-philmd@linaro.org>
References: <20230524145906.33156-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Instead of having each machine instance resolve its board ID,
set it once in their class_init() handler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/realview.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 6970e8a469..c354ce0cfa 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -32,6 +32,8 @@
 
 struct RealviewMachineClass {
     MachineClass parent_obj;
+
+    int board_id;
 };
 typedef struct RealviewMachineClass RealviewMachineClass;
 
@@ -49,7 +51,6 @@ static struct arm_boot_info realview_binfo = {
     .smp_bootreg_addr = SMP_BOOTREG_ADDR,
 };
 
-/* The following two lists must be consistent.  */
 enum realview_board_type {
     BOARD_EB,
     BOARD_EB_MPCORE,
@@ -57,13 +58,6 @@ enum realview_board_type {
     BOARD_PBX_A9,
 };
 
-static const int realview_board_id[] = {
-    0x33b,
-    0x33b,
-    0x769,
-    0x76d
-};
-
 static void split_irq_from_named(DeviceState *src, const char* outname,
                                  qemu_irq out1, qemu_irq out2) {
     DeviceState *splitter = qdev_new(TYPE_SPLIT_IRQ);
@@ -81,6 +75,7 @@ static void split_irq_from_named(DeviceState *src, const char* outname,
 static void realview_init(MachineState *machine,
                           enum realview_board_type board_type)
 {
+    RealviewMachineClass *rmc = REALVIEW_MACHINE_GET_CLASS(machine);
     ARMCPU *cpu = NULL;
     CPUARMState *env;
     MemoryRegion *sysmem = get_system_memory();
@@ -385,7 +380,7 @@ static void realview_init(MachineState *machine,
     memory_region_add_subregion(sysmem, SMP_BOOT_ADDR, ram_hack);
 
     realview_binfo.ram_size = ram_size;
-    realview_binfo.board_id = realview_board_id[board_type];
+    realview_binfo.board_id = rmc->board_id;
     realview_binfo.loader_start = (board_type == BOARD_PB_A8 ? 0x70000000 : 0);
     arm_load_kernel(ARM_CPU(first_cpu), machine, &realview_binfo);
 }
@@ -420,41 +415,49 @@ static void realview_common_class_init(ObjectClass *oc, void *data)
 static void realview_eb_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
+    RealviewMachineClass *rmc = REALVIEW_MACHINE_CLASS(oc);
 
     mc->desc = "ARM RealView Emulation Baseboard (ARM926EJ-S)";
     mc->init = realview_eb_init;
     mc->block_default_type = IF_SCSI;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm926");
+    rmc->board_id = 0x33b;
 }
 
 static void realview_eb_mpcore_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
+    RealviewMachineClass *rmc = REALVIEW_MACHINE_CLASS(oc);
 
     mc->desc = "ARM RealView Emulation Baseboard (ARM11MPCore)";
     mc->init = realview_eb_mpcore_init;
     mc->block_default_type = IF_SCSI;
     mc->max_cpus = 4;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm11mpcore");
+    rmc->board_id = 0x33b;
 }
 
 static void realview_pb_a8_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
+    RealviewMachineClass *rmc = REALVIEW_MACHINE_CLASS(oc);
 
     mc->desc = "ARM RealView Platform Baseboard for Cortex-A8";
     mc->init = realview_pb_a8_init;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a8");
+    rmc->board_id = 0x769;
 }
 
 static void realview_pbx_a9_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
+    RealviewMachineClass *rmc = REALVIEW_MACHINE_CLASS(oc);
 
     mc->desc = "ARM RealView Platform Baseboard Explore for Cortex-A9";
     mc->init = realview_pbx_a9_init;
     mc->max_cpus = 4;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a9");
+    rmc->board_id = 0x76d;
 }
 
 static const TypeInfo realview_machine_types[] = {
-- 
2.38.1


