Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D01766298
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 05:43:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPD5t-0007zA-C9; Thu, 27 Jul 2023 22:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qPD5p-0007we-8u
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 22:20:38 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qPD5n-00073a-MY
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 22:20:36 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-55ba895d457so942888a12.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 19:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1690510834; x=1691115634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tQs4Fsv0nvz66FedKG0+cIDiS7sJUOlO0kK/3h8TTRs=;
 b=kyiw5jllxwHNwrbk3CVtgNjKAtFn+NqoHre5dXloqMy2O7iY6O3MLnYCoiEbc0mBD+
 sHleeYbNdhyQ5ZgFJHiGzqlyvxC/Cou8oVJB4UPfXcKyKPdb8CM2ZKeLxAD20AamByy9
 p1uv+Hfy+P7ut2kjIQKmrNJ3I0P2VOd7KegYOdpO5v2v4cN9QP1NzVbX5wMFl9KThFPy
 FbU8jpaiDobhmfBzjNDiTXO38lFNiKtYEIeTwkoFZtdDH4xKF9VXRGeH8HEZhZ5vaeeG
 mHaawhvtuRZNMU/f5SSYLcoEbTT7hmZCwdwcOYlx6Ke5JW3YDXV8YVLYkhVOFrWj0iiE
 k/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690510834; x=1691115634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tQs4Fsv0nvz66FedKG0+cIDiS7sJUOlO0kK/3h8TTRs=;
 b=LQNfpkdMk5LALZw5MrXUgtHZaGp8j0GtgP6z3BUOSZeV/vObJNbSN83R7NayCsKRdh
 hxtltcs4MR9Qw5bE0EcOcZk0dLdHnkeGG4T7b36IaDvhCJIH3/g+ImoB0Zud7M/RVgRv
 palpUdK+pGuENujpiJeLoKzmbqNXXRbWo0L7m4YUePWRKhI7IXTeRg+vc/HhzHskGjD/
 f0Gb9V9tMsUVWIfMEZ1juu2rL5tsK+2gCdZNnRNCnt9uj4dx+CuNLL+0dL9iVruBOK/G
 L8hpOs4XI6jbRSfJR36b13ntYPUqkN4bzhlcPZJOB+tXscjbuTnQ7NgUdDwpcvyxEEBZ
 M/tw==
X-Gm-Message-State: ABy/qLbEnx22TYLv42q9MnZdDF48hSl5fY/3NR5uTjaWOB+FNLrx3xw1
 XEYATxRYSpIheFHq6bDdzxLD3sgxJ9L5JsyJp+I=
X-Google-Smtp-Source: APBJJlE/DygaADj5u/W1WFcICNeiMm7VI/qeYk9wPlMZpq/6BfajQaxeV7HZDnNT/nTMgxapK0cw8Q==
X-Received: by 2002:a05:6a20:1591:b0:132:84e4:4bea with SMTP id
 h17-20020a056a20159100b0013284e44beamr473910pzj.12.1690510834378; 
 Thu, 27 Jul 2023 19:20:34 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
 by smtp.gmail.com with ESMTPSA id
 b21-20020a170902d31500b001bb9f104328sm2312947plc.146.2023.07.27.19.20.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 19:20:33 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: berto@igalia.com,
	kwolf@redhat.com,
	hreitz@redhat.com
Cc: qemu_oss@crudebyte.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v5 7/9] throttle: use THROTTLE_MAX/ARRAY_SIZE for hard code
Date: Fri, 28 Jul 2023 10:20:04 +0800
Message-Id: <20230728022006.1098509-8-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230728022006.1098509-1-pizhenwei@bytedance.com>
References: <20230728022006.1098509-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pg1-x536.google.com
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

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
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
2.34.1


