Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5419F7A2435
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 19:04:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhCEE-0007XE-TN; Fri, 15 Sep 2023 13:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qhCEB-0007R0-Ic
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 13:03:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qhCEA-0000bL-47
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 13:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694797413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VmVRSRSAHQO60KH1ReIR3Iv78Lf0S/KPjRrS5RCKBQs=;
 b=FY6870OzYp/dc5974NqXPyj3JCVKVw1rd/DbqvQJAHhNvKcvBOLxAK92y+EfctisaxjVbU
 CZay3ffYJQzy6yfWhQ6xrC91Zbj4ecyX3oVyCyGTSAbcgf8M4tjrsj8rpWRYxTDcRu68IE
 o9p3Iyt8jjoeZPy7J6tlcZFrktdJ724=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-ruxyvtK-MzqJxJ2TAZbfrA-1; Fri, 15 Sep 2023 13:03:30 -0400
X-MC-Unique: ruxyvtK-MzqJxJ2TAZbfrA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C3CA3858F19;
 Fri, 15 Sep 2023 17:03:29 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.192.183])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A5B33167F8;
 Fri, 15 Sep 2023 17:03:28 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Hawkins Jiawei <yin31149@gmail.com>,
 si-wei.liu@oracle.com, Jason Wang <jasowang@redhat.com>,
 Lei Yang <leiyang@redhat.com>
Subject: [PATCH 3/3] vdpa net: follow VirtIO initialization properly at cvq
 isolation probing
Date: Fri, 15 Sep 2023 19:03:22 +0200
Message-Id: <20230915170322.3076956-4-eperezma@redhat.com>
In-Reply-To: <20230915170322.3076956-1-eperezma@redhat.com>
References: <20230915170322.3076956-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
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

This patch solves a few issues.  The most obvious is that the feature
set was done previous to ACKNOWLEDGE | DRIVER status bit set.  Current
vdpa devices are permissive with this, but it is better to follow the
standard.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 net/vhost-vdpa.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 51d8144070..4b30325977 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -1270,8 +1270,7 @@ static int vhost_vdpa_probe_cvq_isolation(int device_fd, uint64_t features,
     uint64_t backend_features;
     int64_t cvq_group;
     uint8_t status = VIRTIO_CONFIG_S_ACKNOWLEDGE |
-                     VIRTIO_CONFIG_S_DRIVER |
-                     VIRTIO_CONFIG_S_FEATURES_OK;
+                     VIRTIO_CONFIG_S_DRIVER;
     int r;
 
     ERRP_GUARD();
@@ -1286,15 +1285,22 @@ static int vhost_vdpa_probe_cvq_isolation(int device_fd, uint64_t features,
         return 0;
     }
 
+    r = ioctl(device_fd, VHOST_VDPA_SET_STATUS, &status);
+    if (unlikely(r)) {
+        error_setg_errno(errp, -r, "Cannot set device status");
+        goto out;
+    }
+
     r = ioctl(device_fd, VHOST_SET_FEATURES, &features);
     if (unlikely(r)) {
-        error_setg_errno(errp, errno, "Cannot set features");
+        error_setg_errno(errp, -r, "Cannot set features");
         goto out;
     }
 
+    status |= VIRTIO_CONFIG_S_FEATURES_OK;
     r = ioctl(device_fd, VHOST_VDPA_SET_STATUS, &status);
     if (unlikely(r)) {
-        error_setg_errno(errp, -r, "Cannot set status");
+        error_setg_errno(errp, -r, "Cannot set device status");
         goto out;
     }
 
-- 
2.39.3


