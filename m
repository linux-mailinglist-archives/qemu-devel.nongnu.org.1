Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9777756F02
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 23:37:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLVsp-00024F-Qn; Mon, 17 Jul 2023 17:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qLVsn-00023E-Ts
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 17:35:53 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qLVsk-00083g-Gh
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 17:35:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1689629746; x=1690234546; i=deller@gmx.de;
 bh=X8cCmtRNuxyGIvbr+KDa1t6PktswG9UGYjkCnXWrFBA=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=hCI1+26pyuGXwMmn8Z/v9boxMOe5oQPUGQbqPCDwAMGuH0MtysDIRYEY44Cj/aYHrZM4So+
 Vi3UWXMkZcKdhu4lMFKYFnZzyecpRYtzNvyYrtvKaW7pd8Gu7M57Ha7Erji8Yxd9Hc/4OwQfh
 2SY6aweFRr1GZdtm+p9k9Z0hmiJNnrxZhBNkGs1JbV+cs+EdCloaBkXWhCqQAGKq7RaFngyg9
 GhaAV6NggqnJKKpdkpTZYv1dnEKs2Xk/d+sb4KE4Z88nxOc5KWIKi4kbg1Ouecyp8r43ml5Nn
 VF+JDZZbLl3lNvvOy3ln0NRYnX2YYo8k3UajgUcgrvPZb7FH5jRg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.159.97]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNKm0-1qbWau34tG-00OnwR; Mon, 17
 Jul 2023 23:35:46 +0200
From: Helge Deller <deller@gmx.de>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>,
 "Markus F . X . J . Oberhumer" <notifications@github.com>
Subject: [PATCH 3/6] linux-user: Prohibit brk() to to shrink below initial
 heap address
Date: Mon, 17 Jul 2023 23:35:42 +0200
Message-ID: <20230717213545.142598-4-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230717213545.142598-1-deller@gmx.de>
References: <20230717213545.142598-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ubc9Lmcj//WY4Ix6cMYUFlPU+q2CYCBrth9NzgZhvQXagsA5pow
 dPba0y5UM7oj2Dx6xH/4Ak9lziS3z5kho1kEEyHMNrDzBwFEdQyoFJqxg/SoMid3vnh44rf
 imfI7+lJM14ht7amCM5lvbLqtSqWOKzNOkv7cSOllGiRmEQx/DUQmpbSr6RynbN72Kr8oD5
 T/WBSl67j+4rpRFOdZDjQ==
UI-OutboundReport: notjunk:1;M01:P0:W/2dum31TEQ=;8PjjCIgmrrj4xH3O6/7RVDtP1tn
 KUzSh10T3q9D3rQppCKpMgE6dWkPVJ8o4A7x5N2jGRofF1zrQZ4HTXJV3DFakjPxLEmxxaDZh
 FQUgPIUmaLdbwuqbW9rYXDBD2Yd0nBK1BzKErJg/lOhe7Qp6j8njRvZsfXYUcCc+pPgLHrjt0
 DqP14N8vZm7JB3MRFuxUTxl0JzohDBD+pph8rxloH8dFWbQp1llxPD04VRYCXl2BzB7ws5JeU
 2F9VfsCkekyExBgUHCg8r2SmwUi65qh3etill4LG5vMoPdsvU7tAqKkhjrU9EdAriU3t56Phz
 FD5o7p6cOuNJpNFlnrgi3JyIOzzUZH+S8Fo5ikSs5isdljzTcI2wMxCKCLO81R7AXsAjOdlM7
 CZvHyKmvRe2GCmcmaCK8bTSb8eJWQP0eVRo2Nb6PqZ2jgEKkH9aMa474KtdLuu4oUQJ3FnS3A
 wsXB04QSV3OI5puG+0+IkRKr8x2ictJw2AjbSbWIWJQ6kk68NbaK6GXw3CeKzKgeLzaajr+zy
 AJFkTIev7YicvJYhiXgiAIGbZn77KE5TkIFKY9a89NrkDvSHZ8odnl+XNGaOqP3HzRQN/C5rl
 IyCmDaNag2MHRkm9HMTZ1nrVSlPmZqaIPPzoETPw7xBRGVMVCUrVHWV/p+ohaoqugBl/YSvWn
 34g8sHHmmVRvIcLeHbJ+yU/EOfg7QxOwlIqUQ1UR9lCImcc3Me+U7fEOw0qiBLe8pNR282TFq
 a9dNc2VRjaHJjFmiP6G9L1e8V5uRO5c200XpVfBH7/+z92qSP5IKLm4aOcMsNHuyVI0xb0huz
 TUSj+43XYz9/c4ObSvJwIJ5eC+DbyGuGhCFu5QqkALmvnELv7d6Mcl2IJ11VWC4IZxTnz2ha/
 kupsdOyQfPk54EFH8XY8GV9Hm3LIb2MwvXnDGcBECrF5w8q1RQeoB0awZrDgAJLT88hkN920m
 EPwwGxPxARaPw5Sosl7kXJ4ADOo=
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
possible for userspace applications to reduce memory footprint by
calling brk() with a lower address and free up memory. Before that guest
heap memory never was unmapped.

But the Linux kernel prohibits to reduce brk() below the initial memory
address which is set at startup by the program, while this check was
missed in commit 86f04735ac.

This patch adds the missing check by storing the initial brk value in
initial_target_brk and verify new brk addresses against that value.

Tested with the i386 upx binary from
https://github.com/upx/upx/releases/download/v4.0.2/upx-4.0.2-i386_linux.t=
ar.xz

Signed-off-by: Helge Deller <deller@gmx.de>
Tested-by: Markus F.X.J. Oberhumer <notifications@github.com>
Fixes: 86f04735ac ("linux-user: Fix brk() to release pages")
Buglink: https://github.com/upx/upx/issues/683
=2D--
 linux-user/syscall.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f877156ed3..92d146f8fb 100644
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
     target_brk =3D new_brk;
+    initial_target_brk =3D new_brk;
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


