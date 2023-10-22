Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AFB7D20B9
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 04:02:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quNm8-0004vp-QC; Sat, 21 Oct 2023 22:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1quNm5-0004vB-Oa
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 22:01:05 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1quNm3-00004u-UC
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 22:01:05 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-584042a01eeso1369739eaf.2
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 19:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697940062; x=1698544862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7feFLnARMd+SZJPzS+6DbI77bPZef1Xa8Sanaf19r0g=;
 b=kndFusjqGUxneesNymIsyv/kyuxktJL+RhsP4AZJpSMo8iNAmmjCHaAopetfDgjUBr
 Z3r5Q5Uiu9CbPKv6S55uCvLrBJxWiYPfCcIro+ZfMnl24BE30xOOBYgjwfFvVzA/2UFr
 3vDV20me01lUJPulwNuH9M4jZG6XCtFJN/OyW8F04QYdtH8MgH2mVI2rOWA81IK+NZ3u
 sWWlNyfrG6ARAI3+RQGbYLA8Y7qiLmGcAnEJJBjwInYsnI7A7Pxzs9OLudrjbq9UU1Xe
 wikBFyLpxSqOZZvlu4t7pf/Su1SIU2UiOk/rrSHdYYk2yTwI2KXa9SIddZCtk5HtsprX
 H06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697940062; x=1698544862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7feFLnARMd+SZJPzS+6DbI77bPZef1Xa8Sanaf19r0g=;
 b=D5Ac70rMgHoZjD/HMhQME0kVKPFpI7Eufmw9QQW3lOzRU9UaAEXhFLqk0D07cDAEOv
 ViEiABWtBdjtKkNkq+JAsNlSQLC+2jDkUdMi+zK00m/6Zj2zxDBjofwUGyfKBn4F0xYA
 FESQ7QnRZRDp15RNBL8G68YwhiESVf21GvUkjoh0Gs+YqqCPC5DcgSTiqb8SfIF6uRAV
 KOkc/Q2Swe5vGFrMwBbAHPZltTzQ3kzPWuJNSi0HQVKzmlaLs5Hl/YWl05WuonyFbKjG
 ABFH6z6VAb1M43zvrxCSzLmCO9yPvdXy/JZs6awFnzWVm3eGz1FnEsT0FiSERhfb9B+O
 k+yQ==
X-Gm-Message-State: AOJu0Yz+KKfZhy/HUJN4R3U8p7f45sqt5lrklXg02cQ/f/RDep7ZJ5VY
 mvDHpdptNkk2FCzaUl+z01M=
X-Google-Smtp-Source: AGHT+IGTVfzSjQ5NKXwuIIU+zhcxj/HCenI1fD3Xm4tc2Yo/uqZHQjkRgxnD4SJitFcIgxZFmahqug==
X-Received: by 2002:a05:6358:33a1:b0:12f:158e:ed88 with SMTP id
 i33-20020a05635833a100b0012f158eed88mr7746049rwd.22.1697940062297; 
 Sat, 21 Oct 2023 19:01:02 -0700 (PDT)
Received: from localhost ([124.64.17.222]) by smtp.gmail.com with ESMTPSA id
 s187-20020a625ec4000000b0068ff267f094sm3997284pfb.158.2023.10.21.19.01.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 19:01:01 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v3 1/2] vdpa: Restore hash calculation state
Date: Sun, 22 Oct 2023 10:00:48 +0800
Message-Id: <b7cd0c8d6a58b16b086f11714d2908ad35c67caa.1697902949.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1697902949.git.yin31149@gmail.com>
References: <cover.1697902949.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=yin31149@gmail.com; helo=mail-oo1-xc33.google.com
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

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
v3:
  - remove the `do_rss` argument in vhost_vdpa_net_load_rss()
  - zero reserved fields in "cfg" manually instead of using memset()
to prevent compiler "array-bounds" warning

v2: https://lore.kernel.org/all/f5ffad10699001107022851e0560cb394039d6b0.1693297766.git.yin31149@gmail.com/
  - resolve conflict with updated patch
"vdpa: Send all CVQ state load commands in parallel"
  - move the `table` declaration at the beginning of the
vhost_vdpa_net_load_rss()

RFC: https://lore.kernel.org/all/a54ca70b12ebe2f3c391864e41241697ab1aba30.1691762906.git.yin31149@gmail.com/

 net/vhost-vdpa.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 4b7c3b81b8..2e4bad65b4 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -817,6 +817,86 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n,
     return 0;
 }
 
+static int vhost_vdpa_net_load_rss(VhostVDPAState *s, const VirtIONet *n,
+                                   struct iovec *out_cursor,
+                                   struct iovec *in_cursor)
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
+    table = g_malloc_n(n->rss_data.indirections_len,
+                       sizeof(n->rss_data.indirections_table[0]));
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
+    cfg.indirection_table_mask = 0;
+    cfg.unclassified_queue = 0;
+    table[0] = 0; /* the actual indirection table for cfg */
+    cfg.max_tx_vq = 0;
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
@@ -842,6 +922,15 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
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
2.25.1


