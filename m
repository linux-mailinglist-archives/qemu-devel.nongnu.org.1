Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C339DB4220C
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Sep 2025 15:39:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utng7-0005Gw-VG; Wed, 03 Sep 2025 09:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utnfu-00059S-QA
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 09:37:23 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utnfp-0004w7-QZ
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 09:37:22 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 1D5C2C01A4;
 Wed, 03 Sep 2025 16:37:16 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b8f::1:11])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id BbgRSa3GomI0-Fv3Tkeen; Wed, 03 Sep 2025 16:37:15 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756906635;
 bh=ZIuITB1rd17BNdWGYUy9N1rTVr/YhJCJKjPp4gE6akA=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=na+wOSr64PlakhG5ElD/DgnHtD8yV5pfJdNHEm/CT9VaezRP8lqSV/XV0scoVGXPn
 T/JyoUGjmih+Ul/bFRtJf70k3q+IpIK8t+q7BvSzpDPyZKMJEct7E+vNx67Y3Qq0Cc
 3kIR5RzjG9ubGURRfI3c0MQnIP03MPEpn062RE8I=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 steven.sistare@oracle.com, yc-core@yandex-team.ru, peterx@redhat.com,
 mst@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, philmd@linaro.org, berrange@redhat.com
Subject: [PATCH v2 4/8] qapi: add interface for local TAP migration
Date: Wed,  3 Sep 2025 16:37:01 +0300
Message-ID: <20250903133706.1177633-5-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250903133706.1177633-1-vsementsov@yandex-team.ru>
References: <20250903133706.1177633-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

To migrate TAP device (including open fds) locally, user should:

1. enable local-tap migration capability both on source and target
2. use additional local-incoming=true option for tap on target

Why capability is not enough? We need an option to modify early
initialization of TAP, to avoid opening new fds. The capability
may not be set at the moment of netdev initialization.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 migration/options.c |  7 +++++++
 migration/options.h |  1 +
 qapi/migration.json |  9 ++++++++-
 qapi/net.json       | 12 +++++++++++-
 4 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index 4e923a2e07..6f5af52a5c 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -262,6 +262,13 @@ bool migrate_mapped_ram(void)
     return s->capabilities[MIGRATION_CAPABILITY_MAPPED_RAM];
 }
 
+bool migrate_local_tap(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->capabilities[MIGRATION_CAPABILITY_LOCAL_TAP];
+}
+
 bool migrate_ignore_shared(void)
 {
     MigrationState *s = migrate_get_current();
diff --git a/migration/options.h b/migration/options.h
index 82d839709e..08c0606072 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -30,6 +30,7 @@ bool migrate_colo(void);
 bool migrate_dirty_bitmaps(void);
 bool migrate_events(void);
 bool migrate_mapped_ram(void);
+bool migrate_local_tap(void);
 bool migrate_ignore_shared(void);
 bool migrate_late_block_activate(void);
 bool migrate_multifd(void);
diff --git a/qapi/migration.json b/qapi/migration.json
index 2387c21e9c..992a5b1e2b 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -517,6 +517,12 @@
 #     each RAM page.  Requires a migration URI that supports seeking,
 #     such as a file.  (since 9.0)
 #
+# @local-tap: Migrate TAPs locally, keeping backend alive. Open file
+#     descriptors and TAP-related state are migrated. Only may be
+#     used when migration channel is unix socket. For target device
+#     also @local-incoming option must be specified (since 10.2)
+#     (since 10.2)
+#
 # Features:
 #
 # @unstable: Members @x-colo and @x-ignore-shared are experimental.
@@ -536,7 +542,8 @@
            { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
            'validate-uuid', 'background-snapshot',
            'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
-           'dirty-limit', 'mapped-ram'] }
+           'dirty-limit', 'mapped-ram',
+           { 'name': 'local-tap', 'features': [ 'unstable' ] } ] }
 
 ##
 # @MigrationCapabilityStatus:
diff --git a/qapi/net.json b/qapi/net.json
index 78bcc9871e..8f53549d58 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -353,6 +353,15 @@
 # @poll-us: maximum number of microseconds that could be spent on busy
 #     polling for tap (since 2.7)
 #
+# @local-incoming: Do load open file descriptor for that TAP
+#     on incoming migration. May be used only if QEMU is started
+#     for incoming migration. Will work only together with local-tap
+#     migration capability enabled (default: false) (Since: 10.2)
+#
+# Features:
+#
+# @unstable: Member @local-incoming is experimental
+#
 # Since: 1.2
 ##
 { 'struct': 'NetdevTapOptions',
@@ -371,7 +380,8 @@
     '*vhostfds':   'str',
     '*vhostforce': 'bool',
     '*queues':     'uint32',
-    '*poll-us':    'uint32'} }
+    '*poll-us':    'uint32',
+    '*local-incoming': { 'type': 'bool', 'features': [ 'unstable' ] } } }
 
 ##
 # @NetdevSocketOptions:
-- 
2.48.1


