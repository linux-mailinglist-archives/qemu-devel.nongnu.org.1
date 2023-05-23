Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B1A70E04C
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 17:21:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1ToV-0003Lm-Fg; Tue, 23 May 2023 11:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gudkov.andrei@huawei.com>)
 id 1q1ToT-0003Ld-85
 for qemu-devel@nongnu.org; Tue, 23 May 2023 11:20:37 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gudkov.andrei@huawei.com>)
 id 1q1ToP-0007tT-Mx
 for qemu-devel@nongnu.org; Tue, 23 May 2023 11:20:37 -0400
Received: from lhrpeml500004.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QQdHc6bGcz67ZCD;
 Tue, 23 May 2023 23:18:20 +0800 (CST)
Received: from DESKTOP-0LHM7NF.huawei.com (10.199.58.101) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 16:20:14 +0100
To: <qemu-devel@nongnu.org>
CC: <quintela@redhat.com>, <peterx@redhat.com>, <leobras@redhat.com>,
 <eblake@redhat.com>, <armbru@redhat.com>, Andrei Gudkov
 <gudkov.andrei@huawei.com>
Subject: [PATCH] qapi: better docs for calc-dirty-rate and friends
Date: Tue, 23 May 2023 18:19:56 +0300
Message-ID: <fe7d32a621ebd69ef6974beb2499c0b5dccb9e19.1684854849.git.gudkov.andrei@huawei.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.58.101]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 lhrpeml500004.china.huawei.com (7.191.163.9)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=gudkov.andrei@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Rewrote calc-dirty-rate documentation. Briefly described
different modes of dirty page rate measurement. Added some
examples. Fixed obvious grammar errors.

Signed-off-by: Andrei Gudkov <gudkov.andrei@huawei.com>
---
 qapi/migration.json | 107 +++++++++++++++++++++++++++++++-------------
 1 file changed, 77 insertions(+), 30 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 179af0c4d8..19b51444b5 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1735,14 +1735,14 @@
 ##
 # @DirtyRateStatus:
 #
-# An enumeration of dirtyrate status.
+# Dirty page rate measurement status.
 #
-# @unstarted: the dirtyrate thread has not been started.
+# @unstarted: measuring thread has not been started yet
 #
-# @measuring: the dirtyrate thread is measuring.
+# @measuring: measuring thread is running
 #
-# @measured: the dirtyrate thread has measured and results are
-#     available.
+# @measured: dirty page rate is measured and the results are
+#     available
 #
 # Since: 5.2
 ##
@@ -1752,13 +1752,14 @@
 ##
 # @DirtyRateMeasureMode:
 #
-# An enumeration of mode of measuring dirtyrate.
+# Method used to measure dirty page rate.  Differences between
+# available methods are explained in @calc-dirty-rate.
 #
-# @page-sampling: calculate dirtyrate by sampling pages.
+# @page-sampling: use page sampling
 #
-# @dirty-ring: calculate dirtyrate by dirty ring.
+# @dirty-ring: use dirty ring
 #
-# @dirty-bitmap: calculate dirtyrate by dirty bitmap.
+# @dirty-bitmap: use dirty bitmap
 #
 # Since: 6.2
 ##
@@ -1768,26 +1769,25 @@
 ##
 # @DirtyRateInfo:
 #
-# Information about current dirty page rate of vm.
+# Information about measured dirty page rate.
 #
 # @dirty-rate: an estimate of the dirty page rate of the VM in units
-#     of MB/s, present only when estimating the rate has completed.
+#     of MiB/s. Value is present only when @status is 'measured'.
 #
-# @status: status containing dirtyrate query status includes
-#     'unstarted' or 'measuring' or 'measured'
+# @status: current status of dirty page rate measurements
 #
 # @start-time: start time in units of second for calculation
 #
-# @calc-time: time in units of second for sample dirty pages
+# @calc-time: time period in units of second for which dirty page
+#     rate was measured
 #
-# @sample-pages: page count per GB for sample dirty pages the default
-#     value is 512 (since 6.1)
+# @sample-pages: number of sampled pages per each GiB of guest
+#     memory.  Value is valid only in page-sampling mode (Since 6.1)
 #
-# @mode: mode containing method of calculate dirtyrate includes
-#     'page-sampling' and 'dirty-ring' (Since 6.2)
+# @mode: mode that was used to measure dirty page rate (Since 6.2)
 #
-# @vcpu-dirty-rate: dirtyrate for each vcpu if dirty-ring mode
-#     specified (Since 6.2)
+# @vcpu-dirty-rate: dirty rate for each vCPU if dirty-ring mode
+#     was specified (Since 6.2)
 #
 # Since: 5.2
 ##
@@ -1803,15 +1803,50 @@
 ##
 # @calc-dirty-rate:
 #
-# start calculating dirty page rate for vm
-#
-# @calc-time: time in units of second for sample dirty pages
-#
-# @sample-pages: page count per GB for sample dirty pages the default
-#     value is 512 (since 6.1)
-#
-# @mode: mechanism of calculating dirtyrate includes 'page-sampling'
-#     and 'dirty-ring' (Since 6.1)
+# Starts measuring dirty page rate of the VM.  Results can be
+# retrieved with @query-dirty-rate after measurements are completed.
+#
+# Dirty page rate is the number of pages changed in a given time
+# period expressed in MiB/s.  The following methods of calculation
+# are available:
+#
+# 1. In page sampling mode, a random subset of pages are selected
+#    and hashed twice: once in the beginning of measurement time
+#    period, another one -- in the end.  If two hashes for some page
+#    are different, the page is counted as changed.  Since this
+#    method relies on sampling and hashing, calculated dirty page
+#    rate is only the estimation of its true value.  Setting
+#    @sample-pages to higher value improves estimation quality but
+#    at the cost of higher computational overhead.
+#
+# 2. Dirty bitmap mode captures writes to memory by temporarily
+#    revoking write access to all pages and counting page faults.
+#    Information about modified pages is collected into bitmap,
+#    where each bit corresponds to one guest page.  This mode
+#    requires that KVM accelerator property "dirty-ring-size=N"
+#    is *not* set.
+#
+# 3. Dirty ring mode is similar to dirty bitmap mode, but the
+#    information about modified pages is collected into ring buffer.
+#    This mode tracks page modification per each vCPU separately.
+#    It requires that KVM accelerator property "dirty-ring-size=N"
+#    is set.
+#
+# @calc-time: time period in units of second for which dirty page rate
+#    is calculated.  Note that larger @calc-time values will typically
+#    result in smaller dirty page rates because page dirtying is a
+#    one-time event.  Once some page is counted as dirty during
+#    @calc-time period, further writes to this page will not increase
+#    dirty page rate anymore.
+#
+# @sample-pages: number of sampled pages per each GiB of guest memory.
+#     Default value is 512.  For 4KiB guest pages this corresponds to
+#     sampling ratio of 0.2%.  This argument is used only in page
+#     sampling mode. (Since 6.1)
+#
+# @mode: mechanism for tracking dirty pages.  Default value is
+#    'page-sampling'.  Others are 'dirty-bitmap' and 'dirty-ring'.
+#    (Since 6.1)
 #
 # Since: 5.2
 #
@@ -1828,9 +1863,21 @@
 ##
 # @query-dirty-rate:
 #
-# query dirty page rate in units of MB/s for vm
+# Query results of the most recent invocation of @calc-dirty-rate.
 #
 # Since: 5.2
+#
+# Examples:
+#
+# 1. Measurement is in progress:
+#
+# <- {"status": "measuring", "sample-pages": 512,
+#     "mode": "page-sampling", "start-time": 3665220, "calc-time": 10}
+#
+# 2. Measurement has been completed:
+#
+# <- {"status": "measured", "sample-pages": 512, "dirty-rate": 108,
+#     "mode": "page-sampling", "start-time": 3665220, "calc-time": 10}
 ##
 { 'command': 'query-dirty-rate', 'returns': 'DirtyRateInfo' }
 
-- 
2.30.2


