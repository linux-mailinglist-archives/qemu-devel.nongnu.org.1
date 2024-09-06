Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BAE96F2FB
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Sep 2024 13:24:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smWzf-0005Th-Tm; Fri, 06 Sep 2024 07:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWzZ-0004uW-8N; Fri, 06 Sep 2024 07:19:05 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWzX-0008KB-Hd; Fri, 06 Sep 2024 07:19:04 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 735588C4AE;
 Fri,  6 Sep 2024 14:12:10 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 806FA133717;
 Fri,  6 Sep 2024 14:13:28 +0300 (MSK)
Received: (nullmailer pid 353745 invoked by uid 1000);
 Fri, 06 Sep 2024 11:13:25 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.3 61/69] target/sparc: Restrict STQF to sparcv9
Date: Fri,  6 Sep 2024 14:13:10 +0300
Message-Id: <20240906111324.353230-61-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
References: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
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

Prior to sparcv9, the same encoding was STDFQ.

Cc: qemu-stable@nongnu.org
Fixes: 06c060d9e5b ("target/sparc: Move simple fp load/store to decodetree")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240816072311.353234-2-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 12d36294a2d978faf893101862118d1ac1815e85)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index e2d8a07dc4..d2b29de084 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -484,7 +484,7 @@ STF         11 ..... 100100 ..... . .............          @r_r_ri_na
 STFSR       11 00000 100101 ..... . .............          @n_r_ri
 STXFSR      11 00001 100101 ..... . .............          @n_r_ri
 {
-  STQF      11 ..... 100110 ..... . .............          @q_r_ri_na
+  STQF      11 ..... 100110 ..... . .............          @q_r_ri_na # v9
   STDFQ     11 ----- 100110 ----- - -------------
 }
 STDF        11 ..... 100111 ..... . .............          @d_r_ri_na
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 99c6f3cc72..9d5d0ae47c 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4151,7 +4151,7 @@ static bool do_st_fpr(DisasContext *dc, arg_r_r_ri_asi *a, MemOp sz)
 
 TRANS(STF, ALL, do_st_fpr, a, MO_32)
 TRANS(STDF, ALL, do_st_fpr, a, MO_64)
-TRANS(STQF, ALL, do_st_fpr, a, MO_128)
+TRANS(STQF, 64, do_st_fpr, a, MO_128)
 
 TRANS(STFA, 64, do_st_fpr, a, MO_32)
 TRANS(STDFA, 64, do_st_fpr, a, MO_64)
-- 
2.39.2


