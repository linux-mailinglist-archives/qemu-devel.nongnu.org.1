Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A9A770848
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 20:56:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRzwQ-0002LL-Gy; Fri, 04 Aug 2023 14:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qRzwH-0002Jq-Kj; Fri, 04 Aug 2023 14:54:18 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qRzwF-00089D-Vx; Fri, 04 Aug 2023 14:54:17 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 992DD1840C;
 Fri,  4 Aug 2023 21:54:18 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 3AE021B883;
 Fri,  4 Aug 2023 21:53:58 +0300 (MSK)
Received: (nullmailer pid 1874218 invoked by uid 1000);
 Fri, 04 Aug 2023 18:53:56 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Anthony PERARD <anthony.perard@citrix.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paul Durrant <paul@xen.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.5 22/36] xen-block: Avoid leaks on new error path
Date: Fri,  4 Aug 2023 21:53:35 +0300
Message-Id: <20230804185350.1874133-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.5-20230804215319@cover.tls.msk.ru>
References: <qemu-stable-7.2.5-20230804215319@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Anthony PERARD <anthony.perard@citrix.com>

Commit 189829399070 ("xen-block: Use specific blockdev driver")
introduced a new error path, without taking care of allocated
resources.

So only allocate the qdicts after the error check, and free both
`filename` and `driver` when we are about to return and thus taking
care of both success and error path.

Coverity only spotted the leak of qdicts (*_layer variables).

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Fixes: Coverity CID 1508722, 1398649
Fixes: 189829399070 ("xen-block: Use specific blockdev driver")
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
Reviewed-by: Paul Durrant <paul@xen.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20230704171819.42564-1-anthony.perard@citrix.com>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
(cherry picked from commit aa36243514a777f76c8b8a19b1f8a71f27ec6c78)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 345b284d70..5e45a8b729 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -759,14 +759,15 @@ static XenBlockDrive *xen_block_drive_create(const char *id,
     drive = g_new0(XenBlockDrive, 1);
     drive->id = g_strdup(id);
 
-    file_layer = qdict_new();
-    driver_layer = qdict_new();
-
     rc = stat(filename, &st);
     if (rc) {
         error_setg_errno(errp, errno, "Could not stat file '%s'", filename);
         goto done;
     }
+
+    file_layer = qdict_new();
+    driver_layer = qdict_new();
+
     if (S_ISBLK(st.st_mode)) {
         qdict_put_str(file_layer, "driver", "host_device");
     } else {
@@ -774,7 +775,6 @@ static XenBlockDrive *xen_block_drive_create(const char *id,
     }
 
     qdict_put_str(file_layer, "filename", filename);
-    g_free(filename);
 
     if (mode && *mode != 'w') {
         qdict_put_bool(file_layer, "read-only", true);
@@ -809,7 +809,6 @@ static XenBlockDrive *xen_block_drive_create(const char *id,
     qdict_put_str(file_layer, "locking", "off");
 
     qdict_put_str(driver_layer, "driver", driver);
-    g_free(driver);
 
     qdict_put(driver_layer, "file", file_layer);
 
@@ -820,6 +819,8 @@ static XenBlockDrive *xen_block_drive_create(const char *id,
     qobject_unref(driver_layer);
 
 done:
+    g_free(filename);
+    g_free(driver);
     if (*errp) {
         xen_block_drive_destroy(drive, NULL);
         return NULL;
-- 
2.39.2


