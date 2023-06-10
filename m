Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB31972A993
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 08:59:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7sYn-0002uz-EF; Sat, 10 Jun 2023 02:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q7sYi-0002qh-Ew; Sat, 10 Jun 2023 02:58:48 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q7sYg-00063Y-Qf; Sat, 10 Jun 2023 02:58:48 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BEDACBE2D;
 Sat, 10 Jun 2023 09:58:01 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 57995B29A;
 Sat, 10 Jun 2023 09:58:01 +0300 (MSK)
Received: (nullmailer pid 1107532 invoked by uid 1000);
 Sat, 10 Jun 2023 06:57:58 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 13/16] linux-user: Return EINVAL for getgroups() with negative
 gidsetsize
Date: Sat, 10 Jun 2023 09:57:51 +0300
Message-Id: <8fbf89a9669520ac09b3ae0013ff3eb34f8cab23.1686379708.git.mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1686379708.git.mjt@tls.msk.ru>
References: <cover.1686379708.git.mjt@tls.msk.ru>
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

From: Peter Maydell <peter.maydell@linaro.org>

Coverity doesn't like the way we might end up calling getgroups()
with a NULL grouplist pointer. This is fine for the special case
of gidsetsize == 0, but we will also do it if the guest passes
us a negative gidsetsize. (CID 1512465)

Explicitly fail the negative gidsetsize with EINVAL, as the kernel
does. This means we definitely only call the libc getgroups()
with valid parameters. It also brings the getgroups() code in
to line with the setgroups() code.

Possibly Coverity may still complain about getgroups(0, NULL), but
that would be a false positive.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 linux-user/syscall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 94256cc262..f2cb101d83 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11676,7 +11676,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
             g_autofree gid_t *grouplist = NULL;
             int i;
 
-            if (gidsetsize > NGROUPS_MAX) {
+            if (gidsetsize > NGROUPS_MAX || gidsetsize < 0) {
                 return -TARGET_EINVAL;
             }
             if (gidsetsize > 0) {
@@ -12012,7 +12012,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
             g_autofree gid_t *grouplist = NULL;
             int i;
 
-            if (gidsetsize > NGROUPS_MAX) {
+            if (gidsetsize > NGROUPS_MAX || gidsetsize < 0) {
                 return -TARGET_EINVAL;
             }
             if (gidsetsize > 0) {
-- 
2.39.2


