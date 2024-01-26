Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C00EE83DB05
	for <lists+qemu-devel@lfdr.de>; Fri, 26 Jan 2024 14:35:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTMKE-0003z0-0I; Fri, 26 Jan 2024 08:32:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=5gEp=JE=kaod.org=clg@ozlabs.org>)
 id 1rTMK4-0003AI-AF; Fri, 26 Jan 2024 08:32:44 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=5gEp=JE=kaod.org=clg@ozlabs.org>)
 id 1rTMK1-00080i-T6; Fri, 26 Jan 2024 08:32:43 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TLzCC3P5Tz4wdD;
 Sat, 27 Jan 2024 00:32:39 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TLzC93H8vz4wny;
 Sat, 27 Jan 2024 00:32:37 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gavin Shan <gshan@redhat.com>
Subject: [PULL 06/17] hw/arm/aspeed: Check for CPU types in
 machine_run_board_init()
Date: Fri, 26 Jan 2024 14:32:05 +0100
Message-ID: <20240126133217.996306-7-clg@kaod.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126133217.996306-1-clg@kaod.org>
References: <20240126133217.996306-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=5gEp=JE=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Aspeed SoCs use a single CPU type (set as AspeedSoCClass::cpu_type).
Convert it to a NULL-terminated array (of a single non-NULL element).

Set MachineClass::valid_cpu_types[] to use the common machine code
to provide hints when the requested CPU is invalid (see commit
e702cbc19e ("machine: Improve is_cpu_type_supported()").

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 include/hw/arm/aspeed_soc.h |  3 ++-
 hw/arm/aspeed.c             |  1 +
 hw/arm/aspeed_ast10x0.c     |  6 +++++-
 hw/arm/aspeed_ast2400.c     | 12 ++++++++++--
 hw/arm/aspeed_ast2600.c     |  6 +++++-
 hw/arm/aspeed_soc_common.c  |  5 ++++-
 6 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index a060a5991874..0db5a41e7170 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -128,7 +128,8 @@ struct AspeedSoCClass {
     DeviceClass parent_class;
 
     const char *name;
-    const char *cpu_type;
+    /** valid_cpu_types: NULL terminated array of a single CPU type. */
+    const char * const *valid_cpu_types;
     uint32_t silicon_rev;
     uint64_t sram_size;
     uint64_t secsram_size;
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index d2d490a6d142..fc8355cdce14 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -1149,6 +1149,7 @@ static void aspeed_machine_class_init_cpus_defaults(MachineClass *mc)
     mc->default_cpus = sc->num_cpus;
     mc->min_cpus = sc->num_cpus;
     mc->max_cpus = sc->num_cpus;
+    mc->valid_cpu_types = sc->valid_cpu_types;
 }
 
 static void aspeed_machine_class_init(ObjectClass *oc, void *data)
diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
index dca601a3f9b6..c3b5116a6a9d 100644
--- a/hw/arm/aspeed_ast10x0.c
+++ b/hw/arm/aspeed_ast10x0.c
@@ -417,13 +417,17 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
 
 static void aspeed_soc_ast1030_class_init(ObjectClass *klass, void *data)
 {
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-m4"), /* TODO cortex-m4f */
+        NULL
+    };
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedSoCClass *sc = ASPEED_SOC_CLASS(dc);
 
     dc->realize = aspeed_soc_ast1030_realize;
 
     sc->name = "ast1030-a1";
-    sc->cpu_type = ARM_CPU_TYPE_NAME("cortex-m4"); /* TODO cortex-m4f */
+    sc->valid_cpu_types = valid_cpu_types;
     sc->silicon_rev = AST1030_A1_SILICON_REV;
     sc->sram_size = 0xc0000;
     sc->secsram_size = 0x40000; /* 256 * KiB */
diff --git a/hw/arm/aspeed_ast2400.c b/hw/arm/aspeed_ast2400.c
index 789e591f3ad0..c613e58144dd 100644
--- a/hw/arm/aspeed_ast2400.c
+++ b/hw/arm/aspeed_ast2400.c
@@ -502,6 +502,10 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
 
 static void aspeed_soc_ast2400_class_init(ObjectClass *oc, void *data)
 {
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("arm926"),
+        NULL
+    };
     AspeedSoCClass *sc = ASPEED_SOC_CLASS(oc);
     DeviceClass *dc = DEVICE_CLASS(oc);
 
@@ -510,7 +514,7 @@ static void aspeed_soc_ast2400_class_init(ObjectClass *oc, void *data)
     dc->user_creatable = false;
 
     sc->name         = "ast2400-a1";
-    sc->cpu_type     = ARM_CPU_TYPE_NAME("arm926");
+    sc->valid_cpu_types = valid_cpu_types;
     sc->silicon_rev  = AST2400_A1_SILICON_REV;
     sc->sram_size    = 0x8000;
     sc->spis_num     = 1;
@@ -526,6 +530,10 @@ static void aspeed_soc_ast2400_class_init(ObjectClass *oc, void *data)
 
 static void aspeed_soc_ast2500_class_init(ObjectClass *oc, void *data)
 {
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("arm1176"),
+        NULL
+    };
     AspeedSoCClass *sc = ASPEED_SOC_CLASS(oc);
     DeviceClass *dc = DEVICE_CLASS(oc);
 
@@ -534,7 +542,7 @@ static void aspeed_soc_ast2500_class_init(ObjectClass *oc, void *data)
     dc->user_creatable = false;
 
     sc->name         = "ast2500-a1";
-    sc->cpu_type     = ARM_CPU_TYPE_NAME("arm1176");
+    sc->valid_cpu_types = valid_cpu_types;
     sc->silicon_rev  = AST2500_A1_SILICON_REV;
     sc->sram_size    = 0x9000;
     sc->spis_num     = 2;
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 589a4a6eea10..24541b5284d4 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -628,13 +628,17 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
 
 static void aspeed_soc_ast2600_class_init(ObjectClass *oc, void *data)
 {
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-a7"),
+        NULL
+    };
     DeviceClass *dc = DEVICE_CLASS(oc);
     AspeedSoCClass *sc = ASPEED_SOC_CLASS(oc);
 
     dc->realize      = aspeed_soc_ast2600_realize;
 
     sc->name         = "ast2600-a3";
-    sc->cpu_type     = ARM_CPU_TYPE_NAME("cortex-a7");
+    sc->valid_cpu_types = valid_cpu_types;
     sc->silicon_rev  = AST2600_A3_SILICON_REV;
     sc->sram_size    = 0x16400;
     sc->spis_num     = 2;
diff --git a/hw/arm/aspeed_soc_common.c b/hw/arm/aspeed_soc_common.c
index 36ca189ce960..123a0c432cfd 100644
--- a/hw/arm/aspeed_soc_common.c
+++ b/hw/arm/aspeed_soc_common.c
@@ -20,7 +20,10 @@
 
 const char *aspeed_soc_cpu_type(AspeedSoCClass *sc)
 {
-    return sc->cpu_type;
+    assert(sc->valid_cpu_types);
+    assert(sc->valid_cpu_types[0]);
+    assert(!sc->valid_cpu_types[1]);
+    return sc->valid_cpu_types[0];
 }
 
 qemu_irq aspeed_soc_get_irq(AspeedSoCState *s, int dev)
-- 
2.43.0


