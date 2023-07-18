Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 311CC758522
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 20:54:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLpom-0000vE-9M; Tue, 18 Jul 2023 14:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1qLpoj-0000um-2D; Tue, 18 Jul 2023 14:53:01 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1qLpod-0003O5-45; Tue, 18 Jul 2023 14:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1689706364; x=1690311164; i=deller@gmx.de;
 bh=efVESnAW6H7a8ZymmHelPG4JpfCKaU44b+i4/YpA37k=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=TiKGCoq0p9LSPPN6puDPiGgBV/zT+k/L/zBJAmso8cy/EPnMvFAc9Zi0pitJ+1skephS/eh
 nH09tuAKvpvgESfN4L/1ja7ONn8MCNyhHZtuwKity72EE0I7N0Rj9I2+IOJ8kR4RYfKXDuwDE
 SL31jn+m12yKdCNYOyirEd4DRGWfloyWi4YvUwvaIUMgEimt82hxcGBJfjZ0gTajyRDC8ArW8
 W27OGkENoeOgLVCiY0IN+DkU+ufJPytEueJ7vvDlwTVG4irzk0OYA2IGYDcU/FHXHNooez2jp
 Pau3gvIw+FB4CbdHwGMhcx6ihWhINF7AGavPSVETtRD+Xnx+2f6Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.159.74]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5wLZ-1qJKZE3dAh-007XUP; Tue, 18
 Jul 2023 20:52:43 +0200
From: Helge Deller <deller@gmx.de>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Andreas Schwab <schwab@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>,
 "Markus F.X.J. Oberhumer" <markus@oberhumer.com>, qemu-stable@nongnu.org
Subject: [PATCH v2 1/5] linux-user: Fix qemu brk() to not zero bytes on
 current page
Date: Tue, 18 Jul 2023 20:52:37 +0200
Message-ID: <20230718185241.11433-2-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230718185241.11433-1-deller@gmx.de>
References: <20230718185241.11433-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:26V3d8PsRKflThy3WAo2Ip2YHyW3V+xMCvIF7YDXmeUcC8gaWvf
 FJjpl/V0MyooyejRqwsEclmDI7gFKQX6U1YnheD9/cQ3q8utcld9Re0Is1nMw/u8P4dOJf3
 Rx1cw4mwtNSK/325gx4ydCXEbX1thSDR7yCsTMa9PI5dWNKotrsFZb3epoSNyJ/OJkmK9iG
 Mq1+DQlDym0C63mpYMG1Q==
UI-OutboundReport: notjunk:1;M01:P0:hdFHamfIf6I=;hj5vA0ZCSPVXLsFEAh6DHM3lHzq
 AXPx2mwEEOALCxauIkDpUIoH+JDUnR8B8kz9GV8wyUe23bWbeMntiAESPkRL3Q6sDFaKHMt+L
 pqkdKWCPUYfjPaeGQVRxZIoXseIaJ5Rt8CU0oB9CAHbby7sv9vDhmh2JTOb111bD4ne6Wc7WS
 9EFyhJB/ljwmfrl7hDjWDfiukIuL1UbzoL4dorJoov2hU5zmlPp+dzD5OYRdlpP9TAT2MyGW1
 ZN6ZivFI3V+7vge6zD3+1endG4J+vQlqXxS1F45pNSz9bPEwPe84dMFyLEY6SasNzJhAVA24f
 cp3FS3FI9c1iC7PONi1ky2zpDyNQvml7HJVqVfKbOWoVxB8h/VeAFwIT5lpjcWkDZ/0h8MXYn
 Am+zfsEQC2hvaEw9ZJUMkQy7wd3vnwspaiS/UcSYC1lnF95dpBUcM6Wa/zLYg+d90nFXoUQOl
 E8wYbvpc3Jr5SduMuK5iyjY/0hHEydMdmCzVID3Q4WGMNeazSelN4TCvFA20U0Xw9UQrXw1HB
 ZneMVBuR2iTYPGebbZA9rZqJAs74gR1TlNWVD4Z2yh5o4wzzL/fjZBK5KmdYRFKk9dmokkool
 iWSNyO6MeRiD18RX8LMQT8kDBWVqDPJBKkhji9GCREUkLpD0CkNn+iE8IWM/xAeyvi3ND2tTY
 Fo5yHNnmeGk7k82suUQ5BC80XMJXNq5/KepqiESJystWi5PHzOHofn/Xe7pchT1xF6gRv/jmE
 UZo+lssKrCrcwyXmETFsJUoZ+RWPDr63x1nFYBjBRqoL2BOOYvqKoZO2xQRN2Z4CilqS9eWJl
 S/d+f71PsOKvGxC7rcC3/Uh0todx9Kcw0JQvWvr5VZFDL5ANnuLR4PZVZWGwFVcP26Z/0aFBK
 Jyeibb2jpFuzt8VuSE8QWx7cCdMF+5JlhFbP5zFpFH1CPkUSEkXjQPDIqzNb2wVR+XeV4E5wz
 KTmCUc2z6pCAfP/3tOTRC7p5nyQ=
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

The qemu brk() implementation is too aggressive and cleans remaining bytes
on the current page above the last brk address.

But some existing applications are buggy and read/write bytes above their
current heap address. On a phyiscal machine this does not trigger a
runtime error as long as the access happens on the same page. Additionally
the Linux kernel allocates only full pages and does no zeroing on already
allocated pages, even if the brk address is lowered.

Fix qemu to behave the same way as the kernel does. Do not touch already
allocated pages, and - when running with different page sizes of guest and
host - zero out only those memory areas where the host page size is bigger
than the guest page size.

Signed-off-by: Helge Deller <deller@gmx.de>
Tested-by: "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
Fixes: 86f04735ac ("linux-user: Fix brk() to release pages")
Cc: qemu-stable@nongnu.org
Buglink: https://github.com/upx/upx/issues/683
=2D--
 linux-user/syscall.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index c99ef9c01e..ee54eed33b 100644
=2D-- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -829,10 +829,8 @@ abi_long do_brk(abi_ulong brk_val)

     /* brk_val and old target_brk might be on the same page */
     if (new_brk =3D=3D TARGET_PAGE_ALIGN(target_brk)) {
-        if (brk_val > target_brk) {
-            /* empty remaining bytes in (possibly larger) host page */
-            memset(g2h_untagged(target_brk), 0, new_host_brk_page - targe=
t_brk);
-        }
+        /* empty remaining bytes in (possibly larger) host page */
+        memset(g2h_untagged(new_brk), 0, new_host_brk_page - new_brk);
         target_brk =3D brk_val;
         return target_brk;
     }
@@ -840,7 +838,7 @@ abi_long do_brk(abi_ulong brk_val)
     /* Release heap if necesary */
     if (new_brk < target_brk) {
         /* empty remaining bytes in (possibly larger) host page */
-        memset(g2h_untagged(brk_val), 0, new_host_brk_page - brk_val);
+        memset(g2h_untagged(new_brk), 0, new_host_brk_page - new_brk);

         /* free unused host pages and set new brk_page */
         target_munmap(new_host_brk_page, brk_page - new_host_brk_page);
@@ -873,7 +871,7 @@ abi_long do_brk(abi_ulong brk_val)
          * come from the remaining part of the previous page: it may
          * contains garbage data due to a previous heap usage (grown
          * then shrunken).  */
-        memset(g2h_untagged(target_brk), 0, brk_page - target_brk);
+        memset(g2h_untagged(brk_page), 0, HOST_PAGE_ALIGN(brk_page) - brk=
_page);

         target_brk =3D brk_val;
         brk_page =3D new_host_brk_page;
=2D-
2.41.0


