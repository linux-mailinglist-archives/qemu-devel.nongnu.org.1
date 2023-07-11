Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E59F974F41C
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 17:53:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJFfk-0000h5-17; Tue, 11 Jul 2023 11:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qJFfh-0000gO-LS
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 11:53:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qJFfg-0001jm-21
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 11:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689090778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GeXzhglug7/8XQU7aDNDJiWbUUC2zz5wdaGpy7Xt+AY=;
 b=ZRzch7bOE/LY9yTB8Khbo5oZgc0wpw0j+kJFDsMVRe5K2+zqMnE8qv9HCfIqIalbFuYGK2
 V1KDvRbYirk7Ha5oaC3tdzWYETSiKOCcoHVw26BZMW/YaWG+aihHD8bbNV2m+iYYWPg3Gy
 +LKQpBIBY+A+0A5Zr4FEiFdJlx2rxGk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-Bu-FCH0bMYmVPuW2KLTqyg-1; Tue, 11 Jul 2023 11:52:57 -0400
X-MC-Unique: Bu-FCH0bMYmVPuW2KLTqyg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E5BB51043AC5
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 15:52:56 +0000 (UTC)
Received: from localhost (unknown [10.39.192.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B8727F66B9;
 Tue, 11 Jul 2023 15:37:26 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Czenczek <hreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>
Subject: [PATCH 5/6] vhost-vdpa: Match vhost-user's status reset
Date: Tue, 11 Jul 2023 17:52:27 +0200
Message-ID: <20230711155230.64277-6-hreitz@redhat.com>
In-Reply-To: <20230711155230.64277-1-hreitz@redhat.com>
References: <20230711155230.64277-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

vhost-vdpa and vhost-user differ in how they reset the status in their
respective vhost_reset_status implementations: vhost-vdpa zeroes it,
then re-adds the S_ACKNOWLEDGE and S_DRIVER config bits.  S_DRIVER_OK is
then set in vhost_vdpa_dev_start().

vhost-user in contrast just zeroes the status, and does no re-add any
config bits until vhost_user_dev_start() (where it does re-add all of
S_ACKNOWLEDGE, S_DRIVER, and S_DRIVER_OK).

There is no documentation for vhost_reset_status, but its only caller is
vhost_dev_stop().  So apparently, the device is to be stopped after
vhost_reset_status, and therefore it makes more sense to keep the status
field fully cleared until the back-end is re-started, which is how
vhost-user does it.  Make vhost-vdpa do the same -- if nothing else it's
confusing to have both vhost implementations handle this differently.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 hw/virtio/vhost-vdpa.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index f7fd19a203..0cde8b40de 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -1294,8 +1294,6 @@ static void vhost_vdpa_reset_status(struct vhost_dev *dev)
     }
 
     vhost_vdpa_reset_device(dev);
-    vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE |
-                               VIRTIO_CONFIG_S_DRIVER);
     memory_listener_unregister(&v->listener);
 }
 
@@ -1334,7 +1332,9 @@ static int vhost_vdpa_dev_start(struct vhost_dev *dev, bool started)
         }
         memory_listener_register(&v->listener, dev->vdev->dma_as);
 
-        return vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
+        return vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE |
+                                          VIRTIO_CONFIG_S_DRIVER |
+                                          VIRTIO_CONFIG_S_DRIVER_OK);
     }
 
     return 0;
-- 
2.41.0


