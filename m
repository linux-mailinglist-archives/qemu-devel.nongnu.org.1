Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7E57AF3A8
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 21:02:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlDIB-0001v0-Ay; Tue, 26 Sep 2023 15:00:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qlDHl-0001O5-97
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 14:59:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qlDHj-0003EA-E0
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 14:59:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695754790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=adaLIN+oCidzf9Yl1V7wtFZZqNM0t8YdJyA6CFGysIY=;
 b=M2MP9cjadlp5ycdvKQVxLLyeYFRoIdINtm+WBucT3RUQj1v1ve/WLf8FFRskS38NQAVG34
 c7QMP2/ejWIrwKELLLi9mO08wjVoDqIFt7s9cWq1VJDMMSvzzsDJVfbXlpUNaLP2VeJQkK
 9wfDAWOEYuo2PtsnAVNIvVSj5JEaP5M=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-x1igqqiVPtOTFGoR0hcyVg-1; Tue, 26 Sep 2023 14:59:47 -0400
X-MC-Unique: x1igqqiVPtOTFGoR0hcyVg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 140603C0BE3C;
 Tue, 26 Sep 2023 18:59:47 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9FBBE2026D4B;
 Tue, 26 Sep 2023 18:59:41 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Michal Privoznik <mprivozn@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gavin Shan <gshan@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>, kvm@vger.kernel.org
Subject: [PATCH v4 14/18] virtio-mem: Pass non-const VirtIOMEM via
 virtio_mem_range_cb
Date: Tue, 26 Sep 2023 20:57:34 +0200
Message-ID: <20230926185738.277351-15-david@redhat.com>
In-Reply-To: <20230926185738.277351-1-david@redhat.com>
References: <20230926185738.277351-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


