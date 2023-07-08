Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DC474BBEE
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jul 2023 07:15:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qI0GJ-0006TF-7b; Sat, 08 Jul 2023 01:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qI0GG-0006Qn-2F; Sat, 08 Jul 2023 01:13:36 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qI0G3-0001lq-BW; Sat, 08 Jul 2023 01:13:35 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6D14712687;
 Sat,  8 Jul 2023 08:13:09 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 96DD1139D5;
 Sat,  8 Jul 2023 08:13:05 +0300 (MSK)
Received: (nullmailer pid 3230000 invoked by uid 1000);
 Sat, 08 Jul 2023 05:13:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Laszlo Ersek <lersek@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Peter Xu <peterx@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/10] migration: factor out "resume_requested" in qmp_migrate()
Date: Sat,  8 Jul 2023 08:12:48 +0300
Message-Id: <8c69ae9eff3c4c3432a3846c2444a1c36044b61b.1688793073.git.mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1688793073.git.mjt@tls.msk.ru>
References: <cover.1688793073.git.mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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

From: Laszlo Ersek <lersek@redhat.com>

It cuts back on those awkward, duplicated !(has_resume && resume)
expressions.

Cc: Juan Quintela <quintela@redhat.com> (maintainer:Migration)
Cc: Leonardo Bras <leobras@redhat.com> (reviewer:Migration)
Cc: Peter Xu <peterx@redhat.com> (reviewer:Migration)
Cc: qemu-trivial@nongnu.org
Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=2018404
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 migration/migration.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 096e8191d1..a60a5acee5 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1637,6 +1637,7 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
                  bool has_inc, bool inc, bool has_detach, bool detach,
                  bool has_resume, bool resume, Error **errp)
 {
+    bool resume_requested;
     Error *local_err = NULL;
     MigrationState *s = migrate_get_current();
     const char *p = NULL;
@@ -1646,13 +1647,14 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
         return;
     }
 
+    resume_requested = has_resume && resume;
     if (!migrate_prepare(s, has_blk && blk, has_inc && inc,
-                         has_resume && resume, errp)) {
+                         resume_requested, errp)) {
         /* Error detected, put into errp */
         return;
     }
 
-    if (!(has_resume && resume)) {
+    if (!resume_requested) {
         if (!yank_register_instance(MIGRATION_YANK_INSTANCE, errp)) {
             return;
         }
@@ -1671,7 +1673,7 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
     } else if (strstart(uri, "fd:", &p)) {
         fd_start_outgoing_migration(s, p, &local_err);
     } else {
-        if (!(has_resume && resume)) {
+        if (!resume_requested) {
             yank_unregister_instance(MIGRATION_YANK_INSTANCE);
         }
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "uri",
@@ -1683,7 +1685,7 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
     }
 
     if (local_err) {
-        if (!(has_resume && resume)) {
+        if (!resume_requested) {
             yank_unregister_instance(MIGRATION_YANK_INSTANCE);
         }
         migrate_fd_error(s, local_err);
-- 
2.39.2


