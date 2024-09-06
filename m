Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0896C96F2A5
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Sep 2024 13:18:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smWxU-0007L3-40; Fri, 06 Sep 2024 07:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWwI-0001yV-Af; Fri, 06 Sep 2024 07:15:45 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWwG-00080o-Hj; Fri, 06 Sep 2024 07:15:42 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 532E98C48B;
 Fri,  6 Sep 2024 14:12:08 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 602371336F5;
 Fri,  6 Sep 2024 14:13:26 +0300 (MSK)
Received: (nullmailer pid 353630 invoked by uid 1000);
 Fri, 06 Sep 2024 11:13:24 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.3 27/69] target/arm: Avoid shifts by -1 in tszimm_shr()
 and tszimm_shl()
Date: Fri,  6 Sep 2024 14:12:36 +0300
Message-Id: <20240906111324.353230-27-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
References: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
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

From: Peter Maydell <peter.maydell@linaro.org>

The function tszimm_esz() returns a shift amount, or possibly -1 in
certain cases that correspond to unallocated encodings in the
instruction set.  We catch these later in the trans_ functions
(generally with an "a-esz < 0" check), but before we do the
decodetree-generated code will also call tszimm_shr() or tszimm_sl(),
which will use the tszimm_esz() return value as a shift count without
checking that it is not negative, which is undefined behaviour.

Avoid the UB by checking the return value in tszimm_shr() and
tszimm_shl().

Cc: qemu-stable@nongnu.org
Resolves: Coverity CID 1547617, 1547694
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240722172957.1041231-4-peter.maydell@linaro.org
(cherry picked from commit 76916dfa89e8900639c1055c07a295c06628a0bc)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index ada05aa530..466a19c25a 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -50,13 +50,27 @@ static int tszimm_esz(DisasContext *s, int x)
 
 static int tszimm_shr(DisasContext *s, int x)
 {
-    return (16 << tszimm_esz(s, x)) - x;
+    /*
+     * We won't use the tszimm_shr() value if tszimm_esz() returns -1 (the
+     * trans function will check for esz < 0), so we can return any
+     * value we like from here in that case as long as we avoid UB.
+     */
+    int esz = tszimm_esz(s, x);
+    if (esz < 0) {
+        return esz;
+    }
+    return (16 << esz) - x;
 }
 
 /* See e.g. LSL (immediate, predicated).  */
 static int tszimm_shl(DisasContext *s, int x)
 {
-    return x - (8 << tszimm_esz(s, x));
+    /* As with tszimm_shr(), value will be unused if esz < 0 */
+    int esz = tszimm_esz(s, x);
+    if (esz < 0) {
+        return esz;
+    }
+    return x - (8 << esz);
 }
 
 /* The SH bit is in bit 8.  Extract the low 8 and shift.  */
-- 
2.39.2


