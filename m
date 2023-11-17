Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4231A7EF0E8
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 11:47:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3wMW-0003rN-16; Fri, 17 Nov 2023 05:46:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1r3wMS-0003qW-J4
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 05:46:08 -0500
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1r3wMR-0002TC-0G
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 05:46:08 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id B26A1CE20BB;
 Fri, 17 Nov 2023 10:45:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0907AC433C8;
 Fri, 17 Nov 2023 10:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1700217956;
 bh=4eDg3SyDD7nql6xYHUEWMKETF3w0NCibCsl/vqDMXtg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DD+3hzHJXwFIaG2e29aC6yfu5S5B4i6uXh+SzR2fQFLGwwpvRmhIAIVfeSf6ZrBLU
 9Burc6tiYBqBEi/VQvDIQF2PZ5CXIE5AlJYVx+ke5z8nzmwuzE/NDQPgPqkma3/5yl
 edLmpiPcVyBFSjLCEfJh5I99Nr2khvoYIidxQiZh1rjH631yYLjCSwTOnEAezu4RSD
 9xcnmd4Ry6MuFWWaB5mvAkyzj2ITJNTo8H4RbHspQ5Q1FPNO6fwoxce5zR+pxkTPEI
 cx1CnhH4UdyMr40uOnJeqhBM8oAtlaT5gk5/0bPMTwxn+oiYuwWGJIYHgl82Y347+7
 0KCvi+snEtzuA==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH 1/2] target/hppa: Fix 64-bit SHRPD instruction
Date: Fri, 17 Nov 2023 11:45:50 +0100
Message-ID: <20231117104551.148255-2-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231117104551.148255-1-deller@kernel.org>
References: <20231117104551.148255-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=deller@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.117,
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

When shifting the two joined 64-bit registers right, shift the lower
64-bit register to the left and the higher 64-bit register to the right
before merging them with OR.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 target/hppa/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 4a4830c3e3..3ef39b1bd7 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3438,9 +3438,9 @@ static bool trans_shrp_sar(DisasContext *ctx, arg_shrp_sar *a)
             TCGv_i64 n = tcg_temp_new_i64();
 
             tcg_gen_xori_i64(n, cpu_sar, 63);
-            tcg_gen_shl_i64(t, src2, n);
+            tcg_gen_shl_i64(t, src1, n);
             tcg_gen_shli_i64(t, t, 1);
-            tcg_gen_shr_i64(dest, src1, cpu_sar);
+            tcg_gen_shr_i64(dest, src2, cpu_sar);
             tcg_gen_or_i64(dest, dest, t);
         } else {
             TCGv_i64 t = tcg_temp_new_i64();
-- 
2.41.0


