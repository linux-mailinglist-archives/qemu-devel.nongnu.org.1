Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF057BDCFE
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 15:01:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpprm-0002O9-PL; Mon, 09 Oct 2023 09:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qpprh-0002Mv-QV
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 09:00:05 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qpprf-0001ZW-O2
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 09:00:05 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-58907163519so3406334a12.1
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 05:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1696856281; x=1697461081;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pKJp6Ff3z5nwb7rOcMv4Gg6ohtF4q/WD8FRr4t4CpP8=;
 b=DzyQ18XXwV072xfx4GqZX+jtBwLT3h0iJF2oPjrFHqLw5I5oS4pRTr5Yu/l/nKthkc
 MaftdX8Or3SPQuqTBe1UGifcI8WZoh39z995qnsLCQS0Nsrqf+o7DhMx5UCUSTXD0xMx
 ZTtOHqmkXXlKEdrUdZGFL3J7+Q8j6cVlhQsR2mzRVqbomviG0b+afFN5arnyomVsnPZx
 bisCpBrqR53ORXAAnYC0Kf5J5KXQwWefJojDc/M1DL/ECz15D4wnQQujGue16jxVHYN3
 bqe40VRVowk7EUgoih7GZyLC93PMFWD1MS0HKFnxqNVaRzJZJlgrv3qYyey+mboOq5NV
 8n1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696856281; x=1697461081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pKJp6Ff3z5nwb7rOcMv4Gg6ohtF4q/WD8FRr4t4CpP8=;
 b=r2QrwRYMzucQQyn4LuyB4zUADqoXGUc9wfRAP29OaKrBfamH3MoBoiwgcuKMUFOHm2
 ea90ApQL19tMhzDE2HAZFOpNgTraWbyCHExdYNgqPZ1kuW2DKtAeNmieVTq0aPSU+euW
 KFC7m4PFkJyhR4iLW9ThrAyMgqmJR1j4wUR2zsEwnqcDQT5te4YfC/aESbnvvIiME6Dz
 vhYMLs7sTkjDKAoJXcAF8+AkTT0xTjl2OOOfuqS5u8rj+alAxGQkpF2Na93UxoTPth/7
 0jhbOLQZhvksVOV73jwVtb8OAsT/3/q9jLCDgfBowZJDWr4Fqx5pYACcw3BIFAWz1I2i
 pc/Q==
X-Gm-Message-State: AOJu0YwSFGEljpiCJrKNl93jE507ugYJyyDNP+vUmGmxt2EIdje0UvwL
 3GeYuP4rHw+X24TONdMDnOOAEqLelupGFc/NjWn/UA==
X-Google-Smtp-Source: AGHT+IGGmowDUokRLK6IheF3ar9eiRfhP+3nuGS2EcVmmCQSe6tXjiuf+fHUPQNtZmAWpsz5bnyZAw==
X-Received: by 2002:a17:90a:1089:b0:274:4161:b9dc with SMTP id
 c9-20020a17090a108900b002744161b9dcmr13952589pja.31.1696856280825; 
 Mon, 09 Oct 2023 05:58:00 -0700 (PDT)
Received: from localhost.localdomain ([118.114.95.207])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a17090aec0c00b00268b439a0cbsm8300146pjy.23.2023.10.09.05.57.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 05:58:00 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Andrei Gudkov <gudkov.andrei@huawei.com>,
 Hyman Huang <yong.huang@smartx.com>
Subject: [PULL 2/2] migration/dirtyrate: use QEMU_CLOCK_HOST to report
 start-time
Date: Mon,  9 Oct 2023 20:57:41 +0800
Message-Id: <84719f6d0b75448400068adb78d85000e884f0cd.1696855875.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1696855875.git.yong.huang@smartx.com>
References: <cover.1696855875.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::532;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x532.google.com
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
Reviewed-by: Hyman Huang <yong.huang@smartx.com>
Message-Id: <399861531e3b24a1ecea2ba453fb2c3d129fb03a.1693905328.git.gudkov.andrei@huawei.com>
Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 migration/dirtyrate.c | 15 ++++++---------
 qapi/migration.json   |  4 ++--
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index a461b28bb5..036ac017fc 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -293,11 +293,10 @@ query_dirty_rate_info(TimeUnit calc_time_unit)
     return info;
 }
 
-static void init_dirtyrate_stat(int64_t start_time,
-                                struct DirtyRateConfig config)
+static void init_dirtyrate_stat(struct DirtyRateConfig config)
 {
     DirtyStat.dirty_rate = -1;
-    DirtyStat.start_time = start_time;
+    DirtyStat.start_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) / 1000;
     DirtyStat.calc_time_ms = config.calc_time_ms;
     DirtyStat.sample_pages = config.sample_pages_per_gigabytes;
 
@@ -633,7 +632,7 @@ static void calculate_dirtyrate_dirty_bitmap(struct DirtyRateConfig config)
     record_dirtypages_bitmap(&dirty_pages, true);
 
     start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
-    DirtyStat.start_time = start_time / 1000;
+    DirtyStat.start_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) / 1000;
 
     DirtyStat.calc_time_ms = dirty_stat_wait(config.calc_time_ms, start_time);
 
@@ -659,7 +658,7 @@ static void calculate_dirtyrate_dirty_ring(struct DirtyRateConfig config)
     /* start log sync */
     global_dirty_log_change(GLOBAL_DIRTY_DIRTY_RATE, true);
 
-    DirtyStat.start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) / 1000;
+    DirtyStat.start_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) / 1000;
 
     /* calculate vcpu dirtyrate */
     DirtyStat.calc_time_ms = vcpu_calculate_dirtyrate(config.calc_time_ms,
@@ -685,6 +684,7 @@ static void calculate_dirtyrate_sample_vm(struct DirtyRateConfig config)
 
     rcu_read_lock();
     initial_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+    DirtyStat.start_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) / 1000;
     if (!record_ramblock_hash_info(&block_dinfo, config, &block_count)) {
         goto out;
     }
@@ -692,7 +692,6 @@ static void calculate_dirtyrate_sample_vm(struct DirtyRateConfig config)
 
     DirtyStat.calc_time_ms = dirty_stat_wait(config.calc_time_ms,
                                              initial_time);
-    DirtyStat.start_time = initial_time / 1000;
 
     rcu_read_lock();
     if (!compare_page_hash_info(block_dinfo, block_count)) {
@@ -756,7 +755,6 @@ void qmp_calc_dirty_rate(int64_t calc_time,
     static struct DirtyRateConfig config;
     QemuThread thread;
     int ret;
-    int64_t start_time;
 
     /*
      * If the dirty rate is already being measured, don't attempt to start.
@@ -833,8 +831,7 @@ void qmp_calc_dirty_rate(int64_t calc_time,
      **/
     dirtyrate_mode = mode;
 
-    start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) / 1000;
-    init_dirtyrate_stat(start_time, config);
+    init_dirtyrate_stat(config);
 
     qemu_thread_create(&thread, "get_dirtyrate", get_dirtyrate_thread,
                        (void *)&config, QEMU_THREAD_DETACHED);
diff --git a/qapi/migration.json b/qapi/migration.json
index 1717aa4bbd..d8f3bbd7b0 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1974,13 +1974,13 @@
 # 1. Measurement is in progress:
 #
 # <- {"status": "measuring", "sample-pages": 512,
-#     "mode": "page-sampling", "start-time": 3665220, "calc-time": 10,
+#     "mode": "page-sampling", "start-time": 1693900454, "calc-time": 10,
 #     "calc-time-unit": "second"}
 #
 # 2. Measurement has been completed:
 #
 # <- {"status": "measured", "sample-pages": 512, "dirty-rate": 108,
-#     "mode": "page-sampling", "start-time": 3665220, "calc-time": 10,
+#     "mode": "page-sampling", "start-time": 1693900454, "calc-time": 10,
 #     "calc-time-unit": "second"}
 ##
 { 'command': 'query-dirty-rate', 'data': {'*calc-time-unit': 'TimeUnit' },
-- 
2.39.1


