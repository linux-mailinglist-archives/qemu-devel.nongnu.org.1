Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A67487714AE
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 14:02:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qScQm-0001lj-RP; Sun, 06 Aug 2023 08:00:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qScQd-0001as-T4
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:00:11 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qScQY-0005dJ-CT
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691323204; x=1691928004; i=deller@gmx.de;
 bh=dY+5pD/7yMidI4e6vPgNceRyHJY15FbDamoy1ip1+Fo=;
 h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
 b=g5IeORZVvc0NwS+cjX+FPZieftlO633vzsdwCevigu5jv0dN/SowQXj+7AVZR190KzuR3g7
 CNLVVQdSDNkYDsOsz1dJTvq/a3taquDcP+NLXX2awrdmB+4UcNLE+A+5PqGVqJ77Nr+Om+N5m
 s4D8Sylcl0yLY19Z4pTdh0D2QJdIgvGJX8J0IBJWKXFjZi5EhTFYzusyLA4vkX4dRWeNu0fXH
 6/h2m8X0LMgAFdGBkQwX1AvSDZQGTcHzdnnu3duHw/bD5hdhGxzEYGSVF2/pvXWPCe7zthkov
 cRUdNO8jv93JKYa6PrpUOvQTu5Jk7eerselrc+B1EkUDDSJlwVeQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.152.250]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvbBu-1pa6dB3Xgk-00sgY9; Sun, 06
 Aug 2023 14:00:03 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH 14/23] target/arm: Use MMU_INDEX() helper
Date: Sun,  6 Aug 2023 13:59:52 +0200
Message-ID: <20230806120001.89130-15-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230806120001.89130-1-deller@gmx.de>
References: <20230806120001.89130-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hfwSN9aXPfGJCMMATesmwWupFT/hDjzris0yWPoggr2NzV13swc
 oT5Nf5sLML3fGhyJvWwDY4/PBOpIuN/RgkW2WXZFkskJY25KnRrTOQvpXPpQAcEuf5Jb0jA
 STbPJoJZZjmB+I+6eZKO3ih3EbQxgi/RYHEc4Hfz/fsOXwbgkyWjtQrY7TuK5gfzAFjgaOo
 7/D73YWCaUhlYOgZmqlRg==
UI-OutboundReport: notjunk:1;M01:P0:Df0Y5LGg0iU=;D5guD7iv56YoHnSeCH18aYn4bSJ
 1zDMoEH780lxaUp4376l4b/PV8ec4H0PV+P9S3apaCrXPKp9QBLb5KZ8UsQvY1Ol59vTPZkPF
 zXHx/GNQfECo/CjpjnD0T/U+h31m6iNSVksHnftxmCRdDenjghlanuzukDhNZAQXwpiuVkVxP
 IHpJiduz2/5Shm8MGNIVQkRMNEswf513hNr5cn6x6HSR6IzyUXd2TcucPzX9Ez8lnNX8iFvs7
 uxFhtqGxiDiyidKo0At/1uYvN73Fk80vV9Sc3TFLZzxlhvjK8GaahlfKSAL25xTpYmcbvfxuj
 wmwfb6G520YQYELR2Nl7gFlVjm0aG+SRa38C3hfCg1YBW1e2CoWa6iPT0F6EuZaozeXhJzATh
 8TN+he2KPFGGixZjKWKgfP4tONHhab3T869Fk93bAVmp1vqf5CecyzEyjAqup5REUPzr41JuO
 6BpurkCwUHgr8gj8UHzuIry9w0uoTGfRXRST1ZUiZywSxwFYkj0fXyz51PMjwinu82WAsp0gL
 ZIS1UVfPjXLS30dVQaP3A+p5eGhQfqgHaukxE5sGJ5Xlx2JlHY7UVAUb2OkhzGfcpM623UteU
 5lwBDaMpBFaGphVE6nmDxzUoCFFh/JU1NKRxPquQdF4gdJsW8TrHBM/wsQIVPfe9WCxUFiz05
 wU2ZSvE5UMXd8PZk28amI5bzwQZ0+ObpaOUxWG/d4ex5D2MWWBTArNEAAyadsXOaILR+8iDcV
 uIpwTa0WuOSHrUJ6aip3vNDkbebNfZSgxoA2hFf60TU1bPlIaC0uTcNTeXDEIYmIwch2FZgZb
 wLXA6mZdl0eU08o3UHLd6uOOK5zIPAzfteo1aiOj7QP8++oz4r35KuZRx+fLg2mW7XoUJyX3P
 +HdRl5FqbtMGBT7xq7P/PYzlbVyFoCA32f5zUlQ6oVo8ymAtPq29Yb1BfE7g/aA12QCxmqKkA
 TFhBwNl0QhJ7VD8CY2n57hA0TNM=
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


