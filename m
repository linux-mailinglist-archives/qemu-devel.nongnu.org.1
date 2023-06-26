Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F34173E29D
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 17:00:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlPK-0000ef-VK; Mon, 26 Jun 2023 08:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlMH-0004dt-DW
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:30:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlMF-0003UL-IJ
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:30:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+JPP6gC2T8mRsPCVFgr5jilK+TVU+Qzv7fnB3Ti8Mg4=;
 b=NcwNztOVMy83vETlT2b/wtr54srECtFT3LBgw5SVoOechtC7AWiWHpmlpy34kFW8u0d26c
 oUtwMNRSMbFU81kxjiXVDCQQeAYaybaVY9EO2wECTtUPU6tyysngY6+LQ2SQ6yXTPz5arE
 oQ0zXRSJwHTSO3PjSm7MNZ7gGyAJpHw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-1kzTSnCuO8Sm-6R-Eef4uQ-1; Mon, 26 Jun 2023 08:30:12 -0400
X-MC-Unique: 1kzTSnCuO8Sm-6R-Eef4uQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-313e557a824so653944f8f.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:30:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782611; x=1690374611;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+JPP6gC2T8mRsPCVFgr5jilK+TVU+Qzv7fnB3Ti8Mg4=;
 b=PQIY5pVDjFr7ZoGAoebmOcWhBaq/crlKQfP68TDtcHsqUlicJxKFTGjvToGzy2yucl
 H8YgGLna/NOF5k+/wSkgXfgnnDumJ5Ti+kKd1PX1RlM9N9MvbvvET21271M566RmpbXL
 9R6F38N3/Z1ghamH0XvGVz6tLp+B9YjWK9KcS3/B/RnX/dp3a+SZ6rOG5IP6OHFS1xIp
 dZEjdUnBBxHDAqcJFuLV4irkADC1KS3vIMorQJSJmrgTgYJ6dr/I/deGEZEGPx2fctGu
 nHMOl81YMsbV+MK5nmmOiRQPugdsUBOJGONIwd4FqRC3R9dJXWdpBdWvqVfY7D0YQNZ6
 9cyA==
X-Gm-Message-State: AC+VfDzur3GpRMVRJh3HIOWOOTOoew3e1njJaWQ74gRbsTk2Cmu+KNOG
 EiUZ2op1Z1FQoMgoeFo0s1ZLbYDt8q/k9TIUNgMH0BaPAzLK32lANxuuIgyOsoQmmN5dSWvZF6s
 odL/uUSg7BD+7KopBq4SLSVVA13Jz0e8VZ1CD6VgvxrVF3wWJJnuJWX3ZxdHKjEHUo0Y0
X-Received: by 2002:a5d:674b:0:b0:313:ebbf:3696 with SMTP id
 l11-20020a5d674b000000b00313ebbf3696mr2867397wrw.46.1687782611142; 
 Mon, 26 Jun 2023 05:30:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Q0dyZA4pnYOtQC85OALAlkkgNldInwRPD5pd/rN/6R/XOZmbKSQcUmGe4OMEsJofTRF+5Yw==
X-Received: by 2002:a5d:674b:0:b0:313:ebbf:3696 with SMTP id
 l11-20020a5d674b000000b00313ebbf3696mr2867382wrw.46.1687782610807; 
 Mon, 26 Jun 2023 05:30:10 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 t5-20020a05600001c500b00313f7b077fesm624178wrx.59.2023.06.26.05.30.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:30:10 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:30:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Jean-Louis Dupond <jean-louis@dupond.be>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PULL 47/53] virtio-scsi: avoid dangling host notifier in
 ->ioeventfd_stop()
Message-ID: <c5fb3e6e479b8a3786c8bb7cfb0d0fad1c6e2dc4.1687782442.git.mst@redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1687782442.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

virtio_scsi_dataplane_stop() calls blk_drain_all(), which invokes
->drained_begin()/->drained_end() after we've already detached the host
notifier. virtio_scsi_drained_end() currently attaches the host notifier
again and leaves it dangling after dataplane has stopped.

This results in the following assertion failure because
virtio_scsi_defer_to_dataplane() is called from the IOThread instead of
the main loop thread:

  qemu-system-x86_64: ../softmmu/memory.c:1111: memory_region_transaction_commit: Assertion `qemu_mutex_iothread_locked()' failed.

Buglink: https://gitlab.com/qemu-project/qemu/-/issues/1680
Reported-by: Jean-Louis Dupond <jean-louis@dupond.be>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20230611193924.2444914-1-stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
MST


