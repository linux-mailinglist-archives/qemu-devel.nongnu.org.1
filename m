Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD0770C4F8
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 20:10:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q19yl-0006Ru-Go; Mon, 22 May 2023 14:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1q19yk-0006Rj-AL
 for qemu-devel@nongnu.org; Mon, 22 May 2023 14:09:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1q19yi-000149-Tp
 for qemu-devel@nongnu.org; Mon, 22 May 2023 14:09:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684778991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=fqpVYtoOvANJNKZHYEd3/G7WQsLRofvmBgl2UL+zb3o=;
 b=Enf5f39tT8BFe9linW95vl+s3czm4P0XUxkYRQmmqJFfHxm90otfKGgTU12WAtnsbeiZyt
 LPskLzy7qSkb4/8/zFGjT8L80SVCiu3zNfGaAFU76NBZkNq9F2jMNEV31f0ALl8wLOxceD
 5T4+fNbBA6wcqNgyyadh5TzlIwVXg4I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-B-JNFzLWPr6v6I734-jlbw-1; Mon, 22 May 2023 14:08:41 -0400
X-MC-Unique: B-JNFzLWPr6v6I734-jlbw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DFFE9185A78E;
 Mon, 22 May 2023 18:08:40 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.67.24.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 27F1D40D1B60;
 Mon, 22 May 2023 18:08:38 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH] vhost: release memory objects in error path
Date: Mon, 22 May 2023 23:40:21 +0530
Message-Id: <20230522181021.403585-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Prasad Pandit <pjp@fedoraproject.org>

vhost_dev_start function does not release memory objects in case
of an error. This may crash the guest with:

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
  ===

Release memory_listener and virtqueue objects in the error path.

Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
---
 hw/virtio/vhost.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 23da579ce2..e261ae7c49 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1942,7 +1942,7 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
     r = event_notifier_init(
         &hdev->vqs[VHOST_QUEUE_NUM_CONFIG_INR].masked_config_notifier, 0);
     if (r < 0) {
-        return r;
+        goto fail_vq;
     }
     event_notifier_test_and_clear(
         &hdev->vqs[VHOST_QUEUE_NUM_CONFIG_INR].masked_config_notifier);
@@ -2004,6 +2004,9 @@ fail_vq:
     }
 
 fail_mem:
+    if (vhost_dev_has_iommu(hdev)) {
+        memory_listener_unregister(&hdev->iommu_listener);
+    }
 fail_features:
     vdev->vhost_started = false;
     hdev->started = false;
-- 
2.40.1


