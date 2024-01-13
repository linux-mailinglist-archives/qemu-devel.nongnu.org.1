Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EF082CA13
	for <lists+qemu-devel@lfdr.de>; Sat, 13 Jan 2024 06:58:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOX1k-0007RO-5g; Sat, 13 Jan 2024 00:57:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rOX1i-0007R8-TK
 for qemu-devel@nongnu.org; Sat, 13 Jan 2024 00:57:50 -0500
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rOX1h-00086D-AP
 for qemu-devel@nongnu.org; Sat, 13 Jan 2024 00:57:50 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id C7887CE259A;
 Sat, 13 Jan 2024 05:57:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 109F0C433C7;
 Sat, 13 Jan 2024 05:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705125466;
 bh=HMscmGeaFXpMMw/G897fJ5R4jD8hIiSvdjBj8a9jRtE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Uwjiqwg09U/PqwY7smY4eO93K3GyciKXFTHut7sBWTTGTPj0W0o7sFVFX4Kr81Mfm
 ZKRTWQ/+qg9i7RpgvshhBZSobRNsu9hwQCTvWVkBuUdwDA0ZtJvlEeu1HU5QnHO1wz
 V63nY/xKHF3FLOAZgAJ9oZgbuWfEX8AROPf81pgeaDEFzk/Lx64g/hJgcxYuZuZ3CH
 UrYcav/ddIilunr4AQJ0I57mWiHnAnXXyhKKfotWl1vRlJxNrctFBycNXLdu1dM319
 qxS46aaAo9+htfYg5WXyMlZiK1KzP9/fxbhu+JjKmNKW27jlFOn5ot3TTfOE4M7ml4
 h8vSzCTYzzp+g==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 09/10] target/hppa: Fix IOR and ISR on error in probe
Date: Sat, 13 Jan 2024 06:57:27 +0100
Message-ID: <20240113055729.4480-10-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240113055729.4480-1-deller@kernel.org>
References: <20240113055729.4480-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.40.73.55; envelope-from=deller@kernel.org;
 helo=sin.source.kernel.org
X-Spam_score_int: -64
X-Spam_score: -6.5
X-Spam_bar: ------
X-Spam_report: (-6.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.09,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


