Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EE9BE67D8
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Oct 2025 07:52:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9dNs-0005UC-VG; Fri, 17 Oct 2025 01:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hzuo@redhat.com>) id 1v9dNp-0005N1-NI
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 01:52:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hzuo@redhat.com>) id 1v9dNj-0004wE-T8
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 01:52:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760680316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZZnYCSMiE2VS634K0Y/wCtbBcSCgp0pmS60LU0PsBuM=;
 b=ir+IWmd8MCJ2NKbeqM0/LRXvnLloq8bMz/YvD38Ywbo89Xhh+dfHlujE+JQkbx3tBZ9Qqv
 jllLoLhr1M89JR5st6UVZ7ukE+X0qyviWyklJ7+hcGKU3tiUqbUzYB+4jI3g53q0En8YV3
 wb8evSezQC59Q+2RdA2Q+U34HbYySwg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-wYGejuLNPXWbDTdGai76aA-1; Fri,
 17 Oct 2025 01:51:52 -0400
X-MC-Unique: wYGejuLNPXWbDTdGai76aA-1
X-Mimecast-MFC-AGG-ID: wYGejuLNPXWbDTdGai76aA_1760680312
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B01461954224; Fri, 17 Oct 2025 05:51:51 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.72.116.124])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 402681956056; Fri, 17 Oct 2025 05:51:47 +0000 (UTC)
From: "Houqi (Nick) Zuo" <hzuo@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>,
 Michael Tsirkin <mst@redhat.com>, Lei Yang <leiyang@redhat.com>
Subject: [PATCH v5] net/tap-linux.c: avoid abort when setting invalid fd
Date: Fri, 17 Oct 2025 13:51:12 +0800
Message-ID: <20251017055112.837032-1-hzuo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hzuo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When QEMU creates a tap device automatically and the tap device is
manually removed from the host while the guest is running, the tap
device file descriptor becomes invalid. Later, when the guest executes
shutdown, the tap_fd_set_vnet_hdr_len() function may be called and
abort QEMU with a core dump when attempting to use the invalid fd.

This patch removes many abort() calls in this file. If the fd is found
to be in a bad state (e.g., EBADFD or ENODEV), the related function
will print an error message.

Additionally, the return type of the tap_fd_set_vnet_hdr_len function
is changed to int. When an error occurs during the ioctl() call,
the return value from ioctl() is now passed back to the caller,
allowing the caller to handle the error appropriately.

The expected behavior for this negative test case is that QEMU should
report an error but continue running rather than aborting.

Testing:
- Start QEMU with automatically created tap device
- Manually remove the tap device on the host
- Execute shutdown in the guest
- Verify QEMU reports an error but does not abort

(gdb) bt full
#0  __pthread_kill_implementation (threadid=<optimized out>, signo=signo@entry=6, no_tid=no_tid@entry=0) at pthread_kill.c:44
        tid = <optimized out>
        ret = 0
        pd = <optimized out>
        old_mask = {__val = {10}}
        ret = <optimized out>
#1  0x00007f1710b6bff3 in __pthread_kill_internal (threadid=<optimized out>, signo=6) at pthread_kill.c:78
#2  0x00007f1710b15f56 in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/raise.c:26
        ret = <optimized out>
#3  0x00007f1710afd8fa in __GI_abort () at abort.c:79
        save_stage = 1
        act = {__sigaction_handler = {sa_handler = 0x20, sa_sigaction = 0x20}, sa_mask = {__val = {16929458408262392576, 18446744073709550848, 139737042419943, 139737042419943, 0, 94049703655600, 139737042419943, 139737042670528, 18446744073709550328, 77, 139705603579344, 18446744073709551615, 139737041472378, 139705595179568, 16929458408262392576, 94049679794864}}, sa_flags = 281695456, sa_restorer = 0xa}
#4  0x000055899a71de58 in tap_fd_set_vnet_hdr_len (fd=<optimized out>, len=10) at ../net/tap-linux.c:204
#5  tap_set_vnet_hdr_len (nc=<optimized out>, len=10) at ../net/tap.c:269
        s = <optimized out>
#6  0x000055899a8be67f in qemu_set_vnet_hdr_len (nc=0x2956, len=10588) at ../net/net.c:573
#7  virtio_net_set_mrg_rx_bufs (n=0x5589a72cfa10, mergeable_rx_bufs=<optimized out>, version_1=<error reading variable: Incompatible types on DWARF stack>, hash_report=<optimized out>) at ../hw/net/virtio-net.c:664
        i = 0
        nc = 0x5589a730ab28
#8  virtio_net_set_features (vdev=0x5589a72cfa10, features=0) at ../hw/net/virtio-net.c:897
        n = 0x5589a72cfa10
        err = 0x0
        i = 0
#9  0x000055899a8e4eaa in virtio_set_features_nocheck (vdev=0x5589a72cfa10, val=0) at ../hw/virtio/virtio.c:3079
        k = <optimized out>
        bad = <optimized out>
#10 virtio_reset (opaque=0x5589a72cfa10) at ../hw/virtio/virtio.c:3184
        vdev = 0x5589a72cfa10
        k = 0x5589a5c162b0
        i = 0
#11 0x000055899a630d2b in virtio_bus_reset (bus=0x5589a72cf990) at ../hw/virtio/virtio-bus.c:109
        vdev = <optimized out>
#12 virtio_pci_reset (qdev=0x5589a72c7470) at ../hw/virtio/virtio-pci.c:2311
        proxy = 0x5589a72c7470
        i = 0
        bus = 0x5589a72cf990
#13 0x000055899a686ded in memory_region_write_accessor (mr=<optimized out>, addr=<optimized out>, value=<optimized out>, size=<optimized out>, shift=<optimized out>, mask=<optimized out>, attrs=...) at ../system/memory.c:490
        tmp = <optimized out>
#14 0x000055899a686cbc in access_with_adjusted_size (addr=20, value=0x7f0fbedfde00, size=1, access_size_min=<optimized out>, access_size_max=<optimized out>, access_fn=0x55899a686d30 <memory_region_write_accessor>, mr=0x5589a72c8040, attrs=...) at ../system/memory.c:566
        print_once_ = false
        access_mask = 255
        access_size = 1
        i = 0
        r = 0
        reentrancy_guard_applied = <optimized out>
#15 0x000055899a686ac5 in memory_region_dispatch_write (mr=<optimized out>, addr=20, data=<optimized out>, op=<optimized out>, attrs=...) at ../system/memory.c:1545
        size = <optimized out>
#16 0x000055899a69f7da in flatview_write_continue_step (attrs=..., buf=0x7f1711da6028 <error: Cannot access memory at address 0x7f1711da6028>, len=<optimized out>, mr_addr=20, l=0x7f0fbedfde28, mr=0x5589a72c8040) at ../system/physmem.c:2972
        val = 6
        result = 0
        release_lock = <optimized out>
#17 0x000055899a697c15 in flatview_write_continue (fv=0x7f0f6c124d90, addr=61675730370580, attrs=..., ptr=0x7f1711da6028, len=1, mr_addr=6, l=1, mr=0x0) at ../system/physmem.c:3002
        result = 0
        buf = 0x7f1711da6028 <error: Cannot access memory at address 0x7f1711da6028>
#18 flatview_write (fv=0x7f0f6c124d90, addr=61675730370580, attrs=..., buf=0x7f1711da6028, len=1) at ../system/physmem.c:3033
--Type <RET> for more, q to quit, c to continue without paging--
        l = <optimized out>
        mr_addr = 6
        mr = 0x0
#19 0x000055899a697a91 in address_space_write (as=0x55899bceeba0 <address_space_memory>, addr=61675730370580, attrs=..., buf=0x7f1711da6028, len=1) at ../system/physmem.c:3153
        _rcu_read_auto = 0x1
        result = 0
        fv = 0x2956
#20 0x000055899a91159b in address_space_rw (addr=10588, attrs=..., buf=0x7f1711da6028, len=0, as=<optimized out>, is_write=<optimized out>) at ../system/physmem.c:3163
#21 kvm_cpu_exec (cpu=0x5589a5d68b40) at ../accel/kvm/kvm-all.c:3255
        attrs = {secure = 0, space = 0, user = 0, memory = 0, debug = 0, requester_id = 0, pid = 0, address_type = 0, unspecified = false, _reserved1 = 0 '\000', _reserved2 = 0}
        run = 0x7f1711da6000
        ret = <optimized out>
        run_ret = <optimized out>
#22 0x000055899a9189ca in kvm_vcpu_thread_fn (arg=0x5589a5d68b40) at ../accel/kvm/kvm-accel-ops.c:51
        r = <optimized out>
        cpu = <optimized out>
#23 0x000055899aba817a in qemu_thread_start (args=0x5589a5d72580) at ../util/qemu-thread-posix.c:393
        __clframe = {__cancel_routine = <optimized out>, __cancel_arg = 0x0, __do_it = 1, __cancel_type = <optimized out>}
        qemu_thread_args = 0x5589a5d72580
        start_routine = 0x55899a918850 <kvm_vcpu_thread_fn>
        arg = 0x5589a5d68b40
        r = 0x0
#24 0x00007f1710b6a128 in start_thread (arg=<optimized out>) at pthread_create.c:448
        ret = <optimized out>
        pd = <optimized out>
        out = <optimized out>
        unwind_buf = {cancel_jmp_buf = {{jmp_buf = {32, 8894544057743421332, -1288, 0, 140726164742416, 140726164742679, -8831356496486092908, -8844535456800460908}, mask_was_saved = 0}}, priv = {pad = {0x0, 0x0, 0x0, 0x0}, data = {prev = 0x0, cleanup = 0x0, canceltype = 0}}}
        not_first_call = <optimized out>
#25 0x00007f1710bda924 in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:100

Fixes: 0caed25cd171c611781589b5402161d27d57229c ("virtio: Call set_features during reset")

Signed-off-by: Houqi (Nick) Zuo <hzuo@redhat.com>
---
 net/tap-linux.c | 25 ++++++++++++++++---------
 net/tap_int.h   |  2 +-
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/net/tap-linux.c b/net/tap-linux.c
index 2a90b58467..d6b7533cfd 100644
--- a/net/tap-linux.c
+++ b/net/tap-linux.c
@@ -212,20 +212,25 @@ bool tap_probe_has_tunnel(int fd)
     return true;
 }
 
-void tap_fd_set_vnet_hdr_len(int fd, int len)
+int tap_fd_set_vnet_hdr_len(int fd, int len)
 {
-    if (ioctl(fd, TUNSETVNETHDRSZ, &len) == -1) {
-        fprintf(stderr, "TUNSETVNETHDRSZ ioctl() failed: %s. Exiting.\n",
-                strerror(errno));
-        abort();
+    int ret;
+
+    ret = ioctl(fd, TUNSETVNETHDRSZ, &len);
+    if (ret != 0) {
+        error_report("TUNSETVNETHDRSZ ioctl() failed: %s.", strerror(errno));
     }
+
+    return ret;
 }
 
 int tap_fd_set_vnet_le(int fd, int is_le)
 {
     int arg = is_le ? 1 : 0;
+    int ret;
 
-    if (!ioctl(fd, TUNSETVNETLE, &arg)) {
+    ret = ioctl(fd, TUNSETVNETLE, &arg);
+    if (!ret) {
         return 0;
     }
 
@@ -235,14 +240,16 @@ int tap_fd_set_vnet_le(int fd, int is_le)
     }
 
     error_report("TUNSETVNETLE ioctl() failed: %s.", strerror(errno));
-    abort();
+    return ret;
 }
 
 int tap_fd_set_vnet_be(int fd, int is_be)
 {
     int arg = is_be ? 1 : 0;
+    int ret;
 
-    if (!ioctl(fd, TUNSETVNETBE, &arg)) {
+    ret = ioctl(fd, TUNSETVNETBE, &arg);
+    if (!ret) {
         return 0;
     }
 
@@ -252,7 +259,7 @@ int tap_fd_set_vnet_be(int fd, int is_be)
     }
 
     error_report("TUNSETVNETBE ioctl() failed: %s.", strerror(errno));
-    abort();
+    return ret;
 }
 
 void tap_fd_set_offload(int fd, const NetOffloads *ol)
diff --git a/net/tap_int.h b/net/tap_int.h
index b76a05044b..eed41fedc7 100644
--- a/net/tap_int.h
+++ b/net/tap_int.h
@@ -40,7 +40,7 @@ int tap_probe_has_ufo(int fd);
 int tap_probe_has_uso(int fd);
 bool tap_probe_has_tunnel(int fd);
 void tap_fd_set_offload(int fd, const NetOffloads *ol);
-void tap_fd_set_vnet_hdr_len(int fd, int len);
+int tap_fd_set_vnet_hdr_len(int fd, int len);
 int tap_fd_set_vnet_le(int fd, int vnet_is_le);
 int tap_fd_set_vnet_be(int fd, int vnet_is_be);
 int tap_fd_enable(int fd);
-- 
2.47.3


