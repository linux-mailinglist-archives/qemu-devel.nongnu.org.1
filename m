Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 331187714E2
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 14:18:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSchq-0000Kf-Bk; Sun, 06 Aug 2023 08:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qScha-0000GP-Cy
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:17:42 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSchV-0001np-0j
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691324255; x=1691929055; i=deller@gmx.de;
 bh=AAhlFKdhCBg0rP4mi0eaKNbjFV2RubxTJe69zIRETsY=;
 h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
 b=Y60zsxV/eYXX1nZSe4YLNRcM3ps/Re+rKdxgkBpRM6q5GF0LghnTdPvqeGa3MGBCE2exaTg
 6cyk1e0QE1W8TH+9clpoh/goPLoPKebl3LKFveXqjFWYwvlWd5dq1ZqnTrd7Kh30ClVUOLFAH
 CvWBDqreFJt063ONSaVQEgJxl88hD8y8x+3Z3GcxKgW42YpbfDDwTy2HAFSlBO4DDSSiwTzx0
 HAr31+/OBUktrMyCe81/n2C+9NcB2rsBesCpXW9Gidz/zFQw08PDJ2W2o8gJF7wfqJN5laqmr
 vYXAszSJeOoxbsO1QSU7vZ0xjQoiAos8RUBoPbB/y/+fW56KxUhg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.152.250]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2wGs-1qPJJL0K7A-003ON4; Sun, 06
 Aug 2023 14:17:35 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 18/23] target/m68k: Use MMU_INDEX() helper
Date: Sun,  6 Aug 2023 14:17:27 +0200
Message-ID: <20230806121732.91853-19-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230806121732.91853-1-deller@gmx.de>
References: <20230806121732.91853-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UYtI86l/OKWY+VJvOdSExYClxOIAYfpE9h/9ZODyjFQcxKLejT/
 DNHJrOCtkS+LkXe5wzZU+7sgK4mz6iGQGroeys9zuzL7P6TFaLG1ucJo9JseGusgizlne/x
 6tfWpdHfAGuuZZk46R8lSFxRBl0vu66YgzYIf9Qc/oXgnpicoQ5W584sSSNWBTkf/HMvQX4
 pAjznAb+csuWMDKJJqvVA==
UI-OutboundReport: notjunk:1;M01:P0:E2YHYvHZrLw=;TzIjTGvhHY5mdMn2ay4rOrxWeRP
 5jE652rmfCTHyv0pOApw0wcj3D/MqKNsu4Jrvh4pqefzA0dlI/gc4ZnH53Vqz8PaRYeiZnpCT
 l/iXpEniGyS7rvpxz2SY2Jpvyu6mxUwsC/ARoj4EX1w+U/+j2dDTLRW04GSWwfRHGKlacZKrs
 xoqBsJi0o0Uv9TXaG86s5eOis1CrbFGKWFmCtCMF4CNY2XAtIbvLIW0Q47Wah2lfKpIpvs9Zp
 1CvRKvNGHuD009FgyMQnX5vr1NLGhIigWMQGAJMsWitZEdEr7n3ZPqfXHCK//i7Q2KKENY0SV
 lwZ9A/LghbrkbKx0FVqkvPGZcTjy4MeDBCXuSW/FdMXENwklNA4H8qZdG+W7fWLBz7O3Xz3/g
 6YfdBUm36alKLTDZTQlori6MBDxB+msrsHyk23CtQ8sZK3wEYfpLNK/Y2ya+jnrlu5dffJY7R
 KUzXp1K5YQ4vhqleJ/HLDKXcbfFqb8jrR4mRyUF2iBGOVDq6XMyly5BE+ZhE9OmKv0KGoV43f
 Y1Mxl6TOy+1SPAsYXLq9HGTCy2tiVTObJ/wBbtbcjcHmZ5zFLEVPYafYx9o8OJ6Pvqa85Tp4O
 cIW5axAJwQSugn6581KMZJ664NLiCID/ELtf7r5Al1Q479SdUWozmVwgqGb7NjFpL5IEBWux9
 StCvlKB2xuE7QKFtoL+wIgTmRSv+pRb/iQNUgnlKjNdkYm1P6X4QcO0IY9Ac3QP+c1/iLkJ3J
 3UhF3mC4bLmiqGivJ5AwEpk3IJ7jbSPuFTlGwLA9XfPFrJlxgGjabL3q2UkukbBxsoUb1dvMy
 jBkOj8lnwEKnGkKKvCs2K23vac3jBcCl+O/oURMfMoPEsO74CWeDqEtzxIbQk3pSILGr+oke9
 23wCh3n+o5OcSkR3FAfNznkTUCDHo2pdfMbICf2PBIDtqZ3JSduibVihwLesRaBZaOzJt1O2N
 61GkLVaWPscosX/fAp4FBQwe2i0=
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
 target/nios2/cpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index 477a3161fd..77f9e3803e 100644
=2D-- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -277,8 +277,8 @@ void do_nios2_semihosting(CPUNios2State *env);
 #define CPU_SAVE_VERSION 1

 /* MMU modes definitions */
-#define MMU_SUPERVISOR_IDX  0
-#define MMU_USER_IDX        1
+#define MMU_SUPERVISOR_IDX  MMU_INDEX(0)
+#define MMU_USER_IDX        MMU_INDEX(1)

 static inline int cpu_mmu_index(CPUNios2State *env, bool ifetch)
 {
=2D-
2.41.0


