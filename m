Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0F274BDF1
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jul 2023 16:58:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qI9Nd-00061q-JP; Sat, 08 Jul 2023 10:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qI9NI-000600-9O
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 10:57:28 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qI9NG-00034c-2i
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 10:57:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1688828242; x=1689433042; i=deller@gmx.de;
 bh=4vNCKFekNbv+5ANANaDwSKyxfbXdKrgpehQ4Dcc1UMU=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=IKPNkRKHM9LqP0au4yVEwSo8pmv4QJxeI+YkxCayvcO3+Dn/IltcseaKSpa2tcvGvQZHd73
 2FUhiPx/JZbuCpeuTV63PxI1RmXvFcEjPWtpYdOivKUYKk+lhHXQ7pfF2+FoS5hhy0jch6l/1
 H8fpe9KCHs1u8wURpwzIKhKgprParAHp5HsCW1GA8czqlR9CC+62GTWuMrgvcTYv1BPD8WIdz
 AvO2966Ho5JcytsPETvsGZld/NSfVRajkAVsE9vdJWkPo/VMovr57mjirTxzBgMF8xKb786f2
 0eBvP1mjx+6638lhrfoJaFvXBa80Z2G2y70LY5vTcaSvGUIqoFNw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.155.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAOJP-1q7NsY3SO3-00BpM4; Sat, 08
 Jul 2023 16:57:21 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 3/3] linux-user: Improve strace output of pread64() and
 pwrite64()
Date: Sat,  8 Jul 2023 16:57:20 +0200
Message-ID: <20230708145720.136671-4-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230708145720.136671-1-deller@gmx.de>
References: <20230708145720.136671-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fssPYm3fYGMtxB/g5WU+YD3/OY8L4J9pGHEdIZEIVVcg+m8UlwR
 Cuvl4zw+EgftpgZesy8pNs2LfTK+Ysobm3sh3o8PYbRcyMKrDvtg5q9jmVhyC5PbcY+j+U2
 aBMiVvI2h5nTie7lR4eCKDiy0FQE3bhWpP9ZEGQkFYSfEBfNaS0LjPNy0cCmzGfThDpOCeo
 Jc924lO3FDvhOyypEQemg==
UI-OutboundReport: notjunk:1;M01:P0:Hea2zwU3TIA=;QONE50yGGDzdLcfVBjOyzmvpWAZ
 yqnHxFm8yoQ8UccRiu0JeKgxtYAihtL5N21IVCwRBURdngi6Nr/lbmjFY1ZwRlIir7ttNNAbw
 bOmekZIF8JhZTSruldr7xpZTcfGZEujnkIqKmn6ZWq2kW6tdtcc36BIQsPI6N3aXw7Qce5I+6
 4US3WqQjZtsremYci8tG6mE/5GjCFOSAPtEhYyfevm7sRij4G01NLY9MRZSM7v/0Fv2OLVG/V
 VwxhB5lCa5WmpenVYXI3PYk1L6KNayB4o26dJZs4/ha+NYWGoFSVwmKDjobSqgwd0vUzFDRks
 6aSpkRYNfYUtlRxfd8oCB7yJlpBgplPMOBmTYzzZpbWgtSqRU25hJb7J8bClH+sSTwYVU/D5t
 UQ7eeWel/q+AjP4j2GZdGtWbZEOop0X52D6+FufbmtQw5hRuXqx2lUS36OXdP0di6r0wuqvFW
 XlNM9MeWPjI2/XnC1CJ1l+RFv1ph7sJBV1oYm6cBo7HNOlmoBng+mXwThwb0t7um1cJ487J3x
 ZSKXl70sea457hsHJOWwyRzTRUM+lO5uitvwyxq4vTgznf6TW4ZarfYryagafpEdkp6OyUWz4
 zLhqg/ACXFLeQZJZ5amkpOoHF4g+NE3BAuqWnGuyO0ZxR4/QpNIPDEcTDKUZnF/gvyVHp7uyN
 mn3JXS+LOKul7+bHzhi+nxkXXAuuXZbcJ/axNWhQzL3aQuh8+0SYuDST2ygn5cSuYTyZOR46Q
 nfKxXalTdiP3cwr3wSkntaV8yaUTkvOlNodEORMgWosI92RZeqpF7Q4iYEg5Vi4jgiAJLbP6Q
 HClMbX1qSWLx1EHLO3xVzKCYg83ZjydFrvzJ5yga9wNfGtjhAxRh3DMNai/OvbKZM0W0pInFx
 JadOQxv7WVzB0dPYPes0CylH91UniZuipwuQbE5nXPuX58gtRkbnrwJyANuua+G07Nexj7K/7
 1/ZHUg==
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
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

Make the strace look nicer for those two syscalls.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


