Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9087714ED
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 14:19:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qScho-0000JK-0W; Sun, 06 Aug 2023 08:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSchZ-0000F1-1H
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:17:41 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSchU-0001nE-4A
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691324254; x=1691929054; i=deller@gmx.de;
 bh=QJYh3cUm2UBmMLn1LmBThaRIWm8idLzbefeI9YOYT5w=;
 h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
 b=i55H1WGoU0JcbK9Z2s49z80b/sb6vYbS/cufCiI31GFLm2p5RYW+GjehsSQ4T5+cLUF0lYU
 OTX4IlxI9sTFTVoISb6YERsiEHkDRuS0BetApHVRmO+R6IkrPW2Yji88ORMwCTdBJLQmZk8v4
 F8YPDo7UepZvbLRiVPG7mUwequZ2wR94mLh8fbbjRbjqmun2F9mUFCetpLAFK5dp/cLhkF6HE
 mntEzzs0QJoGGeIRAMdmxqCfuu/3DogD+EIX1PdeBooabyM14F9Oj9c6Tk3etscGAWog2mYpr
 L1Mwuep4LCJ+j906m5Cnz7ReHvsNt/nW7+lIK6Tr3N9AVhpD9lyA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.152.250]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Md6Mt-1psSbN1H5H-00aENP; Sun, 06
 Aug 2023 14:17:34 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 13/23] target/xtensa: Use MMU_INDEX() helper
Date: Sun,  6 Aug 2023 14:17:22 +0200
Message-ID: <20230806121732.91853-14-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230806121732.91853-1-deller@gmx.de>
References: <20230806121732.91853-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C0WZdAEwNAas7AHHV9LBIewK1nZRK41G3RKBb7P7sMe8U8IsGmp
 wNk7YqzKnOIMfxWcl6U+qChQ+PW31P10YpxnaMq/n3aWoQG7GCNCCbt5e3MIBbzPCf613vR
 JI7Lvn4fygTDecLC8Xv8PzNPxOH92CxjYFa5hNhYfXsPZDMfAhqeQK2DSo0wiv00cDmbHd8
 wQ4aY1jRVGZLKh/mZO37Q==
UI-OutboundReport: notjunk:1;M01:P0:t6UCxJLXn88=;9qQzChh0zC1kxVdpCI9nEiD6XgA
 sCZB9PCKZu1EvsYP54mBD3UWrfhi6w2oZ2U+0lsnXV84dlii87x0g4QMSKqOP5GfTl+/9Z9Z0
 1xQo1QPqgPILbTeIspzH/LMBRJqMskcHbPcJjXu+Q3Kmn9kP+yUpqp4vY5kFabzubVAyLBWyD
 Vcq4lyBe80g/3eotO+pxwGhJh6Z1nLSLXwQhQd5AGznzP8mYaG75bBqemHi6D9H8lWrsXk1U4
 bBpL0tPmF4WQsFPBX0h7g8kwobxRCCH9tXCnVQ6ne8i7xh1rBaCUUribpEqyTuScqruxfl6fQ
 ty8hjBRm5Kcty53eSTrPOAKDnDDut/COpUUc/UdddqHprGCyrZOe+GMoSkYgpC3LmqAf/k66o
 M15Ea02ewURjaA3t7UcSbDqRgEWvhd4818HJROiC3WC+izj9ERcm0qEll2J8FVzhNdkb//N1N
 NNJ+xgJ8DWlMZo7nln0IH2nOkA08Mg0DBaCdp11oCPVZg+gmeB7lh0Bw5+USQnJCwhhT46PkS
 et/TVIlpWgzktarAevFKtiQK54o4TvrBvYh/XRIn12MFpMHn3673GnaLramSvKPgiaSDh82CW
 4x4mPj9tpgr/7eht9qiLiqGbtuoEYcWbI8FSXTOGOGz8L7M48cb4umjWzUg1JuRb42Si9XxUv
 eSb4l7baFcbWlRjlTmRgMDuqaYPMPoMLpuHeTAiT0DtKUjB7M/Xfcp9IQryLzpNBCsEudyUKq
 eUeaO6i4Hn7kuQGZpLGsH4CFkf6Kx/ZxxAw1ElJD5FmluG23eJlVhvQ6z2cvegfl52YvhGHp8
 bu3IUnT4a7CuAxP2kyyjMohexsvDYXhuBBt6vJmAKTDzrKwfbh8R3G/BrYuRuVTHv6RQAjRgj
 5o+Tq+lfBVxy27dfvid6ufyqtNJxzEBa8zoVGSBn0u2B6ulA7UeFb0jwoPWsAQDrwNXdKIkUa
 StH6iHLoDDImrqgchvHUiDfI0ug=
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
 target/xtensa/cpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 87fe992ba6..2f1349b13d 100644
=2D-- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -699,11 +699,11 @@ static inline uint32_t xtensa_replicate_windowstart(=
CPUXtensaState *env)
 }

 /* MMU modes definitions */
-#define MMU_USER_IDX 3
+#define MMU_USER_IDX MMU_INDEX(3)

 static inline int cpu_mmu_index(CPUXtensaState *env, bool ifetch)
 {
-    return xtensa_get_cring(env);
+    return MMU_INDEX(xtensa_get_cring(env));
 }

 #define XTENSA_TBFLAG_RING_MASK 0x3
=2D-
2.41.0


