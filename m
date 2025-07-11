Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D05BB025F4
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Jul 2025 22:52:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaKis-0001On-9n; Fri, 11 Jul 2025 16:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uaKe5-0003QA-UA; Fri, 11 Jul 2025 16:47:01 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uaKe3-0003n2-9Y; Fri, 11 Jul 2025 16:47:01 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BB885135D08;
 Fri, 11 Jul 2025 23:46:04 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9147E23FF42;
 Fri, 11 Jul 2025 23:46:32 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.19 09/15] tcg: Fix constant propagation in
 tcg_reg_alloc_dup
Date: Fri, 11 Jul 2025 23:46:24 +0300
Message-ID: <20250711204632.1804872-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-7.2.19-20250711111933@cover.tls.msk.ru>
References: <qemu-stable-7.2.19-20250711111933@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The scalar constant must be replicated for dup.

Cc: qemu-stable@nongnu.org
Fixes: bab1671f0fa ("tcg: Manually expand INDEX_op_dup_vec")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3002
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 0d0fc3f4658937fb81fcc16a89738e83bd8d4795)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tcg/tcg.c b/tcg/tcg.c
index e7aa02c447..6c8f86ecb7 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3491,7 +3491,7 @@ static void tcg_reg_alloc_dup(TCGContext *s, const TCGOp *op)
 
     if (its->val_type == TEMP_VAL_CONST) {
         /* Propagate constant via movi -> dupi.  */
-        tcg_target_ulong val = its->val;
+        tcg_target_ulong val = dup_const(vece, its->val);
         if (IS_DEAD_ARG(1)) {
             temp_dead(s, its);
         }
-- 
2.47.2


