Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C893C7E6BE9
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 15:02:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15aL-0005bh-7x; Thu, 09 Nov 2023 09:00:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15ZW-0005B7-K9; Thu, 09 Nov 2023 08:59:52 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15ZU-0005QH-IT; Thu, 09 Nov 2023 08:59:50 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7E9F331BBB;
 Thu,  9 Nov 2023 16:59:41 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 899EB344F4;
 Thu,  9 Nov 2023 16:59:33 +0300 (MSK)
Received: (nullmailer pid 1462769 invoked by uid 1000);
 Thu, 09 Nov 2023 13:59:33 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.7 05/62] target/ppc: Sign-extend large decrementer to
 64-bits
Date: Thu,  9 Nov 2023 16:58:33 +0300
Message-Id: <20231109135933.1462615-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.7-20231109164316@cover.tls.msk.ru>
References: <qemu-stable-7.2.7-20231109164316@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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
[ clg: removed extra cpu and pcc variables shadowing local variables ]
Signed-off-by: Cédric Le Goater <clg@kaod.org>
(cherry picked from commit c8fbc6b9f2f3c732ee3307093c1c5c367eaa64ae)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 9961abc505..5573ab467c 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -746,7 +746,9 @@ target_ulong cpu_ppc_load_decr(CPUPPCState *env)
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
@@ -765,7 +767,7 @@ target_ulong cpu_ppc_load_hdecr(CPUPPCState *env)
      * extended to 64 bits, otherwise it is 32 bits.
      */
     if (pcc->lrg_decr_bits > 32) {
-        return hdecr;
+        return sextract64(hdecr, 0, pcc->lrg_decr_bits);
     }
     return (uint32_t) hdecr;
 }
-- 
2.39.2


