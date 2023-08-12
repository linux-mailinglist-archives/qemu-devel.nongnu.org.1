Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A0177A122
	for <lists+qemu-devel@lfdr.de>; Sat, 12 Aug 2023 18:44:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUri1-00027Y-0j; Sat, 12 Aug 2023 12:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qUrhz-00027Q-H6
 for qemu-devel@nongnu.org; Sat, 12 Aug 2023 12:43:23 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qUrhx-0006h1-Ld
 for qemu-devel@nongnu.org; Sat, 12 Aug 2023 12:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691858598; x=1692463398; i=deller@gmx.de;
 bh=iWX44ZN2Cmimlggab1XCTZ+RwnRnUVZQhFqeutxYdkk=;
 h=X-UI-Sender-Class:From:To:Subject:Date;
 b=qeDMkMeJ6nxNQyz/q604nJTqqEp2tqI5XK26pTUAhPKWQC4Hr/TCDMur8PSFA1qM9ToxEgz
 qJXMzm8P3gOqpOD0zsRpiNaWuRG0QWWzuOQmcqFyK7xfY+ZRw7k80W6kiz8kpfxWB33Y/yFmf
 4DJ8RIJTWyhEJuWBJ3KjK5ExuMvgz0JMARH3CiQw0FKqWBctfPX0lZSveVHEcm3Nmuqt+T7Bn
 NfVFJrglJ0wJfJKI5ev7mzYVEeSgAJ1gNHL2NpdWtgnqTxNW+SXlgwiW+YOnpy0F2GjJOP+gM
 E3oeVNJyKUBVDT1l/rEEQSoS0LWSzwo4k5dWpzBKpFX1TxSfnPtg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.153.44]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MN5eX-1qBxPX1Tmv-00J64E for
 <qemu-devel@nongnu.org>; Sat, 12 Aug 2023 18:43:18 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Subject: [PATCH] Fix signal handler to detect crashes in qemu-linux-user
Date: Sat, 12 Aug 2023 18:43:14 +0200
Message-ID: <20230812164314.352131-1-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jOoO1dIiQU2YijsBUnx2NjjaoBEkCVkGNybsqxpUvvtPDaQn6cG
 5brqcT+qUV3h0aV4h4sfTVCtXPOjEA5Sq+J7NhAemibgNXg10VzkEbYGkuZQvxy9Y+e0EWA
 tcybehsX6Lk0ayto/m6E6t2sQAk7U6PfQ9hrpJcYe+HsU7vd8j81AarLC2ffRR+LHbWswtn
 02ytsVhjiRKCvL2gf3FZw==
UI-OutboundReport: notjunk:1;M01:P0:J9CwkR3L29E=;pqlvXw4cUcTGcp621rrcPTDwwvv
 qAeDeyCynPfKXnISG2TG++dll65PMnNUgbXtwuHQadi+haHluvLF3pSzZ00D2cwrd9xyE+5UD
 5+6AM4//ag+5uPeAuQLnEKA/sE7Z1ecjqAT0N8IbqCi2jTJ5gNiTVZY1cTQJt+AOaV4d9wygu
 UphFRJy0NXrZnuS3X9GX3JXFiXuG1Bnj6JD9k63fuTfN1TawHOIyBTzTmSwv4tMMN1n2hrlyj
 W88OiMuGCMXOSC/O5NAfvX++QLeS5FCEir/LxcLiilQFlV2c+lC8yRQl72AaogCHPL5cAFva0
 KpOALaOrqRDmzyuIjE04b5mI48J1P7o2N5TmCwksrGWs92QluOlHU1/nmSKjasEkl+FQBguwJ
 AEQoIXMlzdkDGa+RfuTxYKQVoEDg1AWuH9/Q2vY6aOCVqEKtCG99nNATLesuEx5/kMZuso63X
 GO7HhkaOrz75ij9XwxZFKX0ITf1vNMmQJcFpBrTFYmgsEmKFU85U9NN7t/r96kVEVKvBYtvr4
 d0lbaWU2+VhAR60inVDo02uOOz7z/RS0k+Go8tgdi89zNYv7F81Gueed8VUbhvqhF5z+JDSAJ
 FYievKOBy7i+p+TSVeoqKypTq/gVN6mhqlr4CPkxVYQgORNVK8cqUEx+ouEYQH1j7+Ijcv/G1
 Uisuqi3jTvzNULqJg1SzsbkU+FiJ1ijbu1ImllgLuZdUybK1z+aHwz4yo7RrDt1lH0D+b2MUS
 q4PI2e1LnSiVEFT8AHNUf1Q4jxIQinHxsGa0Oxkg68kwJbV2XTz10MRkwll8BzGfXQTbp29g6
 g61ISza5q8EyjOmvSF4MctTwlqTwmpIDQi7gr7zox0v7SUk5RflQQ8IMK6W2QJB9gIn0KcuzJ
 tqL5bTGiCIHVH2OzH0QiM1FuBw9BL7BqxFDRpLnM/H5xVl9JNtC5MXGcpK883X+Ig1qvXwFO+
 j17kLLSt2EntzyjH1GI1BOV4YX4=
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

If there is an internal program error in the qemu source code which
triggers a SIGSEGV, qemu will currently assume this is a SIGSEGV of the
target and print:

(hppa-chroot)root@p100:/# cat /proc/self/maps
**
ERROR:../../home/cvs/qemu/qemu/accel/tcg/cpu-exec.c:532:cpu_exec_longjmp_c=
leanup: assertion failed: (cpu =3D=3D current_cpu)
Bail out! ERROR:../../home/cvs/qemu/qemu/accel/tcg/cpu-exec.c:532:cpu_exec=
_longjmp_cleanup: assertion failed: (cpu =3D=3D current_cpu)
**

This error message is very misleading for developers and end-users.

The attached patch will print instead:

(hppa-chroot)root@p100:/# cat /proc/self/maps
QEMU linux-user v8.0.93 for target parisc
QEMU internal error: signal=3D11, errno=3D0, code=3D1, addr=3D(nil)
while running: /usr/bin/cat
QEMU backtrace:
[0x7f70cd045115]
[0x7f70cd21b140]
[0x7f70cd04ec49]
[0x7f70cd04ec6b]
[0x7f70cd0597e2]
[0x7f70cd05d9ed]
[0x7f70cd064008]
[0x7f70ccffbd2d]
[0x7f70ccff57f8]
[0x7f70cd205868]
[0x7f70cd206f4f]
[0x7f70ccff60a5]

Note that glibc's backtrace() can not resolve the addresses to function
names for static binaries, which is why only addresses are show above.

Signed-off-by: Helge Deller <deller@gmx.de>

v2:
- Refined crash detection based on IP address, suggested by Richard
- More info in crash dump, e.g. qemu version and target
=2D--
 linux-user/signal.c  | 36 ++++++++++++++++++++++++++++++++++++
 linux-user/syscall.c |  1 +
 2 files changed, 37 insertions(+)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 748a98f3e5..d445376f06 100644
=2D-- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -23,6 +23,7 @@

 #include <sys/ucontext.h>
 #include <sys/resource.h>
+#include <execinfo.h>

 #include "qemu.h"
 #include "user-internals.h"
@@ -781,6 +782,34 @@ static inline void rewind_if_in_safe_syscall(void *pu=
c)
     }
 }

+static void qemu_show_backtrace(siginfo_t *info)
+{
+    void *array[20];
+    char **strings;
+    int size, i;
+
+    fprintf(stderr, "QEMU linux-user v" QEMU_VERSION " for target "
+                     UNAME_MACHINE "\n");
+    fprintf(stderr, "QEMU internal error: signal=3D%d, errno=3D%d, "
+                    "code=3D%d, addr=3D%p\n",
+                    info->si_signo, info->si_errno, info->si_code,
+                    info->si_addr);
+    fprintf(stderr, "while running: %s\n", exec_path);
+    size =3D backtrace(array, ARRAY_SIZE(array));
+    strings =3D backtrace_symbols(array, size);
+    if (strings) {
+        fprintf(stderr, "QEMU backtrace:\n");
+        for (i =3D 0; i < size; i++)
+            fprintf(stderr, "%s\n", strings[i]);
+    }
+    free (strings);
+    exit(info->si_code);
+}
+
+/* _init and _fini are provided by the linker */
+extern char _init;
+extern char _fini;
+
 static void host_signal_handler(int host_sig, siginfo_t *info, void *puc)
 {
     CPUArchState *env =3D thread_cpu->env_ptr;
@@ -819,6 +848,13 @@ static void host_signal_handler(int host_sig, siginfo=
_t *info, void *puc)
         if (host_sig =3D=3D SIGSEGV) {
             bool maperr =3D true;

+            /* Did segfault happened in qemu source code? */
+            if ((pc >=3D (uintptr_t) &_init && pc < (uintptr_t) &_fini) |=
|
+                (TARGET_ABI_BITS =3D=3D 32 && HOST_LONG_BITS =3D=3D 64
+                 && !h2g_valid(host_addr))) {
+                qemu_show_backtrace(info);
+            }
+
             if (info->si_code =3D=3D SEGV_ACCERR && h2g_valid(host_addr))=
 {
                 /* If this was a write to a TB protected page, restart. *=
/
                 if (is_write &&
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9353268cc1..da29d97816 100644
=2D-- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8132,6 +8132,7 @@ static int open_self_maps_1(CPUArchState *cpu_env, i=
nt fd, bool smaps)
     IntervalTreeNode *s;
     int count;

+*(int*)NULL =3D 1;
     for (s =3D interval_tree_iter_first(map_info, 0, -1); s;
          s =3D interval_tree_iter_next(s, 0, -1)) {
         MapInfo *e =3D container_of(s, MapInfo, itree);
=2D-
2.41.0


