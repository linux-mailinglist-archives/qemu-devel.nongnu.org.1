Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B427CE1EC
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 17:58:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8rm-0004tE-9Y; Wed, 18 Oct 2023 11:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8rk-0004gP-5E
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:53:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8ri-0006MM-MW
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UQlj+8sgMBKeSBER7AOYNOJcGiMheAyQ6KzKwKB4ADc=;
 b=E7IcxMtpJ0Gcbb/gltCe9KDajMhhI0C9Mj1d7kwBLLYZn8fJAU5lkqHqzxiCGMIgh1VL28
 D9s66H4pM4NyEnU234bQz7vp38BX8pZVY1ysGSY+hsic6WkR4Ez/sDFCV+o/wR9sH9RyxY
 9+VLH4sAhrI6k5uslqUL9R4uU1UGTYw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-b0EBNYhkPFu2VWBHAjRRYg-1; Wed, 18 Oct 2023 11:53:29 -0400
X-MC-Unique: b0EBNYhkPFu2VWBHAjRRYg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-327ab41de6cso4523087f8f.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:53:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644408; x=1698249208;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UQlj+8sgMBKeSBER7AOYNOJcGiMheAyQ6KzKwKB4ADc=;
 b=HrjMUSQR048lRdhd+zMAqXg/8MEpRleC6Ujyvkm3zuLLr4uIyIlLyrYrmHsb4EZqOL
 Ign3pJRVl4sFAE+V5IIEwptAk4q3CUjJMcUDQcFiJvbOAMseG2sY6js+/YKcKDGoVcdC
 CS3L+Xff6z7kUGptmXq9+t1lzcXyj8F0tB8z4Y81RATawA9IogKBrrXTmEhV9GnA5e9Y
 E/PrPxkZxy17zE49ompYhM2pNKQNLlNCYEoXLowNGBWK7CKmm+BUvthhFYPq9R8A6Yn4
 e9gk7D/BKN0G0eug2vuwei/mrn3L7YPSXwoxfoYcSd+UC1LzOstMzXj84JwiAnbCUDYs
 ldDA==
X-Gm-Message-State: AOJu0YyIprRF4Lp5Ln4YwVL7TisAWLGYYcc1RwGuHqEUL6FPV1tbMI4S
 RGi5DkvoeXdsi+x4KA7d/aOcQar5PJ46uJmN1tel+ZKTaSHSwW+uLMgt/BEQGHD5xI50qi8804b
 T+ynWpfDH/7DYubeEbMZ2dtiTKent6BOPww+ODF4MlD66zICggBfWQqFf+2p/qnVzHX4zmlw=
X-Received: by 2002:a5d:5a15:0:b0:321:68fa:70aa with SMTP id
 bq21-20020a5d5a15000000b0032168fa70aamr6619543wrb.9.1697644408206; 
 Wed, 18 Oct 2023 08:53:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrlfzl4i2mZoZ96OqdcRidjlVa2MZ0vWiUTAs5cftsEaa56VjMvpfvvNMcJx7nAOZNb08imQ==
X-Received: by 2002:a5d:5a15:0:b0:321:68fa:70aa with SMTP id
 bq21-20020a5d5a15000000b0032168fa70aamr6619528wrb.9.1697644407822; 
 Wed, 18 Oct 2023 08:53:27 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 e6-20020adfe386000000b0032d96dd703bsm2391464wrm.70.2023.10.18.08.53.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:53:27 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:53:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 02/83] vdpa: Avoid using vhost_vdpa_net_load_*() outside
 vhost_vdpa_net_load()
Message-ID: <327dedb8df91f57ef917ab5b5db519146ee6f08b.1697644299.git.mst@redhat.com>
References: <cover.1697644299.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1697644299.git.mst@redhat.com>
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


