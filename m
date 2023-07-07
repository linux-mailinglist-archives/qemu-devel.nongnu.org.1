Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE2374B1AF
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 15:20:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHlN7-0005Q5-P7; Fri, 07 Jul 2023 09:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qHlN2-0005Ps-99
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 09:19:36 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qHlMz-0001Li-Hs
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 09:19:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1688735969; x=1689340769; i=deller@gmx.de;
 bh=6WonJGiwb08NSRPDtMmJ1dH8R4RTnTU1bZ6SBt5f838=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=O0xfyCjtoGEoFkNrKoqHjXbaGFeMR/Lsket6S4em5mdAaoRspi+r6ICZl88Fhiz4InbzOsQ
 0YFtl8hmIznWl40aR/ACI+1iMsLh3mOEVFDw8p3g4BvqPwDP/KuJmD79pj3BZE4aGGBrdZsSC
 1o041lUn8mSaC95e4C9NN9Ijhq6gW2oqeGr4KuNkdTQ8VbDU/QDtz5RJ1GbuC9F+3nuPILiXP
 iUP2oDKYGbHRsKH1ov4fbnJnqWGy3q33HszmKaAJu3kFE3Lcz+DpEmjhMFDgOCiazb26XBapn
 ictSNzr01XAFcJCr2fnCyxLXrywGLuWyOUYZB/bpKA4RbtCqAXWQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.153.180]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgNct-1pmpH41M9X-00hufH; Fri, 07
 Jul 2023 15:19:29 +0200
From: Helge Deller <deller@gmx.de>
To: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH 2/4] linux-user: Fix accept4(SOCK_NONBLOCK) syscall
Date: Fri,  7 Jul 2023 15:19:26 +0200
Message-ID: <20230707131928.89500-3-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707131928.89500-1-deller@gmx.de>
References: <20230707131928.89500-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H3OsHRqftZMyy6QFccnT4G6ZGuRzPTxzIO04ehjJ0/KwIcK1Esw
 LiL7LpTMLOayteUPs1z4LY9Kx2pj3OXEBoZeMUdHr4Z4uGwBqPLNSBMGK+hoel9MScUp/uB
 DjW5RLUYsCsachg8fEBbIhymhvXnYGmyzxzoaprbAKUCCj1e5jzDXOdzK0cOuBQ9/UUpuXu
 a1GjzBHfYUok5xwSAgR0A==
UI-OutboundReport: notjunk:1;M01:P0:DkHW+fIjIXE=;jPtiNwaZeo0rAJSU5AfdQyaSXJA
 SlbIjxEC2qkLTLHxciYl+R/2lZ1yNuthB7nsdzPvOrR31eiRK0DB4kDZkLiKzZqdIejimBmAU
 V9VnbIZzc/ohVYttZ2Lx5WxJDOcLEv2OxjAoWwsL1KUXvJNRLne/+WLXw+rAIRiFAt1O9RQWG
 1McNyFiOdKNKixKyhfrkjwsSMj2QSQ/ux39Ky6NW3tYdwSDWXwe0AFxxiN0hKYzYu65FYAPGk
 HmbVDtaxU29GkJFt0jGn0Elo4Zxe0uELyvLcbzs3tNaWOCaiHlUX63N4OskvQjjpxAfWVJQiT
 bi1u3cnIrfnqP2Mejr5DeIRzTKaQu4odRrMfTuJSA2k5i3Yu6nNQIhE37Z8LFvHLWQMR1vBnU
 o/i4M436KA2qWIYbo3Q+m4aRx+Kja72Rc3oSTfiA+YLG8aoJ/d/LUPDIReLowfa4EUEw0RMMR
 12OP5aK3qZNDQvtgS0UZJeWRYRk4U/PSyXw2lzSpl2d2gdWtj+zrdU7nzxIcMJ0G9CNjt9fX0
 bzXlBT89iXrrAmCIQn1NaEZQzHSzh/8AtrQW55WPnP7NVNMsKa6A+AqfHy+MypPOwvMkUeYHx
 6+CWGehoANA4IT7pG9IU6h8s4qhBPbI1uZCFaalvq1QhUY3I722wUJ2kEg4JwINobniIxllRc
 3miVT08gCSYgxx6LtbRjt72Ml94yI/DXOYUHytNZwQO6q/ybHKhCQXQwxX1c6Djsl5A19JLWo
 MkwwgC8YROAzIdvchrvfCQ3jvIK16TQJVT79Uov1L4JmURhc/5LGjmR41Cs4rJB0uHIxXmmTq
 tPYtpKAjOeRMAYra203oYqD2jPxds0snsH/n2I3F83lx01BpL1Psx89g/p27VzlH17LpqyUMH
 qEqQfCdTJpW/50m4ziEmQeN2ZKf7lLM7iaQK4ZrO3HE4tDQsEafeLlFUHlf9U/IGwI03Wr3lF
 S6Ez1U4mTX0WGyMEaxUCGnQmG/E=
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
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

The accept4() syscall takes two flags only: SOCK_NONBLOCK and
SOCK_CLOEXEC.
Even the real Linux kernel returns -EINVAL if any other bits
have been set.

Change the implementation of accept4() to recognize those two values
only, instead of using the fcntl_flags_tbl[] bitmask translation.

Beside this correction in behaviour, it actually fixes the accept4()
emulation for hppa, mips and alpha targets for which SOCK_NONBLOCK is
different than TARGET_SOCK_NONBLOCK.

I noticed this wrong behaviour with the testcase of the debian lwt package
which failed (by timeout while hanging in the read() syscall) in qemu but
succeeded on real hardware.

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 linux-user/syscall.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 3f1e8e7ad9..9e9317237d 100644
=2D-- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -3440,7 +3440,18 @@ static abi_long do_accept4(int fd, abi_ulong target=
_addr,
     abi_long ret;
     int host_flags;

-    host_flags =3D target_to_host_bitmask(flags, fcntl_flags_tbl);
+    host_flags =3D 0;
+#if defined(SOCK_NONBLOCK)
+    if (flags & ~(TARGET_SOCK_CLOEXEC | TARGET_SOCK_NONBLOCK)) {
+        return -TARGET_EINVAL;
+    }
+    if (flags & TARGET_SOCK_NONBLOCK) {
+        host_flags |=3D SOCK_NONBLOCK;
+    }
+#endif
+    if (flags & TARGET_SOCK_CLOEXEC) {
+        host_flags |=3D SOCK_CLOEXEC;
+    }

     if (target_addr =3D=3D 0) {
         return get_errno(safe_accept4(fd, NULL, NULL, host_flags));
=2D-
2.41.0


