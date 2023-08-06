Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F937714F2
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 14:20:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSchs-0000Lz-Iq; Sun, 06 Aug 2023 08:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qScha-0000GZ-Jk
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:17:42 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSchV-0001o5-5F
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691324255; x=1691929055; i=deller@gmx.de;
 bh=DYKNn38KjnEDUEwlcK6bqWAeJvviAzR2xTLFiKiKkMg=;
 h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
 b=OwsZFdmO1bYz9+m5ckTHCUBN+ZlMmbpk+l8xq1JBUUdrHefH7rdh2tueIHXK/QH1+LC6WK0
 rlBcD0xQOivvDO/1aEMOKrvlSrfixKk+9E3IP8qr3zccsUHrl8RykJ58nui4SE4VBiMvKyZuw
 3CytNOFt2fq6HbQdDuNQwFcJqVojxJJ5umNaOgLmdmwTYQPmGYlGkRozB1xxdIM1MO+8im4eS
 8cQ8q/iBLUUuujS4sXj3wpRklBjt8OM7Vqvo9bDttvuizFZSwOpFvZlcieHc9S/XASMY8Pf3z
 XmJdXD1gOZ7eGbj6urV1aweEvRA7019X6/u0zfKrpk7aOrk22jMQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.152.250]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKsnP-1q7VJK1XzB-00LCL1; Sun, 06
 Aug 2023 14:17:35 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 21/23] target/sh4: Use MMU_INDEX() helper
Date: Sun,  6 Aug 2023 14:17:30 +0200
Message-ID: <20230806121732.91853-22-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230806121732.91853-1-deller@gmx.de>
References: <20230806121732.91853-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I1wJECXjR5x2Uj/l2S12HrbaOfyIwawyBIYvPpvnRhDqpnEyq17
 la02nkH6NKhAsuWFYt1oyLcAmCtT9OpGpUWcAK6Ei7je9OyacC+uUtil7ZYH6/884PV20UG
 bkpHeyfjVmPa9KpYLIgTVf4ZdlxAkVYjyLboQjPJji+mxuV715/Ki59nSPjFPkScBD2hCSr
 6XWJjF5i4axWItDvHJG5Q==
UI-OutboundReport: notjunk:1;M01:P0:2hleSz/vmas=;IQHtd2JG/YscWlAFxCqrKNoAWMI
 2ypTAiAokIavNzKgBcqwWf8oLWB6UnaSWQulK1HwED/cBUMtoGHR0k82uzINiK9NGNMcDRPX0
 zzkEXJGOYpMaWwgF+8SkjkymCirUTDibJRJzwVNvYrv7QWx834g2lcr7DsXkRmYNelSue40qp
 lSVgz+FpuaHOWtslhdy96avZhP6sFyds5+EStZxIc1YxSOChaMPXbpljx5ebGq0cEFrNIo6MA
 lPXsB/Oizck8mSH6H88RxD2HAAo7mQV/tlwc85WGJu7LAoGXBrFkm1TsTwtHXch+dM61alM6R
 BLtA/X7btc/1OWRiUPglVf55edUKfvvgT1R/vy9BMsygs3CA1wMH9RPXwmZ3RZADI6Inur+kq
 1X858gCETjoqyeBW54McX1LmDVytMobRb3stZKAsfjO91al+bMUGijuWLNjt3pqWtPHePft7q
 Km4WQjA/fWYPAL/YmSMTbgtlRsdwgJjVmviHz3E0QUGH4iNmFgpkMLwVzqghAkKEeAPJte9cj
 lD8B84/Zqb9PzEW3578mZhPsJZtux/2y5TXJL05vvHfGfrkTQBaqgACXwoGFY6yn7aXeUwbZO
 sPTjQcVEU3dndYx2LbAHIh3E+AxVJbgnIASsqvlV/eTM85Z3x7WswZJrueAX8IFg7vCAeRNtY
 DDFpEN/GqCkDMwBIP9/pZw2PxCMMb/mHIB1r73ALB52XsoBii03NlEbTYXE7g411+G7P3wmeZ
 FjhqdhlT1iX5zKgBn5yuHcdHsUdWUKoY/UGN/fDVfnvwjNRSxaBXPcBU+S4nKfglM95j1AbLg
 naEW7yCSPG8bQp2LYrO0XC4BhOWJtC/dUexExvn//SR5JESC3AjG3SZPuY1jn6a93tWr+CWME
 XSg+WjjiosE2BTvqQdtwKc2Z6MQGjCZoOdvgYHXlIPLD9JPzPDm3Iw9TN9eiHas7DReoQm6Y8
 gGbJRQ==
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
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

Use the new MMU_INDEX() helper to specify the index of the CPUTLB which
should be used.  Additionally, in a follow-up patch this helper allows
then to optimize the tcg code generation.

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 target/sh4/cpu.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 1399d3840f..9adb1bb893 100644
=2D-- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -260,15 +260,16 @@ void cpu_load_tlb(CPUSH4State * env);
 #define cpu_list sh4_cpu_list

 /* MMU modes definitions */
-#define MMU_USER_IDX 1
+#define MMU_KERNEL_IDX  MMU_INDEX(0)
+#define MMU_USER_IDX    MMU_INDEX(1)
 static inline int cpu_mmu_index (CPUSH4State *env, bool ifetch)
 {
     /* The instruction in a RTE delay slot is fetched in privileged
        mode, but executed in user mode.  */
     if (ifetch && (env->flags & TB_FLAG_DELAY_SLOT_RTE)) {
-        return 0;
+        return MMU_KERNEL_IDX;
     } else {
-        return (env->sr & (1u << SR_MD)) =3D=3D 0 ? 1 : 0;
+        return (env->sr & (1u << SR_MD)) =3D=3D 0 ? MMU_USER_IDX : MMU_KE=
RNEL_IDX;
     }
 }

=2D-
2.41.0


