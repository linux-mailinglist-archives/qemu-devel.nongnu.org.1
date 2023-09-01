Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 212AB78FD1C
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 14:24:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc3BV-0000V3-5v; Fri, 01 Sep 2023 08:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qc3BS-0000Oy-2O
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 08:23:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qc3BP-0007EY-TO
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 08:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693571007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=HpDc0+/XXYKR0NtBCGyPSKv38OLN2dLh3nwWw6zVwyY=;
 b=G4VAsVqQ7mk9HF7ZjhYuI0LshhlagzFxAQZAHq/R707T2zfITZ//tjIEH7pHt8knTpg63v
 Klp0oHnrBOpp0t9zAvlRCzN0AtwvfHHz0mZSj6rDKXDQpQb8VZrYdHQl3w9a+KmMckDT+3
 d0bdt1fTrQWEcsV65N/kMD3YkZK3Yoc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-Tipm5M9hPUCj-yyxNcSqjA-1; Fri, 01 Sep 2023 08:23:25 -0400
X-MC-Unique: Tipm5M9hPUCj-yyxNcSqjA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 94A7D1817908
 for <qemu-devel@nongnu.org>; Fri,  1 Sep 2023 12:23:25 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.141])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 973CD83B7A;
 Fri,  1 Sep 2023 12:23:24 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Albert Esteve <aesteve@redhat.com>
Subject: [PATCH] hw/virtio/vhost: check nvqs at dev_start
Date: Fri,  1 Sep 2023 14:23:23 +0200
Message-ID: <20230901122323.66183-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
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

While this is not expected to happen, it could still
be that a vhost_dev did not set its nvqs member.

Since `vhost_dev_start` access the device's vqs array
later without checking its size, it would cause a
Segmentation fault when nvqs is 0.

To avoid this `rare` case and made the code safer,
add a clause that ensures nvqs has been set, and
warn the user if it has not.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 hw/virtio/vhost.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index e2f6ffb446..78805fe5b7 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1935,6 +1935,11 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
     hdev->started = true;
     hdev->vdev = vdev;
 
+    if (!hdev->nvqs) {
+        error_report("device nvqs not set");
+        goto fail_nvqs;
+    }
+
     r = vhost_dev_set_features(hdev, hdev->log_enabled);
     if (r < 0) {
         goto fail_features;
@@ -2028,6 +2033,7 @@ fail_mem:
     if (vhost_dev_has_iommu(hdev)) {
         memory_listener_unregister(&hdev->iommu_listener);
     }
+fail_nvqs:
 fail_features:
     vdev->vhost_started = false;
     hdev->started = false;
-- 
2.41.0


