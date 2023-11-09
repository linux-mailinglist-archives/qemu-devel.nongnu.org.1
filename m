Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C4D7E6BC0
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 14:55:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15Nv-0001iU-HN; Thu, 09 Nov 2023 08:47:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15NP-0007vG-Ae; Thu, 09 Nov 2023 08:47:19 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15NM-00028q-N5; Thu, 09 Nov 2023 08:47:18 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8202C31B1F;
 Thu,  9 Nov 2023 16:43:14 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 927E9344C5;
 Thu,  9 Nov 2023 16:43:06 +0300 (MSK)
Received: (nullmailer pid 1461879 invoked by uid 1000);
 Thu, 09 Nov 2023 13:43:02 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.3 39/55] target/arm: Fix A64 LDRA immediate decode
Date: Thu,  9 Nov 2023 16:42:43 +0300
Message-Id: <20231109134300.1461632-39-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
References: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
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

From: Peter Maydell <peter.maydell@linaro.org>

In commit be23a049 in the conversion to decodetree we broke the
decoding of the immediate value in the LDRA instruction.  This should
be a 10 bit signed value that is scaled by 8, but in the conversion
we incorrectly ended up scaling it only by 2.  Fix the scaling
factor.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1970
Fixes: be23a049 ("target/arm: Convert load (pointer auth) insns to decodetree")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20231106113445.1163063-1-peter.maydell@linaro.org
(cherry picked from commit 5722fc471296d5f042df4b005a851cc8008df0c9)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index ef64a3f9cb..7e09fd18b4 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -461,7 +461,7 @@ LDAPR           sz:2 111 0 00 1 0 1 11111 1100 00 rn:5 rt:5
 # Load/store register (pointer authentication)
 
 # LDRA immediate is 10 bits signed and scaled, but the bits aren't all contiguous
-%ldra_imm       22:s1 12:9 !function=times_2
+%ldra_imm       22:s1 12:9 !function=times_8
 
 LDRA            11 111 0 00 m:1 . 1 ......... w:1 1 rn:5 rt:5 imm=%ldra_imm
 
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index d1cacff0b2..1afcd16ab1 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -203,6 +203,11 @@ static inline int times_4(DisasContext *s, int x)
     return x * 4;
 }
 
+static inline int times_8(DisasContext *s, int x)
+{
+    return x * 8;
+}
+
 static inline int times_2_plus_1(DisasContext *s, int x)
 {
     return x * 2 + 1;
-- 
2.39.2


