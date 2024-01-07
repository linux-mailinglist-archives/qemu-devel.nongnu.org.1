Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5F3826444
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Jan 2024 14:25:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMT7l-0006S3-8s; Sun, 07 Jan 2024 08:23:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rMT7I-0006L0-2C
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 08:23:05 -0500
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rMT7F-0003Lt-Nu
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 08:23:03 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 3E006CE098A;
 Sun,  7 Jan 2024 13:22:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE43C433C7;
 Sun,  7 Jan 2024 13:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1704633777;
 bh=aBgCGCkIpFK/yMSnSEqSZ/aCgv/Nk3BedkbPafVsmYI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=g+PKJaIlgJ7WMNtFaki2Dbt72B9LnYCXkAAOLTphAMMqQu2CBClJWtdlLVoO3EZfl
 UiFYM40Ux6NCh+awCnvKO90Cj6NKJRgqcNAHiiQdRAi2bdLXJ6HoPHDnRjxPf/mO/x
 jeB8Hs6iU7Gbs9LGUlqna7XFdkjoIUbGVLJgaFosFmFQgCfJmC0freAikDYpNGDMuR
 vN4mkAjXpVlaQNr5f6grSBUnbZsT2olGZSX9sPC5/4gvRhsvTPFjANBDG7atmNY6oC
 mNW+KyblPrkLEtdrr6/t028YUMkZAX4ObWfqzCXEcgnoYqYaZ4Sr88xtXWnLeVYteI
 IFa3WlmuoQZUg==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Bruno Haible <bruno@clisp.org>,
 "Nelson H . F . Beebe" <beebe@math.utah.edu>, Helge Deller <deller@gmx.de>
Subject: [PATCH v2 8/9] target/hppa: Avoid accessing %gr0 when raising
 exception
Date: Sun,  7 Jan 2024 14:22:36 +0100
Message-ID: <20240107132237.50553-9-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240107132237.50553-1-deller@kernel.org>
References: <20240107132237.50553-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=deller@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -64
X-Spam_score: -6.5
X-Spam_bar: ------
X-Spam_report: (-6.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.098,
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


