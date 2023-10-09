Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8633F7BDCFC
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 15:00:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qppri-0002Mw-Ot; Mon, 09 Oct 2023 09:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qpprf-0002Lx-1P
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 09:00:03 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qpprb-0001Xj-MX
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 09:00:02 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3af65455e7fso3489834b6e.3
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 05:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1696856277; x=1697461077;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PvvlOhgXxsHSv4CHynncK1dG0e5gsZFoMd0PDBld1hI=;
 b=KbsAi7uFUuNrNKf3mYrXvQbpYe0X6BsJhY7/zWajLKjAzwigy7j5GUZ+aprIbhW/Qm
 Kfss/MeX8dTMzDsWA4iKFw8l2LPuNIgdbJugBs8MMip1n+zu7qOGpdq7JRvC61cW0V4G
 C0fh5pBiXLrjtleZPOoylaZ57dQKLVW079OwRREW1XGNu7A6w8OVTpAg+XbXTCsJtUtR
 EoKED3LiNiESGsIvnUyuZ64FH9DjQ3YHvpzlQPP6sGyoEPvvvZF0IEEGN8RfTgZOsfG+
 mN+zkNhHYtm0k7aMGA1xTDqdtOyUDu/oAygvDi+DoBGbSTWDWsxsJNKRmMB+v9akFPZa
 4lag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696856277; x=1697461077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PvvlOhgXxsHSv4CHynncK1dG0e5gsZFoMd0PDBld1hI=;
 b=VySSaFTJ6V/z9LoPNKgwdJOYJnlY7rRqzkjmOBX31ZvzFH/w+b5iyey7LgWzJtFera
 hB3fyKClVcQiBC+0CjwS0NWLCjuoZYRwIkfMaEy/RznXfFHJnTeTKZ8+5MJDhPxMa4t4
 3aZZYs6pVPFD1eOSLOL0bdeu24QKGHGP91q79ac4tbmAWyVFet9WqCakCu0o//a3B19K
 nEE16s7J2UreK/rk72104WohxAEaO1EapblUzMEmzaBhfl25vbtOiIc90uegcERcoDOu
 Ewf36uPgGcJrobSCXyB+xhtsprLyydLyufAP2VyK0HMsjK6CeDoS25y+J8lgbpkBEHEb
 Jzkw==
X-Gm-Message-State: AOJu0YwVejWvcKVsgDDGjsmbVod4KrDa9tOm0mws/9n3nuiQicP4cffp
 zEmkbf5gTVGaMAIk883Cc0+oY65TSuPlCSzcIyGlEQ==
X-Google-Smtp-Source: AGHT+IFPT2YR2pTZdoy1xYniWQgXDUUi+iC+Poo7YlOqDm+vYXrrALRnt+3Bx2W53QfoyEa6jdR4GA==
X-Received: by 2002:a05:6358:702:b0:143:9bc0:a975 with SMTP id
 e2-20020a056358070200b001439bc0a975mr13277848rwj.7.1696856277354; 
 Mon, 09 Oct 2023 05:57:57 -0700 (PDT)
Received: from localhost.localdomain ([118.114.95.207])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a17090aec0c00b00268b439a0cbsm8300146pjy.23.2023.10.09.05.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 05:57:56 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Andrei Gudkov <gudkov.andrei@huawei.com>,
 Hyman Huang <yong.huang@smartx.com>
Subject: [PULL 1/2] migration/calc-dirty-rate: millisecond-granularity period
Date: Mon,  9 Oct 2023 20:57:40 +0800
Message-Id: <e64c2ed130476879b9a2de3e6f7fa84ab50b4015.1696855875.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1696855875.git.yong.huang@smartx.com>
References: <cover.1696855875.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::22d;
 envelope-from=yong.huang@smartx.com; helo=mail-oi1-x22d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Andrei Gudkov via <qemu-devel@nongnu.org>

This patch allows to measure dirty page rate for
sub-second intervals of time. An optional argument is
introduced -- calc-time-unit. For example:
{"execute": "calc-dirty-rate", "arguments":
  {"calc-time": 500, "calc-time-unit": "millisecond"} }

Millisecond granularity allows to make predictions whether
migration will succeed or not. To do this, calculate dirty
rate with calc-time set to max allowed downtime (e.g. 300ms),
convert measured rate into volume of dirtied memory,
and divide by network throughput. If the value is lower
than max allowed downtime, then migration will converge.

Measurement results for single thread randomly writing to
a 1/4/24GiB memory region:

+----------------+-----------------------------------------------+
| calc-time      |                dirty rate MiB/s               |
| (milliseconds) +----------------+---------------+--------------+
|                | theoretical    | page-sampling | dirty-bitmap |
|                | (at 3M wr/sec) |               |              |
+----------------+----------------+---------------+--------------+
|                               1GiB                             |
+----------------+----------------+---------------+--------------+
|            100 |           6996 |          7100 |         3192 |
|            200 |           4606 |          4660 |         2655 |
|            300 |           3305 |          3280 |         2371 |
|            400 |           2534 |          2525 |         2154 |
|            500 |           2041 |          2044 |         1871 |
|            750 |           1365 |          1341 |         1358 |
|           1000 |           1024 |          1052 |         1025 |
|           1500 |            683 |           678 |          684 |
|           2000 |            512 |           507 |          513 |
+----------------+----------------+---------------+--------------+
|                               4GiB                             |
+----------------+----------------+---------------+--------------+
|            100 |          10232 |          8880 |         4070 |
|            200 |           8954 |          8049 |         3195 |
|            300 |           7889 |          7193 |         2881 |
|            400 |           6996 |          6530 |         2700 |
|            500 |           6245 |          5772 |         2312 |
|            750 |           4829 |          4586 |         2465 |
|           1000 |           3865 |          3780 |         2178 |
|           1500 |           2694 |          2633 |         2004 |
|           2000 |           2041 |          2031 |         1789 |
+----------------+----------------+---------------+--------------+
|                               24GiB                            |
+----------------+----------------+---------------+--------------+
|            100 |          11495 |          8640 |         5597 |
|            200 |          11226 |          8616 |         3527 |
|            300 |          10965 |          8386 |         2355 |
|            400 |          10713 |          8370 |         2179 |
|            500 |          10469 |          8196 |         2098 |
|            750 |           9890 |          7885 |         2556 |
|           1000 |           9354 |          7506 |         2084 |
|           1500 |           8397 |          6944 |         2075 |
|           2000 |           7574 |          6402 |         2062 |
+----------------+----------------+---------------+--------------+

Theoretical values are computed according to the following formula:
size * (1 - (1-(4096/size))^(time*wps)) / (time * 2^20),
where size is in bytes, time is in seconds, and wps is number of
writes per second.

Signed-off-by: Andrei Gudkov <gudkov.andrei@huawei.com>
Reviewed-by: Hyman Huang <yong.huang@smartx.com>
Message-Id: <d802e6b8053eb60fbec1a784cf86f67d9528e0a8.1693895970.git.gudkov.andrei@huawei.com>
Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 migration/dirtyrate.c | 107 +++++++++++++++++++++++++++++-------------
 migration/dirtyrate.h |  12 +++--
 qapi/migration.json   |  58 ++++++++++++++++++-----
 3 files changed, 128 insertions(+), 49 deletions(-)

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index bccb3515e3..a461b28bb5 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -189,10 +189,9 @@ retry:
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
 
@@ -216,7 +215,39 @@ static int dirtyrate_set_state(int *state, int old_state, int new_state)
     }
 }
 
-static struct DirtyRateInfo *query_dirty_rate_info(void)
+/* Decimal power of given time unit relative to one second */
+static int time_unit_to_power(TimeUnit time_unit)
+{
+    switch (time_unit) {
+    case TIME_UNIT_SECOND:
+        return 0;
+    case TIME_UNIT_MILLISECOND:
+        return -3;
+    default:
+        assert(false); /* unreachable */
+        return 0;
+    }
+}
+
+static int64_t convert_time_unit(int64_t value, TimeUnit unit_from,
+                                 TimeUnit unit_to)
+{
+    int power = time_unit_to_power(unit_from) -
+                time_unit_to_power(unit_to);
+    while (power < 0) {
+        value /= 10;
+        power += 1;
+    }
+    while (power > 0) {
+        value *= 10;
+        power -= 1;
+    }
+    return value;
+}
+
+
+static struct DirtyRateInfo *
+query_dirty_rate_info(TimeUnit calc_time_unit)
 {
     int i;
     int64_t dirty_rate = DirtyStat.dirty_rate;
@@ -225,7 +256,10 @@ static struct DirtyRateInfo *query_dirty_rate_info(void)
 
     info->status = CalculatingState;
     info->start_time = DirtyStat.start_time;
-    info->calc_time = DirtyStat.calc_time;
+    info->calc_time = convert_time_unit(DirtyStat.calc_time_ms,
+                                        TIME_UNIT_MILLISECOND,
+                                        calc_time_unit);
+    info->calc_time_unit = calc_time_unit;
     info->sample_pages = DirtyStat.sample_pages;
     info->mode = dirtyrate_mode;
 
@@ -264,7 +298,7 @@ static void init_dirtyrate_stat(int64_t start_time,
 {
     DirtyStat.dirty_rate = -1;
     DirtyStat.start_time = start_time;
-    DirtyStat.calc_time = config.sample_period_seconds;
+    DirtyStat.calc_time_ms = config.calc_time_ms;
     DirtyStat.sample_pages = config.sample_pages_per_gigabytes;
 
     switch (config.mode) {
@@ -574,7 +608,6 @@ static inline void dirtyrate_manual_reset_protect(void)
 
 static void calculate_dirtyrate_dirty_bitmap(struct DirtyRateConfig config)
 {
-    int64_t msec = 0;
     int64_t start_time;
     DirtyPageRecord dirty_pages;
 
@@ -602,9 +635,7 @@ static void calculate_dirtyrate_dirty_bitmap(struct DirtyRateConfig config)
     start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     DirtyStat.start_time = start_time / 1000;
 
-    msec = config.sample_period_seconds * 1000;
-    msec = dirty_stat_wait(msec, start_time);
-    DirtyStat.calc_time = msec / 1000;
+    DirtyStat.calc_time_ms = dirty_stat_wait(config.calc_time_ms, start_time);
 
     /*
      * do two things.
@@ -615,12 +646,12 @@ static void calculate_dirtyrate_dirty_bitmap(struct DirtyRateConfig config)
 
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
@@ -631,12 +662,10 @@ static void calculate_dirtyrate_dirty_ring(struct DirtyRateConfig config)
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
@@ -652,7 +681,6 @@ static void calculate_dirtyrate_sample_vm(struct DirtyRateConfig config)
 {
     struct RamblockDirtyInfo *block_dinfo = NULL;
     int block_count = 0;
-    int64_t msec = 0;
     int64_t initial_time;
 
     rcu_read_lock();
@@ -662,17 +690,16 @@ static void calculate_dirtyrate_sample_vm(struct DirtyRateConfig config)
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
@@ -718,6 +745,8 @@ void *get_dirtyrate_thread(void *arg)
 }
 
 void qmp_calc_dirty_rate(int64_t calc_time,
+                         bool has_calc_time_unit,
+                         TimeUnit calc_time_unit,
                          bool has_sample_pages,
                          int64_t sample_pages,
                          bool has_mode,
@@ -737,10 +766,15 @@ void qmp_calc_dirty_rate(int64_t calc_time,
         return;
     }
 
-    if (!is_sample_period_valid(calc_time)) {
-        error_setg(errp, "calc-time is out of range[%d, %d].",
-                         MIN_FETCH_DIRTYRATE_TIME_SEC,
-                         MAX_FETCH_DIRTYRATE_TIME_SEC);
+    int64_t calc_time_ms = convert_time_unit(
+        calc_time,
+        has_calc_time_unit ? calc_time_unit : TIME_UNIT_SECOND,
+        TIME_UNIT_MILLISECOND
+    );
+
+    if (!is_calc_time_valid(calc_time_ms)) {
+        error_setg(errp, "Calculation time is out of range [%dms, %dms].",
+                         MIN_CALC_TIME_MS, MAX_CALC_TIME_MS);
         return;
     }
 
@@ -787,7 +821,7 @@ void qmp_calc_dirty_rate(int64_t calc_time,
         return;
     }
 
-    config.sample_period_seconds = calc_time;
+    config.calc_time_ms = calc_time_ms;
     config.sample_pages_per_gigabytes = sample_pages;
     config.mode = mode;
 
@@ -806,14 +840,18 @@ void qmp_calc_dirty_rate(int64_t calc_time,
                        (void *)&config, QEMU_THREAD_DETACHED);
 }
 
-struct DirtyRateInfo *qmp_query_dirty_rate(Error **errp)
+
+struct DirtyRateInfo *qmp_query_dirty_rate(bool has_calc_time_unit,
+                                           TimeUnit calc_time_unit,
+                                           Error **errp)
 {
-    return query_dirty_rate_info();
+    return query_dirty_rate_info(
+        has_calc_time_unit ? calc_time_unit : TIME_UNIT_SECOND);
 }
 
 void hmp_info_dirty_rate(Monitor *mon, const QDict *qdict)
 {
-    DirtyRateInfo *info = query_dirty_rate_info();
+    DirtyRateInfo *info = query_dirty_rate_info(TIME_UNIT_SECOND);
 
     monitor_printf(mon, "Status: %s\n",
                    DirtyRateStatus_str(info->status));
@@ -873,8 +911,11 @@ void hmp_calc_dirty_rate(Monitor *mon, const QDict *qdict)
         mode = DIRTY_RATE_MEASURE_MODE_DIRTY_RING;
     }
 
-    qmp_calc_dirty_rate(sec, has_sample_pages, sample_pages, true,
-                        mode, &err);
+    qmp_calc_dirty_rate(sec, /* calc-time */
+                        false, TIME_UNIT_SECOND, /* calc-time-unit */
+                        has_sample_pages, sample_pages,
+                        true, mode,
+                        &err);
     if (err) {
         hmp_handle_error(mon, err);
         return;
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
diff --git a/qapi/migration.json b/qapi/migration.json
index 8843e74b59..1717aa4bbd 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1836,6 +1836,21 @@
 { 'enum': 'DirtyRateMeasureMode',
   'data': ['page-sampling', 'dirty-ring', 'dirty-bitmap'] }
 
+##
+# @TimeUnit:
+#
+# Specifies unit in which time-related value is specified.
+#
+# @second: value is in seconds
+#
+# @millisecond: value is in milliseconds
+#
+# Since 8.2
+#
+##
+{ 'enum': 'TimeUnit',
+  'data': ['second', 'millisecond'] }
+
 ##
 # @DirtyRateInfo:
 #
@@ -1848,8 +1863,10 @@
 #
 # @start-time: start time in units of second for calculation
 #
-# @calc-time: time period for which dirty page rate was measured
-#     (in seconds)
+# @calc-time: time period for which dirty page rate was measured,
+#     expressed and rounded down to @calc-time-unit.
+#
+# @calc-time-unit: time unit of @calc-time  (Since 8.2)
 #
 # @sample-pages: number of sampled pages per GiB of guest memory.
 #     Valid only in page-sampling mode (Since 6.1)
@@ -1866,6 +1883,7 @@
            'status': 'DirtyRateStatus',
            'start-time': 'int64',
            'calc-time': 'int64',
+           'calc-time-unit': 'TimeUnit',
            'sample-pages': 'uint64',
            'mode': 'DirtyRateMeasureMode',
            '*vcpu-dirty-rate': [ 'DirtyRateVcpu' ] } }
@@ -1901,12 +1919,16 @@
 #    This mode tracks page modification per each vCPU separately.  It
 #    requires that KVM accelerator property "dirty-ring-size" is set.
 #
-# @calc-time: time period in units of second for which dirty page rate
-#     is calculated.  Note that larger @calc-time values will
-#     typically result in smaller dirty page rates because page
-#     dirtying is a one-time event.  Once some page is counted as
-#     dirty during @calc-time period, further writes to this page will
-#     not increase dirty page rate anymore.
+# @calc-time: time period for which dirty page rate is calculated.
+#     By default it is specified in seconds, but the unit can be set
+#     explicitly with @calc-time-unit.  Note that larger @calc-time
+#     values will typically result in smaller dirty page rates because
+#     page dirtying is a one-time event.  Once some page is counted
+#     as dirty during @calc-time period, further writes to this page
+#     will not increase dirty page rate anymore.
+#
+# @calc-time-unit: time unit in which @calc-time is specified.
+#     By default it is seconds. (Since 8.2)
 #
 # @sample-pages: number of sampled pages per each GiB of guest memory.
 #     Default value is 512.  For 4KiB guest pages this corresponds to
@@ -1924,8 +1946,16 @@
 # -> {"execute": "calc-dirty-rate", "arguments": {"calc-time": 1,
 #                                                 'sample-pages': 512} }
 # <- { "return": {} }
+#
+# Measure dirty rate using dirty bitmap for 500 milliseconds:
+#
+# -> {"execute": "calc-dirty-rate", "arguments": {"calc-time": 500,
+#     "calc-time-unit": "millisecond", "mode": "dirty-bitmap"} }
+#
+# <- { "return": {} }
 ##
 { 'command': 'calc-dirty-rate', 'data': {'calc-time': 'int64',
+                                         '*calc-time-unit': 'TimeUnit',
                                          '*sample-pages': 'int',
                                          '*mode': 'DirtyRateMeasureMode'} }
 
@@ -1934,6 +1964,9 @@
 #
 # Query results of the most recent invocation of @calc-dirty-rate.
 #
+# @calc-time-unit: time unit in which to report calculation time.
+#     By default it is reported in seconds. (Since 8.2)
+#
 # Since: 5.2
 #
 # Examples:
@@ -1941,14 +1974,17 @@
 # 1. Measurement is in progress:
 #
 # <- {"status": "measuring", "sample-pages": 512,
-#     "mode": "page-sampling", "start-time": 3665220, "calc-time": 10}
+#     "mode": "page-sampling", "start-time": 3665220, "calc-time": 10,
+#     "calc-time-unit": "second"}
 #
 # 2. Measurement has been completed:
 #
 # <- {"status": "measured", "sample-pages": 512, "dirty-rate": 108,
-#     "mode": "page-sampling", "start-time": 3665220, "calc-time": 10}
+#     "mode": "page-sampling", "start-time": 3665220, "calc-time": 10,
+#     "calc-time-unit": "second"}
 ##
-{ 'command': 'query-dirty-rate', 'returns': 'DirtyRateInfo' }
+{ 'command': 'query-dirty-rate', 'data': {'*calc-time-unit': 'TimeUnit' },
+                                 'returns': 'DirtyRateInfo' }
 
 ##
 # @DirtyLimitInfo:
-- 
2.39.1


