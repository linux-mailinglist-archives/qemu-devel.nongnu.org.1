Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B99881E65B
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Dec 2023 10:26:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rI3ga-0003bZ-Lu; Tue, 26 Dec 2023 04:25:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rI3gX-0003QT-VU
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 04:25:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rI3gW-00005F-59
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 04:25:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703582711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o+wiRUysJK2+tJ0AobcVOPv/z3/GSAonKn8biwMKrf4=;
 b=FDWXM6irPDK8Ui8pwdW3JaiCgJonwujxQj0WdwN9eeCyRQqdw2c1mvZgA58C4PyvaiOlix
 x1idqzvcwWTb3TBPIQN+viBxpQaK4+aQ8Z1LHhjDY9DbLC5t/QLRnHC4o0Tv9AwkPyCdZa
 5t4xup/h6yoPHBRyflVfK2QLZRYRc4Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-XZmLuou9N1m0MpMhNvfUmQ-1; Tue, 26 Dec 2023 04:25:09 -0500
X-MC-Unique: XZmLuou9N1m0MpMhNvfUmQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40d4a29dca7so32251735e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 Dec 2023 01:25:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703582707; x=1704187507;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o+wiRUysJK2+tJ0AobcVOPv/z3/GSAonKn8biwMKrf4=;
 b=wp8QykSSrnGJ015PjwtRng4+OAyVly087puZIVpoESpV/s4e7HFpSWYB8D+ZUD32/Y
 hqMPOpTV+5yviYfAYVemlJ2AFu/EPgs2aKjwpnfVzkvADBIRqPE6DCEuQrs1TmWMiijr
 0xtWGHHp241smbWWOfxTJlbTI8EpXcAmmPQXxwtrtYsciJbBGm1Hj8URx8wrRDql/P7z
 JmZaM++xLTtVgkKXkLFDu/vtGAuYvOhajjzl8AAKkbM++myLt9hJ0N1YHf7rbDhRam6Q
 /ioGXEqy0MPfkpTBxsORPix19JvqZyOm7mlTh1KKPnbp5QgkY5LO9IrgPidVPesF11lG
 BBkA==
X-Gm-Message-State: AOJu0YyRfnKeAyvidVCpp6VCfhfdvQYIpEwUl4fyOCwphwkq7jXK6+ax
 cqTWd0AVfwHZlVaCmAzJhOZfNcL33GIJ44DXcXmUT2iwYRhHDXoI23HTJbzhowb5ZsXNLXVFwVy
 JU3pY/uh3GrMurZYElI2VmKSDkXWZwE307Fy4fHed/e4V2Gm83AeKszZHHQA7Ih6hvJ2bREWPg/
 YU
X-Received: by 2002:a1c:7714:0:b0:40d:59be:b2e2 with SMTP id
 t20-20020a1c7714000000b0040d59beb2e2mr431242wmi.79.1703582707658; 
 Tue, 26 Dec 2023 01:25:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPQGS/Zy3GFIJi3zERaY5Q1QJURCs2zSAd5Bb30tvbJlvWKJi2N2kSxcKT3FI9u97E0+417Q==
X-Received: by 2002:a1c:7714:0:b0:40d:59be:b2e2 with SMTP id
 t20-20020a1c7714000000b0040d59beb2e2mr431231wmi.79.1703582707379; 
 Tue, 26 Dec 2023 01:25:07 -0800 (PST)
Received: from redhat.com ([2.55.177.189]) by smtp.gmail.com with ESMTPSA id
 k13-20020a05600c1c8d00b0040d3dc52665sm19059502wms.21.2023.12.26.01.25.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 01:25:04 -0800 (PST)
Date: Tue, 26 Dec 2023 04:25:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Lei Yang <leiyang@redhat.com>
Subject: [PULL 15/21] vdpa: move iotlb_batch_begin_sent to vhost_vdpa_shared
Message-ID: <6b8e7650e33d3aee54d5f25159c21d97ebd2322d.1703582625.git.mst@redhat.com>
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

Move the iotlb_batch_begin_sent member to VhostVDPAShared so all
vhost_vdpa can use it, rather than always in the first / last
vhost_vdpa.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20231221174322.3130442-8-eperezma@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost-vdpa.h | 3 ++-
 hw/virtio/vhost-vdpa.c         | 8 ++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
index 796a180afa..05219bbcf7 100644
--- a/include/hw/virtio/vhost-vdpa.h
+++ b/include/hw/virtio/vhost-vdpa.h
@@ -38,6 +38,8 @@ typedef struct vhost_vdpa_shared {
     /* IOVA mapping used by the Shadow Virtqueue */
     VhostIOVATree *iova_tree;
 
+    bool iotlb_batch_begin_sent;
+
     /* Vdpa must send shadow addresses as IOTLB key for data queues, not GPA */
     bool shadow_data;
 } VhostVDPAShared;
@@ -45,7 +47,6 @@ typedef struct vhost_vdpa_shared {
 typedef struct vhost_vdpa {
     int index;
     uint32_t msg_type;
-    bool iotlb_batch_begin_sent;
     uint32_t address_space_id;
     MemoryListener listener;
     uint64_t acked_features;
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 09df150ef2..2ecaedb686 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -162,11 +162,11 @@ static void vhost_vdpa_listener_begin_batch(struct vhost_vdpa *v)
 static void vhost_vdpa_iotlb_batch_begin_once(struct vhost_vdpa *v)
 {
     if (v->dev->backend_cap & (0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH) &&
-        !v->iotlb_batch_begin_sent) {
+        !v->shared->iotlb_batch_begin_sent) {
         vhost_vdpa_listener_begin_batch(v);
     }
 
-    v->iotlb_batch_begin_sent = true;
+    v->shared->iotlb_batch_begin_sent = true;
 }
 
 static void vhost_vdpa_listener_commit(MemoryListener *listener)
@@ -180,7 +180,7 @@ static void vhost_vdpa_listener_commit(MemoryListener *listener)
         return;
     }
 
-    if (!v->iotlb_batch_begin_sent) {
+    if (!v->shared->iotlb_batch_begin_sent) {
         return;
     }
 
@@ -193,7 +193,7 @@ static void vhost_vdpa_listener_commit(MemoryListener *listener)
                      fd, errno, strerror(errno));
     }
 
-    v->iotlb_batch_begin_sent = false;
+    v->shared->iotlb_batch_begin_sent = false;
 }
 
 static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
-- 
MST


