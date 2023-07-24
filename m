Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CDF75F24F
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 12:12:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNsWQ-0007zV-Ru; Mon, 24 Jul 2023 06:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qNsW7-0007kv-M0
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 06:10:16 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qNsW5-0000n1-CZ
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 06:10:14 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bb81809ca8so16028805ad.3
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 03:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1690193412; x=1690798212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l5hGyy9C4bW1jMhiyeNJHvEUqyBP6dGee4Td3XP+VNQ=;
 b=dGKWeGwOnxRRUqSUQ3C27211hBZeX74jiz7Exybgc5wMjyPmCqs7psd8D6BxdmBQWV
 i8LfRI5SOk9PGQYkDYcs+v++zVDyX4qWQxscroA+16K5FoTopeqrydePPFlInWZzt8Wx
 xdNoMgg07YNifICgt+XXBpk46xea3S1WOcoLXwYIkbMGwLbWQRsv1IJfG/5ssbHlZrpG
 vQ8XLgAMv6EHbQ47Kx62XomabQtbgo9AMSvCu2n9JyfT5039PKUmpOKixj6tQhr1JOE7
 +0W7+PUVhk20X5GvyxyftNzntxH9iiP4ROcBXl4v5QNPKjkcMEY6r31HCAEm6ziLdQjx
 eGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690193412; x=1690798212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l5hGyy9C4bW1jMhiyeNJHvEUqyBP6dGee4Td3XP+VNQ=;
 b=d+h0sR72eNtL2OCFWkZZwiXqUoPu1LHACrBosFTAM+ZzQDdUTB7GQSL10eFrS+pD10
 ljac6tSccnhfFzsU6RhTSoLNQvT2aZQmWFpIaG01ncdj1ReEQKuEJ0wPcmLY9LMR6Mvd
 yA8WPw6csXVY2SJMlz5M3RHL7cWmY5xD93DtwARk3YTlQgDXvjEJ3AihCG/UkQFmgJ7N
 dxslWoAx6cNCCwIXE3DZC4GOMrOP+ZYJt0b6yJxnf1mtmBuwRjOfHDptM9YvV8Ek9LRX
 Llv09LlA3fTfmEyFf6MXeNXW1KPD+XRLxsax2maMAYr2QTrxBwfJAsS1buHJtM8mgbbb
 N1OA==
X-Gm-Message-State: ABy/qLb32PXgZth1ginM7Mf2+JGGMtHkCs874J2/Z+sc6bYHWPnA+DUH
 LRWxsFUZZuAwLxCcybXaUXSh/A==
X-Google-Smtp-Source: APBJJlETGz88s/ouJ1JfVycBqrVeBHYUuimnWkJsbX8daQAbQfZRg78XTREFvlRfhvDjz7YtlVBfsQ==
X-Received: by 2002:a17:903:2286:b0:1b9:be2e:2b40 with SMTP id
 b6-20020a170903228600b001b9be2e2b40mr11536946plh.50.1690193411881; 
 Mon, 24 Jul 2023 03:10:11 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
 by smtp.gmail.com with ESMTPSA id
 je2-20020a170903264200b001bb9d6b1baasm2419124plb.198.2023.07.24.03.10.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jul 2023 03:10:11 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: berto@igalia.com, kwolf@redhat.com, groug@kaod.org, qemu_oss@crudebyte.com,
 hreitz@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, berrange@redhat.com,
 zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v4 7/9] throttle: use THROTTLE_MAX/ARRAY_SIZE for hard code
Date: Mon, 24 Jul 2023 18:09:37 +0800
Message-Id: <20230724100939.1022984-8-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724100939.1022984-1-pizhenwei@bytedance.com>
References: <20230724100939.1022984-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The first dimension of both to_check and
bucket_types_size/bucket_types_units is used as throttle direction,
use THROTTLE_MAX instead of hard coded number. Also use ARRAY_SIZE()
to avoid hard coded number for the second dimension.

Hanna noticed that the two array should be static. Yes, turn them
into static variables.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 util/throttle.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/util/throttle.c b/util/throttle.c
index 9a37209bb8..9baa6b8a3a 100644
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
2.34.1


