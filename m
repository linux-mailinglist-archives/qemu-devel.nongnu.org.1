Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 763EF759A3F
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 17:54:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM9Tx-00071k-4j; Wed, 19 Jul 2023 11:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1qM9Tv-00070D-Kg; Wed, 19 Jul 2023 11:52:51 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1qM9Tt-0006Pv-G1; Wed, 19 Jul 2023 11:52:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1689781957; x=1690386757; i=deller@gmx.de;
 bh=Y2R6dhX3c4Smt/gWWNK5vjxqVT4qS1UdFbVRJHqxeWA=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fQkZNeAYbn2AIAEnlAZcPQzmNvkx0GCcxB6hCDciwCi2133Fp25ax+yHUlPodDCKIwBoxsY
 J+9tyg2iD275MGt0q2gL8gAqEEL46qvURl8dbQRDqej4j8ldzC39yk+Brs0zVYuX0W0rLZE5y
 Ppe2aX238tj6K6RYGXm/DGPTR3EZRf8BLSu2u4FpYRd56AJi8mW4p3hG/DsK5MBykttHBFj8j
 Z2NsKMx5EzWNKfKhVm65oitjc4eTn86za1IwRAtLX2LBW9MADcA8/leXK9djJdhQ060MUx02x
 R7LljgrUf13ikeHLQkgsP0nDC7jFVSf3YiLuB2gOUuLhMkA/p0Zw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.145.157]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVeI2-1qW9M934pI-00Ramw; Wed, 19
 Jul 2023 17:52:37 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Andreas Schwab <schwab@suse.de>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 "Markus F.X.J. Oberhumer" <markus@oberhumer.com>, qemu-stable@nongnu.org
Subject: [PULL 2/5] linux-user: Prohibit brk() to to shrink below initial heap
 address
Date: Wed, 19 Jul 2023 17:52:32 +0200
Message-ID: <20230719155235.244478-3-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719155235.244478-1-deller@gmx.de>
References: <20230719155235.244478-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OA5vYHshQY22MErZzwGYNNTa3R5JEFDzHdW7oPVlc61XFox7BMY
 Gw9W4K2e/Nn0pta7Ehhuc3d5vzInRsHrOAUV2490cUKHJcxcNmJCJE3l8BFuC7aIuN2XkAt
 TMjD0P9MD6aFlicMfjP6LYmDlVaYQgaocxzcf5VB+i82kfrZcX/kBbj4V8y2UZRxOka3kkL
 g25jpFvEfq/H35fz4mdYA==
UI-OutboundReport: notjunk:1;M01:P0:yu3NnRHu6Aw=;wHZxXWz/JfgvoKueP3mBqrkBB3i
 Lo4gXTSflQ7SsyZGgc/xXBA6zkr95p6L+tMFL3nryOBqlDIW0xqWeDlHKdsT1dQRrPRY7KEHG
 t4RZodf7biI7GXHGvkLLTYOojWqNRSycOvXnGFK/R4bsHQPiEF4yXPOwroWopo8PksVHh7fWm
 vL0TisIFGns6Bz9zEHshXvbP1SOcIoj48bJFLuUmSV+eyHF1+8Xxjrgp+hCc3/QxpfXVfmlcy
 vXM3NQWmaN+xBjVF0FpaSdErn+NP1O9uh06gOiHcXOgvCdI4k02nx9m3zTXKNZk4ke7JsQqJm
 ErH2BEg/0latpZiyIL2FvBvWInNgQoV9V2whWA61O9RXDs9nGZzNj6xOW9VRai3RWml6RLh0y
 WWeDne/BzbrMQp1mEBVo9yom2eC7lnDavkJmpcOd4fmDRDLVOvuJSsrOdRsSVZFS3ovlWsnmD
 5PlLq/FWWmOUc2nUKoJkm6OiKh6EHwx5zYxwDBKnnANmJP716n8dFeG/p3UI8vKxD0/GzaIjP
 yiHWi5/kUuwT+pe8TGsrRDlaRd813dA+FS0Q7ahyR9ZXt5vSC+z4+UYf/h11EUfSHkRMEpeYk
 F1HZmcZx3tNvJmVAp1S67Kpga5Q5EyiFPzQ8De7SETyEz0Club5M19DS72EeCWepFKbJfVbjE
 dVorekShyU/evVAbMogFKNRHL8nJQh3jiBnuz/VtNckmeOmugzIrXQk00Sf/7RBcurz6C9ZKj
 ti4ZGgqhykuXaFxIqBylYVurdy2s7pR0mHptYox09IIxx076D0YujCm2IwRj5ouypRTXkmqef
 EEAKmhwrxgaUSGu/wko1SbIP2VIHb2dM+nw8o3xeJTbcG0TRAlUeVq7C0AfmYtpEp91Sc32kP
 LMvlS+RBB9kig4oCGsiZR8tk6Yz8uje0YOsbvRkrNj43P8jkv403QDes+e9ifUeRyhl5pnvqt
 hpEHtPMEKFPt5MWlsnC4dR3TD5I=
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Since commit 86f04735ac ("linux-user: Fix brk() to release pages") it's
possible for userspace applications to reduce their memory footprint by
calling brk() with a lower address and free up memory. Before that commit
guest heap memory was never unmapped.

But the Linux kernel prohibits to reduce brk() below the initial memory
address which is set at startup by the set_brk() function in binfmt_elf.c.
Such a range check was missed in commit 86f04735ac.

This patch adds the missing check by storing the initial brk value in
initial_target_brk and verify any new brk addresses against that value.

Tested with the i386 upx binary from
https://github.com/upx/upx/releases/download/v4.0.2/upx-4.0.2-i386_linux.t=
ar.xz

Signed-off-by: Helge Deller <deller@gmx.de>
Tested-by: "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
Fixes: 86f04735ac ("linux-user: Fix brk() to release pages")
Cc: qemu-stable@nongnu.org
Buglink: https://github.com/upx/upx/issues/683
=2D--
 linux-user/syscall.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index ee54eed33b..125fcbe423 100644
=2D-- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -801,12 +801,13 @@ static inline int host_to_target_sock_type(int host_=
type)
     return target_type;
 }

-static abi_ulong target_brk;
+static abi_ulong target_brk, initial_target_brk;
 static abi_ulong brk_page;

 void target_set_brk(abi_ulong new_brk)
 {
     target_brk =3D TARGET_PAGE_ALIGN(new_brk);
+    initial_target_brk =3D target_brk;
     brk_page =3D HOST_PAGE_ALIGN(target_brk);
 }

@@ -824,6 +825,11 @@ abi_long do_brk(abi_ulong brk_val)
         return target_brk;
     }

+    /* do not allow to shrink below initial brk value */
+    if (brk_val < initial_target_brk) {
+        brk_val =3D initial_target_brk;
+    }
+
     new_brk =3D TARGET_PAGE_ALIGN(brk_val);
     new_host_brk_page =3D HOST_PAGE_ALIGN(brk_val);

=2D-
2.41.0


