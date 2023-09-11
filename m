Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4124579A4FE
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 09:51:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfbgt-00042l-Q3; Mon, 11 Sep 2023 03:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=GLJ6=E3=redhat.com=clg@ozlabs.org>)
 id 1qfbgr-0003wZ-Hz
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 03:50:37 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=GLJ6=E3=redhat.com=clg@ozlabs.org>)
 id 1qfbgo-0008DH-Tw
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 03:50:37 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Rkf5g3lfCz4xM3;
 Mon, 11 Sep 2023 17:50:31 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rkf5f04pZz4xM1;
 Mon, 11 Sep 2023 17:50:29 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 08/13] vfio/migration: Fail adding device with
 enable-migration=on and existing blocker
Date: Mon, 11 Sep 2023 09:50:03 +0200
Message-ID: <20230911075008.462712-9-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911075008.462712-1-clg@redhat.com>
References: <20230911075008.462712-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=GLJ6=E3=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Avihai Horon <avihaih@nvidia.com>

If a device with enable-migration=on is added and it causes a migration
blocker, adding the device should fail with a proper error.

This is not the case with multiple device migration blocker when the
blocker already exists. If the blocker already exists and a device with
enable-migration=on is added which causes a migration blocker, adding
the device will succeed.

Fix it by failing adding the device in such case.

Fixes: 8bbcb64a71d8 ("vfio/migration: Make VFIO migration non-experimental")
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/common.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 8a8d074e1863ec40b00a424bbe50494ce8391301..237101d03844273f653d98b6d053a1ae9c05a247 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -394,8 +394,7 @@ int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
 {
     int ret;
 
-    if (multiple_devices_migration_blocker ||
-        vfio_multiple_devices_migration_is_supported()) {
+    if (vfio_multiple_devices_migration_is_supported()) {
         return 0;
     }
 
@@ -405,6 +404,10 @@ int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
         return -EINVAL;
     }
 
+    if (multiple_devices_migration_blocker) {
+        return 0;
+    }
+
     error_setg(&multiple_devices_migration_blocker,
                "Multiple VFIO devices migration is supported only if all of "
                "them support P2P migration");
-- 
2.41.0


