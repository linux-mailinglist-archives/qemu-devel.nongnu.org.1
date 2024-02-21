Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D912785E113
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Feb 2024 16:28:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoOR-0001ld-0m; Wed, 21 Feb 2024 10:20:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rcoJp-0000wk-23; Wed, 21 Feb 2024 10:15:33 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rcmLz-0004pz-4H; Wed, 21 Feb 2024 08:09:40 -0500
Received: from mail.maildlp.com (unknown [172.19.88.234])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TfxPz0n4zz2BdDH;
 Wed, 21 Feb 2024 21:07:19 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
 by mail.maildlp.com (Postfix) with ESMTPS id 121BB1400CF;
 Wed, 21 Feb 2024 21:09:28 +0800 (CST)
Received: from huawei.com (10.67.174.55) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 21 Feb
 2024 21:09:27 +0800
To: <peter.maydell@linaro.org>, <eduardo@habkost.net>,
 <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, <wangyanan55@huawei.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: <ruanjinjie@huawei.com>
Subject: [RFC PATCH v2 07/22] target/arm: Add support for NMI event state
Date: Wed, 21 Feb 2024 13:08:08 +0000
Message-ID: <20240221130823.677762-8-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240221130823.677762-1-ruanjinjie@huawei.com>
References: <20240221130823.677762-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.174.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=ruanjinjie@huawei.com; helo=szxga04-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jinjie Ruan <ruanjinjie@huawei.com>
From:  Jinjie Ruan via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

The NMI exception state include whether the interrupt with super priority
is IRQ or FIQ, so add a nmi_is_irq flag in CPUARMState to distinguish it.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 target/arm/cpu.h    | 2 ++
 target/arm/helper.c | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 5257343bcb..051e589e19 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -603,6 +603,8 @@ typedef struct CPUArchState {
     /* State of our input IRQ/FIQ/VIRQ/VFIQ lines */
     uint32_t irq_line_state;
 
+    bool nmi_is_irq;
+
     /* Thumb-2 EE state.  */
     uint32_t teecr;
     uint32_t teehbr;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index bd7858e02e..0bd7a87e51 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10575,6 +10575,15 @@ uint32_t arm_phys_excp_target_el(CPUState *cs, uint32_t excp_idx,
         scr = ((env->cp15.scr_el3 & SCR_FIQ) == SCR_FIQ);
         hcr = hcr_el2 & HCR_FMO;
         break;
+    case EXCP_NMI:
+        if (env->nmi_is_irq) {
+            scr = ((env->cp15.scr_el3 & SCR_IRQ) == SCR_IRQ);
+            hcr = hcr_el2 & HCR_IMO;
+        } else {
+            scr = ((env->cp15.scr_el3 & SCR_FIQ) == SCR_FIQ);
+            hcr = hcr_el2 & HCR_FMO;
+        }
+        break;
     default:
         scr = ((env->cp15.scr_el3 & SCR_EA) == SCR_EA);
         hcr = hcr_el2 & HCR_AMO;
-- 
2.34.1


