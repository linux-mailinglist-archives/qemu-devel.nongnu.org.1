Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EA878AED2
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 13:28:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaaPY-0000Q5-Gy; Mon, 28 Aug 2023 07:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qaaP4-0008LY-Op
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 07:27:33 -0400
Received: from collins.uni-paderborn.de ([2001:638:502:c003::14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qaaOy-0002ic-GL
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 07:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DdCWk9fEnfEvoveJv22sa+aRQNZMmCe8sqfVKGONakc=; b=hNzqSzsZnnGuo6xo3IYYVzj7bk
 FZ0hmDpYI5DyYeWrGWvo+Iv9IkEG6UZdvVTqIcAQNfPXjomXfpS5lVxONF1BWDTQUGaWRFQUGz+GQ
 40xhJGhmINjaK+eC2zDMpWaxeJ27BZTWWN7qULgTF0uhwJ4wPpNL5HKDSsKFEFEHtBQs=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: anton.kochkov@proton.me, richard.henderson@linaro.org,
 kbastian@mail.uni-paderborn.de
Subject: [PATCH v2 11/11] target/tricore: Fix FTOUZ being ISA v1.3.1 up
Date: Mon, 28 Aug 2023 13:26:51 +0200
Message-ID: <20230828112651.522058-12-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828112651.522058-1-kbastian@mail.uni-paderborn.de>
References: <20230828112651.522058-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-spamd-action: no action
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.8.28.111817, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.8.20.602000
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/tricore/translate.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index cc2030be14..9770839749 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -6294,7 +6294,11 @@ static void decode_rr_divide(DisasContext *ctx)
         gen_helper_ftou(cpu_gpr_d[r3], cpu_env, cpu_gpr_d[r1]);
         break;
     case OPC2_32_RR_FTOUZ:
-        gen_helper_ftouz(cpu_gpr_d[r3], cpu_env, cpu_gpr_d[r1]);
+        if (has_feature(ctx, TRICORE_FEATURE_131)) {
+            gen_helper_ftouz(cpu_gpr_d[r3], cpu_env, cpu_gpr_d[r1]);
+        } else {
+            generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
+        }
         break;
     case OPC2_32_RR_UPDFL:
         gen_helper_updfl(cpu_env, cpu_gpr_d[r1]);
-- 
2.41.0


