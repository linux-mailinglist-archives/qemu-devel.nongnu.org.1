Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 435D8A69EAC
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Mar 2025 04:23:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tv6Ub-0001Hw-EA; Wed, 19 Mar 2025 23:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tv6U4-0001GF-MU
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 23:22:18 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tv6U0-0004wi-SV
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 23:22:15 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxOGrdidtnJe+dAA--.5921S3;
 Thu, 20 Mar 2025 11:22:05 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMDx_MTWidtnEfVUAA--.47322S4;
 Thu, 20 Mar 2025 11:22:05 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
	Markus Armbruster <armbru@redhat.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v5 2/6] hw/loongarch/virt: Fix error handling in cpu plug
Date: Thu, 20 Mar 2025 11:21:54 +0800
Message-Id: <20250320032158.1762751-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250320032158.1762751-1-maobibo@loongson.cn>
References: <20250320032158.1762751-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDx_MTWidtnEfVUAA--.47322S4
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

In function virt_cpu_plug(), it will send cpu plug message to interrupt
controller extioi and ipi irqchip. If there is problem in this function,
system should continue to run and keep state the same before cpu is
added.

Object cpuslot::cpu is set at last only when there is no any error.
If there is, send cpu unplug message to extioi and ipi irqchip, and then
return immediately.

Fixes: ab9935d2991e (hw/loongarch/virt: Implement cpu plug interface)
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index a5840ff968..5118f01e4b 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -981,8 +981,6 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev,
     LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(hotplug_dev);
     Error *err = NULL;
 
-    cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id);
-    cpu_slot->cpu = CPU(dev);
     if (lvms->ipi) {
         hotplug_handler_plug(HOTPLUG_HANDLER(lvms->ipi), dev, &err);
         if (err) {
@@ -995,6 +993,10 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev,
         hotplug_handler_plug(HOTPLUG_HANDLER(lvms->extioi), dev, &err);
         if (err) {
             error_propagate(errp, err);
+            if (lvms->ipi) {
+                /* Send unplug message to restore, discard error here */
+                hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->ipi), dev, NULL);
+            }
             return;
         }
     }
@@ -1003,9 +1005,20 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev,
         hotplug_handler_plug(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &err);
         if (err) {
             error_propagate(errp, err);
+            if (lvms->ipi) {
+                hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->ipi), dev, NULL);
+            }
+
+            if (lvms->extioi) {
+                hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->extioi),
+                                       dev, NULL);
+            }
+            return;
         }
     }
 
+    cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id);
+    cpu_slot->cpu = CPU(dev);
     return;
 }
 
-- 
2.39.3


