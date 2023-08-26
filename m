Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CD27897F2
	for <lists+qemu-devel@lfdr.de>; Sat, 26 Aug 2023 18:05:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZvkn-0006WU-ES; Sat, 26 Aug 2023 12:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qZvkk-0006VI-I5
 for qemu-devel@nongnu.org; Sat, 26 Aug 2023 12:03:10 -0400
Received: from collins.uni-paderborn.de ([2001:638:502:c003::14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qZvkh-0007rl-Q6
 for qemu-devel@nongnu.org; Sat, 26 Aug 2023 12:03:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qGo5GIKJyTWM+SKqkeeYOyVPopfEOeIwORuqgoQ20lM=; b=gezky12lOwKW8dFYoz7oppaaxS
 QnOJMXEHX/oC6rOOU7k4MGVIYKNuT619xHM529A5zIAd56TZjww//Z7pEgFu0QKVFT93Op+E88SPS
 zcxWoE0rHrRU5bt12UX9YkO1FNuthMz7rMvZaqhQP1Ggw39MM0kEGKmp3EUfQyxObwE4=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: anton.kochkov@proton.me,
	kbastian@mail.uni-paderborn.de
Subject: [PATCH 03/10] target/tricore: Correctly handle FPU RM from PSW
Date: Sat, 26 Aug 2023 18:02:35 +0200
Message-ID: <20230826160242.312052-4-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230826160242.312052-1-kbastian@mail.uni-paderborn.de>
References: <20230826160242.312052-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-spamd-action: no action
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.8.26.155417, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.8.26.602000
X-Sophos-SenderHistory: ip=84.184.52.128, fs=17108995, da=180674847, mc=11,
 sc=0, hc=11, sp=0, fso=17108995, re=0, sd=0, hd=0
X-IMT-Source: Intern
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::14;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=collins.uni-paderborn.de
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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

when we reconstructed PSW using psw_read(), we were trying to clear the
cached USB bits out of env->PSW. The mask was wrong and we would clear
PSW.RM as well.

when we write the PSW using psw_write() we update the rounding modes in
env->fp_status for softfloat. The order of bits used by TriCore is not
the one used by softfloat.

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/tricore/helper.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index 6d076ac36f..e615c3d6d4 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -120,7 +120,21 @@ void tricore_cpu_list(void)
 
 void fpu_set_state(CPUTriCoreState *env)
 {
-    set_float_rounding_mode(env->PSW & MASK_PSW_FPU_RM, &env->fp_status);
+    switch (extract32(env->PSW, 24, 2)) {
+    case 0:
+        set_float_rounding_mode(float_round_nearest_even, &env->fp_status);
+        break;
+    case 1:
+        set_float_rounding_mode(float_round_up, &env->fp_status);
+        break;
+    case 2:
+        set_float_rounding_mode(float_round_down, &env->fp_status);
+        break;
+    case 3:
+        set_float_rounding_mode(float_round_to_zero, &env->fp_status);
+        break;
+    }
+
     set_flush_inputs_to_zero(1, &env->fp_status);
     set_flush_to_zero(1, &env->fp_status);
     set_default_nan_mode(1, &env->fp_status);
@@ -129,7 +143,7 @@ void fpu_set_state(CPUTriCoreState *env)
 uint32_t psw_read(CPUTriCoreState *env)
 {
     /* clear all USB bits */
-    env->PSW &= 0x6ffffff;
+    env->PSW &= 0x7ffffff;
     /* now set them from the cache */
     env->PSW |= ((env->PSW_USB_C != 0) << 31);
     env->PSW |= ((env->PSW_USB_V   & (1 << 31))  >> 1);
-- 
2.41.0


