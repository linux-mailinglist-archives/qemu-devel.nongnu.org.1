Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B618D7714B1
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 14:02:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qScQq-0001qb-3A; Sun, 06 Aug 2023 08:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qScQg-0001eK-EN
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:00:16 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qScQZ-0005de-37
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691323204; x=1691928004; i=deller@gmx.de;
 bh=3j4/JtDPN66a0Jgkn0LY3i4AonLjxhCnzA3yeQjEfvM=;
 h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
 b=mUQiaCQHqFzcp4gQJzpKKD63gpFpAworEhazTF5/lwkhaUOXaSijIJdxJQGKemWHu7DAaV4
 yNsCAQQDkSnC8wr7ThUym1lvsZCyzzKsNOg/hUhlGNxVM67+9z5BCa0/G9Bd7Cd1NM47cSPTy
 Tq9zLp0LMbteVXahQULwZdaJWRDtDqwNzn82lZ6bmtYvT+ijxJqsPFMso6+erjMWkXG2uYH4m
 G9G30NsBbtRavgxDsiC/YRIAJx2IrKsBoESH868a/kP4nv+w7vp3oezMlD5W7BeNQ0iuhjGBv
 B+1Itii6xG91itpoK9RbrZKdwx2FUp6KgWitQCOiMWhiZyHHasRw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.152.250]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1Obb-1phYEB06Jv-012sc4; Sun, 06
 Aug 2023 14:00:04 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH 16/23] target/m68k: Use MMU_INDEX() helper
Date: Sun,  6 Aug 2023 13:59:54 +0200
Message-ID: <20230806120001.89130-17-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230806120001.89130-1-deller@gmx.de>
References: <20230806120001.89130-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ure0po7oEoivTpbyorsAU3uXPs7qQ+wips6/T9Vk4nHU1eCNunS
 T481lqF5G5LZi2UUkjfF2385FDqEUJwwDv9fMsdZhEQqjdYelcLfSqrThMQVVubu/uSnqce
 6up5HWKfYH5Cu9wFi/akKRSNMkl+kk9Zoq3FoxrJRvT6sTHbDIyUp9JtF6epcg/JDuMh724
 KanYmqPxdgchIR5KGM2WQ==
UI-OutboundReport: notjunk:1;M01:P0:9fEa5cKdTzI=;uULf3MJ0QKyIxm61mSIushwyBAJ
 Uf9eQqX+x18bqzuAnONkZu//0JyBUjGyu2yE9Gzo2GjM0CGWgBFO4O9RFpMPR0r/n3hasXTqe
 l2UYLTls5sRetnB9ABppb3rR9t+eqDv23IR7KuKp2IiyKhBO1L/a/Zqa8eR9tw4lRDK2dQa+R
 ccxhLUk6P7+njsyTIaHgi+UStYna+t+o7+zyXXTGmNPh2qC2nLhGIpPZab6mqhnslRTflxaSF
 pr2sw6BbWND6jb+w7e711vRjVKNTNAa1kagqqbrrsLFMc1n5sJrFcsHffBJ2jn0623JTouz3q
 VjZKForWN/oiltt+H7E3Pj2In7JOdnlj6OZbMBf7WmKYGxiLbqrcV/YzGVyy0jwsUQRVhX3lf
 5yhvAcjoneO/X4/OktEVFqiaB6pF48T9wyVWbL3SbxtoE8vQw8AOIvJFt1L81Jj7mUFv/r6ZW
 KvkY5hPluwhTNrkIw9nPnVY5Tpj/GoASGWcAU/jGgE3AJrz1aR4Xt44QHESN5r2GAgx5nkknA
 dwm6LuKbrXhbuqhc4wZ9g4WcQofmywubrZfqI4O/lZOvKIVv+mSyNluvAVgzcB0Jnm5yug4RN
 tFKWmcXZtuncwA7SDFYa7e0ylg4WgLGtCUdg+pHbX3iGyaUxs5kRmJH1eieuOq8mzGcGVGGAD
 9PJ28ltR4YE5kNeHLChe72N0u4qA/zf9hwXr8H2x5+wSRWoTAKLN8lkoiMR2t4AiDNyZkF54J
 oPpgXq2QQd07rSvtLlMy8TyjdfZ7PSbHn1SvB5VrzIFEYqo9yUSPLztVYKw4bscZpwn/Hv9vb
 ka2skN3E3CR83AR0Dky2J9h1X4b7p9uuYoXhBIBmABuZ3SHubMeOtOzaEL1pR0Iz7zBDo1mSx
 9WL3E4Dv8ENOp8g2GGrJv079Wk8Cd/kPr5E1p3fjalvkfukT1bM7NnMqj3kWtWZME+DZ2WpuN
 67fD8du7zQkmWpQ9xyOprqTGb7A=
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


