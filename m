Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A34C70F98B
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 17:01:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1pxz-0006cA-F3; Wed, 24 May 2023 10:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1pxt-0006XD-VE
 for qemu-devel@nongnu.org; Wed, 24 May 2023 10:59:49 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1pxs-0006Wd-8b
 for qemu-devel@nongnu.org; Wed, 24 May 2023 10:59:49 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3f42ba32e24so9283605e9.3
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 07:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684940386; x=1687532386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oFNQ0ujjXIJFfhKAnMzFQFaSo5jFHy/7Nt5oxClCYqE=;
 b=VBGF3GLN8LqGOK5xgXvZTNUmB6OxS3Ja5TjqS3poPLOoF7QtZUM4ZDqy8TNunTgBiz
 2ZtP322fZ/nny2lmW6SMa626uRx+eOjfjyfsg0Cm7ThI4epvuYsaYERBNSsj3MWZNyXL
 mxSYX32DE9dkmtg/f6MXe9VR0JE/3YSBuGPCfcbWhTmvAJjrETYG0J3srJ+uiyDcZDGr
 beRRjMKJNIm8FYGGs5e2i86Sot6uy0Ty+wr2M+t8l6vyq1lShp2Amp1l78FpgNvN8BOg
 v/B5GWQlnkGtSh9TffxfE4G1MtGrTZNDlFOcqIfkq5ZAeLtWdTuIZee1yS/xqZ45x+0b
 CkRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684940386; x=1687532386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oFNQ0ujjXIJFfhKAnMzFQFaSo5jFHy/7Nt5oxClCYqE=;
 b=cPzx8nLh43kK8aLT4iHCtdoXWmk1Tz9V1AkOvSQvH4gel95k4GTy9tnQyAbpXZ+GPr
 EsxwZFRE9aCDSrz9ujubP7bas3DvQuZB5ySl7y+c90WLzaqdNEhhktu053bLYZQacbIZ
 /E7YpwinKnV/0Ttn/syPmyjL8eDnmoUHkEoyKGoD+WFgk5OkNSDnbrk/nqcehGu5/tKi
 W6apKTqMgWd7W80aiaPHCvwEOvhp/nwrl1kM4Mdj41ynKoJ6XmmORD+gCTGkfnNLfY3j
 cHMSUlEgEg6crMNLZ8KD4VOeMr3Z29HjFQI9RjCbnsvHsrpkd+NN5zkH0f/lvPI1oBG3
 HlXA==
X-Gm-Message-State: AC+VfDzZHGxJMwTR21ah9aJxQHbkY3LKBBlMbRovyLMW66FzD1XqSTrb
 kt+RiNdLoFVKE2ko3UXJDqBQR0y9sADUTquf/vA6HA==
X-Google-Smtp-Source: ACHHUZ7wtoLUL+58fCrMnC1VI2KeePDgqvyE3ZosLFsOPKj7gf+tWOO/0AlJf/8ei5JPri32ShOUIQ==
X-Received: by 2002:a1c:4b03:0:b0:3f6:41f:5a68 with SMTP id
 y3-20020a1c4b03000000b003f6041f5a68mr17906wma.29.1684940386542; 
 Wed, 24 May 2023 07:59:46 -0700 (PDT)
Received: from localhost.localdomain
 (fac34-h02-176-184-31-193.dsl.sta.abo.bbox.fr. [176.184.31.193])
 by smtp.gmail.com with ESMTPSA id
 o4-20020a05600c378400b003f6050d35c9sm2608530wmr.20.2023.05.24.07.59.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 May 2023 07:59:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 07/10] hw/arm/realview: Move 'mpcore_periphbase' to
 RealviewMachineClass
Date: Wed, 24 May 2023 16:59:03 +0200
Message-Id: <20230524145906.33156-8-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230524145906.33156-1-philmd@linaro.org>
References: <20230524145906.33156-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Instead of having each machine instance resolve whether it is
MPCORE based and its peripheral base address, set it once in
their class_init() handler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/realview.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 1a3a64e0ce..8a3b5a48b1 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -35,6 +35,7 @@ struct RealviewMachineClass {
 
     int board_id;
     bool is_pb;
+    hwaddr mpcore_periphbase;
 };
 typedef struct RealviewMachineClass RealviewMachineClass;
 
@@ -94,26 +95,21 @@ static void realview_init(MachineState *machine,
     int n;
     unsigned int smp_cpus = machine->smp.cpus;
     qemu_irq cpu_irq[4];
-    int is_mpcore = 0;
+    bool is_mpcore = rmc->mpcore_periphbase != 0;
     bool is_pb = rmc->is_pb;
     uint32_t proc_id = 0;
     uint32_t sys_id;
     ram_addr_t low_ram_size;
     ram_addr_t ram_size = machine->ram_size;
-    hwaddr periphbase = 0;
 
     switch (board_type) {
     case BOARD_EB:
         break;
     case BOARD_EB_MPCORE:
-        is_mpcore = 1;
-        periphbase = 0x10100000;
         break;
     case BOARD_PB_A8:
         break;
     case BOARD_PBX_A9:
-        is_mpcore = 1;
-        periphbase = 0x1f000000;
         break;
     }
 
@@ -129,8 +125,8 @@ static void realview_init(MachineState *machine,
         }
 
         if (is_pb && is_mpcore) {
-            object_property_set_int(cpuobj, "reset-cbar", periphbase,
-                                    &error_fatal);
+            object_property_set_int(cpuobj, "reset-cbar",
+                                    rmc->mpcore_periphbase, &error_fatal);
         }
 
         qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
@@ -191,13 +187,13 @@ static void realview_init(MachineState *machine,
         qdev_prop_set_uint32(dev, "num-cpu", smp_cpus);
         busdev = SYS_BUS_DEVICE(dev);
         sysbus_realize_and_unref(busdev, &error_fatal);
-        sysbus_mmio_map(busdev, 0, periphbase);
+        sysbus_mmio_map(busdev, 0, rmc->mpcore_periphbase);
         for (n = 0; n < smp_cpus; n++) {
             sysbus_connect_irq(busdev, n, cpu_irq[n]);
         }
-        sysbus_create_varargs("l2x0", periphbase + 0x2000, NULL);
+        sysbus_create_varargs("l2x0", rmc->mpcore_periphbase + 0x2000, NULL);
         /* Both A9 and 11MPCore put the GIC CPU i/f at base + 0x100 */
-        realview_binfo.gic_cpu_if_addr = periphbase + 0x100;
+        realview_binfo.gic_cpu_if_addr = rmc->mpcore_periphbase + 0x100;
     } else {
         uint32_t gic_addr = is_pb ? 0x1e000000 : 0x10040000;
         /* For now just create the nIRQ GIC, and ignore the others.  */
@@ -434,6 +430,7 @@ static void realview_eb_mpcore_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 4;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm11mpcore");
     rmc->board_id = 0x33b;
+    rmc->mpcore_periphbase = 0x10100000;
 }
 
 static void realview_pb_a8_class_init(ObjectClass *oc, void *data)
@@ -459,6 +456,7 @@ static void realview_pbx_a9_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a9");
     rmc->board_id = 0x76d;
     rmc->is_pb = true;
+    rmc->mpcore_periphbase = 0x1f000000;
 }
 
 static const TypeInfo realview_machine_types[] = {
-- 
2.38.1


