Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4B6A43EA4
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Feb 2025 13:03:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmtf2-0006yG-04; Tue, 25 Feb 2025 07:03:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tmte0-0006Ex-Bo
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 07:02:42 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tmtdt-0006f3-My
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 07:02:35 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxquDvsL1nPRaCAA--.49856S3;
 Tue, 25 Feb 2025 20:00:47 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxLsfpsL1n2uMnAA--.19507S12;
 Tue, 25 Feb 2025 20:00:47 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Subject: [PULL 10/11] target/loongarch: Add kvm steal time feature detection
Date: Tue, 25 Feb 2025 20:00:40 +0800
Message-Id: <20250225120041.1652869-11-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250225120041.1652869-1-maobibo@loongson.cn>
References: <20250225120041.1652869-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxLsfpsL1n2uMnAA--.19507S12
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

Paravirt steal time feature is OnOffAuto type, feature detection is added
to check whether it is supported on KVM host.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.h     |  1 +
 target/loongarch/kvm/kvm.c | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 3e8a91748d..83183a33ab 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -288,6 +288,7 @@ enum loongarch_features {
     LOONGARCH_FEATURE_LBT, /* loongson binary translation extension */
     LOONGARCH_FEATURE_PMU,
     LOONGARCH_FEATURE_PV_IPI,
+    LOONGARCH_FEATURE_STEALTIME,
 };
 
 typedef struct  LoongArchBT {
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index def7451224..59a5f84161 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -924,6 +924,12 @@ static bool kvm_feature_supported(CPUState *cs, enum loongarch_features feature)
         ret = kvm_vm_ioctl(kvm_state, KVM_HAS_DEVICE_ATTR, &attr);
         return (ret == 0);
 
+    case LOONGARCH_FEATURE_STEALTIME:
+        attr.group = KVM_LOONGARCH_VM_FEAT_CTRL;
+        attr.attr = KVM_LOONGARCH_VM_FEAT_PV_STEALTIME;
+        ret = kvm_vm_ioctl(kvm_state, KVM_HAS_DEVICE_ATTR, &attr);
+        return (ret == 0);
+
     default:
         return false;
     }
@@ -1042,6 +1048,20 @@ static int kvm_cpu_check_pv_features(CPUState *cs, Error **errp)
         env->pv_features |= BIT(KVM_FEATURE_IPI);
     }
 
+    kvm_supported = kvm_feature_supported(cs, LOONGARCH_FEATURE_STEALTIME);
+    if (cpu->kvm_steal_time == ON_OFF_AUTO_ON) {
+        if (!kvm_supported) {
+            error_setg(errp, "'kvm stealtime' feature not supported by KVM host");
+            return -ENOTSUP;
+        }
+    } else if (cpu->kvm_steal_time != ON_OFF_AUTO_AUTO) {
+        kvm_supported = false;
+    }
+
+    if (kvm_supported) {
+        env->pv_features |= BIT(KVM_FEATURE_STEAL_TIME);
+    }
+
     return 0;
 }
 
-- 
2.43.5


