Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6261BCFDC4
	for <lists+qemu-devel@lfdr.de>; Sun, 12 Oct 2025 01:27:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7iws-0006EU-Tl; Sat, 11 Oct 2025 19:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7iwr-0006Dl-0v
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 19:24:25 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7iwp-0000u4-Ae
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 19:24:24 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 0419DC01DB;
 Sun, 12 Oct 2025 02:24:22 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a4b::1:3c])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 6OWMXt1FjqM0-VDDfSdew; Sun, 12 Oct 2025 02:24:21 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760225061;
 bh=XEvi3adXzXhv3hAtbmzh4wUci3ltl+p6RB499smUSBU=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Lq1squkTiglGqIQ6hn7fqI2FKU0Sn6+PEm/XrZcBPmTt4viZfLNgAD/2Q0/Nj0qa7
 ZyAqjWvRqTHmqgTxNM14Fbt9fKMTjxNqnUDEl7VoRhuiXvEOy+54/RW6vgRQAK9pMi
 f3UKlieDyQ3WQaZpE5G7nZDkwhVW09cidd58tw4Q=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 raphael.s.norwitz@gmail.com, vsementsov@yandex-team.ru,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Subject: [PATCH v2 16/23] vhost: simplify vhost_dev_init() error-path
Date: Sun, 12 Oct 2025 02:23:55 +0300
Message-ID: <20251011232404.561024-17-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251011232404.561024-1-vsementsov@yandex-team.ru>
References: <20251011232404.561024-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

No reason to rollback setting up busyloop timeout on failure.
We don't do such rollback for other things we setup in backend.
Also, look at vhost_net_init() in hw/net/vhost_net.c: we may fail
after successfully called vhost_dev_init(), and in this case we'll
just call vhost_dev_cleanup(), which doesn't rollback busyloop
timeout.

So, let's keep it simple.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Acked-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
---
 hw/virtio/vhost.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index ebdea096aa..188ea0f955 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1621,7 +1621,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
                                                      busyloop_timeout);
             if (r < 0) {
                 error_setg_errno(errp, -r, "Failed to set busyloop timeout");
-                goto fail_busyloop;
+                goto fail;
             }
         }
     }
@@ -1661,7 +1661,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     if (hdev->migration_blocker != NULL) {
         r = migrate_add_blocker_normal(&hdev->migration_blocker, errp);
         if (r < 0) {
-            goto fail_busyloop;
+            goto fail;
         }
     }
 
@@ -1693,17 +1693,11 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
                    " than current number of used (%d) and reserved (%d)"
                    " memory slots for memory devices.", limit, used, reserved);
         r = -EINVAL;
-        goto fail_busyloop;
+        goto fail;
     }
 
     return 0;
 
-fail_busyloop:
-    if (busyloop_timeout) {
-        while (--i >= 0) {
-            vhost_virtqueue_set_busyloop_timeout(hdev, hdev->vq_index + i, 0);
-        }
-    }
 fail:
     hdev->nvqs = n_initialized_vqs;
     vhost_dev_cleanup(hdev);
-- 
2.48.1


