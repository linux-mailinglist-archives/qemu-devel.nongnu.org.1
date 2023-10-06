Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE887BBE8D
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 20:17:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qopMf-0007vj-J2; Fri, 06 Oct 2023 14:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qopMc-0007nl-0c; Fri, 06 Oct 2023 14:15:50 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qopMa-0000in-B5; Fri, 06 Oct 2023 14:15:49 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9F1462846A;
 Fri,  6 Oct 2023 21:15:12 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 300832D721;
 Fri,  6 Oct 2023 21:15:07 +0300 (MSK)
Received: (nullmailer pid 3297272 invoked by uid 1000);
 Fri, 06 Oct 2023 18:15:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Lei Yang <leiyang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.2 56/57] vdpa net: follow VirtIO initialization properly
 at cvq isolation probing
Date: Fri,  6 Oct 2023 21:14:45 +0300
Message-Id: <20231006181504.3297196-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.2-20231006191112@cover.tls.msk.ru>
References: <qemu-stable-8.1.2-20231006191112@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Eugenio Pérez <eperezma@redhat.com>

This patch solves a few issues.  The most obvious is that the feature
set was done previous to ACKNOWLEDGE | DRIVER status bit set.  Current
vdpa devices are permissive with this, but it is better to follow the
standard.

Fixes: 152128d646 ("vdpa: move CVQ isolation check to net_init_vhost_vdpa")
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Message-Id: <20230915170836.3078172-4-eperezma@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 845ec38ae1578dd2d42ff15c9979f1bf44b23418)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index cda6099ceb..07b616af51 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -1272,8 +1272,7 @@ static int vhost_vdpa_probe_cvq_isolation(int device_fd, uint64_t features,
     uint64_t backend_features;
     int64_t cvq_group;
     uint8_t status = VIRTIO_CONFIG_S_ACKNOWLEDGE |
-                     VIRTIO_CONFIG_S_DRIVER |
-                     VIRTIO_CONFIG_S_FEATURES_OK;
+                     VIRTIO_CONFIG_S_DRIVER;
     int r;
 
     ERRP_GUARD();
@@ -1288,15 +1287,22 @@ static int vhost_vdpa_probe_cvq_isolation(int device_fd, uint64_t features,
         return 0;
     }
 
+    r = ioctl(device_fd, VHOST_VDPA_SET_STATUS, &status);
+    if (unlikely(r)) {
+        error_setg_errno(errp, -r, "Cannot set device status");
+        goto out;
+    }
+
     r = ioctl(device_fd, VHOST_SET_FEATURES, &features);
     if (unlikely(r)) {
-        error_setg_errno(errp, errno, "Cannot set features");
+        error_setg_errno(errp, -r, "Cannot set features");
         goto out;
     }
 
+    status |= VIRTIO_CONFIG_S_FEATURES_OK;
     r = ioctl(device_fd, VHOST_VDPA_SET_STATUS, &status);
     if (unlikely(r)) {
-        error_setg_errno(errp, -r, "Cannot set status");
+        error_setg_errno(errp, -r, "Cannot set device status");
         goto out;
     }
 
-- 
2.39.2


