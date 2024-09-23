Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3579297D1F8
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Sep 2024 09:47:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srYHu-0001Uz-6k; Fri, 20 Sep 2024 03:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1srYHd-0001GX-3T; Fri, 20 Sep 2024 03:42:29 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1srYHb-0000Gn-57; Fri, 20 Sep 2024 03:42:28 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D0BE690862;
 Fri, 20 Sep 2024 10:41:21 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 787951409E5;
 Fri, 20 Sep 2024 10:41:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 12/22] util/cutils: Remove unused qemu_get_exec_dir
Date: Fri, 20 Sep 2024 10:41:24 +0300
Message-Id: <20240920074134.664961-13-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240920074134.664961-1-mjt@tls.msk.ru>
References: <20240920074134.664961-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

qemu_get_exec_dir has been unused since commit:
  5bebe03f51 ("util/cutils: Clean up global variable shadowing in get_relocated_path()")

Remove it, and fix up a comment that pointed to it.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 include/qemu/cutils.h | 5 +----
 util/cutils.c         | 5 -----
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index da15547bfb..34a9b9b220 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -241,13 +241,10 @@ int uleb128_decode_small(const uint8_t *in, uint32_t *n);
 int qemu_pstrcmp0(const char **str1, const char **str2);
 
 /* Find program directory, and save it for later usage with
- * qemu_get_exec_dir().
+ * get_relocated_path().
  * Try OS specific API first, if not working, parse from argv0. */
 void qemu_init_exec_dir(const char *argv0);
 
-/* Get the saved exec dir.  */
-const char *qemu_get_exec_dir(void);
-
 /**
  * get_relocated_path:
  * @dir: the directory (typically a `CONFIG_*DIR` variable) to be relocated.
diff --git a/util/cutils.c b/util/cutils.c
index 42364039a5..9803f11a59 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -1144,11 +1144,6 @@ void qemu_init_exec_dir(const char *argv0)
 #endif
 }
 
-const char *qemu_get_exec_dir(void)
-{
-    return exec_dir;
-}
-
 char *get_relocated_path(const char *dir)
 {
     size_t prefix_len = strlen(CONFIG_PREFIX);
-- 
2.39.5


