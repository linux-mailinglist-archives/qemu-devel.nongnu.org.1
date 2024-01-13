Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1141182CA1A
	for <lists+qemu-devel@lfdr.de>; Sat, 13 Jan 2024 06:59:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOX1e-0007QH-Jc; Sat, 13 Jan 2024 00:57:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rOX1c-0007Pc-OJ
 for qemu-devel@nongnu.org; Sat, 13 Jan 2024 00:57:44 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rOX1b-00083P-B2
 for qemu-devel@nongnu.org; Sat, 13 Jan 2024 00:57:44 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 323F960A27;
 Sat, 13 Jan 2024 05:57:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6104C43390;
 Sat, 13 Jan 2024 05:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705125461;
 bh=oUCHbLTLt1MvvljpncvV3usL/WuleAJ+iiuW0ytrHv0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cYREz1eeMe+mwAqt7hjr7GuhGjFX3D8/xzB2BdDY/qjjCgavnsQ6y0W89MR4kVXp6
 VVz+XuqVSjWXV8uwEIz/gcC5I2K4BFMURn5iS76cM34U3DdExIwJvKtQ4mDQD+VdiD
 QGWf5zCls36VCH/Ik710MptMAcJtG4DEUxZuJE+PAvE+/H2qMkvAmejZcZeOpInMfj
 h7WrBmlWCQboBadRRLySSUju868aZMfdQIqgIuQjpDBKQgMQX3n7CPmQwCOXJVbKPq
 jsakxqihdd+r38BOAqRQQV6xAf0GDK3j4GpXM8VqScPEC5hXIZIQFoAeuIn4o7BDBT
 OgWdJIpwiI4pQ==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bruno Haible <bruno@clisp.org>
Subject: [PULL 06/10] target/hppa: Avoid accessing %gr0 when raising exception
Date: Sat, 13 Jan 2024 06:57:24 +0100
Message-ID: <20240113055729.4480-7-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240113055729.4480-1-deller@kernel.org>
References: <20240113055729.4480-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=deller@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -91
X-Spam_score: -9.2
X-Spam_bar: ---------
X-Spam_report: (-9.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.09,
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Bruno Haible <bruno@clisp.org>
---
 target/hppa/mem_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 4c28c58ee9..1387f4a64b 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -341,7 +341,7 @@ raise_exception_with_ior(CPUHPPAState *env, int excp, uintptr_t retaddr,
 
                 cpu_restore_state(cs, retaddr);
 
-                b = env->gr[env->unwind_breg];
+                b = env->unwind_breg ? env->gr[env->unwind_breg] : 0;
                 b >>= (env->psw & PSW_W ? 62 : 30);
                 env->cr[CR_IOR] |= b << 62;
 
-- 
2.43.0


