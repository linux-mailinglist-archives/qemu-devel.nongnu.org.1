Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B627714A5
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 14:01:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qScQk-0001jl-Q2; Sun, 06 Aug 2023 08:00:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qScQe-0001dy-T5
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:00:16 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qScQY-0005d0-AC
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691323203; x=1691928003; i=deller@gmx.de;
 bh=vztxPNZg2Ks81IufpA0WxudElm6LqGuL9zpQKXSpcK0=;
 h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
 b=i64aboSH1wzDKW3gD9PG+e44eTehdENLgTIRQQLpXpNFuNKVq4KoO5COeQtOpRFvBlyhjPt
 0fErNey/IykCVk6aasOIRdYEzPBjOEY1Z/UwmUtNLrxQr1gv0UWit+mJgNlUK8Jp+iRUIkthG
 HMDlT1UHYJn3G5xc2b58qDFwImcFHH0OKvenCuu3OStoxKuGRvfjXM4ekZ4cxvngI9Dyn8/HN
 rKQrkuAkGRXC2Ujbl+cCQc+ihPlPFNqlzg/BzgF741CFCI8rWJMeBZvMj3viN20lFIdNbxhAA
 BPVlp4CsfUWbGB1DQNu3ZYmapi+G0pDlW9O5C8sjUT6h/WP0vhTA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.152.250]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3bX1-1pjl9E14aZ-010gky; Sun, 06
 Aug 2023 14:00:03 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH 08/23] target/mips: Use MMU_INDEX() helper
Date: Sun,  6 Aug 2023 13:59:46 +0200
Message-ID: <20230806120001.89130-9-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230806120001.89130-1-deller@gmx.de>
References: <20230806120001.89130-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/6mt+XHVRLBeA/rnu4hj70MLoVlYqz3Bflr3Th6/+HVRIotxlQH
 KAq5ZqLSJBPpHjzxeGunlku6bFCaiZTQicCTMILD0/A04tNxDx3n0jakUknLb27xa7/oRhj
 0m7d+oWwHzwK3/57ze6Omp681UpV9Zi8d1jPHZrZVKveSCpxd+HKVqw0/Ifwyu8wdm6EgFJ
 n2p4NsRQee3hnOfE/BR6w==
UI-OutboundReport: notjunk:1;M01:P0:hvIUkHbUJE8=;F4vaZa+WCc2sxdfL/izaDSdkGlr
 8Llf4sf+SIzSD3ZszRwHxaMdKXgc2+7XrzBMxqXct9NkaO8aD3jfOc7eGCUuBmrA1eVOeDd45
 DcLcr6Dvl3Md3pEdPFdoe8czu1pmEMfcpkOEEAw5RA6+6IRVgXG1ggQs5oZcvClt2hZoJVB1j
 B+zxU1kKCkCsQh275avh/di8smgjA16c59A9L+YwX7v8M2svRzpdtN5ADeP6Iky+JXx3YGqV7
 d7cwGQu9a+mgGTr5qPSgGvs8Y5LvvzWOJtrVZOrAw3MTr+4xRSq1H8oAMUQ2hcBG2DBkV1GG5
 EYaXP05UEiZFQp0xSB044cXzpBSEn427IgVW6K626KbrxHVp9Ar//Ky79HsXjCN8IErCK2XCF
 X+fbcSX/0AnJ+fR0sPo+7iudezbV88D6rwuG6a9JCDfnbyG/ngHapZ6J5GUjzCG00Z/NnCEyV
 gJevp6j7UffSYBmNG2MB7zwJm/57slpP8Fu/min7nwOinSBS2MPcbb5+ZMGCPR6LQBo22WRkt
 v3RDwJsDuuD0Tiyr1yfk3y+XEDSEeSPAuB0WVQ7FdujExfVafQ1IjmtBSYsemo1JcG6fgwcpw
 dwz6SiT0hlq0pqCQohILMhOIh9LgQdQHzKkAZJRJMfmrVTqVmisaa/x0Tf/tiFr+Ozg8IJgYR
 WpwoQ1JHXmfDY+yBHJcZEPSyZFSIFbmv8s/8ud0kD2cixHuqrizrQmUT+ZobIc6LznRvC2spp
 gdtT9azgZZZ2NUaeBNlZ5uPuq/xS/iI7NXKqAMb+ZM0REoqRv8w1O0lgQLo+FDn4t0bRozhtV
 v15QmeQkJETPZvVNUcNiAZKfbamdW8PMATRcRvSyn0gR2DSdVZ4GmqoteNaogZidBHNI3nC11
 bE6BNGWieryKP1bl3U+gVdEEhaF4zJlNKbh7pJ+pMIkgNcr0Ne+nqW4v5zslyG9PRyjUWHj6j
 0HeSADNUxrNAUlAZGjUmCCXS/v0=
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
 target/mips/cpu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index f81bd06f5e..4039d59f61 100644
=2D-- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1231,14 +1231,14 @@ extern uint32_t cpu_rddsp(uint32_t mask_num, CPUMI=
PSState *env);
  * MMU modes definitions. We carefully match the indices with our
  * hflags layout.
  */
-#define MMU_USER_IDX 2
+#define MMU_USER_IDX MMU_INDEX(2)

 static inline int hflags_mmu_index(uint32_t hflags)
 {
     if (hflags & MIPS_HFLAG_ERL) {
-        return 3; /* ERL */
+        return MMU_INDEX(3); /* ERL */
     } else {
-        return hflags & MIPS_HFLAG_KSU;
+        return MMU_INDEX(hflags & MIPS_HFLAG_KSU);
     }
 }

=2D-
2.41.0


