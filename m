Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D7B7BCC71
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 07:43:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpMYr-0003Qb-4Z; Sun, 08 Oct 2023 01:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qpMYo-0003QD-2Z
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 01:42:38 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qpMYl-0002gQ-RH
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 01:42:37 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3ae2ec1a222so2418011b6e.2
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 22:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696743754; x=1697348554;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ETPUFn0hUWgvqmftil1y1SZBUPwFETxqxmqKWKXZSNM=;
 b=Pc3nHkg8fyh+kDguEUAeAiAqzCOBGrALgkwn43Jm6Uaqh2w6Hy0IhreZMoXT/K45zb
 ixBHBPH8yuANQxBE4sy7ud2qz1k10CVN8ZBRV2OnCpPFMpwcbxLX4778cnBeaFREUvhX
 7muUhKMqJo0J6Pi9clJ9bX71sV5tPhIjah/bXd0nal+Wth0jMNnovriU+3WQDTzJ+2Iy
 QHHATWasvdw5rFXxaH0H1+1dui86M7DbTA8ZskOpD6l5Ju9r1mBY7+Deae/fQ635z4Uk
 bYrNDk3SDnIl+3McM/Dq9edTSPxC/hrhGKD92iSaXjHQsEZ4A9BXcr5y8qxLumCuYtAS
 YAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696743754; x=1697348554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ETPUFn0hUWgvqmftil1y1SZBUPwFETxqxmqKWKXZSNM=;
 b=Dw6yMjsnMRoHbTE3Iue0vOnYDj0oGjUdBg6Ge9SEijRAdCYQICAQJQz3A5zlC1U36s
 kSSO01MtOPE/4UQJbHVvpjIsobqtUtu99DcsTOBerTuNxREapLLZEIc+w/Mnae2gW6ut
 YHcJYI+EFFc5+W7ITDPhDdKCRswclhaXwsn+qjQ/z/IQcUGCiPo7VOhvdKmA+R4CpXcM
 01KI9Piu2/U75W7vGEmUenV0fZnS61WOgCRb7ewRvtLm936yNy0ud8QcAsH1P2+gvP6O
 /YEMd1nzgoanOb9G99cs/4PsUBnxtKWRs5DuSJ2nmS3+Inzd8chR2tTjBPcr7hT6jJyM
 qtHQ==
X-Gm-Message-State: AOJu0YxeqkCeboJsntUl6Rvptpoh2MqZbJ53PJwgToOAPaMa8u/E1KEW
 fvG2cPYayXBEgxANSFRQYgtXSw==
X-Google-Smtp-Source: AGHT+IEsqdJqn720MV/L1x6E8mPKOFiiM/hoPGiSbuHe6wUfwG+Q4Dhn2uzDW/Sprd+0y+nwK7S4YQ==
X-Received: by 2002:a05:6808:1442:b0:3a7:6ff5:c628 with SMTP id
 x2-20020a056808144200b003a76ff5c628mr17012021oiv.11.1696743754520; 
 Sat, 07 Oct 2023 22:42:34 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 it19-20020a056a00459300b0069305627494sm3983933pfb.165.2023.10.07.22.42.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Oct 2023 22:42:34 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [RFC PATCH 1/4] net: Allow to offload virtio-net hashing
Date: Sun,  8 Oct 2023 14:42:15 +0900
Message-ID: <20231008054222.146228-2-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231008054222.146228-1-akihiko.odaki@daynix.com>
References: <20231008054222.146228-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::22c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x22c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Offloading virtio-net hashing to the client can improve the performance
since the performance can reuse the hash calculated for RSS for hash
reporting as well.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/net/net.h | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 net/tap_int.h     |  3 +++
 net/net.c         | 14 ++++++++++++++
 net/tap-bsd.c     | 10 ++++++++++
 net/tap-linux.c   | 10 ++++++++++
 net/tap-solaris.c | 10 ++++++++++
 net/tap-stub.c    | 10 ++++++++++
 net/tap.c         | 14 ++++++++++++++
 8 files changed, 118 insertions(+)

diff --git a/include/net/net.h b/include/net/net.h
index 685ec58318..7eafef1703 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -35,6 +35,47 @@ typedef struct NICConf {
     int32_t bootindex;
 } NICConf;
 
+#ifdef CONFIG_LINUX
+#ifndef TUNGETVNETHASHCAP
+#define TUNGETVNETHASHCAP _IO('T', 228)
+#define TUNSETVNETHASH _IOW('T', 229, unsigned int)
+
+struct tun_vnet_hash_cap {
+    uint16_t max_indirection_table_length;
+    uint32_t types;
+};
+
+#define TUN_VNET_HASH_RSS 0x01
+#define TUN_VNET_HASH_REPORT 0x02
+struct tun_vnet_hash {
+    uint8_t flags;
+    uint32_t types;
+    uint16_t indirection_table_mask;
+    uint16_t unclassified_queue;
+};
+#endif
+
+typedef struct tun_vnet_hash_cap NetVnetHashCap;
+typedef struct tun_vnet_hash NetVnetHash;
+#define NET_VNET_HASH_RSS TUN_VNET_HASH_RSS
+#define NET_VNET_HASH_REPORT TUN_VNET_HASH_REPORT
+#else
+#define NET_VNET_HASH_RSS 1
+#define NET_VNET_HASH_REPORT 2
+
+typedef struct NetVnetHashCap {
+    uint16_t max_indirection_table_length;
+    uint32_t types;
+} NetVnetHashCap;
+
+typedef struct NetVnetHash {
+    uint8_t flags;
+    uint32_t types;
+    uint16_t indirection_table_mask;
+    uint16_t unclassified_queue;
+} NetVnetHash;
+#endif
+
 #define DEFINE_NIC_PROPERTIES(_state, _conf)                            \
     DEFINE_PROP_MACADDR("mac",   _state, _conf.macaddr),                \
     DEFINE_PROP_NETDEV("netdev", _state, _conf.peers)
@@ -61,6 +102,8 @@ typedef void (UsingVnetHdr)(NetClientState *, bool);
 typedef void (SetOffload)(NetClientState *, int, int, int, int, int);
 typedef int (GetVnetHdrLen)(NetClientState *);
 typedef void (SetVnetHdrLen)(NetClientState *, int);
+typedef bool (GetVnetHashCap)(NetClientState *, NetVnetHashCap *);
+typedef void (SetVnetHash)(NetClientState *, const void *);
 typedef int (SetVnetLE)(NetClientState *, bool);
 typedef int (SetVnetBE)(NetClientState *, bool);
 typedef struct SocketReadState SocketReadState;
@@ -93,6 +136,8 @@ typedef struct NetClientInfo {
     SetVnetHdrLen *set_vnet_hdr_len;
     SetVnetLE *set_vnet_le;
     SetVnetBE *set_vnet_be;
+    GetVnetHashCap *get_vnet_hash_cap;
+    SetVnetHash *set_vnet_hash;
     NetAnnounce *announce;
     SetSteeringEBPF *set_steering_ebpf;
     NetCheckPeerType *check_peer_type;
@@ -197,6 +242,8 @@ void qemu_set_offload(NetClientState *nc, int csum, int tso4, int tso6,
                       int ecn, int ufo);
 int qemu_get_vnet_hdr_len(NetClientState *nc);
 void qemu_set_vnet_hdr_len(NetClientState *nc, int len);
+bool qemu_get_vnet_hash_cap(NetClientState *nc, NetVnetHashCap *cap);
+void qemu_set_vnet_hash(NetClientState *nc, const void *hash);
 int qemu_set_vnet_le(NetClientState *nc, bool is_le);
 int qemu_set_vnet_be(NetClientState *nc, bool is_be);
 void qemu_macaddr_default_if_unset(MACAddr *macaddr);
diff --git a/net/tap_int.h b/net/tap_int.h
index 547f8a5a28..aa36615600 100644
--- a/net/tap_int.h
+++ b/net/tap_int.h
@@ -27,6 +27,7 @@
 #define NET_TAP_INT_H
 
 #include "qapi/qapi-types-net.h"
+#include "net/net.h"
 
 int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
              int vnet_hdr_required, int mq_required, Error **errp);
@@ -36,9 +37,11 @@ ssize_t tap_read_packet(int tapfd, uint8_t *buf, int maxlen);
 void tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp);
 int tap_probe_vnet_hdr(int fd, Error **errp);
 int tap_probe_vnet_hdr_len(int fd, int len);
+bool tap_probe_vnet_hash_cap(int fd, NetVnetHashCap *cap);
 int tap_probe_has_ufo(int fd);
 void tap_fd_set_offload(int fd, int csum, int tso4, int tso6, int ecn, int ufo);
 void tap_fd_set_vnet_hdr_len(int fd, int len);
+void tap_fd_set_vnet_hash(int fd, const void *hash);
 int tap_fd_set_vnet_le(int fd, int vnet_is_le);
 int tap_fd_set_vnet_be(int fd, int vnet_is_be);
 int tap_fd_enable(int fd);
diff --git a/net/net.c b/net/net.c
index 3523cceafc..53372dc6aa 100644
--- a/net/net.c
+++ b/net/net.c
@@ -562,6 +562,20 @@ void qemu_set_vnet_hdr_len(NetClientState *nc, int len)
     nc->info->set_vnet_hdr_len(nc, len);
 }
 
+bool qemu_get_vnet_hash_cap(NetClientState *nc, NetVnetHashCap *cap)
+{
+    if (!nc || !nc->info->get_vnet_hash_cap) {
+        return false;
+    }
+
+    return nc->info->get_vnet_hash_cap(nc, cap);
+}
+
+void qemu_set_vnet_hash(NetClientState *nc, const void *hash)
+{
+    nc->info->set_vnet_hash(nc, hash);
+}
+
 int qemu_set_vnet_le(NetClientState *nc, bool is_le)
 {
 #if HOST_BIG_ENDIAN
diff --git a/net/tap-bsd.c b/net/tap-bsd.c
index 4c98fdd337..503faecb67 100644
--- a/net/tap-bsd.c
+++ b/net/tap-bsd.c
@@ -217,10 +217,20 @@ int tap_probe_vnet_hdr_len(int fd, int len)
     return 0;
 }
 
+bool tap_probe_vnet_hash_cap(int fd, NetVnetHashCap *cap)
+{
+    return false;
+}
+
 void tap_fd_set_vnet_hdr_len(int fd, int len)
 {
 }
 
+void tap_fd_set_vnet_hash(int fd, const void *hash)
+{
+    g_assert_not_reached();
+}
+
 int tap_fd_set_vnet_le(int fd, int is_le)
 {
     return -EINVAL;
diff --git a/net/tap-linux.c b/net/tap-linux.c
index f54f308d35..0877f11df2 100644
--- a/net/tap-linux.c
+++ b/net/tap-linux.c
@@ -193,6 +193,11 @@ int tap_probe_vnet_hdr_len(int fd, int len)
     return 1;
 }
 
+bool tap_probe_vnet_hash_cap(int fd, NetVnetHashCap *cap)
+{
+    return !ioctl(fd, TUNGETVNETHASHCAP, cap);
+}
+
 void tap_fd_set_vnet_hdr_len(int fd, int len)
 {
     if (ioctl(fd, TUNSETVNETHDRSZ, &len) == -1) {
@@ -202,6 +207,11 @@ void tap_fd_set_vnet_hdr_len(int fd, int len)
     }
 }
 
+void tap_fd_set_vnet_hash(int fd, const void *hash)
+{
+    assert(!ioctl(fd, TUNSETVNETHASH, hash));
+}
+
 int tap_fd_set_vnet_le(int fd, int is_le)
 {
     int arg = is_le ? 1 : 0;
diff --git a/net/tap-solaris.c b/net/tap-solaris.c
index 38e15028bf..40e93e3a40 100644
--- a/net/tap-solaris.c
+++ b/net/tap-solaris.c
@@ -221,10 +221,20 @@ int tap_probe_vnet_hdr_len(int fd, int len)
     return 0;
 }
 
+bool tap_probe_vnet_hash_cap(int fd, NetVnetHashCap *cap)
+{
+    return false;
+}
+
 void tap_fd_set_vnet_hdr_len(int fd, int len)
 {
 }
 
+void tap_fd_set_vnet_hash(int fd, const void *hash)
+{
+    g_assert_not_reached();
+}
+
 int tap_fd_set_vnet_le(int fd, int is_le)
 {
     return -EINVAL;
diff --git a/net/tap-stub.c b/net/tap-stub.c
index a0fa25804b..39ce77676a 100644
--- a/net/tap-stub.c
+++ b/net/tap-stub.c
@@ -52,10 +52,20 @@ int tap_probe_vnet_hdr_len(int fd, int len)
     return 0;
 }
 
+bool tap_probe_vnet_hash_cap(int fd, NetVnetHashCap *cap)
+{
+    return false;
+}
+
 void tap_fd_set_vnet_hdr_len(int fd, int len)
 {
 }
 
+void tap_fd_set_vnet_hash(int fd, const void *hash)
+{
+    g_assert_not_reached();
+}
+
 int tap_fd_set_vnet_le(int fd, int is_le)
 {
     return -EINVAL;
diff --git a/net/tap.c b/net/tap.c
index ea46feeaa8..7dbcdaad14 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -275,6 +275,18 @@ static void tap_set_vnet_hdr_len(NetClientState *nc, int len)
     s->host_vnet_hdr_len = len;
 }
 
+static bool tap_get_vnet_hash_cap(NetClientState *nc, NetVnetHashCap *cap)
+{
+    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    return tap_probe_vnet_hash_cap(s->fd, cap);
+}
+
+static void tap_set_vnet_hash(NetClientState *nc, const void *hash)
+{
+    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    return tap_fd_set_vnet_hash(s->fd, hash);
+}
+
 static bool tap_get_using_vnet_hdr(NetClientState *nc)
 {
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
@@ -391,6 +403,8 @@ static NetClientInfo net_tap_info = {
     .set_offload = tap_set_offload,
     .get_vnet_hdr_len = tap_get_vnet_hdr_len,
     .set_vnet_hdr_len = tap_set_vnet_hdr_len,
+    .get_vnet_hash_cap = tap_get_vnet_hash_cap,
+    .set_vnet_hash = tap_set_vnet_hash,
     .set_vnet_le = tap_set_vnet_le,
     .set_vnet_be = tap_set_vnet_be,
     .set_steering_ebpf = tap_set_steering_ebpf,
-- 
2.42.0


