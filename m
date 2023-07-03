Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62101746594
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 00:03:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGRdM-0003aZ-Kz; Mon, 03 Jul 2023 18:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qGRdJ-0003Yu-Tt; Mon, 03 Jul 2023 18:02:57 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qGRdI-0004AR-8O; Mon, 03 Jul 2023 18:02:57 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id E793A748A5D;
 Tue,  4 Jul 2023 00:02:38 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id CA896748A4D; Tue,  4 Jul 2023 00:02:38 +0200 (CEST)
Message-Id: <5e350d971da005648f2e1673f164d5763b978101.1688421085.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1688421085.git.balaton@eik.bme.hu>
References: <cover.1688421085.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 06/13] sam460ex: Remove address_space_mem local variable
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Tue,  4 Jul 2023 00:02:38 +0200 (CEST)
X-Spam-Probability: 8%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Some places already use  get_system_memory() directly so replace the
remaining uses and drop the local variable.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/sam460ex.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index aaa8d2f4a5..f098226974 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -266,7 +266,6 @@ static void main_cpu_reset(void *opaque)
 
 static void sam460ex_init(MachineState *machine)
 {
-    MemoryRegion *address_space_mem = get_system_memory();
     MemoryRegion *isa = g_new(MemoryRegion, 1);
     MemoryRegion *l2cache_ram = g_new(MemoryRegion, 1);
     DeviceState *uic[4];
@@ -406,7 +405,8 @@ static void sam460ex_init(MachineState *machine)
     /* FIXME: remove this after fixing l2sram mapping in ppc440_uc.c? */
     memory_region_init_ram(l2cache_ram, NULL, "ppc440.l2cache_ram", 256 * KiB,
                            &error_abort);
-    memory_region_add_subregion(address_space_mem, 0x400000000LL, l2cache_ram);
+    memory_region_add_subregion(get_system_memory(), 0x400000000LL,
+                                l2cache_ram);
 
     /* USB */
     sysbus_create_simple(TYPE_PPC4xx_EHCI, 0x4bffd0400,
@@ -444,13 +444,13 @@ static void sam460ex_init(MachineState *machine)
     /* SoC has 4 UARTs
      * but board has only one wired and two are present in fdt */
     if (serial_hd(0) != NULL) {
-        serial_mm_init(address_space_mem, 0x4ef600300, 0,
+        serial_mm_init(get_system_memory(), 0x4ef600300, 0,
                        qdev_get_gpio_in(uic[1], 1),
                        PPC_SERIAL_MM_BAUDBASE, serial_hd(0),
                        DEVICE_BIG_ENDIAN);
     }
     if (serial_hd(1) != NULL) {
-        serial_mm_init(address_space_mem, 0x4ef600400, 0,
+        serial_mm_init(get_system_memory(), 0x4ef600400, 0,
                        qdev_get_gpio_in(uic[0], 1),
                        PPC_SERIAL_MM_BAUDBASE, serial_hd(1),
                        DEVICE_BIG_ENDIAN);
-- 
2.30.9


