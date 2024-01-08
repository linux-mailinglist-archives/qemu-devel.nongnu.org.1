Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5204827199
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 15:40:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMqlv-0006Zi-8j; Mon, 08 Jan 2024 09:38:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rMqlf-0006TJ-9I
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 09:38:20 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rMqlb-0007ih-TR
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 09:38:19 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 6343A61052;
 Mon,  8 Jan 2024 14:38:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715FCC433CA;
 Mon,  8 Jan 2024 14:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1704724691;
 bh=LY0zkxpueP44pcToUrKPByeb2NHmWUmMfllbYguP8jw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ooiZ1agzv9aLlEgC93+X2OTiPDN4fl9IclhM6lfOdYZce0jF3ZAfSO2RptPj+hNuX
 RNbij15nQiQweO9yPrmKpGO+qfywrR+M4SgDdkFiIGs+onQL6LcH5IH8/lYBioT/2R
 Zvk63ZnBGRv7bUMxVtvFRo3REaR+/pJ/ADpOlFbXd+aEhKRFkb3cxguuh7+eioi48e
 sxm1bbYaxKjj8jmvGHLKhEfmaSm8KgroqmRflkbcUgcr77+XhH7y5H2fSik2Q8pEwt
 d71Q/wzqt7pRgFckJo+70Uh1lR+M/IdfWbYgLcB8rNihBmhFVb5l2cPbYOFsgaZT63
 ilA07R3l512qA==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 5/9] target/hppa: Strip upper 32-bits of IOR on error in probe
Date: Mon,  8 Jan 2024 15:37:58 +0100
Message-ID: <20240108143802.50256-6-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108143802.50256-1-deller@kernel.org>
References: <20240108143802.50256-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -66
X-Spam_score: -6.7
X-Spam_bar: ------
X-Spam_report: (-6.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
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

Limit IOR to the lower 32-bits on failure.
Keep patch short for easier backporting.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 target/hppa/op_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 7f607c3afd..60c9014242 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -353,7 +353,7 @@ target_ulong HELPER(probe)(CPUHPPAState *env, target_ulong addr,
     if (excp >= 0) {
         if (env->psw & PSW_Q) {
             /* ??? Needs tweaking for hppa64.  */
-            env->cr[CR_IOR] = addr;
+            env->cr[CR_IOR] = (uint32_t)addr;
             env->cr[CR_ISR] = addr >> 32;
         }
         if (excp == EXCP_DTLB_MISS) {
-- 
2.43.0


