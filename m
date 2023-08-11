Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4A6779236
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 16:52:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUTTt-0005tR-Pv; Fri, 11 Aug 2023 10:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qUTTr-0005t4-PZ
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 10:51:11 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qUTTq-00022M-7o
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 10:51:11 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bc3d94d40fso18254315ad.3
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 07:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691765469; x=1692370269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3DMuVNULUVy23JpCXi1mERaaGVw+Y7a2st0eZNSjR6o=;
 b=pVTdJ7Ogla0bPfAPoRy+vW+nDMNiZEW0mKtjlPXl8IHW60DFpcsFb7swGzzuPo+kOq
 BJ5k+YOeCbv0+ijeLfzgp1b+76jdW8/5pHKwGiFarw2YcdxkCWTjuDSyKIaShESm/kv8
 tKo4bGs2VIZNRGphVcQy2EchAwJoRm7L0cd5NliujQdz+2f31rhTpXotCiLGLv3WtbvS
 xbqadxlu+yJSzXWUfZr+CCcKwNXSKVD97yZ9xr9NN3OJJxESDOmfKhoi917gzqkBP1Di
 fHOWbkyb8EJ6P4JGwGdASPuWi5lZA1wPkN/9zqQ5qBlGjKbxaoZO495E4DMbdC4MjfcN
 4qSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691765469; x=1692370269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3DMuVNULUVy23JpCXi1mERaaGVw+Y7a2st0eZNSjR6o=;
 b=YxOE32GVkmGSOlEo6F3aG+BoLXo5WK6JIbP+JlYhHXu1jlXMxxrnN597/o8uwfO0EH
 RYkMPPImTbrm4GJ6RO7Ac5+QnanH07GY+4Z9KfjKqw2L6P/i8pHEkZxvRu1rBbIq8W16
 itEP8dCzZEnIZ9FoAWCIKnkec8S7tg4Cv/qVJVo99JlvJLCiESpfawEtrl9Ei5lgjDXS
 Zd4/vlNo3kUC4P+W9nD5N+wH/1vmowKS35FGH21p3Hzj21PKFC9VXdUClGsJRz97/T6c
 QZmzqt+eqgMQ2UFtmK6/bautunT3iiK3KSeS1HLU3JZgdlPfVqZLN+/ADN9aH3q8pxN3
 9f0Q==
X-Gm-Message-State: AOJu0Yyqh3O13PpxGiHFG9o2Yin0TpzFyfGqwW9vbY2kT5nQvqAV+yQD
 kTsC6lm3IjWkME/14j16KqY=
X-Google-Smtp-Source: AGHT+IEsD21AfwTk+63Sf07GHU+YPpqowrAI1neZ2XtL7lGOgKGG6eWl5mzfHeTqqvLDTWWrbFtwIw==
X-Received: by 2002:a17:902:a407:b0:1bc:5197:73c5 with SMTP id
 p7-20020a170902a40700b001bc519773c5mr2032712plq.54.1691765468628; 
 Fri, 11 Aug 2023 07:51:08 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 x12-20020a170902ec8c00b001b1a2c14a4asm3993750plg.38.2023.08.11.07.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 07:51:08 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org, yin31149@gmail.com, 18801353760@163.com,
 yuri.benditovich@daynix.com
Subject: [RFC PATCH 1/2] vdpa: Restore hash calculation state
Date: Fri, 11 Aug 2023 22:50:49 +0800
Message-Id: <a54ca70b12ebe2f3c391864e41241697ab1aba30.1691762906.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1691762906.git.yin31149@gmail.com>
References: <cover.1691762906.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=yin31149@gmail.com; helo=mail-pl1-x62d.google.com
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

 net/vhost-vdpa.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 7bb29f6009..bd51020771 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -788,6 +788,85 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n,
     return 0;
 }
 
+static int vhost_vdpa_net_load_rss(VhostVDPAState *s, const VirtIONet *n,
+                                   void **out_cursor, void **in_cursor,
+                                   bool do_rss)
+{
+    struct virtio_net_rss_config cfg;
+    ssize_t r;
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
+    /*
+     * Consider that virtio_net_handle_rss() currently does not restore the
+     * hash key length parsed from the CVQ command sent from the guest into
+     * n->rss_data and uses the maximum key length in other code, so we also
+     * employthe the maxium key length here.
+     */
+    cfg.hash_key_length = sizeof(n->rss_data.key);
+
+    g_autofree uint16_t *table = g_malloc_n(n->rss_data.indirections_len,
+                                    sizeof(n->rss_data.indirections_table[0]));
+    for (int i = 0; i < n->rss_data.indirections_len; ++i) {
+        table[i] = cpu_to_le16(n->rss_data.indirections_table[i]);
+    }
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
                                   void **out_cursor, void **in_cursor)
@@ -812,6 +891,15 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
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


