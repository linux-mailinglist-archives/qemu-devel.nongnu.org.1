Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAE874D472
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 13:21:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIowD-0005uf-HH; Mon, 10 Jul 2023 07:20:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qIowA-0005tY-Hm
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 07:20:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qIow6-0007Jr-Ls
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 07:20:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688988008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sezXNKZ81m6+CPVKSIKmzjr6TnNqwY/5lMG+EBk/0RE=;
 b=aAdRxdYzrzwgoMJWnpvn7CX9qsGXQwWRVqSczntRUuGcILxmZn9TjhblkEcHkRW49FTAoD
 7MN9+WOFjxZL7PCWHhpV5IteBRL97V5D0p201xkdXDtP1GZeEWGRUfNwY3oSZyNwMe2Qe8
 1cIpbgpodrfQnbyrRiFXEnfjp7C+4vo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-237-VSbfQ_XlMf2CCJ8Jbca_lQ-1; Mon, 10 Jul 2023 07:20:04 -0400
X-MC-Unique: VSbfQ_XlMf2CCJ8Jbca_lQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3D7223C0F68D;
 Mon, 10 Jul 2023 11:20:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F40E22166B26;
 Mon, 10 Jul 2023 11:20:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D860A21E6A21; Mon, 10 Jul 2023 13:19:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Andrei Gudkov <gudkov.andrei@huawei.com>,
 Peter Xu <peterx@redhat.com>
Subject: [PULL 1/2] qapi: better docs for calc-dirty-rate and friends
Date: Mon, 10 Jul 2023 13:19:58 +0200
Message-ID: <20230710111959.637011-2-armbru@redhat.com>
In-Reply-To: <20230710111959.637011-1-armbru@redhat.com>
References: <20230710111959.637011-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Andrei Gudkov <gudkov.andrei@huawei.com>

Rewrote calc-dirty-rate documentation. Briefly described
different modes of dirty page rate measurement. Added some
examples. Fixed obvious grammar errors.

Signed-off-by: Andrei Gudkov <gudkov.andrei@huawei.com>
Message-Id: <fe7d32a621ebd69ef6974beb2499c0b5dccb9e19.1684854849.git.gudkov.andrei@huawei.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Peter Xu <peterx@redhat.com>
[Prose tweaked and spacing corrected, as per review]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/migration.json | 97 +++++++++++++++++++++++++++++++++------------
 1 file changed, 71 insertions(+), 26 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 47dfef0278..52ff5bee98 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1745,14 +1745,13 @@
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
+# @measured: dirty page rate is measured and the results are available
 #
 # Since: 5.2
 ##
@@ -1762,13 +1761,14 @@
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
@@ -1778,25 +1778,24 @@
 ##
 # @DirtyRateInfo:
 #
-# Information about current dirty page rate of vm.
+# Information about measured dirty page rate.
 #
 # @dirty-rate: an estimate of the dirty page rate of the VM in units
-#     of MB/s, present only when estimating the rate has completed.
+#     of MiB/s.  Value is present only when @status is 'measured'.
 #
-# @status: status containing dirtyrate query status includes
-#     'unstarted' or 'measuring' or 'measured'
+# @status: current status of dirty page rate measurements
 #
 # @start-time: start time in units of second for calculation
 #
-# @calc-time: time in units of second for sample dirty pages
+# @calc-time: time period for which dirty page rate was measured
+#     (in seconds)
 #
-# @sample-pages: page count per GB for sample dirty pages the default
-#     value is 512 (since 6.1)
+# @sample-pages: number of sampled pages per GiB of guest memory.
+#     Valid only in page-sampling mode (Since 6.1)
 #
-# @mode: mode containing method of calculate dirtyrate includes
-#     'page-sampling' and 'dirty-ring' (Since 6.2)
+# @mode: mode that was used to measure dirty page rate (Since 6.2)
 #
-# @vcpu-dirty-rate: dirtyrate for each vcpu if dirty-ring mode
+# @vcpu-dirty-rate: dirty rate for each vCPU if dirty-ring mode was
 #     specified (Since 6.2)
 #
 # Since: 5.2
@@ -1813,15 +1812,49 @@
 ##
 # @calc-dirty-rate:
 #
-# start calculating dirty page rate for vm
+# Start measuring dirty page rate of the VM.  Results can be retrieved
+# with @query-dirty-rate after measurements are completed.
 #
-# @calc-time: time in units of second for sample dirty pages
+# Dirty page rate is the number of pages changed in a given time
+# period expressed in MiB/s.  The following methods of calculation are
+# available:
 #
-# @sample-pages: page count per GB for sample dirty pages the default
-#     value is 512 (since 6.1)
+# 1. In page sampling mode, a random subset of pages are selected and
+#    hashed twice: once at the beginning of measurement time period,
+#    and once again at the end.  If two hashes for some page are
+#    different, the page is counted as changed.  Since this method
+#    relies on sampling and hashing, calculated dirty page rate is
+#    only an estimate of its true value.  Increasing @sample-pages
+#    improves estimation quality at the cost of higher computational
+#    overhead.
 #
-# @mode: mechanism of calculating dirtyrate includes 'page-sampling'
-#     and 'dirty-ring' (Since 6.1)
+# 2. Dirty bitmap mode captures writes to memory (for example by
+#    temporarily revoking write access to all pages) and counting page
+#    faults.  Information about modified pages is collected into a
+#    bitmap, where each bit corresponds to one guest page.  This mode
+#    requires that KVM accelerator property "dirty-ring-size" is *not*
+#    set.
+#
+# 3. Dirty ring mode is similar to dirty bitmap mode, but the
+#    information about modified pages is collected into ring buffer.
+#    This mode tracks page modification per each vCPU separately.  It
+#    requires that KVM accelerator property "dirty-ring-size" is set.
+#
+# @calc-time: time period in units of second for which dirty page rate
+#     is calculated.  Note that larger @calc-time values will
+#     typically result in smaller dirty page rates because page
+#     dirtying is a one-time event.  Once some page is counted as
+#     dirty during @calc-time period, further writes to this page will
+#     not increase dirty page rate anymore.
+#
+# @sample-pages: number of sampled pages per each GiB of guest memory.
+#     Default value is 512.  For 4KiB guest pages this corresponds to
+#     sampling ratio of 0.2%.  This argument is used only in page
+#     sampling mode.  (Since 6.1)
+#
+# @mode: mechanism for tracking dirty pages.  Default value is
+#     'page-sampling'.  Others are 'dirty-bitmap' and 'dirty-ring'.
+#     (Since 6.1)
 #
 # Since: 5.2
 #
@@ -1838,9 +1871,21 @@
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
2.41.0


