Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EDC7714E8
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 14:19:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSchp-0000KU-3Y; Sun, 06 Aug 2023 08:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSchZ-0000FL-79
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:17:41 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSchU-0001nJ-6D
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691324254; x=1691929054; i=deller@gmx.de;
 bh=dY+5pD/7yMidI4e6vPgNceRyHJY15FbDamoy1ip1+Fo=;
 h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
 b=DsCObQwPkWnZGrKQ9z1GGA/p/IQ2Z4LIsG5vavvIMz/4LJ1+vTdIetwNb3fc858kKJVAqZy
 YyYU142vTQFNEZf+w9fouhAJe09Y4BZsZnO6Y2lTLMkQdOvOxQKssrOkJ3QyI087fr5hcPGd7
 +r4M92KCJsXy+dHGfmxqEM98xrCfJ9jj406RHraGVjEKYcy0P+mpyFE9ARx7uP83EsgoGZPND
 CLkcTRcNtnlh4XH59pDPMrslWnY7Kj91Y2xojL+tZ/LKw+N5KSLcT6BaG9GultzdYNftvGDn9
 BK/vIIK27fHCuIB/z79HYJoWHNzhmnCyp48TLxpYC/urs46hIRpA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.152.250]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFKGP-1qdOCt1ghl-00FnoH; Sun, 06
 Aug 2023 14:17:34 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 14/23] target/arm: Use MMU_INDEX() helper
Date: Sun,  6 Aug 2023 14:17:23 +0200
Message-ID: <20230806121732.91853-15-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230806121732.91853-1-deller@gmx.de>
References: <20230806121732.91853-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:agufvB/f0aZvyiRihcTMXaxsyqRP5Y5BefXVZAB06VPNed4fGlr
 q5ta6/9cVzl86fC845SZTWJVJpxhXB/WBlMXcBv0j+CqgC02gicbkazgkg+vOLc+0bwunAd
 2HWOyyIKhw/9TFGcc0cRdFuHwqPBNlk57PCh04gQMLhdIQueXQbWbb1IC+zh3y6rGDM36N+
 USWcds1SvsW8ttZ3DumTQ==
UI-OutboundReport: notjunk:1;M01:P0:G0iP7dt+ezU=;ofdrzOXql+cy3Tj2wt+USV1jsAM
 1CTcHyaBPC9P4Gu+c34q4e7aVj0l3H/1hD7+SwZpiU91FAiKhJt7wPMMduI//2OI97jtB7Cot
 I2KT7OkWLE09Qlh8T8U0kiXgsWblZpZNImfMUNITDHl+LTZgSwBbkr1dRRFe0Dg5c7pP8f1bY
 HVrxevYTxlYx0f0nkUrAg6cmllXw1HbXHKSKJSf/D2bDj5YjEsV5WDBTYWWGXrwGI3+ljVo81
 Ek4BT9/zfEMTTi5T1LHTItal5VXD68bVh9JOYkC3q7vAZJxTmyiOdSwgX+4ZEILHYtQEByeh5
 KQa0Iy9/0+nrQiTSPNfcW0A4zLf5fsGacjZtfLYsmvdwc9oL6/Ob5zrDg0M78HLnHfwgiLC3l
 gpctsAoxP3VUFU0AmLTJCh8bYzOx8DLWhAQcSexzAfcNSN9ZnktpLCWQzQHL0jexMbVKhAjh6
 dMnvnYKPLRV15ohrstEXXCeBcWCxtxHwotKvbjZMKswGiwT6mLnjb4Rftc26bJo2uR0jpfanA
 EsIqBc3V3WV6x3x/r5sPqsq813k4ry9oAfx0uTQbq8boRPJpa2r9I79DUHqV4dnB8uJuu7fwC
 2uXPxt0UdKNgwirV5xjh7eetSK8atfOewKZug6HXFnsit08z8sQ0PM0bRbnHW4F78m06Zk0tS
 69MlIFwyVNkfJkaBniWpF3ZAazln7FP4Y1hkdv8n1mYt56L/s++XjU1vE9nheSLJc4EysulzY
 re4kC1e6qXv/zYs71t5PcgSGLqVmgGUGM7ZFeUAyDFe3C+lqGFcV4CglShLeCxe4pluwB7sgp
 s90DNOjGBaBfURUUz5IvevW2aAlY7H4lf6E+6tTriJdAir/jO+XubTvK66T+XCRBxLmF6R2Jp
 Fo56KCjJnOrD4iQPz1jrRpt+Bfh3RYVvkPPl4Vgna+ynFwC4cexi+SIMWR1NlQu8sHGD7AQ/h
 N5GnOw==
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
 target/arm/cpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 88e5accda6..16e18fb22a 100644
=2D-- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2930,7 +2930,7 @@ typedef enum ARMMMUIdxBit {

 #undef TO_CORE_BIT

-#define MMU_USER_IDX 0
+#define MMU_USER_IDX MMU_INDEX(0)

 /* Indexes used when registering address spaces with cpu_address_space_in=
it */
 typedef enum ARMASIdx {
@@ -3166,7 +3166,7 @@ FIELD(TBFLAG_A64, NAA, 30, 1)
  */
 static inline int cpu_mmu_index(CPUARMState *env, bool ifetch)
 {
-    return EX_TBFLAG_ANY(env->hflags, MMUIDX);
+    return MMU_INDEX(EX_TBFLAG_ANY(env->hflags, MMUIDX));
 }

 /**
=2D-
2.41.0


