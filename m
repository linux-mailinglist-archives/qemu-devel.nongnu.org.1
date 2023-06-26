Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D82773EACD
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 21:00:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDrNI-0004hX-B4; Mon, 26 Jun 2023 14:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrMm-0002l2-Ny; Mon, 26 Jun 2023 14:55:14 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrMk-00062u-M9; Mon, 26 Jun 2023 14:55:12 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5E27CEF4B;
 Mon, 26 Jun 2023 21:50:31 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id CA989F7DA;
 Mon, 26 Jun 2023 21:50:29 +0300 (MSK)
Received: (nullmailer pid 1574115 invoked by uid 1000);
 Mon, 26 Jun 2023 18:50:16 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Prasad Pandit <pjp@fedoraproject.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.3 52/54] vhost: release virtqueue objects in error path
Date: Mon, 26 Jun 2023 21:49:59 +0300
Message-Id: <20230626185002.1573836-52-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.3-20230626214235@cover.tls.msk.ru>
References: <qemu-stable-8.0.3-20230626214235@cover.tls.msk.ru>
MIME-Version: 1.0
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

From: Prasad Pandit <pjp@fedoraproject.org>

vhost_dev_start function does not release virtqueue objects when
event_notifier_init() function fails. Release virtqueue objects
and log a message about function failure.

Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
Message-Id: <20230529114333.31686-3-ppandit@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Fixes: f9a09ca3ea ("vhost: add support for configure interrupt")
Reviewed-by: Peter Xu <peterx@redhat.com>
Cc: qemu-stable@nongnu.org
Acked-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit 77ece20ba04582d94c345ac0107ddff2fd18d27a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 7c87f1328b..58bd9ab82a 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1956,7 +1956,8 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
     r = event_notifier_init(
         &hdev->vqs[VHOST_QUEUE_NUM_CONFIG_INR].masked_config_notifier, 0);
     if (r < 0) {
-        return r;
+        VHOST_OPS_DEBUG(r, "event_notifier_init failed");
+        goto fail_vq;
     }
     event_notifier_test_and_clear(
         &hdev->vqs[VHOST_QUEUE_NUM_CONFIG_INR].masked_config_notifier);
-- 
2.39.2


