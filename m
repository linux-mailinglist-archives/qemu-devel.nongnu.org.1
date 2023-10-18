Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7A27CE1E8
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 17:57:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8rt-00059p-OU; Wed, 18 Oct 2023 11:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8rr-0004yi-VQ
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:53:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8rq-0006NU-Cb
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WotlR6MwHv4Nd3GfFkTO3DbeM+x4JzncXWx5AQNhzFU=;
 b=VahAxSI1X44TbNgg8hmjgSxc1bnv9clEzns+konnl3+A5H4h4z4K7UQ4aDqmZhp7jOn1S+
 tiEiZL2gXUozfwDssmqduPBd/8RMQOD34OryGcL9dWbD/6WBDOCD14OsPik25DndWLN+HI
 PfBpQW/ahIv6BpqVPgqXnsF6/9/Kkt0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314--brqh_OmNhuxMj5CfVFK5w-1; Wed, 18 Oct 2023 11:53:52 -0400
X-MC-Unique: -brqh_OmNhuxMj5CfVFK5w-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32db6a28e24so1978508f8f.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:53:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644430; x=1698249230;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WotlR6MwHv4Nd3GfFkTO3DbeM+x4JzncXWx5AQNhzFU=;
 b=hpzGh/bQZGwVjhKntgcYlCJ5qX5EHHh5PIPZMj75mVPN3haoi417O7timgMeGOSA2O
 4i7nUr4xXPIPL/mLUVvqMrnR405EkgwlYx8KjSa/mf2uLI+/gcyqDOcb0gCB+qWjkbCb
 rhBGbl6x//qLbwXJrg43vqnH+Q2YqiLm2dB3X/+/CNqQAfothSCpDJeJl/cX2t8fDnn2
 kWF27My5uYMPMDNc3ZBapxzUBvgaWM8hzbFKxzDeyHnKya4Pujsj1AGtPg+e5oKDy5Hg
 cX3xv71sMG19EYdtfYEeH1A6Z2DJ2gk15T/t+4N3lX5Rf4LS41q5f0JQ541bnmUzZpja
 H5NQ==
X-Gm-Message-State: AOJu0YyaVvEyFODD+lrUBtsuo8UyOPnsVpQELa88IyEatKuBoxdPHhLk
 kEbSifUbv49CvXv/iS0XqJJL43qh7GwKDN43xQwMVLK/lPSXf/YcGtSLqowAvcuC+fmRsDNoImH
 Xw5ECItnE+wOiXSb1bT3kaY0aRfKeFmBq+HwVDw8K2Y1NxJOz+X0GLMEudghCziNYKnbowDM=
X-Received: by 2002:adf:e50f:0:b0:32d:9ce0:35ae with SMTP id
 j15-20020adfe50f000000b0032d9ce035aemr4535777wrm.52.1697644430657; 
 Wed, 18 Oct 2023 08:53:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHJqGoc1XIPGCONuT8NLbhVrhOScjtRChZVNVocjgIrfWJ1XZ/wkS1zHlwXAL9RsYBQfgXAQ==
X-Received: by 2002:adf:e50f:0:b0:32d:9ce0:35ae with SMTP id
 j15-20020adfe50f000000b0032d9ce035aemr4535763wrm.52.1697644430379; 
 Wed, 18 Oct 2023 08:53:50 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 l13-20020a5d480d000000b0032d9523de65sm2369456wrq.48.2023.10.18.08.53.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:53:49 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:53:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 08/83] vdpa: Restore hash calculation state
Message-ID: <1908cfd6e1748d94680e468b9df6321087b8fcf2.1697644299.git.mst@redhat.com>
References: <cover.1697644299.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697644299.git.mst@redhat.com>
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

This patch introduces vhost_vdpa_net_load_rss() to restore
the hash calculation state at device's startup.

Note that vhost_vdpa_net_load_rss() has `do_rss` argument,
which allows future code to reuse this function to restore
the receive-side scaling state when the VIRTIO_NET_F_RSS
feature is enabled in SVQ. Currently, vhost_vdpa_net_load_rss()
could only be invoked when `do_rss` is set to false.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Message-Id: <f5ffad10699001107022851e0560cb394039d6b0.1693297766.git.yin31149@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 4b7c3b81b8..40d0bcbc0b 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -817,6 +817,88 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n,
     return 0;
 }
 
+static int vhost_vdpa_net_load_rss(VhostVDPAState *s, const VirtIONet *n,
+                                   struct iovec *out_cursor,
+                                   struct iovec *in_cursor, bool do_rss)
+{
+    struct virtio_net_rss_config cfg;
+    ssize_t r;
+    g_autofree uint16_t *table = NULL;
+
+    /*
+     * According to VirtIO standard, "Initially the device has all hash
+     * types disabled and reports only VIRTIO_NET_HASH_REPORT_NONE.".
+     *
+     * Therefore, there is no need to send this CVQ command if the
+     * driver disable the all hash types, which aligns with
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
+    cfg.hash_types = cpu_to_le32(n->rss_data.hash_types);
+
+    /*
+     * According to VirtIO standard, "Field reserved MUST contain zeroes.
+     * It is defined to make the structure to match the layout of
+     * virtio_net_rss_config structure, defined in 5.1.6.5.7.".
+     *
+     * Therefore, we need to zero the fields in struct virtio_net_rss_config,
+     * which corresponds the `reserved` field in
+     * struct virtio_net_hash_config.
+     */
+    memset(&cfg.indirection_table_mask, 0,
+           sizeof_field(struct virtio_net_hash_config, reserved));
+
+    table = g_malloc_n(n->rss_data.indirections_len,
+                       sizeof(n->rss_data.indirections_table[0]));
+    for (int i = 0; i < n->rss_data.indirections_len; ++i) {
+        table[i] = cpu_to_le16(n->rss_data.indirections_table[i]);
+    }
+
+    /*
+     * Consider that virtio_net_handle_rss() currently does not restore the
+     * hash key length parsed from the CVQ command sent from the guest into
+     * n->rss_data and uses the maximum key length in other code, so we also
+     * employthe the maxium key length here.
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
@@ -842,6 +924,15 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
         return r;
     }
 
+    if (!virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_HASH_REPORT)) {
+        return 0;
+    }
+
+    r = vhost_vdpa_net_load_rss(s, n, out_cursor, in_cursor, false);
+    if (unlikely(r < 0)) {
+        return r;
+    }
+
     return 0;
 }
 
-- 
MST


