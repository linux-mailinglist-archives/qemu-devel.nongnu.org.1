Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B5177A1B1
	for <lists+qemu-devel@lfdr.de>; Sat, 12 Aug 2023 20:14:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUt6e-0002Ti-W6; Sat, 12 Aug 2023 14:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qUt6c-0002TX-9y
 for qemu-devel@nongnu.org; Sat, 12 Aug 2023 14:12:54 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qUt6a-0007Os-Ct
 for qemu-devel@nongnu.org; Sat, 12 Aug 2023 14:12:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691863969; x=1692468769; i=deller@gmx.de;
 bh=IPJ8t4q8M46q7YAK4gSB8Q7gIWzCIRVsAAuq4Om+rnw=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=CQS0X9yLH8O836OR++WDK6rYsaifJuMFl5GKFR6t93M2YSciNFZnWU/ti5XgTCQB/nSsVsQ
 dvj30f6kAZWX5BwSsal1QHD5MOO9cPXzjyOQ2vvx0wNCu5B+/W9ezWvBuJ6Lf+uDu1hjKYou2
 IO7GfWf7pT7Qjn9tkYnKZWEema8mTndGAP08gMWy8WkYnfJSsW9hKxBVAXveAC6CXVk+s2onV
 ak9fNy3t/gvB1YZZaLob8NPU4Yvx7TXyyNpvAueRYQr9MfIo+iEbckL9Q5qO2t3cfTVFP6mQY
 6/ocC+ST/t1OKY8NaUSGouHQO1cOr1bKRQZWeiMEHDgtIbXb7aAA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100 ([94.134.153.44]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXGvG-1qIDPC3MkQ-00Yizv; Sat, 12
 Aug 2023 20:12:48 +0200
Date: Sat, 12 Aug 2023 20:12:47 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Subject: Re: [PATCH] Fix signal handler to detect crashes in qemu-linux-user
Message-ID: <ZNfLn22w8bA5X3YV@p100>
References: <20230812164314.352131-1-deller@gmx.de>
 <56908f79-c883-0d83-c990-e7a86714b6da@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56908f79-c883-0d83-c990-e7a86714b6da@linaro.org>
X-Provags-ID: V03:K1:PDHitKEezgUiUjCfxhZnbfnwUs0ekRbrLcIPrq/uXGMVmbxn5RF
 TuftwyiPyy0MXH77AgNbdfHRei0P/ONqP+l2wEZ7bqutSBMe4dy4hwuXGvZ+nUCerxpPz+p
 36WS7VSqk/dO9FZE5ezfvyKoU8ObANOSiaTksPM9lRwzmKi03tNdiQtBMpZe0ZnS4pew3j1
 WckiazkKzVIiBO2bKeEMw==
UI-OutboundReport: notjunk:1;M01:P0:/z+fOpCzEgs=;vr7WM6PdMiwoR5h8F1ZpM3eMSGJ
 rxYJpRlhcXF43U0Wj1JFgKhnxg37oa44r3YANigJ/QTwqNBr/rCb8CBmLrAxXC7E330b7/xcN
 KiU0AYRJSccyZMOu/fVfkTjG+wy8WTXSaOUznKJt7SVeRepXx9GHkNl+zJkhOu9WlRjHQ0VQB
 W1ah2PjaWIqzwnr2NZ3mDlAqsEpBHKLbG93MlMfGSAnpGsHa1nXChrmF5SiOY2p5tF2VGrWxk
 /2BqV/83U9/lgPi8Vw0ieno+2puCF1MBGg/HXvzhMKzZ73KhxIFgtvyaugBu8fjMWP7/BRKAB
 wNtnX6WOGI6QH2HwOd5y0LKulK1E073+kxLe9sSwn/im9oEF719RNzgGCJOEZ991qmvc9Ji+H
 vv8550HOzESJTXcrW1RlyEpaItANyziSbigGaIVQPfpXnLm5m4xqe3nKCRDguhUKcdKNryfj+
 Ixi391Jv/YjcIrgV4zLkmjWIzedJJ0cajPKKFBgN1W6brg8Cna7F5++AIxjDy0vJBRsyGiNhg
 XTRHXYVXr7rKsgQqUU1Sj23VBGqzVRxtP3IXXI0pzrvBd8UK8i3B4U2naigJ2z85obTaX5L20
 zg5WMe8vv14kdIJWuPzCgSEJ51qhlp/75AwVwfmzohBeKecj71rhwCZkMYq7uzTMf1CovGeQS
 wMmP9ujh5wcE9/20wG7dI38TWJI4ThEF6JTloF/gz8RE8iIzol4ORl19/OFg7sTnjsFcpisEr
 z45dfoe/FxWFBqvlyy1x0USgf4lsxkgWx/purbeKYMV7J4hUb/HVuDBGx/Hb4Ew2G6L/c3LxT
 fhhAGm5++zJMFN9qRC9l1Ui8vbSF9De0YR9YJaKnonrmE1dL6dkMCtBPLNXHjZYfSwbkhP1Ib
 KKgItRJGW8I9OOPcpHmi2Ui6+l3kwfNLzeW/ErEKGBvoWc9C05SrN0b6AJzuEQOIFaljmbZdF
 kTPeJyHIZAb/i/jATIivAbJlCF8=
Content-Transfer-Encoding: quoted-printable
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

* Richard Henderson <richard.henderson@linaro.org>:
> On 8/12/23 09:43, Helge Deller wrote:
> > +/* _init and _fini are provided by the linker */
> > +extern char _init;
> > +extern char _fini;
> > +
> >   static void host_signal_handler(int host_sig, siginfo_t *info, void =
*puc)
> >   {
> >       CPUArchState *env =3D thread_cpu->env_ptr;
> > @@ -819,6 +848,13 @@ static void host_signal_handler(int host_sig, sig=
info_t *info, void *puc)
> >           if (host_sig =3D=3D SIGSEGV) {
> >               bool maperr =3D true;
> >
> > +            /* Did segfault happened in qemu source code? */
> > +            if ((pc >=3D (uintptr_t) &_init && pc < (uintptr_t) &_fin=
i) ||
> > +                (TARGET_ABI_BITS =3D=3D 32 && HOST_LONG_BITS =3D=3D 6=
4
> > +                 && !h2g_valid(host_addr))) {
> > +                qemu_show_backtrace(info);
> > +            }
>
> This is incorrect.
>
> I did mention that you should look at adjust_signal_pc,

Yes, you did.
Maybe I was blind or didn't fully understood yet.

> which has a lot of commentary on the subject.
>
> (0) Place this after the write-protect and restart check
> just below, since that is not an error of any sort.
>
> (1) If helper_retaddr =3D=3D 1, then this is a fault reading
> for translation and is a guest SIGSEGV.
>
> (2) If helper_retaddr !=3D 0, then this is a fault in some
> cpu_ldst.h operation and is a guest SIGSEGV.

(1) and (2) means host SIGSEGV can only happen if
helper_retaddr =3D=3D 0.

> (3) If in_code_gen_buffer(host_signal_pc()), then this
> is a fault within generated code and is a guest SIGSEGV.
>
> Otherwise it's a host SIGSEGV.

So, basically like this?

Helge

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 748a98f3e5..9762246eec 100644
=2D-- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -23,6 +23,7 @@

 #include <sys/ucontext.h>
 #include <sys/resource.h>
+#include <execinfo.h>

 #include "qemu.h"
 #include "user-internals.h"
@@ -32,6 +33,7 @@
 #include "signal-common.h"
 #include "host-signal.h"
 #include "user/safe-syscall.h"
+#include "tcg/tcg.h"

 static struct target_sigaction sigact_table[TARGET_NSIG];

@@ -781,6 +783,31 @@ static inline void rewind_if_in_safe_syscall(void *pu=
c)
     }
 }

+static void qemu_show_backtrace(siginfo_t *info)
+{
+    void *array[20];
+    char **strings;
+    int size, i;
+
+    fprintf(stderr, "---------------\n");
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
 static void host_signal_handler(int host_sig, siginfo_t *info, void *puc)
 {
     CPUArchState *env =3D thread_cpu->env_ptr;
@@ -800,7 +827,7 @@ static void host_signal_handler(int host_sig, siginfo_=
t *info, void *puc)
      */
     if ((host_sig =3D=3D SIGSEGV || host_sig =3D=3D SIGBUS) && info->si_c=
ode > 0) {
         MMUAccessType access_type;
-        uintptr_t host_addr;
+        uintptr_t host_addr, host_pc;
         abi_ptr guest_addr;
         bool is_write;

@@ -812,7 +839,8 @@ static void host_signal_handler(int host_sig, siginfo_=
t *info, void *puc)
          */
         guest_addr =3D h2g_nocheck(host_addr);

-        pc =3D host_signal_pc(uc);
+        host_pc =3D host_signal_pc(uc);
+        pc =3D host_pc;
         is_write =3D host_signal_write(info, uc);
         access_type =3D adjust_signal_pc(&pc, is_write);

@@ -837,6 +865,12 @@ static void host_signal_handler(int host_sig, siginfo=
_t *info, void *puc)
                 }
             }

+            /* Did segfault happened in qemu source code? */
+            if (helper_retaddr =3D=3D 0 &&
+                !in_code_gen_buffer((void*)host_pc)) {
+                qemu_show_backtrace(info);
+            }
+
             sigprocmask(SIG_SETMASK, sigmask, NULL);
             cpu_loop_exit_sigsegv(cpu, guest_addr, access_type, maperr, p=
c);
         } else {
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

