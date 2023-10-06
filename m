Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E9C7BC03D
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 22:22:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qorJr-0008Es-US; Fri, 06 Oct 2023 16:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qorJq-0008DZ-0a; Fri, 06 Oct 2023 16:21:06 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qorJm-0005lw-Tz; Fri, 06 Oct 2023 16:21:05 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:3a8c:0:640:ec94:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id B7F1260EFB;
 Fri,  6 Oct 2023 23:20:58 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b403::1:3c])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id kKgI6e5OrCg0-u47sV36S; Fri, 06 Oct 2023 23:20:58 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1696623658;
 bh=syAAIAOzDHq5ojU1/sX7mdXQubeQ0DIGcKwtqZmbCE8=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=YtYKqjdFBgqF/pT005LSQWS5AFaPj7zs7RhBIpsUDjJjT9YL8W8bVBg68oahIn1Do
 Gbt14Kjyc7GE99c1k6W/Myv6xlwLFS9zJT0al4swh9mef1m3ralBqOt9+Wm5I4WX0M
 3berNGUVKRfNx3WgwYcEP2zmzgwn2qES2gX367L8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, eblake@redhat.com, dave@treblig.org,
 armbru@redhat.com, eduardo@habkost.net, berrange@redhat.com,
 pbonzini@redhat.com, hreitz@redhat.com, kwolf@redhat.com,
 raphael.norwitz@nutanix.com, mst@redhat.com, yc-core@yandex-team.ru,
 vsementsov@yandex-team.ru, den-plotnikov@yandex-team.ru,
 daniil.tatianin@yandex.ru
Subject: [PATCH 1/4] vhost-user-blk: simplify and fix
 vhost_user_blk_handle_config_change
Date: Fri,  6 Oct 2023 23:20:42 +0300
Message-Id: <20231006202045.1161543-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006202045.1161543-1-vsementsov@yandex-team.ru>
References: <20231006202045.1161543-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Let's not care about what was changed and update the whole config,
reasons:

1. config->geometry should be updated together with capacity, so we fix
   a bug.

2. Vhost-user protocol doesn't say anything about config change
   limitation. Silent ignore of changes doesn't seem to be correct.

3. vhost-user-vsock reads the whole config

4. on realize we don't do any checks on retrieved config, so no reason
   to care here

Also, let's notify guest unconditionally:

1. So does vhost-user-vsock

2. We are going to reuse the functionality in new cases when we do want
   to notify the guest unconditionally. So, no reason to create extra
   branches in the logic.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/block/vhost-user-blk.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index eecf3f7a81..1ee05b46ee 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -93,7 +93,6 @@ static void vhost_user_blk_set_config(VirtIODevice *vdev, const uint8_t *config)
 static int vhost_user_blk_handle_config_change(struct vhost_dev *dev)
 {
     int ret;
-    struct virtio_blk_config blkcfg;
     VirtIODevice *vdev = dev->vdev;
     VHostUserBlk *s = VHOST_USER_BLK(dev->vdev);
     Error *local_err = NULL;
@@ -102,19 +101,15 @@ static int vhost_user_blk_handle_config_change(struct vhost_dev *dev)
         return 0;
     }
 
-    ret = vhost_dev_get_config(dev, (uint8_t *)&blkcfg,
+    ret = vhost_dev_get_config(dev, (uint8_t *)&s->blkcfg,
                                vdev->config_len, &local_err);
     if (ret < 0) {
         error_report_err(local_err);
         return ret;
     }
 
-    /* valid for resize only */
-    if (blkcfg.capacity != s->blkcfg.capacity) {
-        s->blkcfg.capacity = blkcfg.capacity;
-        memcpy(dev->vdev->config, &s->blkcfg, vdev->config_len);
-        virtio_notify_config(dev->vdev);
-    }
+    memcpy(dev->vdev->config, &s->blkcfg, vdev->config_len);
+    virtio_notify_config(dev->vdev);
 
     return 0;
 }
-- 
2.34.1


