Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CACBC7B00A1
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 11:38:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlQyU-00011B-R3; Wed, 27 Sep 2023 05:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qlQyS-00010a-0E
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 05:36:52 -0400
Received: from nylar.uni-paderborn.de ([2001:638:502:c003::18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qlQyQ-0000ow-FR
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 05:36:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=edtXR816u45JZWfizGurdb1dDkx8u9mYVgXLFCS83yg=; b=MiUGUT22v3r7hqt1wlhHjoHI7I
 kwnGyHSyks1b9pWCX55lYUdE5RHzkReh7fQKOmA/u3ctD/IGRaIAVJBu5QGde6i9MhXUxridqVVNT
 43pZ6UMiP2jHVOdtt4ui7LtuBR99MZp2wYLPOBbCmzt/58Gv6AY9Qsly7pa13iaY9Jmg=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de
Subject: [PULL 21/21] target/tricore: Change effective address (ea) to
 target_ulong
Date: Wed, 27 Sep 2023 11:35:52 +0200
Message-ID: <20230927093552.493279-22-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230927093552.493279-1-kbastian@mail.uni-paderborn.de>
References: <20230927093552.493279-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-spamd-action: add header
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.9.27.93017, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.9.27.602000
X-Sophos-SenderHistory: ip=79.202.213.239, fs=44, da=183416473, mc=18, sc=0,
 hc=18, sp=0, fso=44, re=0, sd=0, hd=0
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

as this is an effective address and those cannot be signed,
it should not be a signed integer.

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <20230913105326.40832-11-kbastian@mail.uni-paderborn.de>
---
 target/tricore/op_helper.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
index 0cf8eb50bd..ba9c4444b3 100644
--- a/target/tricore/op_helper.c
+++ b/target/tricore/op_helper.c
@@ -2458,7 +2458,7 @@ static bool cdc_zero(target_ulong *psw)
     return count == 0;
 }
 
-static void save_context_upper(CPUTriCoreState *env, int ea)
+static void save_context_upper(CPUTriCoreState *env, target_ulong ea)
 {
     cpu_stl_data(env, ea, env->PCXI);
     cpu_stl_data(env, ea+4, psw_read(env));
@@ -2478,7 +2478,7 @@ static void save_context_upper(CPUTriCoreState *env, int ea)
     cpu_stl_data(env, ea+60, env->gpr_d[15]);
 }
 
-static void save_context_lower(CPUTriCoreState *env, int ea)
+static void save_context_lower(CPUTriCoreState *env, target_ulong ea)
 {
     cpu_stl_data(env, ea, env->PCXI);
     cpu_stl_data(env, ea+4, env->gpr_a[11]);
@@ -2498,7 +2498,7 @@ static void save_context_lower(CPUTriCoreState *env, int ea)
     cpu_stl_data(env, ea+60, env->gpr_d[7]);
 }
 
-static void restore_context_upper(CPUTriCoreState *env, int ea,
+static void restore_context_upper(CPUTriCoreState *env, target_ulong ea,
                                   target_ulong *new_PCXI, target_ulong *new_PSW)
 {
     *new_PCXI = cpu_ldl_data(env, ea);
@@ -2519,7 +2519,7 @@ static void restore_context_upper(CPUTriCoreState *env, int ea,
     env->gpr_d[15] = cpu_ldl_data(env, ea+60);
 }
 
-static void restore_context_lower(CPUTriCoreState *env, int ea,
+static void restore_context_lower(CPUTriCoreState *env, target_ulong ea,
                                   target_ulong *ra, target_ulong *pcxi)
 {
     *pcxi = cpu_ldl_data(env, ea);
@@ -2763,26 +2763,26 @@ void helper_rfm(CPUTriCoreState *env)
     }
 }
 
-void helper_ldlcx(CPUTriCoreState *env, uint32_t ea)
+void helper_ldlcx(CPUTriCoreState *env, target_ulong ea)
 {
     uint32_t dummy;
     /* insn doesn't load PCXI and RA */
     restore_context_lower(env, ea, &dummy, &dummy);
 }
 
-void helper_lducx(CPUTriCoreState *env, uint32_t ea)
+void helper_lducx(CPUTriCoreState *env, target_ulong ea)
 {
     uint32_t dummy;
     /* insn doesn't load PCXI and PSW */
     restore_context_upper(env, ea, &dummy, &dummy);
 }
 
-void helper_stlcx(CPUTriCoreState *env, uint32_t ea)
+void helper_stlcx(CPUTriCoreState *env, target_ulong ea)
 {
     save_context_lower(env, ea);
 }
 
-void helper_stucx(CPUTriCoreState *env, uint32_t ea)
+void helper_stucx(CPUTriCoreState *env, target_ulong ea)
 {
     save_context_upper(env, ea);
 }
-- 
2.42.0


