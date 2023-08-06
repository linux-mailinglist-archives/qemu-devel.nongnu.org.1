Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 224FE7714A3
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 14:00:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qScQk-0001j9-1q; Sun, 06 Aug 2023 08:00:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qScQc-0001aN-Q8
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:00:10 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qScQY-0005dF-9i
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:00:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691323203; x=1691928003; i=deller@gmx.de;
 bh=QJYh3cUm2UBmMLn1LmBThaRIWm8idLzbefeI9YOYT5w=;
 h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
 b=jQUmlLa9BEIqmdrtuelVrXaTQ8v29TC3iA4hv6lPOPdlBzMbMOeXK6caFmJDDmUh7wi1xBV
 9qAGpsVbxHLiDlmLRHJIobAJWjPNl3jU6EP5tVG5fvPKrtBSk1rAGLsyOoZKkP/3KVYNEJ20e
 N/F1GWx3ZPbxo3Z8t/daEte5kauWA8necCRDqlLrT2DiR1rN2ei9TQ09i5q7TXzDUhW7r1BG8
 hcm36KREUp0WkFLgIEB5KHaiZTtnkXx54/AVHzLYmDOGUoe6f+qCdyX4eV01qYE/5/VjtHJxu
 ivq9bwcmPXEoOG1VUtVzoGYK+zfAl6AuMjz2w2uqgT8UeHuAUdmA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.152.250]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Msq24-1pZXrv38a8-00tDiF; Sun, 06
 Aug 2023 14:00:03 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH 13/23] target/xtensa: Use MMU_INDEX() helper
Date: Sun,  6 Aug 2023 13:59:51 +0200
Message-ID: <20230806120001.89130-14-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230806120001.89130-1-deller@gmx.de>
References: <20230806120001.89130-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BzCdwywk91Q5Y62CtEqaHYBWanWweenkIZz+0FiKrb7eXzFcCCj
 TCl4S6BCeTHPGBp9i0FGpdTLgOJiJzQTzsy3tk45gN2xXHDcJ38UZ4Hyi4qEkIYrBRr6qVH
 pVdOARkuBKOHL/TDZkzSQ/fHTKTJeNuz/ck7XNgQLGXgk5TicTEdYJq5Z6aHhELmvvNm5/8
 DZsws6zWuQHe6XjYupHNA==
UI-OutboundReport: notjunk:1;M01:P0:Jii9YYQ1buY=;JD3zC7VLG4qRgHRwuP7vEiu4k8R
 7UcLuNwqSHQZ889xZNj4MNT5hR1gNIjwTBHILdwRUPS7fAlU7geiJc6aiS1bRbuPN3Je+gwjG
 z8YxmO9cnBwVYRkF0gQDtrruqQ9qw2+FggvLCngushXKHFvmRkdTcKu+BwWCVh3eSo773aWMc
 t8nhI+9SJ8tR+sK1shCwglhX7z3xswEMkmoV8mom6qKnrHKSokenWXqpsitp1i2jOgnWGpAea
 QRFpnp0KoSkzK82oOokUum7j+NAS8rywBQPJwrGBv55D8Dr+DuUOsZSiyoN+33p+tvIg4HUqz
 XE3Wh80Me2l0HojxQ0z/sPH9seCX1Ccq6WyOvSvG+HvcbAi34qaLFqHAejnX6snMbwa6w2qP7
 Q3UjtR0l26aFaQhEDxvxVhlcqSf1IufGqwRITHJYEWJ7Whgwzj/mWnCszZoBwxOAWr4pICC0V
 +JWFBdbrGRudYB15T18lBrAgP94ScXuXEgeRM0A5lDC9MnqA4PrscNUmPdQUcicHQDcDztNHj
 6jT19OHvzaFrO9OXzeJQduQKfKTMEuaFbOC1c3KRekZjVkYEYonMtXqDzUz05LPXsL3w9vA3S
 qO7tNmA+dTiUznYhaXdFXGX9sD/75mqoSjR2BfrHcptGnvO0aM/Qs5Gf2XTkjF8/W8qV5ZS+I
 rEw+n2qEXglgtPcYMRQX2gwylO6ETaFB+fvxrD5Gg5ymYJGKkhDC0ZfbW66FENHQOKL+hib1K
 yWwsMcrqZ7zzSpj33clw9cmH9ZV3OLWgoPH4a44W7lcYi0DrZQYd1mzmDXN25FComtWXcbeNH
 Z9NfQhcK9VMvVZ5UoRMeJgfFpxiHih7CAOkoUcY9ZGdm9SufK0nntwNQRPs/+59uhe4HeidO2
 zrGnkXOxJsBAQ/rJxW0pLqkFr1hKRKkQBeIlD/iq6rOrir4q/tw7aS5wKijdJF0czTjIq2zA9
 HGUDhlLFXVqzHd6vE3qRLktVVak=
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


