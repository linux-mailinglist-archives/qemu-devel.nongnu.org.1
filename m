Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A127D5F59
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 03:09:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvSNz-0000VV-GN; Tue, 24 Oct 2023 21:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qvSNo-0000VC-SC
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 21:08:29 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qvSNn-0008Hx-0p
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 21:08:28 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1c0ecb9a075so35945535ad.2
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 18:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698196105; x=1698800905; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iqTJYJbb9nM6t9/9E/6lz2EsNdBEGzHkSWKAMwQOUXo=;
 b=fiXHyVfxLcp5rl29bx+RDSjU6zNBJ+xTCO3Sll1rB93P32e9U/C6IV/yhocp3Q05zz
 NtzFFL8XRnFkrohFn6NgP3276FwX3slDcg9JVchATtVxF16wjhtDeI3d97sj8Fup5AL6
 S2Ld62+KS1Iz+9jEC5Cg7kqDoqcTV6WQRK6U31jooe5OYeGV1PSRVPN/Uazi6YWCEsmc
 djWL6/IzIHCKa4n/QH7/bIuIBXuVgvvK5qFzikifAb6KL0haIUANRpud0uaq7C/gRjkL
 UPlb9CcQFGsPMokdkT2pvY0znZwokIIOF1rgPwiQCWfdK82152O9yvNTqEWuJ41zNbl9
 pXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698196105; x=1698800905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iqTJYJbb9nM6t9/9E/6lz2EsNdBEGzHkSWKAMwQOUXo=;
 b=u0o1jcIbdjBV49ZiQ+2PxRGI2T/ptETvZYVjdct5kiJQmgIzpoudSRwhfOZVzjvJ0l
 YUkzEFt+qu1ku+GWKQ+QevF1nsNEIcG4oD5yT9BaO1qGiXZx+2eZX/1CazAUG5Y/zI6N
 WgtsNWAhcMmjEcmR75bI6DJp6Pn4nRiv0KQAlN5tY87IDwlYCLuXp5GhFBGgsAKIPXOu
 d2dEMkvlERnVQ6wfdrLgI4Gw859onKQo312uJ4WCzWfm9W8Clb02tfTfd6IGf7OiMFsk
 ug/cDPSNIiIJOYd7R2DNcVPNIXVSWKEVoHvZ98gC0eWDAL5q63G2+JpF0scuQQUZJPrH
 5ibQ==
X-Gm-Message-State: AOJu0YzBs909j63Cimm6bSvqgHF1N5TEzYm+TzX5GcdIBovGfUo08KHD
 PE7iGosrGLcMweCjWXktmPc=
X-Google-Smtp-Source: AGHT+IF+P2p+t8Gxoc3erVof1lUkiVuW0sqTgn0t9KGJWHxDhPfqdJvz+fZZ+0OlSE1JFeA5ssnZcA==
X-Received: by 2002:a17:902:f988:b0:1c3:2df4:8791 with SMTP id
 ky8-20020a170902f98800b001c32df48791mr10601471plb.27.1698196105266; 
 Tue, 24 Oct 2023 18:08:25 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 jk15-20020a170903330f00b001b9d7c8f44dsm8040830plb.182.2023.10.24.18.08.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 18:08:24 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v5 2/3] vdpa: Restore receive-side scaling state
Date: Wed, 25 Oct 2023 09:08:05 +0800
Message-Id: <cf5b78a16ed0318982ceffb195f2227f6aad4ac1.1698195059.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1698195059.git.yin31149@gmail.com>
References: <cover.1698195059.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=yin31149@gmail.com; helo=mail-pl1-x632.google.com
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

This patch reuses vhost_vdpa_net_load_rss() with some
refactorings to restore the receive-side scaling state
at device's startup.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
v5:
  - resolve conflict with the updated patch 
"Vhost-vdpa Shadow Virtqueue Hash calculation Support"

v4: https://lore.kernel.org/all/79caf9bf05778ed5279e11bdd1f26b49baf373ce.1697904740.git.yin31149@gmail.com/
  - add do_rss argument and relative code in vhost_vdpa_net_load_rss()

v3: https://lore.kernel.org/all/47b17e160ba4e55b24790b7d73b22d2b437ebe3c.1693299194.git.yin31149@gmail.com/
  - resolve conflict with updated patch
"Vhost-vdpa Shadow Virtqueue Hash calculation Support"

RFC v2: https://lore.kernel.org/all/af33aa80bc4ef0b2cec6c21b9448866c517fde80.1691926415.git.yin31149@gmail.com/
  - Correct the feature usage to VIRTIO_NET_F_HASH_REPORT when
loading the hash calculation state

RFC v1: https://lore.kernel.org/all/93d5d82f0a5df71df326830033e50358c8b6be7a.1691766252.git.yin31149@gmail.com/

 net/vhost-vdpa.c | 67 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 44 insertions(+), 23 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 3466936b87..a4cc1381fc 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -828,7 +828,7 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n,
 
 static int vhost_vdpa_net_load_rss(VhostVDPAState *s, const VirtIONet *n,
                                    struct iovec *out_cursor,
-                                   struct iovec *in_cursor)
+                                   struct iovec *in_cursor, bool do_rss)
 {
     struct virtio_net_rss_config cfg = {};
     ssize_t r;
@@ -854,21 +854,35 @@ static int vhost_vdpa_net_load_rss(VhostVDPAState *s, const VirtIONet *n,
                        sizeof(n->rss_data.indirections_table[0]));
     cfg.hash_types = cpu_to_le32(n->rss_data.hash_types);
 
-    /*
-     * According to VirtIO standard, "Field reserved MUST contain zeroes.
-     * It is defined to make the structure to match the layout of
-     * virtio_net_rss_config structure, defined in 5.1.6.5.7.".
-     *
-     * Therefore, we need to zero the fields in
-     * struct virtio_net_rss_config, which corresponds to the
-     * `reserved` field in struct virtio_net_hash_config.
-     *
-     * Note that all other fields are zeroed at their definitions,
-     * except for the `indirection_table` field, where the actual data
-     * is stored in the `table` variable to ensure compatibility
-     * with RSS case. Therefore, we need to zero the `table` variable here.
-     */
-    table[0] = 0;
+    if (do_rss) {
+        /*
+         * According to VirtIO standard, "Number of entries in indirection_table
+         * is (indirection_table_mask + 1)".
+         */
+        cfg.indirection_table_mask = cpu_to_le16(n->rss_data.indirections_len -
+                                                 1);
+        cfg.unclassified_queue = cpu_to_le16(n->rss_data.default_queue);
+        for (int i = 0; i < n->rss_data.indirections_len; ++i) {
+            table[i] = cpu_to_le16(n->rss_data.indirections_table[i]);
+        }
+        cfg.max_tx_vq = cpu_to_le16(n->curr_queue_pairs);
+    } else {
+        /*
+         * According to VirtIO standard, "Field reserved MUST contain zeroes.
+         * It is defined to make the structure to match the layout of
+         * virtio_net_rss_config structure, defined in 5.1.6.5.7.".
+         *
+         * Therefore, we need to zero the fields in
+         * struct virtio_net_rss_config, which corresponds to the
+         * `reserved` field in struct virtio_net_hash_config.
+         *
+         * Note that all other fields are zeroed at their definitions,
+         * except for the `indirection_table` field, where the actual data
+         * is stored in the `table` variable to ensure compatibility
+         * with RSS case. Therefore, we need to zero the `table` variable here.
+         */
+        table[0] = 0;
+    }
 
     /*
      * Considering that virtio_net_handle_rss() currently does not restore
@@ -899,6 +913,7 @@ static int vhost_vdpa_net_load_rss(VhostVDPAState *s, const VirtIONet *n,
 
     r = vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
                                 VIRTIO_NET_CTRL_MQ,
+                                do_rss ? VIRTIO_NET_CTRL_MQ_RSS_CONFIG :
                                 VIRTIO_NET_CTRL_MQ_HASH_CONFIG,
                                 data, ARRAY_SIZE(data));
     if (unlikely(r < 0)) {
@@ -933,13 +948,19 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
         return r;
     }
 
-    if (!virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_HASH_REPORT)) {
-        return 0;
-    }
-
-    r = vhost_vdpa_net_load_rss(s, n, out_cursor, in_cursor);
-    if (unlikely(r < 0)) {
-        return r;
+    if (virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_RSS)) {
+        /* load the receive-side scaling state */
+        r = vhost_vdpa_net_load_rss(s, n, out_cursor, in_cursor, true);
+        if (unlikely(r < 0)) {
+            return r;
+        }
+    } else if (virtio_vdev_has_feature(&n->parent_obj,
+                                       VIRTIO_NET_F_HASH_REPORT)) {
+        /* load the hash calculation state */
+        r = vhost_vdpa_net_load_rss(s, n, out_cursor, in_cursor, false);
+        if (unlikely(r < 0)) {
+            return r;
+        }
     }
 
     return 0;
-- 
2.25.1


