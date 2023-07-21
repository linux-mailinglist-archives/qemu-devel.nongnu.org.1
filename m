Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7654F75C855
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 15:51:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMqWA-000445-Lb; Fri, 21 Jul 2023 09:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qMqW2-00043k-HM
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 09:49:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qMqW0-0003fZ-Mc
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 09:49:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689947391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=B9oswWCqo0/VaVYEh2gJW86L28YMLsF9GHW+bXZcMOI=;
 b=M1q1rV9fFjDngnp7UaE2mt3cNtp/Jjj2BZk+F0hB5+cc+PYIPMKNdXj6rDj66FEV9DucOh
 8RMUasnVlXF2a1b1I4mcsAqaQtLJreTYOvlHScaVFaeRqpdbOk7/OhRodY4kT+OQx7uGk5
 l10dATDWZK72aU841pTH+nirgvTQ1Y8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-671-JbG9i_4fM2m-JV6t2FhFrg-1; Fri, 21 Jul 2023 09:49:47 -0400
X-MC-Unique: JbG9i_4fM2m-JV6t2FhFrg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4EB26800B35
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 13:49:47 +0000 (UTC)
Received: from localhost (unknown [10.39.193.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BDD5C1415115;
 Fri, 21 Jul 2023 13:49:46 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Czenczek <hreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH] virtio: Fix packed virtqueue used_idx mask
Date: Fri, 21 Jul 2023 15:49:45 +0200
Message-ID: <20230721134945.26967-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
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

virtio_queue_packed_set_last_avail_idx() is used by vhost devices to set
the internal queue indices to what has been reported by the vhost
back-end through GET_VRING_BASE.  For packed virtqueues, this
32-bit value is expected to contain both the device's internal avail and
used indices, as well as their respective wrap counters.

To get the used index, we shift the 32-bit value right by 16, and then
apply a mask of 0x7ffff.  That seems to be a typo, because it should be
0x7fff; first of all, the virtio specification says that the maximum
queue size for packed virt queues is 2^15, so the indices cannot exceed
2^15 - 1 anyway, making 0x7fff the correct mask.  Second, the mask
clearly is wrong from context, too, given that (A) `idx & 0x70000` must
be 0 at this point (`idx` is 32 bit and was shifted to the right by 16
already), (B) `idx & 0x8000` is the used_wrap_counter, so should not be
part of the used index, and (C) `vq->used_idx` is a `uint16_t`, so
cannot fit the 0x70000 part of the mask anyway.

This most likely never produced any guest-visible bugs, though, because
for a vhost device, qemu will probably not evaluate the used index
outside of virtio_queue_packed_get_last_avail_idx(), where we
reconstruct the 32-bit value from avail and used indices and their wrap
counters again.  There, it does not matter whether the highest bit of
the used_idx is the used index wrap counter, because we put the wrap
counter exactly in that position anyway.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 hw/virtio/virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 295a603e58..309038fd46 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3321,7 +3321,7 @@ static void virtio_queue_packed_set_last_avail_idx(VirtIODevice *vdev,
     vq->last_avail_wrap_counter =
         vq->shadow_avail_wrap_counter = !!(idx & 0x8000);
     idx >>= 16;
-    vq->used_idx = idx & 0x7ffff;
+    vq->used_idx = idx & 0x7fff;
     vq->used_wrap_counter = !!(idx & 0x8000);
 }
 
-- 
2.41.0


