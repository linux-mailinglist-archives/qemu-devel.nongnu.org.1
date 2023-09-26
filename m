Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA467AE67A
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 09:13:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql2Fu-00042F-ID; Tue, 26 Sep 2023 03:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1ql2Fq-0003zm-Do
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 03:13:10 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1ql2Fm-0006I9-RY
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 03:13:10 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxXet2hBJlTpAsAA--.14576S3;
 Tue, 26 Sep 2023 15:12:54 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxE+R1hBJlomkSAA--.40051S2; 
 Tue, 26 Sep 2023 15:12:53 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, richard.henderson@linaro.org, philmd@redhat.com,
 yangxiaojuan@loongson.cn, maobibo@loongson.cn
Subject: [PATCH 1/1] target/loongarch: Clean up local variable shadowing
Date: Tue, 26 Sep 2023 15:12:53 +0800
Message-Id: <20230926071253.3601021-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxE+R1hBJlomkSAA--.40051S2
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Fix:

  [1839/2601] Compiling C object libqemu-loongarch64-softmmu.fa.p/hw_loongarch_virt.c.o
  ../hw/loongarch/virt.c: In function 'loongarch_irq_init':
  ../hw/loongarch/virt.c:665:14: warning: declaration of 'i' shadows a previous local [-Wshadow=compatible-local]
       for (int i = 0; i < num; i++) {
                ^
  ../hw/loongarch/virt.c:582:19: note: shadowed declaration is here
       int cpu, pin, i, start, num;

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 2629128aed..b0a004f860 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -662,7 +662,7 @@ static void loongarch_irq_init(LoongArchMachineState *lams)
                             sysbus_mmio_get_region(d, 2));
 
     /* Connect pch_pic irqs to extioi */
-    for (int i = 0; i < num; i++) {
+    for (i = 0; i < num; i++) {
         qdev_connect_gpio_out(DEVICE(d), i, qdev_get_gpio_in(extioi, i));
     }
 
-- 
2.39.1


