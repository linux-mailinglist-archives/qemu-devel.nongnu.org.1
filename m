Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F0D70DA30
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 12:18:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1P3y-0006r9-IA; Tue, 23 May 2023 06:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q1P3Z-0006i9-I3; Tue, 23 May 2023 06:15:54 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q1P3X-0001nr-TS; Tue, 23 May 2023 06:15:53 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8D8EF7CF3;
 Tue, 23 May 2023 13:15:49 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id E53CF7283;
 Tue, 23 May 2023 13:15:48 +0300 (MSK)
Received: (nullmailer pid 85492 invoked by uid 1000);
 Tue, 23 May 2023 10:15:48 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.1 35/59] s390x/tcg: Fix LDER instruction format
Date: Tue, 23 May 2023 13:14:57 +0300
Message-Id: <20230523101536.85424-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.1-20230523131351@cover.tls.msk.ru>
References: <qemu-stable-8.0.1-20230523131351@cover.tls.msk.ru>
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

It's RRE, not RXE.

Found by running valgrind's none/tests/s390x/bfp-2.

Fixes: 86b59624c4aa ("s390x/tcg: Implement LOAD LENGTHENED short HFP to long HFP")
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20230511134726.469651-1-iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 970641de01908dd09b569965e78f13842e5854bc)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index 597d968b0e..1f1ac742a9 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -606,7 +606,7 @@
     F(0xed04, LDEB,    RXE,   Z,   0, m2_32u, new, f1, ldeb, 0, IF_BFP)
     F(0xed05, LXDB,    RXE,   Z,   0, m2_64, new_x, x1, lxdb, 0, IF_BFP)
     F(0xed06, LXEB,    RXE,   Z,   0, m2_32u, new_x, x1, lxeb, 0, IF_BFP)
-    F(0xb324, LDER,    RXE,   Z,   0, e2, new, f1, lde, 0, IF_AFP1)
+    F(0xb324, LDER,    RRE,   Z,   0, e2, new, f1, lde, 0, IF_AFP1)
     F(0xed24, LDE,     RXE,   Z,   0, m2_32u, new, f1, lde, 0, IF_AFP1)
 /* LOAD ROUNDED */
     F(0xb344, LEDBR,   RRF_e, Z,   0, f2, new, e1, ledb, 0, IF_BFP)
-- 
2.39.2


