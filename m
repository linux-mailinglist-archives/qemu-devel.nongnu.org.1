Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3FC756F00
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 23:37:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLVsq-00024a-FK; Mon, 17 Jul 2023 17:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qLVsn-00023F-Tt
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 17:35:53 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qLVsk-00083j-GZ
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 17:35:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1689629747; x=1690234547; i=deller@gmx.de;
 bh=SVEf7aN/7yvN3zNDrj1ViH2aOCzxdiVcivng1Q+RCiA=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=kP/IBOBoESYlWYtWywB22lfkiiqW/Go7tYg7h+t/oBvRSdY3tBfDC+vgnAyVLfaFEmDQ6AR
 7y8eP9320uWdkOkjkwro6/xlLj+Ercz/T9RpR1RCYUlwj2uQ4VdpQSUDiAvQY1jk/bDHWEblR
 aoXdUMj7NfiSCxy1dPyagOvOwq/XjZB1YhDsycHzaybcaWQLHgLkeiLEGzQGwk4DjvPcd/m6g
 ZhSA3l/9IQ2G6R8QeOIPFzpHNomdOLDbAfPCTiTeozsGPKaC6izZG3Cjme/ek3Ri5vHuYAUxe
 JO5/4GCoUlVLGtExHmtPs90QRCnSoW0KwJEdFijTQrPL3O86yuLw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.159.97]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8GQs-1pqayw3q52-014AML; Mon, 17
 Jul 2023 23:35:46 +0200
From: Helge Deller <deller@gmx.de>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>,
 "Markus F . X . J . Oberhumer" <notifications@github.com>
Subject: [PATCH 4/6] linux-user: Fix signed math overflow in brk() syscall
Date: Mon, 17 Jul 2023 23:35:43 +0200
Message-ID: <20230717213545.142598-5-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230717213545.142598-1-deller@gmx.de>
References: <20230717213545.142598-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MIc9Pv/Sd/rhUh2mgW9+pMx7e0VJXG9F6mXc1/V5yrbyCh8Ev4g
 WaJ7K+vecYXc7zQzPdElr+4O61bCP/5IVBxNA+KxzrnEEopgFgG7YELezLhJUNv5lRdosZH
 gJRex/MvWxTjEwbuDsCm1Ad8ZTvQU38JXtBKkdRHA4N2FJj/m1xqNfDAXiTZ3CMuwNDQ4Cx
 z39nWjmROTqyw89hWAdbQ==
UI-OutboundReport: notjunk:1;M01:P0:NhOvFUn2Ub4=;Q8T5UU9c8MDCENkm7ua3ldbNbhH
 9Fd8mQYoI49WKGb35T23kTKSvYmlRkhlxOQw8ijiAVMjz39rRZK+YWgR3JZcnXhU5Cm1L8PzP
 UQDDu1L9BZ/0C2Xar/b7uD4uVYIkjhswioMesL5BKK2qoeUEf1K1JYPoTEEJ8ThvuCOQDEEO0
 LMNccsXNx08hkYKLkc249mkBim9qmD/2GKRoHRzCj7XGzsd0WDDRk4FlL791OZdcIlfOHkYAN
 1hjCvyVc7rBW1y8Dqgs0Ooxx1lMNaKd7lqf5yU62P3gb8B20O/x99R8IptHLft2Rm+QZp1iWr
 QDV8T7dm4OnXS80UYLSXvZr/jRN7z/dg1G34N5poAtwTMbKQvYeM1+U3CJ9w1XZQzb8wuaXFB
 q471wqp5ejAL3PUdYUmWEMlbTjz27KbYRO5jTbP8b78a4mIDdGbXl0NlGZN932WJNib0x37Yn
 /l/G02XQUct9vh4514EV435au6bNC+ecnvEh5CjCIkVPCcv8gOc9Dtce9xuPuTYKtmeqiWzn8
 o4okdRJz6Y/gyHaXd+OWISUv0tGG9YhyuZk3fXN+jCmb2oviXbnwlUQbwnzo4j5ylYL9/vftm
 M7VHp6KlYjd6+UNypuT+HjWJNhXjWIEaiiDJAEc8YM0/HyWM+itjZsIJ3qUZSQ+uyV0RaO2SK
 Y9BKF6k+ha/Yj+cVIZkKs9IPiksdhY1DaAwPqzrECKFc0SN0SP08lD9hLLadiZchl12YrLN65
 Y2ie8EsAPeNF47ZpY868nj6/6/xCvbNvM6b5Vcoy9V3HJlshgkdAYTenFAlXMLcSdWRq4gcAh
 q8wVsiPrP17/8FNu1bvq+JddjoinIOkNaqL6CSMkoH1V/MOZ8IMuMkiHfZAuSa2er99vUpoG7
 V4nqny14kMQjwJa95oSj0X6sWqktVZa4J4gKvLUHY+o301wIt/3dgKO6okh/l7MG2J+HASn7j
 ZLCGBGYIjpBhlYb4xfgpuG81NfA=
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
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

Fix the math overflow when calculating the new_malloc_size.

new_host_brk_page and brk_page are unsigned integers. If userspace
reduces the heap, new_host_brk_page is lower than brk_page which results
in a huge positive number (but should actually be negative).

Fix it by adding a proper check and as such make the code more readable.

Signed-off-by: Helge Deller <deller@gmx.de>
Tested-by: Markus F.X.J. Oberhumer <notifications@github.com>
Fixes: 86f04735ac ("linux-user: Fix brk() to release pages")
Buglink: https://github.com/upx/upx/issues/683
=2D--
 linux-user/syscall.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 92d146f8fb..aa906bedcc 100644
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


