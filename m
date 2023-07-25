Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1744B761B0E
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 16:11:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOIkN-0003cM-Oa; Tue, 25 Jul 2023 10:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOIk5-0003XJ-Vq; Tue, 25 Jul 2023 10:10:25 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOIk4-0007WW-Cg; Tue, 25 Jul 2023 10:10:25 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4F1C616168;
 Tue, 25 Jul 2023 17:10:14 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id EA06519500;
 Tue, 25 Jul 2023 17:10:11 +0300 (MSK)
Received: (nullmailer pid 3372587 invoked by uid 1000);
 Tue, 25 Jul 2023 14:10:11 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.5 06/14] target/s390x: Make CKSM raise an exception if R2
 is odd
Date: Tue, 25 Jul 2023 17:10:00 +0300
Message-Id: <20230725141009.3372529-6-mjt@tls.msk.ru>
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

R2 designates an even-odd register pair; the instruction should raise
a specification exception when R2 is not even.

Cc: qemu-stable@nongnu.org
Fixes: e023e832d0ac ("s390x: translate engine for s390x CPU")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20230724082032.66864-2-iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 761b0aa9381e2f755b9b594f7f3033d564561751)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index 4249632af3..0e328ea0fd 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -157,7 +157,7 @@
     C(0xb2fa, NIAI,    E,     EH,  0, 0, 0, 0, 0, 0)
 
 /* CHECKSUM */
-    C(0xb241, CKSM,    RRE,   Z,   r1_o, ra2, new, r1_32, cksm, 0)
+    C(0xb241, CKSM,    RRE,   Z,   r1_o, ra2_E, new, r1_32, cksm, 0)
 
 /* COPY SIGN */
     F(0xb372, CPSDR,   RRF_b, FPSSH, f3, f2, new, f1, cps, 0, IF_AFP1 | IF_AFP2 | IF_AFP3)
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 0885bf2641..ba8b90f538 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -5992,6 +5992,12 @@ static void in2_ra2(DisasContext *s, DisasOps *o)
 }
 #define SPEC_in2_ra2 0
 
+static void in2_ra2_E(DisasContext *s, DisasOps *o)
+{
+    return in2_ra2(s, o);
+}
+#define SPEC_in2_ra2_E SPEC_r2_even
+
 static void in2_a2(DisasContext *s, DisasOps *o)
 {
     int x2 = have_field(s, x2) ? get_field(s, x2) : 0;
-- 
2.39.2


