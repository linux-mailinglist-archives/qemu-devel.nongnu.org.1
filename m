Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F7C7063AA
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 11:12:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzDCJ-0001qI-AV; Wed, 17 May 2023 05:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzDBk-0000vz-1v; Wed, 17 May 2023 05:11:16 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzDBh-0006PJ-Mr; Wed, 17 May 2023 05:11:15 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 445176835;
 Wed, 17 May 2023 12:10:45 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id AE3155F06;
 Wed, 17 May 2023 12:10:44 +0300 (MSK)
Received: (nullmailer pid 3626711 invoked by uid 1000);
 Wed, 17 May 2023 09:10:42 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, Shivaprasad G Bhat <sbhat@linux.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v7.2.3 15/30] softfloat: Fix the incorrect computation in
 float32_exp2
Date: Wed, 17 May 2023 12:10:27 +0300
Message-Id: <20230517091042.3626593-15-mjt@msgid.tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1684310574.git.mjt@msgid.tls.msk.ru>
References: <cover.1684310574.git.mjt@msgid.tls.msk.ru>
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

From: Shivaprasad G Bhat <sbhat@linux.ibm.com>

The float32_exp2 function is computing wrong exponent of 2.

For example, with the following set of values {0.1, 2.0, 2.0, -1.0},
the expected output would be {1.071773, 4.000000, 4.000000, 0.500000}.
Instead, the function is computing {1.119102, 3.382044, 3.382044, -0.191022}

Looking at the code, the float32_exp2() attempts to do this

                  2     3     4     5           n
  x        x     x     x     x     x           x
 e  = 1 + --- + --- + --- + --- + --- + ... + --- + ...
           1!    2!    3!    4!    5!          n!

But because of the typo it ends up doing

  x        x     x     x     x     x           x
 e  = 1 + --- + --- + --- + --- + --- + ... + --- + ...
           1!    2!    3!    4!    5!          n!

This is because instead of the xnp which holds the numerator, parts_muladd
is using the xp which is just 'x'.  Commit '572c4d862ff2' refactored this
function, and mistakenly used xp instead of xnp.

Cc: qemu-stable@nongnu.org
Fixes: 572c4d862ff2 "softfloat: Convert float32_exp2 to FloatParts"
Partially-Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1623
Reported-By: Luca Barbato (https://gitlab.com/lu-zero)
Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 1098cc3fcf952763fc9fd72c1c8fda30a18cc8ea)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 fpu/softfloat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index c7454c3eb1..108f9cb224 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -5135,7 +5135,7 @@ float32 float32_exp2(float32 a, float_status *status)
     float64_unpack_canonical(&rp, float64_one, status);
     for (i = 0 ; i < 15 ; i++) {
         float64_unpack_canonical(&tp, float32_exp2_coefficients[i], status);
-        rp = *parts_muladd(&tp, &xp, &rp, 0, status);
+        rp = *parts_muladd(&tp, &xnp, &rp, 0, status);
         xnp = *parts_mul(&xnp, &xp, status);
     }
 
-- 
2.39.2


