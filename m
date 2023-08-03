Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A46F076F4C6
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 23:46:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRg7w-0003qz-4b; Thu, 03 Aug 2023 17:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1qRg7u-0003qA-EH; Thu, 03 Aug 2023 17:44:58 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1qRg7s-0001FK-GT; Thu, 03 Aug 2023 17:44:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691099091; x=1691703891; i=deller@gmx.de;
 bh=xwz6aMde3YBdcmDS3z738t66mXpAPMuyqhPYVzFaalo=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=rc5N8fRZrbH1QQXpKMmfnEBKkv7QxxqcfgSvsRzshO7no5q0eWmk7EYwocYSX66UnqaNElf
 92XLGOdTduDRxsXTGLRwpr7lSM3wj6/TuPu7pIkvIzIvWjVtmkRayAtPQeF7c0vuYmHyrJMEF
 xCFI+1Z2V0TmLjAWWHQ5sRp8pSFuHO30rquvpkR8nIuHgEGOl46M6kYJNZHamZlmnN0a1AFBR
 2vi4dYjstBmJv6FRMccJ6BTk62ZjZFqZ99I0OYtF5+KR4aQxiJgXpVI5XVr8vKjTjwK7EwXfH
 Yp+8D3vwyCo/4+Vmw9CcH4mN5idFOqU2y+FMjUXx86+qSKEbNiXQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.147.53]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCbEp-1qbKm93OOB-009eks; Thu, 03
 Aug 2023 23:44:50 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v4 1/3] linux-user: Fix openat() emulation to correctly detect
 accesses to /proc
Date: Thu,  3 Aug 2023 23:44:47 +0200
Message-ID: <20230803214450.647040-2-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803214450.647040-1-deller@gmx.de>
References: <20230803214450.647040-1-deller@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E6jZmUD8b9E4Kc2BiDPx9ahwQlCwmzsuwv39p5tnJPirMIpqap7
 ZGpvUoueICd/At7m2DudLYMbnYG+bm/f3jg88apRy42KYHPHBdP5RqpFkzfg0fzLhpRcVFG
 DVtLC+Pwzk64iuIXou0vxaDJASZQXY41dzsOfjGSsZtZ8tJUdoNtQxjBZgOqW4xSxWBTbQK
 OfmC54jWPe1gZpKWpTO5g==
UI-OutboundReport: notjunk:1;M01:P0:zqCNsq0Ssgw=;2hUdO9/keL3wmlQfYAMEEthQsol
 TpJ8255dQIpsmDrOunxqNefMpxM7ee0f+QzF4d7jd7RkjQN9yOdUYLcJFnSllAzVRZF8HuR2a
 2ekFIULzXjle6Eylxyc98fCsPluchi0eJcINXDmRvI4Zm2pCw06fkvHoOs5VvL1YoMoogVW6u
 iezWKnJdeh443oxb5mLMCbP1LDWn83mfHg9WrtxvpiJT9DQhAp5rG7zkT1qXL24RaMLLwELVs
 5LXIi6StHMaAhvr9cekhhgKT0Y1FSj5mttoFBJAFLS/ezNTVHs5x6EwR/KZHjK6RvFE7Qq6qI
 tOA+9VD+RpRK5U2vdTDaVo8SdvFLd3reMtV2c3oRoyKnB+Nr4GxGD8O4sQBie1iXTA75UmLRV
 K4vAS1xI9UOJi4wpzGBDoE7hyCDv5l3GhAzThV5/99rWhpc+q41uCj8CTtnx1I5knlxUD5dD/
 F5ZFFkeAQsDXMmXcGc3Be8o/tKjiqAZN5ByRptaHJiUitUbY4cfRNFvYpf6k612IIJ8fEp6H8
 ugbjghnsIg5bhAPnPdT73tzecnbe5tdQoCGo8wHsdgvMxaaFXLrZz1TpBcFwWKmOeLHWBS2MX
 PJI+KyutEytc47wonRy6N9GekT1I3Z3Ap2AC7KRlUl8ZhejDDhsmEqxKO7yhlSBl9ETxfzDVv
 uVGG7tdYzFRb31lpRwkJIzziCgZqeJYG0KPzqKIBHv14wfLsdZiQnpziymKsYzVAOGIMt0Syg
 wcwLplafTp7H9Kz3gIOA5oDMyrcc7aQQA4sLaToSwW0bXrK7W+b0k6xsfevlyaRiTR2rhBfEE
 2n1yyzxVidQlHgAzhCfzuscSoNWUcD1A8gZMKe5LGsBpG/teVgqrWG92K4zIRaQruVTOXdMJe
 d/9YJHbjshgIMXdXqam1pdBR/cmoO1DVag1eAg70CyTAuYr5YGWi6EJx2nEUS4zhXx+3D9D9B
 dvsuULP2aifYD6WKSMAWN4ru9qw=
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
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

In qemu we catch accesses to files like /proc/cpuinfo or /proc/net/route
and return to the guest contents which would be visible on a real system
(instead what the host would show).

This patch fixes a bug, where for example the accesses
    cat /proc////cpuinfo
or
    cd /proc && cat cpuinfo
will not be recognized by qemu and where qemu will wrongly show
the contents of the host's /proc/cpuinfo file.

Signed-off-by: Helge Deller <deller@gmx.de>

=2D-
v3:
- use g_autofree on returned value from realpath

v2:
- use g_autofree instead of pathname on stack
  Daniel P. Berrang=C3=A9 requested to not put buffers on stack.
  Using g_autofree keeps code much cleaner than using
  extended semantics of realpath(), unless I can use g_autofree
  on malloced area from realpath().
=2D--
 linux-user/syscall.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 95727a816a..1ec7d27e37 100644
=2D-- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8539,9 +8539,12 @@ static int open_hardware(CPUArchState *cpu_env, int=
 fd)
 }
 #endif

-int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *pathnam=
e,
+
+int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
                     int flags, mode_t mode, bool safe)
 {
+    g_autofree char *proc_name =3D NULL;
+    const char *pathname;
     struct fake_open {
         const char *filename;
         int (*fill)(CPUArchState *cpu_env, int fd);
@@ -8567,6 +8570,14 @@ int do_guest_openat(CPUArchState *cpu_env, int dirf=
d, const char *pathname,
         { NULL, NULL, NULL }
     };

+    /* if this is a file from /proc/ filesystem, expand full name */
+    proc_name =3D realpath(fname, NULL);
+    if (proc_name && strncmp(proc_name, "/proc/", 6) =3D=3D 0) {
+        pathname =3D proc_name;
+    } else {
+        pathname =3D fname;
+    }
+
     if (is_proc_myself(pathname, "exe")) {
         if (safe) {
             return safe_openat(dirfd, exec_path, flags, mode);
=2D-
2.41.0


