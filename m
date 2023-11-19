Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4147F084F
	for <lists+qemu-devel@lfdr.de>; Sun, 19 Nov 2023 19:22:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4mQH-0005sN-4K; Sun, 19 Nov 2023 13:21:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r4mQE-0005oH-PR; Sun, 19 Nov 2023 13:21:30 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r4mQC-0008Ha-RT; Sun, 19 Nov 2023 13:21:30 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B137C3490D;
 Sun, 19 Nov 2023 21:21:27 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 139943624B;
 Sun, 19 Nov 2023 21:21:24 +0300 (MSK)
Received: (nullmailer pid 3314724 invoked by uid 1000);
 Sun, 19 Nov 2023 18:21:23 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.7 62/62] target/tricore: Rename tricore_feature
Date: Sun, 19 Nov 2023 21:21:22 +0300
Message-Id: <20231119182123.3314699-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.7-20231119212012@cover.tls.msk.ru>
References: <qemu-stable-7.2.7-20231119212012@cover.tls.msk.ru>
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20230721060605.76636-1-kbastian@mail.uni-paderborn.de>
(cherry picked from commit f8cfdd2038c1823301e6df753242e465b1dc8539)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: update context in target/tricore/cpu.c, target/tricore/op_helper.c, drop chunks in target/tricore/helper.c)

diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 2c54a2825f..0594d3843b 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -100,14 +100,14 @@ static void tricore_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
     /* Some features automatically imply others */
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
index 3b9c533a7c..2e122b44a7 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -269,7 +269,7 @@ enum tricore_features {
     TRICORE_FEATURE_161,
 };
 
-static inline int tricore_feature(CPUTriCoreState *env, int feature)
+static inline int tricore_has_feature(CPUTriCoreState *env, int feature)
 {
     return (env->features & (1ULL << feature)) != 0;
 }
diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
index 532ae6b74c..676529f754 100644
--- a/target/tricore/op_helper.c
+++ b/target/tricore/op_helper.c
@@ -2528,7 +2528,7 @@ void helper_ret(CPUTriCoreState *env)
     /* PCXI = new_PCXI; */
     env->PCXI = new_PCXI;
 
-    if (tricore_feature(env, TRICORE_FEATURE_13)) {
+    if (tricore_has_feature(env, TRICORE_FEATURE_13)) {
         /* PSW = new_PSW */
         psw_write(env, new_PSW);
     } else {
@@ -2639,7 +2639,7 @@ void helper_rfm(CPUTriCoreState *env)
     env->gpr_a[10] = cpu_ldl_data(env, env->DCX+8);
     env->gpr_a[11] = cpu_ldl_data(env, env->DCX+12);
 
-    if (tricore_feature(env, TRICORE_FEATURE_131)) {
+    if (tricore_has_feature(env, TRICORE_FEATURE_131)) {
         env->DBGTCR = 0;
     }
 }
-- 
2.39.2


