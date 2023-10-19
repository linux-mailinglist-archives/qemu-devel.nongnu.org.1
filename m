Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3967D01B1
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:34:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXeh-0005g5-9G; Thu, 19 Oct 2023 14:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXeN-0005eo-Ss
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:21:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXeM-0000cq-7W
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:21:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6rjIIhgIzngiZUO1BhT0Rp7HmlO6psOtfNInxxNDXLU=;
 b=fFR2tr/Dj3DRUTNdH3GXlZMiASqhr8FmVTv2WNRbGAXq6fT9gntF0rny3Zvw0lD8aXfkpA
 I4CePFynShCALZGCiKbYd81GSkNcccICRZq7cFoFt/IwpajAg42YlbgmFVVNwcHb/eIiVM
 WXFtIn0ZH1d5o++7Rg67o9c+imftH24=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-R42RGBoZOGqxNwTn0HuBWQ-1; Thu, 19 Oct 2023 14:21:24 -0400
X-MC-Unique: R42RGBoZOGqxNwTn0HuBWQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4083c9b426fso11917855e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:21:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739683; x=1698344483;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6rjIIhgIzngiZUO1BhT0Rp7HmlO6psOtfNInxxNDXLU=;
 b=YP6yGXqT1z/KK28AgRuuzK4gMfYTasbmEEQjmN0GPmAJ674eAgto1tSV1P12mRzmRr
 rItVY3TGhDdvtuP8N0Os52nd4cfpySMTPyfAUJ3bXd7oXfH4xdZfF3701O9SbAvvKqnO
 Zwp9BGGjnFe/nmPh0r8yB+dkNEUWgjg6OmNMBiwl4UHTW03cTxPLXBzCc7GaL2ZI6QSc
 CNza3ME1CkxAOylktiTuFb60QEpZnsfgzNr1iVBeFBxYmhNVPoE79beIl3OcQvLl2i4z
 DKTg/6CI4R52WjzcZida9RudCCfhUXDV6RIFrexfVN/ekZ4UkHt2B2VXPdRwLggLP8Oc
 WyBg==
X-Gm-Message-State: AOJu0YziB6bvWNBHGSiY3e5Gfk8jl9B2izWTAD0ngapIYSbgm/4YbCBl
 I0WDQQZu2L9aL30oayQxeBu2hH3PvfETG9wtkvEbmFIdf18aOo7HaiLPDBalfdWiBGRGS7NVKi9
 r44LvVB9bxkE+T9p3iebarON7WYy2SwPVcTzYfMjH4/COxlKOyDBGAb/9s/rmc0pQgJmj
X-Received: by 2002:a05:600c:1d14:b0:405:3f19:fc49 with SMTP id
 l20-20020a05600c1d1400b004053f19fc49mr2397161wms.34.1697739682954; 
 Thu, 19 Oct 2023 11:21:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMtoqVQCF5wMygwTHO6+JUbIJ/hRJakQnh8gbryQZbS2IaFr5yuh4WiRY05ku1GpCWcHcQyg==
X-Received: by 2002:a05:600c:1d14:b0:405:3f19:fc49 with SMTP id
 l20-20020a05600c1d1400b004053f19fc49mr2397139wms.34.1697739682471; 
 Thu, 19 Oct 2023 11:21:22 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 je20-20020a05600c1f9400b004063ea92492sm212773wmb.22.2023.10.19.11.21.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:21:21 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:21:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL v2 03/78] vdpa: Check device ack in
 vhost_vdpa_net_load_rx_mode()
Message-ID: <24e59cfe0cb53416b06c2c117bc22ff22dc54df3.1697739629.git.mst@redhat.com>
References: <cover.1697739629.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1697739629.git.mst@redhat.com>
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

Considering that vhost_vdpa_net_load_rx_mode() is only called
within vhost_vdpa_net_load_rx() now, this patch refactors
vhost_vdpa_net_load_rx_mode() to include a check for the
device's ack, simplifying the code and improving its maintainability.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Message-Id: <68811d52f96ae12d68f0d67d996ac1642a623943.1697165821.git.yin31149@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 76 ++++++++++++++++++++----------------------------
 1 file changed, 31 insertions(+), 45 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 86b8d31244..36a4e57c0d 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -827,14 +827,24 @@ static int vhost_vdpa_net_load_rx_mode(VhostVDPAState *s,
         .iov_base = &on,
         .iov_len = sizeof(on),
     };
-    return vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_RX,
-                                   cmd, &data, 1);
+    ssize_t dev_written;
+
+    dev_written = vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_RX,
+                                          cmd, &data, 1);
+    if (unlikely(dev_written < 0)) {
+        return dev_written;
+    }
+    if (*s->status != VIRTIO_NET_OK) {
+        return -EIO;
+    }
+
+    return 0;
 }
 
 static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
                                   const VirtIONet *n)
 {
-    ssize_t dev_written;
+    ssize_t r;
 
     if (!virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_RX)) {
         return 0;
@@ -859,13 +869,9 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
      * configuration only at live migration.
      */
     if (!n->mac_table.uni_overflow && !n->promisc) {
-        dev_written = vhost_vdpa_net_load_rx_mode(s,
-                                            VIRTIO_NET_CTRL_RX_PROMISC, 0);
-        if (unlikely(dev_written < 0)) {
-            return dev_written;
-        }
-        if (*s->status != VIRTIO_NET_OK) {
-            return -EIO;
+        r = vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_PROMISC, 0);
+        if (unlikely(r < 0)) {
+            return r;
         }
     }
 
@@ -887,13 +893,9 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
      * configuration only at live migration.
      */
     if (n->mac_table.multi_overflow || n->allmulti) {
-        dev_written = vhost_vdpa_net_load_rx_mode(s,
-                                            VIRTIO_NET_CTRL_RX_ALLMULTI, 1);
-        if (unlikely(dev_written < 0)) {
-            return dev_written;
-        }
-        if (*s->status != VIRTIO_NET_OK) {
-            return -EIO;
+        r = vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_ALLMULTI, 1);
+        if (unlikely(r < 0)) {
+            return r;
         }
     }
 
@@ -912,13 +914,9 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
      * configuration only at live migration.
      */
     if (n->alluni) {
-        dev_written = vhost_vdpa_net_load_rx_mode(s,
-                                            VIRTIO_NET_CTRL_RX_ALLUNI, 1);
-        if (dev_written < 0) {
-            return dev_written;
-        }
-        if (*s->status != VIRTIO_NET_OK) {
-            return -EIO;
+        r = vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_ALLUNI, 1);
+        if (r < 0) {
+            return r;
         }
     }
 
@@ -933,13 +931,9 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
      * configuration only at live migration.
      */
     if (n->nomulti) {
-        dev_written = vhost_vdpa_net_load_rx_mode(s,
-                                            VIRTIO_NET_CTRL_RX_NOMULTI, 1);
-        if (dev_written < 0) {
-            return dev_written;
-        }
-        if (*s->status != VIRTIO_NET_OK) {
-            return -EIO;
+        r = vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_NOMULTI, 1);
+        if (r < 0) {
+            return r;
         }
     }
 
@@ -954,13 +948,9 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
      * configuration only at live migration.
      */
     if (n->nouni) {
-        dev_written = vhost_vdpa_net_load_rx_mode(s,
-                                            VIRTIO_NET_CTRL_RX_NOUNI, 1);
-        if (dev_written < 0) {
-            return dev_written;
-        }
-        if (*s->status != VIRTIO_NET_OK) {
-            return -EIO;
+        r = vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_NOUNI, 1);
+        if (r < 0) {
+            return r;
         }
     }
 
@@ -975,13 +965,9 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
      * configuration only at live migration.
      */
     if (n->nobcast) {
-        dev_written = vhost_vdpa_net_load_rx_mode(s,
-                                            VIRTIO_NET_CTRL_RX_NOBCAST, 1);
-        if (dev_written < 0) {
-            return dev_written;
-        }
-        if (*s->status != VIRTIO_NET_OK) {
-            return -EIO;
+        r = vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_NOBCAST, 1);
+        if (r < 0) {
+            return r;
         }
     }
 
-- 
MST


