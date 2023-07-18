Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9138675851C
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 20:54:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLpoo-0000wQ-LN; Tue, 18 Jul 2023 14:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1qLpok-0000v7-M0; Tue, 18 Jul 2023 14:53:02 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1qLpod-0003O7-45; Tue, 18 Jul 2023 14:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1689706364; x=1690311164; i=deller@gmx.de;
 bh=QndR1JShYxuIGvq9fxtuUmSM0VG5DS7IN52I1fXIGAw=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=X0uYX//QpGBItdWR8W/nkwxs5l7ohmNYDtnoAs91icp6LNHCZ+U3hMiXPB36WHfIBCicCoW
 rYicHt5hu6Qz/9UuaDcmPuugNyFof+IOkcWk/nx9fR3cUHDBtZ0qX/I9NtdVrttolwjTi/Xej
 aGzHLJXTF3ZY9Zj1XS0kHb5qnmtthhvgzQF12pnvp6yV0WAB39YtRu9ql5sR+LxJnc957vM9C
 wwpQjZ/7lZk6LCXRW8FaBKqriHrbEDVCleXHzPzTOPIp9rVMvel/g/CbGvzPY3gezGI3AtpTb
 BY36DGy0w1H2QS5X8iVNFs4XDIAW2YAfDwMDoAycp1TRDVRLN/GQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.159.74]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0XCw-1pyVb610r6-00wTJe; Tue, 18
 Jul 2023 20:52:44 +0200
From: Helge Deller <deller@gmx.de>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Andreas Schwab <schwab@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>,
 "Markus F.X.J. Oberhumer" <markus@oberhumer.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH v2 3/5] linux-user: Fix signed math overflow in brk() syscall
Date: Tue, 18 Jul 2023 20:52:39 +0200
Message-ID: <20230718185241.11433-4-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230718185241.11433-1-deller@gmx.de>
References: <20230718185241.11433-1-deller@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FnEnS4MBuGuiyF5GalAz3XXr5XaQc9V2PMWB++QvF4nd3A4IcYe
 NiYT6YW/d/GDgFl0pbRByz2AvJtUt59mBBaK5WUbcqf07RWEMhsymJMv7GBM4qMpNqicyow
 LGhInJ9oumkM2q4otlUTFBKRqkwBIJmlyUf9dFXJaFiSGePCVUdQQ1og7YagBZ7nj8Y3Ojb
 Mu4Ky1KGEQ6umqtQy/kig==
UI-OutboundReport: notjunk:1;M01:P0:V3TWnA8EgoE=;b/RECnGFcxMgtjc/zTdT6BAzQAw
 Kc46MX0uWHYdWClE9KnKkCpC9pDgq74MhXpPAFdHMeso6jpS39OjbD87blgVwamR0fhk6MTnf
 h3Jm81vEfiP/414FXCvZOdXAr2h/F5QHFeJeseu95uT2DICr9/7BNafrLc3B1xYF/UMUbsXf0
 APbJvSvEqvA694LBOEVbQg0a4EeyvlAuCIHAPl3uv/6kRPJXnH3ONndKFJMH/fjauCP/77l3L
 lGvIy664dZHVgjd+qkXMQl/g7oi5ul35KlCVeJ1Lm8+Gqo2efe+ynAa4OnknOqJXnGoKL2Y3x
 2RNkWs4oq8wMwnS9de555WVIDXmSxmcFamn7E30IFykv9YBQQI+P4DINKSDUKr9oAs6AAeJYb
 H3Y+RitGCRPzkQGSqXnVJ7u7/N2PlXbvWGfBjCLh4gNseXGT6gljlWb/7MgcgZaWviYrR9NRg
 VkxVcCKmut+sNM5Ng+KrrxSflrDqXSAAdMBCQ8U7KSMxx4RH0nJg9ot3fGAHgIUuPTeEh3/XN
 Wl1LmBXrLX6PADFbHR1zoHNR9fhQl4/coy0k81TbuSQm79s0q590UfKvXCJyrOK043x206vKH
 6CH5GoXSFjtLG0RErVKqrh8bwjk1yiXRBqTQ2heiBiVy6jU9VJkzukWmkwpuxF5ZOBavqdy7u
 2VADMDaR8JjrxbbJ5wzGpEDxeYt0Xs8GjdE57HCf195fpUIR8R4ZVeu3Yiv8rpHux17dEkh72
 3jNdDGzPqnbmu2cLcFLJ/YqzfbsOAgUFcu+b6EgiRo0L9L/6SxLdbrqmGmNUc6tPO/DHHqMta
 R6eecw1zcr08nWskzH9zfM1w8MxW2BWnaViLbSEQY9HslQYHoSpkLLrwu3RwaQssEOrNLnOKE
 WflomhezPkJUkQtHshXKUupWoXFJn1sVm/JxyiFKemT4yPgkGiMA2zr0eM4kszbsrAia//pHj
 qAR5w28nZJP+QtQpmRjyKq24IH4=
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
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

Fix the math overflow when calculating the new_malloc_size.

new_host_brk_page and brk_page are unsigned integers. If userspace
reduces the heap, new_host_brk_page is lower than brk_page which results
in a huge positive number (but should actually be negative).

Fix it by adding a proper check and as such make the code more readable.

Signed-off-by: Helge Deller <deller@gmx.de>
Tested-by: "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
Fixes: 86f04735ac ("linux-user: Fix brk() to release pages")
Cc: qemu-stable@nongnu.org
Buglink: https://github.com/upx/upx/issues/683
=2D--
 linux-user/syscall.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 125fcbe423..95727a816a 100644
=2D-- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -860,12 +860,13 @@ abi_long do_brk(abi_ulong brk_val)
      * itself); instead we treat "mapped but at wrong address" as
      * a failure and unmap again.
      */
-    new_alloc_size =3D new_host_brk_page - brk_page;
-    if (new_alloc_size) {
+    if (new_host_brk_page > brk_page) {
+        new_alloc_size =3D new_host_brk_page - brk_page;
         mapped_addr =3D get_errno(target_mmap(brk_page, new_alloc_size,
                                         PROT_READ|PROT_WRITE,
                                         MAP_ANON|MAP_PRIVATE, 0, 0));
     } else {
+        new_alloc_size =3D 0;
         mapped_addr =3D brk_page;
     }

=2D-
2.41.0


