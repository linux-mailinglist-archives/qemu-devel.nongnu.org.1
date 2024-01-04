Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B40982484C
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 19:38:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLSaM-0001Se-TU; Thu, 04 Jan 2024 13:36:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rLSaK-0001SR-TW
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 13:36:52 -0500
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rLSaJ-0005H1-B8
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 13:36:52 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 67DDCCE1A93;
 Thu,  4 Jan 2024 18:36:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D646C433C7;
 Thu,  4 Jan 2024 18:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1704393407;
 bh=aBgCGCkIpFK/yMSnSEqSZ/aCgv/Nk3BedkbPafVsmYI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ugx8B6xw3kBY0o4Wopo2c+78GT6m29BXBa/KGFvIQI0Lkz1Tuxwc9koHaNtXqXB7P
 H/FRmDX+gsHGbFKWRz4ScEiCZZ+mQbDc8GVGLO59Xr4xcuHzOt4K5bPSOtjhOihvpa
 DO4TrnOZXfOvxec0DlBBydJ6Q50On9HnpqIGhuqzY0Wgt0II7uw0xmmKQk4RY0Bbmr
 PF8DDj9hP4z2PxN/W2v0Y6qXYX5hScP192moA4Neznw06A61UoYnC12KkntdWP++XU
 YeQ657v9XEoRkdOpDjSwo0g1iKeFIO75YClg2S2p+2q0h4SoW5DnBwBVvZ/Se3zk8b
 Wm5ANW2RWxuCw==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Bruno Haible <bruno@clisp.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Nelson H . F . Beebe" <beebe@math.utah.edu>, Helge Deller <deller@gmx.de>
Subject: [PATCH 8/9] target/hppa: Avoid accessing %gr0 when raising exception
Date: Thu,  4 Jan 2024 19:36:27 +0100
Message-ID: <20240104183628.101366-9-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104183628.101366-1-deller@kernel.org>
References: <20240104183628.101366-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.40.73.55; envelope-from=deller@kernel.org;
 helo=sin.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.691,
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


