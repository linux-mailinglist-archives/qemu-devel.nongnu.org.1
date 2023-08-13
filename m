Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E63377A648
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 14:03:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qV9nQ-0002f2-H8; Sun, 13 Aug 2023 08:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qV9nK-0002bG-Ot
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 08:02:09 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qV9nI-0007zR-TH
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 08:02:06 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-26b4dea0000so289070a91.0
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 05:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691928123; x=1692532923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1PSwnwx+0e4/avZ47FqqTcvScAWeBIzqBHe+gH48HnQ=;
 b=H6hrnXIOLxxoz5qR15vu2r+KamGsdUftU0ltRZqGk9z+pe3UyaGGJsTJsEIC+KdwYy
 x61LuQlAj0xI78KBgUyRdtXGCZ1LBoXzdNWvsPdZk9hk3o6nedpKaE+eQBIZ9zyEHQUc
 WieVznAPPxz/IMYYH6Cdx63/rx8FmWSP5W+TZzYbP6caKZrA9BuzJnQ0U92q+bsH2HQT
 AbEeslPogTGdZJdunMMHMscqOi28ihWqXl2OuIo9fD9SI5CEg5Q4hipeAtbPh/z0TxQs
 +YEh06LAPJ0K8GOOn/WrNwR6tURUpvvCGgg8txfPS7Y5AtCpYLlrGF4iEbvbd1SPzius
 wAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691928123; x=1692532923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1PSwnwx+0e4/avZ47FqqTcvScAWeBIzqBHe+gH48HnQ=;
 b=c6CbTCM5Av4ZaAe19mmwlYWYLu1jWvzGQ/pcOZNIFPsbG9yBMIHjUJuxPt9sXFtUIJ
 yiPnnonnVLq/2W1MFwaJQNe7fzQPRZWPeruW8ev9tRR0n+rUYTYZ2IfxApcOkXBkzP4G
 /VhjkvlEq262tRQB/F0KkdioGp9RxpW8e+VJpe9jLw3Xf/Cq+2BEUp/4dYrZSlLjeR2c
 Yn6lHoR9kaWVBbyiUUEFBnGUmgEr9U7CFxAKNw1uVu1RPQqIv4AUkzH094rggbeobHpQ
 5iGlYYdYwqv0N/joFtUS7dnrkwjKQwfHwPfpSbIOdzr+mOqgVHrcpGeBo3aYjGdLwOqn
 flVg==
X-Gm-Message-State: AOJu0Yx3Lib3DX0YpUKUqtWO9M1cw2rORy7AnwB04s+Z50/H1Ef6DLiB
 Uh4E+x4ydpZuz5z1085sLTPuNxbwqqlKDjhI
X-Google-Smtp-Source: AGHT+IGr/ZPvFQ1E5J6C2hVhgmrpj3giGReYfWP27EF9FFwdgkncJIB24qT81V+tuQAtCSG27tP8mA==
X-Received: by 2002:a17:90a:5a4d:b0:269:1e3f:a54d with SMTP id
 m13-20020a17090a5a4d00b002691e3fa54dmr6025411pji.10.1691928123186; 
 Sun, 13 Aug 2023 05:02:03 -0700 (PDT)
Received: from localhost ([125.35.86.198]) by smtp.gmail.com with ESMTPSA id
 40-20020a17090a0fab00b002680f0f2886sm8688235pjz.12.2023.08.13.05.02.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 05:02:02 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [RFC PATCH v2 2/3] vdpa: Restore receive-side scaling state
Date: Sun, 13 Aug 2023 20:01:53 +0800
Message-Id: <af33aa80bc4ef0b2cec6c21b9448866c517fde80.1691926415.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1691926415.git.yin31149@gmail.com>
References: <cover.1691926415.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=yin31149@gmail.com; helo=mail-pj1-x1036.google.com
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
v2:
  - Correct the feature usage to VIRTIO_NET_F_HASH_REPORT when
loading the hash calculation state

v1: https://lore.kernel.org/all/93d5d82f0a5df71df326830033e50358c8b6be7a.1691766252.git.yin31149@gmail.com/

 net/vhost-vdpa.c | 54 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 18 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 4c8e4b19f6..e21b3ac67a 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -820,17 +820,28 @@ static int vhost_vdpa_net_load_rss(VhostVDPAState *s, const VirtIONet *n,
     }
 
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
-    memset(&cfg.indirection_table_mask, 0,
-           sizeof_field(struct virtio_net_hash_config, reserved));
+    if (do_rss) {
+        /*
+         * According to VirtIO standard, "Number of entries in indirection_table
+         * is (indirection_table_mask + 1)".
+         */
+        cfg.indirection_table_mask = cpu_to_le16(n->rss_data.indirections_len -
+                                                 1);
+        cfg.unclassified_queue = cpu_to_le16(n->rss_data.default_queue);
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
+        memset(&cfg.indirection_table_mask, 0,
+               sizeof_field(struct virtio_net_hash_config, reserved));
+    }
     /*
      * Consider that virtio_net_handle_rss() currently does not restore the
      * hash key length parsed from the CVQ command sent from the guest into
@@ -866,6 +877,7 @@ static int vhost_vdpa_net_load_rss(VhostVDPAState *s, const VirtIONet *n,
 
     r = vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
                                 VIRTIO_NET_CTRL_MQ,
+                                do_rss ? VIRTIO_NET_CTRL_MQ_RSS_CONFIG :
                                 VIRTIO_NET_CTRL_MQ_HASH_CONFIG,
                                 data, ARRAY_SIZE(data));
     if (unlikely(r < 0)) {
@@ -899,13 +911,19 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
         return r;
     }
 
-    if (!virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_HASH_REPORT)) {
-        return 0;
-    }
-
-    r = vhost_vdpa_net_load_rss(s, n, out_cursor, in_cursor, false);
-    if (unlikely(r < 0)) {
-        return r;
+    if (virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_RSS)) {
+        /* Load the receive-side scaling state */
+        r = vhost_vdpa_net_load_rss(s, n, out_cursor, in_cursor, true);
+        if (unlikely(r < 0)) {
+            return r;
+        }
+    } else if (virtio_vdev_has_feature(&n->parent_obj,
+                                       VIRTIO_NET_F_HASH_REPORT)) {
+        /* Load the hash calculation state */
+        r = vhost_vdpa_net_load_rss(s, n, out_cursor, in_cursor, false);
+        if (unlikely(r < 0)) {
+            return r;
+        }
     }
 
     return 0;
-- 
2.25.1


