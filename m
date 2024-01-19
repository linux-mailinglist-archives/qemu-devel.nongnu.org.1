Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7938330CE
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 23:41:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQxXU-0001nM-O3; Fri, 19 Jan 2024 17:40:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kloetzke@kernkonzept.com>)
 id 1rQwR5-0003hc-K7
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 16:29:59 -0500
Received: from serv1.kernkonzept.com ([2a01:4f8:1c1c:b490::2]
 helo=mx.kernkonzept.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kloetzke@kernkonzept.com>)
 id 1rQwR3-0001pY-0j
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 16:29:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kernkonzept.com; s=mx1; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:References:In-Reply-To:
 Reply-To:Content-ID:Content-Description;
 bh=D52YVx8j+ZeyzuPrKqpnYYepjkrsS3E7FsEF80Ju8pw=; b=C16ffXUlNeiovCMyWmx0UgJvZd
 VK8MVu9usoqE2aqRCdlaM8ZbLdmhafwVE4KL9EvDrpu8dgp6FUNh3xuvmZDjXKD46RIPJEg53AEXj
 sVbTTBHhPS1FFkaiakzq4Y3CcFn/bjyZOpA/MfoEhcdYADCrTiM5WBcx19JKZoCGHQNvQWSNXn27o
 tqoC/Ih5hpe3wfjwRMFGbq63stR0eb6mWn3YrN/wmcuRhjohXCpxjmb3+Mev8H9sv6ohh/cD5D6kr
 f2mEoYDVZiXzd+wclcvCH9ofXssrmjVxk0hYZdCNXAhZzmJVTJRS/epAi/TVwCle8wvh9TbfoNh2b
 JjBYf0ng==;
Received: from p5dd489e8.dip0.t-ipconnect.de ([93.212.137.232]
 helo=shark.dd1.int.kernkonzept.com)
 by mx.kernkonzept.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.96)
 id 1rQwQy-001Gps-1K; Fri, 19 Jan 2024 22:29:52 +0100
From: =?UTF-8?q?Jan=20Kl=C3=B6tzke?= <jan.kloetzke@kernkonzept.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Jan=20Kl=C3=B6tzke?= <jan.kloetzke@kernkonzept.com>
Subject: [PATCH] target/arm: fix exception syndrome for AArch32 bkpt insn
Date: Fri, 19 Jan 2024 22:29:45 +0100
Message-Id: <20240119212945.2440655-1-jan.kloetzke@kernkonzept.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:4f8:1c1c:b490::2;
 envelope-from=jan.kloetzke@kernkonzept.com; helo=mx.kernkonzept.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 19 Jan 2024 17:40:38 -0500
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

Debug exceptions that target AArch32 Hyp mode are reported differently
than on AAarch64. Internally, Qemu uses the AArch64 syndromes. Therefore
such exceptions need to be either converted to a prefetch abort
(breakpoints, vector catch) or a data abort (watchpoints).

Signed-off-by: Jan Klötzke <jan.kloetzke@kernkonzept.com>
---
 target/arm/helper.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index e068d35383..71dd60ad2d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11013,6 +11013,26 @@ static void arm_cpu_do_interrupt_aarch32(CPUState *cs)
     }
 
     if (env->exception.target_el == 2) {
+        /* Debug exceptions are reported differently on AARCH32 */
+        switch (syn_get_ec(env->exception.syndrome)) {
+        case EC_BREAKPOINT:
+        case EC_BREAKPOINT_SAME_EL:
+        case EC_AA32_BKPT:
+        case EC_VECTORCATCH:
+            env->exception.syndrome = syn_insn_abort(arm_current_el(env) == 2,
+                                                     0, 0, 0x22);
+            break;
+        case EC_WATCHPOINT:
+        case EC_WATCHPOINT_SAME_EL:
+            /*
+             * ISS is compatible between Watchpoints and Data Aborts. Also
+             * retain the lowest EC bit as it signals the originating EL.
+             */
+            env->exception.syndrome &= (1U << (ARM_EL_EC_SHIFT + 1)) - 1U;
+            env->exception.syndrome |= (EC_DATAABORT << ARM_EL_EC_SHIFT)
+                                       | ARM_EL_ISV;
+            break;
+        }
         arm_cpu_do_interrupt_aarch32_hyp(cs);
         return;
     }
-- 
2.39.2


