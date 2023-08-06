Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADC87714E6
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 14:19:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSchq-0000Ke-4W; Sun, 06 Aug 2023 08:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSchZ-0000Fn-Dx
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:17:41 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSchU-0001nV-E6
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691324254; x=1691929054; i=deller@gmx.de;
 bh=3j4/JtDPN66a0Jgkn0LY3i4AonLjxhCnzA3yeQjEfvM=;
 h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
 b=eA24+V9tM7rLhnke451yRKIQT8THbLDrFqFay7luBBBr5aQ3twqifgzohCSujHsNZISe3Hz
 EjGMxFdPqQBSq3C2Ti2APMC3Pbhrgf4TIRDF31Gv32QpPQfJzOIpdouNyXzhXzYiqQcP02ZC5
 emAbkCtZciqjvAFKW+Vhvx1PvXTmLABRtvuPKHuHEgma8qsuVnOOz82vFla9adclfst78Tksb
 R+Nn/Dp3ztFjqMMPmZhaUIiMI1OIkrRtHiFU52DEYD62zAuLuddRI9D1qxjdvFEa+Ic8Rkn3P
 fOR4T2ttIL2Fqh0SUMCC0UMwZpWlpRZxr+kKFRHkApgXabUdf5RA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.152.250]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MpDJX-1q2OlF2RUV-00qnK3; Sun, 06
 Aug 2023 14:17:34 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 16/23] target/m68k: Use MMU_INDEX() helper
Date: Sun,  6 Aug 2023 14:17:25 +0200
Message-ID: <20230806121732.91853-17-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230806121732.91853-1-deller@gmx.de>
References: <20230806121732.91853-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1lcPhFBfFcn6u12wPXhYgfMU617FLOfBH750OiCttfPYl49JgDq
 QwmiZxIm40oYpDwgMhUueFGDY4Xesf7RCBfeyEDInl1r33iFCVDW+d7rsyBhO+Tg11/y8YQ
 mn1gxi7peCn8Ar6gL3OSrdJzdcGE9aprhfWmAwjXjQxqA/uey8ShnlGsM647Rn5xzBjC9ef
 0w6BoS4Fkv3fIPEelrRbw==
UI-OutboundReport: notjunk:1;M01:P0:b39vaxdU/VM=;yqh7UYkqasnl8/gAqjToqcg4cq2
 MDZBnJsc06iD6tr9UABVATjJRzdGQdPJSCtAucMppYDR/sShCgNZ85N8iydePeCpxHIMcLW8Z
 dECyLPKM1Y62vEXqK6Pdongu1JyZbyZDw4e2APCWBItKtnqcwDxEpMX6x9A+pMCXOZuaTI8BP
 OF24RDSokk8TBsBk2nvMkuIrrjEbppfRg1SIcf4vF2MhRObQFzicjESGL4i6nqYz/KQwDCeDt
 ngOBk3qAVXuUZwZ4llomYQe8TyGzFQDjbLyfqwHlc+bd5g/uOYdIqb7RzEGMyWYDreadicW5B
 W8uUze5DKgiFGKTzbIuI428sC/XEv95zNac2VxwW+QXZtnnBvAaCvwahm9hvH0EcSekGrRbo5
 +WQLgmTVQLto5zUoTz1VL+x++5dBL9b7tPw8YwbfNbM6a4h8b4TEuNq97Mlwnpg5+BYBC2pIE
 +xDdFCBwQrCKmC/l7kjbdFnv4vNmVz8vwX/+aVsz4jJLwNzTJotH1O6GozugrfOS9czluSFU2
 1YkRZYnZZB9bguKsVNbT0MwKn9bKGVSPeA+MOY+n5dZIi0YpcJl8+G4Ohm3vorbcqbe2JVuz/
 yAcFGpZwFBm1PgirI2fPLcjGpc7FftGH4IQtr5739HVr2tO0AXZy2ZIhl+lKuLbiliNMwN6L2
 4xrsR5viMLYQQVQd56LbEFn4QKDRd4ImJIl5KhIG0jK8VmjhyFAplI7nb2Lno/lrhHGllbW+g
 4lGautuCq4lKxpiPIY8umU0JWeEN7JnXcgkm8n2/dn05gTry29dOs8F6Ybj+77a1hufxvIgci
 kNAgeX9tznaenq9/d02a/gY4hbDSdcpRbiXW1wBFNw44D3vN3mvV5Iutk+TRlNBEu2oO6JMtD
 ZdrFUx0dNg/MV10kQaqHRAgUS93UaajpKn+eC543KZEpaeRAnvOHjvakNySbNnFz3/IrlT40g
 wnO37hz0nq2XsiGXws9p8oMnI1s=
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Use the new MMU_INDEX() helper to specify the index of the CPUTLB which
should be used.  Additionally, in a follow-up patch this helper allows
then to optimize the tcg code generation.

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 target/m68k/cpu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index cf70282717..8321868506 100644
=2D-- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -571,11 +571,11 @@ enum {
 #define cpu_list m68k_cpu_list

 /* MMU modes definitions */
-#define MMU_KERNEL_IDX 0
-#define MMU_USER_IDX 1
+#define MMU_KERNEL_IDX  MMU_INDEX(0)
+#define MMU_USER_IDX    MMU_INDEX(1)
 static inline int cpu_mmu_index (CPUM68KState *env, bool ifetch)
 {
-    return (env->sr & SR_S) =3D=3D 0 ? 1 : 0;
+    return (env->sr & SR_S) =3D=3D 0 ? MMU_USER_IDX : MMU_KERNEL_IDX;
 }

 bool m68k_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
=2D-
2.41.0


