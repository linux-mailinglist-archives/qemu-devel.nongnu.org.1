Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE61BDF1E8
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Oct 2025 16:40:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v92fb-00006d-Gm; Wed, 15 Oct 2025 10:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v92fW-00006O-8h
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:39:58 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v92fO-00062N-Dz
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:39:58 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 60E8C889C2;
 Wed, 15 Oct 2025 17:39:44 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a94::1:15])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id gdRVCn3Foa60-sWVMuTAW; Wed, 15 Oct 2025 17:39:43 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760539183;
 bh=ZG7MBLKtWr7FDpexxGzgUyfecOn/If9nG1GsuFcJrDs=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=kbJ1XNbthKNMpBOyoAMVWx7lL5K3WCAIWcMZe6o72tM8/TamogWRZt9DdjWkwSoDc
 Tx6k732K9vgLWhDBb4es2GkLvDCKeEmpRmjZt5GptKGyQ0SrIn6znfsIpQzrIw/Uv2
 /SEgueaJdPBgZybV66O983zZH1xCrmlAsyboLu38=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: devel@lists.libvirt.org, eblake@redhat.com, armbru@redhat.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, vsementsov@yandex-team.ru
Subject: [PATCH v4] qapi: net: deprecate vhostforce option
Date: Wed, 15 Oct 2025 17:39:41 +0300
Message-ID: <20251015143941.1109499-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This option for tap and vhost-user netdevs doesn't make sense
since long ago (10 years!), starting from commits:

 1e7398a140f7a6 ("vhost: enable vhost without without MSI-X")
 24f938a682d934 ("vhost user:support vhost user nic for non msi guests")

Prior these commits, to enable kernel vhost-net, or vhost-user-net for
some specific kind of guests (that don't have MSI-X support), you should
have set vhostforce=on.

Now guest type doesn't matter, all guests are equal for these
options logic.

For tap the current logic is:
  vhost=on / vhost=off : vhostforce ignored, doesn't make sense
  vhost unset : vhostforce counts, enabling vhost

So you may enable vhost for tap several ways:
- vhost=on
- vhostforce=on
- vhost=on + vhostforce=on
- and even vhost=on + vhostforce=off

- they are all equal.

For vhost-user we simply ignore the vhostforce option at all in the
code.

Let's finally deprecate the extra options.

Also, fix @vhostforce documentation everywhere to show the real picture,
and update vhost-user test to not use deprecated option.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---

v4:
- update documentation
- deprecate also similar option for vhost-user net

v3 was "[PATCH v3] qapi: net/tap: deprecate vhostforce option":
Supersedes: <20250901153943.65235-1-vsementsov@yandex-team.ru>

 docs/about/deprecated.rst     | 11 +++++++++++
 qapi/net.json                 | 20 ++++++++++++++++----
 qemu-options.hx               | 13 +++++--------
 tests/qtest/vhost-user-test.c |  2 +-
 4 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 98361f5832..2882603b20 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -487,6 +487,17 @@ Stream ``reconnect`` (since 9.2)
 The ``reconnect`` option only allows specifying second granularity timeouts,
 which is not enough for all types of use cases, use ``reconnect-ms`` instead.
 
+TAP ``vhostforce`` (since 10.2)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The ``vhostforce`` option is redundant with the ``vhost`` option.
+If they conflict, ``vhost`` takes precedence.  Just use ``vhost``.
+
+Vhost-user ``vhostforce`` (since 10.2)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The ``vhostforce`` option is a no-op.  Do not use it.
+
 CPU device properties
 '''''''''''''''''''''
 
diff --git a/qapi/net.json b/qapi/net.json
index 60d196afe5..531b360e46 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -346,13 +346,20 @@
 # @vhostfds: file descriptors of multiple already opened vhost net
 #     devices
 #
-# @vhostforce: vhost on for non-MSIX virtio guests
+# @vhostforce: enable vhost-net network accelerator.  Ignored when
+#    @vhost is set.
 #
 # @queues: number of queues to be created for multiqueue capable tap
 #
 # @poll-us: maximum number of microseconds that could be spent on busy
 #     polling for tap (since 2.7)
 #
+# Features:
+#
+# @deprecated: Member @vhostforce is deprecated.  The @vhostforce
+#    option is redundant with the @vhost option. If they conflict,
+#    @vhost takes precedence.  Just use @vhost.
+#
 # Since: 1.2
 ##
 { 'struct': 'NetdevTapOptions',
@@ -369,7 +376,7 @@
     '*vhost':      'bool',
     '*vhostfd':    'str',
     '*vhostfds':   'str',
-    '*vhostforce': 'bool',
+    '*vhostforce': { 'type': 'bool', 'features': [ 'deprecated' ] },
     '*queues':     'uint32',
     '*poll-us':    'uint32'} }
 
@@ -606,17 +613,22 @@
 #
 # @chardev: name of a unix socket chardev
 #
-# @vhostforce: vhost on for non-MSIX virtio guests (default: false).
+# @vhostforce: no-op (default: false).
 #
 # @queues: number of queues to be created for multiqueue vhost-user
 #     (default: 1) (Since 2.5)
 #
+# Features:
+#
+# @deprecated: Member @vhostforce is deprecated.  The @vhostforce
+#    option is ignored in code and does nothing.  Don't use it.
+#
 # Since: 2.1
 ##
 { 'struct': 'NetdevVhostUserOptions',
   'data': {
     'chardev':        'str',
-    '*vhostforce':    'bool',
+    '*vhostforce': { 'type': 'bool', 'features': [ 'deprecated' ] },
     '*queues':        'int' } }
 
 ##
diff --git a/qemu-options.hx b/qemu-options.hx
index 0223ceffeb..35a70096e8 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2882,7 +2882,7 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
 #else
     "-netdev tap,id=str[,fd=h][,fds=x:y:...:z][,ifname=name][,script=file][,downscript=dfile]\n"
     "         [,br=bridge][,helper=helper][,sndbuf=nbytes][,vnet_hdr=on|off][,vhost=on|off]\n"
-    "         [,vhostfd=h][,vhostfds=x:y:...:z][,vhostforce=on|off][,queues=n]\n"
+    "         [,vhostfd=h][,vhostfds=x:y:...:z][,queues=n]\n"
     "         [,poll-us=n]\n"
     "                configure a host TAP network backend with ID 'str'\n"
     "                connected to a bridge (default=" DEFAULT_BRIDGE_INTERFACE ")\n"
@@ -2898,9 +2898,7 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
     "                default is disabled 'sndbuf=0' to enable flow control set 'sndbuf=1048576')\n"
     "                use vnet_hdr=off to avoid enabling the IFF_VNET_HDR tap flag\n"
     "                use vnet_hdr=on to make the lack of IFF_VNET_HDR support an error condition\n"
-    "                use vhost=on to enable experimental in kernel accelerator\n"
-    "                    (only has effect for virtio guests which use MSIX)\n"
-    "                use vhostforce=on to force vhost on for non-MSIX virtio guests\n"
+    "                use vhost=on to enable in kernel accelerator\n"
     "                use 'vhostfd=h' to connect to an already opened vhost net device\n"
     "                use 'vhostfds=x:y:...:z to connect to multiple already opened vhost net devices\n"
     "                use 'queues=n' to specify the number of queues to be created for multiqueue TAP\n"
@@ -2991,7 +2989,7 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
     "                use 'start-queue=m' to specify the first queue that should be used\n"
 #endif
 #ifdef CONFIG_POSIX
-    "-netdev vhost-user,id=str,chardev=dev[,vhostforce=on|off]\n"
+    "-netdev vhost-user,id=str,chardev=dev\n"
     "                configure a vhost-user network, backed by a chardev 'dev'\n"
 #endif
 #ifdef __linux__
@@ -3882,12 +3880,11 @@ SRST
     for insertion into the socket map.  The combination of 'map-path' and
     'sock-fds' together is not supported.
 
-``-netdev vhost-user,chardev=id[,vhostforce=on|off][,queues=n]``
+``-netdev vhost-user,chardev=id[,queues=n]``
     Establish a vhost-user netdev, backed by a chardev id. The chardev
     should be a unix domain socket backed one. The vhost-user uses a
     specifically defined protocol to pass vhost ioctl replacement
-    messages to an application on the other end of the socket. On
-    non-MSIX guests, the feature can be forced with vhostforce. Use
+    messages to an application on the other end of the socket. Use
     'queues=n' to specify the number of queues to be created for
     multiqueue vhost-user.
 
diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
index 609ff24059..a4862d7087 100644
--- a/tests/qtest/vhost-user-test.c
+++ b/tests/qtest/vhost-user-test.c
@@ -46,7 +46,7 @@
 #define QEMU_CMD_SHM    " -m %d -object memory-backend-shm,id=mem,size=%dM," \
                         " -numa node,memdev=mem"
 #define QEMU_CMD_CHR    " -chardev socket,id=%s,path=%s%s"
-#define QEMU_CMD_NETDEV " -netdev vhost-user,id=hs0,chardev=%s,vhostforce=on"
+#define QEMU_CMD_NETDEV " -netdev vhost-user,id=hs0,chardev=%s"
 
 #define HUGETLBFS_MAGIC       0x958458f6
 
-- 
2.48.1


