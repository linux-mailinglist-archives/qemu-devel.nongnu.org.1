Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8244A927E5D
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jul 2024 23:01:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPTZe-0006QE-PS; Thu, 04 Jul 2024 17:01:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sPTZc-0006My-0E; Thu, 04 Jul 2024 17:01:00 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sPTZZ-0004II-KO; Thu, 04 Jul 2024 17:00:59 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 62D0F7755E;
 Fri,  5 Jul 2024 00:00:50 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 79B6DFEC98;
 Fri,  5 Jul 2024 00:00:55 +0300 (MSK)
Received: (nullmailer pid 1507715 invoked by uid 1000);
 Thu, 04 Jul 2024 21:00:55 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.2 01/22] target/i386: fix size of EBP writeback in
 gen_enter()
Date: Fri,  5 Jul 2024 00:00:31 +0300
Message-Id: <20240704210055.1507652-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.2-20240704162154@cover.tls.msk.ru>
References: <qemu-stable-9.0.2-20240704162154@cover.tls.msk.ru>
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

The calculation of FrameTemp is done using the size indicated by mo_pushpop()
before being written back to EBP, but the final writeback to EBP is done using
the size indicated by mo_stacksize().

In the case where mo_pushpop() is MO_32 and mo_stacksize() is MO_16 then the
final writeback to EBP is done using MO_16 which can leave junk in the top
16-bits of EBP after executing ENTER.

Change the writeback of EBP to use the same size indicated by mo_pushpop() to
ensure that the full value is written back.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2198
Message-ID: <20240606095319.229650-5-mark.cave-ayland@ilande.co.uk>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 3973615e7fbaeef1deeaa067577e373781ced70a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index a55df176c6..26ed900f34 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2684,7 +2684,7 @@ static void gen_enter(DisasContext *s, int esp_addend, int level)
     }
 
     /* Copy the FrameTemp value to EBP.  */
-    gen_op_mov_reg_v(s, a_ot, R_EBP, s->T1);
+    gen_op_mov_reg_v(s, d_ot, R_EBP, s->T1);
 
     /* Compute the final value of ESP.  */
     tcg_gen_subi_tl(s->T1, s->T1, esp_addend + size * level);
-- 
2.39.2


