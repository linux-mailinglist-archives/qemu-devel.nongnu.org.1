Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8706E8FBC25
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jun 2024 21:07:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEZUZ-0005xd-38; Tue, 04 Jun 2024 15:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZUV-0005v0-9V
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:06:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZUT-0000nq-Jr
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:06:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717527996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OCCVtvSfvqBAUBpNFi/zb/m65iBLwl7XEHTViiftxcE=;
 b=c7hAk2HEwlGyghTALHp7ytXyy2nnv+mEhbjvPNcr3OpI82ruEU9oCLfHg0ZmtQt4NdfD9N
 ZKNUChb/wsqpgUU5N4sR/ZcZ57RuH6/JrsHjmhcd8UrU1WXy6OvK8b9C2ZYHnvGGyHHwJp
 V//39dGKCbcpOYYhZkrB4tMKP7yq0Ko=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-LRem79UqNseIIeC7uk7v5g-1; Tue, 04 Jun 2024 15:06:35 -0400
X-MC-Unique: LRem79UqNseIIeC7uk7v5g-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-35dbf83bb20so3575852f8f.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 12:06:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717527994; x=1718132794;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OCCVtvSfvqBAUBpNFi/zb/m65iBLwl7XEHTViiftxcE=;
 b=hTwgcJRQcMNvGGVdvkkByV1b6rftvMTszzfMPUcV/4FpbdPks0WjcnxJMcZzHf/2K1
 SsdA3k16sG0bpp8tuY9zO0o9bai8WjyOlgg+AKTGwQxWDADSOJIeKss6sMKI67KyQKdt
 hc23FCo6hnDRKQpt8w+7D/2oG/xR+5KEW3t0VyFYGYhe6T8zXF3lmxuHNarGp0IvampM
 QNhZfObIkrZpB8eI7PsmsEUIJXA3ODw++hjvn6NZB585MWwghQqwlOHJZaTqu2TSIQTt
 G0WEDlRAkbfHAKxJM/EDux97Tf1z2WnrV0VXPCXzfYiS/i/QuvN6pxoNwCdYbm2UvcNS
 a9CA==
X-Gm-Message-State: AOJu0YyXWxE8pcrGFWrdD3YzwA/ElSlOX7A123NC3smLdnxAPYDcqjZY
 ilRTrgWI1b6aNkk2H2MTzjv0gRkHwOUl+/kBbgEyw6R15C35YBSnEg8+a+1wz30ueqWm6kMk3ZS
 XZCiBEnF1meJsY8rS0SKPGkvNV9s2j37LNhyKy435DIc91z6ypAuhxMm13V9bRN0CHGjld1tVRT
 vC9zqLSwh7L4+H93VhOhBTbi1obE1FzA==
X-Received: by 2002:a5d:66cf:0:b0:35e:5be5:fbb with SMTP id
 ffacd0b85a97d-35e8ef8ec1bmr213106f8f.67.1717527993889; 
 Tue, 04 Jun 2024 12:06:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlxcGzgfMyv1oXCA/eCPMq7OxdfCxVeK3UxTeT30HVafbwgGv3cusaR71zAWthsSz/YFutNA==
X-Received: by 2002:a5d:66cf:0:b0:35e:5be5:fbb with SMTP id
 ffacd0b85a97d-35e8ef8ec1bmr213075f8f.67.1717527993350; 
 Tue, 04 Jun 2024 12:06:33 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:552:cf5c:2b13:215c:b9df:f231])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04c0e84sm12415306f8f.13.2024.06.04.12.06.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 12:06:32 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:06:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonah Palmer <jonah.palmer@oracle.com>, Lei Yang <leiyang@redhat.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Srujana Challa <schalla@marvell.com>,
 Raphael Norwitz <raphael@enfabrica.net>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 virtio-fs@lists.linux.dev
Subject: [PULL 09/46] vhost/vhost-user: Add VIRTIO_F_NOTIFICATION_DATA to
 vhost feature bits
Message-ID: <bb0ba79492dc7c1d1b2ef3e2389060ed259e646a.1717527933.git.mst@redhat.com>
References: <cover.1717527933.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1717527933.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Jonah Palmer <jonah.palmer@oracle.com>

Add support for the VIRTIO_F_NOTIFICATION_DATA feature across a variety
of vhost devices.

The inclusion of VIRTIO_F_NOTIFICATION_DATA in the feature bits arrays
for these devices ensures that the backend is capable of offering and
providing support for this feature, and that it can be disabled if the
backend does not support it.

Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
Message-Id: <20240315165557.26942-6-jonah.palmer@oracle.com>
Acked-by: Srujana Challa <schalla@marvell.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/block/vhost-user-blk.c    | 1 +
 hw/net/vhost_net.c           | 2 ++
 hw/scsi/vhost-scsi.c         | 1 +
 hw/scsi/vhost-user-scsi.c    | 1 +
 hw/virtio/vhost-user-fs.c    | 2 +-
 hw/virtio/vhost-user-vsock.c | 1 +
 net/vhost-vdpa.c             | 1 +
 7 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 9e6bbc6950..bc2677dbef 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -51,6 +51,7 @@ static const int user_feature_bits[] = {
     VIRTIO_F_RING_PACKED,
     VIRTIO_F_IOMMU_PLATFORM,
     VIRTIO_F_RING_RESET,
+    VIRTIO_F_NOTIFICATION_DATA,
     VHOST_INVALID_FEATURE_BIT
 };
 
diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index fd1a93701a..18898afe81 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -48,6 +48,7 @@ static const int kernel_feature_bits[] = {
     VIRTIO_F_IOMMU_PLATFORM,
     VIRTIO_F_RING_PACKED,
     VIRTIO_F_RING_RESET,
+    VIRTIO_F_NOTIFICATION_DATA,
     VIRTIO_NET_F_HASH_REPORT,
     VHOST_INVALID_FEATURE_BIT
 };
@@ -55,6 +56,7 @@ static const int kernel_feature_bits[] = {
 /* Features supported by others. */
 static const int user_feature_bits[] = {
     VIRTIO_F_NOTIFY_ON_EMPTY,
+    VIRTIO_F_NOTIFICATION_DATA,
     VIRTIO_RING_F_INDIRECT_DESC,
     VIRTIO_RING_F_EVENT_IDX,
 
diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index ae26bc19a4..3d5fe0994d 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -38,6 +38,7 @@ static const int kernel_feature_bits[] = {
     VIRTIO_RING_F_EVENT_IDX,
     VIRTIO_SCSI_F_HOTPLUG,
     VIRTIO_F_RING_RESET,
+    VIRTIO_F_NOTIFICATION_DATA,
     VHOST_INVALID_FEATURE_BIT
 };
 
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index a63b1f4948..0b050805a8 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -36,6 +36,7 @@ static const int user_feature_bits[] = {
     VIRTIO_RING_F_EVENT_IDX,
     VIRTIO_SCSI_F_HOTPLUG,
     VIRTIO_F_RING_RESET,
+    VIRTIO_F_NOTIFICATION_DATA,
     VHOST_INVALID_FEATURE_BIT
 };
 
diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
index cca2cd41be..ae48cc1c96 100644
--- a/hw/virtio/vhost-user-fs.c
+++ b/hw/virtio/vhost-user-fs.c
@@ -33,7 +33,7 @@ static const int user_feature_bits[] = {
     VIRTIO_F_RING_PACKED,
     VIRTIO_F_IOMMU_PLATFORM,
     VIRTIO_F_RING_RESET,
-
+    VIRTIO_F_NOTIFICATION_DATA,
     VHOST_INVALID_FEATURE_BIT
 };
 
diff --git a/hw/virtio/vhost-user-vsock.c b/hw/virtio/vhost-user-vsock.c
index 9431b9792c..802b44a07d 100644
--- a/hw/virtio/vhost-user-vsock.c
+++ b/hw/virtio/vhost-user-vsock.c
@@ -21,6 +21,7 @@ static const int user_feature_bits[] = {
     VIRTIO_RING_F_INDIRECT_DESC,
     VIRTIO_RING_F_EVENT_IDX,
     VIRTIO_F_NOTIFY_ON_EMPTY,
+    VIRTIO_F_NOTIFICATION_DATA,
     VHOST_INVALID_FEATURE_BIT
 };
 
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index eda714d1a4..daa38428c5 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -62,6 +62,7 @@ const int vdpa_feature_bits[] = {
     VIRTIO_F_RING_PACKED,
     VIRTIO_F_RING_RESET,
     VIRTIO_F_VERSION_1,
+    VIRTIO_F_NOTIFICATION_DATA,
     VIRTIO_NET_F_CSUM,
     VIRTIO_NET_F_CTRL_GUEST_OFFLOADS,
     VIRTIO_NET_F_CTRL_MAC_ADDR,
-- 
MST


