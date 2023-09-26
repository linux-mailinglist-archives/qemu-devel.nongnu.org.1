Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 547FE7AF3A6
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 21:02:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlDIL-0002M2-5l; Tue, 26 Sep 2023 15:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qlDI8-0001to-8e
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 15:00:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qlDI4-0003Uq-Ix
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 15:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695754811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jAvglJj91/o8R3ulPUvMP06jx5ezTDNURc+rL2BIGo4=;
 b=hR12PzKXXvgb//rP8/f7FQccH0FZyKQbaawQnhzy2V+TVcxtJRRVw2KKXx+SYqNZOyT8Ro
 5EE4TTfACEKDkiFVFP0UbCGnrIPUetn+m6flyA9GOQMdfJ+qEczZxyWzHo4ju6C7Z+Qs/v
 KcrmJg5mJ+eLK0qbyMEAxfuXirZxXhg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-281-t_nnSmVvNL-nvOoa5tOcxg-1; Tue, 26 Sep 2023 15:00:07 -0400
X-MC-Unique: t_nnSmVvNL-nvOoa5tOcxg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1DE3E811E8E;
 Tue, 26 Sep 2023 19:00:07 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B9B372026D4B;
 Tue, 26 Sep 2023 19:00:02 +0000 (UTC)
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
Subject: [PATCH v4 18/18] virtio-mem: Mark memslot alias memory regions
 unmergeable
Date: Tue, 26 Sep 2023 20:57:38 +0200
Message-ID: <20230926185738.277351-19-david@redhat.com>
In-Reply-To: <20230926185738.277351-1-david@redhat.com>
References: <20230926185738.277351-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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

Let's mark the memslot alias memory regions as unmergable, such that
flatview and vhost won't merge adjacent memory region aliases and we can
atomically map/unmap individual aliases without affecting adjacent
alias memory regions.

This handles vhost and vfio in multiple-memslot mode correctly (which do
not support atomic memslot updates) and avoids the temporary removal of
large memslots, which can be an expensive operation. For example, vfio
might have to unpin + repin a lot of memory, which is undesired.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-mem.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index e1e4250e69..9dc3c61b5a 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -940,6 +940,12 @@ static void virtio_mem_prepare_memslots(VirtIOMEM *vmem)
         memory_region_init_alias(&vmem->memslots[idx], OBJECT(vmem), name,
                                  &vmem->memdev->mr, memslot_offset,
                                  memslot_size);
+        /*
+         * We want to be able to atomically and efficiently activate/deactivate
+         * individual memslots without affecting adjacent memslots in memory
+         * notifiers.
+         */
+        memory_region_set_unmergeable(&vmem->memslots[idx], true);
     }
 }
 
-- 
2.41.0


