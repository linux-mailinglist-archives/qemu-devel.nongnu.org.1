Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8227D20C0
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 04:18:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quO16-0005qH-Qx; Sat, 21 Oct 2023 22:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1quO14-0005q2-E1
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 22:16:34 -0400
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1quO12-0003Le-JH
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 22:16:34 -0400
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-7a683bd610dso78730539f.1
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 19:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697940991; x=1698545791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GVTxssubxxqzAxFBncG+u/wKTx/KEO8I9Wt1E1WY2sk=;
 b=fiadiqwualyv2DbPjk78d/o0H6NDJG+D873QSdWKXxywNHP8mkjmds8TfPi0VL+HUS
 ZVW79Vm3H2czWw+WwU8HFX6BUC8LXvtsRXX2JV2Td8ijmdIoyDTWqBM2QD7lsuYmbRIW
 Cc2KrL8RfSqdD5Usd9azi134vbJkPthKc33bBvg3AWMHcSM/Af5ssgjJ36OsoaVvmEpT
 GyJJXCcerFzVqanS9Mnur7L3bEocbQYJtMtL6TvSmAFTg1JWEj9/mqWWNzklHe1d1U+z
 4c/g+aCF4gUKTD16C2i+oaZQqiEvAszz40WYLA2nHSB7YkHdFcaOOSvE87U2Ad4HMUGu
 wPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697940991; x=1698545791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GVTxssubxxqzAxFBncG+u/wKTx/KEO8I9Wt1E1WY2sk=;
 b=gXngKZLgc+UQUOmybaFoz2dlLosXcMdaad7RSufmbhBj9/bEogD+UD47Cibrjobj5e
 WHma/IDuYmmEwdOA7pwIjs6FkbTtNlOWz939oX+4Kivj+T5Qu5z3VlWlgo0A44hwJmjn
 GD1VYXpl+sDRRlSI68vAhVu0+z4/WjIQrzwyGN9RPLdl6cLPFjEFC7RaknmY+fVXhU1e
 FnyMTTMhQG3LNcM9nfSCsxVF8TfWaxuHJKGb5BZaD4Slwd/ZLZstft5x2bLhcDatTcUi
 91ugKZnRvfAQaCUJ1V5REBSIOstNu4qUxIQccAbr6ir2MYgy7PXEEYhuNUE74hB3OxGE
 PNlA==
X-Gm-Message-State: AOJu0YwrTnftypKnsPn/K2kY9DA0eup1CYFjeWzBgIHncGq3tAANKvS6
 ZkWHOr7tzXWPSpRzaFx3YL4=
X-Google-Smtp-Source: AGHT+IFzjBc9eAA853Cet93vF30xwWKPnC1cQ0Jh+tfQq55Wn8KTwpKu2oLPIyAk2UeOd2F2oJPjzg==
X-Received: by 2002:a05:6e02:1d96:b0:351:526a:4bc with SMTP id
 h22-20020a056e021d9600b00351526a04bcmr8576010ila.15.1697940990789; 
 Sat, 21 Oct 2023 19:16:30 -0700 (PDT)
Received: from localhost ([124.64.17.222]) by smtp.gmail.com with ESMTPSA id
 y68-20020a636447000000b0058953648c27sm3694559pgb.88.2023.10.21.19.16.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 19:16:30 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v4 2/3] vdpa: Restore receive-side scaling state
Date: Sun, 22 Oct 2023 10:16:16 +0800
Message-Id: <79caf9bf05778ed5279e11bdd1f26b49baf373ce.1697904740.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1697904740.git.yin31149@gmail.com>
References: <cover.1697904740.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d33;
 envelope-from=yin31149@gmail.com; helo=mail-io1-xd33.google.com
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
v4:
  - add do_rss argument and relative code in vhost_vdpa_net_load_rss()

v3: https://lore.kernel.org/all/47b17e160ba4e55b24790b7d73b22d2b437ebe3c.1693299194.git.yin31149@gmail.com/
  - resolve conflict with updated patch
"Vhost-vdpa Shadow Virtqueue Hash calculation Support"

RFC v2: https://lore.kernel.org/all/af33aa80bc4ef0b2cec6c21b9448866c517fde80.1691926415.git.yin31149@gmail.com/
  - Correct the feature usage to VIRTIO_NET_F_HASH_REPORT when
loading the hash calculation state

RFC v1: https://lore.kernel.org/all/93d5d82f0a5df71df326830033e50358c8b6be7a.1691766252.git.yin31149@gmail.com/

 net/vhost-vdpa.c | 63 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 21 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index c4b89f5119..5de01aa851 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -827,7 +827,7 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n,
 
 static int vhost_vdpa_net_load_rss(VhostVDPAState *s, const VirtIONet *n,
                                    struct iovec *out_cursor,
-                                   struct iovec *in_cursor)
+                                   struct iovec *in_cursor, bool do_rss)
 {
     struct virtio_net_rss_config cfg;
     ssize_t r;
@@ -853,19 +853,33 @@ static int vhost_vdpa_net_load_rss(VhostVDPAState *s, const VirtIONet *n,
                        sizeof(n->rss_data.indirections_table[0]));
     cfg.hash_types = cpu_to_le32(n->rss_data.hash_types);
 
-    /*
-     * According to VirtIO standard, "Field reserved MUST contain zeroes.
-     * It is defined to make the structure to match the layout of
-     * virtio_net_rss_config structure, defined in 5.1.6.5.7.".
-     *
-     * Therefore, we need to zero the fields in struct virtio_net_rss_config,
-     * which corresponds the `reserved` field in
-     * struct virtio_net_hash_config.
-     */
-    cfg.indirection_table_mask = 0;
-    cfg.unclassified_queue = 0;
-    table[0] = 0; /* the actual indirection table for cfg */
-    cfg.max_tx_vq = 0;
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
+         * struct virtio_net_rss_config, which corresponds the `reserved` field
+         * in struct virtio_net_hash_config.
+         */
+        cfg.indirection_table_mask = 0;
+        cfg.unclassified_queue = 0;
+        table[0] = 0; /* the actual indirection table for cfg */
+        cfg.max_tx_vq = 0;
+    }
 
     /*
      * Consider that virtio_net_handle_rss() currently does not restore the
@@ -896,6 +910,7 @@ static int vhost_vdpa_net_load_rss(VhostVDPAState *s, const VirtIONet *n,
 
     r = vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
                                 VIRTIO_NET_CTRL_MQ,
+                                do_rss ? VIRTIO_NET_CTRL_MQ_RSS_CONFIG :
                                 VIRTIO_NET_CTRL_MQ_HASH_CONFIG,
                                 data, ARRAY_SIZE(data));
     if (unlikely(r < 0)) {
@@ -930,13 +945,19 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
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


