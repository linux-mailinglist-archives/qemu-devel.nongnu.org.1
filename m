Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A134D86AB37
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Feb 2024 10:32:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfGHX-00015l-2O; Wed, 28 Feb 2024 04:31:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rfGHJ-00010w-Fk; Wed, 28 Feb 2024 04:31:07 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rfGHF-0001P1-WF; Wed, 28 Feb 2024 04:31:04 -0500
Received: from mail.maildlp.com (unknown [172.19.162.254])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Tl8DT1hMjzvVyH;
 Wed, 28 Feb 2024 17:28:41 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
 by mail.maildlp.com (Postfix) with ESMTPS id 1E97718006C;
 Wed, 28 Feb 2024 17:30:51 +0800 (CST)
Received: from huawei.com (10.67.174.55) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 28 Feb
 2024 17:30:50 +0800
To: <peter.maydell@linaro.org>, <eduardo@habkost.net>,
 <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, <wangyanan55@huawei.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: <ruanjinjie@huawei.com>
Subject: [RFC PATCH v4 01/22] target/arm: Handle HCR_EL2 accesses for bits
 introduced with FEAT_NMI
Date: Wed, 28 Feb 2024 09:29:25 +0000
Message-ID: <20240228092946.1768728-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228092946.1768728-1-ruanjinjie@huawei.com>
References: <20240228092946.1768728-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.174.55]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)
Received-SPF: pass client-ip=45.249.212.187;
 envelope-from=ruanjinjie@huawei.com; helo=szxga01-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jinjie Ruan <ruanjinjie@huawei.com>
From:  Jinjie Ruan via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

FEAT_NMI defines another three new bits in HCRX_EL2: TALLINT, HCRX_VINMI and
HCRX_VFNMI. When the feature is enabled, allow these bits to be written in
HCRX_EL2.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v4:
- Update the comment for FEAT_NMI in hcrx_write().
- Update the commit message, s/thress/three/g.
v3:
- Add Reviewed-by.
- Add HCRX_VINMI and HCRX_VFNMI support in HCRX_EL2.
- Upate the commit messsage.
---
 target/arm/cpu-features.h | 5 +++++
 target/arm/helper.c       | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 7567854db6..2ad1179be7 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -681,6 +681,11 @@ static inline bool isar_feature_aa64_sme(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, SME) != 0;
 }
 
+static inline bool isar_feature_aa64_nmi(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, NMI) != 0;
+}
+
 static inline bool isar_feature_aa64_tgran4_lpa2(const ARMISARegisters *id)
 {
     return FIELD_SEX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN4) >= 1;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 90c4fb72ce..affa493141 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6056,6 +6056,11 @@ static void hcrx_write(CPUARMState *env, const ARMCPRegInfo *ri,
         valid_mask |= HCRX_MSCEN | HCRX_MCE2;
     }
 
+    /* FEAT_NMI adds TALLINT, VINMI and VFNMI */
+    if (cpu_isar_feature(aa64_nmi, env_archcpu(env))) {
+        valid_mask |= HCRX_TALLINT | HCRX_VINMI | HCRX_VFNMI;
+    }
+
     /* Clear RES0 bits.  */
     env->cp15.hcrx_el2 = value & valid_mask;
 }
-- 
2.34.1


