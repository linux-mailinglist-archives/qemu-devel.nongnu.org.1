Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01298761B24
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 16:13:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOIk2-0003Rl-Hx; Tue, 25 Jul 2023 10:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOIk0-0003Ql-M2; Tue, 25 Jul 2023 10:10:20 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOIjy-0007SS-TD; Tue, 25 Jul 2023 10:10:20 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A5D2316165;
 Tue, 25 Jul 2023 17:10:13 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 578B8194FD;
 Tue, 25 Jul 2023 17:10:11 +0300 (MSK)
Received: (nullmailer pid 3372578 invoked by uid 1000);
 Tue, 25 Jul 2023 14:10:11 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Helge Deller <deller@gmx.de>,
 Andreas Schwab <schwab@suse.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.5 03/14] linux-user: Fix qemu-arm to run static armhf
 binaries
Date: Tue, 25 Jul 2023 17:09:57 +0300
Message-Id: <20230725141009.3372529-3-mjt@tls.msk.ru>
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

From: Helge Deller <deller@gmx.de>

qemu-user crashes immediately when running static binaries on the armhf
architecture. The problem is the memory layout where the executable is
loaded before the interpreter library, in which case the reserved brk
region clashes with the interpreter code and is released before qemu
tries to start the program.

At load time qemu calculates a brk value for interpreter and executable
each.  The fix is to choose the higher one of both.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: Andreas Schwab <schwab@suse.de>
Cc: qemu-stable@nongnu.org
Reported-by:  Venkata.Pyla@toshiba-tsip.com
Closes: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1040981
(cherry picked from commit 518f32221af759a29500ac172c4c857bef142067)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 20894b633f..fdc95f8cf6 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3553,6 +3553,13 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
 
     if (elf_interpreter) {
         load_elf_interp(elf_interpreter, &interp_info, bprm->buf);
+        /*
+         * adjust brk address if the interpreter was loaded above the main
+         * executable, e.g. happens with static binaries on armhf
+         */
+        if (interp_info.brk > info->brk) {
+            info->brk = interp_info.brk;
+        }
 
         /* If the program interpreter is one of these two, then assume
            an iBCS2 image.  Otherwise assume a native linux image.  */
-- 
2.39.2


