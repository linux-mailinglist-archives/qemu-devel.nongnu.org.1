Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2EC756EFD
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 23:36:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLVss-00025M-3J; Mon, 17 Jul 2023 17:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qLVsn-00023H-Ul
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 17:35:53 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qLVsk-00083l-8F
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 17:35:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1689629747; x=1690234547; i=deller@gmx.de;
 bh=KUncMKy9WijiQatbHwZfVT1Ov1h903vkxW37+woTdNU=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JSa6iGHnqlJozeGNwRDBZEhhJ1V1SIr7jMNtEghclTu946A2ltJ98fBpD9u8U4Xke8xwf4o
 Brdw/KVnoaGEX6bPPXT8JHvfgbG2lp2vQvgEZ5B7pxy5DBWHOnkSJWbVkZeECIOz7B/0WGAas
 L2l9U02yimQ5bYGmhxKtO1AMRQnggU8cwZgqADNVVPuLS1KsaFTC6NC6AvaUaQnbkppQW09mW
 9wMxY01p9s4qDRMTa98M/dOqbbivdPO4SUiYJxNbioq7XjcKFlhVmDiMxZ/9SJYpKaAFiQRdV
 HWVVKd36BlWtlqYHgkOidnzwlhZPBjBStd0pfWS35qVEmMp8Eqgg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.159.97]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mj8mV-1pgNpm0Nwj-00fEzk; Mon, 17
 Jul 2023 23:35:47 +0200
From: Helge Deller <deller@gmx.de>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>,
	John Reiser <notifications@github.com>
Subject: [PATCH 5/6] linux-user: Fix strace output for old_mmap
Date: Mon, 17 Jul 2023 23:35:44 +0200
Message-ID: <20230717213545.142598-6-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230717213545.142598-1-deller@gmx.de>
References: <20230717213545.142598-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wHPIVKXnP5yU6MEZ3dxkwdz/AVdzphvlzmuAE3u3oXCJNK3IYXg
 MRpyP0rNcirRbBu0JlsSOD16+i8/4j9iDZfKbDAicuXTCD9mn3MDpfWDAUY6cjdEyweWa9S
 LsBv9NoRgRoy2bJbSMJRn8ykUfCNnmXBjCa6i/XzNjD0J71rtk3VAivNr00Cm+3kq9gde7M
 RI5G2CWVXSnqmiDTry7Rw==
UI-OutboundReport: notjunk:1;M01:P0:+UtD1Q2TZHg=;327xq7DJTB+qQqX2/qHmTLifkvb
 cPuybQ9tJ721vy3d7v3L0SdcOKgFmkBPgthNDmbj44gF5f4sprTfYUPljOmxs1nmAL2+k4DzO
 KMJAeI2EKg7a1mHwENRsmpymFKuy3SjUXspqfkrKDt3CX7gYMuSHEqyDlyhahdFB3+q67PAa9
 8V5ajJKA1HJzb0YHB7PfQjIGS0tkZFLuuqAYUhRHDX3V2SAvD40dHyk7iBb5nVHBPDX3l7f16
 n8H5vX0Ef0WnEQBwBbyi+kfEuPO5CKow8H8eSjmqpAKPvBlEmMoR1BFmxRrO+i4ipBXcuFg3Y
 uclFXzs5e8znkisWufLH7SFXBrrhmz1Ls7pjvY7tTaF3YYjDKdsfuIFCQqX172GFl8NNre004
 zOvPdJUEV2QnKN/GkH17MV2gjKq+5hy/WXzF3gGd3SpLNOT6bHP8FiuT27kTWXca0VTWaGGFr
 U+xAOj41e0ENLgq1qvdkKFc2nG1B8+fYqJEjX+ZHcwsPppn3ALp3HxyUIUkbLqZYk7iubfV6B
 FZYUH2m53yDHgI9AfzL2pe6hAwqgpsaELHwRGInOkds3YJjZ5fJJjbUVgK+lapW4WC2lYiGyX
 K/15+hcA4nRnYHQo14oJTK2bDqab+EL5bJK6wTJX4GGcWwmAEP9eypeQL0M8oP6btXsUYdnfp
 hiqQXOkHRjWtR6TVZ2EKH0PaFyo0oCwusNzuA6OgEP2EEHVRy1XTSVixKrr6FUdn2dFaSiJgw
 HG25lvvhk9QHeqcaycrKIvRIZH0oKsHOlxyudjRIXjjvFsT1GjOELAylhMg02jE7ZceoaQ1lj
 s3Haj7+9eBxwsBJobt2jpBdo2qq3kEA37/FR/G/H90onJboPeAYcMIG7rqqpQKeQHVy6Ro8z1
 KnGOrmcq6nxbSHnmkcW0+zG1r4U0ylKP0ZiwiCSTPJuM4By4zBaT+8oPDQntNYHHrSk2NlZfv
 Uq2LyWyild73bjbGz60QLUHiPqs=
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
Reported-by: John Reiser <notifications@github.com>
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


