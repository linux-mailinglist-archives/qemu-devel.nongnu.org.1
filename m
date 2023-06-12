Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FC272C2DB
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 13:34:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8foI-0000lf-GC; Mon, 12 Jun 2023 07:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1q8foG-0000hG-1z
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 07:34:08 -0400
Received: from zuban.uni-paderborn.de ([2001:638:502:c003::17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1q8foE-0006sV-46
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 07:34:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YVftmQToCRNb71WxrBVkNdgWzdYO7ofSPJ6DpBau990=; b=Ur00b7BAl5ufe9JjX+OAk7ikou
 feHQMTdziJUcDSBFrSVUSWMSMQmb86WCLkylHGA8fYUhNA3t3fPAvMhls2p5sk2cru5IA1J2/2V7m
 MJGKrWR1xNEbDxODORZPv3wMO/Rwy/VNIfJTW+nZL3AGl9RZ5XjaUDcUXPg9hJEaS5LY=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de
Subject: [PATCH 4/4] target/tricore: Fix helper_ret() not correctly restoring
 PSW
Date: Mon, 12 Jun 2023 13:32:45 +0200
Message-Id: <20230612113245.56667-5-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612113245.56667-1-kbastian@mail.uni-paderborn.de>
References: <20230612113245.56667-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.6.12.112120, AntiVirus-Engine: 6.0.0,
 AntiVirus-Data: 2023.6.6.600001
X-Sophos-SenderHistory: ip=79.202.219.6, fs=414533, da=174178706, mc=51, sc=0,
 hc=51, sp=0, fso=414533, re=0, sd=0, hd=0
X-IMT-Source: Intern
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::17;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=zuban.uni-paderborn.de
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

We are always taking the TRICORE_FEATURE_13 branch as every CPU has TRICORE_FEATURE_13.
For CPUs with ISA > 1.3 we have to take the else branch.

We fix this by inverting the condition. We check for
TRICORE_FEATURE_131, which every CPU except TRICORE_FEATURE_13 CPUs
have.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1700
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/tricore/op_helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
index d3c836ecd9..cbc46b2a5f 100644
--- a/target/tricore/op_helper.c
+++ b/target/tricore/op_helper.c
@@ -2532,12 +2532,12 @@ void helper_ret(CPUTriCoreState *env)
     /* PCXI = new_PCXI; */
     env->PCXI = new_PCXI;
 
-    if (tricore_feature(env, TRICORE_FEATURE_13)) {
-        /* PSW = new_PSW */
-        psw_write(env, new_PSW);
-    } else {
+    if (tricore_feature(env, TRICORE_FEATURE_131)) {
         /* PSW = {new_PSW[31:26], PSW[25:24], new_PSW[23:0]}; */
         psw_write(env, (new_PSW & ~(0x3000000)) + (psw & (0x3000000)));
+    } else { /* TRICORE_FEATURE_13 only */
+        /* PSW = new_PSW */
+        psw_write(env, new_PSW);
     }
 }
 
-- 
2.40.1


