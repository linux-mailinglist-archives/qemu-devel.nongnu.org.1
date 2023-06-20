Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AFD736362
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 08:03:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBUQo-0005qK-7K; Tue, 20 Jun 2023 02:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=rj0j=CI=kaod.org=clg@ozlabs.org>)
 id 1qBUPB-0004eB-3l; Tue, 20 Jun 2023 01:59:55 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=rj0j=CI=kaod.org=clg@ozlabs.org>)
 id 1qBUP7-0004Zq-Qc; Tue, 20 Jun 2023 01:59:52 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QlbZC2v2Sz4x3N;
 Tue, 20 Jun 2023 15:59:47 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QlbZ95Ppnz4x2c;
 Tue, 20 Jun 2023 15:59:45 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-ppc@nongnu.org,
	Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 9/9] target/ppc: Fix timer register accessors when !KVM
Date: Tue, 20 Jun 2023 07:59:11 +0200
Message-ID: <20230620055911.187065-10-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620055911.187065-1-clg@kaod.org>
References: <20230620055911.187065-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=rj0j=CI=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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


