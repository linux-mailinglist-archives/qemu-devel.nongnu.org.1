Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DCFBDEBB5
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Oct 2025 15:24:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v91SZ-0005Vr-E1; Wed, 15 Oct 2025 09:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v91SP-0005Of-K9
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 09:22:22 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v91S8-00035A-Be
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 09:22:20 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 8D1F288ACC;
 Wed, 15 Oct 2025 16:21:53 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a94::1:15])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id bLQ5oq0N5Os0-ReoYg5YL; Wed, 15 Oct 2025 16:21:52 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760534512;
 bh=XTOoRgjZxbvOOe/95H3efUvxXfxwDYqJdenVX8jbsHM=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=OeLJuhSuwSJgEFCNjYLZoxaXReYsOL0TMm6gMBsFF9M0teWCerTEGYuiDA+BZgjgO
 JQxVEQUQILyqXske7HI8b/pLqsSiY4iGIa+ciu8zmoq+RazPsxcv2B+y95ty/ByPU5
 T8mZHLrfrz9V5SC37aYqfXQMXdgDpum03TXMMcA4=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: peterx@redhat.com, farosas@suse.de, sw@weilnetz.de, eblake@redhat.com,
 armbru@redhat.com, thuth@redhat.com, philmd@linaro.org,
 berrange@redhat.com, qemu-devel@nongnu.org, michael.roth@amd.com,
 steven.sistare@oracle.com, leiyang@redhat.com, davydov-max@yandex-team.ru,
 yc-core@yandex-team.ru, vsementsov@yandex-team.ru,
 raphael.s.norwitz@gmail.com
Subject: [PATCH v8 15/19] net/tap: postpone tap setup to pre-incoming
Date: Wed, 15 Oct 2025 16:21:31 +0300
Message-ID: <20251015132136.1083972-16-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251015132136.1083972-1-vsementsov@yandex-team.ru>
References: <20251015132136.1083972-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

As described in previous commit, to support backend-transfer migration
for virtio-net/tap, we need to postpone the decision to open the device
or to wait for incoming fds up to pre-incoming point (when we actually
can decide).

This commit only postpones TAP-open case of initialization.
We don't try to postpone the all cases of initialization, as it will
require a lot more work of refactoring the code.

So we postpone only the simple case, for which we are going to support
fd-incoming migration:

1. No fds / fd parameters: obviously, if user give fd/fds the should
be used, no incoming backend-transfer migration is possible.

2. No helper: just for simplicity. It probably possible to allow it (and
just ignore in case of backend-transfer migration), to allow user use
same cmdline on target QEMU.. But that questionable, and postponable.

3. No sciprt/downscript. It's not simple to support downscript:
we should pass the responsiblity to call it on target QEMU with
migration.. And back to source QEMU on migration failure. It
feasible, but may be implemented later on demand.

3. Concrete ifname: to not try to share it between queues, when we only
can setup queues as separate entities. Supporting undecided ifname will
require to create some extra netdev state, connecting all the taps, to
be able to iterate through them.

No part of backend-transfer migration is here, we only prepare the code
for future implementation of it.

Are net-drivers prepared to postponed initialization of NICs?
For future feature of backend-transfer migration, we are mainly
interested in virtio-net. So, let's prepare virtio-net to work with
postponed initialization of TAP (two places about early set/get
features) and for other drivers let's simply finalize initialization on
setting netdev property. Support for other drivers may be added later if
needed.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/net/virtio-net.c |  78 ++++++++++++++++++++++++-
 include/net/tap.h   |   3 +
 net/tap-win32.c     |  11 ++++
 net/tap.c           | 136 +++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 226 insertions(+), 2 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 33116712eb..661413c72f 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -719,6 +719,30 @@ default_value:
     return VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE;
 }
 
+static bool peer_wait_incoming(VirtIONet *n)
+{
+    NetClientState *nc = qemu_get_queue(n->nic);
+
+    if (!nc->peer) {
+        return false;
+    }
+
+    if (nc->peer->info->type != NET_CLIENT_DRIVER_TAP) {
+        return false;
+    }
+
+    return tap_wait_incoming(nc->peer);
+}
+
+static bool peer_postponed_init(VirtIONet *n, int index, Error **errp)
+{
+    NetClientState *nc = qemu_get_subqueue(n->nic, index);
+
+    assert(nc->peer->info->type == NET_CLIENT_DRIVER_TAP);
+
+    return tap_postponed_init(nc->peer, errp);
+}
+
 static int peer_attach(VirtIONet *n, int index)
 {
     NetClientState *nc = qemu_get_subqueue(n->nic, index);
@@ -3060,7 +3084,17 @@ static void virtio_net_set_multiqueue(VirtIONet *n, int multiqueue)
     n->multiqueue = multiqueue;
     virtio_net_change_num_queues(n, max * 2 + 1);
 
-    virtio_net_set_queue_pairs(n);
+    /*
+     * virtio_net_set_multiqueue() called from set_features(0) on early
+     * reset, when peer may wait for incoming (and is not initialized
+     * yet).
+     * Don't worry about it: virtio_net_set_queue_pairs() will be called
+     * later form virtio_net_post_load_device(), and anyway will be
+     * noop for local incoming migration with live backend passing.
+     */
+    if (!peer_wait_incoming(n)) {
+        virtio_net_set_queue_pairs(n);
+    }
 }
 
 static int virtio_net_pre_load_queues(VirtIODevice *vdev, uint32_t n)
@@ -3089,6 +3123,17 @@ static void virtio_net_get_features(VirtIODevice *vdev, uint64_t *features,
 
     virtio_add_feature_ex(features, VIRTIO_NET_F_MAC);
 
+    if (peer_wait_incoming(n)) {
+        /*
+         * Excessive feature set is OK for early initialization when
+         * we wait for local incoming migration: actual guest-negotiated
+         * features will come with migration stream anyway. And we are sure
+         * that we support same host-features as source, because the backend
+         * is the same (the same TAP device, for example).
+         */
+        return;
+    }
+
     if (!peer_has_vnet_hdr(n)) {
         virtio_clear_feature_ex(features, VIRTIO_NET_F_CSUM);
         virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_TSO4);
@@ -3180,6 +3225,18 @@ static void virtio_net_get_features(VirtIODevice *vdev, uint64_t *features,
     }
 }
 
+static bool virtio_net_update_host_features(VirtIONet *n, Error **errp)
+{
+    ERRP_GUARD();
+    VirtIODevice *vdev = VIRTIO_DEVICE(n);
+
+    peer_test_vnet_hdr(n);
+
+    virtio_net_get_features(vdev, &vdev->host_features, errp);
+
+    return !*errp;
+}
+
 static int virtio_net_post_load_device(void *opaque, int version_id)
 {
     VirtIONet *n = opaque;
@@ -4177,6 +4234,24 @@ static bool dev_unplug_pending(void *opaque)
     return vdc->primary_unplug_pending(dev);
 }
 
+static bool vhost_user_blk_pre_incoming(void *opaque, Error **errp)
+{
+    VirtIONet *n = opaque;
+    int i;
+
+    if (peer_wait_incoming(n)) {
+        for (i = 0; i < n->max_queue_pairs; i++) {
+            if (!peer_postponed_init(n, i, errp)) {
+                return false;
+            }
+        }
+
+        return virtio_net_update_host_features(n, errp);
+    }
+
+    return true;
+}
+
 static const VMStateDescription vmstate_virtio_net = {
     .name = "virtio-net",
     .minimum_version_id = VIRTIO_NET_VM_VERSION,
@@ -4185,6 +4260,7 @@ static const VMStateDescription vmstate_virtio_net = {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
     },
+    .pre_incoming = vhost_user_blk_pre_incoming,
     .pre_save = virtio_net_pre_save,
     .dev_unplug_pending = dev_unplug_pending,
 };
diff --git a/include/net/tap.h b/include/net/tap.h
index 6f34f13eae..5a926ba513 100644
--- a/include/net/tap.h
+++ b/include/net/tap.h
@@ -33,4 +33,7 @@ int tap_disable(NetClientState *nc);
 
 int tap_get_fd(NetClientState *nc);
 
+bool tap_wait_incoming(NetClientState *nc);
+bool tap_postponed_init(NetClientState *nc, Error **errp);
+
 #endif /* QEMU_NET_TAP_H */
diff --git a/net/tap-win32.c b/net/tap-win32.c
index 38baf90e0b..7430cdf6fa 100644
--- a/net/tap-win32.c
+++ b/net/tap-win32.c
@@ -766,3 +766,14 @@ int tap_disable(NetClientState *nc)
 {
     abort();
 }
+
+bool tap_wait_incoming(NetClientState *nc)
+{
+    return false;
+}
+
+bool tap_postponed_init(NetClientState *nc, Error **errp)
+{
+    error_setg(errp, "win32 tap postponed init is not supported");
+    return false;
+}
diff --git a/net/tap.c b/net/tap.c
index 7e85444ace..8afbf3b407 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -35,7 +35,9 @@
 #include "net/eth.h"
 #include "net/net.h"
 #include "clients.h"
+#include "migration/misc.h"
 #include "monitor/monitor.h"
+#include "system/runstate.h"
 #include "system/system.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
@@ -88,6 +90,13 @@ typedef struct TAPState {
     int sndbuf;
     int vhostfd;
     uint32_t vhost_busyloop_timeout;
+
+    /* for postponed setup */
+    QTAILQ_ENTRY(TAPState) next;
+    bool vnet_hdr_required;
+    int vnet_hdr;
+    bool mq_required;
+    char *ifname;
 } TAPState;
 
 static bool net_tap_setup(TAPState *s, int fd, int vnet_hdr, Error **errp);
@@ -366,6 +375,8 @@ static void tap_cleanup(NetClientState *nc)
         close(s->vhostfd);
         s->vhostfd = -1;
     }
+
+    g_free(s->ifname);
 }
 
 static void tap_poll(NetClientState *nc, bool enable)
@@ -383,6 +394,25 @@ static bool tap_set_steering_ebpf(NetClientState *nc, int prog_fd)
     return tap_fd_set_steering_ebpf(s->fd, prog_fd) == 0;
 }
 
+static bool tap_check_peer_type(NetClientState *nc, ObjectClass *oc,
+                                Error **errp)
+{
+    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    const char *driver = object_class_get_name(oc);
+
+    if (!g_str_has_prefix(driver, "virtio-net-")) {
+        /*
+         * Only virtio-net support postponed TAP initialization, so
+         * for other drivers let's finalize initialization now.
+         */
+        if (tap_wait_incoming(nc)) {
+            return tap_postponed_init(&s->nc, errp);
+        }
+    }
+
+    return true;
+}
+
 int tap_get_fd(NetClientState *nc)
 {
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
@@ -422,6 +452,7 @@ static NetClientInfo net_tap_info = {
     .set_vnet_be = tap_set_vnet_be,
     .set_steering_ebpf = tap_set_steering_ebpf,
     .get_vhost_net = tap_get_vhost_net,
+    .check_peer_type = tap_check_peer_type,
 };
 
 static TAPState *net_tap_new(NetClientState *peer, const char *model,
@@ -845,6 +876,93 @@ static int get_fds(char *str, char *fds[], int max)
     return i;
 }
 
+#define TAP_OPEN_IFNAME_SZ 128
+
+bool tap_postponed_init(NetClientState *nc, Error **errp)
+{
+    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    char ifname[TAP_OPEN_IFNAME_SZ];
+    int vnet_hdr = s->vnet_hdr;
+    int fd;
+
+    pstrcpy(ifname, sizeof(ifname), s->ifname);
+    fd = net_tap_open(&vnet_hdr, s->vnet_hdr_required, NULL,
+                      ifname, sizeof(ifname),
+                      s->mq_required, errp);
+    if (fd < 0) {
+        goto fail;
+    }
+
+    if (!net_tap_setup(s, fd, vnet_hdr, errp)) {
+        goto fail;
+    }
+
+    return true;
+
+fail:
+    qemu_del_net_client(&s->nc);
+    return false;
+}
+
+static bool check_no_script(const char *script_arg)
+{
+    return script_arg &&
+        (script_arg[0] == '\0' || strcmp(script_arg, "no") == 0);
+}
+
+static bool tap_postpone_init(const NetdevTapOptions *tap,
+                              const char *name, NetClientState *peer,
+                              bool *postponed, Error **errp)
+{
+    int queues = tap->has_queues ? tap->queues : 1;
+
+    *postponed = false;
+
+    if (!runstate_check(RUN_STATE_INMIGRATE)) {
+        return true;
+    }
+
+    if (tap->fd || tap->fds || tap->helper || tap->vhostfds) {
+        return true;
+    }
+
+    if (!tap->ifname || tap->ifname[0] == '\0' ||
+        strstr(tap->ifname, "%d") != NULL) {
+        /*
+         * It's hard to postpone logic of parsing template or
+         * absent ifname
+         */
+        return true;
+    }
+
+    /*
+     * Supporting downscipt means understanding and realizing the logic of
+     * transfer of responsibility to call it in target QEMU process. Or in
+     * source QEMU process in case of migration failure. So for simplicity we
+     * don't support scripts together with fds migration.
+     */
+    if (!check_no_script(tap->script) || !check_no_script(tap->downscript)) {
+        return true;
+    }
+
+    for (int i = 0; i < queues; i++) {
+        TAPState *s = net_tap_new(peer, "tap", name, tap, NULL, errp);
+        if (!s) {
+            return false;
+        }
+
+        s->vnet_hdr_required = tap->has_vnet_hdr && tap->vnet_hdr;
+        s->vnet_hdr = tap->has_vnet_hdr ? tap->vnet_hdr : 1;
+        s->mq_required = queues > 1;
+        s->ifname = g_strdup(tap->ifname);
+        qemu_set_info_str(&s->nc, "ifname=%s,script=no,downscript=no",
+                          tap->ifname);
+    }
+
+    *postponed = true;
+    return true;
+}
+
 int net_init_tap(const Netdev *netdev, const char *name,
                  NetClientState *peer, Error **errp)
 {
@@ -853,8 +971,9 @@ int net_init_tap(const Netdev *netdev, const char *name,
     /* for the no-fd, no-helper case */
     Error *err = NULL;
     const char *vhostfdname;
-    char ifname[128];
+    char ifname[TAP_OPEN_IFNAME_SZ];
     int ret = 0;
+    bool postponed = false;
 
     assert(netdev->type == NET_CLIENT_DRIVER_TAP);
     tap = &netdev->u.tap;
@@ -873,6 +992,14 @@ int net_init_tap(const Netdev *netdev, const char *name,
         return -1;
     }
 
+    if (!tap_postpone_init(tap, name, peer, &postponed, errp)) {
+        return -1;
+    }
+
+    if (postponed) {
+        return 0;
+    }
+
     if (tap->fd) {
         if (tap->ifname || tap->script || tap->downscript ||
             tap->has_vnet_hdr || tap->helper || tap->has_queues ||
@@ -1097,3 +1224,10 @@ int tap_disable(NetClientState *nc)
         return ret;
     }
 }
+
+bool tap_wait_incoming(NetClientState *nc)
+{
+    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+
+    return s->fd == -1;
+}
-- 
2.48.1


