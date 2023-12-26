Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A97681E65E
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Dec 2023 10:26:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rI3gd-0003mY-1T; Tue, 26 Dec 2023 04:25:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rI3ga-0003fl-LF
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 04:25:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rI3gY-00005k-SD
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 04:25:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703582714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D+Sy8LokVxiUP811D8nldNN2ZDdnJt8aAbJYeHozE3g=;
 b=KitDqQoz78u2vkddC9YooDf40nlD6Pskx+G/TGu9jXJl4u7SH9Jg/MhYX8t69U0jubVq2k
 ZlxmxEitUxyYsRVo8be0wm6zQPyDlJ/GS2HQO4uq0ONDdXHaZwq7RhE745jPkMzNEC2Yxz
 sbrzzdbxsAVaneduDc3YmJIv0MYtCPA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-NfpOrJI6MB6OGvueCzRemg-1; Tue, 26 Dec 2023 04:25:12 -0500
X-MC-Unique: NfpOrJI6MB6OGvueCzRemg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3368abe10c5so3113216f8f.0
 for <qemu-devel@nongnu.org>; Tue, 26 Dec 2023 01:25:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703582711; x=1704187511;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D+Sy8LokVxiUP811D8nldNN2ZDdnJt8aAbJYeHozE3g=;
 b=QxWAWIi/6YYr1AE+Hbrrzj7K5pIDt23Spu3RBvW2Nf8vSVaEI1M0Ews72RWM0Zpt0e
 OQYAhZy+ezUsWMoAN3QYYGx1AI5RVoxDA8sx0TEyxptLTEbStYQDiSaO2SVY3+k4XAC2
 TOnbRD30Hzj52EfBBjOj3XpBiVJeMbbM1Pyltjyohus8bf5u1oWoqmvKB8lqe+GONgid
 B5mR75mtpFf/Xb7qadsszUct0SPtIlk+Kl3CBLb6GhVRf/gyN204BKlH42btyjzFyfza
 RnqP1MLp9wQjbHxHSBRWRN4LOl9VLrUX0SQG3KxNyfwr9h8dVSY3C/Qi+QzVMOGgq3ur
 DE7g==
X-Gm-Message-State: AOJu0YzG+SyurQ3tVUxxX4TayzCdakL3KH/C1Y66ECYi4EmIN42RsktS
 D3jOnCYhuJAocvafCfeiArF9SxJoPmzoPdTcmuGYJfWeOTwhjHi3Qki7Z+sixRWpmHUaJFU+B8C
 1dP2dvhDS5XI+R/U0xZMshj/zgWpSdB7nPgoZzVKGta11t0jAMAdkADOVqwGjhGADn6NF4z5dsY
 9j
X-Received: by 2002:adf:e30a:0:b0:336:7656:ee19 with SMTP id
 b10-20020adfe30a000000b003367656ee19mr2922257wrj.92.1703582710963; 
 Tue, 26 Dec 2023 01:25:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IED3cPVOnpCAeTIgT6HxEDadxdWPGRU88tb7gjLqILvBNvT2h829kvGs+Xnw29EQ6k/2bPEDQ==
X-Received: by 2002:adf:e30a:0:b0:336:7656:ee19 with SMTP id
 b10-20020adfe30a000000b003367656ee19mr2922248wrj.92.1703582710563; 
 Tue, 26 Dec 2023 01:25:10 -0800 (PST)
Received: from redhat.com ([2.55.177.189]) by smtp.gmail.com with ESMTPSA id
 g3-20020a5d4883000000b00336e32338f3sm977229wrq.70.2023.12.26.01.25.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 01:25:09 -0800 (PST)
Date: Tue, 26 Dec 2023 04:25:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Lei Yang <leiyang@redhat.com>
Subject: [PULL 16/21] vdpa: move backend_cap to vhost_vdpa_shared
Message-ID: <75478072fdbb26ca7f704cf1da04712cf5ea3c3a.1703582625.git.mst@redhat.com>
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

Next patches will register the vhost_vdpa memory listener while the VM
is migrating at the destination, so we can map the memory to the device
before stopping the VM at the source.  The main goal is to reduce the
downtime.

However, the destination QEMU is unaware of which vhost_vdpa device will
register its memory_listener.  If the source guest has CVQ enabled, it
will be the CVQ device.  Otherwise, it  will be the first one.

Move the backend_cap member to VhostVDPAShared so all vhost_vdpa can use
it, rather than always in the first / last vhost_vdpa.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20231221174322.3130442-9-eperezma@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost-vdpa.h | 3 +++
 hw/virtio/vhost-vdpa.c         | 8 +++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
index 05219bbcf7..11ac14085a 100644
--- a/include/hw/virtio/vhost-vdpa.h
+++ b/include/hw/virtio/vhost-vdpa.h
@@ -38,6 +38,9 @@ typedef struct vhost_vdpa_shared {
     /* IOVA mapping used by the Shadow Virtqueue */
     VhostIOVATree *iova_tree;
 
+    /* Copy of backend features */
+    uint64_t backend_cap;
+
     bool iotlb_batch_begin_sent;
 
     /* Vdpa must send shadow addresses as IOTLB key for data queues, not GPA */
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 2ecaedb686..99597c3179 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -161,7 +161,7 @@ static void vhost_vdpa_listener_begin_batch(struct vhost_vdpa *v)
 
 static void vhost_vdpa_iotlb_batch_begin_once(struct vhost_vdpa *v)
 {
-    if (v->dev->backend_cap & (0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH) &&
+    if (v->shared->backend_cap & (0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH) &&
         !v->shared->iotlb_batch_begin_sent) {
         vhost_vdpa_listener_begin_batch(v);
     }
@@ -172,11 +172,10 @@ static void vhost_vdpa_iotlb_batch_begin_once(struct vhost_vdpa *v)
 static void vhost_vdpa_listener_commit(MemoryListener *listener)
 {
     struct vhost_vdpa *v = container_of(listener, struct vhost_vdpa, listener);
-    struct vhost_dev *dev = v->dev;
     struct vhost_msg_v2 msg = {};
     int fd = v->shared->device_fd;
 
-    if (!(dev->backend_cap & (0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH))) {
+    if (!(v->shared->backend_cap & (0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH))) {
         return;
     }
 
@@ -838,6 +837,8 @@ static int vhost_vdpa_set_features(struct vhost_dev *dev,
 
 static int vhost_vdpa_set_backend_cap(struct vhost_dev *dev)
 {
+    struct vhost_vdpa *v = dev->opaque;
+
     uint64_t features;
     uint64_t f = 0x1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2 |
         0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH |
@@ -859,6 +860,7 @@ static int vhost_vdpa_set_backend_cap(struct vhost_dev *dev)
     }
 
     dev->backend_cap = features;
+    v->shared->backend_cap = features;
 
     return 0;
 }
-- 
MST


