Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A01182CA14
	for <lists+qemu-devel@lfdr.de>; Sat, 13 Jan 2024 06:58:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOX1j-0007RG-L4; Sat, 13 Jan 2024 00:57:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rOX1h-0007Ql-QV
 for qemu-devel@nongnu.org; Sat, 13 Jan 2024 00:57:49 -0500
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rOX1g-00085c-4J
 for qemu-devel@nongnu.org; Sat, 13 Jan 2024 00:57:49 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 5D215CE23C7;
 Sat, 13 Jan 2024 05:57:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38BBC433F1;
 Sat, 13 Jan 2024 05:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705125464;
 bh=sM2ZWgk6JWatVLRPpAnEmobohCrep0P3Z/YMyGxKwtU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iAn6o6LwipUiNz2YwBneIi7anfobVuqeM7ykxzCr6gTiTnNRZ6j+2NV3lTm2j9gsg
 dASxfW8YnLlmr9veIQ5g5B6AEpiJSTSmKJQ+6aqUpOpqmsN7aVDb2miPBSnrmWQWXW
 GIRU5pe6PNAi6odyYqPuIt8jd6CQszy3g+enTVSO+73s1O4dlMVW+EqDTpelkkc5Tf
 h7aC1Im7vS2UPOiBa7BA87CRUASJ7II9oa/Hda4i+slahiyeB9Mmwp2M6zMNWk2mg/
 EPBoIHjT7NSyc6agud5BeOvGhbjgh58Di7ZY1IcjhOwHSu+7xI1i3gaDNHbcLPWHTj
 Jaz2LTZY3Dr3A==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 08/10] target/hppa: Fix IOR and ISR on unaligned access trap
Date: Sat, 13 Jan 2024 06:57:26 +0100
Message-ID: <20240113055729.4480-9-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240113055729.4480-1-deller@kernel.org>
References: <20240113055729.4480-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=deller@kernel.org; helo=sin.source.kernel.org
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
 target/hppa/cpu.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 04de1689d7..fda32d7f59 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -110,11 +110,7 @@ void hppa_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
     CPUHPPAState *env = &cpu->env;
 
     cs->exception_index = EXCP_UNALIGN;
-    if (env->psw & PSW_Q) {
-        /* ??? Needs tweaking for hppa64.  */
-        env->cr[CR_IOR] = addr;
-        env->cr[CR_ISR] = addr >> 32;
-    }
+    hppa_set_ior_and_isr(env, addr, MMU_IDX_MMU_DISABLED(mmu_idx));
 
     cpu_loop_exit_restore(cs, retaddr);
 }
-- 
2.43.0


