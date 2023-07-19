Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 247BE759A3C
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 17:54:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM9Tx-00071x-TJ; Wed, 19 Jul 2023 11:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1qM9Tu-0006zu-Re; Wed, 19 Jul 2023 11:52:50 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1qM9Ts-0006Pg-4s; Wed, 19 Jul 2023 11:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1689781958; x=1690386758; i=deller@gmx.de;
 bh=QndR1JShYxuIGvq9fxtuUmSM0VG5DS7IN52I1fXIGAw=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=PDhuruxvCMI4wtWeqFx584ShHaLCzSfB9KGcwAdSOTrnxti6S7KphnAERJORfhInjpx7WCg
 JeTEzU3lEyg4QkvIwEv12qxTSNh0nCnrvGyKlbqh+zOSEh3GRjiutc6fEMim9EssfKjmJbQFC
 uF3zGjn/Yu5aSS5S8pp0zIAHyFDw5wI0MmS0shcbCQDywaNyN/md/dsKjEtUmV/FD+eDhGc1j
 ZwDxjdB38JlLcpgW7chLjizSQfzrHoySzWQdReDa3komXOhnH15kB16yaEJROLJiWEp7YqMvH
 j9tFxE/+LtQXMVZOMafn+ZArF1XUxKWCgGKWB5SKmU3r9hYUkt2g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.145.157]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MulqD-1q5aAH04FH-00rtX3; Wed, 19
 Jul 2023 17:52:38 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Andreas Schwab <schwab@suse.de>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 "Markus F.X.J. Oberhumer" <markus@oberhumer.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PULL 3/5] linux-user: Fix signed math overflow in brk() syscall
Date: Wed, 19 Jul 2023 17:52:33 +0200
Message-ID: <20230719155235.244478-4-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719155235.244478-1-deller@gmx.de>
References: <20230719155235.244478-1-deller@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K9yOMTZJBZEDnsKu1NePC5D43Rgn+8cvnQEPGDA1qDySEKSpsQy
 FUQDdqHmGy2nShdYhfniAfig+iZL9u0dos/nPIqQVH80Kb/IDw6jp66pgk/m4yNM52zPdUP
 57k1BHvt9WYKJwK/4XnGRx47vfpdSO6BC51EOJCK67IM8GKYbUEsR0iDL6GLwbPUxt9jPaM
 YVD5M94w+5UFZf8ppHxZg==
UI-OutboundReport: notjunk:1;M01:P0:vOP6zqKiwGU=;rthfAxYtLngh3PHj4zZUw+vuIKI
 FcPznh4oazHhxlWUlq7ArTwoGU3v07qaQSW+hNgZPcpYkqMJh6VSGv4/MNw/oHOM12RBFZJeO
 7GShiCu2Xy0Y9738jkBuXlicNk0dLJ1YZ85oN7LbDfqwPOLgpkn3nAQh2/wLBMaPnLiIhg4Rw
 Ct3w98yA1XRx25lGXsxPsJ1gw1dAyzLUkVs5DclVOcw34+FP+dm4e6z3q1bVSvFfA6lFW+mjT
 uZAKRD0Pxt15lL34HvDdPxYmHrLUmbihM6m3EU+DJMc1lMxDhqNKW7SQc82LYgoptHuYN4S7e
 n2nb4Noh9BiqtOHJbK9GiXPrIaYnjEtl2nxp6Ouh9mZOGt6C2MSllrObzVlY+N41KQbKxCIxz
 u5YT5miOGMEhObiR4JEtHvW4UWxTWgnyapVTKQcpATDoF2nuksI7RpRT2eSK5M07TqH5P++BA
 jb2du38DF/VqS2HPHPOMQ4rK7QiY1obZUmuHoh7TRGpg+k9Do/qrLMHOXmEZIKxi/ZSHfhcrD
 AkPyMQE/jYLdz6ZkmcK4Ltq33a6lOUqNLgkMx2/UBEfaKLt/4gPkbNcEacI+WcltgLRkv1lks
 jDOpZeT24wNfcZR/mYXQHG4GQDWUHbU8D1W3tBDv95XS65xGdeYD79+DU97GjUOxmlhwxjdXt
 uEAJGKejiAbI+urLgCBRdYu2l3l70o0zMrMS5kqOjFHutXmcGOBlcF6LZ4MqehRUEiiEV6poF
 Pfpd0+0ax6rSv7few05wbcgWsBIWjd+Hk62XiaJbaAE2uyMtMbMHseSmW1euSeGY7GEcqYsGp
 2AvR0ASd6H9ise+9u/c7U+KDSzns9YqJan4a6FaNjJ7uwjlWAjWFTR0iXoFV2GrDJPb6plXJk
 xnsKOOsa5zNk1wPYkp7MBST5XHclxu1ywn87SNCITlBUCnuYuuoFs8cTDPNd3p7T7MsWbpvRG
 KRjraqSP0K+lVaS33ZyuvvpmmIQ=
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


