Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5AC73EAC8
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 21:00:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDrNU-0006aJ-CL; Mon, 26 Jun 2023 14:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrMk-0002hy-HS; Mon, 26 Jun 2023 14:55:12 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrMi-0005nx-Bx; Mon, 26 Jun 2023 14:55:10 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 14069EF4A;
 Mon, 26 Jun 2023 21:50:31 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 7F4F3F7D9;
 Mon, 26 Jun 2023 21:50:29 +0300 (MSK)
Received: (nullmailer pid 1574112 invoked by uid 1000);
 Mon, 26 Jun 2023 18:50:16 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Prasad Pandit <pjp@fedoraproject.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.3 51/54] vhost: release memory_listener object in error
 path
Date: Mon, 26 Jun 2023 21:49:58 +0300
Message-Id: <20230626185002.1573836-51-mjt@tls.msk.ru>
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

vhost_dev_start function does not release memory_listener object
in case of an error. This may crash the guest when vhost is unable
to set memory table:

  stack trace of thread 125653:
  Program terminated with signal SIGSEGV, Segmentation fault
  #0  memory_listener_register (qemu-kvm + 0x6cda0f)
  #1  vhost_dev_start (qemu-kvm + 0x699301)
  #2  vhost_net_start (qemu-kvm + 0x45b03f)
  #3  virtio_net_set_status (qemu-kvm + 0x665672)
  #4  qmp_set_link (qemu-kvm + 0x548fd5)
  #5  net_vhost_user_event (qemu-kvm + 0x552c45)
  #6  tcp_chr_connect (qemu-kvm + 0x88d473)
  #7  tcp_chr_new_client (qemu-kvm + 0x88cf83)
  #8  tcp_chr_accept (qemu-kvm + 0x88b429)
  #9  qio_net_listener_channel_func (qemu-kvm + 0x7ac07c)
  #10 g_main_context_dispatch (libglib-2.0.so.0 + 0x54e2f)

Release memory_listener objects in the error path.

Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
Message-Id: <20230529114333.31686-2-ppandit@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Fixes: c471ad0e9b ("vhost_net: device IOTLB support")
Cc: qemu-stable@nongnu.org
Acked-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit 1e3ffb34f764f8ac4c003b2b2e6a775b2b073a16)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index a266396576..7c87f1328b 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -2018,6 +2018,9 @@ fail_vq:
     }
 
 fail_mem:
+    if (vhost_dev_has_iommu(hdev)) {
+        memory_listener_unregister(&hdev->iommu_listener);
+    }
 fail_features:
     vdev->vhost_started = false;
     hdev->started = false;
-- 
2.39.2


