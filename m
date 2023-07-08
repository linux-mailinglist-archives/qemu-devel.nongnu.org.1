Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FD774BC45
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jul 2023 07:44:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qI0ih-0000pk-N5; Sat, 08 Jul 2023 01:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qI0ie-0000pE-SX
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 01:42:57 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qI0id-00027O-0z
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 01:42:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1688794971; x=1689399771; i=deller@gmx.de;
 bh=4vNCKFekNbv+5ANANaDwSKyxfbXdKrgpehQ4Dcc1UMU=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=YRifo0opPTQch8it7T/lnclymZwb0kjazygCvwI1E3MtvfUZlSbmywmcBixaxAuv7ghSFrE
 NzWg3e8voVl3hjhLRV0yRAjbPlSscBQp9RL2tRVMzwtEVdkPGDtuJ9gAQ97WcbbFB3SEOQqmY
 Ky5DffjhnfeaOr4QrwjcmTnFNruhxoSIPVsAFshxLytps/gmI/DMQFEkygz0M07d4ERAePhUe
 3gpHtQyTdjgc4KVpImsAckgqx0idmUtBt4eMAt9mwbT9E0R+2YjTpBdiIB2qD4NNdYGfUyEq6
 Gj0GeEdY5y4uoKu5b0PGX2+B1nJV3I19HP+h4eRpsjfBviWv69AQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.155.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5mGB-1puNvc0pXn-017FEZ; Sat, 08
 Jul 2023 07:42:51 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH v2 3/3] linux-user: Improve strace output of pread64() and
 pwrite64()
Date: Sat,  8 Jul 2023 07:42:49 +0200
Message-ID: <20230708054249.10245-4-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230708054249.10245-1-deller@gmx.de>
References: <20230708054249.10245-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zVAgNptuRKJAjXbmytA4SJCjU7fJDXXD9A0ruIVaJXx08R4ChrV
 nQQvz8MWC4DwLmDUDgmMWJsv0l0OQONCcuQ5R4o95IxcpQntCYH52UEN0XIJ8/UXgpIEDaN
 BDc9jRoHHIg9rrb7CGfqjqK6DuF8e29T0Fkb8SpAP5Gy9nxumskM6pw0xDHAV1foG8vi36l
 av+/zuKhUemS12mkNw40A==
UI-OutboundReport: notjunk:1;M01:P0:XmsCq6CAPtU=;x5YmTWaWk2Y9ICBi7LTJihC53Vg
 iaxPZ81UDfrEo+gX+f9bdn/zpLVHSsCg3Yfpjcx6AFxHAXioOdyXW8fxsdXVhPqLw7jGHuyk3
 nsSzn+r200Bp2CmqNT0T3meDPWUoZcsJEnFz36ULACg+ADItlxPLiWj92P4otZCViddtNNjTx
 C/Yjcy8Y8LvGHApgV56gP4B4zemXK39YJGdkZJUCiosGNEsPTkD+45DJQ1kGvETvd09iBeSbL
 LPwhDFKd9IgTdTIwUcQQMWO/nSH1OYCE+4JPJzew7ZnnhHwM+vUzz/j/kAG9PidZuilhasOO2
 yaGJbX/Xqf1nkE6qcI3fDnfoMq9D/pPqg92anB0aby9qpijCd8g45p6kjBxlbxHOpMX9XIn2D
 ZJ60DZ86HfPNAcQohxT+pwzmSKTTas4smKdo+VTPat3ERGPbIPsgPtrYdiFLAV+7UA77KQw/F
 hWquBBmzxkXCPZYJPWP9casStoh9X0yZloCa4QhMnJGRm6XupNBcSEjQrQarVBuYid4SCaJ+h
 UdM4QBVUcoiti9uCDq3T9+hc8dTx1LjzUNso1KwkJhk82TvLV22uxIqnn7m4d5ogOBBI6fL5i
 COyt2C7kNeVtg99azJheuaYydBS6MTxjAUNg0hbALyCuXivrpG/kJdI2LBHNlE8b+vtMD273Z
 2N50w4xnO+vlbszIZAIO8MFj61RaP13MqT3ZyNq+j9LWQtgHMmkcbbing8u7C1r+rYR1H29LU
 yj/HYOG3h3zKORftOfhU6rU1rJbI0J5kRGiqoyLnbXE+Jmx5Gy5WgQJRlKjBZHUsBlP+3CkTb
 RWfhIBvffVDBdjCEnmshgqCzQ86Ro4eVag2lWIa73vXooAlcehvqmlUBMlgHwtlXhchZtiecZ
 iS7nEbYrLEyjKWYelOot2FHC9IKogC/Vy0TXhS4kDKT3WaiZeV6Pho2jcP/k4dcz5YVLjA6nO
 vKe5dF6zIjoMTzAIjPKTo4bmCMY=
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
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


