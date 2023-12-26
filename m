Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B1481E65A
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Dec 2023 10:26:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rI3gk-0004TO-91; Tue, 26 Dec 2023 04:25:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rI3gg-0004Gv-9l
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 04:25:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rI3ge-000091-JC
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 04:25:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703582720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M5QGJ+eIeZAekNiSAn72joJJNqpG535Ykhgx4/GAM48=;
 b=BBUZpdM7hadzNgvKvg3ufEgx8GFbK9jurfxf0Jqiu7Ik/1YaVfv/8jDBf2lWxsbnsn6Exf
 Gw2LPJAyrMr6cUvVtnzTHoyT/obdeYw1LoM2OG4aTSBO1Zhv9XaLOtNG7rPVzvc4XRauVl
 EUZRaWOq0o1rlW/CBodsG99JJ4Y/ZRc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-FnKprD_aNoiMvaYgueS5XQ-1; Tue, 26 Dec 2023 04:25:18 -0500
X-MC-Unique: FnKprD_aNoiMvaYgueS5XQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40d2fa6b23eso47176955e9.2
 for <qemu-devel@nongnu.org>; Tue, 26 Dec 2023 01:25:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703582717; x=1704187517;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M5QGJ+eIeZAekNiSAn72joJJNqpG535Ykhgx4/GAM48=;
 b=eGueebsttDmv6heCKp/HpI1aAxu9y1VfUCnLBkiBWWA8KdgNfJLc2Zl4N1RbzkNYyu
 ki0ubPwPBHVWp41FwFV0gHujI2o7NcBpJ7zMsTyZjbDZ5O9CgPO9151lWt+o+GyaOWMs
 mDMKN2sQOI8FHKZdNlXziF4e+VJEqbdtOpV7RnN7SO12V89l7NC2OTWeGBFf4PJJsmr9
 xq32Pz7ne4YyNnVNfbXLGXvAthORa9UcwAAPl1J4zd4dKIuaSx7v2eOonpDBbtkdUP9b
 fl7dUSHDCyor86yIu3SSDx//PgUc7kTwm3GwVajKbuJmZU77Atjx1AKYX/jrlxsCT/+e
 APnQ==
X-Gm-Message-State: AOJu0YwDMLTVE+jAV/d0FdCnu5Ja5OEL4k2rCv+85uQ9jCkEF0+Orabe
 W3QI/zo/bf/feVjrmDENO7ai5FzsDM9cppZgmokaPanWewHbzXwiUcsDAEO6t1WH027+17Jc5Sy
 vMdCgr4OcBhz0DKnwYLeiGvtAacvTXQ5p4Ov1iXbO/zSkgYvb8K+37Iq+lmK5DIjQsBen3nU8fE
 lJ
X-Received: by 2002:a05:600c:3412:b0:40d:379a:93a2 with SMTP id
 y18-20020a05600c341200b0040d379a93a2mr3060056wmp.237.1703582716913; 
 Tue, 26 Dec 2023 01:25:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7NJIV0ZMPmyaMzls7wxGV7TFfjjRkBgGKMNMGpaCQSXbQxHU7w+cuaSj6C+58sPEluYlrwA==
X-Received: by 2002:a05:600c:3412:b0:40d:379a:93a2 with SMTP id
 y18-20020a05600c341200b0040d379a93a2mr3060047wmp.237.1703582716497; 
 Tue, 26 Dec 2023 01:25:16 -0800 (PST)
Received: from redhat.com ([2.55.177.189]) by smtp.gmail.com with ESMTPSA id
 h5-20020a05600c314500b0040b2a52ecaasm27801153wmo.2.2023.12.26.01.25.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 01:25:15 -0800 (PST)
Date: Tue, 26 Dec 2023 04:25:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Lei Yang <leiyang@redhat.com>
Subject: [PULL 18/21] vdpa: move iommu_list to vhost_vdpa_shared
Message-ID: <8e0139ee409fcbedc940b61d09c022657e26bab3.1703582625.git.mst@redhat.com>
References: <cover.1703582625.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1703582625.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.977,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Eugenio Pérez <eperezma@redhat.com>

Next patches will register the vhost_vdpa memory listener while the VM
is migrating at the destination, so we can map the memory to the device
before stopping the VM at the source.  The main goal is to reduce the
downtime.

However, the destination QEMU is unaware of which vhost_vdpa device will
register its memory_listener.  If the source guest has CVQ enabled, it
will be the CVQ device.  Otherwise, it  will be the first one.

Move the iommu_list member to VhostVDPAShared so all vhost_vdpa can use
it, rather than always in the first / last vhost_vdpa.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20231221174322.3130442-11-eperezma@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost-vdpa.h | 2 +-
 hw/virtio/vhost-vdpa.c         | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
index 5bd964dac5..3880b9e7f2 100644
--- a/include/hw/virtio/vhost-vdpa.h
+++ b/include/hw/virtio/vhost-vdpa.h
@@ -34,6 +34,7 @@ typedef struct VhostVDPAHostNotifier {
 typedef struct vhost_vdpa_shared {
     int device_fd;
     struct vhost_vdpa_iova_range iova_range;
+    QLIST_HEAD(, vdpa_iommu) iommu_list;
 
     /* IOVA mapping used by the Shadow Virtqueue */
     VhostIOVATree *iova_tree;
@@ -62,7 +63,6 @@ typedef struct vhost_vdpa {
     struct vhost_dev *dev;
     Error *migration_blocker;
     VhostVDPAHostNotifier notifier[VIRTIO_QUEUE_MAX];
-    QLIST_HEAD(, vdpa_iommu) iommu_list;
     IOMMUNotifier n;
 } VhostVDPA;
 
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index cbfcf18883..a2713b9f0b 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -279,7 +279,7 @@ static void vhost_vdpa_iommu_region_add(MemoryListener *listener,
         return;
     }
 
-    QLIST_INSERT_HEAD(&v->iommu_list, iommu, iommu_next);
+    QLIST_INSERT_HEAD(&v->shared->iommu_list, iommu, iommu_next);
     memory_region_iommu_replay(iommu->iommu_mr, &iommu->n);
 
     return;
@@ -292,7 +292,7 @@ static void vhost_vdpa_iommu_region_del(MemoryListener *listener,
 
     struct vdpa_iommu *iommu;
 
-    QLIST_FOREACH(iommu, &v->iommu_list, iommu_next)
+    QLIST_FOREACH(iommu, &v->shared->iommu_list, iommu_next)
     {
         if (MEMORY_REGION(iommu->iommu_mr) == section->mr &&
             iommu->n.start == section->offset_within_region) {
-- 
MST


