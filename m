Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5CF7B00A0
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 11:38:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlQyD-0000sI-Qj; Wed, 27 Sep 2023 05:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qlQy0-0000lo-27
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 05:36:25 -0400
Received: from collins.uni-paderborn.de ([2001:638:502:c003::14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qlQxt-0000h8-Ny
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 05:36:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XlhIZu2wG5GEm8bOpyij8zG6k/JHGKk+P3CD/Q1HBjc=; b=sajlN6OAz81uasqxk/zT6x5HlS
 Ik8zxHP4pAxvC0vKlIhz+LKhhgRYd/DlXku8nj4cdLp/2/nji5bjw4uiREzLX3NHz1l3bObdMu0cL
 JRD7L7xEOUwZSGi/qYZfI1HF8SH7l6+42nWZpOs2MjPvKzzx/N/UkTu3lIuDT/qK1mp0=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 05/21] target/tricore: Clarify special case for FTOUZ insn
Date: Wed, 27 Sep 2023 11:35:36 +0200
Message-ID: <20230927093552.493279-6-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230927093552.493279-1-kbastian@mail.uni-paderborn.de>
References: <20230927093552.493279-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-spamd-action: no action
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.9.27.92417, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.9.27.602000
X-Sophos-SenderHistory: ip=79.202.213.239, fs=9, da=183416438, mc=4, sc=0, hc=4,
 sp=0, fso=9, re=0, sd=0, hd=0
X-IMT-Source: Intern
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::14;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=collins.uni-paderborn.de
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

this is not something other ISAs do, so clarify it with a comment.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <20230828112651.522058-6-kbastian@mail.uni-paderborn.de>
---
 target/tricore/fpu_helper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/tricore/fpu_helper.c b/target/tricore/fpu_helper.c
index 3aefeb776e..d0c474c5f3 100644
--- a/target/tricore/fpu_helper.c
+++ b/target/tricore/fpu_helper.c
@@ -475,6 +475,11 @@ uint32_t helper_ftouz(CPUTriCoreState *env, uint32_t arg)
         if (float32_is_any_nan(f_arg)) {
             result = 0;
         }
+    /*
+     * we need to check arg < 0.0 before rounding as TriCore needs to raise
+     * float_flag_invalid as well. For instance, when we have a negative
+     * exponent and sign, softfloat would only raise float_flat_inexact.
+     */
     } else if (float32_lt_quiet(f_arg, 0, &env->fp_status)) {
         flags = float_flag_invalid;
         result = 0;
-- 
2.42.0


