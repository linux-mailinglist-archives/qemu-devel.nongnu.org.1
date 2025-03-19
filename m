Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F517A6830D
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Mar 2025 03:11:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuit1-0001wE-2M; Tue, 18 Mar 2025 22:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tuirq-0001rh-1k
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 22:09:14 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tuirh-0002F4-UP
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 22:09:13 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxlnAzJ9pnfoKcAA--.2107S3;
 Wed, 19 Mar 2025 10:08:51 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxb8cwJ9pn2NpSAA--.42124S6;
 Wed, 19 Mar 2025 10:08:51 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
	Markus Armbruster <armbru@redhat.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 4/4] target/loongarch: Set dest error with error_abort in
 virt_cpu_irq_init
Date: Wed, 19 Mar 2025 10:08:47 +0800
Message-Id: <20250319020847.1511759-5-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250319020847.1511759-1-maobibo@loongson.cn>
References: <20250319020847.1511759-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxb8cwJ9pn2NpSAA--.42124S6
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

In function virt_cpu_irq_init(), there is notification with ipi and extioi
interrupt controller for cpu creation. Local variable with error type is
used, however there is no check with its return value.

Here set dest error object with error_abort, rather than local variable, so
application will abort to run if there is error.

Fixes: 50ebc3fc47fe (hw/intc/loongarch_ipi: Notify ipi object when cpu is plugged)
Fixes: 087a23a87c57 (hw/intc/loongarch_extioi: Use cpu plug notification)
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index a9fab39dd8..f10a4704ab 100644
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


