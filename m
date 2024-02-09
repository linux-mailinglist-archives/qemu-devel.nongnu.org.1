Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EFF84F4EF
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Feb 2024 12:58:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYPVH-0003hr-Vh; Fri, 09 Feb 2024 06:57:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rYPV3-0003dV-V7
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:56:59 -0500
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rYPV1-0002Re-CK
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:56:56 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id B80FFCE200D;
 Fri,  9 Feb 2024 11:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED17C433C7;
 Fri,  9 Feb 2024 11:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707479810;
 bh=QEDKIdARto+ZCseIU47VCEGfs+CMVMZ3Lv39zKgePHQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=brqT05GkcBmw0v/ZI20VPXfrrPyzVHHDcO1CGTouqIFaUfH9f7riT/vbPIJHpjCN1
 UVWT2Srt/PmAAyfrnPmap9vW5sWe3oCvwAFdFVDCbnInh8SS04nVXZhhj/gsfX7+Ap
 e3nVQvib9W+xnvySO1CA6rIwMpnNVk4+3Ogo9MARXOoZd+7cRv/Qz6Dzd/IJxS/U1T
 9xsuA6XHs0Nky+2YHjeX6yyFp7PT90ZBPx1QhtWLlvW964gQNjzDwurJ44wTGasqsu
 o+D1sc6eLr1CrX4whxw05DNUT9PLK6E2O/ePSfGStv4MwhXrtWcjLT+epc3j94RpTI
 QsbRgaRrH7lNA==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Sven Schnelle <svens@stackframe.org>, Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 08/12] target/hppa: Allow read-access to PSW with rsm 0,
 reg instruction
Date: Fri,  9 Feb 2024 12:56:29 +0100
Message-ID: <20240209115633.55823-9-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209115633.55823-1-deller@kernel.org>
References: <20240209115633.55823-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.40.73.55; envelope-from=deller@kernel.org;
 helo=sin.source.kernel.org
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.213,
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

HP-UX 11 and HP ODE tools use the "rsm 0,%reg" instruction in not priviledged
code paths to get the current PSW flags. The constant 0 means that no bits of
the PSW shall be reset, so this is effectively a read-only access to the PSW.
Allow this read-only access even for not privileged code.

Signed-off-by: Helge Deller <deller@gmx.de>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 53ec57ee86..01f3188656 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2156,10 +2156,16 @@ static bool trans_ldsid(DisasContext *ctx, arg_ldsid *a)
 
 static bool trans_rsm(DisasContext *ctx, arg_rsm *a)
 {
+#ifdef CONFIG_USER_ONLY
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
-#ifndef CONFIG_USER_ONLY
+#else
     TCGv_i64 tmp;
 
+    /* HP-UX 11i and HP ODE use rsm for read-access to PSW */
+    if (a->i) {
+        CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
+    }
+
     nullify_over(ctx);
 
     tmp = tcg_temp_new_i64();
-- 
2.43.0


