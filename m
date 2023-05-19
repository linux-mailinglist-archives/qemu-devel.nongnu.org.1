Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6616709A6E
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:50:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01QV-0006ze-Up; Fri, 19 May 2023 10:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01QS-0006zF-OD
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:49:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01QR-0003Gg-1W
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684507786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m8H3lZKDwI3mjSVXnoAagyvh6l6UiwvzrfJKVsJ59EM=;
 b=YECQE4VOhYUC0fMKqwk8+UwXLa9w+5y3FAyiaYLTS+39AFrJ62BfuUZ5qSckjJ9wFL4YN5
 gR22depUVqNezuaT/o/f7mgGGJ7uXTK/3okT1JBox/NO0frn6E2rq4v5EpYYsqFvJvwJx9
 D65fAX+YNECdKYSUkM0bieKU9Zt5WRA=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-2iedybBcOt-DLJ0i7Q0hKA-1; Fri, 19 May 2023 10:49:44 -0400
X-MC-Unique: 2iedybBcOt-DLJ0i7Q0hKA-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4f13b1c06aaso2237693e87.1
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:49:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684507782; x=1687099782;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m8H3lZKDwI3mjSVXnoAagyvh6l6UiwvzrfJKVsJ59EM=;
 b=ljgAoY1/xHWfyg3hOrCK7wMTQR7iLo+WlB+WHJZ0VlGeapOlwA+g8LHPDnxqgPrzrA
 to8Pp9ipde6EZvvmkYqbaiA+u4bSwtoYkxRNpomyj2pSAfV73wcciwCA6GOsOef+Tyxd
 c8CIyeLexL2ueOQDNJRZqT5jcgOoIAM7I4vp99SpjgXSwHN2sNmS7/D9ca72j6HqtlaH
 iaDyqhwMEzFBOJgZiMXnS+Q8sUiI4Y0Lik1FWI7hzP+cqOKn6cfmlawNlfLeA0vKH6JX
 yrChLy7vR27ggEFq1FLZvn9UJxkmxcm8jbPQ4aiXqrdbDbQWmc+JTjRRC+929XzA5UuL
 OWOg==
X-Gm-Message-State: AC+VfDxtpJcmEgAQjpYISp9Bf73SeNevriI6sbs2OH9LTKw5nUW9AhZ3
 c40Ba1+k6tJ62rauS8Hfl1AjwTfN2E7SEoi7ziK6z+mjwhlPtgR0wfd4NjjeuRK44JeLOkYq0S0
 54HtY1i2dKkASqpL0mL/SYjPUDIkiFf5wg7wILQ9h4iSX1MWofGYgrymI8VWCy0dEmz5f
X-Received: by 2002:ac2:4350:0:b0:4f3:91ee:3b73 with SMTP id
 o16-20020ac24350000000b004f391ee3b73mr763649lfl.30.1684507782124; 
 Fri, 19 May 2023 07:49:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7KyHMrBRXp+ODGCDRdQ7k8O3ycOiCEFjjFMJcYYFNWbDmQ/tq34Glr4iEsK89QdZBLoCcaKg==
X-Received: by 2002:ac2:4350:0:b0:4f3:91ee:3b73 with SMTP id
 o16-20020ac24350000000b004f391ee3b73mr763640lfl.30.1684507781799; 
 Fri, 19 May 2023 07:49:41 -0700 (PDT)
Received: from redhat.com ([176.12.184.180]) by smtp.gmail.com with ESMTPSA id
 v26-20020a056512049a00b004efff420b11sm622508lfq.181.2023.05.19.07.49.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 07:49:41 -0700 (PDT)
Date: Fri, 19 May 2023 10:49:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Lei Yang <leiyang@redhat.com>
Subject: [PULL 01/40] vhost: fix possible wrap in SVQ descriptor ring
Message-ID: <5d410557dea452f6231a7c66155e29a37e168528.1684507742.git.mst@redhat.com>
References: <cover.1684507742.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1684507742.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

From: Hawkins Jiawei <yin31149@gmail.com>

QEMU invokes vhost_svq_add() when adding a guest's element
into SVQ. In vhost_svq_add(), it uses vhost_svq_available_slots()
to check whether QEMU can add the element into SVQ. If there is
enough space, then QEMU combines some out descriptors and some
in descriptors into one descriptor chain, and adds it into
`svq->vring.desc` by vhost_svq_vring_write_descs().

Yet the problem is that, `svq->shadow_avail_idx - svq->shadow_used_idx`
in vhost_svq_available_slots() returns the number of occupied elements,
or the number of descriptor chains, instead of the number of occupied
descriptors, which may cause wrapping in SVQ descriptor ring.

Here is an example. In vhost_handle_guest_kick(), QEMU forwards
as many available buffers to device by virtqueue_pop() and
vhost_svq_add_element(). virtqueue_pop() returns a guest's element,
and then this element is added into SVQ by vhost_svq_add_element(),
a wrapper to vhost_svq_add(). If QEMU invokes virtqueue_pop() and
vhost_svq_add_element() `svq->vring.num` times,
vhost_svq_available_slots() thinks QEMU just ran out of slots and
everything should work fine. But in fact, virtqueue_pop() returns
`svq->vring.num` elements or descriptor chains, more than
`svq->vring.num` descriptors due to guest memory fragmentation,
and this causes wrapping in SVQ descriptor ring.

This bug is valid even before marking the descriptors used.
If the guest memory is fragmented, SVQ must add chains
so it can try to add more descriptors than possible.

This patch solves it by adding `num_free` field in
VhostShadowVirtqueue structure and updating this field
in vhost_svq_add() and vhost_svq_get_buf(), to record
the number of free descriptors.

Fixes: 100890f7ca ("vhost: Shadow virtqueue buffers forwarding")
Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Message-Id: <20230509084817.3973-1-yin31149@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 hw/virtio/vhost-shadow-virtqueue.h | 3 +++
 hw/virtio/vhost-shadow-virtqueue.c | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shadow-virtqueue.h
index 926a4897b1..6efe051a70 100644
--- a/hw/virtio/vhost-shadow-virtqueue.h
+++ b/hw/virtio/vhost-shadow-virtqueue.h
@@ -107,6 +107,9 @@ typedef struct VhostShadowVirtqueue {
 
     /* Next head to consume from the device */
     uint16_t last_used_idx;
+
+    /* Size of SVQ vring free descriptors */
+    uint16_t num_free;
 } VhostShadowVirtqueue;
 
 bool vhost_svq_valid_features(uint64_t features, Error **errp);
diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index 8361e70d1b..bd7c12b6d3 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -68,7 +68,7 @@ bool vhost_svq_valid_features(uint64_t features, Error **errp)
  */
 static uint16_t vhost_svq_available_slots(const VhostShadowVirtqueue *svq)
 {
-    return svq->vring.num - (svq->shadow_avail_idx - svq->shadow_used_idx);
+    return svq->num_free;
 }
 
 /**
@@ -263,6 +263,7 @@ int vhost_svq_add(VhostShadowVirtqueue *svq, const struct iovec *out_sg,
         return -EINVAL;
     }
 
+    svq->num_free -= ndescs;
     svq->desc_state[qemu_head].elem = elem;
     svq->desc_state[qemu_head].ndescs = ndescs;
     vhost_svq_kick(svq);
@@ -449,6 +450,7 @@ static VirtQueueElement *vhost_svq_get_buf(VhostShadowVirtqueue *svq,
     last_used_chain = vhost_svq_last_desc_of_chain(svq, num, used_elem.id);
     svq->desc_next[last_used_chain] = svq->free_head;
     svq->free_head = used_elem.id;
+    svq->num_free += num;
 
     *len = used_elem.len;
     return g_steal_pointer(&svq->desc_state[used_elem.id].elem);
@@ -659,6 +661,7 @@ void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
     svq->iova_tree = iova_tree;
 
     svq->vring.num = virtio_queue_get_num(vdev, virtio_get_queue_index(vq));
+    svq->num_free = svq->vring.num;
     driver_size = vhost_svq_driver_area_size(svq);
     device_size = vhost_svq_device_area_size(svq);
     svq->vring.desc = qemu_memalign(qemu_real_host_page_size(), driver_size);
-- 
MST


