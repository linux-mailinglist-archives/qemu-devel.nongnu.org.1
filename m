Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B0A761C59
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 16:57:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOJSH-0002le-DB; Tue, 25 Jul 2023 10:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOJS5-0002Q8-9W; Tue, 25 Jul 2023 10:55:53 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOJS2-0000D4-J2; Tue, 25 Jul 2023 10:55:52 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 16375161C4;
 Tue, 25 Jul 2023 17:55:38 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 91C611953F;
 Tue, 25 Jul 2023 17:55:35 +0300 (MSK)
Received: (nullmailer pid 3375815 invoked by uid 1000);
 Tue, 25 Jul 2023 14:55:34 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 6/8] target/tricore: Rename tricore_feature
Date: Tue, 25 Jul 2023 17:55:30 +0300
Message-Id: <8c0e8ed327c8ff7b48a5f2b7f5295c0541fcdbf4.1690294956.git.mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1690294956.git.mjt@tls.msk.ru>
References: <cover.1690294956.git.mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

this name is used by capstone and will lead to a build failure of QEMU,
when capstone is enabled. So we rename it to tricore_has_feature(), to
match has_feature() in translate.c.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1774
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
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
index 7587c2ffe8..6d076ac36f 100644
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
2.39.2


