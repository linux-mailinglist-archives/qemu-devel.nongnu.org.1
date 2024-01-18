Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3B6831367
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 08:56:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQNF7-0001VS-4B; Thu, 18 Jan 2024 02:55:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQNF3-0001Sr-Th; Thu, 18 Jan 2024 02:55:13 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQNF1-0007PQ-8C; Thu, 18 Jan 2024 02:55:13 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C7DBC45039;
 Thu, 18 Jan 2024 10:54:35 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id F02DE661A2;
 Thu, 18 Jan 2024 10:54:05 +0300 (MSK)
Received: (nullmailer pid 2381673 invoked by uid 1000);
 Thu, 18 Jan 2024 07:54:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.1 15/38] hw/vfio: fix iteration over global VFIODevice
 list
Date: Thu, 18 Jan 2024 10:52:42 +0300
Message-Id: <20240118075404.2381519-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.1-20240118102508@cover.tls.msk.ru>
References: <qemu-stable-8.2.1-20240118102508@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
(cherry picked from commit 9353b6da430f90e47f352dbf6dc31120c8914da6)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index e70fdf5e0c..a5dfc2d27e 100644
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
 
@@ -1352,13 +1352,13 @@ void vfio_reset_handler(void *opaque)
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
2.39.2


