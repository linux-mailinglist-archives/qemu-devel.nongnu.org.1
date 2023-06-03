Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBCA72115D
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 19:25:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5Uyf-0008RP-65; Sat, 03 Jun 2023 13:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q5Uyc-0008RC-Oz; Sat, 03 Jun 2023 13:23:42 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q5Uyb-00036a-40; Sat, 03 Jun 2023 13:23:42 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 87163A7E0;
 Sat,  3 Jun 2023 20:23:40 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 498D79377;
 Sat,  3 Jun 2023 20:23:39 +0300 (MSK)
Received: (nullmailer pid 19592 invoked by uid 1000);
 Sat, 03 Jun 2023 17:23:39 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH] linux-user: add comments for TARGET_NR_[gs]etgroups{,32}
Date: Sat,  3 Jun 2023 20:23:38 +0300
Message-Id: <20230603172338.19578-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
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

There are 2 paits of identical code (with different types)
for TARGET_NR_setgroups and TARGET_NR_setgroups32, and
for TARGET_NR_getgroups and TARGET_NR_getgroups32.  Add
comments stating this fact, so that further modifications
are done in two places.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
Please excuse me for double send, - I mistyped the qemu-devel@ address.

 linux-user/syscall.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 333e6b7026..a88493d51c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11472,7 +11472,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
     case TARGET_NR_setregid:
         return get_errno(setregid(low2highgid(arg1), low2highgid(arg2)));
     case TARGET_NR_getgroups:
-        {
+        { /* the same code as for TARGET_NR_getgroups32 */
             int gidsetsize = arg1;
             target_id *target_grouplist;
             g_autofree gid_t *grouplist = NULL;
@@ -11503,7 +11503,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
             return ret;
         }
     case TARGET_NR_setgroups:
-        {
+        { /* the same code as for TARGET_NR_setgroups32 */
             int gidsetsize = arg1;
             target_id *target_grouplist;
             g_autofree gid_t *grouplist = NULL;
@@ -11808,7 +11808,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_getgroups32
     case TARGET_NR_getgroups32:
-        {
+        { /* the same code as for TARGET_NR_getgroups */
             int gidsetsize = arg1;
             uint32_t *target_grouplist;
             g_autofree gid_t *grouplist = NULL;
@@ -11840,7 +11840,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_setgroups32
     case TARGET_NR_setgroups32:
-        {
+        { /* the same code as for TARGET_NR_setgroups */
             int gidsetsize = arg1;
             uint32_t *target_grouplist;
             g_autofree gid_t *grouplist = NULL;
-- 
2.39.2


