Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F252E7CE1DA
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 17:56:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8s8-0006xN-DO; Wed, 18 Oct 2023 11:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8s5-0006hz-97
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:54:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8s3-0006Oj-10
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:54:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NnZ2s+L/b1HX9DHf9pBpEKpAVinEM8uC7IZ8jyp1dfs=;
 b=SFf8LXzzYnAJ3WAOczYKfwMEF0cklm5oWSsQ88ky9qKXUt0EyERmqfsFrt7vb//BeXOK9S
 MhOGXhxmbzeP7HY9/tv1x6o9XdoTxXruHMAlrV1KyuWw2/BMZbV8dwtYv1fIP67Zi+LgPc
 8N5lohHwYex3P4kxLUddB86eNfbo0mU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-VDvMAh-BNgm6T2Ye7aKSqg-1; Wed, 18 Oct 2023 11:54:04 -0400
X-MC-Unique: VDvMAh-BNgm6T2Ye7aKSqg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-406710d9a4aso49922635e9.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644443; x=1698249243;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NnZ2s+L/b1HX9DHf9pBpEKpAVinEM8uC7IZ8jyp1dfs=;
 b=mbIVTWF1aanQAKfomHZQ0c5cz9Kj2BvSShNYZY1hGZrTmbgZRWTSS1bnYzAMHUnpmL
 4VSxWWfS7vQhxH2GjkJK14rGIYa7ajHUyq67AfrkcH5X2aLu1vh10aVugA25GUWcgQm6
 VqkZO/QKjRaS+PCy74g8d9r6QLqPKH6nVr3ijwbZWtdTxPi3CWdNdBUe41bQ5TBbh1nb
 PbKvhi0yjMABn1H/4xduhdctfmF41vufvJX9+EJrhTmm671DaifNwFcsG/KixNwdSryT
 XvQeC77HssEYvrwJb90qDpY6Q2nc+T/1L2kaFGBH3aEZZw20lG7ePsx72KJ9qnq/HcSq
 jANA==
X-Gm-Message-State: AOJu0Ywe3dbV3kuV/YuiGdypYbNm5mNwShgApxn4P+lrh0oxw7OXyevC
 NIa4hFAqyA6HQS5nzJovKRWs6OW3aQ8gdB2KuOFc6rOOeFXW5tCpsxH4bGvdLoQ227JrvkXxTML
 bz7ctnQfBTKmbJF5DWGBpzaKfwAsENkcbRHuzTcHLFNXIkVWG6tOnBo8JxtZv0vbBczoctT8=
X-Received: by 2002:a05:600c:1d22:b0:408:41b4:7fe0 with SMTP id
 l34-20020a05600c1d2200b0040841b47fe0mr540270wms.6.1697644442852; 
 Wed, 18 Oct 2023 08:54:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNNvqRufkYWgLCVMGAiH4zi1xx9tS7bzYRTiAW//xjGT/3weCrOaRyFc5BIYT1v4YpiRP3Vw==
X-Received: by 2002:a05:600c:1d22:b0:408:41b4:7fe0 with SMTP id
 l34-20020a05600c1d2200b0040841b47fe0mr540257wms.6.1697644442550; 
 Wed, 18 Oct 2023 08:54:02 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 h17-20020a05600c499100b0040772138bb7sm1962949wmp.2.2023.10.18.08.54.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:54:02 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:53:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 11/83] vdpa: Restore receive-side scaling state
Message-ID: <49f5836bacfb9d4bb96d29f16d04822d64e0ad52.1697644299.git.mst@redhat.com>
References: <cover.1697644299.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697644299.git.mst@redhat.com>
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

This patch reuses vhost_vdpa_net_load_rss() with some
refactorings to restore the receive-side scaling state
at device's startup.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Message-Id: <47b17e160ba4e55b24790b7d73b22d2b437ebe3c.1693299194.git.yin31149@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 54 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 18 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index ef48b6e816..846457129d 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -851,17 +851,28 @@ static int vhost_vdpa_net_load_rss(VhostVDPAState *s, const VirtIONet *n,
 
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
@@ -898,6 +909,7 @@ static int vhost_vdpa_net_load_rss(VhostVDPAState *s, const VirtIONet *n,
 
     r = vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
                                 VIRTIO_NET_CTRL_MQ,
+                                do_rss ? VIRTIO_NET_CTRL_MQ_RSS_CONFIG :
                                 VIRTIO_NET_CTRL_MQ_HASH_CONFIG,
                                 data, ARRAY_SIZE(data));
     if (unlikely(r < 0)) {
@@ -932,13 +944,19 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
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
MST


