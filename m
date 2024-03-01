Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BA286DE87
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Mar 2024 10:45:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfzML-0003K5-BB; Fri, 01 Mar 2024 04:39:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rfzMB-0003Hy-AM
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 04:39:11 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rfzM5-0006Op-Kc
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 04:39:07 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxOOgpouFlbD0TAA--.29209S3;
 Fri, 01 Mar 2024 17:38:49 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxDBMfouFlyZxLAA--.4871S19; 
 Fri, 01 Mar 2024 17:38:49 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, philmd@linaro.org,
 maobibo@loongson.cn, zhaotianrui@loongson.cn, lixianglai@loongson.cn,
 imammedo@redhat.com, anisinha@redhat.com, mst@redhat.com
Subject: [PATCH v5 17/17] hw/loongarch: Add cells missing from rtc node
Date: Fri,  1 Mar 2024 17:38:38 +0800
Message-Id: <20240301093839.663947-18-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240301093839.663947-1-gaosong@loongson.cn>
References: <20240301093839.663947-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxDBMfouFlyZxLAA--.4871S19
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
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

rtc node need interrupts and interrupt-parent cells.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/virt.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 5d92b2f1aa..6810f78ebd 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -195,7 +195,8 @@ static void fdt_add_flash_node(LoongArchMachineState *lams)
     g_free(nodename);
 }
 
-static void fdt_add_rtc_node(LoongArchMachineState *lams)
+static void fdt_add_rtc_node(LoongArchMachineState *lams,
+                             uint32_t *pch_pic_phandle)
 {
     char *nodename;
     hwaddr base = VIRT_RTC_REG_BASE;
@@ -204,8 +205,13 @@ static void fdt_add_rtc_node(LoongArchMachineState *lams)
 
     nodename = g_strdup_printf("/rtc@%" PRIx64, base);
     qemu_fdt_add_subnode(ms->fdt, nodename);
-    qemu_fdt_setprop_string(ms->fdt, nodename, "compatible", "loongson,ls7a-rtc");
+    qemu_fdt_setprop_string(ms->fdt, nodename, "compatible",
+                            "loongson,ls7a-rtc");
     qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg", 2, base, 2, size);
+    qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts",
+                           VIRT_RTC_IRQ - VIRT_GSI_BASE , 0x4);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "interrupt-parent",
+                          *pch_pic_phandle);
     g_free(nodename);
 }
 
@@ -611,7 +617,7 @@ static void loongarch_devices_init(DeviceState *pch_pic,
     sysbus_create_simple("ls7a_rtc", VIRT_RTC_REG_BASE,
                          qdev_get_gpio_in(pch_pic,
                          VIRT_RTC_IRQ - VIRT_GSI_BASE));
-    fdt_add_rtc_node(lams);
+    fdt_add_rtc_node(lams, pch_pic_phandle);
 
     /* acpi ged */
     lams->acpi_ged = create_acpi_ged(pch_pic, lams);
-- 
2.25.1


