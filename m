Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC53762B92
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 08:37:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOY7u-0006O3-9P; Wed, 26 Jul 2023 02:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinglimin@cmss.chinamobile.com>)
 id 1qOY7l-0006Nr-IQ
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 02:35:53 -0400
Received: from cmccmta6.chinamobile.com ([111.22.67.139]
 helo=cmccmta1.chinamobile.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dinglimin@cmss.chinamobile.com>) id 1qOY7f-0004Pz-5N
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 02:35:50 -0400
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
 by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee164c0bebb9a7-1ea80;
 Wed, 26 Jul 2023 14:35:39 +0800 (CST)
X-RM-TRANSID: 2ee164c0bebb9a7-1ea80
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.108.79.99])
 by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee864c0beb9697-63a1b;
 Wed, 26 Jul 2023 14:35:39 +0800 (CST)
X-RM-TRANSID: 2ee864c0beb9697-63a1b
From: dinglimin <dinglimin@cmss.chinamobile.com>
To: imp@bsdimp.com,
	richard.henderson@linaro.org
Cc: qemu-devel@nongnu.org,
	dinglimin <dinglimin@cmss.chinamobile.com>
Subject: [PATCH] os-sys.c:do_freebsd_sysctl The unuser_lock for hnewp and
 hnamep is missing
Date: Wed, 26 Jul 2023 14:34:54 +0800
Message-Id: <20230726063454.247-1-dinglimin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.30.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=111.22.67.139;
 envelope-from=dinglimin@cmss.chinamobile.com; helo=cmccmta1.chinamobile.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

If holdp returns NULL, you need to execute unuser_lock on hnewp and hnamep when exiting the function

Signed-off-by: dinglimin <dinglimin@cmss.chinamobile.com>
---
 bsd-user/freebsd/os-sys.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bsd-user/freebsd/os-sys.c b/bsd-user/freebsd/os-sys.c
index df31706558..3918ddf1ed 100644
--- a/bsd-user/freebsd/os-sys.c
+++ b/bsd-user/freebsd/os-sys.c
@@ -585,9 +585,10 @@ abi_long do_freebsd_sysctl(CPUArchState *env, abi_ulong namep, int32_t namelen,
     if (oldlenp && (ret == 0 || ret == -TARGET_ENOMEM)) {
         put_user_ual(holdlen, oldlenp);
     }
-    unlock_user(hnamep, namep, 0);
     unlock_user(holdp, oldp, ret == 0 ? holdlen : 0);
 out:
+    unlock_user(hnamep, namep, 0);
+    unlock_user(hnewp, newp, 0);
     g_free(snamep);
     return ret;
 }
-- 
2.30.0.windows.2




