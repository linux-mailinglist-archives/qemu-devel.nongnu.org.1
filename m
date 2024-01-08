Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A39698268AD
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 08:35:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMk8N-0003Im-5q; Mon, 08 Jan 2024 02:33:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=P3fH=IS=redhat.com=clg@ozlabs.org>)
 id 1rMk8J-0003IG-SW
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 02:33:16 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=P3fH=IS=redhat.com=clg@ozlabs.org>)
 id 1rMk8H-0004hT-4m
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 02:33:15 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4T7m4k4dWKz4x1v;
 Mon,  8 Jan 2024 18:33:10 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4T7m4h1NSFz4wcc;
 Mon,  8 Jan 2024 18:33:07 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 12/17] hw/vfio: fix iteration over global VFIODevice list
Date: Mon,  8 Jan 2024 08:32:27 +0100
Message-ID: <20240108073232.118228-13-clg@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108073232.118228-1-clg@redhat.com>
References: <20240108073232.118228-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=P3fH=IS=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_MED=-2.3,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Volker Rümelin <vr_qemu@t-online.de>

Commit 3d779abafe ("vfio/common: Introduce a global VFIODevice list")
introduced a global VFIODevice list, but forgot to update the list
element field name when iterating over the new list. Change the code
to use the correct list element field.

Fixes: 3d779abafe ("vfio/common: Introduce a global VFIODevice list")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2061
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 hw/vfio/common.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 0d4d8b8416c6a4770677e1ebe5e1fc7dbaaef004..0b3352f2a9d278f252a460e339732f1ccac0a96d 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -73,7 +73,7 @@ bool vfio_mig_active(void)
         return false;
     }
 
-    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
+    QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
         if (vbasedev->migration_blocker) {
             return false;
         }
@@ -94,7 +94,7 @@ static bool vfio_multiple_devices_migration_is_supported(void)
     unsigned int device_num = 0;
     bool all_support_p2p = true;
 
-    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
+    QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
         if (vbasedev->migration) {
             device_num++;
 
@@ -1366,13 +1366,13 @@ void vfio_reset_handler(void *opaque)
 {
     VFIODevice *vbasedev;
 
-    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
+    QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
         if (vbasedev->dev->realized) {
             vbasedev->ops->vfio_compute_needs_reset(vbasedev);
         }
     }
 
-    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
+    QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
         if (vbasedev->dev->realized && vbasedev->needs_reset) {
             vbasedev->ops->vfio_hot_reset_multi(vbasedev);
         }
-- 
2.43.0


