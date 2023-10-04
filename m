Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8D17B7A6C
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:44:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxUK-0003Zt-0o; Wed, 04 Oct 2023 04:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxU9-00032t-Uk
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:44:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxU8-00016N-69
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:44:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XPImF4K2pL45lQ4EfG0s+CTn23uOSVuTqBqWIA624PQ=;
 b=L2oXVEqMKA1UIvYRPU6n2lD5BYG0pafNn15iCKXt4R1/udEMP2jVvFq9ojR57TTOE9/gao
 NviH6OfQ/jds+SDL2Dm1ZnbwmXKukYep0q+MsHpF0TeoNEh+bpZYSdROT87ADfc6MbVX83
 6Dy0K+2MLAkU85CdvpRmVRGfFcu155o=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-MQfsB5YVO2Og71Mp39DbxA-1; Wed, 04 Oct 2023 04:43:58 -0400
X-MC-Unique: MQfsB5YVO2Og71Mp39DbxA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5056eada207so1737905e87.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:43:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409036; x=1697013836;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XPImF4K2pL45lQ4EfG0s+CTn23uOSVuTqBqWIA624PQ=;
 b=tpyfUdM3jBzW6r0/uSb+sNHVN3Cagh0prQsN+Xu9FTTrlkMcEdQr3UFcmMbC/fhxEA
 wZ+sYDQCmWVdPhydZdVhZ0KdjB/k4xn6JomDDUl9RGfrBAMdQYccnRCfGMPXFndpvtAB
 n1Ai3dqqKrawGinuk3zlJYy9myBimuRToN8Z/z2krzKXq4vIb+x2GCsmjSKfBcVFv7Hg
 hblVvYMFd6H9+xlXMbHXPLgOQwa3hVS4KCA43GhEnIGZW47HpFDaqnX+2+819n5SLdPm
 OAmXAo5UVtb+rHkrRjpw76Il68jtOnC8Y4KKk/LZpETZVhOxDqIqLrtE89dmScZGrAce
 OYrg==
X-Gm-Message-State: AOJu0YzJP6WgIcTC0SvUr25tkKCrlpGjLCmGhP/NR3VLyzydj46uqRfg
 ewTgJDLp2Z+vxfFyD23YVTtHjc/BMEP4pKWkcG/gDqSvIp9bMMXRTxvVTzM4t1m7ZvAkoUDFRi7
 yZgM/zOInG9f61NeRl+f1fXzUmjGWWs1Lq/pBbfuN7m5eGf590n2nvjpLWOTaKP+DT/2q
X-Received: by 2002:a19:5f5b:0:b0:502:adbc:9b74 with SMTP id
 a27-20020a195f5b000000b00502adbc9b74mr1175168lfj.68.1696409036339; 
 Wed, 04 Oct 2023 01:43:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDA6TouP/WvN4eqYpa5F0N11tR48g0FbCQvSIFO3E9LVcceE7uQzXJHDwZRyitmCrxGjOxxg==
X-Received: by 2002:a19:5f5b:0:b0:502:adbc:9b74 with SMTP id
 a27-20020a195f5b000000b00502adbc9b74mr1175151lfj.68.1696409036050; 
 Wed, 04 Oct 2023 01:43:56 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 n16-20020a05600c3b9000b0040684abb623sm804633wms.24.2023.10.04.01.43.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:43:55 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:43:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ilya Maximets <i.maximets@ovn.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 14/63] virtio: don't zero out memory region cache for indirect
 descriptors
Message-ID: <219e986b0191c7e315bec4e011e2e8c188b5f025.1696408966.git.mst@redhat.com>
References: <cover.1696408966.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696408966.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Ilya Maximets <i.maximets@ovn.org>

Lots of virtio functions that are on a hot path in data transmission
are initializing indirect descriptor cache at the point of stack
allocation.  It's a 112 byte structure that is getting zeroed out on
each call adding unnecessary overhead.  It's going to be correctly
initialized later via special init function.  The only reason to
actually initialize right away is the ability to safely destruct it.
Replacing a designated initializer with a function to only initialize
what is necessary.

Removal of the unnecessary stack initializations improves throughput
of virtio-net devices in terms of 64B packets per second by 6-14 %
depending on the case.  Tested with a proposed af-xdp network backend
and a dpdk testpmd application in the guest, but should be beneficial
for other virtio devices as well.

Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
Message-Id: <20230811143423.3258788-1-i.maximets@ovn.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/exec/memory.h | 16 +++++++++++++---
 hw/virtio/virtio.c    | 20 +++++++++++++++-----
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index ef23d65afc..c99842d2fc 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2671,9 +2671,6 @@ struct MemoryRegionCache {
     bool is_write;
 };
 
-#define MEMORY_REGION_CACHE_INVALID ((MemoryRegionCache) { .mrs.mr = NULL })
-
-
 /* address_space_ld*_cached: load from a cached #MemoryRegion
  * address_space_st*_cached: store into a cached #MemoryRegion
  *
@@ -2762,6 +2759,19 @@ int64_t address_space_cache_init(MemoryRegionCache *cache,
                                  hwaddr len,
                                  bool is_write);
 
+/**
+ * address_space_cache_init_empty: Initialize empty #MemoryRegionCache
+ *
+ * @cache: The #MemoryRegionCache to operate on.
+ *
+ * Initializes #MemoryRegionCache structure without memory region attached.
+ * Cache initialized this way can only be safely destroyed, but not used.
+ */
+static inline void address_space_cache_init_empty(MemoryRegionCache *cache)
+{
+    cache->mrs.mr = NULL;
+}
+
 /**
  * address_space_cache_invalidate: complete a write to a #MemoryRegionCache
  *
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 4577f3f5b3..d3a22e3d36 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1071,10 +1071,12 @@ static void virtqueue_split_get_avail_bytes(VirtQueue *vq,
     VirtIODevice *vdev = vq->vdev;
     unsigned int idx;
     unsigned int total_bufs, in_total, out_total;
-    MemoryRegionCache indirect_desc_cache = MEMORY_REGION_CACHE_INVALID;
+    MemoryRegionCache indirect_desc_cache;
     int64_t len = 0;
     int rc;
 
+    address_space_cache_init_empty(&indirect_desc_cache);
+
     idx = vq->last_avail_idx;
     total_bufs = in_total = out_total = 0;
 
@@ -1207,12 +1209,14 @@ static void virtqueue_packed_get_avail_bytes(VirtQueue *vq,
     VirtIODevice *vdev = vq->vdev;
     unsigned int idx;
     unsigned int total_bufs, in_total, out_total;
+    MemoryRegionCache indirect_desc_cache;
     MemoryRegionCache *desc_cache;
-    MemoryRegionCache indirect_desc_cache = MEMORY_REGION_CACHE_INVALID;
     int64_t len = 0;
     VRingPackedDesc desc;
     bool wrap_counter;
 
+    address_space_cache_init_empty(&indirect_desc_cache);
+
     idx = vq->last_avail_idx;
     wrap_counter = vq->last_avail_wrap_counter;
     total_bufs = in_total = out_total = 0;
@@ -1487,7 +1491,7 @@ static void *virtqueue_split_pop(VirtQueue *vq, size_t sz)
 {
     unsigned int i, head, max;
     VRingMemoryRegionCaches *caches;
-    MemoryRegionCache indirect_desc_cache = MEMORY_REGION_CACHE_INVALID;
+    MemoryRegionCache indirect_desc_cache;
     MemoryRegionCache *desc_cache;
     int64_t len;
     VirtIODevice *vdev = vq->vdev;
@@ -1498,6 +1502,8 @@ static void *virtqueue_split_pop(VirtQueue *vq, size_t sz)
     VRingDesc desc;
     int rc;
 
+    address_space_cache_init_empty(&indirect_desc_cache);
+
     RCU_READ_LOCK_GUARD();
     if (virtio_queue_empty_rcu(vq)) {
         goto done;
@@ -1624,7 +1630,7 @@ static void *virtqueue_packed_pop(VirtQueue *vq, size_t sz)
 {
     unsigned int i, max;
     VRingMemoryRegionCaches *caches;
-    MemoryRegionCache indirect_desc_cache = MEMORY_REGION_CACHE_INVALID;
+    MemoryRegionCache indirect_desc_cache;
     MemoryRegionCache *desc_cache;
     int64_t len;
     VirtIODevice *vdev = vq->vdev;
@@ -1636,6 +1642,8 @@ static void *virtqueue_packed_pop(VirtQueue *vq, size_t sz)
     uint16_t id;
     int rc;
 
+    address_space_cache_init_empty(&indirect_desc_cache);
+
     RCU_READ_LOCK_GUARD();
     if (virtio_queue_packed_empty_rcu(vq)) {
         goto done;
@@ -3970,13 +3978,15 @@ VirtioQueueElement *qmp_x_query_virtio_queue_element(const char *path,
     } else {
         unsigned int head, i, max;
         VRingMemoryRegionCaches *caches;
-        MemoryRegionCache indirect_desc_cache = MEMORY_REGION_CACHE_INVALID;
+        MemoryRegionCache indirect_desc_cache;
         MemoryRegionCache *desc_cache;
         VRingDesc desc;
         VirtioRingDescList *list = NULL;
         VirtioRingDescList *node;
         int rc; int ndescs;
 
+        address_space_cache_init_empty(&indirect_desc_cache);
+
         RCU_READ_LOCK_GUARD();
 
         max = vq->vring.num;
-- 
MST


