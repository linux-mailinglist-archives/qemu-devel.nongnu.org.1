Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E34E7B009C
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 11:38:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlQyE-0000t4-0t; Wed, 27 Sep 2023 05:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qlQxx-0000lW-5E
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 05:36:23 -0400
Received: from nylar.uni-paderborn.de ([2001:638:502:c003::18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qlQxp-0000gl-7t
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 05:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0ZVKuipTJZZwnR/JF/GcM77eIVDauUJCXY9qIu7SUNg=; b=bC01ekzP3KytSGniIJ1jg4+XIA
 WZLLvL0pEF/wax83Zxd0phMEanQZE2N1tn2yQ8S9LJE0PBWOteHDyACJ7cjtlEf00InSILv/nAakU
 tt5iCCl+e7arcMC5RCbf3GdD/YJpD9++IlNfNg27KK0A2fM0NiaZHXNAxqKFAecG0lNk=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 03/21] target/tricore: Correctly handle FPU RM from PSW
Date: Wed, 27 Sep 2023 11:35:34 +0200
Message-ID: <20230927093552.493279-4-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230927093552.493279-1-kbastian@mail.uni-paderborn.de>
References: <20230927093552.493279-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-spamd-action: add header
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.9.27.93017, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.9.27.602000
X-Sophos-SenderHistory: ip=79.202.213.239, fs=5, da=183416434, mc=2, sc=0, hc=2,
 sp=0, fso=5, re=0, sd=0, hd=0
X-IMT-Source: Intern
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::18;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=nylar.uni-paderborn.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
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
Message-ID: <20230828112651.522058-4-kbastian@mail.uni-paderborn.de>
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
2.42.0


