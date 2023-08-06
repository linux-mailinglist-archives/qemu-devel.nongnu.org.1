Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B037714E7
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 14:19:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSchc-0000GQ-6A; Sun, 06 Aug 2023 08:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSchX-0000Dk-Ph
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:17:39 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSchT-0001mr-JR
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:17:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691324253; x=1691929053; i=deller@gmx.de;
 bh=hLqEpcC8Hd79MrgioRBBl6xIy1QwV0TCk6yDDh3U9zU=;
 h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
 b=Pdw6Ce/qIB6O+KpaUHnYMJ4zk8m20BF9UJ/CB1bYgfc3Pq8DL40PocCODQMg0eg33w8BXa2
 n/M9HCCCekgVaFCTK80tSHKoGKPNfKAStnPIhHo4OfPsdjP+Tdc2RNNjztHsjmlz1SlyQIFL/
 1xJwpSOOEt/6P3R5gcbg8ofkHNtmDZUrnxus+Cknq1jZ/gFPOVJr2+8N94C5IL7KSzDuapUuM
 bMIXDcAvB/OIhkAqrYgfj1v0rPTSFNy2Tgq3c9fJ7tB7oJUba7hLyYoeIvvB8c3Kag0I29Lpx
 wsc+dMt8eh5LQOguCVflw/gTvYafekNQOVXXjNaFx2WLAkbTjl4w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.152.250]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOzSu-1qCCGn32cu-00PKRA; Sun, 06
 Aug 2023 14:17:33 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 07/23] target/loongarch: Use MMU_INDEX() helper
Date: Sun,  6 Aug 2023 14:17:16 +0200
Message-ID: <20230806121732.91853-8-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230806121732.91853-1-deller@gmx.de>
References: <20230806121732.91853-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HK1s8NwL4fcqchpAumkek6Ph4QDNeI3MeOAuRYU85u0n3bRHFzH
 DSAAxz+6E/BZ7VhCidor5c/kZhKLxOJV3ne+MVIS/MDaJSYuBXMEWR+DL2sVTP9Dy4oVJKp
 Nn8S7RRILNDKHFmmt9+I/NJdYfUhxrEh0EJIU35xKYF1Jm5xVe5oEUB2wSgUdG+SN1wg5+E
 eWvMRIc2rFLlwEz6ATdvA==
UI-OutboundReport: notjunk:1;M01:P0:yKGE9iBGwMs=;5juDNxk+MjEJDZAiNrjnhnGyql2
 eU7Pls+ffBQZi6LI+Rw4HVAFQZU+qGjYhpGZaQuAgfcpn2zUbiCmkUxI9QPt+QSMC5VG7Name
 GRFWeel0lyQJnIxYrse4Mv/Sep/cDWBmr9nsBGr/57ZlX/YGJtwZmMcW/LopUtcb3V+b1woqL
 MbADqh97Hg5esoU2+WMONSsZoztEJvNh5M5sCI/DNPLLrta6IZFolF+y9QhNDiMppEXeMk8Ej
 clsMBxalV/ji0cDtookw0W1Po+ESRLYAvFI23SR8x5z/H6Uf8ehiX1EyaFZOaQatdfzI8n3nW
 wngGwUp5blQT6LZvuBYFb2s2gLRtzBKMyI6cc5Y0vn+F622A16rLmJZfL5mZlHK88WdIKaHvx
 jtMBJNi4FjDVCKGH92Fa4qtlNFgq2+Z5gzCmpIEUXhKkV4DJU2YkElNwlMhdI92nntptnBDgi
 AiJUQ6Rs/e2KfbZEM9xSq89iAqyP5bLM7waPu6n5RGyBfQ0kuGGIIGXLmTFwfl4mIVEOodcsU
 d32kXwoDemY2deUB8SyKB9hkLOuSsa0oivGCHBEkW4kKiBrzK3edYuhtoEPc4VSCiFGTWVKw3
 j1eyNE3kaPg9kizxqu5oHE4zqLn1YZQM4A+Bf5oW4RzkSFoui9ubgv9Xn9G/qMZnTAYWgsudD
 dHw18f34No97RqcSAhd+9cf4uaNsbxia26j+OQwrTQH/oWC1BbISQfGiqUwWc0Oj4FPgoc8RC
 iZsKqGfaQC3JVSZ6av46jaqfD9wPftgmjySZxbdf8tcrz218Z4FN+1cwuCnts8oHXDSIYHKvN
 gdxVCesKwcrt9l7kPBzknepWCc1sdeC8uHnOrsu20hj/w7FJLtpQJv2GvRTqV4upZZXQsf9mZ
 fTKJMGGXvp/vL285+CM1mdGp+fJQ514TYrNud4isc47XQQyiF9j2lvPRI0fZ2742RMun9OIIP
 E+6Y8CJJwZi1ALH8LjiClKa+iWs=
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


