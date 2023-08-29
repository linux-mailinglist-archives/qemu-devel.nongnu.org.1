Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7755378C0C4
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 10:49:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qauOz-0008LW-JS; Tue, 29 Aug 2023 04:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qauOr-0008Ka-R1
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 04:48:40 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qauOm-0007lQ-Nl
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 04:48:37 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-26814e27a9eso2167008a91.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 01:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693298910; x=1693903710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7A8bb42jd+n02BsnrgotugyR8FDt67yG4EBeqWrPXHM=;
 b=BNH8pkY8AzYXfpkkQ5pMXf3lqexDHx0Pz+xWneUKknfWcgNJhWTJWxJY980Ctoxbm5
 yfRMyLxZ6eN+DMOg3uEibA4swSV+QR8MWE1JVn57iNfbr/MfwOyjZUxHhugSNv7oJVr0
 uG34B14dPwcURHC4GKhS9dcJ1rNOhspSmdZfUx+SfUqqBWyLRR430xoFZWPeOsXL/moS
 xStxNm3cXtPwXqayYf/KqmsjfOnns6/IFxEeeYRNmFrQ6v4GCIMJNLpZHZZhWFv+Qu/y
 MBeyxEGs4OLlf60ysKEHApkMWCFlacqGGx4D8YgHxneO3bJ4xxDRfWZT/i3sZEhNStE3
 umLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693298910; x=1693903710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7A8bb42jd+n02BsnrgotugyR8FDt67yG4EBeqWrPXHM=;
 b=cekv6sTMkmyQWtcJB/VnF9FhK5c5C+BbnNvj4YBNHEGnkaOfoer4jqNNoilbBjrYqw
 L1+tAwDhc6c473HT3ilXXfrD4P3Es+cZehqF0cO+8aubri23zanKSeC/8djSSGxv4D3o
 Zt1GUYo0yey+BjEfykWQbOQMLgIMIx25mXOOQHf3KlUktpoOY4SWoaF+SSEhL6klraMg
 kflm6JRRuOFd+2DNmuiBJRAJ1sn+mr0IHlVFSI9R04YsQ1XcmzJEeehXTT71nqItabPP
 2ESeYux2PfLv8rke07CZoBCouUpJN/VOoi23Iy3rNH76bQu/a2ZAwyLrMyrOAXGVbWu/
 FmIg==
X-Gm-Message-State: AOJu0Yzrcbq4tAOd6yGx9fSrZkJs1fXXcL4WsKhGcQVRZVma88BRUZbB
 BiJdN2bNZJtwhEi6NHMMkdKqyLg0gdPb4J+h
X-Google-Smtp-Source: AGHT+IGbaQ1y2JPC+W4mjzJ4LEda9xODHd5f2bvpczAUAvTdKE1EXBPGxbTVPCxe6Aw9eMdnzgGEMg==
X-Received: by 2002:a17:90b:4a02:b0:26b:5205:525e with SMTP id
 kk2-20020a17090b4a0200b0026b5205525emr19650903pjb.42.1693298909963; 
 Tue, 29 Aug 2023 01:48:29 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 mq3-20020a17090b380300b002682523653asm8410789pjb.49.2023.08.29.01.48.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 01:48:29 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v2 1/2] vdpa: Restore hash calculation state
Date: Tue, 29 Aug 2023 16:48:15 +0800
Message-Id: <f5ffad10699001107022851e0560cb394039d6b0.1693297766.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1693297766.git.yin31149@gmail.com>
References: <cover.1693297766.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=yin31149@gmail.com; helo=mail-pj1-x1029.google.com
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

This patch introduces vhost_vdpa_net_load_rss() to restore
the hash calculation state at device's startup.

Note that vhost_vdpa_net_load_rss() has `do_rss` argument,
which allows future code to reuse this function to restore
the receive-side scaling state when the VIRTIO_NET_F_RSS
feature is enabled in SVQ. Currently, vhost_vdpa_net_load_rss()
could only be invoked when `do_rss` is set to false.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
Question:

It seems that virtio_net_handle_rss() currently does not restore the
hash key length parsed from the CVQ command sent from the guest into
n->rss_data and uses the maximum key length in other code.

So for `hash_key_length` field in VIRTIO_NET_CTRL_MQ_HASH_CONFIG command
sent to device, is it okay to also use the maximum key length as its value?
Or should we introduce the `hash_key_length` field in n->rss_data
structure to record the key length from guest and use this value?

ChangeLog:

v2:
  - resolve conflict with updated patch
"vdpa: Send all CVQ state load commands in parallel"
  - move the `table` declaration at the beginning of the
vhost_vdpa_net_load_rss()

RFC: https://lore.kernel.org/all/a54ca70b12ebe2f3c391864e41241697ab1aba30.1691762906.git.yin31149@gmail.com/

 net/vhost-vdpa.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 818464b702..139bb79468 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -805,6 +805,88 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n,
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
@@ -830,6 +912,15 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
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
2.25.1


