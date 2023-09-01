Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E66478F9D3
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 10:19:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbzMQ-00075H-Cr; Fri, 01 Sep 2023 04:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qbzMK-00071y-TH
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 04:18:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qbzMI-00017p-3K
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 04:18:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693556305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MxsQvdy7aSXMQhICY6LdnYvYoqXl8kHSJ9/PbrWeUFI=;
 b=SNEkyWBbArr+XZKs15orJhzBXGC8Zqe4fR6rzp+lVSfyF/DZgKLs4Qv4C2fnUkMwShTQdn
 ytUtjMkNkTJ1N1OljnUMWvntJATKrWzlajVGhoKBZJhan2mGGeAXE/KeWhQqS6+NWXORrT
 0Xtypvo3/yLAD/e5NosdJzXiES2/uGw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-489-Z4aAT--7NyudDlEoxxgRug-1; Fri, 01 Sep 2023 04:18:23 -0400
X-MC-Unique: Z4aAT--7NyudDlEoxxgRug-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4AEDB101A53C;
 Fri,  1 Sep 2023 08:18:23 +0000 (UTC)
Received: from localhost (unknown [10.39.194.146])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F09B363A63;
 Fri,  1 Sep 2023 08:18:22 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org,
	Hanna Czenczek <hreitz@redhat.com>
Subject: [PULL 07/14] throttle: use THROTTLE_MAX/ARRAY_SIZE for hard code
Date: Fri,  1 Sep 2023 10:18:02 +0200
Message-ID: <20230901081804.31377-8-hreitz@redhat.com>
In-Reply-To: <20230901081804.31377-1-hreitz@redhat.com>
References: <20230901081804.31377-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: zhenwei pi <pizhenwei@bytedance.com>

The first dimension of both to_check and
bucket_types_size/bucket_types_units is used as throttle direction,
use THROTTLE_MAX instead of hard coded number. Also use ARRAY_SIZE()
to avoid hard coded number for the second dimension.

Hanna noticed that the two array should be static. Yes, turn them
into static variables.

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
Message-Id: <20230728022006.1098509-8-pizhenwei@bytedance.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 util/throttle.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/util/throttle.c b/util/throttle.c
index 7d3eb6032f..9582899da3 100644
--- a/util/throttle.c
+++ b/util/throttle.c
@@ -142,7 +142,8 @@ int64_t throttle_compute_wait(LeakyBucket *bkt)
 static int64_t throttle_compute_wait_for(ThrottleState *ts,
                                          ThrottleDirection direction)
 {
-    BucketType to_check[2][4] = { {THROTTLE_BPS_TOTAL,
+    static const BucketType to_check[THROTTLE_MAX][4] = {
+                                  {THROTTLE_BPS_TOTAL,
                                    THROTTLE_OPS_TOTAL,
                                    THROTTLE_BPS_READ,
                                    THROTTLE_OPS_READ},
@@ -153,7 +154,7 @@ static int64_t throttle_compute_wait_for(ThrottleState *ts,
     int64_t wait, max_wait = 0;
     int i;
 
-    for (i = 0; i < 4; i++) {
+    for (i = 0; i < ARRAY_SIZE(to_check[THROTTLE_READ]); i++) {
         BucketType index = to_check[direction][i];
         wait = throttle_compute_wait(&ts->cfg.buckets[index]);
         if (wait > max_wait) {
@@ -469,11 +470,11 @@ bool throttle_schedule_timer(ThrottleState *ts,
 void throttle_account(ThrottleState *ts, ThrottleDirection direction,
                       uint64_t size)
 {
-    const BucketType bucket_types_size[2][2] = {
+    static const BucketType bucket_types_size[THROTTLE_MAX][2] = {
         { THROTTLE_BPS_TOTAL, THROTTLE_BPS_READ },
         { THROTTLE_BPS_TOTAL, THROTTLE_BPS_WRITE }
     };
-    const BucketType bucket_types_units[2][2] = {
+    static const BucketType bucket_types_units[THROTTLE_MAX][2] = {
         { THROTTLE_OPS_TOTAL, THROTTLE_OPS_READ },
         { THROTTLE_OPS_TOTAL, THROTTLE_OPS_WRITE }
     };
@@ -486,7 +487,7 @@ void throttle_account(ThrottleState *ts, ThrottleDirection direction,
         units = (double) size / ts->cfg.op_size;
     }
 
-    for (i = 0; i < 2; i++) {
+    for (i = 0; i < ARRAY_SIZE(bucket_types_size[THROTTLE_READ]); i++) {
         LeakyBucket *bkt;
 
         bkt = &ts->cfg.buckets[bucket_types_size[direction][i]];
-- 
2.41.0


