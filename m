Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 700007714A4
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 14:01:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qScQp-0001q6-48; Sun, 06 Aug 2023 08:00:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qScQg-0001eI-DW
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:00:16 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qScQY-0005d8-CC
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:00:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691323203; x=1691928003; i=deller@gmx.de;
 bh=wW8jWkcZw5zu6txqL6q+MBM+DZULGnKkQ9in2Fgeebg=;
 h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
 b=iXH9rZLHv5HN7oFUVGI2Kp4r7+3CxjitN04mitupgPvPDuOfTXXRVnTxSR9PmTuul9fWaIp
 3pYt+6XBDHZocwat/Pw0nV3zW0bAfW65F0FIut3EwuaKUXdr2WP8T/9L0QhiN+qA06O8VSjUR
 cevB3ejkh8OZWCGMnvdUqBC6oUtfurPHpjb7/ghQM2Eb+T2daFGHWWmnKvvYpDaYwnlPDpU/B
 yPxcnTjD6HJuKXZzB568ULO3QW1mXbrGXfc7ueCfxymsyBVWo8C4Iz7G+/C3gnjR60IWfSUKU
 ghId4Ii3kx9vFocZiA/E97w7dTCdm1T14yIScwRqIbiqQTPkbbwg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.152.250]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNKhm-1qCkEz2h7C-00Oou9; Sun, 06
 Aug 2023 14:00:03 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH 12/23] target/sparc: Use MMU_INDEX() helper
Date: Sun,  6 Aug 2023 13:59:50 +0200
Message-ID: <20230806120001.89130-13-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230806120001.89130-1-deller@gmx.de>
References: <20230806120001.89130-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wQ7jLaKEK4xYRLptIveYs9TL803M0bWHr4CPh0ARz14RuRga0AV
 R+yHBx46vI3H9po7zg/XA63KaSk2BbGpEEZrGoRsvtsa4rJtFQvQjs7htvQzJ8mLZ51DLmK
 D0q/l3t3bwqaF2wAZ5WQDXHmRDG6pgoNqzZQFTA6x5vt2vOIqtF8Ldcp3wYKZKnNkh0sCg7
 +3/hIuccOqM+fMmnWWOcg==
UI-OutboundReport: notjunk:1;M01:P0:Tr49OFnZ2+o=;9bK7mApL9UVCZn3b+ou+L33d8yq
 9S8jIccV3U+rpOHuSKqShF4/4NUyscT8hDCU20AbVhBpCVf9N4a3BNWOJYguTSQac3/By0GsG
 7bJ5G7r2nVoeu51DOALMKhCHv6fIsvM6BoZr7MlF2pgN6VagKdR90BwmcOPt6YPObw2ozMbdE
 gFKbURq4/NxYzixoRa/OY34y304egls0nOw65tuoBrUEQh6dzgbqli599U1WUqZUp/Znoncwx
 wlVDVLB5yniBzyhvK7IPQH3evfU9CKKSJpSibsKGMlPLSThMh35GDyq4iX2ZsUbjRdXqHwzXt
 RhE1GYcVjLqyXQIZqWQ0qnosRsN+shUfBsfP72BY/DLuq/WEMJZZl9BkRrkjdE4mNgnXkO1Uu
 5UDwXY2PnhoDEJX+Qm3ZOUNz773MP9UWnkU3SgqG96VIz+zvUMCkScPWlJD62dm+PtU9VHrLL
 6Ro8lF3rtPEzNPzhIiuoCYOqondDy+By/gbYMpf9C/5X3+gQjVwQiFOj3mHtyEJ6T0nTV+xAu
 0c7y3YlI1/6HtxUp1da5iFIxc99A2zdJWCBDz+7IEQ62orATBf7cLUk6NpSH1m97ZLnIGzKIL
 5HQPbfgpvDLxk4/z6MphjTRQnzLq5/o/prr0Ach0C05kjoHg7VnU1gvAWSk4XyhaejAZF4Tub
 90BI2H8O42RonJpvONRqxzac5PhDayBFX6Q2fIZTfTDZRIN9G8X46N9FKKkohLxp0axwnCo//
 /TiSuXEbCKNDqURUWPwZ8m+B6naZ/RF7pnzkhfa4b2elXym/QyLDCUugUV2aTy/NBXEsgGodv
 KBqZDcIYJrIzISR/pCak2OvtKb40JMpkO5iQu8wplJ1oR7IoBiRLqWf7STQKYycKTAM0U4mii
 +vIeTQnAwjzo/NVbBNQwS+U7gk+TdfLHu1nYOB9M72eZ2jby4NNnUWIKuaEDldARLLKVoUgQQ
 dp04JbbZrm9F/xM5CKAQWJMyYaE=
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
 target/sparc/cpu.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 98044572f2..0c84033326 100644
=2D-- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -659,16 +659,16 @@ hwaddr cpu_get_phys_page_nofault(CPUSPARCState *env,=
 target_ulong addr,

 /* MMU modes definitions */
 #if defined (TARGET_SPARC64)
-#define MMU_USER_IDX   0
-#define MMU_USER_SECONDARY_IDX   1
-#define MMU_KERNEL_IDX 2
-#define MMU_KERNEL_SECONDARY_IDX 3
-#define MMU_NUCLEUS_IDX 4
-#define MMU_PHYS_IDX   5
+#define MMU_USER_IDX            MMU_INDEX(0)
+#define MMU_USER_SECONDARY_IDX  MMU_INDEX(1)
+#define MMU_KERNEL_IDX          MMU_INDEX(2)
+#define MMU_KERNEL_SECONDARY_IDX MMU_INDEX(3)
+#define MMU_NUCLEUS_IDX         MMU_INDEX(4)
+#define MMU_PHYS_IDX            MMU_INDEX(5)
 #else
-#define MMU_USER_IDX   0
-#define MMU_KERNEL_IDX 1
-#define MMU_PHYS_IDX   2
+#define MMU_USER_IDX            MMU_INDEX(0)
+#define MMU_KERNEL_IDX          MMU_INDEX(1)
+#define MMU_PHYS_IDX            MMU_INDEX(2)
 #endif

 #if defined (TARGET_SPARC64)
@@ -701,7 +701,7 @@ static inline int cpu_mmu_index(CPUSPARCState *env, bo=
ol ifetch)
     if ((env->mmuregs[0] & MMU_E) =3D=3D 0) { /* MMU disabled */
         return MMU_PHYS_IDX;
     } else {
-        return env->psrs;
+        return MMU_INDEX(env->psrs);
     }
 #else
     /* IMMU or DMMU disabled.  */
=2D-
2.41.0


