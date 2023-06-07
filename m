Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EA2747CB0
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 07:51:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGvOV-0005U2-3L; Wed, 05 Jul 2023 01:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qGvOJ-0005Sg-9Z
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 01:49:27 -0400
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qGvOF-00085a-VP
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 01:49:25 -0400
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id 565BD11F0C6;
 Wed,  5 Jul 2023 05:49:21 +0000 (UTC)
From: ~hyman <hyman@git.sr.ht>
Date: Thu, 08 Jun 2023 00:21:58 +0800
Subject: [PATCH QEMU v7 8/9] migration: Extend query-migrate to provide dirty
 page limit info
MIME-Version: 1.0
Message-ID: <168853615963.17240.15832775267134683267-8@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <168853615963.17240.15832775267134683267-0@git.sr.ht>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hyman =?utf-8?b?SHVhbmco6buE5YuHKQ==?= <yong.huang@smartx.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=173.195.146.151; envelope-from=outgoing@sr.ht;
 helo=mail-b.sr.ht
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-To: ~hyman <yong.huang@smartx.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>

Extend query-migrate to provide throttle time and estimated
ring full time with dirty-limit capability enabled, through which
we can observe if dirty limit take effect during live migration.

Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
---
 include/sysemu/dirtylimit.h    |  2 ++
 migration/migration-hmp-cmds.c | 10 +++++++++
 migration/migration.c          | 10 +++++++++
 qapi/migration.json            | 16 +++++++++++++-
 softmmu/dirtylimit.c           | 39 ++++++++++++++++++++++++++++++++++
 5 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/include/sysemu/dirtylimit.h b/include/sysemu/dirtylimit.h
index 8d2c1f3a6b..d11ebbbbdb 100644
--- a/include/sysemu/dirtylimit.h
+++ b/include/sysemu/dirtylimit.h
@@ -34,4 +34,6 @@ void dirtylimit_set_vcpu(int cpu_index,
 void dirtylimit_set_all(uint64_t quota,
                         bool enable);
 void dirtylimit_vcpu_execute(CPUState *cpu);
+uint64_t dirtylimit_throttle_time_per_round(void);
+uint64_t dirtylimit_ring_full_time(void);
 #endif
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 35e8020bbf..c115ef2d23 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -190,6 +190,16 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
                        info->cpu_throttle_percentage);
     }
=20
+    if (info->has_dirty_limit_throttle_time_per_round) {
+        monitor_printf(mon, "dirty-limit throttle time: %" PRIu64 " us\n",
+                       info->dirty_limit_throttle_time_per_round);
+    }
+
+    if (info->has_dirty_limit_ring_full_time) {
+        monitor_printf(mon, "dirty-limit ring full time: %" PRIu64 " us\n",
+                       info->dirty_limit_ring_full_time);
+    }
+
     if (info->has_postcopy_blocktime) {
         monitor_printf(mon, "postcopy blocktime: %u\n",
                        info->postcopy_blocktime);
diff --git a/migration/migration.c b/migration/migration.c
index a3791900fd..a4dcaa3c91 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -64,6 +64,7 @@
 #include "yank_functions.h"
 #include "sysemu/qtest.h"
 #include "options.h"
+#include "sysemu/dirtylimit.h"
=20
 static NotifierList migration_state_notifiers =3D
     NOTIFIER_LIST_INITIALIZER(migration_state_notifiers);
@@ -974,6 +975,15 @@ static void populate_ram_info(MigrationInfo *info, Migra=
tionState *s)
         info->ram->dirty_pages_rate =3D
            stat64_get(&mig_stats.dirty_pages_rate);
     }
+
+    if (migrate_dirty_limit() && dirtylimit_in_service()) {
+        info->has_dirty_limit_throttle_time_per_round =3D true;
+        info->dirty_limit_throttle_time_per_round =3D
+                            dirtylimit_throttle_time_per_round();
+
+        info->has_dirty_limit_ring_full_time =3D true;
+        info->dirty_limit_ring_full_time =3D dirtylimit_ring_full_time();
+    }
 }
=20
 static void populate_disk_info(MigrationInfo *info)
diff --git a/qapi/migration.json b/qapi/migration.json
index cc51835cdd..ebc15e2782 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -250,6 +250,18 @@
 #     blocked.  Present and non-empty when migration is blocked.
 #     (since 6.0)
 #
+# @dirty-limit-throttle-time-per-round: Maximum throttle time (in microsecon=
ds) of virtual
+#                                       CPUs each dirty ring full round, whi=
ch shows how
+#                                       MigrationCapability dirty-limit affe=
cts the guest
+#                                       during live migration. (since 8.1)
+#
+# @dirty-limit-ring-full-time: Estimated average dirty ring full time (in mi=
croseconds)
+#                              each dirty ring full round, note that the val=
ue equals
+#                              dirty ring memory size divided by average dir=
ty page rate
+#                              of virtual CPU, which can be used to observe =
the average
+#                              memory load of virtual CPU indirectly. Note t=
hat zero
+#                              means guest doesn't dirty memory (since 8.1)
+#
 # Since: 0.14
 ##
 { 'struct': 'MigrationInfo',
@@ -267,7 +279,9 @@
            '*postcopy-blocktime' : 'uint32',
            '*postcopy-vcpu-blocktime': ['uint32'],
            '*compression': 'CompressionStats',
-           '*socket-address': ['SocketAddress'] } }
+           '*socket-address': ['SocketAddress'],
+           '*dirty-limit-throttle-time-per-round': 'uint64',
+           '*dirty-limit-ring-full-time': 'uint64'} }
=20
 ##
 # @query-migrate:
diff --git a/softmmu/dirtylimit.c b/softmmu/dirtylimit.c
index 5134296667..a0686323e5 100644
--- a/softmmu/dirtylimit.c
+++ b/softmmu/dirtylimit.c
@@ -565,6 +565,45 @@ out:
     hmp_handle_error(mon, err);
 }
=20
+/* Return the max throttle time of each virtual CPU */
+uint64_t dirtylimit_throttle_time_per_round(void)
+{
+    CPUState *cpu;
+    int64_t max =3D 0;
+
+    CPU_FOREACH(cpu) {
+        if (cpu->throttle_us_per_full > max) {
+            max =3D cpu->throttle_us_per_full;
+        }
+    }
+
+    return max;
+}
+
+/*
+ * Estimate average dirty ring full time of each virtaul CPU.
+ * Return 0 if guest doesn't dirty memory.
+ */
+uint64_t dirtylimit_ring_full_time(void)
+{
+    CPUState *cpu;
+    uint64_t curr_rate =3D 0;
+    int nvcpus =3D 0;
+
+    CPU_FOREACH(cpu) {
+        if (cpu->running) {
+            nvcpus++;
+            curr_rate +=3D vcpu_dirty_rate_get(cpu->cpu_index);
+        }
+    }
+
+    if (!curr_rate || !nvcpus) {
+        return 0;
+    }
+
+    return dirtylimit_dirty_ring_full_time(curr_rate / nvcpus);
+}
+
 static struct DirtyLimitInfo *dirtylimit_query_vcpu(int cpu_index)
 {
     DirtyLimitInfo *info =3D NULL;
--=20
2.38.5


