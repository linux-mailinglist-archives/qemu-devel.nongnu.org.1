Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 828A075851A
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 20:54:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLpoe-0000tS-SD; Tue, 18 Jul 2023 14:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qLpoc-0000sr-9J
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 14:52:54 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qLpoZ-0003Nk-6F
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 14:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1689706364; x=1690311164; i=deller@gmx.de;
 bh=GcJX0PwH05RXdjGqj9MYbykoFQSW3eaMaUjhr3sxux0=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Ztl+Q5uUoRHcolJ0kyOVC9lpWiQjlOOC/WnqClUpvrN3IxY9/8DOMzCLnwr1dAxHPaKjw3/
 Vu91QItsoHAiLavxS3KwpQRR9PKRo3h4msra7nUgsHFhPtOmAOVNc2SUEYON77mFhEBhN/Elo
 8svQEYAEnIdURpEiMSJzOQyAC312AqLBsinzP8vRsuf2jFtbUAHnq025PfMMr4pRkK3vlAcDf
 hgjOh+tx3akAqN6EXRICpeExSIy4eTgCMw4fdaYFCSTKcoebUM9vE0pkF3ukillbUyqh8vQBR
 KSAoJRnHzZCXV+K2CtrEg5iAXvwovms0iGm2UiWMhtmUyJiaTSgg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.159.74]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mi2Jn-1piMBx1rur-00e75H; Tue, 18
 Jul 2023 20:52:44 +0200
From: Helge Deller <deller@gmx.de>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Andreas Schwab <schwab@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>,
	John Reiser <jreiser@BitWagon.com>
Subject: [PATCH v2 4/5] linux-user: Fix strace output for old_mmap
Date: Tue, 18 Jul 2023 20:52:40 +0200
Message-ID: <20230718185241.11433-5-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230718185241.11433-1-deller@gmx.de>
References: <20230718185241.11433-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0dFX3G0Bd6BSsOP4o7TQN4/V/N++S3lfnco+TNsbJ8h9NXzvxju
 8lB3mb3bl+qO7WODNETNf0CwsEMsPFwiD9Z79+Ax40PR84/NBIE09GEQA1TBaXk2qIKqIBw
 YXyi7vDdloEqfOzgQQAqa6T4HcpuMKQVV0LFcVrXOUl6+q/qtYSO9cvBTKJ7uPuwH7kon94
 7VQpkV3LEjzm+3M8IUNcw==
UI-OutboundReport: notjunk:1;M01:P0:yEey5Un+CoU=;pX/9gPDpN4Wi6iVvXsDDqFdSvAO
 e5mNCiuG3fiESOa9BW/PdoHsDryqJi/F/XuZOvydqdNzPFKyLHL8vDd23BeDEqmgR7jHNrpI+
 VSOMbVpLo+g/f8eJRj0EvePQAfGUuoxDyvf/dYBliVzzUSWA6MrxlChxXtvmclnlLsOBtWb8D
 q5whGVG8emsAgiOIXwTEBPstQ3PSraPSnKFoX3zRTyFbW/30lm5QSq/xWcWS178FGZRWlV8fi
 ueVWyS2JeNxtR+iL97iYf/B3ZiXrFPsts4x+GapRR8fD1XExd/7n565BC9Eq1AtdfBTd2AHWq
 DuF1c+0Ys7JfAiC1A6BtytxRH+hghgDGYFPXrJ4SfbwjaQGWIImS1N/tUSBOYQwc18nYPvXd8
 MjRBeRYUCrGSesabXpP1Iy7D9n3RRvBn/hpNOxbxZBh+RSVr7IfZkvY9uTpALZHQadNrJOVOo
 Vq8FI0bCerhtBZxfH8zK6IGW49UUJII9y0UDB400m5meB8KO0Nsdz1bRzW4VzVnzRcOLcXgY6
 o7DpH2MPb1A0g0wFY3j4NWjpre2ilQDse7oU3RF1vYXFZuNPhDwBaJu5gyd0857D8nR9jcIQQ
 vgGuoR1NIPxwHSJw0nCMgqT6QJyNKW+j4pZo4A8DsB07vfhc1rWzwdhqL8OVVKO9ZABC6dljS
 D5o3uQYJznZXxiM5opUxPeDDvKp9DAqxMWQwgcE4dHFL4A0DJIdSPl2TdpeFrKa2uDxD0Aj+e
 +ajG/ZUAEwPgW8+mNlMcRSjR1iIoz52E41Is6OKFBwRMsS8Y5v8S6a4kcGnn/tmkgL/1ogPET
 xspVY/rkF26xcgRBU7x6DHJ2+WJzlk/geN9KvEH/2XXqXUvUlwvqnslKZ1DJFpm6iBhaeR/yG
 gVg+pg/D7FOUcs0mCpdGYrPevOHDfvPcQpSDaw1Yb7aEMwgaC7HvF0zS+kZGUJ6H65lJwmKyi
 EK9K5k3GgnlCs+VcL8g0nJwnhpQ=
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


