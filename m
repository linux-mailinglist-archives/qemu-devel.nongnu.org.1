Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FA97714F0
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 14:20:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSchr-0000LD-Qc; Sun, 06 Aug 2023 08:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSchY-0000Eu-Sc
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:17:40 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSchU-0001n7-1F
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691324254; x=1691929054; i=deller@gmx.de;
 bh=wW8jWkcZw5zu6txqL6q+MBM+DZULGnKkQ9in2Fgeebg=;
 h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
 b=EfTANcGyxaLg2VvXcwGqkjxYORfSykAgV3Trp3YR76T21TjzVA6fO/rbDA+lgKS4VGnd0V4
 YkcfU5HInPooBmMIkjRnvdLEJRe9jXhAAPzETsYMSZkVH3RSCHexlnKmLFevxMKneFyUTm+yS
 R9XRB6ZsSyQeq7I2J5goUoAdB+YEKxXwKRdiLp5jv+1REOXA1bdOzXPuLPnoDrln8jl7Uy4vl
 nGWVzMK2rWiZLbln3IVOQicsoUqa4Lrvi2y/Zf3mHkN/jwblwRES+jQcukgqMmlkP/NJOS3tH
 5EiOIY2AFGxB9DnQvwjH6vLhhEUPWccOifMLuVw4zDfsIF4wrpZg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.152.250]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6lpG-1qTAvI0s5G-008Lok; Sun, 06
 Aug 2023 14:17:34 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 12/23] target/sparc: Use MMU_INDEX() helper
Date: Sun,  6 Aug 2023 14:17:21 +0200
Message-ID: <20230806121732.91853-13-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230806121732.91853-1-deller@gmx.de>
References: <20230806121732.91853-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NLSpTp1PLmXKyeE4hNkYfbi4NlAFXEQt3vSTrgGwWwitIgMqW5x
 rO1nWHKO/rocetXd8odx3jMVNf6SsoPKk+h6jIP5ikEO8tymMRgtVC07fIZ28sb0qJsazGf
 bKwrqehF9HxuTznpcmAdvTNG6XQpPjuZAfdT5NDwAOV7127f461hNuUXFTaQDLCdzKbLSqG
 iB4UKISXXOkDhIvUHwLpA==
UI-OutboundReport: notjunk:1;M01:P0:QKafihooABQ=;+cHLYl4wq+VOecJEjnQD8UK6DuT
 bQsR81JU6TCAkoo6vaAHzoLL2HYqHjiYTdLOqTRSP+Y3VBOeumojgTI3NZcdtu9tBumR8w0vb
 RwK+lcnI2kjBRQ8qrtZh2ThomH0R2mE7qqosZcnMU+0oVqzd8adhM4OlKT8tw33rXEq8+bBH8
 hatbdgJpiBJfILazHCN+b5mg4WtI3k8L73nJvpOz2K7TSqw+ucjV23e4m6DfA6CTrWdfZG3Xe
 vMqnNlgKar5GoZ6nYtZXK6FsandyYjdGsM1njr8YPR6H01NO09u6aBAS+GkYAVdhHhkuw1ZsE
 R4qiCqljjnSz/0RNDwVyVudtUhiFDuG02ywTIYmO7cag61GQqcF0xlwPLPCyHN68vHs4Es5vh
 8c/AoHY9yTB2w164Kt0ZNp569DQG6/ar0nminaZl5m4fTwusq8rDfCuxi69hLiNoFG3/qyS4D
 /uMLwz9anUiV2Sy6e/4CyKbH+reDkCFD02rKr/8boRwjTPMmwnt//EX8Ce9zD/gVzmqDy3EBe
 gLdHYeYsMagAH6naNJh13BrqKNKoJuHeMn3AegCKJig9q7gWyc69Yph355hBp0DpnDvNN6jro
 5JEmOM1nTYhobuGWNrHmxMc3hruNoNcGy/MI5wHrdCy3NKSffdReZY8d7MHCUX2xY/ZLt4Lf9
 fXgVgIPCwu3Q0iZavWzLU0dBpbFm7OEGxJJYSRogP9iZM/H5E3tarE4a9kEUEtaPs3agTTxXa
 nkbC+WE5dow5UQPd+5L8FYMX+B6UF8UOqq2u+aq7QMKlgQmhtcnkcjFEEkCoLfKGBLIZEEO0Y
 oRurKF05m0mV7yHOFHjoC48noS/X7A2zz1i+zEXFbdL2hNdN1wQGjbWK7Q28JSdBoToFDPyJi
 Zb4NQaWFDGZX3tj4XXE1c+nuDvJ79+7826G5nsNv4xHnn16Ne37YKINOCOXI1Noj0en/y1sOW
 qZe9mTwEPeXpZg3YRjk9/Z9njM8=
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

Use the new MMU_INDEX() helper to specify the index of the CPUTLB which
should be used.  Additionally, in a follow-up patch this helper allows
then to optimize the tcg code generation.

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 target/sparc/cpu.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 98044572f2..0c84033326 100644
=2D-- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -659,16 +659,16 @@ hwaddr cpu_get_phys_page_nofault(CPUSPARCState *env,=
 target_ulong addr,

 /* MMU modes definitions */
 #if defined (TARGET_SPARC64)
-#define MMU_USER_IDX   0
-#define MMU_USER_SECONDARY_IDX   1
-#define MMU_KERNEL_IDX 2
-#define MMU_KERNEL_SECONDARY_IDX 3
-#define MMU_NUCLEUS_IDX 4
-#define MMU_PHYS_IDX   5
+#define MMU_USER_IDX            MMU_INDEX(0)
+#define MMU_USER_SECONDARY_IDX  MMU_INDEX(1)
+#define MMU_KERNEL_IDX          MMU_INDEX(2)
+#define MMU_KERNEL_SECONDARY_IDX MMU_INDEX(3)
+#define MMU_NUCLEUS_IDX         MMU_INDEX(4)
+#define MMU_PHYS_IDX            MMU_INDEX(5)
 #else
-#define MMU_USER_IDX   0
-#define MMU_KERNEL_IDX 1
-#define MMU_PHYS_IDX   2
+#define MMU_USER_IDX            MMU_INDEX(0)
+#define MMU_KERNEL_IDX          MMU_INDEX(1)
+#define MMU_PHYS_IDX            MMU_INDEX(2)
 #endif

 #if defined (TARGET_SPARC64)
@@ -701,7 +701,7 @@ static inline int cpu_mmu_index(CPUSPARCState *env, bo=
ol ifetch)
     if ((env->mmuregs[0] & MMU_E) =3D=3D 0) { /* MMU disabled */
         return MMU_PHYS_IDX;
     } else {
-        return env->psrs;
+        return MMU_INDEX(env->psrs);
     }
 #else
     /* IMMU or DMMU disabled.  */
=2D-
2.41.0


