Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FDD7B9A53
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 05:46:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoFH0-00022y-B9; Wed, 04 Oct 2023 23:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFGy-0001vx-0d
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:43:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFGw-00009b-Cy
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:43:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696477413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r7t3RY6KSMAZbgOmvy8F0sqwvYbqLUNza9YburPW3qA=;
 b=f2R7/NlvMbLWA3f3X13fvZMX0A0rd1ChRDy4KXsh2n5hYokAdSF1gj9FopI+CXQtjU0PGI
 6gpqcwrKsvrs0NXbuv28pK+McginGhwsJ2hO7Po43d8KF+zHhEfOajiHu7Q3k6B+l9Bwie
 1YkKGKTmoA0YOYUVHj1T4NlNkA5VkWA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-f45VDuDePoiGWt4eW9b4ug-1; Wed, 04 Oct 2023 23:43:32 -0400
X-MC-Unique: f45VDuDePoiGWt4eW9b4ug-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-324810f3bfcso691245f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 20:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696477411; x=1697082211;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r7t3RY6KSMAZbgOmvy8F0sqwvYbqLUNza9YburPW3qA=;
 b=szJOAKKR5xohweiCLDXu1buxgGBuxqv9mDccgAueUFd52/vc5Qm/XLtwEi1SioCImp
 9fOZ+MVDFut49Cer9sbUCEaMFfvGC+pZtt7+dcdFClBusK5ruBWoNX5y+hcnESHIEwBY
 Zc88TrwmAkri321ttVI3vtF5amD7FW399Ku0QxN/qZfTkicgp4ij/kt9xpe6TH9S1Zv4
 Ibefu4hK89YoC6jEgw431aNMhGqiWyMTLSY79Iq5IBytC50XbgZYzFCYYDyoW0s1s/XM
 zYanyrSKC5URRIUgQO7eSLXX14iiNqehBR1ZF3f3f5HrscDqKpx++YmHvHyRb3j+nB4z
 oM2w==
X-Gm-Message-State: AOJu0YwbCCjcvrHRkONwhtIEkzzStG5tgWtDSpZzZiqhwXAkqF8QxLbx
 Z+tcZNuxW+xj6MXBWRmL5pGoyqHvd1FTdym6AitMQTO8oCe9zlr6asQBk6laz4uY22t0tF+/2ft
 EtViPap/NgDggu3LlY4G6kbm5O59eMi2r2jLhXP8o+CpG4FCZbOokeS7lwR1jv1tIL7gP
X-Received: by 2002:a5d:6183:0:b0:321:8181:6012 with SMTP id
 j3-20020a5d6183000000b0032181816012mr975096wru.21.1696477410884; 
 Wed, 04 Oct 2023 20:43:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHICwbtFymhrHOakrES23G1oUw/xQr+e5x+AWwI8hBZlJvH/mw/e3rR0GXFy0sWQkTegNNYcw==
X-Received: by 2002:a5d:6183:0:b0:321:8181:6012 with SMTP id
 j3-20020a5d6183000000b0032181816012mr975086wru.21.1696477410615; 
 Wed, 04 Oct 2023 20:43:30 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 t9-20020a5d4609000000b0031f8a59dbeasm630611wrq.62.2023.10.04.20.43.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 20:43:29 -0700 (PDT)
Date: Wed, 4 Oct 2023 23:43:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Lei Yang <leiyang@redhat.com>
Subject: [PULL v2 16/53] vdpa: export vhost_vdpa_set_vring_ready
Message-ID: <d7ce0841767d01c226fc0e22436ce22a0ec74226.1696477105.git.mst@redhat.com>
References: <cover.1696477105.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696477105.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

From: Eugenio Pérez <eperezma@redhat.com>

The vhost-vdpa net backend needs to enable vrings in a different order
than default, so export it.

No functional change intended except for tracing, that now includes the
(virtio) index being enabled and the return value of the ioctl.

Still ignoring return value of this function if called from
vhost_vdpa_dev_start, as reorganize calling code around it is out of
the scope of this series.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20230822085330.3978829-3-eperezma@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost-vdpa.h |  1 +
 hw/virtio/vhost-vdpa.c         | 25 +++++++++++++------------
 hw/virtio/trace-events         |  2 +-
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
index e64bfc7f98..5407d54fd7 100644
--- a/include/hw/virtio/vhost-vdpa.h
+++ b/include/hw/virtio/vhost-vdpa.h
@@ -57,6 +57,7 @@ typedef struct vhost_vdpa {
 } VhostVDPA;
 
 int vhost_vdpa_get_iova_range(int fd, struct vhost_vdpa_iova_range *iova_range);
+int vhost_vdpa_set_vring_ready(struct vhost_vdpa *v, unsigned idx);
 
 int vhost_vdpa_dma_map(struct vhost_vdpa *v, uint32_t asid, hwaddr iova,
                        hwaddr size, void *vaddr, bool readonly);
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 50b932a930..e7de880d51 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -882,18 +882,17 @@ static int vhost_vdpa_get_vq_index(struct vhost_dev *dev, int idx)
     return idx;
 }
 
-static int vhost_vdpa_set_vring_ready(struct vhost_dev *dev)
+int vhost_vdpa_set_vring_ready(struct vhost_vdpa *v, unsigned idx)
 {
-    int i;
-    trace_vhost_vdpa_set_vring_ready(dev);
-    for (i = 0; i < dev->nvqs; ++i) {
-        struct vhost_vring_state state = {
-            .index = dev->vq_index + i,
-            .num = 1,
-        };
-        vhost_vdpa_call(dev, VHOST_VDPA_SET_VRING_ENABLE, &state);
-    }
-    return 0;
+    struct vhost_dev *dev = v->dev;
+    struct vhost_vring_state state = {
+        .index = idx,
+        .num = 1,
+    };
+    int r = vhost_vdpa_call(dev, VHOST_VDPA_SET_VRING_ENABLE, &state);
+
+    trace_vhost_vdpa_set_vring_ready(dev, idx, r);
+    return r;
 }
 
 static int vhost_vdpa_set_config_call(struct vhost_dev *dev,
@@ -1304,7 +1303,9 @@ static int vhost_vdpa_dev_start(struct vhost_dev *dev, bool started)
         if (unlikely(!ok)) {
             return -1;
         }
-        vhost_vdpa_set_vring_ready(dev);
+        for (int i = 0; i < dev->nvqs; ++i) {
+            vhost_vdpa_set_vring_ready(v, dev->vq_index + i);
+        }
     } else {
         vhost_vdpa_suspend(dev);
         vhost_vdpa_svqs_stop(dev);
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 7109cf1a3b..1cb9027d1e 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -48,7 +48,7 @@ vhost_vdpa_set_features(void *dev, uint64_t features) "dev: %p features: 0x%"PRI
 vhost_vdpa_get_device_id(void *dev, uint32_t device_id) "dev: %p device_id %"PRIu32
 vhost_vdpa_reset_device(void *dev) "dev: %p"
 vhost_vdpa_get_vq_index(void *dev, int idx, int vq_idx) "dev: %p idx: %d vq idx: %d"
-vhost_vdpa_set_vring_ready(void *dev) "dev: %p"
+vhost_vdpa_set_vring_ready(void *dev, unsigned i, int r) "dev: %p, idx: %u, r: %d"
 vhost_vdpa_dump_config(void *dev, const char *line) "dev: %p %s"
 vhost_vdpa_set_config(void *dev, uint32_t offset, uint32_t size, uint32_t flags) "dev: %p offset: %"PRIu32" size: %"PRIu32" flags: 0x%"PRIx32
 vhost_vdpa_get_config(void *dev, void *config, uint32_t config_len) "dev: %p config: %p config_len: %"PRIu32
-- 
MST


