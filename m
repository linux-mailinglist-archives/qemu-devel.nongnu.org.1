Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5055F761B13
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 16:12:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOIkk-0004VF-JW; Tue, 25 Jul 2023 10:11:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOIkA-0003e0-Mj; Tue, 25 Jul 2023 10:10:32 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOIk7-0007ZP-Qb; Tue, 25 Jul 2023 10:10:29 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9FDA41616A;
 Tue, 25 Jul 2023 17:10:14 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 538CB19502;
 Tue, 25 Jul 2023 17:10:12 +0300 (MSK)
Received: (nullmailer pid 3372593 invoked by uid 1000);
 Tue, 25 Jul 2023 14:10:11 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.5 08/14] target/s390x: Fix CONVERT TO LOGICAL/FIXED with
 out-of-range inputs
Date: Tue, 25 Jul 2023 17:10:02 +0300
Message-Id: <20230725141009.3372529-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.5-20230725170615@cover.tls.msk.ru>
References: <qemu-stable-7.2.5-20230725170615@cover.tls.msk.ru>
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

CONVERT TO LOGICAL/FIXED deviate from IEEE 754 in that they raise an
inexact exception on out-of-range inputs. float_flag_invalid_cvti
aligns nicely with that behavior, so convert it to
S390_IEEE_MASK_INEXACT.

Cc: qemu-stable@nongnu.org
Fixes: defb0e3157af ("s390x: Implement opcode helpers")
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20230724082032.66864-4-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 53684e344a27da770acc9012740334154ddea24f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/s390x/tcg/fpu_helper.c b/target/s390x/tcg/fpu_helper.c
index be80b2373c..0bde369768 100644
--- a/target/s390x/tcg/fpu_helper.c
+++ b/target/s390x/tcg/fpu_helper.c
@@ -44,7 +44,8 @@ uint8_t s390_softfloat_exc_to_ieee(unsigned int exc)
     s390_exc |= (exc & float_flag_divbyzero) ? S390_IEEE_MASK_DIVBYZERO : 0;
     s390_exc |= (exc & float_flag_overflow) ? S390_IEEE_MASK_OVERFLOW : 0;
     s390_exc |= (exc & float_flag_underflow) ? S390_IEEE_MASK_UNDERFLOW : 0;
-    s390_exc |= (exc & float_flag_inexact) ? S390_IEEE_MASK_INEXACT : 0;
+    s390_exc |= (exc & (float_flag_inexact | float_flag_invalid_cvti)) ?
+                S390_IEEE_MASK_INEXACT : 0;
 
     return s390_exc;
 }
-- 
2.39.2


