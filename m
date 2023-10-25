Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FD17D5F51
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 03:03:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvSID-0005AL-90; Tue, 24 Oct 2023 21:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qvSIA-0005A9-Vo
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 21:02:38 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qvSI9-0007XJ-2W
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 21:02:38 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-68fb85afef4so4387878b3a.1
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 18:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698195756; x=1698800556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WRR6oQ/x6XwW2GrevfWEufzkvx9Ekrh4jY/lT89RnKI=;
 b=Fy9wsTHouX3gA1MiW4vYFkQOjogB5xrbn4T+Kqwz6zK7HdKs/QXm9f2VoOixmUGiaq
 fgYhNhwN/3wGChgvNsEbCz8j8vSwMVgHzVMIell0kotLmM7yiYyFDSHrd6DtxC3RuBkr
 FqaVfvO3u73AXQOPuBccVjGW+TeN/A87gFtLZ4+uqO/KN+L081AIN7K2xEJsL9EzvlDo
 iBXc7Wt32WoQ0TNEwapaL5WRNYWUcLMBRsLiQBhS34fOPDKZojVml9GTJjUTZYfl/lpw
 hzOFkqL2Yj/6Jov3ax1iysbs1IrW7jc0Yp/KOUp+PWs7IAhx+3uZgneV+mrDFZFlJ7C/
 llaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698195756; x=1698800556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WRR6oQ/x6XwW2GrevfWEufzkvx9Ekrh4jY/lT89RnKI=;
 b=WpxzLxTVmV3XtfU2X0Ug4unRqtSx2SUnHL0cNTvZY3NZNoZM7lUqBJ0P/15IWDGH2z
 9mP88VpYHktktFb/RQLpt2RuV+6zFYTAXcEWLyIXJAff+5IOJ5jt06+gkrNlCKg2YXVo
 A02GdoL1nv6GxGD6EQXXeiabYg0nux23S0RFir1I0CcPwViUPEFVXoVZRvfEZgQd/Ib4
 XB1wjqHVXuKJ443zyrccEXczI0hvvQhpVAwf3QkGdzud9/hF2Z51RXoWRZcLhMzstjXD
 R8erf0y7pYiBY1dDkllREI+1KW7Gm5u+v+05BgCzFnsypH0N0Q7UF33hnhnOYryXV51E
 /gGQ==
X-Gm-Message-State: AOJu0YzeFkZVGZyQAtkZYgNyDfigYL5kqj8HzDRYazLDz1wDHBj5W//d
 p+JevZi62lrrO4Ic9PnNVHU=
X-Google-Smtp-Source: AGHT+IFTnBcSPVQEOwBhB8aLfL64/lKfYAn+Ejl1fvNJcuyg8R9U2ZX+LrjerUp4aP5RiGyzsYOAYQ==
X-Received: by 2002:a05:6a21:595:b0:15b:c800:48af with SMTP id
 lw21-20020a056a21059500b0015bc80048afmr4192797pzb.23.1698195755539; 
 Tue, 24 Oct 2023 18:02:35 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 fb22-20020a056a002d9600b006be17e60708sm8177250pfb.204.2023.10.24.18.02.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 18:02:35 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v4 1/2] vdpa: Restore hash calculation state
Date: Wed, 25 Oct 2023 09:02:24 +0800
Message-Id: <dbf699acff8c226596136a55a6abe35ebfeac8b0.1698194366.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1698194366.git.yin31149@gmail.com>
References: <cover.1698194366.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=yin31149@gmail.com; helo=mail-pf1-x431.google.com
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
v4:
  - fix some typos pointed out by Michael
  - zero the `cfg` fields at the definition suggested by Michael

v3: https://patchwork.kernel.org/project/qemu-devel/patch/b7cd0c8d6a58b16b086f11714d2908ad35c67caa.1697902949.git.yin31149@gmail.com/
  - remove the `do_rss` argument in vhost_vdpa_net_load_rss()
  - zero reserved fields in "cfg" manually instead of using memset()
to prevent compiler "array-bounds" warning

v2: https://lore.kernel.org/all/f5ffad10699001107022851e0560cb394039d6b0.1693297766.git.yin31149@gmail.com/
  - resolve conflict with updated patch
"vdpa: Send all CVQ state load commands in parallel"
  - move the `table` declaration at the beginning of the
vhost_vdpa_net_load_rss()

RFC: https://lore.kernel.org/all/a54ca70b12ebe2f3c391864e41241697ab1aba30.1691762906.git.yin31149@gmail.com/

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
2.25.1


