Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6EE927667
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jul 2024 14:51:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPLuM-0005i3-51; Thu, 04 Jul 2024 08:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sPLu5-0005OJ-Ds; Thu, 04 Jul 2024 08:49:41 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sPLu3-0006Vn-Hs; Thu, 04 Jul 2024 08:49:37 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B327F773A7;
 Thu,  4 Jul 2024 15:48:22 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 4C392FE78C;
 Thu,  4 Jul 2024 15:48:27 +0300 (MSK)
Received: (nullmailer pid 1471804 invoked by uid 1000);
 Thu, 04 Jul 2024 12:48:26 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.13 13/17] target/arm: Fix VCMLA Dd, Dn, Dm[idx]
Date: Thu,  4 Jul 2024 15:48:20 +0300
Message-Id: <20240704124826.1471715-13-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.13-20240704143502@cover.tls.msk.ru>
References: <qemu-stable-7.2.13-20240704143502@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

The inner loop, bounded by eltspersegment, must not be
larger than the outer loop, bounded by elements.

Cc: qemu-stable@nongnu.org
Fixes: 18fc2405781 ("target/arm: Implement SVE fp complex multiply add (indexed)")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2376
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240625183536.1672454-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 76bccf3cb9d9383da0128bbc6d1300cddbe3ae8f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index f59d3b26ea..859366e264 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -842,7 +842,7 @@ void HELPER(gvec_fcmlah_idx)(void *vd, void *vn, void *vm, void *va,
     intptr_t index = extract32(desc, SIMD_DATA_SHIFT + 2, 2);
     uint32_t neg_real = flip ^ neg_imag;
     intptr_t elements = opr_sz / sizeof(float16);
-    intptr_t eltspersegment = 16 / sizeof(float16);
+    intptr_t eltspersegment = MIN(16 / sizeof(float16), elements);
     intptr_t i, j;
 
     /* Shift boolean to the sign bit so we can xor to negate.  */
@@ -904,7 +904,7 @@ void HELPER(gvec_fcmlas_idx)(void *vd, void *vn, void *vm, void *va,
     intptr_t index = extract32(desc, SIMD_DATA_SHIFT + 2, 2);
     uint32_t neg_real = flip ^ neg_imag;
     intptr_t elements = opr_sz / sizeof(float32);
-    intptr_t eltspersegment = 16 / sizeof(float32);
+    intptr_t eltspersegment = MIN(16 / sizeof(float32), elements);
     intptr_t i, j;
 
     /* Shift boolean to the sign bit so we can xor to negate.  */
-- 
2.39.2


