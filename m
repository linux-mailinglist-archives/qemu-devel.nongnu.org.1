Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4F07714F5
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 14:20:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSchr-0000LE-Q5; Sun, 06 Aug 2023 08:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSchY-0000EF-6C
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:17:40 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSchU-0001n2-14
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:17:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691324254; x=1691929054; i=deller@gmx.de;
 bh=eVIz1+2aEWXCJiiL5CrCLKj6aw9XMfrjOXixWdeOVBo=;
 h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
 b=EqxU1da0q+YTCjMVngOWFZs3EKMahuCUITe220fIJfFEz4nygME+XrNpfAgUo5AJHKWR6cb
 rhcuH8JN+ssp9DScVKhjlwFKX7lioYjBjJnTNnPle1yU9mMmqYOlTkrtSq3cI9OO4GfjJOUM7
 C2c9jobBMgiKpliLmebM3d1nMlc+/OzIFiJv/YNRoZWoZVjbAo11WDJkRTKfh8/ScXFX6uFlH
 tI27387lso3qUx+wpy5HoZLMF+A77i4GmtFMnLV5tJrqX4htfJin07G3qu9WJ6FRZHcDEBsF+
 YL2Rw6DSv5d1+DUFQ72yHu9pMP/xsumteWBDfyUaON94hth3CZtw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.152.250]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7K3Y-1qTj9e0QVo-007naO; Sun, 06
 Aug 2023 14:17:34 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 11/23] target/s390x: Use MMU_INDEX() helper
Date: Sun,  6 Aug 2023 14:17:20 +0200
Message-ID: <20230806121732.91853-12-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230806121732.91853-1-deller@gmx.de>
References: <20230806121732.91853-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S+SRRbg+M3fPCYOB5lyoL86rs8JxtofsmXcsZm8zKhCZlDZIaMD
 9WqG63C8fj6NG9WZSs++jKe1LuefNH8xe/wausNgd74x0Av40qMtJf6nUW/479MNu6/QvLI
 0JrueShYMxU5xPID2MJy+0ZTr3bQ0E03ZJMB49XnYg0oVsC6UCoya8GAJR6YnVt1Z1z+TsN
 aKR8uAGSlElVn+rfc8Gxw==
UI-OutboundReport: notjunk:1;M01:P0:aJ8WKztcYIs=;6N+f4rBN6uiUowOPyyrmeTgaudl
 WrlvPZgU19WPSnIVRzMC79A/vFMYPWMJ6qvzsU7HOZIqbJIa0SeVErObp5ibTIC7BymNNi5Ll
 ZB2lmvfWBBhdgGrQW+r891cyaUlv0iLxpRgnBJ3YwiXiYGIaRgQTAgbpW0a9/pzqboRk44RRj
 rPXMkLQmQZsCJuUltg3og7/Uw3QZ12wXLue2OHeXr/2BQCYOJnnudgSoH0/hOlECIdYaXtODA
 b7HW55/WU46Io204rV4N2EiPnsXMJpIZN/T07GHdLIJaDIiDP5uaoF7YDdi6UFMCsOGGYKcfj
 kCaHMv6D692xP7yuyjv8pS4lHf9eYKjmVC7B/m62ZVwyUL2hrSHSoEo733VSCcd8ZOd1V2A28
 q1iuazIXCpgS84v4akD5JsniTLdZxGuacvM8mlFmNjb0Jy29gIQc95VwRydrwRN9Tf7M72XMb
 hWjzaYG1QiIWyUBf83VQQRijppQLcs2hxuip2gBP9IWjHJEwBoCO9C8t2xGHo5i3LhcGqCSw3
 IW/hCkdUlvP1oxJbBI2banirc9dnRksVPjMYQQDqdRxWYbAY18svPJxnM66xhB3G9kb7tEuHA
 LMyHKgc10WQvN8zhYeMz5/rk45loy5iMONdaLmt4+yhOwHXTwCkEpLMULkLvDnpNhPcUkL8CK
 oLK8YinuprDfUV3cmDRfNdPJW9LFmVEIIEHfqYn/N4A5hbuijoiKbdh7J1T74CvpSMVX9eryf
 iPECIehOOb5no03ErpsmT8Ae6wguudB4dmz3Cob60S+y3TEkx6uQV2fVcR9lNjdxA5F2rPpxK
 Il2iQ8dfWxDOEsuiOsAXg6ujkbkKK/IOOP6k06hZ9KQTXnmh1APHzUlVNfcAenucMdWaOoZh2
 fuZwDh1uz9XFIv93UQe9qfPaHXWZ34iFi71kMbPT4Gz/wnWMTfOcsCcWtkSENlI/1qAVW+5tc
 g+IcqFfqd6a2NLRmioIo+XClpVg=
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


