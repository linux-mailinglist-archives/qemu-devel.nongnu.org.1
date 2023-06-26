Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F24D073E0D5
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 15:40:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlM6-0003oE-7h; Mon, 26 Jun 2023 08:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlLn-0002xi-TH
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:29:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlLj-00037q-Pi
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:29:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dB6FfjKXTOnVb8d3WrfijaAV0zZ6uF43dpewIdOQqdk=;
 b=Tsb7GNeq0m8frQNiBEbiSfH7/6DP0dR3Wm6A0na9tQhANyfniewq5P4GCeFMHQLe4cHfMx
 AcmjK6sQ4vmiLt4URl0HKIPlQrbAzYbNrw9+D4IapdOLBRm3cDQipAboYAchkr0EWy1581
 MtDuYiYKJYAjnq0BHC2CFBWeUttohW4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-NvlwMqfhM3qYQMkEbauQGw-1; Mon, 26 Jun 2023 08:29:41 -0400
X-MC-Unique: NvlwMqfhM3qYQMkEbauQGw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f9b003507bso15733615e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782580; x=1690374580;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dB6FfjKXTOnVb8d3WrfijaAV0zZ6uF43dpewIdOQqdk=;
 b=Lu1KM6sw7bzKZ4wSDOoVEOyoma4tEumWr5gzD/h0ozyNSe9YjVQYFMWGku+L0ceZ7Z
 ZvEPgMN9ss6tQCCCn8Fdrr1qSN5Ixmdv07ZOSqaJfCJ+caiHB0nxG3cxzSRgCOEvSAVZ
 dy/XmY1MFjQjFu307PGpBCbB5pcpJTdQjafHj3Bgoe9ouCJDTZaQh31BUNt/qPmdKn6D
 xyDViHf6pl2plZm3ivyoBzLRA1kRugi5ZtkiH8bBDVh/rAkhOuEJiCBweAzzr01+mMjK
 loS1MD1HsbsLDKfqGJ+l8rghqqBX5L8gQ3IEQjSycm968XuxIufvoq8sT0yqizsJYrK9
 +L2Q==
X-Gm-Message-State: AC+VfDw2XpS6CJHHg8J3WHafl6l1MeKIyWymnvDUbJ2NwLwWn365WIOH
 nsk/hPNOv5dVQjoVHaWFWpt6Dd1em2bEdbyr5vEQVdZFekrdV10unkw/Ko8s0h08ubHxavRyU8w
 kEkw0jdz8lbVyhMJIubLgSIm7qoxx4Tx1yQiYLXB7PmftIVoSXtNx0mDaclC9NA0bntuF
X-Received: by 2002:a05:600c:d1:b0:3fa:9823:407 with SMTP id
 u17-20020a05600c00d100b003fa98230407mr1246738wmm.18.1687782579805; 
 Mon, 26 Jun 2023 05:29:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ48ZagAXBR3lvawnpOcKVUGGye9LAIqzXLLCIU36gPkqDV8S9tLXb/DorlHir3q3QK3P2ds3A==
X-Received: by 2002:a05:600c:d1:b0:3fa:9823:407 with SMTP id
 u17-20020a05600c00d100b003fa98230407mr1246720wmm.18.1687782579314; 
 Mon, 26 Jun 2023 05:29:39 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 u8-20020a05600c00c800b003f70a7b4537sm10485830wmm.36.2023.06.26.05.29.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:29:38 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:29:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 36/53] vdpa: map shadow vrings with MAP_SHARED
Message-ID: <f37ac7eac483c170f04740ca195af88f2a330d92.1687782442.git.mst@redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1687782442.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The vdpa devices that use va addresses neeeds these maps shared.
Otherwise, vhost_vdpa checks will refuse to accept the maps.

The mmap call will always return a page aligned address, so removing the
qemu_memalign call.  Keeping the ROUND_UP for the size as we still need
to DMA-map them in full.

Not applying fixes tag as it never worked with va devices.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Message-Id: <20230602143854.1879091-4-eperezma@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-shadow-virtqueue.c | 18 +++++++++---------
 net/vhost-vdpa.c                   | 16 ++++++++--------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index bd7c12b6d3..1b1d85306c 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -649,7 +649,7 @@ void vhost_svq_set_svq_kick_fd(VhostShadowVirtqueue *svq, int svq_kick_fd)
 void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
                      VirtQueue *vq, VhostIOVATree *iova_tree)
 {
-    size_t desc_size, driver_size, device_size;
+    size_t desc_size;
 
     event_notifier_set_handler(&svq->hdev_call, vhost_svq_handle_call);
     svq->next_guest_avail_elem = NULL;
@@ -662,14 +662,14 @@ void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
 
     svq->vring.num = virtio_queue_get_num(vdev, virtio_get_queue_index(vq));
     svq->num_free = svq->vring.num;
-    driver_size = vhost_svq_driver_area_size(svq);
-    device_size = vhost_svq_device_area_size(svq);
-    svq->vring.desc = qemu_memalign(qemu_real_host_page_size(), driver_size);
+    svq->vring.desc = mmap(NULL, vhost_svq_driver_area_size(svq),
+                           PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS,
+                           -1, 0);
     desc_size = sizeof(vring_desc_t) * svq->vring.num;
     svq->vring.avail = (void *)((char *)svq->vring.desc + desc_size);
-    memset(svq->vring.desc, 0, driver_size);
-    svq->vring.used = qemu_memalign(qemu_real_host_page_size(), device_size);
-    memset(svq->vring.used, 0, device_size);
+    svq->vring.used = mmap(NULL, vhost_svq_device_area_size(svq),
+                           PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS,
+                           -1, 0);
     svq->desc_state = g_new0(SVQDescState, svq->vring.num);
     svq->desc_next = g_new0(uint16_t, svq->vring.num);
     for (unsigned i = 0; i < svq->vring.num - 1; i++) {
@@ -712,8 +712,8 @@ void vhost_svq_stop(VhostShadowVirtqueue *svq)
     svq->vq = NULL;
     g_free(svq->desc_next);
     g_free(svq->desc_state);
-    qemu_vfree(svq->vring.desc);
-    qemu_vfree(svq->vring.used);
+    munmap(svq->vring.desc, vhost_svq_driver_area_size(svq));
+    munmap(svq->vring.used, vhost_svq_device_area_size(svq));
     event_notifier_set_handler(&svq->hdev_call, NULL);
 }
 
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index e425fabc34..8840ca2ea4 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -205,8 +205,8 @@ static void vhost_vdpa_cleanup(NetClientState *nc)
 {
     VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
 
-    qemu_vfree(s->cvq_cmd_out_buffer);
-    qemu_vfree(s->status);
+    munmap(s->cvq_cmd_out_buffer, vhost_vdpa_net_cvq_cmd_page_len());
+    munmap(s->status, vhost_vdpa_net_cvq_cmd_page_len());
     if (s->vhost_net) {
         vhost_net_cleanup(s->vhost_net);
         g_free(s->vhost_net);
@@ -903,12 +903,12 @@ static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
         vhost_vdpa_net_valid_svq_features(features,
                                           &s->vhost_vdpa.migration_blocker);
     } else if (!is_datapath) {
-        s->cvq_cmd_out_buffer = qemu_memalign(qemu_real_host_page_size(),
-                                            vhost_vdpa_net_cvq_cmd_page_len());
-        memset(s->cvq_cmd_out_buffer, 0, vhost_vdpa_net_cvq_cmd_page_len());
-        s->status = qemu_memalign(qemu_real_host_page_size(),
-                                  vhost_vdpa_net_cvq_cmd_page_len());
-        memset(s->status, 0, vhost_vdpa_net_cvq_cmd_page_len());
+        s->cvq_cmd_out_buffer = mmap(NULL, vhost_vdpa_net_cvq_cmd_page_len(),
+                                     PROT_READ | PROT_WRITE,
+                                     MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+        s->status = mmap(NULL, vhost_vdpa_net_cvq_cmd_page_len(),
+                         PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS,
+                         -1, 0);
 
         s->vhost_vdpa.shadow_vq_ops = &vhost_vdpa_net_svq_ops;
         s->vhost_vdpa.shadow_vq_ops_opaque = s;
-- 
MST


