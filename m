Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C015375BE48
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 08:08:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMjHz-0000uE-OU; Fri, 21 Jul 2023 02:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qMjHf-0000r4-53
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 02:06:36 -0400
Received: from doohan.uni-paderborn.de ([2001:638:502:c003::16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qMjHb-0001qf-0u
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 02:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pCe4B/hYv/UovrJxP9wBqCSvD5fU/xxHczDAWGGb74k=; b=Ud8zvWPdulQDV0fTf3esu9Yz64
 PJ6J6qRoZWJz+Gp05Hm+d5yOWZGxiMmSEh/M4NDhYdmk7vnvly/6rtcBUUChna2TmKhics3Z6uiSe
 JhwJHeDUk7CJFwoEGnX2uwMqm9I6C8esGnIa5ukD6L2YluxcNKaREeif7qjLPxA9Na7o=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: chenrui333@gmail.com,
	kbastian@mail.uni-paderborn.de
Subject: [PATCH] target/tricore: Rename tricore_feature
Date: Fri, 21 Jul 2023 08:06:05 +0200
Message-ID: <20230721060605.76636-1-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.7.21.55120, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.7.17.602000
X-IMT-Source: Intern
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::16;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=doohan.uni-paderborn.de
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

this name is used by capstone and will lead to a build failure of QEMU,
when capstone is enabled. So we rename it to tricore_has_feature(), to
match has_feature() in translate.c.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1774
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/tricore/cpu.c       | 8 ++++----
 target/tricore/cpu.h       | 2 +-
 target/tricore/helper.c    | 4 ++--
 target/tricore/op_helper.c | 4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index f15169bd1b..133a9ac70e 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -104,18 +104,18 @@ static void tricore_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
     /* Some features automatically imply others */
-    if (tricore_feature(env, TRICORE_FEATURE_162)) {
+    if (tricore_has_feature(env, TRICORE_FEATURE_162)) {
         set_feature(env, TRICORE_FEATURE_161);
     }
 
-    if (tricore_feature(env, TRICORE_FEATURE_161)) {
+    if (tricore_has_feature(env, TRICORE_FEATURE_161)) {
         set_feature(env, TRICORE_FEATURE_16);
     }
 
-    if (tricore_feature(env, TRICORE_FEATURE_16)) {
+    if (tricore_has_feature(env, TRICORE_FEATURE_16)) {
         set_feature(env, TRICORE_FEATURE_131);
     }
-    if (tricore_feature(env, TRICORE_FEATURE_131)) {
+    if (tricore_has_feature(env, TRICORE_FEATURE_131)) {
         set_feature(env, TRICORE_FEATURE_13);
     }
     cpu_reset(cs);
diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index a50b91cc36..3708405be8 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -277,7 +277,7 @@ enum tricore_features {
     TRICORE_FEATURE_162,
 };
 
-static inline int tricore_feature(CPUTriCoreState *env, int feature)
+static inline int tricore_has_feature(CPUTriCoreState *env, int feature)
 {
     return (env->features & (1ULL << feature)) != 0;
 }
diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index 951024d491..731a6e9cb6 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -155,7 +155,7 @@ void psw_write(CPUTriCoreState *env, uint32_t val)
 #define FIELD_GETTER_WITH_FEATURE(NAME, REG, FIELD, FEATURE)     \
 uint32_t NAME(CPUTriCoreState *env)                             \
 {                                                                \
-    if (tricore_feature(env, TRICORE_FEATURE_##FEATURE)) {       \
+    if (tricore_has_feature(env, TRICORE_FEATURE_##FEATURE)) {   \
         return FIELD_EX32(env->REG, REG, FIELD ## _ ## FEATURE); \
     }                                                            \
     return FIELD_EX32(env->REG, REG, FIELD ## _13);              \
@@ -170,7 +170,7 @@ uint32_t NAME(CPUTriCoreState *env)         \
 #define FIELD_SETTER_WITH_FEATURE(NAME, REG, FIELD, FEATURE)              \
 void NAME(CPUTriCoreState *env, uint32_t val)                            \
 {                                                                         \
-    if (tricore_feature(env, TRICORE_FEATURE_##FEATURE)) {                \
+    if (tricore_has_feature(env, TRICORE_FEATURE_##FEATURE)) {            \
         env->REG = FIELD_DP32(env->REG, REG, FIELD ## _ ## FEATURE, val); \
     }                                                                     \
     env->REG = FIELD_DP32(env->REG, REG, FIELD ## _13, val);              \
diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
index 821a4b67cb..89be1ed648 100644
--- a/target/tricore/op_helper.c
+++ b/target/tricore/op_helper.c
@@ -2584,7 +2584,7 @@ void helper_ret(CPUTriCoreState *env)
     /* PCXI = new_PCXI; */
     env->PCXI = new_PCXI;
 
-    if (tricore_feature(env, TRICORE_FEATURE_131)) {
+    if (tricore_has_feature(env, TRICORE_FEATURE_131)) {
         /* PSW = {new_PSW[31:26], PSW[25:24], new_PSW[23:0]}; */
         psw_write(env, (new_PSW & ~(0x3000000)) + (psw & (0x3000000)));
     } else { /* TRICORE_FEATURE_13 only */
@@ -2695,7 +2695,7 @@ void helper_rfm(CPUTriCoreState *env)
     env->gpr_a[10] = cpu_ldl_data(env, env->DCX+8);
     env->gpr_a[11] = cpu_ldl_data(env, env->DCX+12);
 
-    if (tricore_feature(env, TRICORE_FEATURE_131)) {
+    if (tricore_has_feature(env, TRICORE_FEATURE_131)) {
         env->DBGTCR = 0;
     }
 }
-- 
2.41.0


