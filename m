Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAE776B88A
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 17:24:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQrDC-0007PW-7Y; Tue, 01 Aug 2023 11:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1qQrD3-0007Oe-1g
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 11:22:53 -0400
Received: from home.keithp.com ([63.227.221.253] helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1qQrD0-0004Xg-Vw
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 11:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1690903368; bh=QxE/0O5liIONigBKZX1v38PB9OIl12V4gNKWlUP0/gY=;
 h=From:To:Cc:Subject:Date:From;
 b=vRvOuuZ/bDov9bWzGJq/35DKDNVQ7p5kz0gYhQrvd4KmeBdGwlXIPuzvKF5/9pFLD
 ZdQYh9rnDKRK+NqvLrsghZBzE4fnzXeOhHM7EpM+S+tc55o8DvcnyNt+l+9NKXEZDO
 V7xB3rUyeeBZUeX2KFszHuoYfxKWGr89QUbBDxVkimMUrcQT7YX6jLEeAf5X+i+tIM
 vu330sqjnbtwMnUQHYZCmmiN9VsTqPBMJFmgahWHFZ1NDohaV9T3SdaxxLBgkkerKc
 vDbLi+PPNP4shf7bVKq2T2uvMBRzi5kGuXUSDFI/HEyKPgHDQOdg1VhdzdUdSitYyB
 R5ZDoqrblUBKw==
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id 21EFC3F206C6;
 Tue,  1 Aug 2023 08:22:48 -0700 (PDT)
X-Virus-Scanned: Debian amavis at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavis, port 10024) with LMTP
 id wIiG7u1rMDGy; Tue,  1 Aug 2023 08:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1690903367; bh=QxE/0O5liIONigBKZX1v38PB9OIl12V4gNKWlUP0/gY=;
 h=From:To:Cc:Subject:Date:From;
 b=Ibtmrn+dh/latRuTQzxLIvq3tSWmkkGn7Z/l8P+IJ5Z7zvGPdl4w+0ju0JuhKjOtP
 jM/Dvtzc87GxRgdTAViQ2HYN4k6nGF7FzwtBix4Vqc3YvGaUzRiTl5/NCHx5cF6b54
 SRsL7wdhEcCPotUHZCYlfiiLzivU2pWGM4/WV0DbMaNDn9UP9QUYwPFcPgUgSlWaXn
 a0SMJvhbmON2wEeD86OlIvozn1qJHczlTGAjPqDyIHdNAmL40NYcX9Bz5vFaTuGdpm
 GMFL4KIShwBBPDMdAHRbwAXaCXtJ58Sn1hZRiUoGnOpYGHIrGvXuWMqMlJu3oWVWcH
 J+z0N3hbMGpyA==
Received: from keithp.com (koto.keithp.com [192.168.11.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id 56EB03F20587;
 Tue,  1 Aug 2023 08:22:47 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1000)
 id 4010F1E601E7; Tue,  1 Aug 2023 08:22:47 -0700 (PDT)
To: qemu-devel@nongnu.org
Cc: Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>,
 Keith Packard <keithp@keithp.com>
Subject: [PATCH] target/nios2: Pass semihosting arg to exit
Date: Tue,  1 Aug 2023 08:22:45 -0700
Message-Id: <20230801152245.332749-1-keithp@keithp.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.227.221.253; envelope-from=keithp@keithp.com;
 helo=elaine.keithp.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Keith Packard <keithp@keithp.com>
From:  Keith Packard via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Instead of using R_ARG0 (the semihost function number), use R_ARG1
(the provided exit status).

Signed-off-by: Keith Packard <keithp@keithp.com>
---
 target/nios2/nios2-semi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/nios2/nios2-semi.c b/target/nios2/nios2-semi.c
index 3738774976..f3b7aee4f1 100644
--- a/target/nios2/nios2-semi.c
+++ b/target/nios2/nios2-semi.c
@@ -133,8 +133,8 @@ void do_nios2_semihosting(CPUNios2State *env)
     args = env->regs[R_ARG1];
     switch (nr) {
     case HOSTED_EXIT:
-        gdb_exit(env->regs[R_ARG0]);
-        exit(env->regs[R_ARG0]);
+        gdb_exit(env->regs[R_ARG1]);
+        exit(env->regs[R_ARG1]);
 
     case HOSTED_OPEN:
         GET_ARG(0);
-- 
2.40.1


