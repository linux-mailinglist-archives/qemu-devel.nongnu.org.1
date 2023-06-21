Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EE6738AB1
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 18:17:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC0Ud-0007C2-Fl; Wed, 21 Jun 2023 12:15:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qC0Ub-0006wT-1Y
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 12:15:37 -0400
Received: from hoth.uni-paderborn.de ([2001:638:502:c003::19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qC0UU-0007lD-AQ
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 12:15:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sCmBIbnZcvf/azNut5IpMQqfbyhxx76XfUeW5UPM8Rc=; b=e7gnd/4LymQ2gP+7XKE3BzoCqW
 6Ap6Ms5KgMZotoXYjahCDGOaI2hu7njquitYHL1QT26bgLUlL2pVkDQXsxOeT1kdb3Juy3eUQhw1i
 matG0nGfq0lK2tmARpQTzcMCi+hjLw0Lvd3S4VUCodehVOtCyorXFcMt0D2v+/euqi5M=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de
Subject: [PULL 10/20] target/tricore: Correctly fix saving PSW.CDE to CSA on
 call
Date: Wed, 21 Jun 2023 18:14:12 +0200
Message-Id: <20230621161422.1652151-11-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230621161422.1652151-1-kbastian@mail.uni-paderborn.de>
References: <20230621161422.1652151-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.6.21.160616, AntiVirus-Engine: 6.0.0,
 AntiVirus-Data: 2023.6.6.600001
X-Sophos-SenderHistory: ip=79.202.219.6, fs=1209015, da=174973188, mc=161, sc=0,
 hc=161, sp=0, fso=1209015, re=0, sd=0, hd=0
X-IMT-Source: Intern
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::19;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=hoth.uni-paderborn.de
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

we don't want to save PSW.CDC to the CSA, but PSW.CDE must be saved.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1699
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-Id: <20230612113245.56667-3-kbastian@mail.uni-paderborn.de>
---
 target/tricore/op_helper.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
index 026e15f3e0..9a7a26b171 100644
--- a/target/tricore/op_helper.c
+++ b/target/tricore/op_helper.c
@@ -2499,7 +2499,12 @@ void helper_call(CPUTriCoreState *env, uint32_t next_pc)
     }
     /* PSW.CDE = 1;*/
     psw |= MASK_PSW_CDE;
-    psw_write(env, psw);
+    /*
+     * we need to save PSW.CDE and not PSW.CDC into the CSAs. psw already
+     * contains the CDC from cdc_increment(), so we cannot call psw_write()
+     * here.
+     */
+    env->PSW |= MASK_PSW_CDE;
 
     /* tmp_FCX = FCX; */
     tmp_FCX = env->FCX;
-- 
2.40.1


