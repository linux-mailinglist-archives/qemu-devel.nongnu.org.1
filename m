Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1490EA63BAC
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Mar 2025 03:30:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu0EY-0002yI-OH; Sun, 16 Mar 2025 22:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tu0EW-0002xM-4k
 for qemu-devel@nongnu.org; Sun, 16 Mar 2025 22:29:40 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tu0EU-00032b-7K
 for qemu-devel@nongnu.org; Sun, 16 Mar 2025 22:29:39 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxbeIOiddnsk+ZAA--.25188S3;
 Mon, 17 Mar 2025 10:29:34 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCxbsUDiddn1ZVOAA--.28932S3;
 Mon, 17 Mar 2025 10:29:34 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 1/3] target/loongarch: Fix error handling of KVM feature
 checks
Date: Mon, 17 Mar 2025 10:29:20 +0800
Message-Id: <20250317022922.802988-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250317022922.802988-1-maobibo@loongson.cn>
References: <20250317022922.802988-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxbsUDiddn1ZVOAA--.28932S3
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

For some paravirt KVM features, if user forces to enable it however
KVM does not support, qemu should fail to run and exit immediately,
rather than continue to run. Here set error message and return directly
in function kvm_arch_init_vcpu().

Fixes: 6edd2a9bec90 (target/loongarch/kvm: Implement LoongArch PMU extension)
Fixes: 936c3f4d7916 (target/loongarch: Use auto method with LSX feature)
Fixes: 5e360dabedb1 (target/loongarch: Use auto method with LASX feature)
Fixes: 620d9bd0022e (target/loongarch: Add paravirt ipi feature detection)
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/kvm/kvm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 28735c80be..7f63e7c8fe 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -1081,7 +1081,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
     int ret;
     Error *local_err = NULL;
 
-    ret = 0;
     qemu_add_vm_change_state_handler(kvm_loongarch_vm_stage_change, cs);
 
     if (!kvm_get_one_reg(cs, KVM_REG_LOONGARCH_DEBUG_INST, &val)) {
@@ -1091,29 +1090,34 @@ int kvm_arch_init_vcpu(CPUState *cs)
     ret = kvm_cpu_check_lsx(cs, &local_err);
     if (ret < 0) {
         error_report_err(local_err);
+        return ret;
     }
 
     ret = kvm_cpu_check_lasx(cs, &local_err);
     if (ret < 0) {
         error_report_err(local_err);
+        return ret;
     }
 
     ret = kvm_cpu_check_lbt(cs, &local_err);
     if (ret < 0) {
         error_report_err(local_err);
+        return ret;
     }
 
     ret = kvm_cpu_check_pmu(cs, &local_err);
     if (ret < 0) {
         error_report_err(local_err);
+        return ret;
     }
 
     ret = kvm_cpu_check_pv_features(cs, &local_err);
     if (ret < 0) {
         error_report_err(local_err);
+        return ret;
     }
 
-    return ret;
+    return 0;
 }
 
 static bool loongarch_get_lbt(Object *obj, Error **errp)
-- 
2.39.3


