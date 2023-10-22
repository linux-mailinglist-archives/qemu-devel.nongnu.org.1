Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1127D2211
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:22:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUf2-0008Sr-P3; Sun, 22 Oct 2023 05:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUf0-0008PI-AN
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:22:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUey-00009w-Kj
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:22:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6rjIIhgIzngiZUO1BhT0Rp7HmlO6psOtfNInxxNDXLU=;
 b=J/HyPLAbXvnmOYWt5FhajJG/zNbwLlyMaPGXVu0Xq2zFKyCiRlD0Fk2oFKWgrBzPiDzE4L
 bcNtxKXz3xJ+Jcp7dJTExvI5duA/OoWc8o1ao2OMzImoD7YjKO20oJNVajcITTwk8cGvqa
 h13qfurKaUNEWAtER5gpjft5OARORqU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-V8RCCvpdP4mmcnAiIFg8VA-1; Sun, 22 Oct 2023 05:22:10 -0400
X-MC-Unique: V8RCCvpdP4mmcnAiIFg8VA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4084001846eso16038545e9.1
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:22:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966528; x=1698571328;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6rjIIhgIzngiZUO1BhT0Rp7HmlO6psOtfNInxxNDXLU=;
 b=q4iWuo1rYVzl9jD8x7Y8hum7p2EuyeAqYOXHN2kaVhM76nrpyTx+gjvYXY0zeT2RGL
 QKQtvm+g1CLZhkIcqTEdTyfZseiudaedmc0SrpTkT/q90+XjafhwY4M50ZnkSi8o4RIm
 T5KW7wnrF56N4pJgnpCqSGq0PH2PM2/3vogD8ltWPjvrHP7hlJ7HfT0DmMtrj3+azhwu
 ocRbKrweB5dPp+KpAdM1+33Ia0Fr8Lf80pkcGG1ED53+ZLuOPSucTfPKfGfPY0pQ3JtE
 JLZlcJ83g5sVTuQSxmiKcN5hNsX7zM2EpTvbwXRmL4YQZfMbKGQFqFi28GJhsbr2ZcR2
 dTeQ==
X-Gm-Message-State: AOJu0YxS7Erj9x8xWnlJcufEW9UPn4ENnCbkPL1omrYOrsB9w88hYbQk
 /r1Y3oJEqAD2UgwZKQTvaTbW0yLbiqf7O8pcGfDcEcesI/21+Tkm1NDB236mZxhxCXnhm7b4Sj9
 AxnK0siMHJhqtY2XBons8Mi7h8FFAKtjMinfn7B/lwfOFI6hthSSEdhUgLYhr1WLb3y9L
X-Received: by 2002:a05:6000:713:b0:32d:a495:a9b8 with SMTP id
 bs19-20020a056000071300b0032da495a9b8mr4943538wrb.48.1697966528426; 
 Sun, 22 Oct 2023 02:22:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSVqzV8+3a1cO9biyF4mD1PmN1AtNVoft+lnFUbSUCryUrT7GEUuUfDGsYN8iY4/Kx3l3a4w==
X-Received: by 2002:a05:6000:713:b0:32d:a495:a9b8 with SMTP id
 bs19-20020a056000071300b0032da495a9b8mr4943522wrb.48.1697966527981; 
 Sun, 22 Oct 2023 02:22:07 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 f9-20020adff449000000b0032d81837433sm5274398wrp.30.2023.10.22.02.22.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:22:07 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:22:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL v3 03/62] vdpa: Check device ack in
 vhost_vdpa_net_load_rx_mode()
Message-ID: <24e59cfe0cb53416b06c2c117bc22ff22dc54df3.1697966402.git.mst@redhat.com>
References: <cover.1697966402.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1697966402.git.mst@redhat.com>
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


