Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5780F79E11E
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 09:48:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgKao-0003Fq-Ab; Wed, 13 Sep 2023 03:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qgKaf-0003FQ-TU
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 03:47:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qgKad-000630-J1
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 03:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694591223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=I5eMpr2L+oDdbAVnMFYihTm1RKGCWAkzGk6JihsOgwQ=;
 b=gfVpklRWF9dnGo3ZjUOZ1OnGviTIquQfsGNjAQ2sx6CYWQ9QOYb5ap8lMGhIPSLt55qlOU
 t6cihi4KsXMBuawzNaXrDap+AtzEmCbCoWig7Y4PX9TaWieyPCWDTPPKfL38hL9XU4CoHA
 RhehwCoce2cMrF1tMf9ghgiX42CoY7Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-qcWGqic5OH2ogHhqfJTogw-1; Wed, 13 Sep 2023 03:47:02 -0400
X-MC-Unique: qcWGqic5OH2ogHhqfJTogw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C4C128A12B9;
 Wed, 13 Sep 2023 07:47:01 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.192.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 62617422E0;
 Wed, 13 Sep 2023 07:47:00 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org
Cc: jasowang@redhat.com,
	lvivier@redhat.com
Subject: [PATCH] vhost: Add a defensive check in vhost_commit against wrong
 deallocation
Date: Wed, 13 Sep 2023 09:46:57 +0200
Message-ID: <20230913074657.523530-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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

In vhost_commit(), it may happen that dev->mem_sections and
dev->tmp_sections are equal, in which case, unconditionally
freeing old_sections at the end of the function will also free
dev->mem_sections used on subsequent call leading to a segmentation
fault.

Check this situation before deallocating memory.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Fixes: c44317efecb2 ("vhost: Build temporary section list and deref
after commit")
CC: QEMU Stable <qemu-stable@nongnu.org>

---

This SIGSEV condition can be reproduced with
https://lore.kernel.org/all/20230904080451.424731-1-eric.auger@redhat.com/#r
This is most probably happening in a situation where the memory API is
used in a wrong manner but well.
---
 hw/virtio/vhost.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index e2f6ffb446..c02c599ef0 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -545,6 +545,11 @@ static void vhost_commit(MemoryListener *listener)
     dev->mem_sections = dev->tmp_sections;
     dev->n_mem_sections = dev->n_tmp_sections;
 
+    if (old_sections == dev->mem_sections) {
+        assert(n_old_sections ==  dev->n_mem_sections);
+        return;
+    }
+
     if (dev->n_mem_sections != n_old_sections) {
         changed = true;
     } else {
-- 
2.41.0


