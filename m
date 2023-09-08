Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2951A7982AC
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:48:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeVG3-0005qT-Hy; Fri, 08 Sep 2023 02:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qeVFc-0005Fa-V7
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:45:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qeVFW-0003K3-QF
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694155549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sEtmfOf3ZHuf7mrTDCu2flbMnZQnNfwAX8S1En1BjNo=;
 b=QKWnOVnc2O/SPm7khdxS/FBhFLO/8VIKcBpcDPprBlZC3SsgErnUPKzTc+ArgCmueUYw9N
 WQjxj3wuggQWNQ9qKF3H4hO6vJ3PgAbWvxciOYV99QhfamyP48ydISiU1XN+iDFZFt9WdR
 bEuyXyrSGsAd7mN+Ge6OtBiSzeeI228=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-wxPst8ZwO3-JCBYGw0cbKw-1; Fri, 08 Sep 2023 02:45:46 -0400
X-MC-Unique: wxPst8ZwO3-JCBYGw0cbKw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D27D88001EA;
 Fri,  8 Sep 2023 06:45:45 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.113.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 22C021121314;
 Fri,  8 Sep 2023 06:45:43 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ilya Maximets <i.maximets@ovn.org>,
	Jason Wang <jasowang@redhat.com>
Subject: [PULL 12/17] net: add initial support for AF_XDP network backend
Date: Fri,  8 Sep 2023 14:45:02 +0800
Message-Id: <20230908064507.14596-13-jasowang@redhat.com>
In-Reply-To: <20230908064507.14596-1-jasowang@redhat.com>
References: <20230908064507.14596-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

From: Ilya Maximets <i.maximets@ovn.org>

AF_XDP is a network socket family that allows communication directly
with the network device driver in the kernel, bypassing most or all
of the kernel networking stack.  In the essence, the technology is
pretty similar to netmap.  But, unlike netmap, AF_XDP is Linux-native
and works with any network interfaces without driver modifications.
Unlike vhost-based backends (kernel, user, vdpa), AF_XDP doesn't
require access to character devices or unix sockets.  Only access to
the network interface itself is necessary.

This patch implements a network backend that communicates with the
kernel by creating an AF_XDP socket.  A chunk of userspace memory
is shared between QEMU and the host kernel.  4 ring buffers (Tx, Rx,
Fill and Completion) are placed in that memory along with a pool of
memory buffers for the packet data.  Data transmission is done by
allocating one of the buffers, copying packet data into it and
placing the pointer into Tx ring.  After transmission, device will
return the buffer via Completion ring.  On Rx, device will take
a buffer form a pre-populated Fill ring, write the packet data into
it and place the buffer into Rx ring.

AF_XDP network backend takes on the communication with the host
kernel and the network interface and forwards packets to/from the
peer device in QEMU.

Usage example:

  -device virtio-net-pci,netdev=guest1,mac=00:16:35:AF:AA:5C
  -netdev af-xdp,ifname=ens6f1np1,id=guest1,mode=native,queues=1

XDP program bridges the socket with a network interface.  It can be
attached to the interface in 2 different modes:

1. skb - this mode should work for any interface and doesn't require
         driver support.  With a caveat of lower performance.

2. native - this does require support from the driver and allows to
            bypass skb allocation in the kernel and potentially use
            zero-copy while getting packets in/out userspace.

By default, QEMU will try to use native mode and fall back to skb.
Mode can be forced via 'mode' option.  To force 'copy' even in native
mode, use 'force-copy=on' option.  This might be useful if there is
some issue with the driver.

Option 'queues=N' allows to specify how many device queues should
be open.  Note that all the queues that are not open are still
functional and can receive traffic, but it will not be delivered to
QEMU.  So, the number of device queues should generally match the
QEMU configuration, unless the device is shared with something
else and the traffic re-direction to appropriate queues is correctly
configured on a device level (e.g. with ethtool -N).
'start-queue=M' option can be used to specify from which queue id
QEMU should start configuring 'N' queues.  It might also be necessary
to use this option with certain NICs, e.g. MLX5 NICs.  See the docs
for examples.

In a general case QEMU will need CAP_NET_ADMIN and CAP_SYS_ADMIN
or CAP_BPF capabilities in order to load default XSK/XDP programs to
the network interface and configure BPF maps.  It is possible, however,
to run with no capabilities.  For that to work, an external process
with enough capabilities will need to pre-load default XSK program,
create AF_XDP sockets and pass their file descriptors to QEMU process
on startup via 'sock-fds' option.  Network backend will need to be
configured with 'inhibit=on' to avoid loading of the program.
QEMU will need 32 MB of locked memory (RLIMIT_MEMLOCK) per queue
or CAP_IPC_LOCK.

There are few performance challenges with the current network backends.

First is that they do not support IO threads.  This means that data
path is handled by the main thread in QEMU and may slow down other
work or may be slowed down by some other work.  This also means that
taking advantage of multi-queue is generally not possible today.

Another thing is that data path is going through the device emulation
code, which is not really optimized for performance.  The fastest
"frontend" device is virtio-net.  But it's not optimized for heavy
traffic either, because it expects such use-cases to be handled via
some implementation of vhost (user, kernel, vdpa).  In practice, we
have virtio notifications and rcu lock/unlock on a per-packet basis
and not very efficient accesses to the guest memory.  Communication
channels between backend and frontend devices do not allow passing
more than one packet at a time as well.

Some of these challenges can be avoided in the future by adding better
batching into device emulation or by implementing vhost-af-xdp variant.

There are also a few kernel limitations.  AF_XDP sockets do not
support any kinds of checksum or segmentation offloading.  Buffers
are limited to a page size (4K), i.e. MTU is limited.  Multi-buffer
support implementation for AF_XDP is in progress, but not ready yet.
Also, transmission in all non-zero-copy modes is synchronous, i.e.
done in a syscall.  That doesn't allow high packet rates on virtual
interfaces.

However, keeping in mind all of these challenges, current implementation
of the AF_XDP backend shows a decent performance while running on top
of a physical NIC with zero-copy support.

Test setup:

2 VMs running on 2 physical hosts connected via ConnectX6-Dx card.
Network backend is configured to open the NIC directly in native mode.
The driver supports zero-copy.  NIC is configured to use 1 queue.

Inside a VM - iperf3 for basic TCP performance testing and dpdk-testpmd
for PPS testing.

iperf3 result:
 TCP stream      : 19.1 Gbps

dpdk-testpmd (single queue, single CPU core, 64 B packets) results:
 Tx only         : 3.4 Mpps
 Rx only         : 2.0 Mpps
 L2 FWD Loopback : 1.5 Mpps

In skb mode the same setup shows much lower performance, similar to
the setup where pair of physical NICs is replaced with veth pair:

iperf3 result:
  TCP stream      : 9 Gbps

dpdk-testpmd (single queue, single CPU core, 64 B packets) results:
  Tx only         : 1.2 Mpps
  Rx only         : 1.0 Mpps
  L2 FWD Loopback : 0.7 Mpps

Results in skb mode or over the veth are close to results of a tap
backend with vhost=on and disabled segmentation offloading bridged
with a NIC.

Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 MAINTAINERS                                     |   4 +
 hmp-commands.hx                                 |   3 +
 meson.build                                     |   9 +
 meson_options.txt                               |   2 +
 net/af-xdp.c                                    | 526 ++++++++++++++++++++++++
 net/clients.h                                   |   5 +
 net/meson.build                                 |   3 +
 net/net.c                                       |   6 +
 qapi/net.json                                   |  58 +++
 qemu-options.hx                                 |  70 +++-
 scripts/ci/org.centos/stream/8/x86_64/configure |   1 +
 scripts/meson-buildoptions.sh                   |   3 +
 tests/docker/dockerfiles/debian-amd64.docker    |   1 +
 13 files changed, 690 insertions(+), 1 deletion(-)
 create mode 100644 net/af-xdp.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b471973..a057147 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2940,6 +2940,10 @@ W: http://info.iet.unipi.it/~luigi/netmap/
 S: Maintained
 F: net/netmap.c
 
+AF_XDP network backend
+R: Ilya Maximets <i.maximets@ovn.org>
+F: net/af-xdp.c
+
 Host Memory Backends
 M: David Hildenbrand <david@redhat.com>
 M: Igor Mammedov <imammedo@redhat.com>
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 2cbd0f7..63eac22 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1296,6 +1296,9 @@ ERST
         .name       = "netdev_add",
         .args_type  = "netdev:O",
         .params     = "[user|tap|socket|stream|dgram|vde|bridge|hubport|netmap|vhost-user"
+#ifdef CONFIG_AF_XDP
+                      "|af-xdp"
+#endif
 #ifdef CONFIG_VMNET
                       "|vmnet-host|vmnet-shared|vmnet-bridged"
 #endif
diff --git a/meson.build b/meson.build
index bf9831c..1e9fe07 100644
--- a/meson.build
+++ b/meson.build
@@ -1873,6 +1873,13 @@ if libbpf.found() and not cc.links('''
   endif
 endif
 
+# libxdp
+libxdp = not_found
+if not get_option('af_xdp').auto() or have_system
+    libxdp = dependency('libxdp', required: get_option('af_xdp'),
+                        version: '>=1.4.0', method: 'pkg-config')
+endif
+
 # libdw
 libdw = not_found
 if not get_option('libdw').auto() or \
@@ -2099,6 +2106,7 @@ config_host_data.set('CONFIG_HEXAGON_IDEF_PARSER', get_option('hexagon_idef_pars
 config_host_data.set('CONFIG_LIBATTR', have_old_libattr)
 config_host_data.set('CONFIG_LIBCAP_NG', libcap_ng.found())
 config_host_data.set('CONFIG_EBPF', libbpf.found())
+config_host_data.set('CONFIG_AF_XDP', libxdp.found())
 config_host_data.set('CONFIG_LIBDAXCTL', libdaxctl.found())
 config_host_data.set('CONFIG_LIBISCSI', libiscsi.found())
 config_host_data.set('CONFIG_LIBNFS', libnfs.found())
@@ -4269,6 +4277,7 @@ summary_info = {}
 if targetos == 'darwin'
   summary_info += {'vmnet.framework support': vmnet}
 endif
+summary_info += {'AF_XDP support':    libxdp}
 summary_info += {'slirp support':     slirp}
 summary_info += {'vde support':       vde}
 summary_info += {'netmap support':    have_netmap}
diff --git a/meson_options.txt b/meson_options.txt
index f82d88b..2ca40f2 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -122,6 +122,8 @@ option('avx512bw', type: 'feature', value: 'auto',
 option('keyring', type: 'feature', value: 'auto',
        description: 'Linux keyring support')
 
+option('af_xdp', type : 'feature', value : 'auto',
+       description: 'AF_XDP network backend support')
 option('attr', type : 'feature', value : 'auto',
        description: 'attr/xattr support')
 option('auth_pam', type : 'feature', value : 'auto',
diff --git a/net/af-xdp.c b/net/af-xdp.c
new file mode 100644
index 0000000..6c65028
--- /dev/null
+++ b/net/af-xdp.c
@@ -0,0 +1,526 @@
+/*
+ * AF_XDP network backend.
+ *
+ * Copyright (c) 2023 Red Hat, Inc.
+ *
+ * Authors:
+ *  Ilya Maximets <i.maximets@ovn.org>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+
+#include "qemu/osdep.h"
+#include <bpf/bpf.h>
+#include <inttypes.h>
+#include <linux/if_link.h>
+#include <linux/if_xdp.h>
+#include <net/if.h>
+#include <xdp/xsk.h>
+
+#include "clients.h"
+#include "monitor/monitor.h"
+#include "net/net.h"
+#include "qapi/error.h"
+#include "qemu/cutils.h"
+#include "qemu/error-report.h"
+#include "qemu/iov.h"
+#include "qemu/main-loop.h"
+#include "qemu/memalign.h"
+
+
+typedef struct AFXDPState {
+    NetClientState       nc;
+
+    struct xsk_socket    *xsk;
+    struct xsk_ring_cons rx;
+    struct xsk_ring_prod tx;
+    struct xsk_ring_cons cq;
+    struct xsk_ring_prod fq;
+
+    char                 ifname[IFNAMSIZ];
+    int                  ifindex;
+    bool                 read_poll;
+    bool                 write_poll;
+    uint32_t             outstanding_tx;
+
+    uint64_t             *pool;
+    uint32_t             n_pool;
+    char                 *buffer;
+    struct xsk_umem      *umem;
+
+    uint32_t             n_queues;
+    uint32_t             xdp_flags;
+    bool                 inhibit;
+} AFXDPState;
+
+#define AF_XDP_BATCH_SIZE 64
+
+static void af_xdp_send(void *opaque);
+static void af_xdp_writable(void *opaque);
+
+/* Set the event-loop handlers for the af-xdp backend. */
+static void af_xdp_update_fd_handler(AFXDPState *s)
+{
+    qemu_set_fd_handler(xsk_socket__fd(s->xsk),
+                        s->read_poll ? af_xdp_send : NULL,
+                        s->write_poll ? af_xdp_writable : NULL,
+                        s);
+}
+
+/* Update the read handler. */
+static void af_xdp_read_poll(AFXDPState *s, bool enable)
+{
+    if (s->read_poll != enable) {
+        s->read_poll = enable;
+        af_xdp_update_fd_handler(s);
+    }
+}
+
+/* Update the write handler. */
+static void af_xdp_write_poll(AFXDPState *s, bool enable)
+{
+    if (s->write_poll != enable) {
+        s->write_poll = enable;
+        af_xdp_update_fd_handler(s);
+    }
+}
+
+static void af_xdp_poll(NetClientState *nc, bool enable)
+{
+    AFXDPState *s = DO_UPCAST(AFXDPState, nc, nc);
+
+    if (s->read_poll != enable || s->write_poll != enable) {
+        s->write_poll = enable;
+        s->read_poll  = enable;
+        af_xdp_update_fd_handler(s);
+    }
+}
+
+static void af_xdp_complete_tx(AFXDPState *s)
+{
+    uint32_t idx = 0;
+    uint32_t done, i;
+    uint64_t *addr;
+
+    done = xsk_ring_cons__peek(&s->cq, XSK_RING_CONS__DEFAULT_NUM_DESCS, &idx);
+
+    for (i = 0; i < done; i++) {
+        addr = (void *) xsk_ring_cons__comp_addr(&s->cq, idx++);
+        s->pool[s->n_pool++] = *addr;
+        s->outstanding_tx--;
+    }
+
+    if (done) {
+        xsk_ring_cons__release(&s->cq, done);
+    }
+}
+
+/*
+ * The fd_write() callback, invoked if the fd is marked as writable
+ * after a poll.
+ */
+static void af_xdp_writable(void *opaque)
+{
+    AFXDPState *s = opaque;
+
+    /* Try to recover buffers that are already sent. */
+    af_xdp_complete_tx(s);
+
+    /*
+     * Unregister the handler, unless we still have packets to transmit
+     * and kernel needs a wake up.
+     */
+    if (!s->outstanding_tx || !xsk_ring_prod__needs_wakeup(&s->tx)) {
+        af_xdp_write_poll(s, false);
+    }
+
+    /* Flush any buffered packets. */
+    qemu_flush_queued_packets(&s->nc);
+}
+
+static ssize_t af_xdp_receive(NetClientState *nc,
+                              const uint8_t *buf, size_t size)
+{
+    AFXDPState *s = DO_UPCAST(AFXDPState, nc, nc);
+    struct xdp_desc *desc;
+    uint32_t idx;
+    void *data;
+
+    /* Try to recover buffers that are already sent. */
+    af_xdp_complete_tx(s);
+
+    if (size > XSK_UMEM__DEFAULT_FRAME_SIZE) {
+        /* We can't transmit packet this size... */
+        return size;
+    }
+
+    if (!s->n_pool || !xsk_ring_prod__reserve(&s->tx, 1, &idx)) {
+        /*
+         * Out of buffers or space in tx ring.  Poll until we can write.
+         * This will also kick the Tx, if it was waiting on CQ.
+         */
+        af_xdp_write_poll(s, true);
+        return 0;
+    }
+
+    desc = xsk_ring_prod__tx_desc(&s->tx, idx);
+    desc->addr = s->pool[--s->n_pool];
+    desc->len = size;
+
+    data = xsk_umem__get_data(s->buffer, desc->addr);
+    memcpy(data, buf, size);
+
+    xsk_ring_prod__submit(&s->tx, 1);
+    s->outstanding_tx++;
+
+    if (xsk_ring_prod__needs_wakeup(&s->tx)) {
+        af_xdp_write_poll(s, true);
+    }
+
+    return size;
+}
+
+/*
+ * Complete a previous send (backend --> guest) and enable the
+ * fd_read callback.
+ */
+static void af_xdp_send_completed(NetClientState *nc, ssize_t len)
+{
+    AFXDPState *s = DO_UPCAST(AFXDPState, nc, nc);
+
+    af_xdp_read_poll(s, true);
+}
+
+static void af_xdp_fq_refill(AFXDPState *s, uint32_t n)
+{
+    uint32_t i, idx = 0;
+
+    /* Leave one packet for Tx, just in case. */
+    if (s->n_pool < n + 1) {
+        n = s->n_pool;
+    }
+
+    if (!n || !xsk_ring_prod__reserve(&s->fq, n, &idx)) {
+        return;
+    }
+
+    for (i = 0; i < n; i++) {
+        *xsk_ring_prod__fill_addr(&s->fq, idx++) = s->pool[--s->n_pool];
+    }
+    xsk_ring_prod__submit(&s->fq, n);
+
+    if (xsk_ring_prod__needs_wakeup(&s->fq)) {
+        /* Receive was blocked by not having enough buffers.  Wake it up. */
+        af_xdp_read_poll(s, true);
+    }
+}
+
+static void af_xdp_send(void *opaque)
+{
+    uint32_t i, n_rx, idx = 0;
+    AFXDPState *s = opaque;
+
+    n_rx = xsk_ring_cons__peek(&s->rx, AF_XDP_BATCH_SIZE, &idx);
+    if (!n_rx) {
+        return;
+    }
+
+    for (i = 0; i < n_rx; i++) {
+        const struct xdp_desc *desc;
+        struct iovec iov;
+
+        desc = xsk_ring_cons__rx_desc(&s->rx, idx++);
+
+        iov.iov_base = xsk_umem__get_data(s->buffer, desc->addr);
+        iov.iov_len = desc->len;
+
+        s->pool[s->n_pool++] = desc->addr;
+
+        if (!qemu_sendv_packet_async(&s->nc, &iov, 1,
+                                     af_xdp_send_completed)) {
+            /*
+             * The peer does not receive anymore.  Packet is queued, stop
+             * reading from the backend until af_xdp_send_completed().
+             */
+            af_xdp_read_poll(s, false);
+
+            /* Return unused descriptors to not break the ring cache. */
+            xsk_ring_cons__cancel(&s->rx, n_rx - i - 1);
+            n_rx = i + 1;
+            break;
+        }
+    }
+
+    /* Release actually sent descriptors and try to re-fill. */
+    xsk_ring_cons__release(&s->rx, n_rx);
+    af_xdp_fq_refill(s, AF_XDP_BATCH_SIZE);
+}
+
+/* Flush and close. */
+static void af_xdp_cleanup(NetClientState *nc)
+{
+    AFXDPState *s = DO_UPCAST(AFXDPState, nc, nc);
+
+    qemu_purge_queued_packets(nc);
+
+    af_xdp_poll(nc, false);
+
+    xsk_socket__delete(s->xsk);
+    s->xsk = NULL;
+    g_free(s->pool);
+    s->pool = NULL;
+    xsk_umem__delete(s->umem);
+    s->umem = NULL;
+    qemu_vfree(s->buffer);
+    s->buffer = NULL;
+
+    /* Remove the program if it's the last open queue. */
+    if (!s->inhibit && nc->queue_index == s->n_queues - 1 && s->xdp_flags
+        && bpf_xdp_detach(s->ifindex, s->xdp_flags, NULL) != 0) {
+        fprintf(stderr,
+                "af-xdp: unable to remove XDP program from '%s', ifindex: %d\n",
+                s->ifname, s->ifindex);
+    }
+}
+
+static int af_xdp_umem_create(AFXDPState *s, int sock_fd, Error **errp)
+{
+    struct xsk_umem_config config = {
+        .fill_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
+        .comp_size = XSK_RING_CONS__DEFAULT_NUM_DESCS,
+        .frame_size = XSK_UMEM__DEFAULT_FRAME_SIZE,
+        .frame_headroom = 0,
+    };
+    uint64_t n_descs;
+    uint64_t size;
+    int64_t i;
+    int ret;
+
+    /* Number of descriptors if all 4 queues (rx, tx, cq, fq) are full. */
+    n_descs = (XSK_RING_PROD__DEFAULT_NUM_DESCS
+               + XSK_RING_CONS__DEFAULT_NUM_DESCS) * 2;
+    size = n_descs * XSK_UMEM__DEFAULT_FRAME_SIZE;
+
+    s->buffer = qemu_memalign(qemu_real_host_page_size(), size);
+    memset(s->buffer, 0, size);
+
+    if (sock_fd < 0) {
+        ret = xsk_umem__create(&s->umem, s->buffer, size,
+                               &s->fq, &s->cq, &config);
+    } else {
+        ret = xsk_umem__create_with_fd(&s->umem, sock_fd, s->buffer, size,
+                                       &s->fq, &s->cq, &config);
+    }
+
+    if (ret) {
+        qemu_vfree(s->buffer);
+        error_setg_errno(errp, errno,
+                         "failed to create umem for %s queue_index: %d",
+                         s->ifname, s->nc.queue_index);
+        return -1;
+    }
+
+    s->pool = g_new(uint64_t, n_descs);
+    /* Fill the pool in the opposite order, because it's a LIFO queue. */
+    for (i = n_descs; i >= 0; i--) {
+        s->pool[i] = i * XSK_UMEM__DEFAULT_FRAME_SIZE;
+    }
+    s->n_pool = n_descs;
+
+    af_xdp_fq_refill(s, XSK_RING_PROD__DEFAULT_NUM_DESCS);
+
+    return 0;
+}
+
+static int af_xdp_socket_create(AFXDPState *s,
+                                const NetdevAFXDPOptions *opts, Error **errp)
+{
+    struct xsk_socket_config cfg = {
+        .rx_size = XSK_RING_CONS__DEFAULT_NUM_DESCS,
+        .tx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
+        .libxdp_flags = 0,
+        .bind_flags = XDP_USE_NEED_WAKEUP,
+        .xdp_flags = XDP_FLAGS_UPDATE_IF_NOEXIST,
+    };
+    int queue_id, error = 0;
+
+    s->inhibit = opts->has_inhibit && opts->inhibit;
+    if (s->inhibit) {
+        cfg.libxdp_flags |= XSK_LIBXDP_FLAGS__INHIBIT_PROG_LOAD;
+    }
+
+    if (opts->has_force_copy && opts->force_copy) {
+        cfg.bind_flags |= XDP_COPY;
+    }
+
+    queue_id = s->nc.queue_index;
+    if (opts->has_start_queue && opts->start_queue > 0) {
+        queue_id += opts->start_queue;
+    }
+
+    if (opts->has_mode) {
+        /* Specific mode requested. */
+        cfg.xdp_flags |= (opts->mode == AFXDP_MODE_NATIVE)
+                         ? XDP_FLAGS_DRV_MODE : XDP_FLAGS_SKB_MODE;
+        if (xsk_socket__create(&s->xsk, s->ifname, queue_id,
+                               s->umem, &s->rx, &s->tx, &cfg)) {
+            error = errno;
+        }
+    } else {
+        /* No mode requested, try native first. */
+        cfg.xdp_flags |= XDP_FLAGS_DRV_MODE;
+
+        if (xsk_socket__create(&s->xsk, s->ifname, queue_id,
+                               s->umem, &s->rx, &s->tx, &cfg)) {
+            /* Can't use native mode, try skb. */
+            cfg.xdp_flags &= ~XDP_FLAGS_DRV_MODE;
+            cfg.xdp_flags |= XDP_FLAGS_SKB_MODE;
+
+            if (xsk_socket__create(&s->xsk, s->ifname, queue_id,
+                                   s->umem, &s->rx, &s->tx, &cfg)) {
+                error = errno;
+            }
+        }
+    }
+
+    if (error) {
+        error_setg_errno(errp, error,
+                         "failed to create AF_XDP socket for %s queue_id: %d",
+                         s->ifname, queue_id);
+        return -1;
+    }
+
+    s->xdp_flags = cfg.xdp_flags;
+
+    return 0;
+}
+
+/* NetClientInfo methods. */
+static NetClientInfo net_af_xdp_info = {
+    .type = NET_CLIENT_DRIVER_AF_XDP,
+    .size = sizeof(AFXDPState),
+    .receive = af_xdp_receive,
+    .poll = af_xdp_poll,
+    .cleanup = af_xdp_cleanup,
+};
+
+static int *parse_socket_fds(const char *sock_fds_str,
+                             int64_t n_expected, Error **errp)
+{
+    gchar **substrings = g_strsplit(sock_fds_str, ":", -1);
+    int64_t i, n_sock_fds = g_strv_length(substrings);
+    int *sock_fds = NULL;
+
+    if (n_sock_fds != n_expected) {
+        error_setg(errp, "expected %"PRIi64" socket fds, got %"PRIi64,
+                   n_expected, n_sock_fds);
+        goto exit;
+    }
+
+    sock_fds = g_new(int, n_sock_fds);
+
+    for (i = 0; i < n_sock_fds; i++) {
+        sock_fds[i] = monitor_fd_param(monitor_cur(), substrings[i], errp);
+        if (sock_fds[i] < 0) {
+            g_free(sock_fds);
+            sock_fds = NULL;
+            goto exit;
+        }
+    }
+
+exit:
+    g_strfreev(substrings);
+    return sock_fds;
+}
+
+/*
+ * The exported init function.
+ *
+ * ... -netdev af-xdp,ifname="..."
+ */
+int net_init_af_xdp(const Netdev *netdev,
+                    const char *name, NetClientState *peer, Error **errp)
+{
+    const NetdevAFXDPOptions *opts = &netdev->u.af_xdp;
+    NetClientState *nc, *nc0 = NULL;
+    unsigned int ifindex;
+    uint32_t prog_id = 0;
+    int *sock_fds = NULL;
+    int64_t i, queues;
+    Error *err = NULL;
+    AFXDPState *s;
+
+    ifindex = if_nametoindex(opts->ifname);
+    if (!ifindex) {
+        error_setg_errno(errp, errno, "failed to get ifindex for '%s'",
+                         opts->ifname);
+        return -1;
+    }
+
+    queues = opts->has_queues ? opts->queues : 1;
+    if (queues < 1) {
+        error_setg(errp, "invalid number of queues (%" PRIi64 ") for '%s'",
+                   queues, opts->ifname);
+        return -1;
+    }
+
+    if ((opts->has_inhibit && opts->inhibit) != !!opts->sock_fds) {
+        error_setg(errp, "'inhibit=on' requires 'sock-fds' and vice versa");
+        return -1;
+    }
+
+    if (opts->sock_fds) {
+        sock_fds = parse_socket_fds(opts->sock_fds, queues, errp);
+        if (!sock_fds) {
+            return -1;
+        }
+    }
+
+    for (i = 0; i < queues; i++) {
+        nc = qemu_new_net_client(&net_af_xdp_info, peer, "af-xdp", name);
+        qemu_set_info_str(nc, "af-xdp%"PRIi64" to %s", i, opts->ifname);
+        nc->queue_index = i;
+
+        if (!nc0) {
+            nc0 = nc;
+        }
+
+        s = DO_UPCAST(AFXDPState, nc, nc);
+
+        pstrcpy(s->ifname, sizeof(s->ifname), opts->ifname);
+        s->ifindex = ifindex;
+        s->n_queues = queues;
+
+        if (af_xdp_umem_create(s, sock_fds ? sock_fds[i] : -1, errp)
+            || af_xdp_socket_create(s, opts, errp)) {
+            /* Make sure the XDP program will be removed. */
+            s->n_queues = i;
+            error_propagate(errp, err);
+            goto err;
+        }
+    }
+
+    if (nc0) {
+        s = DO_UPCAST(AFXDPState, nc, nc0);
+        if (bpf_xdp_query_id(s->ifindex, s->xdp_flags, &prog_id) || !prog_id) {
+            error_setg_errno(errp, errno,
+                             "no XDP program loaded on '%s', ifindex: %d",
+                             s->ifname, s->ifindex);
+            goto err;
+        }
+    }
+
+    af_xdp_read_poll(s, true); /* Initially only poll for reads. */
+
+    return 0;
+
+err:
+    g_free(sock_fds);
+    if (nc0) {
+        qemu_del_net_client(nc0);
+    }
+
+    return -1;
+}
diff --git a/net/clients.h b/net/clients.h
index ed8bdff..be53794 100644
--- a/net/clients.h
+++ b/net/clients.h
@@ -64,6 +64,11 @@ int net_init_netmap(const Netdev *netdev, const char *name,
                     NetClientState *peer, Error **errp);
 #endif
 
+#ifdef CONFIG_AF_XDP
+int net_init_af_xdp(const Netdev *netdev, const char *name,
+                    NetClientState *peer, Error **errp);
+#endif
+
 int net_init_vhost_user(const Netdev *netdev, const char *name,
                         NetClientState *peer, Error **errp);
 
diff --git a/net/meson.build b/net/meson.build
index d2d7063..4536103 100644
--- a/net/meson.build
+++ b/net/meson.build
@@ -36,6 +36,9 @@ system_ss.add(when: vde, if_true: files('vde.c'))
 if have_netmap
   system_ss.add(files('netmap.c'))
 endif
+
+system_ss.add(when: libxdp, if_true: files('af-xdp.c'))
+
 if have_vhost_net_user
   system_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('vhost-user.c'), if_false: files('vhost-user-stub.c'))
   system_ss.add(when: 'CONFIG_ALL', if_true: files('vhost-user-stub.c'))
diff --git a/net/net.c b/net/net.c
index b110e61..1c0bfda 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1091,6 +1091,9 @@ static int (* const net_client_init_fun[NET_CLIENT_DRIVER__MAX])(
 #ifdef CONFIG_NETMAP
         [NET_CLIENT_DRIVER_NETMAP]    = net_init_netmap,
 #endif
+#ifdef CONFIG_AF_XDP
+        [NET_CLIENT_DRIVER_AF_XDP]    = net_init_af_xdp,
+#endif
 #ifdef CONFIG_NET_BRIDGE
         [NET_CLIENT_DRIVER_BRIDGE]    = net_init_bridge,
 #endif
@@ -1195,6 +1198,9 @@ void show_netdevs(void)
 #ifdef CONFIG_NETMAP
         "netmap",
 #endif
+#ifdef CONFIG_AF_XDP
+        "af-xdp",
+#endif
 #ifdef CONFIG_POSIX
         "vhost-user",
 #endif
diff --git a/qapi/net.json b/qapi/net.json
index 313c8a6..8095b68 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -409,6 +409,60 @@
     '*devname':    'str' } }
 
 ##
+# @AFXDPMode:
+#
+# Attach mode for a default XDP program
+#
+# @skb: generic mode, no driver support necessary
+#
+# @native: DRV mode, program is attached to a driver, packets are passed to
+#     the socket without allocation of skb.
+#
+# Since: 8.2
+##
+{ 'enum': 'AFXDPMode',
+  'data': [ 'native', 'skb' ],
+  'if': 'CONFIG_AF_XDP' }
+
+##
+# @NetdevAFXDPOptions:
+#
+# AF_XDP network backend
+#
+# @ifname: The name of an existing network interface.
+#
+# @mode: Attach mode for a default XDP program.  If not specified, then
+#     'native' will be tried first, then 'skb'.
+#
+# @force-copy: Force XDP copy mode even if device supports zero-copy.
+#     (default: false)
+#
+# @queues: number of queues to be used for multiqueue interfaces (default: 1).
+#
+# @start-queue: Use @queues starting from this queue number (default: 0).
+#
+# @inhibit: Don't load a default XDP program, use one already loaded to
+#     the interface (default: false).  Requires @sock-fds.
+#
+# @sock-fds: A colon (:) separated list of file descriptors for already open
+#     but not bound AF_XDP sockets in the queue order.  One fd per queue.
+#     These descriptors should already be added into XDP socket map for
+#     corresponding queues.  Requires @inhibit.
+#
+# Since: 8.2
+##
+{ 'struct': 'NetdevAFXDPOptions',
+  'data': {
+    'ifname':       'str',
+    '*mode':        'AFXDPMode',
+    '*force-copy':  'bool',
+    '*queues':      'int',
+    '*start-queue': 'int',
+    '*inhibit':     'bool',
+    '*sock-fds':    'str' },
+  'if': 'CONFIG_AF_XDP' }
+
+##
 # @NetdevVhostUserOptions:
 #
 # Vhost-user network backend
@@ -642,6 +696,7 @@
 # @vmnet-bridged: since 7.1
 # @stream: since 7.2
 # @dgram: since 7.2
+# @af-xdp: since 8.2
 #
 # Since: 2.7
 ##
@@ -649,6 +704,7 @@
   'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'stream',
             'dgram', 'vde', 'bridge', 'hubport', 'netmap', 'vhost-user',
             'vhost-vdpa',
+            { 'name': 'af-xdp', 'if': 'CONFIG_AF_XDP' },
             { 'name': 'vmnet-host', 'if': 'CONFIG_VMNET' },
             { 'name': 'vmnet-shared', 'if': 'CONFIG_VMNET' },
             { 'name': 'vmnet-bridged', 'if': 'CONFIG_VMNET' }] }
@@ -679,6 +735,8 @@
     'bridge':   'NetdevBridgeOptions',
     'hubport':  'NetdevHubPortOptions',
     'netmap':   'NetdevNetmapOptions',
+    'af-xdp':   { 'type': 'NetdevAFXDPOptions',
+                  'if': 'CONFIG_AF_XDP' },
     'vhost-user': 'NetdevVhostUserOptions',
     'vhost-vdpa': 'NetdevVhostVDPAOptions',
     'vmnet-host': { 'type': 'NetdevVmnetHostOptions',
diff --git a/qemu-options.hx b/qemu-options.hx
index 463f520..c9a110c 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2863,6 +2863,19 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
     "                VALE port (created on the fly) called 'name' ('nmname' is name of the \n"
     "                netmap device, defaults to '/dev/netmap')\n"
 #endif
+#ifdef CONFIG_AF_XDP
+    "-netdev af-xdp,id=str,ifname=name[,mode=native|skb][,force-copy=on|off]\n"
+    "         [,queues=n][,start-queue=m][,inhibit=on|off][,sock-fds=x:y:...:z]\n"
+    "                attach to the existing network interface 'name' with AF_XDP socket\n"
+    "                use 'mode=MODE' to specify an XDP program attach mode\n"
+    "                use 'force-copy=on|off' to force XDP copy mode even if device supports zero-copy (default: off)\n"
+    "                use 'inhibit=on|off' to inhibit loading of a default XDP program (default: off)\n"
+    "                with inhibit=on,\n"
+    "                  use 'sock-fds' to provide file descriptors for already open AF_XDP sockets\n"
+    "                  added to a socket map in XDP program.  One socket per queue.\n"
+    "                use 'queues=n' to specify how many queues of a multiqueue interface should be used\n"
+    "                use 'start-queue=m' to specify the first queue that should be used\n"
+#endif
 #ifdef CONFIG_POSIX
     "-netdev vhost-user,id=str,chardev=dev[,vhostforce=on|off]\n"
     "                configure a vhost-user network, backed by a chardev 'dev'\n"
@@ -2908,6 +2921,9 @@ DEF("nic", HAS_ARG, QEMU_OPTION_nic,
 #ifdef CONFIG_NETMAP
     "netmap|"
 #endif
+#ifdef CONFIG_AF_XDP
+    "af-xdp|"
+#endif
 #ifdef CONFIG_POSIX
     "vhost-user|"
 #endif
@@ -2936,6 +2952,9 @@ DEF("net", HAS_ARG, QEMU_OPTION_net,
 #ifdef CONFIG_NETMAP
     "netmap|"
 #endif
+#ifdef CONFIG_AF_XDP
+    "af-xdp|"
+#endif
 #ifdef CONFIG_VMNET
     "vmnet-host|vmnet-shared|vmnet-bridged|"
 #endif
@@ -2943,7 +2962,7 @@ DEF("net", HAS_ARG, QEMU_OPTION_net,
     "                old way to initialize a host network interface\n"
     "                (use the -netdev option if possible instead)\n", QEMU_ARCH_ALL)
 SRST
-``-nic [tap|bridge|user|l2tpv3|vde|netmap|vhost-user|socket][,...][,mac=macaddr][,model=mn]``
+``-nic [tap|bridge|user|l2tpv3|vde|netmap|af-xdp|vhost-user|socket][,...][,mac=macaddr][,model=mn]``
     This option is a shortcut for configuring both the on-board
     (default) guest NIC hardware and the host network backend in one go.
     The host backend options are the same as with the corresponding
@@ -3357,6 +3376,55 @@ SRST
         # launch QEMU instance
         |qemu_system| linux.img -nic vde,sock=/tmp/myswitch
 
+``-netdev af-xdp,id=str,ifname=name[,mode=native|skb][,force-copy=on|off][,queues=n][,start-queue=m][,inhibit=on|off][,sock-fds=x:y:...:z]``
+    Configure AF_XDP backend to connect to a network interface 'name'
+    using AF_XDP socket.  A specific program attach mode for a default
+    XDP program can be forced with 'mode', defaults to best-effort,
+    where the likely most performant mode will be in use.  Number of queues
+    'n' should generally match the number or queues in the interface,
+    defaults to 1.  Traffic arriving on non-configured device queues will
+    not be delivered to the network backend.
+
+    .. parsed-literal::
+
+        # set number of queues to 4
+        ethtool -L eth0 combined 4
+        # launch QEMU instance
+        |qemu_system| linux.img -device virtio-net-pci,netdev=n1 \\
+            -netdev af-xdp,id=n1,ifname=eth0,queues=4
+
+    'start-queue' option can be specified if a particular range of queues
+    [m, m + n] should be in use.  For example, this is may be necessary in
+    order to use certain NICs in native mode.  Kernel allows the driver to
+    create a separate set of XDP queues on top of regular ones, and only
+    these queues can be used for AF_XDP sockets.  NICs that work this way
+    may also require an additional traffic redirection with ethtool to these
+    special queues.
+
+    .. parsed-literal::
+
+        # set number of queues to 1
+        ethtool -L eth0 combined 1
+        # redirect all the traffic to the second queue (id: 1)
+        # note: drivers may require non-empty key/mask pair.
+        ethtool -N eth0 flow-type ether \\
+            dst 00:00:00:00:00:00 m FF:FF:FF:FF:FF:FE action 1
+        ethtool -N eth0 flow-type ether \\
+            dst 00:00:00:00:00:01 m FF:FF:FF:FF:FF:FE action 1
+        # launch QEMU instance
+        |qemu_system| linux.img -device virtio-net-pci,netdev=n1 \\
+            -netdev af-xdp,id=n1,ifname=eth0,queues=1,start-queue=1
+
+    XDP program can also be loaded externally.  In this case 'inhibit' option
+    should be set to 'on' and 'sock-fds' provided with file descriptors for
+    already open but not bound XDP sockets already added to a socket map for
+    corresponding queues.  One socket per queue.
+
+    .. parsed-literal::
+
+        |qemu_system| linux.img -device virtio-net-pci,netdev=n1 \\
+            -netdev af-xdp,id=n1,ifname=eth0,queues=3,inhibit=on,sock-fds=15:16:17
+
 ``-netdev vhost-user,chardev=id[,vhostforce=on|off][,queues=n]``
     Establish a vhost-user netdev, backed by a chardev id. The chardev
     should be a unix domain socket backed one. The vhost-user uses a
diff --git a/scripts/ci/org.centos/stream/8/x86_64/configure b/scripts/ci/org.centos/stream/8/x86_64/configure
index 131f8ee..76781f1 100755
--- a/scripts/ci/org.centos/stream/8/x86_64/configure
+++ b/scripts/ci/org.centos/stream/8/x86_64/configure
@@ -35,6 +35,7 @@
 --block-drv-ro-whitelist="vmdk,vhdx,vpc,https,ssh" \
 --with-coroutine=ucontext \
 --tls-priority=@QEMU,SYSTEM \
+--disable-af-xdp \
 --disable-attr \
 --disable-auth-pam \
 --disable-avx2 \
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index e1d1783..2301193 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -76,6 +76,7 @@ meson_options_help() {
   printf "%s\n" 'disabled with --disable-FEATURE, default is enabled if available'
   printf "%s\n" '(unless built with --without-default-features):'
   printf "%s\n" ''
+  printf "%s\n" '  af-xdp          AF_XDP network backend support'
   printf "%s\n" '  alsa            ALSA sound support'
   printf "%s\n" '  attr            attr/xattr support'
   printf "%s\n" '  auth-pam        PAM access control'
@@ -208,6 +209,8 @@ meson_options_help() {
 }
 _meson_option_parse() {
   case $1 in
+    --enable-af-xdp) printf "%s" -Daf_xdp=enabled ;;
+    --disable-af-xdp) printf "%s" -Daf_xdp=disabled ;;
     --enable-alsa) printf "%s" -Dalsa=enabled ;;
     --disable-alsa) printf "%s" -Dalsa=disabled ;;
     --enable-attr) printf "%s" -Dattr=enabled ;;
diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/dockerfiles/debian-amd64.docker
index 02262bc..811a7fe 100644
--- a/tests/docker/dockerfiles/debian-amd64.docker
+++ b/tests/docker/dockerfiles/debian-amd64.docker
@@ -98,6 +98,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libvirglrenderer-dev \
                       libvte-2.91-dev \
                       libxen-dev \
+                      libxdp-dev \
                       libzstd-dev \
                       llvm \
                       locales \
-- 
2.7.4


