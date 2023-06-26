Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D7773D769
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 07:58:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDfEZ-0003bV-U0; Mon, 26 Jun 2023 01:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org>)
 id 1qDfE4-0003K3-Aa; Mon, 26 Jun 2023 01:57:24 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org>)
 id 1qDfE2-0007Ia-JW; Mon, 26 Jun 2023 01:57:24 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QqHDd480Nz4wZy;
 Mon, 26 Jun 2023 15:57:21 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QqHDb4Hwnz4wb3;
 Mon, 26 Jun 2023 15:57:19 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 09/30] target/ppc: Fix timer register accessors when !KVM
Date: Mon, 26 Jun 2023 07:56:26 +0200
Message-ID: <20230626055647.1147743-10-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626055647.1147743-1-clg@kaod.org>
References: <20230626055647.1147743-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

When the Timer Control and Timer Status registers are modified, avoid
calling the KVM backend when not available

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 target/ppc/kvm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index a7f2de9d1018..a8a935e26726 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1728,6 +1728,10 @@ int kvmppc_or_tsr_bits(PowerPCCPU *cpu, uint32_t tsr_bits)
         .addr = (uintptr_t) &bits,
     };
 
+    if (!kvm_enabled()) {
+        return 0;
+    }
+
     return kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
 }
 
@@ -1741,6 +1745,10 @@ int kvmppc_clear_tsr_bits(PowerPCCPU *cpu, uint32_t tsr_bits)
         .addr = (uintptr_t) &bits,
     };
 
+    if (!kvm_enabled()) {
+        return 0;
+    }
+
     return kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
 }
 
@@ -1755,6 +1763,10 @@ int kvmppc_set_tcr(PowerPCCPU *cpu)
         .addr = (uintptr_t) &tcr,
     };
 
+    if (!kvm_enabled()) {
+        return 0;
+    }
+
     return kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
 }
 
-- 
2.41.0


