Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA2DA69EB0
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Mar 2025 04:24:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tv6VB-0001Kk-Q9; Wed, 19 Mar 2025 23:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tv6U4-0001GH-ND
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 23:22:18 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tv6U0-0004x1-TB
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 23:22:15 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxlnDgidtnNO+dAA--.4275S3;
 Thu, 20 Mar 2025 11:22:08 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMDx_MTWidtnEfVUAA--.47322S8;
 Thu, 20 Mar 2025 11:22:08 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
	Markus Armbruster <armbru@redhat.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v5 6/6] target/loongarch: Clean up virt_cpu_irq_init() error
 handling
Date: Thu, 20 Mar 2025 11:21:58 +0800
Message-Id: <20250320032158.1762751-7-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250320032158.1762751-1-maobibo@loongson.cn>
References: <20250320032158.1762751-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDx_MTWidtnEfVUAA--.47322S8
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The Error ** argument must be NULL, &error_abort, &error_fatal, or a
pointer to a variable containing NULL. Passing an argument of the
latter kind twice without clearing it in between is wrong: if the
first call sets an error, it no longer points to NULL for the second
call.

virt_cpu_irq_init() is wrong that way: it passes &err to
hotplug_handler_plug() twice.  If both calls failed, this could trip
error_setv()'s assertion.  Moreover, if just one fails, the Error
object leaks. Fortunately, these calls can't actually fail.

Messed up in commit 50ebc3fc47f7 (hw/intc/loongarch_ipi: Notify ipi
object when cpu is plugged) and commit 087a23a87c57
(hw/intc/loongarch_extioi: Use cpu plug notification).

Clean this up by passing &error_abort instead.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Acked-by: Markus Armbruster <armbru@redhat.com>
---
 hw/loongarch/virt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 8a766181ec..66da6b241f 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -327,7 +327,6 @@ static void virt_cpu_irq_init(LoongArchVirtMachineState *lvms)
     MachineClass *mc = MACHINE_GET_CLASS(ms);
     const CPUArchIdList *possible_cpus;
     CPUState *cs;
-    Error *err = NULL;
 
     /* cpu nodes */
     possible_cpus = mc->possible_cpu_arch_ids(ms);
@@ -337,8 +336,10 @@ static void virt_cpu_irq_init(LoongArchVirtMachineState *lvms)
             continue;
         }
 
-        hotplug_handler_plug(HOTPLUG_HANDLER(lvms->ipi), DEVICE(cs), &err);
-        hotplug_handler_plug(HOTPLUG_HANDLER(lvms->extioi), DEVICE(cs), &err);
+        hotplug_handler_plug(HOTPLUG_HANDLER(lvms->ipi), DEVICE(cs),
+                             &error_abort);
+        hotplug_handler_plug(HOTPLUG_HANDLER(lvms->extioi), DEVICE(cs),
+                             &error_abort);
     }
 }
 
-- 
2.39.3


