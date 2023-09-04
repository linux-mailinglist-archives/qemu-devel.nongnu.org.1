Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42ACB79145D
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 11:09:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd5YL-00027Z-7c; Mon, 04 Sep 2023 05:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kZzc=EU=kaod.org=clg@ozlabs.org>)
 id 1qd5YI-00026b-VK; Mon, 04 Sep 2023 05:07:22 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kZzc=EU=kaod.org=clg@ozlabs.org>)
 id 1qd5YG-0003n1-LQ; Mon, 04 Sep 2023 05:07:22 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RfN7V0PpGz4wxW;
 Mon,  4 Sep 2023 19:07:18 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RfN7S1dy2z4wy1;
 Mon,  4 Sep 2023 19:07:15 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 16/35] target/ppc: Sign-extend large decrementer to 64-bits
Date: Mon,  4 Sep 2023 11:06:11 +0200
Message-ID: <20230904090630.725952-17-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904090630.725952-1-clg@kaod.org>
References: <20230904090630.725952-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=kZzc=EU=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Nicholas Piggin <npiggin@gmail.com>

When storing a large decrementer value with the most significant
implemented bit set, it is to be treated as a negative and sign
extended.

This isn't hit for book3s DEC because of another bug, fixing it
in the next patch exposes this one and can cause additional
problems, so fix this first. It can be hit with HDECR and other
edge triggered types.

Fixes: a8dafa52518 ("target/ppc: Implement large decrementer support for TCG")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/ppc/ppc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index a397820d9c34..fb4784793ce1 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -743,7 +743,9 @@ target_ulong cpu_ppc_load_decr(CPUPPCState *env)
      * to 64 bits, otherwise it is a 32 bit value.
      */
     if (env->spr[SPR_LPCR] & LPCR_LD) {
-        return decr;
+        PowerPCCPU *cpu = env_archcpu(env);
+        PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+        return sextract64(decr, 0, pcc->lrg_decr_bits);
     }
     return (uint32_t) decr;
 }
@@ -762,7 +764,9 @@ target_ulong cpu_ppc_load_hdecr(CPUPPCState *env)
      * extended to 64 bits, otherwise it is 32 bits.
      */
     if (pcc->lrg_decr_bits > 32) {
-        return hdecr;
+        PowerPCCPU *cpu = env_archcpu(env);
+        PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+        return sextract64(hdecr, 0, pcc->lrg_decr_bits);
     }
     return (uint32_t) hdecr;
 }
-- 
2.41.0


