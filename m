Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B64428CFAE5
	for <lists+qemu-devel@lfdr.de>; Mon, 27 May 2024 10:05:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBVLR-0003uZ-GZ; Mon, 27 May 2024 04:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sBVKk-0001fg-Mk; Mon, 27 May 2024 04:03:54 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sBVKi-0005H2-W2; Mon, 27 May 2024 04:03:54 -0400
Received: from TWMBX02.aspeed.com (192.168.0.24) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Mon, 27 May
 2024 16:02:39 +0800
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 27 May
 2024 16:02:40 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 27 May 2024 16:02:38 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>,
 Cleber Rosa <crosa@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <yunlin.tang@aspeedtech.com>
Subject: [PATCH v4 14/16] aspeed/soc: fix incorrect dram size for AST2700
Date: Mon, 27 May 2024 16:02:28 +0800
Message-ID: <20240527080231.1576609-15-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240527080231.1576609-1-jamin_lin@aspeedtech.com>
References: <20240527080231.1576609-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: Fail (TWMBX02.aspeed.com: domain of jamin_lin@aspeedtech.com
 does not designate 192.168.10.10 as permitted sender)
 receiver=TWMBX02.aspeed.com; client-ip=192.168.10.10;
 helo=localhost.localdomain;
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_FAIL=0.001,
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

AST2700 dram size calculation is not back compatible AST2600.
According to the DDR capacity hardware behavior,
if users write the data to address which is beyond the ram size,
it would write the data to address 0.
For example:
a. sdram base address "0x4 00000000"
b. sdram size is 1 GiB
The available address range is from "0x4 00000000" to "0x4 40000000".
If users write 0xdeadbeef to address "0x6 00000000",
the value of DRAM address 0 (base address 0x4 00000000) should be 0xdeadbeef.

Add aspeed_soc_ast2700_dram_init to calculate the dram size and add
memory I/O whose address range is from max_ram_size - ram_size to max_ram_size
and its read/write handler to emulate DDR capacity hardware behavior.

Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/arm/aspeed_ast27x0.c     | 94 ++++++++++++++++++++++++++++++++++++-
 include/hw/arm/aspeed_soc.h |  1 +
 2 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index a3a03fc1ca..19380087fa 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -20,6 +20,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/intc/arm_gicv3.h"
 #include "qapi/qmp/qlist.h"
+#include "qemu/log.h"
 
 static const hwaddr aspeed_soc_ast2700_memmap[] = {
     [ASPEED_DEV_SPI_BOOT]  =  0x400000000,
@@ -191,6 +192,97 @@ static qemu_irq aspeed_soc_ast2700_get_irq(AspeedSoCState *s, int dev)
     return qdev_get_gpio_in(a->intc.gic, sc->irqmap[dev]);
 }
 
+static uint64_t aspeed_ram_capacity_read(void *opaque, hwaddr addr,
+                                                    unsigned int size)
+{
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "%s: read @%" PRIx64 " out of ram size\n",
+                   __func__, addr);
+    return 0;
+}
+
+static void aspeed_ram_capacity_write(void *opaque, hwaddr addr, uint64_t data,
+                                                unsigned int size)
+{
+    AspeedSoCState *s = ASPEED_SOC(opaque);
+    uint32_t test_pattern = 0xdeadbeef;
+    bool invalid_pattern = true;
+    uint32_t *ram_ptr;
+    int sz;
+
+    ram_ptr = memory_region_get_ram_ptr(s->dram_mr);
+
+   /*
+    * Emulate ddr capacity hardware behavior.
+    * If writes the test_pattern to address which is beyond the ram size,
+    * it would write the test_pattern to address 0.
+    */
+    for (sz = 4; sz > 0 ; sz--) {
+        test_pattern = (test_pattern << 4) + sz;
+        if (data == test_pattern) {
+            ram_ptr[0] = test_pattern;
+            invalid_pattern = false;
+            break;
+        }
+    }
+
+    if (invalid_pattern) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: write invalid pattern @%" PRIx64
+                      " to addr @%" HWADDR_PRIx "]\n",
+                      __func__, data, addr);
+    }
+}
+
+static const MemoryRegionOps aspeed_ram_capacity_ops = {
+    .read = aspeed_ram_capacity_read,
+    .write = aspeed_ram_capacity_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+    },
+};
+
+/*
+ * SDMC should be realized first to get correct RAM size and max size
+ * values
+ */
+static bool aspeed_soc_ast2700_dram_init(DeviceState *dev, Error **errp)
+{
+    ram_addr_t ram_size, max_ram_size;
+    Aspeed27x0SoCState *a = ASPEED27X0_SOC(dev);
+    AspeedSoCState *s = ASPEED_SOC(dev);
+    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
+
+    ram_size = object_property_get_uint(OBJECT(&s->sdmc), "ram-size",
+                                        &error_abort);
+    max_ram_size = object_property_get_uint(OBJECT(&s->sdmc), "max-ram-size",
+                                            &error_abort);
+
+    memory_region_init(&s->dram_container, OBJECT(s), "ram-container",
+                       ram_size);
+    memory_region_add_subregion(&s->dram_container, 0, s->dram_mr);
+
+    /*
+     * Add a memory region beyond the RAM region to emulate
+     * ddr capacity hardware behavior.
+     */
+    if (ram_size < max_ram_size) {
+        memory_region_init_io(&a->dram_empty, OBJECT(s),
+                              &aspeed_ram_capacity_ops, s,
+                              "ram-empty", max_ram_size - ram_size);
+
+        memory_region_add_subregion(s->memory,
+                                    sc->memmap[ASPEED_DEV_SDRAM] + ram_size,
+                                    &a->dram_empty);
+    }
+
+    memory_region_add_subregion(s->memory,
+                      sc->memmap[ASPEED_DEV_SDRAM], &s->dram_container);
+    return true;
+}
+
 static void aspeed_soc_ast2700_init(Object *obj)
 {
     Aspeed27x0SoCState *a = ASPEED27X0_SOC(obj);
@@ -461,7 +553,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
                     sc->memmap[ASPEED_DEV_SDMC]);
 
     /* RAM */
-    if (!aspeed_soc_dram_init(s, errp)) {
+    if (!aspeed_soc_ast2700_dram_init(dev, errp)) {
         return;
     }
 
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 9f177b6037..9dbf48f873 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -127,6 +127,7 @@ struct Aspeed27x0SoCState {
 
     ARMCPU cpu[ASPEED_CPUS_NUM];
     AspeedINTCState intc;
+    MemoryRegion dram_empty;
 };
 
 #define TYPE_ASPEED27X0_SOC "aspeed27x0-soc"
-- 
2.25.1


