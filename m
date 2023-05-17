Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F186770626B
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 10:12:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzC74-0003ZK-5g; Wed, 17 May 2023 04:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzC6t-0002wS-Gy; Wed, 17 May 2023 04:02:11 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzC6j-0000mV-QN; Wed, 17 May 2023 04:02:11 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B8C79676D;
 Wed, 17 May 2023 11:01:01 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 48C3A5E25;
 Wed, 17 May 2023 11:01:01 +0300 (MSK)
Received: (nullmailer pid 3624187 invoked by uid 1000);
 Wed, 17 May 2023 08:00:56 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v8.0.1 36/36] tcg/i386: Set P_REXW in tcg_out_addi_ptr
Date: Wed, 17 May 2023 11:00:56 +0300
Message-Id: <20230517080056.3623993-36-mjt@msgid.tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <<20230517073442.3622973-0-mjt@msgid.tls.msk.ru>
References: <20230517073442.3622973-0-mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

The REXW bit must be set to produce a 64-bit pointer result; the
bit is disabled in 32-bit mode, so we can do this unconditionally.

Fixes: 7d9e1ee424b0 ("tcg/i386: Adjust assert in tcg_out_addi_ptr")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1592
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1642
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 988998503bc6d8c03fbea001a0513e8372fddf28)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 tcg/i386/tcg-target.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 5a151fe64a..5c7c180799 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1083,7 +1083,7 @@ static void tcg_out_addi_ptr(TCGContext *s, TCGReg rd, TCGReg rs,
 {
     /* This function is only used for passing structs by reference. */
     tcg_debug_assert(imm == (int32_t)imm);
-    tcg_out_modrm_offset(s, OPC_LEA, rd, rs, imm);
+    tcg_out_modrm_offset(s, OPC_LEA | P_REXW, rd, rs, imm);
 }
 
 static inline void tcg_out_pushi(TCGContext *s, tcg_target_long val)
-- 
2.39.2


