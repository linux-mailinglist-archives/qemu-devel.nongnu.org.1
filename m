Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 524D8761A97
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 15:52:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOINZ-0007HQ-O9; Tue, 25 Jul 2023 09:47:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOIMo-0005ms-Ue; Tue, 25 Jul 2023 09:46:32 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOIMn-0001UV-DI; Tue, 25 Jul 2023 09:46:22 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0C542160F6;
 Tue, 25 Jul 2023 16:45:35 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id B8885194B9;
 Tue, 25 Jul 2023 16:45:32 +0300 (MSK)
Received: (nullmailer pid 3370825 invoked by uid 1000);
 Tue, 25 Jul 2023 13:45:29 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.4 14/31] tcg: Fix info_in_idx increment in
 layout_arg_by_ref
Date: Tue, 25 Jul 2023 16:44:59 +0300
Message-Id: <20230725134517.3370706-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.4-20230725164041@cover.tls.msk.ru>
References: <qemu-stable-8.0.4-20230725164041@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Off by one error, failing to take into account that layout_arg_1
already incremented info_in_idx for the first piece.  We only
need care for the n-1 TCG_CALL_ARG_BY_REF_N pieces here.

Cc: qemu-stable@nongnu.org
Fixes: 313bdea84d2 ("tcg: Add TCG_CALL_{RET,ARG}_BY_REF")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1751
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit e18ed26ce785f74a17e6f3a095647e08ba6fc669)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tcg/tcg.c b/tcg/tcg.c
index bb52bc060b..f3bf471274 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -732,7 +732,7 @@ static void layout_arg_by_ref(TCGCumulativeArgs *cum, TCGHelperInfo *info)
             .ref_slot = cum->ref_slot + i,
         };
     }
-    cum->info_in_idx += n;
+    cum->info_in_idx += n - 1;  /* i=0 accounted for in layout_arg_1 */
     cum->ref_slot += n;
 }
 
-- 
2.39.2


