Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A9C756F01
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 23:37:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLVsp-00023l-8X; Mon, 17 Jul 2023 17:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qLVsm-00022b-AB
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 17:35:52 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qLVsk-00083f-7K
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 17:35:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1689629746; x=1690234546; i=deller@gmx.de;
 bh=wnRg8SPQ0wYFmJrUrlN+dbul1Q8Xbd63TQUBTBR6cMc=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Rgioz8J8CXSE0T7sTG3hxkv/7cIr/snVhBgMYbLFX0r4h0sanUljTRVbDx690CmXgnH/mU0
 kNqmry34IWNw6VALXZT7U47JBijn0NUeU8WtxtB8z7eU3PiiSqRP3lQ5CsrnRpU4x/YB9lHjG
 BrwUwt5wx9dqIw8sCLje7geW90u+1l8ZwTilDNu4yOtnaEE4Af1imbl2fVrO1On/dTSd3STte
 cYDD+DvMV5oLLQrpn298SIG9WWp/C8/Y2HWMZZWlfjvLcRqu1zKvJeywnpvOZ1qOzElLqljIy
 p6KdIxM4hZjQVqrwTTwhz4jNSXLGNgjMtlnCg/trrU3efQSMUR/g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.159.97]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2V0H-1pwOY12HBH-013rFm; Mon, 17
 Jul 2023 23:35:46 +0200
From: Helge Deller <deller@gmx.de>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>,
 "Markus F . X . J . Oberhumer" <notifications@github.com>
Subject: [PATCH 2/6] linux-user: Fix qemu brk() to not zero bytes on current
 page
Date: Mon, 17 Jul 2023 23:35:41 +0200
Message-ID: <20230717213545.142598-3-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230717213545.142598-1-deller@gmx.de>
References: <20230717213545.142598-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Tv+VDVi0+XYHIjGqDMR9h0kS2ak6KWfpNssCP9EyR02VR2Ir7CM
 1f3/xT722ks1JZ3Hgv62jB/TMMTEWi+QQDGfH8DxG/o3GKz4WC7eH0hWj6cNTZ4xUf0paQr
 E0iEyj457s4RdvNwHTh7pnUNMQbtPeo6oa2Y6z3Hgbzbyd6PFp5iq/QVsNAiHJBQ/PpTztm
 qTkVDtOBj2ef9YhgLgjhw==
UI-OutboundReport: notjunk:1;M01:P0:5NM1riW7inA=;RX5C1JRcdU7etbEyoDpeJBnwZkk
 PXS0Q+tEKSA0UtJgxBDE0g8EhneDuMqV1SNfFSrkn+Jc1et4dyyneaDQDvyJ9XUedOP5Je7oh
 A8bP4gy6uIbLqzKE69ZHsccwJ5vxE7vjV1CWE36Uf9tIq1A9hTosWWbAQuFJI0mBM6oISj2wp
 UHExfKyFJRtpwsfDqnx3WTzo2ME/kiSodN4FjrRZEVTsUKk2jQ8kId5HMClesg+FC+imxXov2
 sXqjca+vun2qGvwrGoLujvdCWpxQGuZYIwvLhjl7/LXi2fCAj9OZ7JRXz32sg7NJMv09ayqzb
 wHs+q3rwqGmrRGaezjvvEnAEXtqrU1JWGC179tZZMx5ePF3V/8flptHZbkTjPs6VV+CInJWNQ
 rFNAz3s5cw98OF6C0mm0HKKPy9sy0V8eZvPfERJdjqE5agR1yA9Ld2v7hJycaS6vkzJmrXFx4
 WojiVAzuPj9+eojC124y6PhST5hXDUF+Bm++vn9MSvkwrmtdDMW8D3OEB7Y21Z0ZZaRR1yUWo
 Gn3AvPQgNaoDXs6A7tRz7F8PdWD52ogyTNPWRl2zDSq7cQeGKGYUal+NV2Y6K5Y0c5ujFT69u
 3W0AaPGw2oADSLD7+hgvjx/CxPiV7P6G0R9Th3dYweoCoHWPubpHmJa08KN5EQL8j29aX+2Fb
 TgXzsmJvJAkyKBj+wqXgxNjs9dpKiy3SukdHXukFK3bIvatApeMlUD5ngv9nJ1r6cTZhn4Ujc
 cIkkYLR1e6XkxlXXwnytcI2aDjEBN//vl97pZVIl6B0v2bszC+6ZS0i0PXqZS53nYLFvK66iL
 ioCK+t07jo0ZgUGmXezmqFUx3Q9C2mWhXJ7lTJx+G7vYroHKxK9MLUQJiMZQu37JaiVChUzOO
 zSXWFs6gaK5D0iQiYaXn1BXAe/sd3Qfo19gb/6EqIziEQf/6VqI+AuWxb1GKYdHnprHqEOr5a
 5/yXbOmw7sKP9uEesj7unc6IyB4=
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

The qemu brk() implementation is too aggressive and cleans remaining bytes
on the current page above the last brk address.
But some existing applications are buggy and read or write to bytes above
their current heap address. On a phyiscal machine this does not trigger
any runtime errors (as long as the accesses happen on the same page only)
since the Linux kernel allocates only full pages and does no zeroing on
already allocated pages.

So, fix qemu to behave the same way as the kernel does. Do not touch
already allocated pages, and - when running with different page sizes of
guest and host - zero out only those memory areas where the host have a
bigger page size than the guest.

Signed-off-by: Helge Deller <deller@gmx.de>
Tested-by: Markus F.X.J. Oberhumer <notifications@github.com>
Fixes: 86f04735ac ("linux-user: Fix brk() to release pages")
Buglink: https://github.com/upx/upx/issues/683
=2D--
 linux-user/syscall.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b9527ab00f..f877156ed3 100644
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


