Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D39C382BEA6
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 11:30:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOEnR-00086n-Fb; Fri, 12 Jan 2024 05:29:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rOEnK-0007yM-BZ
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 05:29:46 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rOEnI-0006Lt-Gz
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 05:29:46 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 8457461D60;
 Fri, 12 Jan 2024 10:29:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574F1C43390;
 Fri, 12 Jan 2024 10:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705055383;
 bh=fXmfWG5wGeCbjGRjAUA62CMUoLzlw1DwHmq/Afn380k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YI/nNX7xLlg+Mt17XK81iQNwEmZGhI4UwDtQAVucfmSSZL4wRSEzAERBshwo20jH2
 lw6uZeUubK/Y9j598ozLZOHQE3tA1MZfdHNukbUwW99ZH1cgbQ/k2a7Y/H6XH1KrDt
 1Yw09RbEwsVaYOsuLTT/tB7RnRsMEJmof2W3P1MBzmihU33m+M+61NBm7J9Jaxx5oM
 x4vKAacstAfisMnfKyOTJEPParn/1UrMlRb8TbtECIxOYjtMLuIH0nxws+CpNOSmGC
 W6/ZV3Vg29NflHtcqRAhJ5Ek1ru4IxnNk+yyUy0qpi5rIPrzuNNMSSjs0aYL76msX6
 cnpFNNgCA0Y6w==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v3 9/9] target/hppa: Fix IOR and ISR on error in probe
Date: Fri, 12 Jan 2024 11:29:27 +0100
Message-ID: <20240112102927.35406-10-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240112102927.35406-1-deller@kernel.org>
References: <20240112102927.35406-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=deller@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Helge Deller <deller@gmx.de>

Put correct values (depending on CPU arch) into IOR and ISR on fault.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 target/hppa/op_helper.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 7f607c3afd..ce15469465 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -351,11 +351,7 @@ target_ulong HELPER(probe)(CPUHPPAState *env, target_ulong addr,
     excp = hppa_get_physical_address(env, addr, mmu_idx, 0, &phys,
                                      &prot, NULL);
     if (excp >= 0) {
-        if (env->psw & PSW_Q) {
-            /* ??? Needs tweaking for hppa64.  */
-            env->cr[CR_IOR] = addr;
-            env->cr[CR_ISR] = addr >> 32;
-        }
+        hppa_set_ior_and_isr(env, addr, MMU_IDX_MMU_DISABLED(mmu_idx));
         if (excp == EXCP_DTLB_MISS) {
             excp = EXCP_NA_DTLB_MISS;
         }
-- 
2.43.0


