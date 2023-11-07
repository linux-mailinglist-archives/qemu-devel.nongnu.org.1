Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CF17E387A
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:11:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J3G-0004na-PM; Tue, 07 Nov 2023 05:11:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J3E-0004a6-4h
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:11:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J3C-0002Vp-3C
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:11:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699351873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yu/DRCnQglYDbBr20d7/0QO5BSMWBIDRPcuYSsahgjo=;
 b=NG2CqMr4KtgUiFrw33JeY86JUv/8adK+NoLHCScphhszi/qLpfLFFomgLdDdBgqczqrELe
 BTX6l/dGVgqKvvfvGoVYho4auUu2o40r6XYKw9UVipUU4ejKU+iVUX8n6PDvYnniTDvVa6
 jck3DmGHa0FoODaKwjJKZu59Q69j/TE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-ea6yjPneOE-LUlvY9M4c1A-1; Tue, 07 Nov 2023 05:11:12 -0500
X-MC-Unique: ea6yjPneOE-LUlvY9M4c1A-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-408f9e9e9b0so35068355e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:11:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699351870; x=1699956670;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yu/DRCnQglYDbBr20d7/0QO5BSMWBIDRPcuYSsahgjo=;
 b=pAZnYaR9vMoDB9Y9XM2R3UIu4tvwmgrTDmzKDPze0jav3qgfHUvaJbWKLYE0DHXyLb
 pcaupcuPFHvEOkc9oPPPInlHl3BY7e2D+a+Gn1FTGmP0HAYyOffQ0nwJVDugkQbcC0Af
 ouAPcXmkEaFVU2qpVfPjdDi6Ahb+LSibNym8274Jy+csCDWuriphVzs0e9JW2FdKjEXq
 R5QD45VaNCce1Z/hQ5+49UBoD16UVer9ukEqA511/0wmV8kB2QhzwQ8Wd3OPDuX0ll6g
 +P4QS00IUhzuUzhQUtIt8rBXSkBT/eDQOj9g27+gxT5S6ahODAEli74bkeZh4X6OiOtm
 a0JA==
X-Gm-Message-State: AOJu0Yzsa5x0OUXHC1C9a5NNSogRUaoxR3J9LFNhdYwcTKOBTjg73tFn
 F2eTY1AbyvefC5F/ndEyKRdd/iS2eGkhT9gtwaXFTQMTTz+kjKo2j5s3AxneIAI8bLslcQBTMz2
 BDuiAU8sGvFwKem9NsTCmdUeds4CXUvWSnv/w8tE7iZzKO5wkINEOLoRwNPyZ6u9mbNMy
X-Received: by 2002:a05:600c:46d2:b0:40a:20f3:d126 with SMTP id
 q18-20020a05600c46d200b0040a20f3d126mr1619831wmo.6.1699351870105; 
 Tue, 07 Nov 2023 02:11:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0iCW89dy7j421OF1kO6UGKYYzsLhdDOndmiRs6IJHOCEg6vdf7O8f3h+Xo5aG9qBzP6z9yQ==
X-Received: by 2002:a05:600c:46d2:b0:40a:20f3:d126 with SMTP id
 q18-20020a05600c46d200b0040a20f3d126mr1619812wmo.6.1699351869717; 
 Tue, 07 Nov 2023 02:11:09 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 x17-20020a05600c2d1100b004077219aed5sm14821417wmf.6.2023.11.07.02.11.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:11:09 -0800 (PST)
Date: Tue, 7 Nov 2023 05:11:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 22/63] vdpa: Restore receive-side scaling state
Message-ID: <b3c09106559f9d84a940d2a27c4cfc81c9e15347.1699351720.git.mst@redhat.com>
References: <cover.1699351720.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1699351720.git.mst@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Hawkins Jiawei <yin31149@gmail.com>

This patch reuses vhost_vdpa_net_load_rss() with some
refactorings to restore the receive-side scaling state
at device's startup.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Message-Id: <cf5b78a16ed0318982ceffb195f2227f6aad4ac1.1698195059.git.yin31149@gmail.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
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
MST


