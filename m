Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6DF92D4EC
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jul 2024 17:26:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRZCZ-00018s-5e; Wed, 10 Jul 2024 11:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1sRZCW-0000s3-45; Wed, 10 Jul 2024 11:25:48 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1sRZCT-0000YF-TF; Wed, 10 Jul 2024 11:25:47 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id F1985472FF;
 Wed, 10 Jul 2024 17:25:34 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: fam@euphon.net, pbonzini@redhat.com, qemu-stable@nongnu.org,
 kwolf@redhat.com
Subject: [PATCH] scsi: fix regression and honor bootindex again for legacy
 drives
Date: Wed, 10 Jul 2024 17:25:29 +0200
Message-Id: <20240710152529.1737407-1-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Commit 3089637461 ("scsi: Don't ignore most usb-storage properties")
removed the call to object_property_set_int() and thus the 'set'
method for the bootindex property was also not called anymore. Here
that method is device_set_bootindex() (as configured by
scsi_dev_instance_init() -> device_add_bootindex_property()) which as
a side effect registers the device via add_boot_device_path().

As reported by a downstream user [0], the bootindex property did not
have the desired effect anymore for legacy drives. Fix the regression
by explicitly calling the add_boot_device_path() function after
checking that the bootindex is not yet used (to avoid
add_boot_device_path() calling exit()).

[0]: https://forum.proxmox.com/threads/149772/post-679433

Cc: qemu-stable@nongnu.org
Fixes: 3089637461 ("scsi: Don't ignore most usb-storage properties")
Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 hw/scsi/scsi-bus.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 9e40b0c920..53eff5dd3d 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -384,6 +384,7 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
     DeviceState *dev;
     SCSIDevice *s;
     DriveInfo *dinfo;
+    Error *local_err = NULL;
 
     if (blk_is_sg(blk)) {
         driver = "scsi-generic";
@@ -403,6 +404,14 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
     s = SCSI_DEVICE(dev);
     s->conf = *conf;
 
+    check_boot_index(conf->bootindex, &local_err);
+    if (local_err) {
+        object_unparent(OBJECT(dev));
+        error_propagate(errp, local_err);
+        return NULL;
+    }
+    add_boot_device_path(conf->bootindex, dev, NULL);
+
     qdev_prop_set_uint32(dev, "scsi-id", unit);
     if (object_property_find(OBJECT(dev), "removable")) {
         qdev_prop_set_bit(dev, "removable", removable);
-- 
2.39.2



