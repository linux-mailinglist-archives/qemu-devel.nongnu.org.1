Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86486B05056
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Jul 2025 06:38:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubXPK-0001ry-Ee; Tue, 15 Jul 2025 00:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ubXP2-0001f5-HE
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 00:36:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ubXOz-00065R-Sy
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 00:36:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752554185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YnGInowHDQM/yx6IqGBLQtzOS1Z+AVF+jDgTvgR0Jaw=;
 b=H4HfLWRbbQ6wn8m5tn2wnLwQer294k7OibuAx7xyB8pCxTWu/DDL6DP7VYwXGoZqGtppWa
 C70IWSwWW4Kg6xWtImhLNvemgbCXUUN49m0OfHUgEIT04xfvhTybIY3eIDcSa6ZEXHBYTQ
 bF0KCZDTGj/enhRZAv5Op+UDy7GQvgc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-501-6GaNIZb4MaqWi4C5palRww-1; Tue,
 15 Jul 2025 00:36:21 -0400
X-MC-Unique: 6GaNIZb4MaqWi4C5palRww-1
X-Mimecast-MFC-AGG-ID: 6GaNIZb4MaqWi4C5palRww_1752554180
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B0117195608C; Tue, 15 Jul 2025 04:36:19 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.42])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C75981977000; Tue, 15 Jul 2025 04:36:16 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Daniel Borkmann <daniel@iogearbox.net>, Ilya Maximets <i.maximets@ovn.org>,
 Jason Wang <jasowang@redhat.com>, Anton Protopopov <aspsk@isovalent.com>
Subject: [PULL V2 16/16] net/af-xdp: Support pinned map path for AF_XDP sockets
Date: Tue, 15 Jul 2025 12:35:24 +0800
Message-ID: <20250715043524.21719-17-jasowang@redhat.com>
In-Reply-To: <20250715043524.21719-1-jasowang@redhat.com>
References: <20250715043524.21719-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Daniel Borkmann <daniel@iogearbox.net>

Extend 'inhibit=on' setting with the option to specify a pinned XSK map
path along with a starting index (default 0) to push the created XSK
sockets into. Example usage:

  # ./build/qemu-system-x86_64 [...] \
   -netdev af-xdp,ifname=enp2s0f0np0,id=net0,mode=native,queues=2,start-queue=14,inhibit=on,map-path=/sys/fs/bpf/xsks_map,map-start-index=14 \
   -device virtio-net-pci,netdev=net0 [...]

This is useful for the case where an existing XDP program with XSK map
is present on the AF_XDP supported phys device and the XSK map is not
yet populated. For example, the former could have been pre-loaded onto
the netdevice by a control plane, which later launches QEMU to populate
it with XSK sockets.

Normally, the main idea behind 'inhibit=on' is that the QEMU instance
doesn't need to have a lot of privileges to use the pre-loaded program
and the pre-created sockets, but this mentioned use-case here is different
where QEMU still needs privileges to create the sockets.

The 'map-start-index' parameter is optional and defaults to 0. It allows
flexible placement of the XSK sockets, and is up to the user to specify
when the XDP program with XSK map was already preloaded. In the simplest
case the queue-to-map-slot mapping is just 1:1 based on ctx->rx_queue_index
but the user might as well have a different scheme (or smaller map size,
e.g. ctx->rx_queue_index % max_size) to push the inbound traffic to one
of the XSK sockets.

Note that the bpf_xdp_query_id() is now only tested for 'inhibit=off'
since only in the latter case the libxdp takes care of installing the
XDP program which was installed based on the s->xdp_flags pointing to
either driver or skb mode. For 'inhibit=on' we don't make any assumptions
and neither go down the path of probing all possible options in which
way the user installed the XDP program.

Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Ilya Maximets <i.maximets@ovn.org>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Anton Protopopov <aspsk@isovalent.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/af-xdp.c    | 83 ++++++++++++++++++++++++++++++++++++++++++++++---
 qapi/net.json   | 29 +++++++++++------
 qemu-options.hx | 23 ++++++++++++--
 3 files changed, 118 insertions(+), 17 deletions(-)

diff --git a/net/af-xdp.c b/net/af-xdp.c
index cbe1cae700..14f302ea21 100644
--- a/net/af-xdp.c
+++ b/net/af-xdp.c
@@ -51,6 +51,10 @@ typedef struct AFXDPState {
 
     uint32_t             xdp_flags;
     bool                 inhibit;
+
+    char                 *map_path;
+    int                  map_fd;
+    uint32_t             map_start_index;
 } AFXDPState;
 
 #define AF_XDP_BATCH_SIZE 64
@@ -260,6 +264,7 @@ static void af_xdp_send(void *opaque)
 static void af_xdp_cleanup(NetClientState *nc)
 {
     AFXDPState *s = DO_UPCAST(AFXDPState, nc, nc);
+    int idx;
 
     qemu_purge_queued_packets(nc);
 
@@ -273,6 +278,18 @@ static void af_xdp_cleanup(NetClientState *nc)
     s->umem = NULL;
     qemu_vfree(s->buffer);
     s->buffer = NULL;
+
+    if (s->map_fd >= 0) {
+        idx = nc->queue_index + s->map_start_index;
+        if (bpf_map_delete_elem(s->map_fd, &idx)) {
+            fprintf(stderr, "af-xdp: unable to remove AF_XDP socket from map"
+                    " %s\n", s->map_path);
+        }
+        close(s->map_fd);
+        s->map_fd = -1;
+    }
+    g_free(s->map_path);
+    s->map_path = NULL;
 }
 
 static int af_xdp_umem_create(AFXDPState *s, int sock_fd, Error **errp)
@@ -336,7 +353,6 @@ static int af_xdp_socket_create(AFXDPState *s,
     };
     int queue_id, error = 0;
 
-    s->inhibit = opts->has_inhibit && opts->inhibit;
     if (s->inhibit) {
         cfg.libxdp_flags |= XSK_LIBXDP_FLAGS__INHIBIT_PROG_LOAD;
     }
@@ -387,6 +403,35 @@ static int af_xdp_socket_create(AFXDPState *s,
     return 0;
 }
 
+static int af_xdp_update_xsk_map(AFXDPState *s, Error **errp)
+{
+    int xsk_fd, idx, error = 0;
+
+    if (!s->map_path) {
+        return 0;
+    }
+
+    s->map_fd = bpf_obj_get(s->map_path);
+    if (s->map_fd < 0) {
+        error = errno;
+    } else {
+        xsk_fd = xsk_socket__fd(s->xsk);
+        idx = s->nc.queue_index + s->map_start_index;
+        if (bpf_map_update_elem(s->map_fd, &idx, &xsk_fd, 0)) {
+            error = errno;
+        }
+    }
+
+    if (error) {
+        error_setg_errno(errp, error,
+                         "failed to insert AF_XDP socket into map %s",
+                         s->map_path);
+        return -1;
+    }
+
+    return 0;
+}
+
 /* NetClientInfo methods. */
 static NetClientInfo net_af_xdp_info = {
     .type = NET_CLIENT_DRIVER_AF_XDP,
@@ -435,12 +480,14 @@ int net_init_af_xdp(const Netdev *netdev,
 {
     const NetdevAFXDPOptions *opts = &netdev->u.af_xdp;
     NetClientState *nc, *nc0 = NULL;
+    int32_t map_start_index;
     unsigned int ifindex;
     uint32_t prog_id = 0;
     g_autofree int *sock_fds = NULL;
     int64_t i, queues;
     Error *err = NULL;
     AFXDPState *s;
+    bool inhibit;
 
     ifindex = if_nametoindex(opts->ifname);
     if (!ifindex) {
@@ -456,8 +503,28 @@ int net_init_af_xdp(const Netdev *netdev,
         return -1;
     }
 
-    if ((opts->has_inhibit && opts->inhibit) != !!opts->sock_fds) {
-        error_setg(errp, "'inhibit=on' requires 'sock-fds' and vice versa");
+    inhibit = opts->has_inhibit && opts->inhibit;
+    if (inhibit && !opts->sock_fds && !opts->map_path) {
+        error_setg(errp, "'inhibit=on' requires 'sock-fds' or 'map-path'");
+        return -1;
+    }
+    if (!inhibit && (opts->sock_fds || opts->map_path)) {
+        error_setg(errp, "'sock-fds' and 'map-path' require 'inhibit=on'");
+        return -1;
+    }
+    if (opts->sock_fds && opts->map_path) {
+        error_setg(errp, "'sock-fds' and 'map-path' are mutually exclusive");
+        return -1;
+    }
+    if (!opts->map_path && opts->has_map_start_index) {
+        error_setg(errp, "'map-start-index' requires 'map-path'");
+        return -1;
+    }
+
+    map_start_index = opts->has_map_start_index ? opts->map_start_index : 0;
+    if (map_start_index < 0) {
+        error_setg(errp, "'map-start-index' cannot be negative (%d)",
+                   map_start_index);
         return -1;
     }
 
@@ -481,14 +548,20 @@ int net_init_af_xdp(const Netdev *netdev,
 
         pstrcpy(s->ifname, sizeof(s->ifname), opts->ifname);
         s->ifindex = ifindex;
+        s->inhibit = inhibit;
+
+        s->map_path = g_strdup(opts->map_path);
+        s->map_start_index = map_start_index;
+        s->map_fd = -1;
 
         if (af_xdp_umem_create(s, sock_fds ? sock_fds[i] : -1, &err) ||
-            af_xdp_socket_create(s, opts, &err)) {
+            af_xdp_socket_create(s, opts, &err) ||
+            af_xdp_update_xsk_map(s, &err)) {
             goto err;
         }
     }
 
-    if (nc0) {
+    if (nc0 && !inhibit) {
         s = DO_UPCAST(AFXDPState, nc, nc0);
         if (bpf_xdp_query_id(s->ifindex, s->xdp_flags, &prog_id) || !prog_id) {
             error_setg_errno(&err, errno,
diff --git a/qapi/net.json b/qapi/net.json
index 0f766041a3..1f40bf46bb 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -567,25 +567,34 @@
 #     (default: 0).
 #
 # @inhibit: Don't load a default XDP program, use one already loaded
-#     to the interface (default: false).  Requires @sock-fds.
+#     to the interface (default: false).  Requires @sock-fds or @map-path.
 #
 # @sock-fds: A colon (:) separated list of file descriptors for
 #     already open but not bound AF_XDP sockets in the queue order.
 #     One fd per queue.  These descriptors should already be added
-#     into XDP socket map for corresponding queues.  Requires
-#     @inhibit.
+#     into XDP socket map for corresponding queues.  @sock-fds and
+#     @map-path are mutually exclusive.  Requires @inhibit.
+#
+# @map-path: The path to a pinned xsk map to push file descriptors
+#     for bound AF_XDP sockets into.  @map-path and @sock-fds are
+#     mutually exclusive.  Requires @inhibit.  (Since 10.1)
+#
+# @map-start-index: Use @map-path to insert xsk sockets starting from
+#     this index number (default: 0).  Requires @map-path.  (Since 10.1)
 #
 # Since: 8.2
 ##
 { 'struct': 'NetdevAFXDPOptions',
   'data': {
-    'ifname':       'str',
-    '*mode':        'AFXDPMode',
-    '*force-copy':  'bool',
-    '*queues':      'int',
-    '*start-queue': 'int',
-    '*inhibit':     'bool',
-    '*sock-fds':    'str' },
+    'ifname':           'str',
+    '*mode':            'AFXDPMode',
+    '*force-copy':      'bool',
+    '*queues':          'int',
+    '*start-queue':     'int',
+    '*inhibit':         'bool',
+    '*sock-fds':        'str',
+    '*map-path':        'str',
+    '*map-start-index': 'int32' },
   'if': 'CONFIG_AF_XDP' }
 
 ##
diff --git a/qemu-options.hx b/qemu-options.hx
index a3c066c678..bf19987cb0 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2929,6 +2929,7 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
 #ifdef CONFIG_AF_XDP
     "-netdev af-xdp,id=str,ifname=name[,mode=native|skb][,force-copy=on|off]\n"
     "         [,queues=n][,start-queue=m][,inhibit=on|off][,sock-fds=x:y:...:z]\n"
+    "         [,map-path=/path/to/socket/map][,map-start-index=i]\n"
     "                attach to the existing network interface 'name' with AF_XDP socket\n"
     "                use 'mode=MODE' to specify an XDP program attach mode\n"
     "                use 'force-copy=on|off' to force XDP copy mode even if device supports zero-copy (default: off)\n"
@@ -2936,6 +2937,8 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
     "                with inhibit=on,\n"
     "                  use 'sock-fds' to provide file descriptors for already open AF_XDP sockets\n"
     "                  added to a socket map in XDP program.  One socket per queue.\n"
+    "                  use 'map-path' to provide the socket map location to populate AF_XDP sockets with,\n"
+    "                  and use 'map-start-index' to specify the starting index for the map (default: 0) (Since 10.1)\n"
     "                use 'queues=n' to specify how many queues of a multiqueue interface should be used\n"
     "                use 'start-queue=m' to specify the first queue that should be used\n"
 #endif
@@ -3759,7 +3762,7 @@ SRST
         # launch QEMU instance
         |qemu_system| linux.img -nic vde,sock=/tmp/myswitch
 
-``-netdev af-xdp,id=str,ifname=name[,mode=native|skb][,force-copy=on|off][,queues=n][,start-queue=m][,inhibit=on|off][,sock-fds=x:y:...:z]``
+``-netdev af-xdp,id=str,ifname=name[,mode=native|skb][,force-copy=on|off][,queues=n][,start-queue=m][,inhibit=on|off][,sock-fds=x:y:...:z][,map-path=/path/to/socket/map][,map-start-index=i]``
     Configure AF_XDP backend to connect to a network interface 'name'
     using AF_XDP socket.  A specific program attach mode for a default
     XDP program can be forced with 'mode', defaults to best-effort,
@@ -3799,7 +3802,8 @@ SRST
             -netdev af-xdp,id=n1,ifname=eth0,queues=1,start-queue=1
 
     XDP program can also be loaded externally.  In this case 'inhibit' option
-    should be set to 'on' and 'sock-fds' provided with file descriptors for
+    should be set to 'on'.  Either 'sock-fds' or 'map-path' can be used with
+    'inhibit' enabled.  'sock-fds' can be provided with file descriptors for
     already open but not bound XDP sockets already added to a socket map for
     corresponding queues.  One socket per queue.
 
@@ -3808,6 +3812,21 @@ SRST
         |qemu_system| linux.img -device virtio-net-pci,netdev=n1 \\
             -netdev af-xdp,id=n1,ifname=eth0,queues=3,inhibit=on,sock-fds=15:16:17
 
+    For the 'inhibit' option set to 'on' used together with 'map-path' it is
+    expected that the XDP program with the socket map is already loaded on
+    the networking device and the map pinned into BPF file system.  The path
+    to the pinned map is then passed to QEMU which then creates the file
+    descriptors and inserts them into the existing socket map.
+
+    .. parsed-literal::
+
+        |qemu_system| linux.img -device virtio-net-pci,netdev=n1 \\
+            -netdev af-xdp,id=n1,ifname=eth0,queues=2,inhibit=on,map-path=/sys/fs/bpf/xsks_map
+
+    Additionally, 'map-start-index' can be used to specify the start offset
+    for insertion into the socket map.  The combination of 'map-path' and
+    'sock-fds' together is not supported.
+
 ``-netdev vhost-user,chardev=id[,vhostforce=on|off][,queues=n]``
     Establish a vhost-user netdev, backed by a chardev id. The chardev
     should be a unix domain socket backed one. The vhost-user uses a
-- 
2.42.0


