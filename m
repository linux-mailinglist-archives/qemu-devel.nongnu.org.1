Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FA479829B
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:46:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeVFY-00052p-KZ; Fri, 08 Sep 2023 02:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qeVF4-0004wr-NO
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:45:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qeVF0-0002fg-6z
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:45:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694155517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gG0OwUBXLGkdwDBfP3S/mv7uBSzwvt5C2wH4yGMosxE=;
 b=dIs7c1PilLmAWbmhNIz6Q7v4at0Ms1G1s8tBL1YX/41VXuS01dK9w+r74J43VjdehP7lQg
 nQBsGvKr/ZblvAYLAwcVtlvrmfXvbBEri3Ds8uebd6GxIKHd5e76ZjGrpzmnZUXU/RAL3n
 af/QZ0A/IEmbmP8ny8vEDejS0tyJ4Eo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-166-ziap945_MtCA-be489ykcQ-1; Fri, 08 Sep 2023 02:45:15 -0400
X-MC-Unique: ziap945_MtCA-be489ykcQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 65D99101A529;
 Fri,  8 Sep 2023 06:45:15 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.113.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 665AF1121314;
 Fri,  8 Sep 2023 06:45:13 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Andrew Melnychenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 01/17] tap: Add USO support to tap device.
Date: Fri,  8 Sep 2023 14:44:51 +0800
Message-Id: <20230908064507.14596-2-jasowang@redhat.com>
In-Reply-To: <20230908064507.14596-1-jasowang@redhat.com>
References: <20230908064507.14596-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
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

From: Andrew Melnychenko <andrew@daynix.com>

Passing additional parameters (USOv4 and USOv6 offloads) when
setting TAP offloads

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/e1000e_core.c |  2 +-
 hw/net/igb_core.c    |  2 +-
 hw/net/virtio-net.c  |  4 +++-
 hw/net/vmxnet3.c     |  2 ++
 include/net/net.h    |  4 ++--
 net/net.c            |  4 ++--
 net/tap-bsd.c        |  2 +-
 net/tap-linux.c      | 15 ++++++++++++---
 net/tap-linux.h      |  2 ++
 net/tap-solaris.c    |  2 +-
 net/tap-stub.c       |  2 +-
 net/tap-win32.c      |  2 +-
 net/tap.c            |  6 +++---
 net/tap_int.h        |  3 ++-
 14 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index f8aeafa..d405595 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -2852,7 +2852,7 @@ e1000e_update_rx_offloads(E1000ECore *core)
 
     if (core->has_vnet) {
         qemu_set_offload(qemu_get_queue(core->owner_nic)->peer,
-                         cso_state, 0, 0, 0, 0);
+                         cso_state, 0, 0, 0, 0, 0, 0);
     }
 }
 
diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 8b6b75c..389eef1 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -2753,7 +2753,7 @@ igb_update_rx_offloads(IGBCore *core)
 
     if (core->has_vnet) {
         qemu_set_offload(qemu_get_queue(core->owner_nic)->peer,
-                         cso_state, 0, 0, 0, 0);
+                         cso_state, 0, 0, 0, 0, 0, 0);
     }
 }
 
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 7102ec4..d2311e7 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -859,7 +859,9 @@ static void virtio_net_apply_guest_offloads(VirtIONet *n)
             !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_TSO4)),
             !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_TSO6)),
             !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_ECN)),
-            !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_UFO)));
+            !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_UFO)),
+            !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_USO4)),
+            !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_USO6)));
 }
 
 static uint64_t virtio_net_guest_offloads_by_features(uint32_t features)
diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 5dfacb1..886adae 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -1341,6 +1341,8 @@ static void vmxnet3_update_features(VMXNET3State *s)
                          s->lro_supported,
                          s->lro_supported,
                          0,
+                         0,
+                         0,
                          0);
     }
 }
diff --git a/include/net/net.h b/include/net/net.h
index 1448d00..b5ccfbb 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -58,7 +58,7 @@ typedef bool (HasVnetHdr)(NetClientState *);
 typedef bool (HasVnetHdrLen)(NetClientState *, int);
 typedef bool (GetUsingVnetHdr)(NetClientState *);
 typedef void (UsingVnetHdr)(NetClientState *, bool);
-typedef void (SetOffload)(NetClientState *, int, int, int, int, int);
+typedef void (SetOffload)(NetClientState *, int, int, int, int, int, int, int);
 typedef int (GetVnetHdrLen)(NetClientState *);
 typedef void (SetVnetHdrLen)(NetClientState *, int);
 typedef int (SetVnetLE)(NetClientState *, bool);
@@ -192,7 +192,7 @@ bool qemu_has_vnet_hdr_len(NetClientState *nc, int len);
 bool qemu_get_using_vnet_hdr(NetClientState *nc);
 void qemu_using_vnet_hdr(NetClientState *nc, bool enable);
 void qemu_set_offload(NetClientState *nc, int csum, int tso4, int tso6,
-                      int ecn, int ufo);
+                      int ecn, int ufo, int uso4, int uso6);
 int qemu_get_vnet_hdr_len(NetClientState *nc);
 void qemu_set_vnet_hdr_len(NetClientState *nc, int len);
 int qemu_set_vnet_le(NetClientState *nc, bool is_le);
diff --git a/net/net.c b/net/net.c
index 6492ad5..543e6de 100644
--- a/net/net.c
+++ b/net/net.c
@@ -532,13 +532,13 @@ void qemu_using_vnet_hdr(NetClientState *nc, bool enable)
 }
 
 void qemu_set_offload(NetClientState *nc, int csum, int tso4, int tso6,
-                          int ecn, int ufo)
+                          int ecn, int ufo, int uso4, int uso6)
 {
     if (!nc || !nc->info->set_offload) {
         return;
     }
 
-    nc->info->set_offload(nc, csum, tso4, tso6, ecn, ufo);
+    nc->info->set_offload(nc, csum, tso4, tso6, ecn, ufo, uso4, uso6);
 }
 
 int qemu_get_vnet_hdr_len(NetClientState *nc)
diff --git a/net/tap-bsd.c b/net/tap-bsd.c
index 4c98fdd..abd16a2 100644
--- a/net/tap-bsd.c
+++ b/net/tap-bsd.c
@@ -232,7 +232,7 @@ int tap_fd_set_vnet_be(int fd, int is_be)
 }
 
 void tap_fd_set_offload(int fd, int csum, int tso4,
-                        int tso6, int ecn, int ufo)
+                        int tso6, int ecn, int ufo, int uso4, int uso6)
 {
 }
 
diff --git a/net/tap-linux.c b/net/tap-linux.c
index f54f308..30fcca1 100644
--- a/net/tap-linux.c
+++ b/net/tap-linux.c
@@ -237,7 +237,7 @@ int tap_fd_set_vnet_be(int fd, int is_be)
 }
 
 void tap_fd_set_offload(int fd, int csum, int tso4,
-                        int tso6, int ecn, int ufo)
+                        int tso6, int ecn, int ufo, int uso4, int uso6)
 {
     unsigned int offload = 0;
 
@@ -256,13 +256,22 @@ void tap_fd_set_offload(int fd, int csum, int tso4,
             offload |= TUN_F_TSO_ECN;
         if (ufo)
             offload |= TUN_F_UFO;
+        if (uso4) {
+            offload |= TUN_F_USO4;
+        }
+        if (uso6) {
+            offload |= TUN_F_USO6;
+        }
     }
 
     if (ioctl(fd, TUNSETOFFLOAD, offload) != 0) {
-        offload &= ~TUN_F_UFO;
+        offload &= ~(TUN_F_USO4 | TUN_F_USO6);
         if (ioctl(fd, TUNSETOFFLOAD, offload) != 0) {
-            fprintf(stderr, "TUNSETOFFLOAD ioctl() failed: %s\n",
+            offload &= ~TUN_F_UFO;
+            if (ioctl(fd, TUNSETOFFLOAD, offload) != 0) {
+                fprintf(stderr, "TUNSETOFFLOAD ioctl() failed: %s\n",
                     strerror(errno));
+            }
         }
     }
 }
diff --git a/net/tap-linux.h b/net/tap-linux.h
index bbbb62c..9a58cec 100644
--- a/net/tap-linux.h
+++ b/net/tap-linux.h
@@ -50,5 +50,7 @@
 #define TUN_F_TSO6    0x04    /* I can handle TSO for IPv6 packets */
 #define TUN_F_TSO_ECN 0x08    /* I can handle TSO with ECN bits. */
 #define TUN_F_UFO     0x10    /* I can handle UFO packets */
+#define TUN_F_USO4    0x20    /* I can handle USO for IPv4 packets */
+#define TUN_F_USO6    0x40    /* I can handle USO for IPv6 packets */
 
 #endif /* QEMU_TAP_LINUX_H */
diff --git a/net/tap-solaris.c b/net/tap-solaris.c
index 38e1502..a617a10 100644
--- a/net/tap-solaris.c
+++ b/net/tap-solaris.c
@@ -236,7 +236,7 @@ int tap_fd_set_vnet_be(int fd, int is_be)
 }
 
 void tap_fd_set_offload(int fd, int csum, int tso4,
-                        int tso6, int ecn, int ufo)
+                        int tso6, int ecn, int ufo, int uso4, int uso6)
 {
 }
 
diff --git a/net/tap-stub.c b/net/tap-stub.c
index a0fa258..ac8dfc0 100644
--- a/net/tap-stub.c
+++ b/net/tap-stub.c
@@ -67,7 +67,7 @@ int tap_fd_set_vnet_be(int fd, int is_be)
 }
 
 void tap_fd_set_offload(int fd, int csum, int tso4,
-                        int tso6, int ecn, int ufo)
+                        int tso6, int ecn, int ufo, int uso4, int uso6)
 {
 }
 
diff --git a/net/tap-win32.c b/net/tap-win32.c
index f327d62..7b8b4be 100644
--- a/net/tap-win32.c
+++ b/net/tap-win32.c
@@ -741,7 +741,7 @@ static void tap_using_vnet_hdr(NetClientState *nc, bool using_vnet_hdr)
 }
 
 static void tap_set_offload(NetClientState *nc, int csum, int tso4,
-                     int tso6, int ecn, int ufo)
+                     int tso6, int ecn, int ufo, int uso4, int uso6)
 {
 }
 
diff --git a/net/tap.c b/net/tap.c
index 1bf085d..14ea4ef 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -307,14 +307,14 @@ static int tap_set_vnet_be(NetClientState *nc, bool is_be)
 }
 
 static void tap_set_offload(NetClientState *nc, int csum, int tso4,
-                     int tso6, int ecn, int ufo)
+                     int tso6, int ecn, int ufo, int uso4, int uso6)
 {
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
     if (s->fd < 0) {
         return;
     }
 
-    tap_fd_set_offload(s->fd, csum, tso4, tso6, ecn, ufo);
+    tap_fd_set_offload(s->fd, csum, tso4, tso6, ecn, ufo, uso4, uso6);
 }
 
 static void tap_exit_notify(Notifier *notifier, void *data)
@@ -414,7 +414,7 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
     s->using_vnet_hdr = false;
     s->has_ufo = tap_probe_has_ufo(s->fd);
     s->enabled = true;
-    tap_set_offload(&s->nc, 0, 0, 0, 0, 0);
+    tap_set_offload(&s->nc, 0, 0, 0, 0, 0, 0, 0);
     /*
      * Make sure host header length is set correctly in tap:
      * it might have been modified by another instance of qemu.
diff --git a/net/tap_int.h b/net/tap_int.h
index 547f8a5..d8861d8 100644
--- a/net/tap_int.h
+++ b/net/tap_int.h
@@ -37,7 +37,8 @@ void tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp);
 int tap_probe_vnet_hdr(int fd, Error **errp);
 int tap_probe_vnet_hdr_len(int fd, int len);
 int tap_probe_has_ufo(int fd);
-void tap_fd_set_offload(int fd, int csum, int tso4, int tso6, int ecn, int ufo);
+void tap_fd_set_offload(int fd, int csum, int tso4, int tso6, int ecn, int ufo,
+                        int uso4, int uso6);
 void tap_fd_set_vnet_hdr_len(int fd, int len);
 int tap_fd_set_vnet_le(int fd, int vnet_is_le);
 int tap_fd_set_vnet_be(int fd, int vnet_is_be);
-- 
2.7.4


