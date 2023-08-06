Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF837714B5
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 14:05:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qScQl-0001k1-1a; Sun, 06 Aug 2023 08:00:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qScQf-0001eG-Lj
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:00:16 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qScQY-0005dA-CQ
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:00:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691323203; x=1691928003; i=deller@gmx.de;
 bh=eVIz1+2aEWXCJiiL5CrCLKj6aw9XMfrjOXixWdeOVBo=;
 h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
 b=h6d7SXteTKBGbXV4f+uqIxcRfDK3v1wxBhU66cy83cec/OWSgo3sqOMMK70hFV0y0TbuA+V
 q2KLDB3FKmBjEl6vxpa6RhEnqeOFN+Y6hD+lDrzkm81sxfM63Ec/QHFoF4CSk/UF6NuNeKRKm
 s3lq1BhaExt90lb4quGNRRUCxXkXuVqVRD8XYR1NghIm6PhRjwjpVKjhm71JLzFZgqQ49KTW/
 SCo2oJB0OATMZhWmzqKI2CtGHcFdPvD9TD3I770uUDCVAzvV/FJvGkG4xiU0fGk7Cuz0fMdoZ
 y93VKWN6xItPcDrQIz0/R3z+eudPS3+GjlHllNijjubbt4OOAWfQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.152.250]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTAFb-1qFn362IXv-00UeKC; Sun, 06
 Aug 2023 14:00:03 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH 11/23] target/s390x: Use MMU_INDEX() helper
Date: Sun,  6 Aug 2023 13:59:49 +0200
Message-ID: <20230806120001.89130-12-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230806120001.89130-1-deller@gmx.de>
References: <20230806120001.89130-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/NGfQ8XWaXmM7tqWwcSa79kasB3J451fiJZHGzlMIQ3sm9e33vt
 2Q4Js7tOt3ZLYIa3GcyZEfojDEc3rzS2VgTcGgXyjxWWY8kmaL5W1xbBw9so5ePNgTxrJyo
 GmrOKNJ6/JtlyNp58C5Q/r7l5CTy3EaJ+9PMBhzRi3lwVzIr9KWSU4iIMRbEO4TjGBmCgxR
 Hh11hnNpt7Rsor7zKUq7Q==
UI-OutboundReport: notjunk:1;M01:P0:+ixASq/Uxmg=;8a8EqojkM128YDFE/UITTKNDqRW
 UheZfpu7+SDFPXcq/oqImnGHNdeX7yqdjf+mPSye1RvkW8FJVd7XY/DSC00X4b2nFnXGUEbyP
 yDDD6f9N7WJWyb3t2orxbvxWce07m/JlCOqPpDD59Ha4SHnbTf9DB3LnS5Cr2cfSocdLx6wpD
 U982dBu1Yi8L79zhpPzlKOr+vnSA5hfovoQ56wV/6gwGcoaK3GG0RefoSAJDit5+3ObngspWa
 HdQ/nkjzm6wZb8ehVi/kxRGYcaE2c7eW6zGzMs2ivdKWfGhQwuB/KHFhS32UCe7feRdFkO5M8
 zq6aOWzdjU+uXn2t6l3+//HroaivTEmMD6mVSS6YsnAhr0OpIhY6NWU2dGmLCuH5RWgxUU+6Y
 8qHah71Rjl95TI7L0z6x75TA1tM6giuv9HSDvEsqQCuCR9AO6vmbKzAowVqMRiZP33LkbVp8j
 Ix8Q6/huNEVDJDVIgYUsI7sxxVc8nu9wKB4L2VCOC7AyLnbJavOiLgGezMtvk1TSx0b4CWYT6
 muDcGp79TWQXzbsw8y98YiKHtpGX2RV7ZyybA0+NyZEvMgYk4yWYBUBh2j/nJeseA1K+dljfe
 7emDZiLaApleKDNMWHwo0r/86J4hu1PdQh0PUDNr65XuxRVozhWNPoYbt7JePgpUm1/Qbz2qJ
 GEKXMu6xOrJJ+xP/8YuUQQOh9L+rUc6FCUFQsMRnmt35L79V2kg/a6yUFO3VA98of4sTwvvcn
 Q71q+x7w2xf/0GTPid7MPBWr5Lq9TlwZjKcSQYUvaEjFDOCyqjPXbHqwWc+PJr1TfHlqIysUU
 KN5Zr59PJBgQmrcMHGNFE1794d+3fabW1s8Sb2+0Ki7M2914LJ7TT3LHy5V1n9XaL9hEj5vzZ
 G4W63/ppYP4wLkKPN6k3xObhXRNW1hiqk9J0ngsdfcRFj+LvNlxGffUJkHkAPk1V4pXclvQH6
 buXDw+Li3GpdA47WJ//rPvMYozk=
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
 target/s390x/cpu.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index eb5b65b7d3..05a4b7b299 100644
=2D-- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -38,7 +38,7 @@

 #define TARGET_INSN_START_EXTRA_WORDS 2

-#define MMU_USER_IDX 0
+#define MMU_USER_IDX MMU_INDEX(0)

 #define S390_MAX_CPUS 248

@@ -342,10 +342,10 @@ extern const VMStateDescription vmstate_s390_cpu;
 #define CR14_CHANNEL_REPORT_SC  0x0000000010000000ULL

 /* MMU */
-#define MMU_PRIMARY_IDX         0
-#define MMU_SECONDARY_IDX       1
-#define MMU_HOME_IDX            2
-#define MMU_REAL_IDX            3
+#define MMU_PRIMARY_IDX         MMU_INDEX(0)
+#define MMU_SECONDARY_IDX       MMU_INDEX(1)
+#define MMU_HOME_IDX            MMU_INDEX(2)
+#define MMU_REAL_IDX            MMU_INDEX(3)

 static inline int cpu_mmu_index(CPUS390XState *env, bool ifetch)
 {
=2D-
2.41.0


