Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D3282016E
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 21:40:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJJdK-0008HN-42; Fri, 29 Dec 2023 15:39:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1rJJdI-0008HB-Fk; Fri, 29 Dec 2023 15:39:04 -0500
Received: from mailout11.t-online.de ([194.25.134.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1rJJdG-00076a-CW; Fri, 29 Dec 2023 15:39:04 -0500
Received: from fwd72.aul.t-online.de (fwd72.aul.t-online.de [10.223.144.98])
 by mailout11.t-online.de (Postfix) with SMTP id C472077D5;
 Fri, 29 Dec 2023 21:38:56 +0100 (CET)
Received: from linpower.localnet ([79.208.20.53]) by fwd72.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1rJJd8-0oI1Yn0; Fri, 29 Dec 2023 21:38:54 +0100
Received: by linpower.localnet (Postfix, from userid 1000)
 id 8C18C200279; Fri, 29 Dec 2023 21:38:54 +0100 (CET)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Subject: [PATCH] hw/vfio: fix iteration over global VFIODevice list
Date: Fri, 29 Dec 2023 21:38:54 +0100
Message-Id: <20231229203854.8281-1-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1703882334-5081A95D-2FB37117/0/0 CLEAN NORMAL
X-TOI-MSGID: 9de0d6bc-f662-4ee8-aba1-b9aea0e14331
Received-SPF: pass client-ip=194.25.134.85;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout11.t-online.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

Commit 3d779abafe ("vfio/common: Introduce a global VFIODevice list")
introduced a global VFIODevice list, but forgot to update the list
element field name when iterating over the new list. Change the code
to use the correct list element field.

Fixes: 3d779abafe ("vfio/common: Introduce a global VFIODevice list")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2061
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 hw/vfio/common.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 08a3e57672..3ba892d7d3 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -74,7 +74,7 @@ bool vfio_mig_active(void)
         return false;
     }
 
-    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
+    QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
         if (vbasedev->migration_blocker) {
             return false;
         }
@@ -95,7 +95,7 @@ static bool vfio_multiple_devices_migration_is_supported(void)
     unsigned int device_num = 0;
     bool all_support_p2p = true;
 
-    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
+    QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
         if (vbasedev->migration) {
             device_num++;
 
@@ -1367,13 +1367,13 @@ void vfio_reset_handler(void *opaque)
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
2.35.3


