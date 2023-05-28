Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 042F571382B
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 08:59:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3ALy-0006bS-Bp; Sun, 28 May 2023 02:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q3ALt-0006Xn-RE; Sun, 28 May 2023 02:58:05 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q3ALs-0001eZ-AQ; Sun, 28 May 2023 02:58:05 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 337AB8E05;
 Sun, 28 May 2023 09:57:18 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id C69427E25;
 Sun, 28 May 2023 09:57:17 +0300 (MSK)
Received: (nullmailer pid 42090 invoked by uid 1000);
 Sun, 28 May 2023 06:57:15 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.1 73/73] virtio: qmp: fix memory leak
Date: Sun, 28 May 2023 09:57:11 +0300
Message-Id: <20230528065714.42005-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.1-20230528095540@cover.tls.msk.ru>
References: <qemu-stable-8.0.1-20230528095540@cover.tls.msk.ru>
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

From: Paolo Bonzini <pbonzini@redhat.com>

The VirtioInfoList is already allocated by QAPI_LIST_PREPEND and
need not be allocated by the caller.

Fixes Coverity CID 1508724.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 0bfd14149b248e8097ea4da1f9d53beb5c5b0cca)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index b70148aba9..3d7ce2ea2f 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -666,7 +666,7 @@ VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap)
 VirtioInfoList *qmp_x_query_virtio(Error **errp)
 {
     VirtioInfoList *list = NULL;
-    VirtioInfoList *node;
+    VirtioInfo *node;
     VirtIODevice *vdev;
 
     QTAILQ_FOREACH(vdev, &virtio_list, next) {
@@ -680,11 +680,10 @@ VirtioInfoList *qmp_x_query_virtio(Error **errp)
             if (!strncmp(is_realized->str, "false", 4)) {
                 QTAILQ_REMOVE(&virtio_list, vdev, next);
             } else {
-                node = g_new0(VirtioInfoList, 1);
-                node->value = g_new(VirtioInfo, 1);
-                node->value->path = g_strdup(dev->canonical_path);
-                node->value->name = g_strdup(vdev->name);
-                QAPI_LIST_PREPEND(list, node->value);
+                node = g_new(VirtioInfo, 1);
+                node->path = g_strdup(dev->canonical_path);
+                node->name = g_strdup(vdev->name);
+                QAPI_LIST_PREPEND(list, node);
             }
            g_string_free(is_realized, true);
         }
-- 
2.39.2


