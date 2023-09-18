Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5485D7A44C0
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 10:32:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi9fe-0005xQ-OY; Mon, 18 Sep 2023 04:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qi9fa-0005wb-Sk
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 04:31:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qi9fW-00048Q-29
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 04:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695025905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+VaoNKdbZ2MF3T0xib1qkCJhHUG8IuCJYdHkAXEj0+I=;
 b=N4ZmvvRETK79CExQAkgB/IWl0L8oq5aUihbOBzFLtnHJc9qyV0xr0b2E74MDNnHbznSEfa
 FE+tM/DwsWDcGJOMPxEc7SwJkiDZyxmIh8bSKMcjpsdQNPxZFIC0aqswqCEsCZPEiW8L/O
 xtfYWG99JJUfTORaBF6gnPy3ck8Krls=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-179-zAV4qnmVPg67bUknPfQBug-1; Mon, 18 Sep 2023 04:31:42 -0400
X-MC-Unique: zAV4qnmVPg67bUknPfQBug-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 35728801FA9;
 Mon, 18 Sep 2023 08:31:42 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.113.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4E3982156A27;
 Mon, 18 Sep 2023 08:31:40 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychecnko <andrew@daynix.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL V2 02/17] tap: Add check for USO features
Date: Mon, 18 Sep 2023 16:31:17 +0800
Message-Id: <20230918083132.55423-3-jasowang@redhat.com>
In-Reply-To: <20230918083132.55423-1-jasowang@redhat.com>
References: <20230918083132.55423-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
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

From: Yuri Benditovich <yuri.benditovich@daynix.com>

Tap indicates support for USO features according to
capabilities of current kernel module.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
Signed-off-by: Andrew Melnychecnko <andrew@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 include/net/net.h |  3 +++
 net/net.c         |  9 +++++++++
 net/tap-bsd.c     |  5 +++++
 net/tap-linux.c   | 12 ++++++++++++
 net/tap-solaris.c |  5 +++++
 net/tap-stub.c    |  5 +++++
 net/tap.c         | 12 ++++++++++++
 net/tap_int.h     |  1 +
 8 files changed, 52 insertions(+)

diff --git a/include/net/net.h b/include/net/net.h
index b5ccfbb..330d285 100644
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
index 543e6de..b110e61 100644
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
index abd16a2..274ea7b 100644
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
index 30fcca1..c7e514e 100644
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
index a617a10..08b13af 100644
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
index ac8dfc0..4b24f61 100644
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
index 14ea4ef..bcea8d0 100644
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
index d8861d8..9a21756 100644
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
2.7.4


