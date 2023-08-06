Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D547714B6
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 14:05:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qScQj-0001hZ-VH; Sun, 06 Aug 2023 08:00:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qScQd-0001ac-NB
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:00:11 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qScQY-0005d1-B5
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691323203; x=1691928003; i=deller@gmx.de;
 bh=hLqEpcC8Hd79MrgioRBBl6xIy1QwV0TCk6yDDh3U9zU=;
 h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
 b=LXiL4z5fbJDnbc5x6klw9T3bL4xe4PNX1kIotgOumyMHu0pqSq69/oNsbvoo06yCXyZdXfg
 rnuTx1FGPzJhRoYV7JNLhxAI65SQHc1OBCqINCMAa4p6jvHbwUCKA6vvt764MHu68L8WywZcH
 8v7YD7Kx0GlvysdK6VBHEl6LxXEyjW0ONtyYCWsTj5cJSnkv+wLpaRom86Ygm0FnN71Q3zihZ
 3+spmbgRaqVyY/ndVjdlh5uPlSB2MS0BoA6wC+POBBmcQ65ANin8YmGLqjCIXB4ubKyaJlFy4
 Ogs1P2n7ryVE7VYIOz0iN3MAD8kVmyksqEDf2Z/oHvqVteIDAbWw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.152.250]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVNB1-1qHzyG0dBX-00SST6; Sun, 06
 Aug 2023 14:00:03 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH 07/23] target/loongarch: Use MMU_INDEX() helper
Date: Sun,  6 Aug 2023 13:59:45 +0200
Message-ID: <20230806120001.89130-8-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230806120001.89130-1-deller@gmx.de>
References: <20230806120001.89130-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k7nqBYx2IZa9n0J50MleLnYB3B0NAVmapo2EFOYxCbgkI39+3qt
 qnzqEWVj86b2ZIsWwittVcpX6/ECrV15wk6+NyfAh1aAieuLBKGy0N0JE484vFmiIs/KZsk
 +ma1Ml/QyEBVCVptu5P/ewvSs9SJJYj70/JogZ7JcIT+mMalJxgoOvrxjbDca2ntE+6keqf
 Lva4MV9chu4VnRdSDfFxA==
UI-OutboundReport: notjunk:1;M01:P0:O0xrt8EYVWg=;kdslLitdnHNaYvkk/107lPAbXWf
 P9aBxI7prUR7wnLAYqG96S83AAarBKnoA2NJHQBQ8FqtTLO29BrCiFR9Gi+DCaVRk/qrmHa0Y
 N1QNaQrVhaaGF4+paVylBOdgCgF99b5SwHbgiS7O5R9dNFKLYfzS9yDqo5C6dY7qDwKmgKDSj
 ljnsGIpvynlHQkE4Wbzjv6YyjpkMDiL9laYnLBHfGZvo8WlUvjqu3h6fSTvZWts8EOYsg8UIx
 QQwTpXdTnD/bPIBz77HtGA4FYTpCWp0bL0xErpYvFZdfLE3HhymkV4CiTglPij8ATHtOHycEt
 k9E2DUAhhSK8S74RhvueZe85JuXeQO0Y6gJHiKdjN1LpEDxjKA1foYOl/sy/yUqUqhGfNWb/U
 Hd+mvzfjU6Onh+Bhy7ce9vBP6Lt5zmJgRVKMX+RppLKVehYNAR19nI63lpDRt8HA7TVb4LM0+
 N1hCI965SGwD6gq7zQnexQ0scsIZPNQAeiOIdNOGZXm0BAmZ4RnFykGLtzClQrze/PQhhzvyU
 UsEp5UJcnCFPHp2/Nq0OFNeb5Ic8QZw+M30iHM1ZCVxLTEmBY3NqYUwsEbCxrgp2AvgOnFbyF
 GuKesfJ3bn3sEyr3O183xr6SL51gnl7kII5Z6szSrTLRTd3TwFFnnPky8rnPkWtNxpXaJPozJ
 F+KRbHTaXChxrbqokMgOVC8GiPT8ZNOVxqkr+5gVHhuMrtkqVOquDva06gEHyp6FaY/5U67/w
 TPqy7e6GzZFpjVavzR8dE8dwKeIOTAdNZdRW+CXxDikF+2l87jKpemX52kZ7/o0HQ1xO7UrDf
 bvSqTqTMZ5Ure+DnN+1YMYnGvtvUqh30xA2Jsvp9ETY79UK0WBKDvPNRThjlHQgklBzXUcW5z
 jjemWm8eLr3v+klKTLFqBAX8LmkweiWrfHAxa6i8CUcMgg8ZrHUdWHrN1uL4OIjAuY/wnhGyh
 9CCN35S/sAlt+gqMPoJ3jm8hvvA=
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
 target/loongarch/cpu.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index fa371ca8ba..ab15146d77 100644
=2D-- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -404,9 +404,9 @@ struct LoongArchCPUClass {
  */
 #define MMU_PLV_KERNEL   0
 #define MMU_PLV_USER     3
-#define MMU_IDX_KERNEL   MMU_PLV_KERNEL
-#define MMU_IDX_USER     MMU_PLV_USER
-#define MMU_IDX_DA       4
+#define MMU_IDX_KERNEL   MMU_INDEX(MMU_PLV_KERNEL)
+#define MMU_IDX_USER     MMU_INDEX(MMU_PLV_USER)
+#define MMU_IDX_DA       MMU_INDEX(4)

 static inline int cpu_mmu_index(CPULoongArchState *env, bool ifetch)
 {
@@ -414,7 +414,7 @@ static inline int cpu_mmu_index(CPULoongArchState *env=
, bool ifetch)
     return MMU_IDX_USER;
 #else
     if (FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PG)) {
-        return FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PLV);
+        return MMU_INDEX(FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PLV));
     }
     return MMU_IDX_DA;
 #endif
=2D-
2.41.0


