Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FEF809F11
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 10:16:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBWvw-00015p-KJ; Fri, 08 Dec 2023 04:14:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rBWvg-00011m-Gl
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 04:13:52 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rBWvc-0008Ed-Ey
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 04:13:52 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxqOhE3nJlqew_AA--.26306S3;
 Fri, 08 Dec 2023 17:13:40 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxH91A3nJlrE5YAA--.822S6; 
 Fri, 08 Dec 2023 17:13:39 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, peter.maydell@linaro.org,
 maobibo@loongson.cn
Subject: [PATCH v1 04/17] hw/loongarch: Add slave cpu boot_code
Date: Fri,  8 Dec 2023 17:00:29 +0800
Message-Id: <20231208090042.2672425-5-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231208090042.2672425-1-gaosong@loongson.cn>
References: <20231208090042.2672425-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxH91A3nJlrE5YAA--.822S6
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

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/boot.c | 66 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index b3fbed2ea0..742a70b7f0 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -14,6 +14,62 @@
 #include "qemu/error-report.h"
 #include "sysemu/reset.h"
 
+enum {
+    SLAVE_BOOT,
+};
+
+static const MemMapEntry loader_rommap[] = {
+    [SLAVE_BOOT] = {0xf100000, 0x10000},
+};
+
+static unsigned int slave_boot_code[] = {
+                  /* Configure reset ebase.         */
+    0x0400302c,   /* csrwr      $r12,0xc            */
+
+                  /* Disable interrupt.             */
+    0x0380100c,   /* ori        $r12,$r0,0x4        */
+    0x04000180,   /* csrxchg    $r0,$r12,0x0        */
+
+                  /* Clear mailbox.                 */
+    0x1400002d,   /* lu12i.w    $r13,1(0x1)         */
+    0x038081ad,   /* ori        $r13,$r13,0x20      */
+    0x06481da0,   /* iocsrwr.d  $r0,$r13            */
+
+                  /* Enable IPI interrupt.          */
+    0x1400002c,   /* lu12i.w    $r12,1(0x1)         */
+    0x0400118c,   /* csrxchg    $r12,$r12,0x4       */
+    0x02fffc0c,   /* addi.d     $r12,$r0,-1(0xfff)  */
+    0x1400002d,   /* lu12i.w    $r13,1(0x1)         */
+    0x038011ad,   /* ori        $r13,$r13,0x4       */
+    0x064819ac,   /* iocsrwr.w  $r12,$r13           */
+    0x1400002d,   /* lu12i.w    $r13,1(0x1)         */
+    0x038081ad,   /* ori        $r13,$r13,0x20      */
+
+                  /* Wait for wakeup  <.L11>:       */
+    0x06488000,   /* idle       0x0                 */
+    0x03400000,   /* andi       $r0,$r0,0x0         */
+    0x064809ac,   /* iocsrrd.w  $r12,$r13           */
+    0x43fff59f,   /* beqz       $r12,-12(0x7ffff4) # 48 <.L11> */
+
+                  /* Read and clear IPI interrupt.  */
+    0x1400002d,   /* lu12i.w    $r13,1(0x1)         */
+    0x064809ac,   /* iocsrrd.w  $r12,$r13           */
+    0x1400002d,   /* lu12i.w    $r13,1(0x1)         */
+    0x038031ad,   /* ori        $r13,$r13,0xc       */
+    0x064819ac,   /* iocsrwr.w  $r12,$r13           */
+
+                  /* Disable  IPI interrupt.        */
+    0x1400002c,   /* lu12i.w    $r12,1(0x1)         */
+    0x04001180,   /* csrxchg    $r0,$r12,0x4        */
+
+                  /* Read mail buf and jump to specified entry */
+    0x1400002d,   /* lu12i.w    $r13,1(0x1)         */
+    0x038081ad,   /* ori        $r13,$r13,0x20      */
+    0x06480dac,   /* iocsrrd.d  $r12,$r13           */
+    0x00150181,   /* move       $r1,$r12            */
+    0x4c000020,   /* jirl       $r0,$r1,0           */
+};
+
 static int init_cmdline(struct loongarch_boot_info *info)
 {
     hwaddr cmdline_addr;
@@ -136,11 +192,19 @@ static void loongarch_direct_kernel_boot(LoongArchMachineState *lams,
     int i;
 
     kernel_addr = load_kernel_info(info);
+
+    rom_add_blob_fixed("slave_boot", slave_boot_code, sizeof(slave_boot_code),
+                       loader_rommap[SLAVE_BOOT].base);
+
     if (!machine->firmware) {
         for (i = 0; i < machine->smp.cpus; i++) {
             lacpu = LOONGARCH_CPU(qemu_get_cpu(i));
             lacpu->env.load_elf = true;
-            lacpu->env.elf_address = kernel_addr;
+            if (i == 0) {
+                lacpu->env.elf_address = kernel_addr;
+            } else {
+                lacpu->env.elf_address = loader_rommap[SLAVE_BOOT].base;
+            }
             lacpu->env.boot_info = info;
         }
     }
-- 
2.25.1


