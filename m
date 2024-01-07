Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AAF82643D
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Jan 2024 14:24:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMT7H-0006Kk-5Y; Sun, 07 Jan 2024 08:23:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rMT7B-0006IU-40
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 08:22:57 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rMT79-0003L4-4T
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 08:22:56 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E3AF060B9A;
 Sun,  7 Jan 2024 13:22:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E19C433C7;
 Sun,  7 Jan 2024 13:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1704633773;
 bh=HlpONBE5xmYT5SPvJFAtSC7CZESRyr5y7DVv3L+OrJw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WLvsL1OhYyHExCvM1Le1Pgq1B1vHpnOPKT7rQnH7q76XgTLeWhq/6+hneh0IB2EO7
 7/PbDGupI0FiY6bOegZwNN+TIP7rX/71ZFbANMvh5ob0/GIjmqOlgymPwbMvZJ0enO
 FEunJ7rHCLYwF/B51xh8eNIzY4S8A6sOve/fg0PoULG+wNlAdib9onrHRVrlemNRwk
 rvC6S8z+Q8bK8nKugCq//DcSvjzsu/duaSRh0k2h/x1CHQkg+dznzlmLoe9ytc2x+d
 ifDGyexuGmX518YpLK5V1bOS+nKhyKNndEpzN7cyVhYvSV9av+TvK4cIv5KEoa2plm
 uJma501JaUSpg==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Bruno Haible <bruno@clisp.org>,
 "Nelson H . F . Beebe" <beebe@math.utah.edu>, Helge Deller <deller@gmx.de>
Subject: [PATCH v2 6/9] target/hppa: Strip upper 32-bits of IOR on unaligned
 access error
Date: Sun,  7 Jan 2024 14:22:34 +0100
Message-ID: <20240107132237.50553-7-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240107132237.50553-1-deller@kernel.org>
References: <20240107132237.50553-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
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

Limit IOR to the lower 32-bits on failure.
Keep patch short for easier backporting.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 target/hppa/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 04de1689d7..3c384d5855 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -112,7 +112,7 @@ void hppa_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
     cs->exception_index = EXCP_UNALIGN;
     if (env->psw & PSW_Q) {
         /* ??? Needs tweaking for hppa64.  */
-        env->cr[CR_IOR] = addr;
+        env->cr[CR_IOR] = (uint32_t)addr;
         env->cr[CR_ISR] = addr >> 32;
     }
 
-- 
2.43.0


