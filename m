Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CE4A3B1FC
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Feb 2025 08:08:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkeAv-00086M-FC; Wed, 19 Feb 2025 02:07:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tkeAs-00086B-Iw
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 02:07:14 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tkeAp-0003U6-FF
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 02:07:14 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxjawVg7Vn9rN6AA--.48039S3;
 Wed, 19 Feb 2025 15:07:01 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBx3MQVg7VngKkbAA--.36598S2;
 Wed, 19 Feb 2025 15:07:01 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PATCH] target/loongarch: Correct maximum physical address in KVM mode
Date: Wed, 19 Feb 2025 15:07:00 +0800
Message-Id: <20250219070700.288416-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBx3MQVg7VngKkbAA--.36598S2
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 3A5000 system, the physical address space width for host is 48,
however 47 bit for KVM VM. For KVM VM, size of physical address space is
the same with that of virtual user space address.

Here modify physical address space width with 47 bit in KVM mode.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index e91f4a5239..32a0d01876 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -406,7 +406,7 @@ static void loongarch_la464_initfn(Object *obj)
 {
     LoongArchCPU *cpu = LOONGARCH_CPU(obj);
     CPULoongArchState *env = &cpu->env;
-    uint32_t data = 0;
+    uint32_t data = 0, field;
     int i;
 
     for (i = 0; i < 21; i++) {
@@ -419,7 +419,13 @@ static void loongarch_la464_initfn(Object *obj)
     data = FIELD_DP32(data, CPUCFG1, ARCH, 2);
     data = FIELD_DP32(data, CPUCFG1, PGMMU, 1);
     data = FIELD_DP32(data, CPUCFG1, IOCSR, 1);
-    data = FIELD_DP32(data, CPUCFG1, PALEN, 0x2f);
+    if (kvm_enabled()) {
+        /* GPA size is 47 for VM, 47 bit - 1 */
+        field = 0x2e;
+    } else {
+        field = 0x2f; /* 48 bit - 1 */
+    }
+    data = FIELD_DP32(data, CPUCFG1, PALEN, field);
     data = FIELD_DP32(data, CPUCFG1, VALEN, 0x2f);
     data = FIELD_DP32(data, CPUCFG1, UAL, 1);
     data = FIELD_DP32(data, CPUCFG1, RI, 1);

base-commit: db7aa99ef894e88fc5eedf02ca2579b8c344b2ec
-- 
2.39.3


