Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE8A7ADB07
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 17:11:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qknEe-0008Vo-VI; Mon, 25 Sep 2023 11:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qknEN-0008EM-78
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 11:10:40 -0400
Received: from mout.kundenserver.de ([212.227.126.135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qknEK-0005LK-PT
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 11:10:38 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MrhDg-1rPL6j03Ay-00ngzd; Mon, 25
 Sep 2023 17:10:33 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 5/5] linux-user/syscall.c: clean up local variable shadowing
 in xattr syscalls
Date: Mon, 25 Sep 2023 17:10:29 +0200
Message-ID: <20230925151029.461358-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230925151029.461358-1-laurent@vivier.eu>
References: <20230925151029.461358-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:MeBvzcuRUut/buWI4k9XUOj5/7wB04NFKeVVJcc28GoEL/8JGH7
 f7CbFXXJCa1NN8/SeJu0UCOT6Q/1zEu+BZFk6PHwu30GiLEey2Z1B6EWBbVPHybVjm42AEw
 T70NylaldAHhEzI6MYSLk7jNixtgzVDu0ixJCi2+1mfOrak0aJsHWfjFznezlJleBt8QzxI
 axg5Q7Hr4dKoDESARzenQ==
UI-OutboundReport: notjunk:1;M01:P0:dIIA/VoiAXk=;V6hQuhSHhDMwzhtUtsjyeKStpap
 +Xje+ocLntqCWBd51UHQVmQ8xvX+WvB2wDp0q4Wu1Ug/fjECwCevScHCP4VsPvQ4hyeJ/YYXX
 BmcovOSPOdIS6hxC3KsCBEp7/YOVwrFHk6gEczdS9K0kMhMILsFf7Xk7nzEB53uhEmxH1VLeM
 DJ3Ee4zL/xyeujVAzDz4l+LRQwjEpm2D3kTn4nEMX1khIFenWx0IIfpTeQpaV166AxKUw9eR3
 58yiR9JLcg6jPciEali5+3eADSUSkTjyVG1dgR1YR5IWxkpwwoSh7Ped7UYI47164Z5udX+ue
 5zdyawl+iosoRRCQ+i8XgIWXT8qE1AERmLo2Qi9dA7XMCLEpk8xbgTUWQLX1cp6NP9XhJcIm7
 ve6qegNBtWs0p6PO0K/FzlL2webzUub+gJgf3GwW4EHqKP2tLFrnH1h7tp9ZFWseEcDpsSmPW
 Xb5i4zGRIO4i1Euevk7r0uOzRROBbws0uk41SIorebNVwlnenliWrGr9hZgp++iq1jJFF83Aw
 t3lS5HFH2Pv0C9d4OCecVWCwBi19XgZnad4Y2xtWTqQABKJYqizz1QQ7UxmxUTO5C+0808r7V
 VdlcvWtKu/av7zSFA53kGMPJKs1dgw4wcefc73mR2qO0nXSS/EWGj+4kb1YKqqZSHrY9Mixnz
 I3FtUNm95w+C4zUWvxEss96zwxgLlxkkbcz1RQsB/OzmPIBw2i8ET6uuD4JNqkROS4SOmgZlc
 ApX7/YrQ7qpLCiCenWX6eJafX4Lm6URqdvDwxbPUf8YEWyu6YE9ha5Oxg1cgNrs1TBhP8QLWT
 OJ4HXAJ+MTkIL21FPq1xZmAIvDqN2StR0d3dWePPGnKjVcXFQuJcXSD2QhIQTcp6guxgLn6bO
 32B89+vO6pBCkTg==
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

p is a generic variable in syscall() and can be used by any syscall
case, so this patch removes the useless local variable declaration for
the following syscalls: TARGET_NR_llistxattr, TARGET_NR_listxattr,
TARGET_NR_setxattr, TARGET_NR_lsetxattr, TARGET_NR_getxattr,
TARGET_NR_lgetxattr, TARGET_NR_removexattr, TARGET_NR_lremovexattr.

Fix following warnings:

.../linux-user/syscall.c:12342:15: warning: declaration of 'p' shadows a previous local [-Wshadow=compatible-local]
12342 |         void *p, *b = 0;
      |               ^
.../linux-user/syscall.c:8975:11: note: shadowed declaration is here
 8975 |     void *p;
      |           ^
.../linux-user/syscall.c:12379:19: warning: declaration of 'p' shadows a previous local [-Wshadow=compatible-local]
12379 |             void *p, *n, *v = 0;
      |                   ^
.../linux-user/syscall.c:8975:11: note: shadowed declaration is here
 8975 |     void *p;
      |           ^
.../linux-user/syscall.c:12424:19: warning: declaration of 'p' shadows a previous local [-Wshadow=compatible-local]
12424 |             void *p, *n, *v = 0;
      |                   ^
.../linux-user/syscall.c:8975:11: note: shadowed declaration is here
 8975 |     void *p;
      |           ^
.../linux-user/syscall.c:12469:19: warning: declaration of 'p' shadows a previous local [-Wshadow=compatible-local]
12469 |             void *p, *n;
      |                   ^
.../linux-user/syscall.c:8975:11: note: shadowed declaration is here
 8975 |     void *p;
      |           ^

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 6139c00ddceb..fe228f7db3a7 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -12339,7 +12339,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
     case TARGET_NR_listxattr:
     case TARGET_NR_llistxattr:
     {
-        void *p, *b = 0;
+        void *b = 0;
         if (arg2) {
             b = lock_user(VERIFY_WRITE, arg2, arg3, 0);
             if (!b) {
@@ -12376,7 +12376,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
     case TARGET_NR_setxattr:
     case TARGET_NR_lsetxattr:
         {
-            void *p, *n, *v = 0;
+            void *n, *v = 0;
             if (arg3) {
                 v = lock_user(VERIFY_READ, arg3, arg4, 1);
                 if (!v) {
@@ -12421,7 +12421,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
     case TARGET_NR_getxattr:
     case TARGET_NR_lgetxattr:
         {
-            void *p, *n, *v = 0;
+            void *n, *v = 0;
             if (arg3) {
                 v = lock_user(VERIFY_WRITE, arg3, arg4, 0);
                 if (!v) {
@@ -12466,7 +12466,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
     case TARGET_NR_removexattr:
     case TARGET_NR_lremovexattr:
         {
-            void *p, *n;
+            void *n;
             p = lock_user_string(arg1);
             n = lock_user_string(arg2);
             if (p && n) {
-- 
2.41.0


