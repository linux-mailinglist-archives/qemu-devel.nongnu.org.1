Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E00F758FAF
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 09:54:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM21C-0005L3-Se; Wed, 19 Jul 2023 03:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qM20v-0005H2-K7
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 03:54:26 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qM20t-0003Ox-W7
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 03:54:25 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6686c74183cso6598356b3a.1
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 00:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689753262; x=1692345262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TzUWFm6jl8VZ4HfXUTybQ0jJBYc+cOQnZhY89ahOgk4=;
 b=WH3c5vJUUVSkeYk31VYhuZEQq7qrcKVzApwL+HeSAAvcc+WvBAzf+9pTQSeL2pFMgR
 zdXEXn716wCUfta+QPlG9HIuZ0ymib2DUZ4K3AZYPbz6ukv+h6oC4u4ylVCWd2I+nQME
 CfIyNRkrxzhMxKDkPaI+NBDQMrbOcbEoxQOnnOoBk4e/v8QqkQKKlXNQeFv4geEemzpU
 QUZpCfg5V1E3FPCXTBqVPmveIzxD7g3IFYw7Qw3klRHZJvQNcNYwkX+p6AAvCfvLuAFJ
 G5LGX5pZ+EeYIoEw7vYNoeUuUmdXmp1Cukx6GHKEnGgvxxmrAVbi0/UDoQbUbBS2M5Lk
 WS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689753262; x=1692345262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TzUWFm6jl8VZ4HfXUTybQ0jJBYc+cOQnZhY89ahOgk4=;
 b=B6qCB8LpcWUWq7eChbPaXDinfYfLfJ7+qKx1NupvZwSzhE3mUQx0CtBhuzb+CKCAsH
 74ur27I0NJOjoaFrJbvWImHCIaUBobXkBl2rMs2JSlrPQuARrTXhiKRhqLbo6Opi8HwB
 e0+un4lkghaIi/pbXgCGzhbc3j5vNYrAxoE69DJ5HVumu9lcuec6zWowwZQK2+ckLvJV
 Yov6OFV9lgO88APHVDYafdtqg2cQgWfzsbBh+1igGoS1twz7iVmpzex9r15pvUYiW1gM
 ye/AjOUP/r0CMwFKNuWSHneSKW5wuAKwJn58WtX+kV9JRhL/D/sJcsq//cRIDkU0Dog/
 9bYw==
X-Gm-Message-State: ABy/qLaLvvaz7lsCTpST6XDrs9U3TjFT1bjtiSRc5CJyi12E66mqfpkn
 y2ecT6tebeybGle0xBmGMVeYi1728C8iMQ==
X-Google-Smtp-Source: APBJJlFMutHhHrJ1s3r/kJ8GjIlisRmVrNrnoCBdRonsGqlOc48DeduDFooUQQL+FG583nLfS9v4Qw==
X-Received: by 2002:a05:6a20:2452:b0:137:2204:4ea6 with SMTP id
 t18-20020a056a20245200b0013722044ea6mr2186260pzc.27.1689753262512; 
 Wed, 19 Jul 2023 00:54:22 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 a16-20020a62e210000000b006528d9080f6sm2685943pfi.9.2023.07.19.00.54.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jul 2023 00:54:22 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v3 5/8] vdpa: Check device ack in vhost_vdpa_net_load_rx_mode()
Date: Wed, 19 Jul 2023 15:53:50 +0800
Message-Id: <abecff1ddd3020adacb398e0f553600d0b088205.1689748694.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1689748694.git.yin31149@gmail.com>
References: <cover.1689748694.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=yin31149@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Considering that vhost_vdpa_net_load_rx_mode() is only called
within vhost_vdpa_net_load_rx() now, this patch refactors
vhost_vdpa_net_load_rx_mode() to include a check for the
device's ack, simplifying the code and improving its maintainability.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 net/vhost-vdpa.c | 76 ++++++++++++++++++++----------------------------
 1 file changed, 31 insertions(+), 45 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index ae8f59adaa..fe0ba19724 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -814,14 +814,24 @@ static int vhost_vdpa_net_load_rx_mode(VhostVDPAState *s,
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
@@ -846,13 +856,9 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
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
 
@@ -874,13 +880,9 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
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
 
@@ -899,13 +901,9 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
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
 
@@ -920,13 +918,9 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
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
 
@@ -941,13 +935,9 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
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
 
@@ -962,13 +952,9 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
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


