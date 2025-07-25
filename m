Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B28B11A56
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Jul 2025 10:57:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufEDv-0007fm-Us; Fri, 25 Jul 2025 04:56:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ufEDr-0007d2-PV
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 04:56:11 -0400
Received: from p-west3-cluster4-host9-snip4-7.eps.apple.com ([57.103.74.238]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ufEDq-0001uZ-74
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 04:56:11 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-20-percent-0 (Postfix) with ESMTPS id
 EFA1F1800209; Fri, 25 Jul 2025 08:56:03 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=cBn1WfKnGFblnfiu+ECL4GTAAk/dYzreQo9gWD9hOmQ=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=dKdjDAMvvsw2y5uVzOmWpynu0oAw9EREEECtXdF+B/hipHt5cvtvkV14N4mStSscOnifOcZDJMx08ZuAiXkWODYuFqkU0uLrin2fyJyzxQ6amlDmPb6yNrcRNWg3viC77K4P4OsPGHhr/N0EW/AukXgrzrJpc5JkS/IQ8pd81l9h26aHlKkYI6M9hVFHgX7u3FiCTl718aI5eXjhx0PUDGC5prRWi95jU6SMAxTdZLAt0/sxkMFIZyV2aAlCBCAyTXObeOrIFORE95sZAI38uchPFGTySN8clT3MknQgjltJY9C/mQCjjCvXlQrL3cn36LM6VLpCMmnU6TO3ylAJ1w==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (ms-asmtp-me-k8s.p00.prod.me.com
 [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-20-percent-0 (Postfix) with ESMTPSA id
 7760C18000B8; Fri, 25 Jul 2025 08:56:00 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v2 4/9] target/arm: add asserts for code paths not leveraged
 when using the vGIC
Date: Fri, 25 Jul 2025 10:55:40 +0200
Message-Id: <20250725085545.93619-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250725085545.93619-1-mohamed@unpredictable.fr>
References: <20250725085545.93619-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: V-3nCKTX28TIiCqpkctns3c9gKtgpOJ6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA3NSBTYWx0ZWRfX1/ve2PByr/ZI
 uHUALPlSq/TUAruYSJJOblgjV31BZO+NEEr1RspQJ5hImtGQE1CALi7WbyE4BWReD1hJBvLQrJW
 5uEcRR/aoIGvULT5EyYoRZjUShwq4iE0m8ohl4AvUFM7/qAY7kIMhTFmYFIt/R5BMheTJlXMaC/
 O9b3W1O23mQxepqR3Ba7wD80IbmnuLfZbxT3qqYiqIph5A5qEvOdH4KBug21avLDbPlCDZ+wacD
 tw8E5OXWSpTnvYVMJuBIoe4xIXFIuUJMDAa0tNCjwkLc9+mzZBK90oUoolB9gYkBrV/wbJ2K0=
X-Proofpoint-ORIG-GUID: V-3nCKTX28TIiCqpkctns3c9gKtgpOJ6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=662 spamscore=0 malwarescore=0 mlxscore=0 clxscore=1030
 phishscore=0 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507250075
Received-SPF: pass client-ip=57.103.74.238;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

When using the vGIC, timers are directly handled by the platform, so no vmexits ought to happen in that case.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index bb31df90b8..7b4e8297af 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1378,6 +1378,9 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
     case SYSREG_ICC_CTLR_EL1:
+        if (hvf_irqchip_in_kernel()) {
+            abort();
+        }
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
         if (hvf_sysreg_read_cp(cpu, reg, val)) {
             return 0;
@@ -1694,6 +1697,9 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_ICC_SGI0R_EL1:
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
+        if (hvf_irqchip_in_kernel()) {
+            abort();
+        }
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
         if (hvf_sysreg_write_cp(cpu, reg, val)) {
             return 0;
@@ -1957,6 +1963,10 @@ int hvf_vcpu_exec(CPUState *cpu)
         /* This is the main one, handle below. */
         break;
     case HV_EXIT_REASON_VTIMER_ACTIVATED:
+        /* This is only for when a user-mode irqchip is used. */
+        if (hvf_irqchip_in_kernel()) {
+            assert("vtimer activated vmexit when using platform GIC");
+        }
         qemu_set_irq(arm_cpu->gt_timer_outputs[GTIMER_VIRT], 1);
         cpu->accel->vtimer_masked = true;
         return 0;
-- 
2.39.5 (Apple Git-154)


