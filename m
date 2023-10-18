Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEA47CE1C4
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 17:54:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8rb-0003Zy-BV; Wed, 18 Oct 2023 11:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8rZ-0003RX-LS
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:53:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8rX-0006LF-M7
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:53:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6rjIIhgIzngiZUO1BhT0Rp7HmlO6psOtfNInxxNDXLU=;
 b=eEFZcDUIFIHRZGkZZBPS5sFDM53Hd/P/UcGCS33bVGcPWPsmWLh3Pqygi0RLXNxwukuOCc
 8e6B3Y6prqzb5sGaZez/8jU2l/uInkVUGkPNwM47ZFAInr6QAdkSEobqPH3V7MLM4QRI8Q
 xJBaX44WM3SjW6bE6Zc+HKzvXz1RYtM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-XgkZ2kQ5NfedsBdyyIWixg-1; Wed, 18 Oct 2023 11:53:33 -0400
X-MC-Unique: XgkZ2kQ5NfedsBdyyIWixg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32da8de4833so2418210f8f.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:53:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644411; x=1698249211;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6rjIIhgIzngiZUO1BhT0Rp7HmlO6psOtfNInxxNDXLU=;
 b=doksGyzig3XWk2C3jBqQ8Jhf9bdN05fuKbQ/UcL4GWxfasMmpMcll8MmYJfxIfKFeB
 K4HoVI4n7QCC85y9P28/v1TEJS8EHByCuhHN1dHqPCVC9/eYLiyX3Ph4FPKxixd/CFwO
 2ORB78lIDTIx4UcYYDnsvT+rMqswE/Q7j6f1nn4WfmOmJyaGQ+jmktijzToghvvsHPiS
 7Eb43mN7iDhVuDpOD7Jng4FulkNrDtADspUmLQxkSrle+2pcYrypenzJssrR5biA/9Aq
 7ci7SQDkFjS3LI4UZT/VI5rneiP4LIDBj5ADP+KOl0uWcAE1YMjb0JPNQiA4MVgHGvo9
 5SBA==
X-Gm-Message-State: AOJu0Yyr+ScUdW791Y0wVh8GdL6hzc09TFLl6Dd0vG/X7g4+5OXGCzdc
 bDzFjeG86qryR4VjyEiEAT0j5qiLw/fYLT6Sx1aEIukcaMZ3o6Yx8ZyDMrR2k1RUsnDXxRacKE8
 WX1OhT5IPYe3DIzdOs7GtN2P6qwdNV22ej1kmKjGj6h3U2mqRTPzBn07e5QW2sJrq6eBP+hc=
X-Received: by 2002:a5d:6087:0:b0:323:306e:65cf with SMTP id
 w7-20020a5d6087000000b00323306e65cfmr4622349wrt.10.1697644411614; 
 Wed, 18 Oct 2023 08:53:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGi4otNAw/xIqzs63sknX1uTSBu7b1L5gjjJ1+/FcQnseWgPmtfhWwaSgxeubrXIfcWr91dlw==
X-Received: by 2002:a5d:6087:0:b0:323:306e:65cf with SMTP id
 w7-20020a5d6087000000b00323306e65cfmr4622332wrt.10.1697644411261; 
 Wed, 18 Oct 2023 08:53:31 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 j14-20020adfea4e000000b0032d81837433sm2444980wrn.30.2023.10.18.08.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:53:30 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:53:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 03/83] vdpa: Check device ack in vhost_vdpa_net_load_rx_mode()
Message-ID: <24e59cfe0cb53416b06c2c117bc22ff22dc54df3.1697644299.git.mst@redhat.com>
References: <cover.1697644299.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1697644299.git.mst@redhat.com>
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


