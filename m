Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F5078C101
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 11:11:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaulB-0000GU-0j; Tue, 29 Aug 2023 05:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qaul9-0000FY-4S
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 05:11:39 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qaul5-0000VG-IX
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 05:11:37 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-68c3b9f85b7so1857938b3a.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 02:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693300294; x=1693905094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Znge5YwLhXoq+d+egkc4N829QLJubVUwOvAAm5uLYB0=;
 b=mxkPHqnzDeAaSzpmYTB70rOaYTa8io1SZV5QWmc2eUtwL5GJi5OYd12AFaTNy0pXAE
 2HUT9jmJuwM2Udkh/OOsO3Q+Qwig5YteHlVs1vJXOjteUCzotr28vk4SaYI6Y8BRJrEm
 gWmcKpYo+IDViLCnsyu6i6RF9XvdQ6diLfVRwXoRhulUrl/3FN3DJK72V1RHgVUxTkpn
 YKMkAIYb0UfnZYuzhc/UuJtYqT77g3n3vW9DatuLwg2CJfoz7mCR4jtrLOiMVndv7bQs
 ZZO0dFxRGY5HXWSEsjxHgxK38nq+GK7B+K49SDusWpqc4a+44PfXC/Hrhcx+Bwv8u8EQ
 pp7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693300294; x=1693905094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Znge5YwLhXoq+d+egkc4N829QLJubVUwOvAAm5uLYB0=;
 b=SdOdnQYRA3uwsE+IXk4MUQlKzHBDPar3UE8+1HQKpWwpVrsEj1qqgtZxCsehMxNL/k
 yQxCsJAmO3x6dDrXSB5GNRRms9zWt1iaJaQHdGcu+S9f8oK2aufcd8Yc/kGjuE/lW9qM
 NK+x4vjp5gmLpU6qHX41W0XVOY/2IGYNYB4GlJaUgw5my0yqpfLqbE0W4Pre7OHhbMgT
 lxIKBugMWybLPHIAErzQZcQIXoSV+UAZN3bI5SGDqSyRTNT7RSVdD2oetYL+IaHDyCJm
 CkWFlXyfNL7fFKC/yvDReE7YrPTmgmyR8uLz81Q1nIg1181F/ygWSjNFPl9mG2xXgOwv
 X/0g==
X-Gm-Message-State: AOJu0Ywfp61D1mk3r2VjQqPMURa5newGU/4ojDVRfUzsK4aYDlvqChZZ
 yhAHUaO6E8Ro1gmioAu1nDs=
X-Google-Smtp-Source: AGHT+IG7rprK0vCNCMMXcjYq/Ikg5frW1LKrOyzoXHyafK+ZhqZjlY0kJW4oxUMW+ZAgPzJU73T3nQ==
X-Received: by 2002:a05:6a20:244f:b0:133:215e:7230 with SMTP id
 t15-20020a056a20244f00b00133215e7230mr25558338pzc.55.1693300293911; 
 Tue, 29 Aug 2023 02:11:33 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 x19-20020a170902821300b001bbf7fd354csm8837672pln.213.2023.08.29.02.11.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 02:11:33 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v3 2/3] vdpa: Restore receive-side scaling state
Date: Tue, 29 Aug 2023 17:11:16 +0800
Message-Id: <47b17e160ba4e55b24790b7d73b22d2b437ebe3c.1693299194.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1693299194.git.yin31149@gmail.com>
References: <cover.1693299194.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=yin31149@gmail.com; helo=mail-pf1-x430.google.com
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
v3:
  - resolve conflict with updated patch
"Vhost-vdpa Shadow Virtqueue Hash calculation Support"

v2: https://lore.kernel.org/all/af33aa80bc4ef0b2cec6c21b9448866c517fde80.1691926415.git.yin31149@gmail.com/
  - Correct the feature usage to VIRTIO_NET_F_HASH_REPORT when
loading the hash calculation state

v1: https://lore.kernel.org/all/93d5d82f0a5df71df326830033e50358c8b6be7a.1691766252.git.yin31149@gmail.com/

 net/vhost-vdpa.c | 54 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 18 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 11f89e7032..85547b7bbb 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -839,17 +839,28 @@ static int vhost_vdpa_net_load_rss(VhostVDPAState *s, const VirtIONet *n,
 
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
 
     table = g_malloc_n(n->rss_data.indirections_len,
                        sizeof(n->rss_data.indirections_table[0]));
@@ -886,6 +897,7 @@ static int vhost_vdpa_net_load_rss(VhostVDPAState *s, const VirtIONet *n,
 
     r = vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
                                 VIRTIO_NET_CTRL_MQ,
+                                do_rss ? VIRTIO_NET_CTRL_MQ_RSS_CONFIG :
                                 VIRTIO_NET_CTRL_MQ_HASH_CONFIG,
                                 data, ARRAY_SIZE(data));
     if (unlikely(r < 0)) {
@@ -920,13 +932,19 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
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


