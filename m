Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E797129BB
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 17:38:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2ZVi-00080R-H0; Fri, 26 May 2023 11:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q2ZVf-0007zD-Mw
 for qemu-devel@nongnu.org; Fri, 26 May 2023 11:37:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q2ZVe-0004bh-5g
 for qemu-devel@nongnu.org; Fri, 26 May 2023 11:37:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685115461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+54B3w9+z/3ivqFbdQ5tyWss4Ab4+nh200yk/a7igx4=;
 b=AkD0MckY0dd7rsiA2EwhDtbj9PFNCFpZayOqdEYV1himrgvpcMXYIJ7i9+ZVSJAs7g5ygx
 g4KBMapnanXms++4zy5+3Ge3BCKxnADedz5MmlUFv3pLB7BhwWo5OcP9Qoyl+w8oQ5Pj/b
 danliV2vzsjUj0YZA3kS8a4b2+HCtrw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-65-ngitXRt7PrqJT75A5fMKag-1; Fri, 26 May 2023 11:37:39 -0400
X-MC-Unique: ngitXRt7PrqJT75A5fMKag-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 883DA1C0ED0D
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 15:37:39 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.193.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6FB187AE4;
 Fri, 26 May 2023 15:37:38 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH] vdpa: Remove status in reset tracing
Date: Fri, 26 May 2023 17:37:36 +0200
Message-Id: <20230526153736.472443-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

It is always 0 and it is not useful to route call through file
descriptor.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---

Commit extracted from series [1], Message-Id
<20230509154435.1410162-1-eperezma@redhat.com>, as this change is not
needed anymore there but the patch makes sense by itself.

[1] https://lore.kernel.org/qemu-devel/20230518172138-mutt-send-email-mst@kernel.org/T/
---
 hw/virtio/vhost-vdpa.c | 2 +-
 hw/virtio/trace-events | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index b3094e8a8b..dc593042d7 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -860,7 +860,7 @@ static int vhost_vdpa_reset_device(struct vhost_dev *dev)
     uint8_t status = 0;
 
     ret = vhost_vdpa_call(dev, VHOST_VDPA_SET_STATUS, &status);
-    trace_vhost_vdpa_reset_device(dev, status);
+    trace_vhost_vdpa_reset_device(dev);
     v->suspended = false;
     return ret;
 }
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 8f8d05cf9b..6265231683 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -44,7 +44,7 @@ vhost_vdpa_set_mem_table(void *dev, uint32_t nregions, uint32_t padding) "dev: %
 vhost_vdpa_dump_regions(void *dev, int i, uint64_t guest_phys_addr, uint64_t memory_size, uint64_t userspace_addr, uint64_t flags_padding) "dev: %p %d: guest_phys_addr: 0x%"PRIx64" memory_size: 0x%"PRIx64" userspace_addr: 0x%"PRIx64" flags_padding: 0x%"PRIx64
 vhost_vdpa_set_features(void *dev, uint64_t features) "dev: %p features: 0x%"PRIx64
 vhost_vdpa_get_device_id(void *dev, uint32_t device_id) "dev: %p device_id %"PRIu32
-vhost_vdpa_reset_device(void *dev, uint8_t status) "dev: %p status: 0x%"PRIx8
+vhost_vdpa_reset_device(void *dev) "dev: %p"
 vhost_vdpa_get_vq_index(void *dev, int idx, int vq_idx) "dev: %p idx: %d vq idx: %d"
 vhost_vdpa_set_vring_ready(void *dev) "dev: %p"
 vhost_vdpa_dump_config(void *dev, const char *line) "dev: %p %s"
-- 
2.31.1


