Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE7575997F
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 17:22:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM908-0001GM-2n; Wed, 19 Jul 2023 11:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1qM905-0001FJ-EM
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 11:22:01 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1qM903-00038I-LR
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 11:22:01 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-313e742a787so639553f8f.1
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 08:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1689780118; x=1690384918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FRF2E6P7sVcLvP4wqSAFGPs7SegT5a73p9SOCWkZw+Y=;
 b=BJX/Ch7OhFKm4hvg5hFojXGwAaXOZkD9mwYZAeTfDtPlVOa+tGekBwLkGKi8YUMdFk
 nrv7XsgvSM/ClRSvgVUPNK+GWgkLUq938+jOdbBtCKInZPTq4HMVVYkIzUK9bOuv51OA
 NV6GkzVTgQkDjB/z1e7+fhJKNU+MbZU1Dlr9Kc84rwvBHDYZqeXHvF/M9pwmT4ROQya3
 KTpEjukybyZPNjrO2GlWV23tIgxDZdt0H2ju0UIqdttB8PflsxrAWvmfWs3FKV/pEAaL
 0CoInBfv/mLfRwXrFsa3kuzzhcmQBJj4sP+cNRrWnjz0pNh4ouOnGTfcrFlTsan6fFlg
 qzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689780118; x=1690384918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FRF2E6P7sVcLvP4wqSAFGPs7SegT5a73p9SOCWkZw+Y=;
 b=gHoynl3X6lJlR1yvlNxB46PS3i7EsZ2G+K3lXPAOKZgLtmegaRRgf/OLWjkyKXQtTv
 9tg5TTQx3qpfZTP+G97/O/00/U1CDe+OCyDw3U/CwQFJyM41Kar7/10NE09pKtA3AKgR
 Jb81pwd3L6sUaW4o753paXoAY0a2ApTzb+nxQmTgE6TCU/mcvcN9E+dNm4i6dq7nOLou
 9Hjkf24z1zze836FPJMGYcTnqhaNFo/Eejhc400cwkNh6PyFpjkxsl78UhXDM0lmlM6k
 Zg4HCCOL8vh79/36eS1p4n8T8t+xlyn19f8nMYrynHMSuw1gX8QkAkGV4+Qoi6AnywIY
 Hfzg==
X-Gm-Message-State: ABy/qLYIrZZ5FN7UJqcpC93mefvtGXGQRY0N19eTk564HR8S20c0wXGS
 I7fEYZ19bzwgBnkJ/cHqXNWhRNP0l6PZjrhwRLQ=
X-Google-Smtp-Source: APBJJlH0X7OEHgMJO/MxwVYOHRguDkp+w2L1kZCbjBW7k5Jvjycx4TJjVAwF4iVC0cIsAGiohBofeA==
X-Received: by 2002:a05:6000:a:b0:313:df09:acfb with SMTP id
 h10-20020a056000000a00b00313df09acfbmr86310wrx.11.1689780118392; 
 Wed, 19 Jul 2023 08:21:58 -0700 (PDT)
Received: from localhost.localdomain
 ([2a06:c701:46e6:7e00:c5bb:d943:dc1b:8245])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a5d6349000000b0030e52d4c1bcsm5626775wrw.71.2023.07.19.08.21.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jul 2023 08:21:58 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, mst@redhat.com,
 Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org
Cc: yan@daynix.com,
	andrew@daynix.com
Subject: [PATCH 4/4] virtio-net: Added uso check
Date: Wed, 19 Jul 2023 18:21:39 +0300
Message-Id: <20230719152139.1316570-5-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20230719152139.1316570-1-yuri.benditovich@daynix.com>
References: <20230719152139.1316570-1-yuri.benditovich@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::42e;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Andrew Melnychenko <andrew@daynix.com>

Added tap uso check with stubs for non-Linux systems.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 hw/net/virtio-net.c | 15 +++++++++++++++
 include/net/net.h   |  3 +++
 net/net.c           |  9 +++++++++
 net/tap-bsd.c       |  5 +++++
 net/tap-linux.c     | 12 ++++++++++++
 net/tap-solaris.c   |  5 +++++
 net/tap-stub.c      |  5 +++++
 net/tap.c           | 12 ++++++++++++
 net/tap_int.h       |  1 +
 9 files changed, 67 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index e76cad923b..d950d3a77f 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -659,6 +659,15 @@ static int peer_has_ufo(VirtIONet *n)
     return n->has_ufo;
 }
 
+static int peer_has_uso(VirtIONet *n)
+{
+    if (!peer_has_vnet_hdr(n)) {
+        return 0;
+    }
+
+    return qemu_has_uso(qemu_get_queue(n->nic)->peer);
+}
+
 static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, int mergeable_rx_bufs,
                                        int version_1, int hash_report)
 {
@@ -808,6 +817,12 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
         virtio_clear_feature(&features, VIRTIO_NET_F_HOST_UFO);
     }
 
+    if (!peer_has_uso(n)) {
+        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_USO);
+        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO4);
+        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO6);
+    }
+
     if (!get_vhost_net(nc->peer)) {
         return features;
     }
diff --git a/include/net/net.h b/include/net/net.h
index b5ccfbbffb..330d285930 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -54,6 +54,7 @@ typedef void (LinkStatusChanged)(NetClientState *);
 typedef void (NetClientDestructor)(NetClientState *);
 typedef RxFilterInfo *(QueryRxFilter)(NetClientState *);
 typedef bool (HasUfo)(NetClientState *);
+typedef bool (HasUso)(NetClientState *);
 typedef bool (HasVnetHdr)(NetClientState *);
 typedef bool (HasVnetHdrLen)(NetClientState *, int);
 typedef bool (GetUsingVnetHdr)(NetClientState *);
@@ -84,6 +85,7 @@ typedef struct NetClientInfo {
     QueryRxFilter *query_rx_filter;
     NetPoll *poll;
     HasUfo *has_ufo;
+    HasUso *has_uso;
     HasVnetHdr *has_vnet_hdr;
     HasVnetHdrLen *has_vnet_hdr_len;
     GetUsingVnetHdr *get_using_vnet_hdr;
@@ -187,6 +189,7 @@ void qemu_set_info_str(NetClientState *nc,
                        const char *fmt, ...) G_GNUC_PRINTF(2, 3);
 void qemu_format_nic_info_str(NetClientState *nc, uint8_t macaddr[6]);
 bool qemu_has_ufo(NetClientState *nc);
+bool qemu_has_uso(NetClientState *nc);
 bool qemu_has_vnet_hdr(NetClientState *nc);
 bool qemu_has_vnet_hdr_len(NetClientState *nc, int len);
 bool qemu_get_using_vnet_hdr(NetClientState *nc);
diff --git a/net/net.c b/net/net.c
index 543e6dec43..b110e61f66 100644
--- a/net/net.c
+++ b/net/net.c
@@ -495,6 +495,15 @@ bool qemu_has_ufo(NetClientState *nc)
     return nc->info->has_ufo(nc);
 }
 
+bool qemu_has_uso(NetClientState *nc)
+{
+    if (!nc || !nc->info->has_uso) {
+        return false;
+    }
+
+    return nc->info->has_uso(nc);
+}
+
 bool qemu_has_vnet_hdr(NetClientState *nc)
 {
     if (!nc || !nc->info->has_vnet_hdr) {
diff --git a/net/tap-bsd.c b/net/tap-bsd.c
index abd16a2ad2..274ea7bd2c 100644
--- a/net/tap-bsd.c
+++ b/net/tap-bsd.c
@@ -212,6 +212,11 @@ int tap_probe_has_ufo(int fd)
     return 0;
 }
 
+int tap_probe_has_uso(int fd)
+{
+    return 0;
+}
+
 int tap_probe_vnet_hdr_len(int fd, int len)
 {
     return 0;
diff --git a/net/tap-linux.c b/net/tap-linux.c
index 30fcca1bc2..c7e514ecb0 100644
--- a/net/tap-linux.c
+++ b/net/tap-linux.c
@@ -173,6 +173,18 @@ int tap_probe_has_ufo(int fd)
     return 1;
 }
 
+int tap_probe_has_uso(int fd)
+{
+    unsigned offload;
+
+    offload = TUN_F_CSUM | TUN_F_USO4 | TUN_F_USO6;
+
+    if (ioctl(fd, TUNSETOFFLOAD, offload) < 0) {
+        return 0;
+    }
+    return 1;
+}
+
 /* Verify that we can assign given length */
 int tap_probe_vnet_hdr_len(int fd, int len)
 {
diff --git a/net/tap-solaris.c b/net/tap-solaris.c
index a617a10e5c..08b13af512 100644
--- a/net/tap-solaris.c
+++ b/net/tap-solaris.c
@@ -216,6 +216,11 @@ int tap_probe_has_ufo(int fd)
     return 0;
 }
 
+int tap_probe_has_uso(int fd)
+{
+    return 0;
+}
+
 int tap_probe_vnet_hdr_len(int fd, int len)
 {
     return 0;
diff --git a/net/tap-stub.c b/net/tap-stub.c
index ac8dfc03b4..4b24f61e3a 100644
--- a/net/tap-stub.c
+++ b/net/tap-stub.c
@@ -47,6 +47,11 @@ int tap_probe_has_ufo(int fd)
     return 0;
 }
 
+int tap_probe_has_uso(int fd)
+{
+    return 0;
+}
+
 int tap_probe_vnet_hdr_len(int fd, int len)
 {
     return 0;
diff --git a/net/tap.c b/net/tap.c
index 14ea4ef26f..bcea8d03f9 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -57,6 +57,7 @@ typedef struct TAPState {
     bool write_poll;
     bool using_vnet_hdr;
     bool has_ufo;
+    bool has_uso;
     bool enabled;
     VHostNetState *vhost_net;
     unsigned host_vnet_hdr_len;
@@ -237,6 +238,15 @@ static bool tap_has_ufo(NetClientState *nc)
     return s->has_ufo;
 }
 
+static bool tap_has_uso(NetClientState *nc)
+{
+    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+
+    assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
+
+    return s->has_uso;
+}
+
 static bool tap_has_vnet_hdr(NetClientState *nc)
 {
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
@@ -384,6 +394,7 @@ static NetClientInfo net_tap_info = {
     .poll = tap_poll,
     .cleanup = tap_cleanup,
     .has_ufo = tap_has_ufo,
+    .has_uso = tap_has_uso,
     .has_vnet_hdr = tap_has_vnet_hdr,
     .has_vnet_hdr_len = tap_has_vnet_hdr_len,
     .get_using_vnet_hdr = tap_get_using_vnet_hdr,
@@ -413,6 +424,7 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
     s->host_vnet_hdr_len = vnet_hdr ? sizeof(struct virtio_net_hdr) : 0;
     s->using_vnet_hdr = false;
     s->has_ufo = tap_probe_has_ufo(s->fd);
+    s->has_uso = tap_probe_has_uso(s->fd);
     s->enabled = true;
     tap_set_offload(&s->nc, 0, 0, 0, 0, 0, 0, 0);
     /*
diff --git a/net/tap_int.h b/net/tap_int.h
index d8861d81ba..9a2175655b 100644
--- a/net/tap_int.h
+++ b/net/tap_int.h
@@ -37,6 +37,7 @@ void tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp);
 int tap_probe_vnet_hdr(int fd, Error **errp);
 int tap_probe_vnet_hdr_len(int fd, int len);
 int tap_probe_has_ufo(int fd);
+int tap_probe_has_uso(int fd);
 void tap_fd_set_offload(int fd, int csum, int tso4, int tso6, int ecn, int ufo,
                         int uso4, int uso6);
 void tap_fd_set_vnet_hdr_len(int fd, int len);
-- 
2.34.3


