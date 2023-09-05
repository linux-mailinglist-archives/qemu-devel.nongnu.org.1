Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE249792161
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 11:20:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdSDU-0005bp-Ch; Tue, 05 Sep 2023 05:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gudkov.andrei@huawei.com>)
 id 1qdSDS-0005bd-I2
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 05:19:22 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gudkov.andrei@huawei.com>)
 id 1qdSDP-0005Ov-Vt
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 05:19:22 -0400
Received: from lhrpeml500004.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rg0Lj2lNNz6FH7y;
 Tue,  5 Sep 2023 17:19:09 +0800 (CST)
Received: from DESKTOP-0LHM7NF.huawei.com (10.199.58.101) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 5 Sep 2023 10:19:12 +0100
To: <qemu-devel@nongnu.org>
CC: <yong.huang@smartx.com>, <quintela@redhat.com>, <peterx@redhat.com>,
 <leobras@redhat.com>, <eblake@redhat.com>, <armbru@redhat.com>, Andrei Gudkov
 <gudkov.andrei@huawei.com>
Subject: [PATCH] migration/dirtyrate: use QEMU_CLOCK_HOST to report start-time
Date: Tue, 5 Sep 2023 12:18:39 +0300
Message-ID: <399861531e3b24a1ecea2ba453fb2c3d129fb03a.1693905328.git.gudkov.andrei@huawei.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.58.101]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 lhrpeml500004.china.huawei.com (7.191.163.9)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=gudkov.andrei@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Andrei Gudkov <gudkov.andrei@huawei.com>
From:  Andrei Gudkov via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Currently query-dirty-rate uses QEMU_CLOCK_REALTIME as
the source for start-time field. This translates to
clock_gettime(CLOCK_MONOTONIC), i.e. number of seconds
since host boot. This is not very useful. The only
reasonable use case of start-time I can imagine is to
check whether previously completed measurements are
too old or not. But this makes sense only if start-time
is reported as host wall-clock time.

This patch replaces source of start-time from
QEMU_CLOCK_REALTIME to QEMU_CLOCK_HOST.

Signed-off-by: Andrei Gudkov <gudkov.andrei@huawei.com>
---
 qapi/migration.json   |  4 ++--
 migration/dirtyrate.c | 15 ++++++---------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 8843e74b59..63deb8e387 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1941,12 +1941,12 @@
 # 1. Measurement is in progress:
 #
 # <- {"status": "measuring", "sample-pages": 512,
-#     "mode": "page-sampling", "start-time": 3665220, "calc-time": 10}
+#     "mode": "page-sampling", "start-time": 1693900454, "calc-time": 10}
 #
 # 2. Measurement has been completed:
 #
 # <- {"status": "measured", "sample-pages": 512, "dirty-rate": 108,
-#     "mode": "page-sampling", "start-time": 3665220, "calc-time": 10}
+#     "mode": "page-sampling", "start-time": 1693900454, "calc-time": 10}
 ##
 { 'command': 'query-dirty-rate', 'returns': 'DirtyRateInfo' }
 
diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index bccb3515e3..0510d68765 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -259,11 +259,10 @@ static struct DirtyRateInfo *query_dirty_rate_info(void)
     return info;
 }
 
-static void init_dirtyrate_stat(int64_t start_time,
-                                struct DirtyRateConfig config)
+static void init_dirtyrate_stat(struct DirtyRateConfig config)
 {
     DirtyStat.dirty_rate = -1;
-    DirtyStat.start_time = start_time;
+    DirtyStat.start_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) / 1000;
     DirtyStat.calc_time = config.sample_period_seconds;
     DirtyStat.sample_pages = config.sample_pages_per_gigabytes;
 
@@ -600,7 +599,7 @@ static void calculate_dirtyrate_dirty_bitmap(struct DirtyRateConfig config)
     record_dirtypages_bitmap(&dirty_pages, true);
 
     start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
-    DirtyStat.start_time = start_time / 1000;
+    DirtyStat.start_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) / 1000;
 
     msec = config.sample_period_seconds * 1000;
     msec = dirty_stat_wait(msec, start_time);
@@ -628,7 +627,7 @@ static void calculate_dirtyrate_dirty_ring(struct DirtyRateConfig config)
     /* start log sync */
     global_dirty_log_change(GLOBAL_DIRTY_DIRTY_RATE, true);
 
-    DirtyStat.start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) / 1000;
+    DirtyStat.start_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) / 1000;
 
     /* calculate vcpu dirtyrate */
     duration = vcpu_calculate_dirtyrate(config.sample_period_seconds * 1000,
@@ -657,6 +656,7 @@ static void calculate_dirtyrate_sample_vm(struct DirtyRateConfig config)
 
     rcu_read_lock();
     initial_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+    DirtyStat.start_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) / 1000;
     if (!record_ramblock_hash_info(&block_dinfo, config, &block_count)) {
         goto out;
     }
@@ -664,7 +664,6 @@ static void calculate_dirtyrate_sample_vm(struct DirtyRateConfig config)
 
     msec = config.sample_period_seconds * 1000;
     msec = dirty_stat_wait(msec, initial_time);
-    DirtyStat.start_time = initial_time / 1000;
     DirtyStat.calc_time = msec / 1000;
 
     rcu_read_lock();
@@ -727,7 +726,6 @@ void qmp_calc_dirty_rate(int64_t calc_time,
     static struct DirtyRateConfig config;
     QemuThread thread;
     int ret;
-    int64_t start_time;
 
     /*
      * If the dirty rate is already being measured, don't attempt to start.
@@ -799,8 +797,7 @@ void qmp_calc_dirty_rate(int64_t calc_time,
      **/
     dirtyrate_mode = mode;
 
-    start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) / 1000;
-    init_dirtyrate_stat(start_time, config);
+    init_dirtyrate_stat(config);
 
     qemu_thread_create(&thread, "get_dirtyrate", get_dirtyrate_thread,
                        (void *)&config, QEMU_THREAD_DETACHED);
-- 
2.30.2


