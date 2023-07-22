Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC7575DD8E
	for <lists+qemu-devel@lfdr.de>; Sat, 22 Jul 2023 19:01:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNFxd-0002XZ-Bs; Sat, 22 Jul 2023 13:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qNFxY-0002WO-ON
 for qemu-devel@nongnu.org; Sat, 22 Jul 2023 13:00:00 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qNFxW-0005ox-HM
 for qemu-devel@nongnu.org; Sat, 22 Jul 2023 13:00:00 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 94DE31593F;
 Sat, 22 Jul 2023 19:59:51 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 7004B18A6E;
 Sat, 22 Jul 2023 19:59:44 +0300 (MSK)
Received: (nullmailer pid 3267239 invoked by uid 1000);
 Sat, 22 Jul 2023 16:59:44 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 Andreas Schwab <schwab@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 1/1] Revert "linux-user: Fix qemu-arm to run static armhf
 binaries"
Date: Sat, 22 Jul 2023 19:59:42 +0300
Message-Id: <4ea3fa99bebe8f153e74cf625980183cfd2238f6.1690045088.git.mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1690045088.git.mjt@tls.msk.ru>
References: <cover.1690045088.git.mjt@tls.msk.ru>
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

This reverts commit 518f32221af759a29500ac172c4c857bef142067.

It is causing similar segfaults at least on aarch64, ppc64el
and s390x. Let's revert this one for now and analyze what's
going on later.

Reopens: https://bugs.debian.org/1040981
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 linux-user/elfload.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 88c6861d7d..861ec07abc 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3618,13 +3618,6 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
 
     if (elf_interpreter) {
         load_elf_interp(elf_interpreter, &interp_info, bprm->buf);
-        /*
-         * adjust brk address if the interpreter was loaded above the main
-         * executable, e.g. happens with static binaries on armhf
-         */
-        if (interp_info.brk > info->brk) {
-            info->brk = interp_info.brk;
-        }
 
         /* If the program interpreter is one of these two, then assume
            an iBCS2 image.  Otherwise assume a native linux image.  */
-- 
2.39.2


