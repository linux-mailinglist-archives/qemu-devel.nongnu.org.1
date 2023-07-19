Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03324759A39
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 17:53:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM9Tw-00070P-Bx; Wed, 19 Jul 2023 11:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qM9Tr-0006zK-5r
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 11:52:47 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qM9Tp-0006P3-2N
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 11:52:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1689781958; x=1690386758; i=deller@gmx.de;
 bh=GcJX0PwH05RXdjGqj9MYbykoFQSW3eaMaUjhr3sxux0=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=h2Ev3lR7zClEULiUowIBb2hHYJVVWGzvNMh13FKfNHFvRKlYzqe4+op5XykQXOL3hx7aVBQ
 5j2fIxAxWS1hKHFjWv+TV6/P1pWf++Qum/1gKSyDE6aLcqJNfI8t+fDWlrNtQhGql4ZTtxDee
 cKjqCE2X4TE8gvlWTcEhd0PucP73lsef+hBmtUNt5+J8EhKsA0VjPWePUtMPeiTgCuQDArLgz
 0NJ3NplQ+c8a7ZKtmNLl1oL4IHPzCXcz0nvuwwaBHhko2rGZza21tp9UuGPOkwhbjrIhh56LU
 lGDxVqX0fmQhjbWvumgRMubaz7YNILSxvLkfhv3PgeJIGFZl6nMw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.145.157]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2V4P-1pvioL0w8N-013wkL; Wed, 19
 Jul 2023 17:52:38 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Andreas Schwab <schwab@suse.de>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
	John Reiser <jreiser@BitWagon.com>
Subject: [PULL 4/5] linux-user: Fix strace output for old_mmap
Date: Wed, 19 Jul 2023 17:52:34 +0200
Message-ID: <20230719155235.244478-5-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719155235.244478-1-deller@gmx.de>
References: <20230719155235.244478-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IjwP9qap1dfkmxXafXQiVDTU6A4wuDEgQGVHIsNr46Ol6CII3GR
 NHujKO22hgF7NH59OlolTL1615+6MXmyDm/7FEjut79iF2yvwVVgyvyysv1fzB5ZCuqd8qm
 5lsr/fTV3ohDxQMzZFRdWyKnJwXiV3kUT7tCt9thDN4bn3doXNEcsReTLPy/Drza7dQMCW6
 77EKtU9+bW7zfzTDaHHpw==
UI-OutboundReport: notjunk:1;M01:P0:w2N/4v1U7Ng=;9PeK4cJlWoftt8e91+EQ2Fm4vuI
 3vhBNaatb7pVNJjtTMJQn/lWnnxo0AfRKyT5DbyGEKaeo4J/gBL0NiA1vYoeI8T1nZi3rGpSr
 0Q4eMOMg6CMhzN/grhnWAH1Mz77AXe97vPeDQynxgDfD7ySM7IEE/M72Um/dcRKfYNshfWUXj
 g/tExCquaSFx6mtCzRt2y4kkj6l0i+B2O7DfSlUUjS4aUHX+F/Dq1MaPqUiQctFKqvlSl0yE6
 rYf8ij0LysvEjqe0SRxfIVErd8sqz5SK69tN5XoBJvlD9jdrOYdyPAAU5XvpsSlpWf5q7CP5A
 mBnp5UfiEf9vD1WF1oHPk1WVfsP3j7dVqIS1tTpkWjIcJLBqF64nUWFBDb++1lxqAMxJ1iGwE
 vde/mZMvjPIB4d3UDC7qiiSKGdVptomkfxt8OOoRGTi3E3aVHlAVkmlb0TeJUqd+VNbG6PsOw
 Gw4N31Y3H+MavHC9iChY7aiUFTPTBSUI4ipos1Rso4bOWGpiyWCJMnWrALm4CcMt12KKXq/kr
 5WBGXpMjyivxBV/Oe5jjSnZuIfTi+/vmZGk+cu/3VHfY7CDgJW4Vwy/TV8IxMDMMxC0xhFbqq
 p7tdqarihAgP4ks65cvYZM4ezzs0rHmL2rZUPus3gOgWpEhL+4OwC0DFbR/4IcIKQGPFPDhG9
 Ooy9b24r7FT/FTnflwaqqD6LCrJk2RUspcEAOvCCjmhacU80yrAXOLP2BDq5SnkFpZLiacOID
 UI6wPba1XYwOl1xYW4VAy581DE625xsr4QfB2fVH/q10751zxjahAexnXLk5t9vnm6Ub9bcqf
 BPT7NmF++yX0FJOq/+vT6AnzOEXfYjysHsQVitvfXTfHodribQt8sttzHWMwPO5u9OxXNGrxd
 WCThxj5/tj5eDLuw61lhYoXw1kOfSj5AzpIqFmvUE8Xq8Iy363hORSKBVEFD+SFUb+5Xv1tI3
 JS1EB428jrHxMIj41ZKCX+yVkEg=
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
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

The old_mmap syscall (e.g. on i386) hands over the parameters in
a struct. Adjust the strace output to print the correct values.

Signed-off-by: Helge Deller <deller@gmx.de>
Reported-by: John Reiser <jreiser@BitWagon.com>
Closes: https://gitlab.com/qemu-project/qemu/-/issues/1760
=2D--
 linux-user/strace.c | 49 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 4 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index bbd29148d4..e0ab8046ec 100644
=2D-- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -3767,10 +3767,24 @@ print_utimensat(CPUArchState *cpu_env, const struc=
t syscallname *name,

 #if defined(TARGET_NR_mmap) || defined(TARGET_NR_mmap2)
 static void
-print_mmap(CPUArchState *cpu_env, const struct syscallname *name,
+print_mmap_both(CPUArchState *cpu_env, const struct syscallname *name,
            abi_long arg0, abi_long arg1, abi_long arg2,
-           abi_long arg3, abi_long arg4, abi_long arg5)
-{
+           abi_long arg3, abi_long arg4, abi_long arg5,
+           bool is_old_mmap)
+{
+    if (is_old_mmap) {
+            abi_ulong *v;
+            abi_ulong argp =3D arg0;
+            if (!(v =3D lock_user(VERIFY_READ, argp, 6 * sizeof(abi_ulong=
), 1)))
+                return;
+            arg0 =3D tswapal(v[0]);
+            arg1 =3D tswapal(v[1]);
+            arg2 =3D tswapal(v[2]);
+            arg3 =3D tswapal(v[3]);
+            arg4 =3D tswapal(v[4]);
+            arg5 =3D tswapal(v[5]);
+            unlock_user(v, argp, 0);
+        }
     print_syscall_prologue(name);
     print_pointer(arg0, 0);
     print_raw_param("%d", arg1, 0);
@@ -3780,7 +3794,34 @@ print_mmap(CPUArchState *cpu_env, const struct sysc=
allname *name,
     print_raw_param("%#x", arg5, 1);
     print_syscall_epilogue(name);
 }
-#define print_mmap2     print_mmap
+#endif
+
+#if defined(TARGET_NR_mmap)
+static void
+print_mmap(CPUArchState *cpu_env, const struct syscallname *name,
+           abi_long arg0, abi_long arg1, abi_long arg2,
+           abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    return print_mmap_both(cpu_env, name, arg0, arg1, arg2, arg3,
+                           arg4, arg5,
+#if defined(TARGET_NR_mmap2)
+                            true
+#else
+                            false
+#endif
+                            );
+}
+#endif
+
+#if defined(TARGET_NR_mmap2)
+static void
+print_mmap2(CPUArchState *cpu_env, const struct syscallname *name,
+           abi_long arg0, abi_long arg1, abi_long arg2,
+           abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    return print_mmap_both(cpu_env, name, arg0, arg1, arg2, arg3,
+                           arg4, arg5, false);
+}
 #endif

 #ifdef TARGET_NR_mprotect
=2D-
2.41.0


