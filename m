Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD7D759A3A
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 17:54:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM9Ty-00072K-Jx; Wed, 19 Jul 2023 11:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1qM9Tw-00070Y-5g; Wed, 19 Jul 2023 11:52:52 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1qM9Tt-0006Ph-NV; Wed, 19 Jul 2023 11:52:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1689781957; x=1690386757; i=deller@gmx.de;
 bh=efVESnAW6H7a8ZymmHelPG4JpfCKaU44b+i4/YpA37k=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=gIz+3yIxdFbiIKTyacrbDX9wwLMoWCSAFgm0qZy1TnIYo3wJ11BW15dDFxfB1okVDNrzoyH
 NJuISt8tpK174S8/EyaTZbtC6I5vktVHpNn5uv+IYDKIKkvjflmlDR97JT/FRt6BfsG4V7f+6
 V+7d4ypMQV4AbXtoGBvwBvrcHgoEi6vo8bjSuKq9LoAJ2GVD15lPogPtAlLZZ6IVnVOCI5Z38
 Z7QANSeyuYFclZi885/gv7gT95u25aJw7DoRChV/Cn3Qw2KStwEQmal/FwJZ+QNjPZgzeqvA8
 6mfXn7KJGMPXCO47Wzq35SOGAgv7HBfDNQjtG9q9+p/FdIw0aAkg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.145.157]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McH5a-1plzmT2ExQ-00cgbC; Wed, 19
 Jul 2023 17:52:37 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Andreas Schwab <schwab@suse.de>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 "Markus F.X.J. Oberhumer" <markus@oberhumer.com>, qemu-stable@nongnu.org
Subject: [PULL 1/5] linux-user: Fix qemu brk() to not zero bytes on current
 page
Date: Wed, 19 Jul 2023 17:52:31 +0200
Message-ID: <20230719155235.244478-2-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719155235.244478-1-deller@gmx.de>
References: <20230719155235.244478-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9ki5GeoyYFsDmXulyMlR7W48fzzEaB85Bx6bs6KtGYaneKENyCU
 eVOokJLxVu9yJYhwrWuA+yTgatY5rTYxcbNWozvoK0iepV7sEJQP6U+vu3hEo4heZd9XinK
 plSu+Ad9wDmr/i6tJLEw/1mg1vlllGET6z3k8hLAWAhMuPusBJseR+V5KaTxFruKC3HZx2l
 gigu35h0sXys34uLrVtxQ==
UI-OutboundReport: notjunk:1;M01:P0:NdG3xE/qhxI=;Oi3/a6d/YL3rRDXPdA6e7l6CDTN
 p4FOj0pjPf9UO3AZ6roKgdsoGwVEdzwNmSh1p38AGCwPhPo0jUNHLd3EBjKVAHnr32mw6sq3+
 ps3+YXNWblIuWYMuZO2EdZ/cn6cuLv7+vyrpwfwX/eejnO3Z5ahBgWZOkHEmikY2NcNEL8G2w
 hVUP3CXyEsdymeuT8GKo8TaolPELECHDyK5AZeimY/Q5VPzobVh5soZBP4/TDUiKPmUrgDKNJ
 OKcglEGC8oup71IJw2Srf6Xw09kyed9UpyoWx2QOb7NyZJ/pHn5Yr5lxLbeOXA4b57f2IB6yz
 bOtjJ7LOk1z7n4PbohY+Vt/+Idr9XtwinJAm+m5alIy5IQHH0gZaf+Ro5sgEEFhLjfkpv91fM
 FBYRPEKZGlI4HhFRwP4fLPIqB1oJzXm/c+N6HKJ7rDDtXcH3VTrrVMMNzfnuVkTZwBfONvLOU
 NwjhSu0rgIj+PYp9fQ1l6o2dDN0O4JVOZ5zIpNR/pgZu1Fyf3/pD8ZiiNBk62IvlIoWXrq+IQ
 g/VdHWVYjjTEYCN0ScdGZmqTvh1nKVLmD77LRp0cPIQroQglr6Hs3W4iIzX6FdzrmL+TET/s+
 m54nsfKZFN8+kYWcIKsmFZqwgmY4qeMV2YQnToA3+lmVeYWOPT3OsjHF4zH0iJKE0m2rHTkmE
 zIgK+3TIbBQ0YvO5sOZIgfbkM9X078dM249wB9nLXiucDF9lZzqkVcEBfIkH+AOS7yqmt0DY/
 hFzAfUESgnsj/rNglBtiBvfumorc+xqTMh/k/necczyH9JdsdXOpXwMCEWtUXajowtK0yf0hW
 +EpMTT5HaiAHhVuxTm61DG7L2/5Fz6oTgbt3YJjENB5jDF1zNnq2x+wUMT41qHmQp95rX309X
 zhBZne+MGK1aIHvPn4m/snkuxUoE/atHZ7/dr2JEGg7f3zguW1VzS8b+FJDHBzf8LPxSQ1sQh
 yu0p+XKDQSZ9bVMlDC83UD8uGf0=
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


