Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CE27A5F9F
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 12:32:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiY1l-0004r2-Ud; Tue, 19 Sep 2023 06:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qiY0H-00037T-Hx
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 06:30:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qiY0F-0001xg-7Q
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 06:30:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695119446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tNEhNaDV6xvJCqwzhjc+fWixEBd8DMV8k/lJMTAm+HE=;
 b=MU2wKcEcdnK+jMQdyjLB/Z8cP5qgkI2UXyZr/BnQ9M2MGcukO4FMYCLljtrNUa71SeJ3By
 KA1OfBqBVn0CuSqdmHU4+JxczAQQy7dkHOt+3n73DfOpKxxOkt67SQA4JNqUAYuV5qoArw
 iITkjb6oVuGClLJrbcKdvLQ/HBzysWA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-nxVTzubYNJuPyTXC1_1-kA-1; Tue, 19 Sep 2023 06:30:42 -0400
X-MC-Unique: nxVTzubYNJuPyTXC1_1-kA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C93485A5A8;
 Tue, 19 Sep 2023 10:30:42 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.194.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8482540C6EC0;
 Tue, 19 Sep 2023 10:30:41 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 hongmianquan <hongmianquan@bytedance.com>, Peter Xu <peterx@redhat.com>
Subject: [GIT PULL 12/12] memory: avoid updating ioeventfds for some
 address_space
Date: Tue, 19 Sep 2023 12:30:29 +0200
Message-ID: <20230919103029.235736-13-david@redhat.com>
In-Reply-To: <20230919103029.235736-1-david@redhat.com>
References: <20230919103029.235736-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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

From: hongmianquan <hongmianquan@bytedance.com>

When updating ioeventfds, we need to iterate all address spaces,
but some address spaces do not register eventfd_add|del call when
memory_listener_register() and they do nothing when updating ioeventfds.
So we can skip these AS in address_space_update_ioeventfds().

The overhead of memory_region_transaction_commit() can be significantly
reduced. For example, a VM with 8 vhost net devices and each one has
64 vectors, can reduce the time spent on memory_region_transaction_commit by 20%.

Message-ID: <20230830032906.12488-1-hongmianquan@bytedance.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: hongmianquan <hongmianquan@bytedance.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/exec/memory.h |  1 +
 softmmu/memory.c      | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index cc68249eda..ef23d65afc 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1095,6 +1095,7 @@ struct AddressSpace {
     struct FlatView *current_map;
 
     int ioeventfd_nb;
+    int ioeventfd_notifiers;
     struct MemoryRegionIoeventfd *ioeventfds;
     QTAILQ_HEAD(, MemoryListener) listeners;
     QTAILQ_ENTRY(AddressSpace) address_spaces_link;
diff --git a/softmmu/memory.c b/softmmu/memory.c
index 2cb60ec9b8..c0383a163d 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -842,6 +842,10 @@ static void address_space_update_ioeventfds(AddressSpace *as)
     AddrRange tmp;
     unsigned i;
 
+    if (!as->ioeventfd_notifiers) {
+        return;
+    }
+
     /*
      * It is likely that the number of ioeventfds hasn't changed much, so use
      * the previous size as the starting value, with some headroom to avoid
@@ -3075,6 +3079,10 @@ void memory_listener_register(MemoryListener *listener, AddressSpace *as)
     }
 
     listener_add_address_space(listener, as);
+
+    if (listener->eventfd_add || listener->eventfd_del) {
+        as->ioeventfd_notifiers++;
+    }
 }
 
 void memory_listener_unregister(MemoryListener *listener)
@@ -3083,6 +3091,10 @@ void memory_listener_unregister(MemoryListener *listener)
         return;
     }
 
+    if (listener->eventfd_add || listener->eventfd_del) {
+        listener->address_space->ioeventfd_notifiers--;
+    }
+
     listener_del_address_space(listener, listener->address_space);
     QTAILQ_REMOVE(&memory_listeners, listener, link);
     QTAILQ_REMOVE(&listener->address_space->listeners, listener, link_as);
-- 
2.41.0


