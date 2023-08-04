Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B907703E3
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 17:05:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRwLR-0000Ie-W0; Fri, 04 Aug 2023 11:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gudkov.andrei@huawei.com>)
 id 1qRwLP-0000IL-QE
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 11:03:59 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gudkov.andrei@huawei.com>)
 id 1qRwLN-0004xQ-Gm
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 11:03:59 -0400
Received: from lhrpeml500004.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RHTQp2BPqz67LyQ;
 Fri,  4 Aug 2023 23:00:02 +0800 (CST)
Received: from DESKTOP-0LHM7NF.huawei.com (10.199.58.101) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 16:03:39 +0100
To: <qemu-devel@nongnu.org>
CC: <yong.huang@smartx.com>, <quintela@redhat.com>, <peterx@redhat.com>,
 <leobras@redhat.com>, <eblake@redhat.com>, <armbru@redhat.com>, Andrei Gudkov
 <gudkov.andrei@huawei.com>
Subject: [PATCH v2] migration/calc-dirty-rate: millisecond-granularity period
Date: Fri, 4 Aug 2023 18:03:27 +0300
Message-ID: <8ddb0d40d143f77aab8f602bd494e01e5fa01614.1691161009.git.gudkov.andrei@huawei.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.58.101]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

Introduces alternative argument calc-time-ms, which is the
the same as calc-time but accepts millisecond value.
Millisecond granularity allows to make predictions whether
migration will succeed or not. To do this, calculate dirty
rate with calc-time-ms set to max allowed downtime, convert
measured rate into volume of dirtied memory, and divide by
network throughput. If the value is lower than max allowed
downtime, then migration will converge.

Measurement results for single thread randomly writing to
a 1/4/24GiB memory region:

+--------------+-----------------------------------------------+
| calc-time-ms |                dirty rate MiB/s               |
|              +----------------+---------------+--------------+
|              | theoretical    | page-sampling | dirty-bitmap |
|              | (at 3M wr/sec) |               |              |
+--------------+----------------+---------------+--------------+
|                             1GiB                             |
+--------------+----------------+---------------+--------------+
|          100 |           6996 |          7100 |         3192 |
|          200 |           4606 |          4660 |         2655 |
|          300 |           3305 |          3280 |         2371 |
|          400 |           2534 |          2525 |         2154 |
|          500 |           2041 |          2044 |         1871 |
|          750 |           1365 |          1341 |         1358 |
|         1000 |           1024 |          1052 |         1025 |
|         1500 |            683 |           678 |          684 |
|         2000 |            512 |           507 |          513 |
+--------------+----------------+---------------+--------------+
|                             4GiB                             |
+--------------+----------------+---------------+--------------+
|          100 |          10232 |          8880 |         4070 |
|          200 |           8954 |          8049 |         3195 |
|          300 |           7889 |          7193 |         2881 |
|          400 |           6996 |          6530 |         2700 |
|          500 |           6245 |          5772 |         2312 |
|          750 |           4829 |          4586 |         2465 |
|         1000 |           3865 |          3780 |         2178 |
|         1500 |           2694 |          2633 |         2004 |
|         2000 |           2041 |          2031 |         1789 |
+--------------+----------------+---------------+--------------+
|                             24GiB                            |
+--------------+----------------+---------------+--------------+
|          100 |          11495 |          8640 |         5597 |
|          200 |          11226 |          8616 |         3527 |
|          300 |          10965 |          8386 |         2355 |
|          400 |          10713 |          8370 |         2179 |
|          500 |          10469 |          8196 |         2098 |
|          750 |           9890 |          7885 |         2556 |
|         1000 |           9354 |          7506 |         2084 |
|         1500 |           8397 |          6944 |         2075 |
|         2000 |           7574 |          6402 |         2062 |
+--------------+----------------+---------------+--------------+

Theoretical values are computed according to the following formula:
size * (1 - (1-(4096/size))^(time*wps)) / (time * 2^20),
where size is in bytes, time is in seconds, and wps is number of
writes per second.

Signed-off-by: Andrei Gudkov <gudkov.andrei@huawei.com>
---
 qapi/migration.json   | 14 ++++++--
 migration/dirtyrate.h | 12 ++++---
 migration/dirtyrate.c | 81 +++++++++++++++++++++++++------------------
 3 files changed, 67 insertions(+), 40 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 8843e74b59..82493d6a57 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1849,7 +1849,11 @@
 # @start-time: start time in units of second for calculation
 #
 # @calc-time: time period for which dirty page rate was measured
-#     (in seconds)
+#     (rounded down to seconds).
+#
+# @calc-time-ms: actual time period for which dirty page rate was
+#     measured (in milliseconds).  Value may be larger than requested
+#     time period due to measurement overhead.
 #
 # @sample-pages: number of sampled pages per GiB of guest memory.
 #     Valid only in page-sampling mode (Since 6.1)
@@ -1866,6 +1870,7 @@
            'status': 'DirtyRateStatus',
            'start-time': 'int64',
            'calc-time': 'int64',
+           'calc-time-ms': 'int64',
            'sample-pages': 'uint64',
            'mode': 'DirtyRateMeasureMode',
            '*vcpu-dirty-rate': [ 'DirtyRateVcpu' ] } }
@@ -1908,6 +1913,10 @@
 #     dirty during @calc-time period, further writes to this page will
 #     not increase dirty page rate anymore.
 #
+# @calc-time-ms: the same as @calc-time but in milliseconds.  These
+#    two arguments are mutually exclusive.  Exactly one of them must
+#    be specified. (Since 8.1)
+#
 # @sample-pages: number of sampled pages per each GiB of guest memory.
 #     Default value is 512.  For 4KiB guest pages this corresponds to
 #     sampling ratio of 0.2%.  This argument is used only in page
@@ -1925,7 +1934,8 @@
 #                                                 'sample-pages': 512} }
 # <- { "return": {} }
 ##
-{ 'command': 'calc-dirty-rate', 'data': {'calc-time': 'int64',
+{ 'command': 'calc-dirty-rate', 'data': {'*calc-time': 'int64',
+                                         '*calc-time-ms': 'int64',
                                          '*sample-pages': 'int',
                                          '*mode': 'DirtyRateMeasureMode'} }
 
diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
index 594a5c0bb6..869c060941 100644
--- a/migration/dirtyrate.h
+++ b/migration/dirtyrate.h
@@ -31,10 +31,12 @@
 #define MIN_RAMBLOCK_SIZE                         128
 
 /*
- * Take 1s as minimum time for calculation duration
+ * Allowed range for dirty page rate calculation (in milliseconds).
+ * Lower limit relates to the smallest realistic downtime it
+ * makes sense to impose on migration.
  */
-#define MIN_FETCH_DIRTYRATE_TIME_SEC              1
-#define MAX_FETCH_DIRTYRATE_TIME_SEC              60
+#define MIN_CALC_TIME_MS                          50
+#define MAX_CALC_TIME_MS                       60000
 
 /*
  * Take 1/16 pages in 1G as the maxmum sample page count
@@ -44,7 +46,7 @@
 
 struct DirtyRateConfig {
     uint64_t sample_pages_per_gigabytes; /* sample pages per GB */
-    int64_t sample_period_seconds; /* time duration between two sampling */
+    int64_t calc_time_ms; /* desired calculation time (in milliseconds) */
     DirtyRateMeasureMode mode; /* mode of dirtyrate measurement */
 };
 
@@ -73,7 +75,7 @@ typedef struct SampleVMStat {
 struct DirtyRateStat {
     int64_t dirty_rate; /* dirty rate in MB/s */
     int64_t start_time; /* calculation start time in units of second */
-    int64_t calc_time; /* time duration of two sampling in units of second */
+    int64_t calc_time_ms; /* actual calculation time (in milliseconds) */
     uint64_t sample_pages; /* sample pages per GB */
     union {
         SampleVMStat page_sampling;
diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index 84f1b0fb20..90fb336329 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -57,6 +57,8 @@ static int64_t dirty_stat_wait(int64_t msec, int64_t initial_time)
         msec = current_time - initial_time;
     } else {
         g_usleep((msec + initial_time - current_time) * 1000);
+        /* g_usleep may overshoot */
+        msec = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) - initial_time;
     }
 
     return msec;
@@ -77,9 +79,12 @@ static int64_t do_calculate_dirtyrate(DirtyPageRecord dirty_pages,
 {
     uint64_t increased_dirty_pages =
         dirty_pages.end_pages - dirty_pages.start_pages;
-    uint64_t memory_size_MiB = qemu_target_pages_to_MiB(increased_dirty_pages);
-
-    return memory_size_MiB * 1000 / calc_time_ms;
+    /*
+     * multiply by 1000ms/s _before_ converting down to megabytes
+     * to avoid losing precision
+     */
+    return qemu_target_pages_to_MiB(increased_dirty_pages * 1000) /
+        calc_time_ms;
 }
 
 void global_dirty_log_change(unsigned int flag, bool start)
@@ -183,10 +188,9 @@ retry:
     return duration;
 }
 
-static bool is_sample_period_valid(int64_t sec)
+static bool is_calc_time_valid(int64_t msec)
 {
-    if (sec < MIN_FETCH_DIRTYRATE_TIME_SEC ||
-        sec > MAX_FETCH_DIRTYRATE_TIME_SEC) {
+    if ((msec < MIN_CALC_TIME_MS) || (msec > MAX_CALC_TIME_MS)) {
         return false;
     }
 
@@ -219,7 +223,8 @@ static struct DirtyRateInfo *query_dirty_rate_info(void)
 
     info->status = CalculatingState;
     info->start_time = DirtyStat.start_time;
-    info->calc_time = DirtyStat.calc_time;
+    info->calc_time_ms = DirtyStat.calc_time_ms;
+    info->calc_time = DirtyStat.calc_time_ms / 1000;
     info->sample_pages = DirtyStat.sample_pages;
     info->mode = dirtyrate_mode;
 
@@ -258,7 +263,7 @@ static void init_dirtyrate_stat(int64_t start_time,
 {
     DirtyStat.dirty_rate = -1;
     DirtyStat.start_time = start_time;
-    DirtyStat.calc_time = config.sample_period_seconds;
+    DirtyStat.calc_time_ms = config.calc_time_ms;
     DirtyStat.sample_pages = config.sample_pages_per_gigabytes;
 
     switch (config.mode) {
@@ -568,7 +573,6 @@ static inline void dirtyrate_manual_reset_protect(void)
 
 static void calculate_dirtyrate_dirty_bitmap(struct DirtyRateConfig config)
 {
-    int64_t msec = 0;
     int64_t start_time;
     DirtyPageRecord dirty_pages;
 
@@ -596,9 +600,7 @@ static void calculate_dirtyrate_dirty_bitmap(struct DirtyRateConfig config)
     start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     DirtyStat.start_time = start_time / 1000;
 
-    msec = config.sample_period_seconds * 1000;
-    msec = dirty_stat_wait(msec, start_time);
-    DirtyStat.calc_time = msec / 1000;
+    DirtyStat.calc_time_ms = dirty_stat_wait(config.calc_time_ms, start_time);
 
     /*
      * do two things.
@@ -609,12 +611,12 @@ static void calculate_dirtyrate_dirty_bitmap(struct DirtyRateConfig config)
 
     record_dirtypages_bitmap(&dirty_pages, false);
 
-    DirtyStat.dirty_rate = do_calculate_dirtyrate(dirty_pages, msec);
+    DirtyStat.dirty_rate = do_calculate_dirtyrate(dirty_pages,
+                                                  DirtyStat.calc_time_ms);
 }
 
 static void calculate_dirtyrate_dirty_ring(struct DirtyRateConfig config)
 {
-    int64_t duration;
     uint64_t dirtyrate = 0;
     uint64_t dirtyrate_sum = 0;
     int i = 0;
@@ -625,12 +627,10 @@ static void calculate_dirtyrate_dirty_ring(struct DirtyRateConfig config)
     DirtyStat.start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) / 1000;
 
     /* calculate vcpu dirtyrate */
-    duration = vcpu_calculate_dirtyrate(config.sample_period_seconds * 1000,
-                                        &DirtyStat.dirty_ring,
-                                        GLOBAL_DIRTY_DIRTY_RATE,
-                                        true);
-
-    DirtyStat.calc_time = duration / 1000;
+    DirtyStat.calc_time_ms = vcpu_calculate_dirtyrate(config.calc_time_ms,
+                                                      &DirtyStat.dirty_ring,
+                                                      GLOBAL_DIRTY_DIRTY_RATE,
+                                                      true);
 
     /* calculate vm dirtyrate */
     for (i = 0; i < DirtyStat.dirty_ring.nvcpu; i++) {
@@ -646,7 +646,6 @@ static void calculate_dirtyrate_sample_vm(struct DirtyRateConfig config)
 {
     struct RamblockDirtyInfo *block_dinfo = NULL;
     int block_count = 0;
-    int64_t msec = 0;
     int64_t initial_time;
 
     rcu_read_lock();
@@ -656,17 +655,16 @@ static void calculate_dirtyrate_sample_vm(struct DirtyRateConfig config)
     }
     rcu_read_unlock();
 
-    msec = config.sample_period_seconds * 1000;
-    msec = dirty_stat_wait(msec, initial_time);
+    DirtyStat.calc_time_ms = dirty_stat_wait(config.calc_time_ms,
+                                             initial_time);
     DirtyStat.start_time = initial_time / 1000;
-    DirtyStat.calc_time = msec / 1000;
 
     rcu_read_lock();
     if (!compare_page_hash_info(block_dinfo, block_count)) {
         goto out;
     }
 
-    update_dirtyrate(msec);
+    update_dirtyrate(DirtyStat.calc_time_ms);
 
 out:
     rcu_read_unlock();
@@ -711,7 +709,10 @@ void *get_dirtyrate_thread(void *arg)
     return NULL;
 }
 
-void qmp_calc_dirty_rate(int64_t calc_time,
+void qmp_calc_dirty_rate(bool has_calc_time,
+                         int64_t calc_time,
+                         bool has_calc_time_ms,
+                         int64_t calc_time_ms,
                          bool has_sample_pages,
                          int64_t sample_pages,
                          bool has_mode,
@@ -731,10 +732,21 @@ void qmp_calc_dirty_rate(int64_t calc_time,
         return;
     }
 
-    if (!is_sample_period_valid(calc_time)) {
-        error_setg(errp, "calc-time is out of range[%d, %d].",
-                         MIN_FETCH_DIRTYRATE_TIME_SEC,
-                         MAX_FETCH_DIRTYRATE_TIME_SEC);
+    if ((int)has_calc_time + (int)has_calc_time_ms != 1) {
+        error_setg(errp, "Exactly one of calc-time and calc-time-ms must"
+                         " be specified");
+        return;
+    }
+    if (has_calc_time) {
+        /*
+         * The worst thing that can happen due to overflow is that
+         * invalid value will become valid.
+         */
+        calc_time_ms = calc_time * 1000;
+    }
+    if (!is_calc_time_valid(calc_time_ms)) {
+        error_setg(errp, "Calculation time is out of range[%dms, %dms].",
+                         MIN_CALC_TIME_MS, MAX_CALC_TIME_MS);
         return;
     }
 
@@ -781,7 +793,7 @@ void qmp_calc_dirty_rate(int64_t calc_time,
         return;
     }
 
-    config.sample_period_seconds = calc_time;
+    config.calc_time_ms = calc_time_ms;
     config.sample_pages_per_gigabytes = sample_pages;
     config.mode = mode;
 
@@ -867,8 +879,11 @@ void hmp_calc_dirty_rate(Monitor *mon, const QDict *qdict)
         mode = DIRTY_RATE_MEASURE_MODE_DIRTY_RING;
     }
 
-    qmp_calc_dirty_rate(sec, has_sample_pages, sample_pages, true,
-                        mode, &err);
+    qmp_calc_dirty_rate(true, sec, /* calc_time */
+                        false, 0, /* calc_time_ms */
+                        has_sample_pages, sample_pages,
+                        true, mode,
+                        &err);
     if (err) {
         hmp_handle_error(mon, err);
         return;
-- 
2.30.2


