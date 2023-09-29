Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D427B2C84
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 08:43:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm7BG-0005kw-2F; Fri, 29 Sep 2023 02:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qm7Az-0005f0-Tr
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 02:40:39 -0400
Received: from hoth.uni-paderborn.de ([2001:638:502:c003::19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qm7Aq-0007OA-1A
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 02:40:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XlhIZu2wG5GEm8bOpyij8zG6k/JHGKk+P3CD/Q1HBjc=; b=p72Jrr1/q8qdyZfTZVZ36pqpoj
 0JXAEkhC3ZkeSHr+E569cm8p+7JLzjiY+qegOfmUrcrUfkjXhwb7rMnvBRU3YMq9Z9Sl7mjF8GHaP
 51esPrfX07kDpCrwFLReJnhJQl+vf/v0E9e1E5pJeisU3QggKTK8kq+0IsS2CCrGS2ak=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v3 05/16] target/tricore: Clarify special case for FTOUZ insn
Date: Fri, 29 Sep 2023 08:39:49 +0200
Message-ID: <20230929064000.536923-6-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230929064000.536923-1-kbastian@mail.uni-paderborn.de>
References: <20230929064000.536923-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-spamd-action: no action
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.9.29.63017, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.9.28.602002
X-Sophos-SenderHistory: ip=79.202.213.239, fs=162260, da=183578689, mc=50, sc=0,
 hc=50, sp=0, fso=162260, re=0, sd=0, hd=0
X-IMT-Source: Intern
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::19;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=hoth.uni-paderborn.de
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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


