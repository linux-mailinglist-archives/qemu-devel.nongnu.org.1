Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBECC81E658
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Dec 2023 10:25:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rI3gi-0004Ns-16; Tue, 26 Dec 2023 04:25:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rI3gf-0004Cy-I4
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 04:25:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rI3gc-00006Y-OB
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 04:25:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703582717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5DnbzKStrGIR1igJTyuESQsjBjVqw22u5ZPR3rhCzDg=;
 b=N4qPeSWlBazt4J9hhCeQbvjd96Q6V5ha3mP3T8tJDmQoEKncHArNMC9ip8vEzvOmQo5X6/
 UQM+v/D/PKMb4GV7S8chmTJddJSmN9/vjR+v/uAa1CCx+CoQfjNt2rxnT3y3xR7AvZfdOM
 EYTBvJuoMyRPIVjIRKrEgNI1SW2Pn2I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-r1gcPDeOOSqQUahIlLqCng-1; Tue, 26 Dec 2023 04:25:15 -0500
X-MC-Unique: r1gcPDeOOSqQUahIlLqCng-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40d38c09797so40899975e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 Dec 2023 01:25:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703582714; x=1704187514;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5DnbzKStrGIR1igJTyuESQsjBjVqw22u5ZPR3rhCzDg=;
 b=aYN9XmBTTPn4WYlhpB2vEB8elO1/iigbXEisG2T7+zKwUe1O/XCLar+82y0TUEW0oO
 kJJq0jdcNdklBKLcuiYKN/z2/guDoLwLo862J/NO94S7p95gArM53dbKDWk3LLqycron
 MIBJBFOPj2VxYQv+bfv5SRy6MWaSj9/I6Kdv3+gcwZkyK+j6nI8dxTpQcxMAjzYpsBXn
 IwT23b5Tn3E/ZfJ4pFV8f3zFLymqtCrJW+0XfZdYvNZq3gZyDem3jI3MxuCOQ+X0GZlz
 Cm6LmoZpe3u3YnzJjBM+DeD4LmhdX+rM9EIC11U2hIna9iKvZPIR8+LahTzcpum5YFOf
 M1pw==
X-Gm-Message-State: AOJu0YwVw2WLjYOfhPowyK5tdnY+BJb6ogDWqAbAngeTZPN6xtX26bgZ
 I2UoLizpUgecKffu3YNBcjOj1zGE0KBCIE58iOPUNyIfE8U4U3I9BIYfctVxtO+z3SLbiInXwg2
 XjAXojskzWr4y6lxaaXS6g2BIltTz/X/33w65Gfb/faogoTywERerERQKzKk86FzT55UdxrvjAE
 YC
X-Received: by 2002:a05:600c:3154:b0:40c:330f:f2f9 with SMTP id
 h20-20020a05600c315400b0040c330ff2f9mr3948360wmo.125.1703582714038; 
 Tue, 26 Dec 2023 01:25:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG606jeWW4cg1bSqHq4Ok9u8V3zlru8apZRp4F0L4X0hNP+6gqcb4Qswfht8FFGfU+VVko2fw==
X-Received: by 2002:a05:600c:3154:b0:40c:330f:f2f9 with SMTP id
 h20-20020a05600c315400b0040c330ff2f9mr3948350wmo.125.1703582713680; 
 Tue, 26 Dec 2023 01:25:13 -0800 (PST)
Received: from redhat.com ([2.55.177.189]) by smtp.gmail.com with ESMTPSA id
 fm13-20020a05600c0c0d00b0040b37f107c4sm20307608wmb.16.2023.12.26.01.25.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 01:25:13 -0800 (PST)
Date: Tue, 26 Dec 2023 04:25:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Lei Yang <leiyang@redhat.com>
Subject: [PULL 17/21] vdpa: remove msg type of vhost_vdpa
Message-ID: <fb919c250aacea94ce7bd33c34449856cfea3bf4.1703582625.git.mst@redhat.com>
References: <cover.1703582625.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1703582625.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.977,
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

From: Eugenio Pérez <eperezma@redhat.com>

It is always VHOST_IOTLB_MSG_V2. We can always make it back per
vhost_dev if needed.

This change makes easier for vhost_vdpa_map and unmap not to depend on
vhost_vdpa but only in VhostVDPAShared.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20231221174322.3130442-10-eperezma@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost-vdpa.h | 1 -
 hw/virtio/vhost-vdpa.c         | 9 ++++-----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
index 11ac14085a..5bd964dac5 100644
--- a/include/hw/virtio/vhost-vdpa.h
+++ b/include/hw/virtio/vhost-vdpa.h
@@ -49,7 +49,6 @@ typedef struct vhost_vdpa_shared {
 
 typedef struct vhost_vdpa {
     int index;
-    uint32_t msg_type;
     uint32_t address_space_id;
     MemoryListener listener;
     uint64_t acked_features;
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 99597c3179..cbfcf18883 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -93,7 +93,7 @@ int vhost_vdpa_dma_map(struct vhost_vdpa *v, uint32_t asid, hwaddr iova,
     int fd = v->shared->device_fd;
     int ret = 0;
 
-    msg.type = v->msg_type;
+    msg.type = VHOST_IOTLB_MSG_V2;
     msg.asid = asid;
     msg.iotlb.iova = iova;
     msg.iotlb.size = size;
@@ -125,7 +125,7 @@ int vhost_vdpa_dma_unmap(struct vhost_vdpa *v, uint32_t asid, hwaddr iova,
     int fd = v->shared->device_fd;
     int ret = 0;
 
-    msg.type = v->msg_type;
+    msg.type = VHOST_IOTLB_MSG_V2;
     msg.asid = asid;
     msg.iotlb.iova = iova;
     msg.iotlb.size = size;
@@ -147,7 +147,7 @@ static void vhost_vdpa_listener_begin_batch(struct vhost_vdpa *v)
 {
     int fd = v->shared->device_fd;
     struct vhost_msg_v2 msg = {
-        .type = v->msg_type,
+        .type = VHOST_IOTLB_MSG_V2,
         .iotlb.type = VHOST_IOTLB_BATCH_BEGIN,
     };
 
@@ -183,7 +183,7 @@ static void vhost_vdpa_listener_commit(MemoryListener *listener)
         return;
     }
 
-    msg.type = v->msg_type;
+    msg.type = VHOST_IOTLB_MSG_V2;
     msg.iotlb.type = VHOST_IOTLB_BATCH_END;
 
     trace_vhost_vdpa_listener_commit(v->shared, fd, msg.type, msg.iotlb.type);
@@ -597,7 +597,6 @@ static int vhost_vdpa_init(struct vhost_dev *dev, void *opaque, Error **errp)
     v->dev = dev;
     dev->opaque =  opaque ;
     v->listener = vhost_vdpa_memory_listener;
-    v->msg_type = VHOST_IOTLB_MSG_V2;
     vhost_vdpa_init_svq(dev, v);
 
     error_propagate(&dev->migration_blocker, v->migration_blocker);
-- 
MST


