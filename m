Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 213D87C7FEC
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:20:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDFP-000719-Qz; Fri, 13 Oct 2023 04:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qrDFI-0006sG-OB
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:10:11 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qrDFG-0001kn-RF
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:10:08 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c894e4573bso14207285ad.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697184605; x=1697789405; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TORX/2+rZIf+XwtZl4Awh7Er7v8DktbAlILwpC/XKfA=;
 b=SPH839rjsvWrQZ/QQL3C+LT7Y1EVcrkUlo7mWosW4kTkem2AY55lQT4uPgxo4QaOBh
 PUwDTjQxMAGMl784RwsRiEWB1IkX0cNolVU+YtCJDvfx1iNUmcfrV5X9WYWdtCuNi8O9
 rpzUX+OP5iaO1mMgGgnd7t8JgO2nPC9OblpalJ21ri9xV7vFDIOLmZTRkGPZYbunEZr7
 yIDeK7u9KK3CMJ6R5E7Ok6uXNnmPWUxEWKMScODxh2Ve47RF+p2NqSc49KTzHLMBAgZH
 dCaEUKH1rDAEH1ZjefVda4QSEg8xT1CLf1j/5YpPM3ydL4hielt/s4uWgxWz53cqT5Bz
 Jb7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697184605; x=1697789405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TORX/2+rZIf+XwtZl4Awh7Er7v8DktbAlILwpC/XKfA=;
 b=FJVvh0V5zSGA11oogt4YYIfrmYpm5XR1D0N7T4/u8Gfqjv95iLiI0RMtGCUbpNnX0l
 edKMv0xRNKGY0VMPBIEu6C/m2eWntzVswJ9dwh0ZyMobIYJ3sIq3cHrP2ylPJ8oc1wfo
 Lub09yYyRioDElCo0PMXL0XGykoO70rxhbK8sBxwjy7E2TjXIkRpjo7xKPLHQwSaDfrd
 SMag3DpheC/ekL/MNuvd+SHPJihd1l39CzwhEsJzFNFK85teOSzvn4a3FdOTorDPD+El
 6RjbRT2quEe16mMJvD8jFO2P478CUiVRzX27dVBdSJvS5L9V4aDe0LZLuzikoNIROPjO
 p86A==
X-Gm-Message-State: AOJu0YynfmeihW9NBK2KH0ua+kDjO0ZjsgnpmSKUjovf0f8Hj4WyjWcO
 KlByT8aM/R7yfeAL2kKwoEk=
X-Google-Smtp-Source: AGHT+IFrfLSuTsz9JfAKcdjCJMlkPNOJMqe1HD/zTqHDs75KVjR0FcUpR6ml4i3iTuurQdmBApoUgg==
X-Received: by 2002:a17:902:bf0c:b0:1c5:b4a1:ff6 with SMTP id
 bi12-20020a170902bf0c00b001c5b4a10ff6mr21604955plb.45.1697184605151; 
 Fri, 13 Oct 2023 01:10:05 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 e4-20020a17090301c400b001aaf2e8b1eesm3252091plh.248.2023.10.13.01.10.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:10:04 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v5 3/7] vdpa: Check device ack in vhost_vdpa_net_load_rx_mode()
Date: Fri, 13 Oct 2023 16:09:38 +0800
Message-Id: <68811d52f96ae12d68f0d67d996ac1642a623943.1697165821.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1697165821.git.yin31149@gmail.com>
References: <cover.1697165821.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=yin31149@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Considering that vhost_vdpa_net_load_rx_mode() is only called
within vhost_vdpa_net_load_rx() now, this patch refactors
vhost_vdpa_net_load_rx_mode() to include a check for the
device's ack, simplifying the code and improving its maintainability.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
---
v5:
  - no change

v4: https://lore.kernel.org/all/be0e39e2c76e1ef39a76839b4a4ce90c8e54a98e.1693287885.git.yin31149@gmail.com/

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
2.25.1


