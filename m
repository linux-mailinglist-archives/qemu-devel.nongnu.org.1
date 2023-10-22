Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B29057D221A
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:23:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUf3-0008T4-Ib; Sun, 22 Oct 2023 05:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUf1-0008SB-Ro
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:22:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUf0-0000AA-9p
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:22:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UQlj+8sgMBKeSBER7AOYNOJcGiMheAyQ6KzKwKB4ADc=;
 b=arc3/inKk1JSuVFYEDIr7TOggNEjz0U07hvPEflcKi/2Rv/lmrUOENIYgvgpbsb+JBK+3F
 RKKDjgy0Ti+6ogReQqEjR/lq09JE9bHSHWF9Ovxf5zMe0pOg7mWq4/NdH7UZGRDTZGvZXL
 5B5KFGdaRUrzxcXFVuY5vJ5p6cfG6KI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-kjyKTIAtPo6SVdqLWItq6w-1; Sun, 22 Oct 2023 05:22:06 -0400
X-MC-Unique: kjyKTIAtPo6SVdqLWItq6w-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40768556444so14521795e9.3
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966525; x=1698571325;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UQlj+8sgMBKeSBER7AOYNOJcGiMheAyQ6KzKwKB4ADc=;
 b=gh1fKspjiyZtyZhN4RjvAwQbwDX61EoKEWwUHULb33D2gv+rEpL9PkGhJjX9D7+eQ3
 7qQuxP6a16M2ckETVa9hHN0j7YTT4NaisAYt9u7V2DptCwNi70/FzRaITLkGAAftS2Mt
 kkE2GrREpzNLKDxdDwX3fzFJNqwk34yXZ6RHT44f2d84PfvlPNq2arbUq9gqc/xnePdF
 zaPMNm3t5hOBocUAm25Y3h2ItuemAqlPBoTSYSsyhzcChOzeRxx4hfxQC4HgKlvn5O2K
 AFl08UXF+CcfQMxU2g2xh4y4meeloTL4DGBktgLnRdZzuUGPj7ydKqPfPZQT5oHhxCe7
 /Yvg==
X-Gm-Message-State: AOJu0Yw/oJQSpQXlV0cJ1mx2tizctxJczBgE2st3b8z9F2eZhbLyuYmG
 bIOua/5zSsoy3T0mL/CMnThznnPd4xyb1NI6yWYn0eYlebZlmXj5jnTYj9rOtmN9LxwdSz02jXl
 vmDI/1RMX8XfQJ/m2R3JppZ1W8Tv/0A88vh9IEkmnpqM3P0bn946IAN/1qGJupmd/Eg2Z
X-Received: by 2002:a05:600c:46d1:b0:405:3dbc:8823 with SMTP id
 q17-20020a05600c46d100b004053dbc8823mr5421838wmo.12.1697966525123; 
 Sun, 22 Oct 2023 02:22:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFviErRYyxm5RUCpa3s+jZ9JIznC4IzBoS93CHHQJbXOIfKsidpmBjP8J9nS1HrH3QgAjFyQ==
X-Received: by 2002:a05:600c:46d1:b0:405:3dbc:8823 with SMTP id
 q17-20020a05600c46d100b004053dbc8823mr5421821wmo.12.1697966524633; 
 Sun, 22 Oct 2023 02:22:04 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 r9-20020a05600c320900b0040644e699a0sm11230803wmp.45.2023.10.22.02.22.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:22:04 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:22:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL v3 02/62] vdpa: Avoid using vhost_vdpa_net_load_*() outside
 vhost_vdpa_net_load()
Message-ID: <327dedb8df91f57ef917ab5b5db519146ee6f08b.1697966402.git.mst@redhat.com>
References: <cover.1697966402.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1697966402.git.mst@redhat.com>
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

From: Hawkins Jiawei <yin31149@gmail.com>

Next patches in this series will refactor vhost_vdpa_net_load_cmd()
to iterate through the control commands shadow buffers, allowing QEMU
to send CVQ state load commands in parallel at device startup.

Considering that QEMU always forwards the CVQ command serialized
outside of vhost_vdpa_net_load(), it is more elegant to send the
CVQ commands directly without invoking vhost_vdpa_net_load_*() helpers.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Message-Id: <254f0618efde7af7229ba4fdada667bb9d318991.1697165821.git.yin31149@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 618758596a..86b8d31244 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -1114,12 +1114,14 @@ static NetClientInfo net_vhost_vdpa_cvq_info = {
  */
 static int vhost_vdpa_net_excessive_mac_filter_cvq_add(VhostVDPAState *s,
                                                        VirtQueueElement *elem,
-                                                       struct iovec *out)
+                                                       struct iovec *out,
+                                                       const struct iovec *in)
 {
     struct virtio_net_ctrl_mac mac_data, *mac_ptr;
     struct virtio_net_ctrl_hdr *hdr_ptr;
     uint32_t cursor;
     ssize_t r;
+    uint8_t on = 1;
 
     /* parse the non-multicast MAC address entries from CVQ command */
     cursor = sizeof(*hdr_ptr);
@@ -1167,7 +1169,13 @@ static int vhost_vdpa_net_excessive_mac_filter_cvq_add(VhostVDPAState *s,
      * filter table to the vdpa device, it should send the
      * VIRTIO_NET_CTRL_RX_PROMISC CVQ command to enable promiscuous mode
      */
-    r = vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_PROMISC, 1);
+    hdr_ptr = out->iov_base;
+    out->iov_len = sizeof(*hdr_ptr) + sizeof(on);
+
+    hdr_ptr->class = VIRTIO_NET_CTRL_RX;
+    hdr_ptr->cmd = VIRTIO_NET_CTRL_RX_PROMISC;
+    iov_from_buf(out, 1, sizeof(*hdr_ptr), &on, sizeof(on));
+    r = vhost_vdpa_net_cvq_add(s, out, 1, in, 1);
     if (unlikely(r < 0)) {
         return r;
     }
@@ -1285,7 +1293,7 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostShadowVirtqueue *svq,
          * the CVQ command directly.
          */
         dev_written = vhost_vdpa_net_excessive_mac_filter_cvq_add(s, elem,
-                                                                  &out);
+                                                            &out, &vdpa_in);
         if (unlikely(dev_written < 0)) {
             goto out;
         }
-- 
MST


