Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D4A809F12
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 10:16:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBWvz-00018G-E2; Fri, 08 Dec 2023 04:14:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rBWvx-000178-7l
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 04:14:09 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rBWvs-0008Mm-O7
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 04:14:09 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxyOhP3nJlzOw_AA--.26423S3;
 Fri, 08 Dec 2023 17:13:51 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxH91A3nJlrE5YAA--.822S19; 
 Fri, 08 Dec 2023 17:13:51 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, peter.maydell@linaro.org,
 maobibo@loongson.cn
Subject: [PATCH v1 17/17] hw/loongarch: Add cells missing from rtc node
Date: Fri,  8 Dec 2023 17:00:42 +0800
Message-Id: <20231208090042.2672425-18-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231208090042.2672425-1-gaosong@loongson.cn>
References: <20231208090042.2672425-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxH91A3nJlrE5YAA--.822S19
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
 hw/loongarch/virt.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index bd1db2de4f..eb568c71cf 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -203,7 +203,8 @@ static void fdt_add_flash_node(LoongArchMachineState *lams)
     g_free(nodename);
 }
 
-static void fdt_add_rtc_node(LoongArchMachineState *lams)
+static void fdt_add_rtc_node(LoongArchMachineState *lams,
+                             uint32_t *pch_pic_phandle)
 {
     char *nodename;
     hwaddr base = VIRT_RTC_REG_BASE;
@@ -212,8 +213,13 @@ static void fdt_add_rtc_node(LoongArchMachineState *lams)
 
     nodename = g_strdup_printf("/rtc@%" PRIx64, base);
     qemu_fdt_add_subnode(ms->fdt, nodename);
-    qemu_fdt_setprop_string(ms->fdt, nodename, "compatible", "loongson,ls7a-rtc");
-    qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg", 2, base, 2, size);
+    qemu_fdt_setprop_string(ms->fdt, nodename, "compatible",
+                            "loongson,ls7a-rtc");
+    qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg", 0, base, 0, size);
+    qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts",
+                           VIRT_RTC_IRQ - VIRT_GSI_BASE , 0x4);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "interrupt-parent",
+                          *pch_pic_phandle);
     g_free(nodename);
 }
 
@@ -617,7 +623,7 @@ static void loongarch_devices_init(DeviceState *pch_pic,
     sysbus_create_simple("ls7a_rtc", VIRT_RTC_REG_BASE,
                          qdev_get_gpio_in(pch_pic,
                          VIRT_RTC_IRQ - VIRT_GSI_BASE));
-    fdt_add_rtc_node(lams);
+    fdt_add_rtc_node(lams, pch_pic_phandle);
 
     /* acpi ged */
     lams->acpi_ged = create_acpi_ged(pch_pic, lams);
-- 
2.25.1


