Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D36F87C706A
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 16:37:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqwoU-0002r8-9k; Thu, 12 Oct 2023 10:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qqwoR-0002oW-L5
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:37:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qqwoP-0005hG-Hk
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697121436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xPlwpV7YUakNqvQHq0hhNEPksYu4ihQPL5w7gfIQSzU=;
 b=YZ7iNEoD//TFr6YSQ65Su12LqckkxpLvCZZGxvjEt6JWIjR1YP1Ni0AhRIEC9WMoBwqhw3
 +3EtCqNf/qKfnyMRBj2R7+MxkONW2l+KfF4KBzFOAipXDhefFDvHq9fvd0C75rXVPGZFkF
 yj0uXIyCu6/mKjpHMm6kbJnKVKBWr0E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-115-m2888XtNPCKP5KcWRCVBGQ-1; Thu, 12 Oct 2023 10:37:13 -0400
X-MC-Unique: m2888XtNPCKP5KcWRCVBGQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B63B4862F4E;
 Thu, 12 Oct 2023 14:37:12 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.176])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E61461C060DF;
 Thu, 12 Oct 2023 14:37:11 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [GIT PULL 14/18] virtio-mem: Pass non-const VirtIOMEM via
 virtio_mem_range_cb
Date: Thu, 12 Oct 2023 16:36:51 +0200
Message-ID: <20231012143655.114631-15-david@redhat.com>
In-Reply-To: <20231012143655.114631-1-david@redhat.com>
References: <20231012143655.114631-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Let's prepare for a user that has to modify the VirtIOMEM device state.

Message-ID: <20230926185738.277351-15-david@redhat.com>
Reviewed-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-mem.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index da5b09cefc..0b0e6c5090 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -177,10 +177,10 @@ static bool virtio_mem_is_busy(void)
     return migration_in_incoming_postcopy() || !migration_is_idle();
 }
 
-typedef int (*virtio_mem_range_cb)(const VirtIOMEM *vmem, void *arg,
+typedef int (*virtio_mem_range_cb)(VirtIOMEM *vmem, void *arg,
                                    uint64_t offset, uint64_t size);
 
-static int virtio_mem_for_each_unplugged_range(const VirtIOMEM *vmem, void *arg,
+static int virtio_mem_for_each_unplugged_range(VirtIOMEM *vmem, void *arg,
                                                virtio_mem_range_cb cb)
 {
     unsigned long first_zero_bit, last_zero_bit;
@@ -204,7 +204,7 @@ static int virtio_mem_for_each_unplugged_range(const VirtIOMEM *vmem, void *arg,
     return ret;
 }
 
-static int virtio_mem_for_each_plugged_range(const VirtIOMEM *vmem, void *arg,
+static int virtio_mem_for_each_plugged_range(VirtIOMEM *vmem, void *arg,
                                              virtio_mem_range_cb cb)
 {
     unsigned long first_bit, last_bit;
@@ -969,7 +969,7 @@ static void virtio_mem_device_unrealize(DeviceState *dev)
     ram_block_coordinated_discard_require(false);
 }
 
-static int virtio_mem_discard_range_cb(const VirtIOMEM *vmem, void *arg,
+static int virtio_mem_discard_range_cb(VirtIOMEM *vmem, void *arg,
                                        uint64_t offset, uint64_t size)
 {
     RAMBlock *rb = vmem->memdev->mr.ram_block;
@@ -1021,7 +1021,7 @@ static int virtio_mem_post_load(void *opaque, int version_id)
     return virtio_mem_restore_unplugged(vmem);
 }
 
-static int virtio_mem_prealloc_range_cb(const VirtIOMEM *vmem, void *arg,
+static int virtio_mem_prealloc_range_cb(VirtIOMEM *vmem, void *arg,
                                         uint64_t offset, uint64_t size)
 {
     void *area = memory_region_get_ram_ptr(&vmem->memdev->mr) + offset;
-- 
2.41.0


