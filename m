Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4443B74B1AB
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 15:20:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHlNH-0005Rs-IO; Fri, 07 Jul 2023 09:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qHlND-0005R9-Ls
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 09:19:47 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qHlMz-0001Lp-KB
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 09:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1688735969; x=1689340769; i=deller@gmx.de;
 bh=IOgfBhVbwG0r69fo32lc7jonL/HryVyaw1Y9m04uDho=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=avQy9ehZwHO7KXT7+xNPgmDhxhJaoJIGHWlX6XcPrjlHVe4+fnJY09hrXs2orQ1ASUE4Nr1
 BqGiJGguhVwoVFAEjFgTFiOpzx18azsb+VWHfAJoSxeXZ874PP09oVbtfVrCaKr9xJMs1+3Wb
 hSIntebY4N4Z+5tNCBP4XbMJof3U+r0Y7g/UaDZwTlELkixwaY5wi9xxfb8r6VCj54ufg9lgZ
 drAdIjp1LWsgOs/k/CfRiIxEvnzUVpscW03tIQSmgP8xaGoinH5Y2B28oOkkYXsl9oQlWIdPq
 30sCgavbEq9qwbYi7y6chLNdrUr8n8tTsdhGNlsNipUrp54/NTxQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.153.180]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MplXp-1pdVbI2bPh-00q7sL; Fri, 07
 Jul 2023 15:19:29 +0200
From: Helge Deller <deller@gmx.de>
To: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH 4/4] linux-user: Improve strace output of pread64() and
 pwrite64()
Date: Fri,  7 Jul 2023 15:19:28 +0200
Message-ID: <20230707131928.89500-5-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707131928.89500-1-deller@gmx.de>
References: <20230707131928.89500-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:w5aGYmQFcHDQ3bfY+lti8c3erT+KGUBxeJfx6LqDPz2QsCWxpW4
 nCmH31ZG+QENIYAYuhHH25ilqxtT/vtj+5nWS9f0cR+KR8sLR9tW8YifiXjnLuEpitjyRw6
 +YwZpy1B25caLRGl93xbOIptSyLwTAEy3ugnsonCwr+kheWngwY2jHKdpjaej2gECEN6eWh
 d9/vu1meAJyLLHOiTSK1g==
UI-OutboundReport: notjunk:1;M01:P0:nQv6cQuPpdo=;ZNQ6bnpFCI39SFqKbPtVOcYohZF
 XQ5uIV6RhIPubsO9R1SBN5jS24RjVZImME9aM/fwGJBi+VYcclh99H98bjsC3sL3kUtS7Zrc3
 m8GzgCE4l8H4SfQyTX/hzY49fkao+lNvFT9k0ADWoGC7TTbtYYL0pjNdi0ShfSQMpgXfS3ZoC
 TzxDByPExjoKJMFTUQJi/6c9Retls/CfIq7BFd+JYezktUidOUsFhmOgJBxFANSRcLrCAacXZ
 gK/inV+kNJmJ1cPd5+hzOg+312U+LZc82QJvN+rk238SIJLW8srmSwVRdsZexkeNRMB8ljZN1
 TZdO9UD2gRSNM8q0F1lErhaDY9kwH1nNrcgYEdyMWo1A6w7rQhyRemhMSgIfMfEaSeLqguSZz
 FNkS9PBl+zvc05TqMxPyX1/wJbedFP+y+F0y3qN2faoT18rEeFj+Ew9dbGNoeFsboAW3Gp6eK
 oev8gKYqbta33Fo48H8LRgfmriQkjw6+5EzVLCB4UcBMkvR+5RxjVUraG9hloZBrBEYc059fQ
 Qm14PimuAqOI29K84fMMPVZ26DUKOf4A2jodJthO2RgPMvR5yVGfq+i8mlZ1sl+5aSC6wMG3Y
 5Wfwog9U35jsUYoAqsE/D6X7FNUXfbfXNNa/znKH+ZmtlQcOjr1mousFp8gyLF3DES/d4GaSA
 fYR9k/Fy8HBAudJGOSLufgrov5QakduP0szF20lmqiK5TWY0SS7pMXiryv8W7x5mGv7mqfTo5
 uvFP1btxIFPJcTyMTechY4WDJ2WsWZreLMlWEyA5x/wsx7Z7Ux3kc8ZRAQMlVHpjrVqyPMffR
 lzr0gEOxhYbuvK4DLdfrgw22XjGe6y6I5YrvY9/bA1ChaSCiJbSjyASbLz2njKA3YUk7z0VQf
 xWVqcn9z493e9CW6d7rGznOJsK5Vd4+53pRtjqKw+O7rMizXMaMCNTyhzHKQeHoGM/YDsJ0sh
 dHRwsg==
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Make the strace look nicer for those two syscalls.

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 linux-user/strace.c    | 19 +++++++++++++++++++
 linux-user/strace.list |  4 ++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index aad2b62ca4..669200c4a4 100644
=2D-- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -3999,6 +3999,25 @@ print_tgkill(CPUArchState *cpu_env, const struct sy=
scallname *name,
 }
 #endif

+#if defined(TARGET_NR_pread64) || defined(TARGET_NR_pwrite64)
+static void
+print_pread64(CPUArchState *cpu_env, const struct syscallname *name,
+        abi_long arg0, abi_long arg1, abi_long arg2,
+        abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    if (regpairs_aligned(cpu_env, TARGET_NR_pread64)) {
+        arg3 =3D arg4;
+        arg4 =3D arg5;
+    }
+    print_syscall_prologue(name);
+    print_raw_param("%d", arg0, 0);
+    print_pointer(arg1, 0);
+    print_raw_param("%d", arg2, 0);
+    print_raw_param("%" PRIu64, target_offset64(arg3, arg4), 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
 #ifdef TARGET_NR_statx
 static void
 print_statx(CPUArchState *cpu_env, const struct syscallname *name,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index c7808ea118..6655d4f26d 100644
=2D-- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1068,7 +1068,7 @@
 { TARGET_NR_prctl, "prctl" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_pread64
-{ TARGET_NR_pread64, "pread64" , NULL, NULL, NULL },
+{ TARGET_NR_pread64, "pread64" , NULL, print_pread64, NULL },
 #endif
 #ifdef TARGET_NR_preadv
 { TARGET_NR_preadv, "preadv" , NULL, NULL, NULL },
@@ -1099,7 +1099,7 @@
 { TARGET_NR_putpmsg, "putpmsg" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_pwrite64
-{ TARGET_NR_pwrite64, "pwrite64" , NULL, NULL, NULL },
+{ TARGET_NR_pwrite64, "pwrite64" , NULL, print_pread64, NULL },
 #endif
 #ifdef TARGET_NR_pwritev
 { TARGET_NR_pwritev, "pwritev" , NULL, NULL, NULL },
=2D-
2.41.0


