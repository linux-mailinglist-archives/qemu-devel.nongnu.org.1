Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C2B82484A
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 19:38:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLSaF-0001LW-8y; Thu, 04 Jan 2024 13:36:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rLSaC-0001HO-QL
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 13:36:44 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rLSaB-0005EZ-Cp
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 13:36:44 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 48323618E8;
 Thu,  4 Jan 2024 18:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F15C433C8;
 Thu,  4 Jan 2024 18:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1704393401;
 bh=TZmsEXD8QFvRMVbZU1fktx3Zxu6qmdxWr8MwsABbMi8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MtJcvqRmJdriDSwZkN1G2AR5QakSOjZp7q0bF8vcOLsTQdDRALo4NwjFfT9/6tTdZ
 qKFSLjNs94vJG+Ni5YJjsyq00Chbcyio/lFlLtB8j6V6BiFoujzLSBvZlvVP8wjuff
 RIRBg0C1AzlRhN30o/XdgzJ3wesvW5orDfkROSvJPOyJVgJZW/2t44ggLLc/CXzcx+
 vpfOxMdjmYe+imreJ14Dv6k6YVDZy78PPr9rHM0Bxo48ecyZzpUagbrrkahrfEnv7Y
 nOOd6I66QhCsVM8UBRGdz/ip0KueCjnQZNMKOmQ9Gfi2ipZ573iqBtnIzV/K5OP3y2
 YzDGMjTEklEkQ==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Bruno Haible <bruno@clisp.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Nelson H . F . Beebe" <beebe@math.utah.edu>, Helge Deller <deller@gmx.de>
Subject: [PATCH 5/9] target/hppa: Strip upper 32-bits of IOR on error in probe
Date: Thu,  4 Jan 2024 19:36:24 +0100
Message-ID: <20240104183628.101366-6-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104183628.101366-1-deller@kernel.org>
References: <20240104183628.101366-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=deller@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -97
X-Spam_score: -9.8
X-Spam_bar: ---------
X-Spam_report: (-9.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.691,
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

Limit IOR to the lower 32-bits on failure.
Keep patch short for easier backporting.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 target/hppa/op_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 7f607c3afd..56930a3a8c 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -353,7 +353,7 @@ target_ulong HELPER(probe)(CPUHPPAState *env, target_ulong addr,
     if (excp >= 0) {
         if (env->psw & PSW_Q) {
             /* ??? Needs tweaking for hppa64.  */
-            env->cr[CR_IOR] = addr;
+            env->cr[CR_IOR] = (uint32_t) addr;
             env->cr[CR_ISR] = addr >> 32;
         }
         if (excp == EXCP_DTLB_MISS) {
-- 
2.43.0


