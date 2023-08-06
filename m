Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE717714AD
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 14:02:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qScQn-0001mI-Km; Sun, 06 Aug 2023 08:00:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qScQd-0001ab-JM
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:00:11 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qScQY-0005ct-88
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691323203; x=1691928003; i=deller@gmx.de;
 bh=dvxkSS+9zJe2d6S5F16mDEZxjl4ybNfaIXuGtQs5GGw=;
 h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
 b=lqeRZBv2ca/JBcberjH6mxbUKMOo4+UAmoRVt1YMPNhplZ5OfraaUMmDa7F6BMvqudkkOPs
 TM6Bevqr0UIcSUvCyC6PBkZmiWClpo/bub6ao/NK70Zi3yXzdwivXDMzdf4bMNGWQDZZaVX/Y
 bqcBesRFURQs9ujUQodanfzHj3vTrggDjxFYLPR7O8FbyCUN2pYX3jlujDBVrBEQ7LTYIubvT
 vb+ZcB+4hnUNQ4YusDitZnSEhqKwHX5jz5ufHPrXTvjhaBKKI9X6KlVCBqO0IdRs+7bTE4Xm6
 iwt974aARJLOcgbZMx6AfFOyaQng7VE50lc/mzljRRRvbS7c/XQg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.152.250]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MrhQC-1q5RIt022m-00ngLP; Sun, 06
 Aug 2023 14:00:03 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH 06/23] target/hexagon: Use MMU_INDEX() helper
Date: Sun,  6 Aug 2023 13:59:44 +0200
Message-ID: <20230806120001.89130-7-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230806120001.89130-1-deller@gmx.de>
References: <20230806120001.89130-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OtH6DGDkCQQx7ZsnH/5NSd/dqCjDSz55Ukv7ewz8lqeeUyVV1OX
 ErhFHf+SskSUAkS9Mg5Tyy41aiYWgxweN8SHQh1ZS5t3TnCY2JL9aFuDaMab/XNeunNmjoW
 u53F1FpMp7QVy3ZY2d/UrCp7K73Q1UgAdf3NR6q0/9bvwwlYDqxxOBDiNBU1MAJoz4t4Nje
 HiR9Ft8t+mNSUwvIu5kFg==
UI-OutboundReport: notjunk:1;M01:P0:qMo+jKsJMwc=;rCfKfoU10FwduBduQycz+cFLotJ
 itnX1fCnV75nW8YUutZpryfDXe2ZXfM/1qiNQ7povnJ658I3zKO2Ex9nVaiQEyt7q4QQ1e4Gz
 V7YkWfrlnnpbg4Gtr0EbyewLSe3qYlH48Ks+SymOUaEdX4GrJ/D2R32mg62Dw50Oejtw2Utgl
 HMv570WFSk9kV3idBc3cUFENGp8k7ikqvF2PFZqTpcpMxSzksdJDYiGjwGKxfoIYEETuP3zPD
 N8sj6kJrQQiOOmQ/EY+TmHPP83K51hLSrKLsf5bZtW8XzNizVWLQR+6D2qav8aHPKRvMBIUD7
 hDZlyrQ1I+AJ4ZDe2TZyAt3274GfUAzo7Dk353+ZYVa8djmc8PlKm4WT5dIY3LdTEHTVR1hpf
 9OoDTbaAGfRbfpbsluK09q20OYrUYtON7BR9hJaUAGWWDqhkcJwRCdFmOn7mujv0ZhWMq4jMI
 mc0y6TzZmOG2RqTe5XV2wcgP1Jho3NC4fCDEvsY4V8dXIPg+oKRvIcQdTWC+UVaTaLju43X6W
 G/JJ9C3IokPK171BD2WSYbPa1ryeBw6CtaT8RhdrJoO5SsdAxlGs5IWJh8APqc5R54xGFqDDM
 ag+Cl7NAkPOa4mJn+DY93xgfcSCvtoqfZTzWUEYrM3PNhWjixnYbKtrUglb8HpfijoCz2wn8x
 62JLCT3McfpcdPthF+8nc45pluw+oSIay8N1bPZhFwZvSrapR33ef4hmPs4j3Z7g+oXsrNNSf
 rWZRac57pdQMEFG7+kHSyQY3kk6QvT1qGYSA714nM6W71i1L9AGmGAfVLW1JRcof2NyeSWvvt
 BQnnXJTKPCwUuyfNgwg57JTzZ07/HYzBZsF3zqYhzkw90eiynE1Etmvoax5O2c7cqYJnKgDws
 sQpB95mmOrlH8Dgw4zObLio8aR56/E7NQfl7Zkj33N7KDKgmKxO6thf8cr2fgx5KVLVuchw89
 7wMGnHPD9lR2YJRWsivy57ffcpw=
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
 target/hexagon/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index daef5c3f00..b4cf9f1a7d 100644
=2D-- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -51,7 +51,7 @@
 void hexagon_cpu_list(void);
 #define cpu_list hexagon_cpu_list

-#define MMU_USER_IDX 0
+#define MMU_USER_IDX MMU_INDEX(0)

 typedef struct {
     target_ulong va;
=2D-
2.41.0


