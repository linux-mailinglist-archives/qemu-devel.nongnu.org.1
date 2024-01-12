Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 762B282BEA8
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 11:30:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOEnP-000842-Sr; Fri, 12 Jan 2024 05:29:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rOEnK-0007yL-9e
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 05:29:46 -0500
Received: from ams.source.kernel.org ([145.40.68.75])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rOEnI-0006LE-3s
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 05:29:46 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 88AE0B82296;
 Fri, 12 Jan 2024 10:29:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10907C433F1;
 Fri, 12 Jan 2024 10:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705055381;
 bh=1/Shn1bfOWinU0jRlavKVHl8hicEJQBQrs23UnAUgkM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cIuR7SWGxaA+0WCBYaOCq0cMhQFUl61aPzg5uTWwwQmTJI7/SkclCF6aDymJtMF9J
 BdBOBtK+o3s+YxhIfo1xR6OUeXV4FfKvXL8MOUQfB1QQAdN9Nt1cIkGqv7r97SFdAM
 Luh+0tsG31G1iKEMJsNBbUuItjKFlJGx96Lx5bQcZc6Ra//7vwIhGqPizGT+94GFgy
 3DBzHUxfSppsdfNsJLlQhyLsY3gvD4GaydxSRvwGoEyXblraLqshZ10QFatFtlVUIB
 W3G1yTNFmQgPvQJcIHMFIlyUrd5UkqdoE9s56PXI7hkG6xSXh49fie5/jrVLzUMMC0
 ktmn2mH5qWq5w==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v3 8/9] target/hppa: Fix IOR and ISR on unaligned access trap
Date: Fri, 12 Jan 2024 11:29:26 +0100
Message-ID: <20240112102927.35406-9-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240112102927.35406-1-deller@kernel.org>
References: <20240112102927.35406-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.40.68.75; envelope-from=deller@kernel.org;
 helo=ams.source.kernel.org
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.467,
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


