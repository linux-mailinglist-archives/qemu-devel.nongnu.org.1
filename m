Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEDA7081E1
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 14:54:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzd6a-0004IP-JL; Thu, 18 May 2023 08:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd6U-0004E4-11
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:34 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd6N-00082J-Uw
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:33 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3f42d937d61so19244045e9.3
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 05:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684414281; x=1687006281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jCWIoWT3Hd3TR8fGxUvKYcgsnVLN9JfO4nlSuLHIiD0=;
 b=IRUibtPNX3glYBL073WskxCsUs4AM63lHDSxn/eAvv+ei4AmEfNOMhPjzt87aMs6MG
 0yya7cMwPFt19Wfbl7kCNKzEKrJVJhMJwMIg0rwbeecBbud+9mPuvpnmIbWtrQs6NxDQ
 JG1ERU0DYeUft6iH+gbcT1uCzTEhHu0G7lDCF1pQjA7iAGdR6r2SIUJMR1A1MNNjtLXq
 dV2BHL2IyBCuzMcBK3IyU/YmWyaWVBqRD4hbd3+YdEtXnBt2O8FhrV14tOr335a5Ex3t
 f8qyx1JLaaAh4E0cGT0DeZyf16owjYewdcMKwk/FwiCJx1sDat/9mnXp4nb0xgfmN5L3
 pZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684414281; x=1687006281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jCWIoWT3Hd3TR8fGxUvKYcgsnVLN9JfO4nlSuLHIiD0=;
 b=XyhSLP/YTtCO5U+Flri/rNtjOyYAyFV1vW0JGXo2aA/RNIRVxIV3kNc+RPz7wATKLr
 Tu+qZE7qq5k8pvAR0XFfzRj3jk4hl7fAe1B92dfF7Byu004V4VkStYuhReOqLTAQNK/L
 8pP/lRG+jH2Ov7YdMCe4CWxIvWhe22ixYT436pYLhEbI8iDmuLEwxDLgIFVs8CH2gnql
 0xUd9CyByfQjl0qiS57pGnQb1v0cEhy1qmEoK3DMnOONPsznKeTGIr1x00roROgZrtCh
 UA6vZHWS23y4gvvP6b6wZV1oT55b6RyWFEZuQKMUe2ixKvoZWimM+gEZFlTjYlRMGBDs
 Xeww==
X-Gm-Message-State: AC+VfDzYASOUi3Tmpl1VCywcyTThPs11FceM7uGp/bd//nkMdYSIQjho
 rYgAD7udH0JUYEGkG+H3sLLQ6sq7z3WcGOq20PU=
X-Google-Smtp-Source: ACHHUZ4/RTsisPl1zGxGaPWmv2C8EPktsJ98b6UUYR5L5+S50Rh+zAJpwacc3csZXdTwIv5MZcJZ8Q==
X-Received: by 2002:a7b:cc84:0:b0:3f5:54f:b1b2 with SMTP id
 p4-20020a7bcc84000000b003f5054fb1b2mr1517166wma.37.1684414281534; 
 Thu, 18 May 2023 05:51:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z21-20020a1c4c15000000b003f42d2f4531sm5201321wmf.48.2023.05.18.05.51.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 05:51:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/29] hw/arm/vexpress: Avoid trivial memory leak of
 'flashalias'
Date: Thu, 18 May 2023 13:51:06 +0100
Message-Id: <20230518125107.146421-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518125107.146421-1-peter.maydell@linaro.org>
References: <20230518125107.146421-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

In the vexpress board code, we allocate a new MemoryRegion at the top
of vexpress_common_init() but only set it up and use it inside the
"if (map[VE_NORFLASHALIAS] != -1)" conditional, so we leak it if not.
This isn't a very interesting leak as it's a tiny amount of memory
once at startup, but it's easy to fix.

We could silence Coverity simply by moving the g_new() into the
if() block, but this use of g_new(MemoryRegion, 1) is a legacy from
when this board model was originally written; we wouldn't do that
if we wrote it today. The MemoryRegions are conceptually a part of
the board and must not go away until the whole board is done with
(at the end of the simulation), so they belong in its state struct.

This machine already has a VexpressMachineState struct that extends
MachineState, so statically put the MemoryRegions in there instead of
dynamically allocating them separately at runtime.

Spotted by Coverity (CID 1509083).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20230512170223.3801643-3-peter.maydell@linaro.org
---
 hw/arm/vexpress.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 34b012b528b..56abadd9b8b 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -173,6 +173,11 @@ struct VexpressMachineClass {
 
 struct VexpressMachineState {
     MachineState parent;
+    MemoryRegion vram;
+    MemoryRegion sram;
+    MemoryRegion flashalias;
+    MemoryRegion lowram;
+    MemoryRegion a15sram;
     bool secure;
     bool virt;
 };
@@ -182,7 +187,7 @@ struct VexpressMachineState {
 #define TYPE_VEXPRESS_A15_MACHINE   MACHINE_TYPE_NAME("vexpress-a15")
 OBJECT_DECLARE_TYPE(VexpressMachineState, VexpressMachineClass, VEXPRESS_MACHINE)
 
-typedef void DBoardInitFn(const VexpressMachineState *machine,
+typedef void DBoardInitFn(VexpressMachineState *machine,
                           ram_addr_t ram_size,
                           const char *cpu_type,
                           qemu_irq *pic);
@@ -263,14 +268,13 @@ static void init_cpus(MachineState *ms, const char *cpu_type,
     }
 }
 
-static void a9_daughterboard_init(const VexpressMachineState *vms,
+static void a9_daughterboard_init(VexpressMachineState *vms,
                                   ram_addr_t ram_size,
                                   const char *cpu_type,
                                   qemu_irq *pic)
 {
     MachineState *machine = MACHINE(vms);
     MemoryRegion *sysmem = get_system_memory();
-    MemoryRegion *lowram = g_new(MemoryRegion, 1);
     ram_addr_t low_ram_size;
 
     if (ram_size > 0x40000000) {
@@ -287,9 +291,9 @@ static void a9_daughterboard_init(const VexpressMachineState *vms,
      * address space should in theory be remappable to various
      * things including ROM or RAM; we always map the RAM there.
      */
-    memory_region_init_alias(lowram, NULL, "vexpress.lowmem", machine->ram,
-                             0, low_ram_size);
-    memory_region_add_subregion(sysmem, 0x0, lowram);
+    memory_region_init_alias(&vms->lowram, NULL, "vexpress.lowmem",
+                             machine->ram, 0, low_ram_size);
+    memory_region_add_subregion(sysmem, 0x0, &vms->lowram);
     memory_region_add_subregion(sysmem, 0x60000000, machine->ram);
 
     /* 0x1e000000 A9MPCore (SCU) private memory region */
@@ -348,14 +352,13 @@ static VEDBoardInfo a9_daughterboard = {
     .init = a9_daughterboard_init,
 };
 
-static void a15_daughterboard_init(const VexpressMachineState *vms,
+static void a15_daughterboard_init(VexpressMachineState *vms,
                                    ram_addr_t ram_size,
                                    const char *cpu_type,
                                    qemu_irq *pic)
 {
     MachineState *machine = MACHINE(vms);
     MemoryRegion *sysmem = get_system_memory();
-    MemoryRegion *sram = g_new(MemoryRegion, 1);
 
     {
         /* We have to use a separate 64 bit variable here to avoid the gcc
@@ -386,9 +389,9 @@ static void a15_daughterboard_init(const VexpressMachineState *vms,
     /* 0x2b060000: SP805 watchdog: not modelled */
     /* 0x2b0a0000: PL341 dynamic memory controller: not modelled */
     /* 0x2e000000: system SRAM */
-    memory_region_init_ram(sram, NULL, "vexpress.a15sram", 0x10000,
+    memory_region_init_ram(&vms->a15sram, NULL, "vexpress.a15sram", 0x10000,
                            &error_fatal);
-    memory_region_add_subregion(sysmem, 0x2e000000, sram);
+    memory_region_add_subregion(sysmem, 0x2e000000, &vms->a15sram);
 
     /* 0x7ffb0000: DMA330 DMA controller: not modelled */
     /* 0x7ffd0000: PL354 static memory controller: not modelled */
@@ -547,10 +550,6 @@ static void vexpress_common_init(MachineState *machine)
     I2CBus *i2c;
     ram_addr_t vram_size, sram_size;
     MemoryRegion *sysmem = get_system_memory();
-    MemoryRegion *vram = g_new(MemoryRegion, 1);
-    MemoryRegion *sram = g_new(MemoryRegion, 1);
-    MemoryRegion *flashalias = g_new(MemoryRegion, 1);
-    MemoryRegion *flash0mem;
     const hwaddr *map = daughterboard->motherboard_map;
     int i;
 
@@ -662,24 +661,25 @@ static void vexpress_common_init(MachineState *machine)
 
     if (map[VE_NORFLASHALIAS] != -1) {
         /* Map flash 0 as an alias into low memory */
+        MemoryRegion *flash0mem;
         flash0mem = sysbus_mmio_get_region(SYS_BUS_DEVICE(pflash0), 0);
-        memory_region_init_alias(flashalias, NULL, "vexpress.flashalias",
+        memory_region_init_alias(&vms->flashalias, NULL, "vexpress.flashalias",
                                  flash0mem, 0, VEXPRESS_FLASH_SIZE);
-        memory_region_add_subregion(sysmem, map[VE_NORFLASHALIAS], flashalias);
+        memory_region_add_subregion(sysmem, map[VE_NORFLASHALIAS], &vms->flashalias);
     }
 
     dinfo = drive_get(IF_PFLASH, 0, 1);
     ve_pflash_cfi01_register(map[VE_NORFLASH1], "vexpress.flash1", dinfo);
 
     sram_size = 0x2000000;
-    memory_region_init_ram(sram, NULL, "vexpress.sram", sram_size,
+    memory_region_init_ram(&vms->sram, NULL, "vexpress.sram", sram_size,
                            &error_fatal);
-    memory_region_add_subregion(sysmem, map[VE_SRAM], sram);
+    memory_region_add_subregion(sysmem, map[VE_SRAM], &vms->sram);
 
     vram_size = 0x800000;
-    memory_region_init_ram(vram, NULL, "vexpress.vram", vram_size,
+    memory_region_init_ram(&vms->vram, NULL, "vexpress.vram", vram_size,
                            &error_fatal);
-    memory_region_add_subregion(sysmem, map[VE_VIDEORAM], vram);
+    memory_region_add_subregion(sysmem, map[VE_VIDEORAM], &vms->vram);
 
     /* 0x4e000000 LAN9118 Ethernet */
     if (nd_table[0].used) {
-- 
2.34.1


