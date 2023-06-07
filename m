Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A007265D7
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 18:26:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6vyw-0001Pu-Es; Wed, 07 Jun 2023 12:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1q6vyi-0000ud-IR
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 12:25:47 -0400
Received: from collins.uni-paderborn.de ([2001:638:502:c003::14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1q6vyg-0007Ti-3F
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 12:25:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q7mG+k3nEGbZxzI9PSOokUQgY3uE84xUwSWJvkfJhJM=; b=o/cTwnUeSaHyRVexNWQuADb3a/
 USLLWu/9gO8EH4WaLpYTxBXSg65Ep+JJ92aE+HI91uovCo2lZFBhYbd6ND7rUX6g4rZFIG0N04wZo
 M2JTpcRoXG7mB/2P/RcrEOfrh6sil1FzuSNkyHmgJDTdupOcOh8CETftmj2ugeO8pcpU=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de
Subject: [PULL 5/6] target/tricore: Fix wrong PSW for call insns
Date: Wed,  7 Jun 2023 18:24:39 +0200
Message-Id: <20230607162440.7807-6-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230607162440.7807-1-kbastian@mail.uni-paderborn.de>
References: <20230607162440.7807-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.6.7.161517, AntiVirus-Engine: 6.0.0,
 AntiVirus-Data: 2023.6.6.600001
X-Sophos-SenderHistory: ip=79.202.219.6, fs=30, da=173764203, mc=10, sc=0,
 hc=10, sp=0, fso=30, re=0, sd=0, hd=0
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

we were copying PSW into a local variable, updated PSW.CDE in the local
and never wrote it back. So when we called save_context_upper() we were
using the non-local version of PSW which did not contain the updated
PSW.CDE.

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-Id: <20230526061946.54514-6-kbastian@mail.uni-paderborn.de>
---
 target/tricore/op_helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
index 6fd2cbe20f..54f54811d9 100644
--- a/target/tricore/op_helper.c
+++ b/target/tricore/op_helper.c
@@ -2447,6 +2447,8 @@ void helper_call(CPUTriCoreState *env, uint32_t next_pc)
     }
     /* PSW.CDE = 1;*/
     psw |= MASK_PSW_CDE;
+    psw_write(env, psw);
+
     /* tmp_FCX = FCX; */
     tmp_FCX = env->FCX;
     /* EA = {FCX.FCXS, 6'b0, FCX.FCXO, 6'b0}; */
-- 
2.40.1


