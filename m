Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 368457E3886
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:12:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J38-0003be-40; Tue, 07 Nov 2023 05:11:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J30-0002xz-GE
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:11:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J2y-0002Up-NT
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:11:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699351860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lwNZq3J0BZTlZC7w878PfX1koj5w7HE98022Wpi/7iY=;
 b=QQA1sLCztCuSVTnd4h7kUvFZupcfvtjiRisKzYOD6ym/E7kuMc2F4yUPIwJ5DJYxjw0Sj2
 zFSaVZPf7N0QnNnP087KIwNfCQmJk+3KVShRFv+E16uUJHIB3ZkfnizgaySihZ2SzuqhEt
 wBRzPrUEFsVk32faw7tvCAVl2xVdO0o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-phf6HhaNPEG0S310GYf6pg-1; Tue, 07 Nov 2023 05:10:58 -0500
X-MC-Unique: phf6HhaNPEG0S310GYf6pg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4083c9b426fso34438755e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:10:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699351857; x=1699956657;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lwNZq3J0BZTlZC7w878PfX1koj5w7HE98022Wpi/7iY=;
 b=OsSEsPGWsNzfEA09LqwtpuyNDDs8y4kJIWi1ji9AzqqRF6E5de9qOndDmzqk2AIAWa
 iZZs/Kw2FQL0Hl7Xbu/y16M24vgfDUIvKf0orbOXyqDkbovCEPcMZZzV6tg3RoBxV9N+
 bCWF1cBqioPU5qlYaOadJ7eyKMIecWChgTTeXDdvoNc+lmEsjotoZEQhVR7BwID38Amx
 vMo483oLlN017efaBxZAYjG4OdS3A93xvB8RwpwgWpgP97eJz+/pieKiZD23iTdk8HUe
 KtfKHAhJTq7Ke+LeNM9v+gBBdpUGu8CwK/85nP9EELJB9qessFvvSDksO+tCOMhBIJw8
 j6xw==
X-Gm-Message-State: AOJu0Yw/zzDD5ji6NerIeOblx8UROuwGJ930slFMqg/bybI9YKKh4TJH
 Yyd/mTEg1OV3OmpfUfE6veeY2ssfZcRsM2V2HTgIaD51xIaP/1Dnzup433vp6ZrYN6U1b9ZLOiv
 ee7ukgcMpVlTVoNZjrijjcZPH09OzfCsmppUXTUeVtqw65oeHRIJaQ31jCdMEv2eW/AEU
X-Received: by 2002:a5d:6dae:0:b0:32f:7c01:5376 with SMTP id
 u14-20020a5d6dae000000b0032f7c015376mr25404268wrs.31.1699351857155; 
 Tue, 07 Nov 2023 02:10:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/52wyFaN00HbAl/jur4LC2XEZNyP0vxTVUylcplucZEswlKSNWJDVwB90FmzERzO/dglitA==
X-Received: by 2002:a5d:6dae:0:b0:32f:7c01:5376 with SMTP id
 u14-20020a5d6dae000000b0032f7c015376mr25404248wrs.31.1699351856778; 
 Tue, 07 Nov 2023 02:10:56 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 j6-20020a5d6046000000b0032fc5f5abafsm1895042wrt.96.2023.11.07.02.10.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:10:56 -0800 (PST)
Date: Tue, 7 Nov 2023 05:10:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 19/63] vdpa: Restore hash calculation state
Message-ID: <8b98c15f22fca34f23846e70752a70e4a2469317.1699351720.git.mst@redhat.com>
References: <cover.1699351720.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1699351720.git.mst@redhat.com>
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

This patch introduces vhost_vdpa_net_load_rss() to restore
the hash calculation state at device's startup.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Message-Id: <dbf699acff8c226596136a55a6abe35ebfeac8b0.1698194366.git.yin31149@gmail.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 7a226c93bc..e59d40b8ae 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -818,6 +818,88 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n,
     return 0;
 }
 
+static int vhost_vdpa_net_load_rss(VhostVDPAState *s, const VirtIONet *n,
+                                   struct iovec *out_cursor,
+                                   struct iovec *in_cursor)
+{
+    struct virtio_net_rss_config cfg = {};
+    ssize_t r;
+    g_autofree uint16_t *table = NULL;
+
+    /*
+     * According to VirtIO standard, "Initially the device has all hash
+     * types disabled and reports only VIRTIO_NET_HASH_REPORT_NONE.".
+     *
+     * Therefore, there is no need to send this CVQ command if the
+     * driver disables the all hash types, which aligns with
+     * the device's defaults.
+     *
+     * Note that the device's defaults can mismatch the driver's
+     * configuration only at live migration.
+     */
+    if (!n->rss_data.enabled ||
+        n->rss_data.hash_types == VIRTIO_NET_HASH_REPORT_NONE) {
+        return 0;
+    }
+
+    table = g_malloc_n(n->rss_data.indirections_len,
+                       sizeof(n->rss_data.indirections_table[0]));
+    cfg.hash_types = cpu_to_le32(n->rss_data.hash_types);
+
+    /*
+     * According to VirtIO standard, "Field reserved MUST contain zeroes.
+     * It is defined to make the structure to match the layout of
+     * virtio_net_rss_config structure, defined in 5.1.6.5.7.".
+     *
+     * Therefore, we need to zero the fields in
+     * struct virtio_net_rss_config, which corresponds to the
+     * `reserved` field in struct virtio_net_hash_config.
+     *
+     * Note that all other fields are zeroed at their definitions,
+     * except for the `indirection_table` field, where the actual data
+     * is stored in the `table` variable to ensure compatibility
+     * with RSS case. Therefore, we need to zero the `table` variable here.
+     */
+    table[0] = 0;
+
+    /*
+     * Considering that virtio_net_handle_rss() currently does not restore
+     * the hash key length parsed from the CVQ command sent from the guest
+     * into n->rss_data and uses the maximum key length in other code, so
+     * we also employ the maximum key length here.
+     */
+    cfg.hash_key_length = sizeof(n->rss_data.key);
+
+    const struct iovec data[] = {
+        {
+            .iov_base = &cfg,
+            .iov_len = offsetof(struct virtio_net_rss_config,
+                                indirection_table),
+        }, {
+            .iov_base = table,
+            .iov_len = n->rss_data.indirections_len *
+                       sizeof(n->rss_data.indirections_table[0]),
+        }, {
+            .iov_base = &cfg.max_tx_vq,
+            .iov_len = offsetof(struct virtio_net_rss_config, hash_key_data) -
+                       offsetof(struct virtio_net_rss_config, max_tx_vq),
+        }, {
+            .iov_base = (void *)n->rss_data.key,
+            .iov_len = sizeof(n->rss_data.key),
+        }
+    };
+
+    r = vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
+                                VIRTIO_NET_CTRL_MQ,
+                                VIRTIO_NET_CTRL_MQ_HASH_CONFIG,
+                                data, ARRAY_SIZE(data));
+    if (unlikely(r < 0)) {
+        return r;
+    }
+
+    return 0;
+}
+
 static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
                                   const VirtIONet *n,
                                   struct iovec *out_cursor,
@@ -843,6 +925,15 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
         return r;
     }
 
+    if (!virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_HASH_REPORT)) {
+        return 0;
+    }
+
+    r = vhost_vdpa_net_load_rss(s, n, out_cursor, in_cursor);
+    if (unlikely(r < 0)) {
+        return r;
+    }
+
     return 0;
 }
 
-- 
MST


