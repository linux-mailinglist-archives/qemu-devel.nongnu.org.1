Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BF97C7076
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 16:39:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqwoR-0002nw-2c; Thu, 12 Oct 2023 10:37:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qqwoN-0002km-PA
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:37:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qqwoM-0005gZ-8k
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697121433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dSAofz879I4xJBI7jfHjOsBuQYUBWNaxQb8jQNCKeA4=;
 b=bR9kKq8q19LutsrWL8Mv1Kpce/HpIdUd176K6JD23qgN6/DjRA2arQGrZYnqyjpzszIZXE
 XPFd94uoYK5dNmOWoMH19DO1+LrHjHLQqEO79iJ+2dAiLhCV9f/ggYjyelKImQV1WR4Pnn
 nS7zEElvhBSLBW9L9cbW2Ow4l7DONG4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-662-ki2vUOPqNfKw1o20-exwRA-1; Thu, 12 Oct 2023 10:37:09 -0400
X-MC-Unique: ki2vUOPqNfKw1o20-exwRA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 842A23826D3A;
 Thu, 12 Oct 2023 14:37:09 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.176])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B139F1C06536;
 Thu, 12 Oct 2023 14:37:08 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [GIT PULL 11/18] vhost: Add vhost_get_max_memslots()
Date: Thu, 12 Oct 2023 16:36:48 +0200
Message-ID: <20231012143655.114631-12-david@redhat.com>
In-Reply-To: <20231012143655.114631-1-david@redhat.com>
References: <20231012143655.114631-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
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

Let's add vhost_get_max_memslots().

Message-ID: <20230926185738.277351-12-david@redhat.com>
Reviewed-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/vhost-stub.c    |  5 +++++
 hw/virtio/vhost.c         | 11 +++++++++++
 include/hw/virtio/vhost.h |  1 +
 3 files changed, 17 insertions(+)

diff --git a/hw/virtio/vhost-stub.c b/hw/virtio/vhost-stub.c
index d53dd9d288..52d42adab2 100644
--- a/hw/virtio/vhost-stub.c
+++ b/hw/virtio/vhost-stub.c
@@ -2,6 +2,11 @@
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/vhost-user.h"
 
+unsigned int vhost_get_max_memslots(void)
+{
+    return UINT_MAX;
+}
+
 unsigned int vhost_get_free_memslots(void)
 {
     return UINT_MAX;
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 041a05d5f1..2bdb4fb231 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -55,6 +55,17 @@ static unsigned int used_shared_memslots;
 static QLIST_HEAD(, vhost_dev) vhost_devices =
     QLIST_HEAD_INITIALIZER(vhost_devices);
 
+unsigned int vhost_get_max_memslots(void)
+{
+    unsigned int max = UINT_MAX;
+    struct vhost_dev *hdev;
+
+    QLIST_FOREACH(hdev, &vhost_devices, entry) {
+        max = MIN(max, hdev->vhost_ops->vhost_backend_memslots_limit(hdev));
+    }
+    return max;
+}
+
 unsigned int vhost_get_free_memslots(void)
 {
     unsigned int free = UINT_MAX;
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 603bf834be..c7e5467693 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -315,6 +315,7 @@ uint64_t vhost_get_features(struct vhost_dev *hdev, const int *feature_bits,
  */
 void vhost_ack_features(struct vhost_dev *hdev, const int *feature_bits,
                         uint64_t features);
+unsigned int vhost_get_max_memslots(void);
 unsigned int vhost_get_free_memslots(void);
 
 int vhost_net_set_backend(struct vhost_dev *hdev,
-- 
2.41.0


