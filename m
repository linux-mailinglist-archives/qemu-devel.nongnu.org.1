Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C402993728
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Oct 2024 21:20:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxtH8-0001PU-Il; Mon, 07 Oct 2024 15:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sxtGE-00076A-8R; Mon, 07 Oct 2024 15:19:15 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sxtG2-0004MJ-TC; Mon, 07 Oct 2024 15:19:13 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AFBAA96256;
 Mon,  7 Oct 2024 22:16:49 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 86CCD14F736;
 Mon,  7 Oct 2024 22:16:56 +0300 (MSK)
Received: (nullmailer pid 2592777 invoked by uid 1000);
 Mon, 07 Oct 2024 19:16:54 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Claudio Fontana <cfontana@suse.de>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.1 25/32] target/ppc: Fix lxvx/stxvx facility check
Date: Mon,  7 Oct 2024 22:16:42 +0300
Message-Id: <20241007191654.2592616-25-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.1-20241007221311@cover.tls.msk.ru>
References: <qemu-stable-9.1.1-20241007221311@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Fabiano Rosas <farosas@suse.de>

The XT check for the lxvx/stxvx instructions is currently
inverted. This was introduced during the move to decodetree.

>From the ISA:
  Chapter 7. Vector-Scalar Extension Facility
  Load VSX Vector Indexed X-form

  lxvx XT,RA,RB
  if TX=0 & MSR.VSX=0 then VSX_Unavailable()
  if TX=1 & MSR.VEC=0 then Vector_Unavailable()
  ...
  Let XT be the value 32×TX + T.

The code currently does the opposite:

    if (paired || a->rt >= 32) {
        REQUIRE_VSX(ctx);
    } else {
        REQUIRE_VECTOR(ctx);
    }

This was already fixed for lxv/stxv at commit "2cc0e449d1 (target/ppc:
Fix lxv/stxv MSR facility check)", but the indexed forms were missed.

Cc: qemu-stable@nongnu.org
Fixes: 70426b5bb7 ("target/ppc: moved stxvx and lxvx from legacy to decodtree")
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Claudio Fontana <cfontana@suse.de>
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Message-ID: <20240911141651.6914-1-farosas@suse.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 8bded2e73e80823a67f730140788a3c5e60bf4b5)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/ppc/translate/vsx-impl.c.inc b/target/ppc/translate/vsx-impl.c.inc
index 40a87ddc4a..a869f30e86 100644
--- a/target/ppc/translate/vsx-impl.c.inc
+++ b/target/ppc/translate/vsx-impl.c.inc
@@ -2244,7 +2244,7 @@ static bool do_lstxv_PLS_D(DisasContext *ctx, arg_PLS_D *a,
 
 static bool do_lstxv_X(DisasContext *ctx, arg_X *a, bool store, bool paired)
 {
-    if (paired || a->rt >= 32) {
+    if (paired || a->rt < 32) {
         REQUIRE_VSX(ctx);
     } else {
         REQUIRE_VECTOR(ctx);
-- 
2.39.5


