Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C0E74E208
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:10:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIztv-0002oz-U6; Mon, 10 Jul 2023 19:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIztt-0002oS-TU
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:02:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzts-00046P-4r
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:02:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b0MXB3jbql5WvQ/habq6pavth8cn2+kv1+mjQ4aH340=;
 b=YW7CHQXd/I0ujglgAyZjwmnIcKbS7TqzwdAMKjyg0W8e20eM2MfXbOauvFU8PfT3H7q9nD
 dtTKmwrQe2dWe/Dcu2lCfECdZkajzccChv2TUK976umnX8SJoPaetvzkRBWUEMWotMcN+P
 WQjgK9fR7AMCOo3GOzOC9oZ6DzqxKIo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-t0wIWPGpOkaWKi6wIO3ucw-1; Mon, 10 Jul 2023 19:02:34 -0400
X-MC-Unique: t0wIWPGpOkaWKi6wIO3ucw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3113da8b778so2712642f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:02:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030152; x=1691622152;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b0MXB3jbql5WvQ/habq6pavth8cn2+kv1+mjQ4aH340=;
 b=jugBMHkYTaMJDk0OdvDgsvW3p0mGv9FckErtuhkiRwWMhOzNQA7eIrMM53GiWjtCyy
 Cg4JAHm2SLFTOBW/dNs/8Vbx/q5taM0boZx/z7aqB/xUMI+j0LCWzQLEZ+l6dlTnMXyO
 TqBXozyICXHrnAlPJpsER9aYbtv/OzXgRfngy3MnGUWiPTpKhXtiEt2EBMclhzxNvOgA
 NtkoWxXB8XXu8M/YjqlBf/HQqab5RPehlCe8LFgdIhncea1VWGRKhowBJ/H7okja1w7F
 I/nc2HJK3llzi+70HsZIhuVwMYxThGZby/Zs9ZfS0iK/lNQznlFeuHsmCmCao+B6a5xQ
 KQwQ==
X-Gm-Message-State: ABy/qLYsGSDIWfbKu0vBWrrQOo0O7aXL63QWDqOIr27L9FH7wVCPQv3c
 CyoE7lMk5BPasEwwiHgXLOukF9nuP7cxH5Mo7yPCyQJblL6UXG9iXmFPQ4INBV/Rwd6HshsLAPP
 7ofkSZLr4s+2Ks4OcP0ukdoKg7HZ8+rkQ9ACIKoODGOTbTk5x6lgCX5SsleaWCn0Dffhz
X-Received: by 2002:adf:f008:0:b0:314:13e7:b8b with SMTP id
 j8-20020adff008000000b0031413e70b8bmr12949153wro.18.1689030151901; 
 Mon, 10 Jul 2023 16:02:31 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG7UBTBcDbb7a89vED4u/KGi721kr3T1LpEeDsuoMLK01dlstLC3TGpsLGRGGIepUkr06HAng==
X-Received: by 2002:adf:f008:0:b0:314:13e7:b8b with SMTP id
 j8-20020adff008000000b0031413e70b8bmr12949135wro.18.1689030151604; 
 Mon, 10 Jul 2023 16:02:31 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 m15-20020adfdc4f000000b003142ea7a661sm595472wrj.21.2023.07.10.16.02.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:02:31 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:02:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 01/66] vdpa: Remove status in reset tracing
Message-ID: <2b5de4d7dff457d34b57fcf3f985a41ddc0db062.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

From: Eugenio Pérez <eperezma@redhat.com>

It is always 0 and it is not useful to route call through file
descriptor.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Message-Id: <20230526153736.472443-1-eperezma@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-vdpa.c | 2 +-
 hw/virtio/trace-events | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 3c575a9a6e..6246e5b9bf 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -859,7 +859,7 @@ static int vhost_vdpa_reset_device(struct vhost_dev *dev)
     uint8_t status = 0;
 
     ret = vhost_vdpa_call(dev, VHOST_VDPA_SET_STATUS, &status);
-    trace_vhost_vdpa_reset_device(dev, status);
+    trace_vhost_vdpa_reset_device(dev);
     v->suspended = false;
     return ret;
 }
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 8f8d05cf9b..6265231683 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -44,7 +44,7 @@ vhost_vdpa_set_mem_table(void *dev, uint32_t nregions, uint32_t padding) "dev: %
 vhost_vdpa_dump_regions(void *dev, int i, uint64_t guest_phys_addr, uint64_t memory_size, uint64_t userspace_addr, uint64_t flags_padding) "dev: %p %d: guest_phys_addr: 0x%"PRIx64" memory_size: 0x%"PRIx64" userspace_addr: 0x%"PRIx64" flags_padding: 0x%"PRIx64
 vhost_vdpa_set_features(void *dev, uint64_t features) "dev: %p features: 0x%"PRIx64
 vhost_vdpa_get_device_id(void *dev, uint32_t device_id) "dev: %p device_id %"PRIu32
-vhost_vdpa_reset_device(void *dev, uint8_t status) "dev: %p status: 0x%"PRIx8
+vhost_vdpa_reset_device(void *dev) "dev: %p"
 vhost_vdpa_get_vq_index(void *dev, int idx, int vq_idx) "dev: %p idx: %d vq idx: %d"
 vhost_vdpa_set_vring_ready(void *dev) "dev: %p"
 vhost_vdpa_dump_config(void *dev, const char *line) "dev: %p %s"
-- 
MST


