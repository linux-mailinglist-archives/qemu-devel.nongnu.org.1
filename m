Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 729F675DB06
	for <lists+qemu-devel@lfdr.de>; Sat, 22 Jul 2023 10:27:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qN7wZ-0000gl-My; Sat, 22 Jul 2023 04:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qN7wX-0000gR-4T; Sat, 22 Jul 2023 04:26:25 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qN7wV-0004Wp-97; Sat, 22 Jul 2023 04:26:24 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6C57D158D2;
 Sat, 22 Jul 2023 11:26:24 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id DF8FF18A3A;
 Sat, 22 Jul 2023 11:26:17 +0300 (MSK)
Received: (nullmailer pid 3254054 invoked by uid 1000);
 Sat, 22 Jul 2023 08:26:17 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 Andreas Schwab <schwab@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH] limit brk adjustment wrt interp.brk to arm32 only for now
Date: Sat, 22 Jul 2023 11:26:16 +0300
Message-Id: <20230722082616.3254040-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
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

Commit 518f32221af7 "linux-user: Fix qemu-arm to run static armhf binaries"
added brk value adjustment to interpreter brk value after loading the
interpreter. Unfortunately this broke aarch64, ppc64el and s390x emulation, -
the error which we had on armhf now happens on at least these 3 architectures.
For the time being, limit the adjustment to aarch32 case only (where the prob
originally observed), to be analyzed in more details later.

This is a quick band-aid, not a real fix.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 linux-user/elfload.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 88c6861d7d..08e09b6863 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3617,15 +3617,18 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
     }
 
     if (elf_interpreter) {
         load_elf_interp(elf_interpreter, &interp_info, bprm->buf);
+#if defined(TARGET_ARM) && !defined(TARGET_AARCH64)
+/* FIXME: this breaks aarch64, ppc64el, s390x, hence the #if for now */
         /*
          * adjust brk address if the interpreter was loaded above the main
          * executable, e.g. happens with static binaries on armhf
          */
         if (interp_info.brk > info->brk) {
             info->brk = interp_info.brk;
         }
+#endif
 
         /* If the program interpreter is one of these two, then assume
            an iBCS2 image.  Otherwise assume a native linux image.  */
 
-- 
2.39.2


