Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 456E18522C5
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Feb 2024 00:48:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZg1e-0003Eg-HU; Mon, 12 Feb 2024 18:47:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rZg1b-0003DI-AB
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 18:47:47 -0500
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rZg1Z-00009B-Hv
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 18:47:47 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id D9F85CE17B9;
 Mon, 12 Feb 2024 23:47:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA8EBC433F1;
 Mon, 12 Feb 2024 23:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707781662;
 bh=bMGiugQoc2DhmTSqm+CZs/LiSubHUzCkUMZHroTlcng=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fIpLKn27e3vkTT3s8QIyNGitEgRIQfytmGeQxiRoDTld4daoEBeq3WPKqzQIi0hG9
 a5t/vpA1lcPBUbfujQigHUr8IpcuuyBH285GoHf0wJGVkXoQZFMwNwwY25SiO6Ig00
 HwHw3bAypzHJi3yWD5TL986yr09WPVoTvvT7Hg/9dljyUStvlnL8wQmsr1wmQoGtNH
 SVJTD0ruWMrmbYfzW6SEYsF+bt5INVunajvv5OIVp9hnqyfBXeAfeCQPe7uOPZLozt
 9j+c0z7M481tAOa4daX9qPVw04xEyuT4wtJ6TazIDJylNzSveqtZRatWaklNNhwvWa
 GxaySBZG/GVLg==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Sven Schnelle <svens@stackframe.org>, Jason Wang <jasowang@redhat.com>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 09/12] target/hppa: PDC_BTLB_INFO uses 32-bit ints
Date: Tue, 13 Feb 2024 00:47:20 +0100
Message-ID: <20240212234723.222847-10-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212234723.222847-1-deller@kernel.org>
References: <20240212234723.222847-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=deller@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.774,
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

The BTLB helper function stores the BTLB info (four 32-bit ints) into
the memory of the guest. They are only available when emulating a 32-bit
CPU in the guest, so use "uint32_t" instead of "target_ulong" here.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/mem_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 676c0b3003..66b8fa7d72 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -684,7 +684,7 @@ void HELPER(diag_btlb)(CPUHPPAState *env)
     case 0:
         /* return BTLB parameters */
         qemu_log_mask(CPU_LOG_MMU, "PDC_BLOCK_TLB: PDC_BTLB_INFO\n");
-        vaddr = probe_access(env, env->gr[24], 4 * sizeof(target_ulong),
+        vaddr = probe_access(env, env->gr[24], 4 * sizeof(uint32_t),
                              MMU_DATA_STORE, mmu_idx, ra);
         if (vaddr == NULL) {
             env->gr[28] = -10; /* invalid argument */
-- 
2.43.0


