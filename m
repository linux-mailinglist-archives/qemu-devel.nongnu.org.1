Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DCD776CA5
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 01:09:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTsHU-0001Fa-3j; Wed, 09 Aug 2023 19:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qTsHR-0001FQ-Eb
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 19:07:53 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qTsHP-00052J-Aj
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 19:07:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691622469; x=1692227269; i=deller@gmx.de;
 bh=G9URKYaSIUDNU6WIrTpoxw9FeRCtjwzYH005gYn4YEI=;
 h=X-UI-Sender-Class:Date:From:To:Subject;
 b=YDZRTouAI/hKRnNqokE76ZVJHZ2MakuKdYWsLJXcf49oa5bUUmBpYXLL/uFn3TbFuTGC31h
 b/BjHk9wbfDV7jw7wuxyPvOcgsdQJBkJjEvpPqQHK4DVwtkX28+qmo5oUd1UD0V5tjQtaZU2x
 3gjdlkch+en/MsWjS7WKHijs425f0Ahlm7cs9y/WN48YYU2MO2vGOSfZz1ekv6usCcT/TmG/z
 arOULjnuBb8xGtn8FX71NsmrASXXUDGdDsmm52ICn59on6+7wKCOB+CdiB5cmzmJuu2DKr4Ab
 vyWHr16RR7H/2vEsS3IRRT9HukQPAhu46gHsog7eJW2OiTOTiqAQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100 ([94.134.156.76]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MK3Vu-1qDz1X0lEk-00LZmy; Thu, 10
 Aug 2023 01:07:49 +0200
Date: Thu, 10 Aug 2023 01:07:47 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Subject: [PATCH][RFC] Add crash handler for qemu-linux-user
Message-ID: <ZNQcQxcL/22LmrVP@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:3naaZdjsoT5w8vCjHD5hqi+ED/aXNB/fbyrqDbMOeT/sjKu7fPo
 NkuSpqnq9HI5qY9ELhvojWX3/yAiitOUdbCVzNB2E6RoDsdRnkDr5vu3V6HjgsWL38E1DVF
 gS8mP9rT9Nf2c2xHSz5NtKAmDxNVEIuvAahLEZdDrT3ft3OAa6J9xYB1b6L4FQSXX1dQKNr
 rLqXk0hfkUx2H+5qP3erQ==
UI-OutboundReport: notjunk:1;M01:P0:S8Thf59uAf8=;TuJAqL4EqJcXvmlbOlwNDALINMe
 JeovOu563JPIcvhz2DZT/zjdb5YJ+lUmEY/poYVOVgrf5iwEycuBEvP7Q7/xIjsE3vl5Mahit
 pz1KkorL+GMZF382P7eO1ywtddje631x0VeGSjdD++bwPiXei6lboZan8SgRChbjGj/jmkB0q
 ZMZF3ng8YWo13EE1nARrvV/rC8HgZ79/Q9OQx7VKHiek+G7oz0ExsQfOV6802etF75L2QQJeA
 R7UhCVhQp20Akd5IlMbLy+sJAUQ7FBaXD39c3yzqeNuHPzXCPYOTK9d55G3UAGtoRzcufQ252
 rVqXdjGjCiuoxzk84AzrUTCKAQgw9RwY+AF8NJEy2lYm/iILD4n3EZcPzsOt2xjoAh0fU2W+v
 10gkosmw5cu4ktyTRMtk1pgWHxMwb6t770p1W6PCTB9dDW5VZbhC03LEwxi19BUaiv1Hc2Eux
 BQL27YOs7lNRf9/Q1ny6Jn9yEEin2Dw8UsCvoxAmF0G87LU6jKKeLWAneNNoqGSUo+k5BTVC6
 TPJgRiCSzGxsrzq94OpRFXd9i2KEIgjgUQLO33cj2Rb3kqEa+jQ5H6dN6qabr4UmvlONbD7O+
 1n8yyHh+JJuSt2QYCAP5O+isVT8ABuDJOjKH0+fSuX3xS43eiH/KfOuHGAoeIMQj8LsaSCG0V
 rCyzZk7CqikpQZSX0erxlTZZsWQV/s01rMLKeGH9VJ7U0aKqbfktuwONe0TLD3BVQAz1nZW2F
 ZwVX52t8ck/bUhzKTkVH8sF6M2SUNAxRwRMfshX6gorLXWOjDBUlv3HD4+eQRf2d4yJv4AewQ
 iPhcKiyplj8kdVilujEnqwruB41oYHlyjj31HR+LriPO+qqAbzU5/9nWHBWMxSBdyBhi309Nl
 qIeSl+2Igss2c5Uud+87qRbA/rTxX1naTdI/zY7kPRR7CFOlD7AgA7Qth7Nr+P4tdp60Dc7Ez
 EbtPHuENKX7t98VliDZiPhkbDNk=
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

If there is an internal program error in qemu source code
which triggers a SIGSEGV, qemu will currently assume this
is a SIGSEGV of the target and print:

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
QEMU host internal error: signal=3D11, errno=3D0, code=3D1, addr=3D(nil)
QEMU host backtrace:
[0x7fd285445039]
[0x7fd28561af80]
[0x7fd28544eba9]
[0x7fd28544ebcb]
[0x7fd285459631]
[0x7fd28545d833]
[0x7fd285463e78]
[0x7fd2853fbd2d]
[0x7fd2853f57f9]
[0x7fd2856056a8]
[0x7fd285606d8f]
[0x7fd2853f60a5]

Note that glibc's backtrace() does not resolve the addresses to function
names, which is why only addresses are show above.

Is such a patch useful?

Ideas on how to get the function names resolved, e.g.  including a
static build of libunwind?

Note, that the patch below includes the sigsegv-trigger (just run
"cat /proc/self/maps" in the chroot) for testing purposes.

Opinions?

Helge


Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 748a98f3e5..5d01ab61b8 100644
=2D-- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -23,6 +23,7 @@

 #include <sys/ucontext.h>
 #include <sys/resource.h>
+#include <execinfo.h>

 #include "qemu.h"
 #include "user-internals.h"
@@ -781,6 +782,27 @@ static inline void rewind_if_in_safe_syscall(void *pu=
c)
     }
 }

+static void qemu_show_backtrace(siginfo_t *info)
+{
+    void *array[20];
+    char **strings;
+    int size, i;
+
+    fprintf(stderr, "QEMU host internal error: signal=3D%d, errno=3D%d, c=
ode=3D%d, addr=3D%p\n",
+        info->si_signo, info->si_errno, info->si_code, info->si_addr);
+    size =3D backtrace (array, 20);
+    strings =3D backtrace_symbols (array, size);
+    if (strings)
+    {
+        fprintf(stderr, "QEMU host backtrace:\n");
+        for (i =3D 0; i < size; i++)
+            fprintf(stderr, "%s\n", strings[i]);
+    }
+    free (strings);
+    exit(info->si_code);
+}
+
+
 static void host_signal_handler(int host_sig, siginfo_t *info, void *puc)
 {
     CPUArchState *env =3D thread_cpu->env_ptr;
@@ -819,6 +841,11 @@ static void host_signal_handler(int host_sig, siginfo=
_t *info, void *puc)
         if (host_sig =3D=3D SIGSEGV) {
             bool maperr =3D true;

+            /* did qemu source code crashed? */
+            if (unlikely(!h2g_valid(host_addr))) {
+                qemu_show_backtrace(info);
+            }
+
             if (info->si_code =3D=3D SEGV_ACCERR && h2g_valid(host_addr))=
 {
                 /* If this was a write to a TB protected page, restart. *=
/
                 if (is_write &&
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index a15bce2be2..0267ff7649 100644
=2D-- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8074,6 +8074,7 @@ static int open_self_maps_1(CPUArchState *cpu_env, i=
nt fd, bool smaps)
     IntervalTreeNode *s;
     int count;

+*(int*)NULL =3D 1;
     for (s =3D interval_tree_iter_first(map_info, 0, -1); s;
          s =3D interval_tree_iter_next(s, 0, -1)) {
         MapInfo *e =3D container_of(s, MapInfo, itree);
diff --git a/meson.build b/meson.build
index 98e68ef0b1..6db4e029a0 100644
=2D-- a/meson.build
+++ b/meson.build
@@ -4068,6 +4068,8 @@ if targetos =3D=3D 'darwin'
   summary_info +=3D {'Objective-C compiler': ' '.join(meson.get_compiler(=
'objc').cmd_array())}
 endif
 option_cflags =3D (get_option('debug') ? ['-g'] : [])
+# add symbol table for backtrace(), not sufficient for qemu-linux-user bu=
ilt as static executable
+option_cflags +=3D ['-rdynamic']
 if get_option('optimization') !=3D 'plain'
   option_cflags +=3D ['-O' + get_option('optimization')]
 endif

