Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C1977931B
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 17:30:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUU4k-0003NA-D9; Fri, 11 Aug 2023 11:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qUU4X-0003KP-KX
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 11:29:07 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qUU4U-0001ZW-IO
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 11:29:03 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1bc8a2f71eeso15651075ad.0
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 08:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691767741; x=1692372541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d0J4+NFvllkfXC8isEMvJoBUiBhktDu32aUMBe2kQ00=;
 b=WBTZ2hzMAERxAgk4FZXpeFEacqqyZSe8GLXI4Ct1UNkrIaVvTqXCrOvrxhSto4eP9C
 qCT+dxsNHNSkq5M0hKE1ragCxuvScRs5qUMxBq6VC4NC26+5WY/b9REDhkoham3aJkUb
 x93hHoJgg351Ho54JvLvNEc38AYSuYFwakyQUI7AAWRNIMrWo7NVC9wOlOsfynGe7AKF
 iKyXIO3vq72bZYmCAwEDwHtYuu5t/SZ8ALhjhfCRr6xA4MI1bmE3ekRf2t/vMj4kjIap
 0nEZuuVRwLN8Q3kjTF02iQgc816k614/cP4Qw1u2swfo9L5urj9njw4w3zR0ik9xZnzE
 o6UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691767741; x=1692372541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d0J4+NFvllkfXC8isEMvJoBUiBhktDu32aUMBe2kQ00=;
 b=PsFmXhYlQw4n9AWMNCiK9Y9edr0VwsHsSm1JDrF2tneRsa61lT+A9XpAs1v/xfUSBW
 lx4QCFUXNshWcSoMNgT3oITQwBkpvyLxQXCXam7ljSKSbxMUvmnvfMjcWax1AiiZ2Mia
 ReQ9eMHHmCxTJXvPxuTbnNJNuZBGNnAa0kl3FHehvM59MFiLRpOQXgJgaywACbEC7KZl
 nl3XGj72n5MvI4obBzGoIhX0iMEIoqwlP598qwKNXEvZEksR11USVblrshsWHloUfQG3
 tL8kmm1gJFm0k9Gney6a5IgkPPZ/dLTj5YeI5KXvgBaMvNsZA4aQIATfh/pfILxqtxsZ
 ehIQ==
X-Gm-Message-State: AOJu0YzJBzzWR4QNwHNWzLfRzPJWg7a3TMoIXchet1J2Mfqd+j3YwdOt
 DNLKvnhR65h0ME5qszsSq44=
X-Google-Smtp-Source: AGHT+IEtYlcc5Ab6QQg7lfrfUMD+LbxeniIBVBKdq9vOwmGwS7e97vNz7cSo+3wxofG+lhVdRu5r3w==
X-Received: by 2002:a17:902:8604:b0:1b9:ebf4:5d2 with SMTP id
 f4-20020a170902860400b001b9ebf405d2mr1905941plo.33.1691767740887; 
 Fri, 11 Aug 2023 08:29:00 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 a11-20020a170902b58b00b001b83e624eecsm4079286pls.81.2023.08.11.08.28.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 08:29:00 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [RFC PATCH 2/3] vdpa: Restore receive-side scaling state
Date: Fri, 11 Aug 2023 23:28:43 +0800
Message-Id: <93d5d82f0a5df71df326830033e50358c8b6be7a.1691766252.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1691766252.git.yin31149@gmail.com>
References: <cover.1691766252.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=yin31149@gmail.com; helo=mail-pl1-x631.google.com
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
 net/vhost-vdpa.c | 53 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 18 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 4c8e4b19f6..7870cbe142 100644
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
@@ -899,13 +911,18 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
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
+    } else if (virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_RSS)) {
+        /* Load the hash calculation state */
+        r = vhost_vdpa_net_load_rss(s, n, out_cursor, in_cursor, false);
+        if (unlikely(r < 0)) {
+            return r;
+        }
     }
 
     return 0;
-- 
2.25.1


