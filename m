Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC58E78AEDB
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 13:29:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaaPV-000053-8z; Mon, 28 Aug 2023 07:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qaaOm-0008CK-Tk
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 07:27:12 -0400
Received: from collins.uni-paderborn.de ([2001:638:502:c003::14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qaaOh-0002f4-32
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 07:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8UyuZVOXHv9lYjVEO5vJ8sDCu43Yt9vnNDzuHygTdDg=; b=hvsX7giXGMgfpsOl+w4r8lq+a2
 s1hUW6z7Q9/KfTF9W45ejm05a1ochWVPldpSdfstuwewUHM/CN6b8qxcnOH2Sphrd5P59Qvn2VUEv
 Wl4hS6A/W0LXqLq2pyJnZDqekeZsjC827/+rnmgSCbIIXGB94qplcswbO0UXuFCkmP7k=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: anton.kochkov@proton.me, richard.henderson@linaro.org,
 kbastian@mail.uni-paderborn.de
Subject: [PATCH v2 03/11] target/tricore: Correctly handle FPU RM from PSW
Date: Mon, 28 Aug 2023 13:26:43 +0200
Message-ID: <20230828112651.522058-4-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828112651.522058-1-kbastian@mail.uni-paderborn.de>
References: <20230828112651.522058-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-spamd-action: no action
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.8.28.111517, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.8.20.602000
X-Sophos-SenderHistory: ip=84.184.52.128, fs=17265237, da=180831089, mc=26,
 sc=0, hc=26, sp=0, fso=17265237, re=0, sd=0, hd=0
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


