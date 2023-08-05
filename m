Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DD37711E5
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 21:42:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSN9d-0007aR-UT; Sat, 05 Aug 2023 15:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qSN9b-0007ZS-6e; Sat, 05 Aug 2023 15:41:35 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qSN9Z-0007rj-FS; Sat, 05 Aug 2023 15:41:34 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 665B01865F;
 Sat,  5 Aug 2023 22:41:50 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 269A11BA45;
 Sat,  5 Aug 2023 22:41:28 +0300 (MSK)
Received: (nullmailer pid 70355 invoked by uid 1000);
 Sat, 05 Aug 2023 19:41:27 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Hawkins Jiawei <yin31149@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Lei Yang <leiyang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.4 66/71] vdpa: Return -EIO if device ack is
 VIRTIO_NET_ERR in _load_mac()
Date: Sat,  5 Aug 2023 22:41:07 +0300
Message-Id: <20230805194127.70304-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.4-20230805223954@cover.tls.msk.ru>
References: <qemu-stable-8.0.4-20230805223954@cover.tls.msk.ru>
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

From: Hawkins Jiawei <yin31149@gmail.com>

According to VirtIO standard, "The class, command and
command-specific-data are set by the driver,
and the device sets the ack byte.
There is little it can do except issue a diagnostic
if ack is not VIRTIO_NET_OK."

Therefore, QEMU should stop sending the queued SVQ commands and
cancel the device startup if the device's ack is not VIRTIO_NET_OK.

Yet the problem is that, vhost_vdpa_net_load_mac() returns 1 based on
`*s->status != VIRTIO_NET_OK` when the device's ack is VIRTIO_NET_ERR.
As a result, net->nc->info->load() also returns 1, this makes
vhost_net_start_one() incorrectly assume the device state is
successfully loaded by vhost_vdpa_net_load() and return 0, instead of
goto `fail` label to cancel the device startup, as vhost_net_start_one()
only cancels the device startup when net->nc->info->load() returns a
negative value.

This patch fixes this problem by returning -EIO when the device's
ack is not VIRTIO_NET_OK.

Fixes: f73c0c43ac ("vdpa: extract vhost_vdpa_net_load_mac from vhost_vdpa_net_load")
Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Message-Id: <a21731518644abbd0c495c5b7960527c5911f80d.1688438055.git.yin31149@gmail.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit b479bc3c9d5e473553137641fd31069c251f0d6e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 7c2c4fb7ea..92c74497b5 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -659,8 +659,9 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n)
         if (unlikely(dev_written < 0)) {
             return dev_written;
         }
-
-        return *s->status != VIRTIO_NET_OK;
+        if (*s->status != VIRTIO_NET_OK) {
+            return -EIO;
+        }
     }
 
     return 0;
-- 
2.39.2


