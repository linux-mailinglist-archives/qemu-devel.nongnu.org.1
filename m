Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 525BE9C2D0F
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Nov 2024 13:35:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9kOy-0005GZ-QN; Sat, 09 Nov 2024 07:17:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kO1-0004ZT-50; Sat, 09 Nov 2024 07:16:17 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kNz-00059f-Ck; Sat, 09 Nov 2024 07:16:16 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 84DF0A1637;
 Sat,  9 Nov 2024 15:08:07 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 4A4E8167FBE;
 Sat,  9 Nov 2024 15:09:02 +0300 (MSK)
Received: (nullmailer pid 3296169 invoked by uid 1000);
 Sat, 09 Nov 2024 12:09:01 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.2 14/58] linux-user/ppc: Fix sigmask endianness issue in
 sigreturn
Date: Sat,  9 Nov 2024 15:08:15 +0300
Message-Id: <20241109120901.3295995-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.2-20241109150812@cover.tls.msk.ru>
References: <qemu-stable-9.1.2-20241109150812@cover.tls.msk.ru>
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

do_setcontext() copies the target sigmask without endianness handling
and then uses target_to_host_sigset_internal(), which expects a
byte-swapped one. Use target_to_host_sigset() instead.

Fixes: bcd4933a23f1 ("linux-user: ppc signal handling")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241017125811.447961-2-iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 8704132805cf7a3259d1c5a073b3c2b92afa2616)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/ppc/signal.c b/linux-user/ppc/signal.c
index a1d8c0bccc..24e5a02a78 100644
--- a/linux-user/ppc/signal.c
+++ b/linux-user/ppc/signal.c
@@ -628,7 +628,7 @@ static int do_setcontext(struct target_ucontext *ucp, CPUPPCState *env, int sig)
     if (!lock_user_struct(VERIFY_READ, mcp, mcp_addr, 1))
         return 1;
 
-    target_to_host_sigset_internal(&blocked, &set);
+    target_to_host_sigset(&blocked, &set);
     set_sigmask(&blocked);
     restore_user_regs(env, mcp, sig);
 
-- 
2.39.5


