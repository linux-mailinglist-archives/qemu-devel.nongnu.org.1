Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EB082719A
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 15:40:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMqlw-0006aL-5u; Mon, 08 Jan 2024 09:38:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rMqlg-0006Tc-KC
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 09:38:22 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rMqlf-0007rx-05
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 09:38:20 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id ED02E61055;
 Mon,  8 Jan 2024 14:38:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E140C433C9;
 Mon,  8 Jan 2024 14:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1704724694;
 bh=aBgCGCkIpFK/yMSnSEqSZ/aCgv/Nk3BedkbPafVsmYI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gLHVBp8KIc9yR9iHz8AhIOHrCXEVMZJyi07MJrdGsr8+mrZkvyloH3eWiKuPmhBD8
 H5sEj6EOJDLV71ExATWRc3rQqe8p2t1ggukad5Nm3t/XUMdR0NLeUCYyce+PafD/UT
 aBL4RlzwYWceMPiVrbIauzPxTrjtl1SL0zWXD5SsScBKb0sYVPNPgc3AlF6kqZ+oiz
 tnocwDXtTzGMADcwrXVpaM8ZDjiRVGLGbyT5lwEfsKp57vIcNXJRrvdvKMPudWCwxE
 L6hq9peG49lK/FVD/wonhfawQB6izqC/xq6j0CKsYFWxMWI7dIl2x7THhsvGo7PM0E
 rtUiudEEb/zAQ==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 8/9] target/hppa: Avoid accessing %gr0 when raising exception
Date: Mon,  8 Jan 2024 15:38:01 +0100
Message-ID: <20240108143802.50256-9-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108143802.50256-1-deller@kernel.org>
References: <20240108143802.50256-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=deller@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -93
X-Spam_score: -9.4
X-Spam_bar: ---------
X-Spam_report: (-9.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
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

The value of unwind_breg may reference register %r0, but we need to avoid
accessing gr0 directly and use the value 0 instead.

At runtime I've seen unwind_breg being zero with the Linux kernel when
rfi is used to jump to smp_callin().

Signed-off-by: Helge Deller <deller@gmx.de>
---
 target/hppa/mem_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 011b192406..42bd0063c0 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -335,7 +335,7 @@ raise_exception_with_ior(CPUHPPAState *env, int excp, uintptr_t retaddr,
 
                 cpu_restore_state(cs, retaddr);
 
-                b = env->gr[env->unwind_breg];
+                b = env->unwind_breg ? env->gr[env->unwind_breg] : 0;
                 b >>= (env->psw & PSW_W ? 62 : 30);
                 env->cr[CR_IOR] |= b << 62;
 
-- 
2.43.0


