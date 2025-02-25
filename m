Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B1FA43EAA
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Feb 2025 13:04:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmtcy-0003sf-3k; Tue, 25 Feb 2025 07:01:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tmtcN-0003j3-L0
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 07:00:55 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tmtcI-0006W4-K3
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 07:00:54 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxYa_vsL1nOxaCAA--.50369S3;
 Tue, 25 Feb 2025 20:00:47 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxLsfpsL1n2uMnAA--.19507S11;
 Tue, 25 Feb 2025 20:00:47 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Subject: [PULL 09/11] target/loongarch: Add vCPU property for kvm steal time
 feature
Date: Tue, 25 Feb 2025 20:00:39 +0800
Message-Id: <20250225120041.1652869-10-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250225120041.1652869-1-maobibo@loongson.cn>
References: <20250225120041.1652869-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxLsfpsL1n2uMnAA--.19507S11
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

Property kvm-steal-time is added for kvm steal time feature, it is
specially for kvm mode.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.h                |  1 +
 target/loongarch/kvm/kvm.c            | 18 ++++++++++++++++++
 target/loongarch/loongarch-qmp-cmds.c |  2 +-
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 3a8e45d9d5..3e8a91748d 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -409,6 +409,7 @@ struct ArchCPU {
     OnOffAuto lsx;
     OnOffAuto lasx;
     OnOffAuto kvm_pv_ipi;
+    OnOffAuto kvm_steal_time;
 
     /* 'compatible' string for this CPU for Linux device trees */
     const char *dtb_compatible;
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index ed0706e8e0..def7451224 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -1122,6 +1122,18 @@ static void kvm_pv_ipi_set(Object *obj, bool value, Error **errp)
     cpu->kvm_pv_ipi = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
 }
 
+static bool kvm_steal_time_get(Object *obj, Error **errp)
+{
+    return LOONGARCH_CPU(obj)->kvm_steal_time != ON_OFF_AUTO_OFF;
+}
+
+static void kvm_steal_time_set(Object *obj, bool value, Error **errp)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
+
+    cpu->kvm_steal_time = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
+}
+
 void kvm_loongarch_cpu_post_init(LoongArchCPU *cpu)
 {
     cpu->lbt = ON_OFF_AUTO_AUTO;
@@ -1141,6 +1153,12 @@ void kvm_loongarch_cpu_post_init(LoongArchCPU *cpu)
                              kvm_pv_ipi_set);
     object_property_set_description(OBJECT(cpu), "kvm-pv-ipi",
                                     "Set off to disable KVM paravirt IPI.");
+
+    cpu->kvm_steal_time = ON_OFF_AUTO_AUTO;
+    object_property_add_bool(OBJECT(cpu), "kvm-steal-time", kvm_steal_time_get,
+                             kvm_steal_time_set);
+    object_property_set_description(OBJECT(cpu), "kvm-steal-time",
+                                    "Set off to disable KVM steal time.");
 }
 
 int kvm_arch_destroy_vcpu(CPUState *cs)
diff --git a/target/loongarch/loongarch-qmp-cmds.c b/target/loongarch/loongarch-qmp-cmds.c
index 4f94a39833..6f732d80f3 100644
--- a/target/loongarch/loongarch-qmp-cmds.c
+++ b/target/loongarch/loongarch-qmp-cmds.c
@@ -40,7 +40,7 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
 }
 
 static const char *cpu_model_advertised_features[] = {
-    "lsx", "lasx", "lbt", "pmu", "kvm-pv-ipi", NULL
+    "lsx", "lasx", "lbt", "pmu", "kvm-pv-ipi", "kvm-steal-time", NULL
 };
 
 CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
-- 
2.43.5


