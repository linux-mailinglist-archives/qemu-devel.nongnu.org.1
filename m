Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DECE172B3BA
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 21:41:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8QuW-00016e-TH; Sun, 11 Jun 2023 15:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q8QuV-000167-4g
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 15:39:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q8QuT-0008Lk-ME
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 15:39:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686512371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+n8G6yTzwrEyBmx0c+esTTD24rSyG19DzYuods5UpVY=;
 b=UtuCZzkEXS8A/K/L9ZMah17ibXZ853oP3yub6TLd5ePGeG1CDQoU/qqk9y6nCs8T6JW2Ga
 ZfTCHsAiYYIn0ecmKR2t+is2AQT0+doabF6KSwziImLgScTlk/girXE5mF6iphJS6BgngY
 gnoG/njn9SAI53oIq+gKuPQwYd7Rzy8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-38-kHVYPRAoPoiI5ftOZ4r3hA-1; Sun, 11 Jun 2023 15:39:28 -0400
X-MC-Unique: kHVYPRAoPoiI5ftOZ4r3hA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BD83F811E78;
 Sun, 11 Jun 2023 19:39:27 +0000 (UTC)
Received: from localhost (unknown [10.39.192.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C402B2166B25;
 Sun, 11 Jun 2023 19:39:26 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, kwolf@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, <qemu-block@nongnu.org>,
 Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Jean-Louis Dupond <jean-louis@dupond.be>
Subject: [PATCH] virtio-scsi: avoid dangling host notifier in
 ->ioeventfd_stop()
Date: Sun, 11 Jun 2023 15:39:24 -0400
Message-Id: <20230611193924.2444914-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

virtio_scsi_dataplane_stop() calls blk_drain_all(), which invokes
->drained_begin()/->drained_end() after we've already detached the host
notifier. virtio_scsi_drained_end() currently attaches the host notifier
again and leaves it dangling after dataplane has stopped.

This results in the following assertion failure because
virtio_scsi_defer_to_dataplane() is called from the IOThread instead of
the main loop thread:

  qemu-system-x86_64: ../softmmu/memory.c:1111: memory_region_transaction_commit: Assertion `qemu_mutex_iothread_locked()' failed.

Reported-by: Jean-Louis Dupond <jean-louis@dupond.be>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/scsi/virtio-scsi.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 9c8ef0aaa6..45b95ea070 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -1125,7 +1125,16 @@ static void virtio_scsi_drained_begin(SCSIBus *bus)
     uint32_t total_queues = VIRTIO_SCSI_VQ_NUM_FIXED +
                             s->parent_obj.conf.num_queues;
 
-    if (!s->dataplane_started) {
+    /*
+     * Drain is called when stopping dataplane but the host notifier has
+     * already been detached. Detaching multiple times is a no-op if nothing
+     * else is using the monitoring same file descriptor, but avoid it just in
+     * case.
+     *
+     * Also, don't detach if dataplane has not even been started yet because
+     * the host notifier isn't attached.
+     */
+    if (s->dataplane_stopping || !s->dataplane_started) {
         return;
     }
 
@@ -1143,7 +1152,14 @@ static void virtio_scsi_drained_end(SCSIBus *bus)
     uint32_t total_queues = VIRTIO_SCSI_VQ_NUM_FIXED +
                             s->parent_obj.conf.num_queues;
 
-    if (!s->dataplane_started) {
+    /*
+     * Drain is called when stopping dataplane. Keep the host notifier detached
+     * so it's not left dangling after dataplane is stopped.
+     *
+     * Also, don't attach if dataplane has not even been started yet. We're not
+     * ready.
+     */
+    if (s->dataplane_stopping || !s->dataplane_started) {
         return;
     }
 
-- 
2.40.1


