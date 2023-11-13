Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 582B57E9E7A
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 15:20:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2XnN-00023X-Th; Mon, 13 Nov 2023 09:20:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1r2XnK-00022t-Tg
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 09:20:06 -0500
Received: from mx20.baidu.com ([111.202.115.85] helo=baidu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1r2XnG-0005vf-R2
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 09:20:06 -0500
To: Markus Armbruster <armbru@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Konstantin Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Dr. David
 Alan Gilbert" <dgilbert@redhat.com>
CC: <qemu-devel@nongnu.org>, Gao Shiyuan <gaoshiyuan@baidu.com>
Subject: [PATCH] util/qemu-config: Remove unnecessary traversal
Date: Mon, 13 Nov 2023 22:19:36 +0800
Message-ID: <20231113141936.30567-1-gaoshiyuan@baidu.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex08.internal.baidu.com (10.127.64.18) To
 bjkjy-mail-ex26.internal.baidu.com (172.31.50.42)
X-FEAS-Client-IP: 172.31.51.13
X-FE-Policy-ID: 15:10:21:SYSTEM
Received-SPF: pass client-ip=111.202.115.85; envelope-from=gaoshiyuan@baidu.com;
 helo=baidu.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-to:  Shiyuan Gao <gaoshiyuan@baidu.com>
From:  Shiyuan Gao via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Gao Shiyuan <gaoshiyuan@baidu.com>

No remove QemuOptsList from *_config_groups, so no need to
traverse from the beginning every time.

No functional changes.

Signed-off-by: Gao Shiyuan <gaoshiyuan@baidu.com>
---
 include/qemu/config-file.h |  3 +++
 util/qemu-config.c         | 18 ++++++++----------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/qemu/config-file.h b/include/qemu/config-file.h
index b82a778123..223ef7bc8f 100644
--- a/include/qemu/config-file.h
+++ b/include/qemu/config-file.h
@@ -1,6 +1,9 @@
 #ifndef QEMU_CONFIG_FILE_H
 #define QEMU_CONFIG_FILE_H
 
+#define MAX_VM_CONFIG_GROUPS    48
+#define MAX_DRIVE_CONFIG_GROUPS 5
+
 typedef void QEMUConfigCB(const char *group, QDict *qdict, void *opaque, Error **errp);
 
 void qemu_load_module_for_opts(const char *group);
diff --git a/util/qemu-config.c b/util/qemu-config.c
index 42076efe1e..d7bab2047f 100644
--- a/util/qemu-config.c
+++ b/util/qemu-config.c
@@ -9,8 +9,8 @@
 #include "qemu/config-file.h"
 #include "hw/boards.h"
 
-static QemuOptsList *vm_config_groups[48];
-static QemuOptsList *drive_config_groups[5];
+static QemuOptsList *vm_config_groups[MAX_VM_CONFIG_GROUPS];
+static QemuOptsList *drive_config_groups[MAX_DRIVE_CONFIG_GROUPS];
 
 static QemuOptsList *find_list(QemuOptsList **lists, const char *group,
                                Error **errp)
@@ -260,11 +260,10 @@ QemuOptsList *qemu_find_opts_err(const char *group, Error **errp)
 
 void qemu_add_drive_opts(QemuOptsList *list)
 {
-    int entries, i;
+    static int i;
+    static int entries = MAX_DRIVE_CONFIG_GROUPS - 1; /* keep list NULL terminated */
 
-    entries = ARRAY_SIZE(drive_config_groups);
-    entries--; /* keep list NULL terminated */
-    for (i = 0; i < entries; i++) {
+    for (; i < entries; i++) {
         if (drive_config_groups[i] == NULL) {
             drive_config_groups[i] = list;
             return;
@@ -276,11 +275,10 @@ void qemu_add_drive_opts(QemuOptsList *list)
 
 void qemu_add_opts(QemuOptsList *list)
 {
-    int entries, i;
+    static int i;
+    static int entries = MAX_VM_CONFIG_GROUPS - 1; /* keep list NULL terminated */
 
-    entries = ARRAY_SIZE(vm_config_groups);
-    entries--; /* keep list NULL terminated */
-    for (i = 0; i < entries; i++) {
+    for (; i < entries; i++) {
         if (vm_config_groups[i] == NULL) {
             vm_config_groups[i] = list;
             return;
-- 
2.27.0


