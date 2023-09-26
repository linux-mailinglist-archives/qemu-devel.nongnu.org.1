Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5497AF17E
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 19:01:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlBPm-0002Bo-Db; Tue, 26 Sep 2023 13:00:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlBPd-000275-IX
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:59:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlBPc-0006hr-5M
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:59:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695747591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5O/R/yuV9jt0nLf1xa7RpbeTuLn5AN5h0C14fZowb2E=;
 b=AvVp2aqiz2r9uPtZFcAFh23wuk1vYAKydLliGkshq7HsfKgZQmu0a7dAc71B6NofeqEjuK
 ygIOAkgb0QbQW3XJ58RKd/v8QLWoSMcdLA3YCiR5CtHB2PLjXEQLxxEe7yjJVSU/iJyDPi
 t8JgE7bGH95/59nA1sRct7G1t3rD2u0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-5KIE1dY2OKmupcMcvvsUpA-1; Tue, 26 Sep 2023 12:59:49 -0400
X-MC-Unique: 5KIE1dY2OKmupcMcvvsUpA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4053e4195c6so68138695e9.1
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 09:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695747588; x=1696352388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5O/R/yuV9jt0nLf1xa7RpbeTuLn5AN5h0C14fZowb2E=;
 b=IAznOkkpBs3H7FfYs6sMS/hBRJkAviezmhtbxS+eNv6NEttpwLQZb2qybzJP/o9t8U
 ave3TGtj6EQoBVw5pytvQiyXopHg/Bgfx6FKFm1bqj3Zjbqk5/mn9Q6rzJo+YzEz/6w2
 Zv621pMXF8ylm5LKjcTy216wFdNQBH4MJzm8UgWaouybyKxV4p3/6YMXUQ/hlveLR/Gb
 zow4IO4ZpD+gR3CbDAE5vCArMIkxjYQZk/oRkCY4km2QwnsPON7kehxI+l1h3cH6p/fQ
 VfxUUjbwBQcXxYE7ovXgDlPOUwD4XnufVEPLXGxDuWi5iVdKzyULwysQs+xT9d6IknXt
 jm+Q==
X-Gm-Message-State: AOJu0YwcyZk+njkoWnHtm4aBGW0E2ngA8DF2OF0PYeR96UizcSKeoPaB
 oSL8iryIeOdtKGbBPz3AFIntmL4WS8rzSoJSiqHQxSYmIvZ2TisnF+15nIUa1fX+IGJNBDlfZTR
 lg1nSb6RcWW+xeLNBfx5oHnXk0QCkiRiur90rR1VaAhQZDSE+gd8vxJKDj2Ee9+RyDldMW0Y2B9
 I=
X-Received: by 2002:a5d:4fc9:0:b0:31f:f99c:6009 with SMTP id
 h9-20020a5d4fc9000000b0031ff99c6009mr10513915wrw.22.1695747588391; 
 Tue, 26 Sep 2023 09:59:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0Y1JBHEugMusEpMg8hI1cc2E/z+/h6afjxyDINtf+0dHUQUXV4cyhpTdYYdr28H1Pg9pK9w==
X-Received: by 2002:a5d:4fc9:0:b0:31f:f99c:6009 with SMTP id
 h9-20020a5d4fc9000000b0031ff99c6009mr10513898wrw.22.1695747588045; 
 Tue, 26 Sep 2023 09:59:48 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 x5-20020adfdcc5000000b0031c6581d55esm15351598wrm.91.2023.09.26.09.59.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 09:59:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/19] block: mark mixed functions that can suspend
Date: Tue, 26 Sep 2023 18:59:13 +0200
Message-ID: <20230926165915.738719-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230926165915.738719-1-pbonzini@redhat.com>
References: <20230926165915.738719-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The marking should be extended transitively to all functions that call
these ones, so that static analysis can be done much more efficiently.
However, this is a start and makes it possible to use vrc's path-based
searches to find potential bugs where coroutine_fns call blocking functions.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/io.c              | 5 +++--
 block/qcow2.c           | 2 +-
 block/qed.c             | 4 ++--
 block/throttle-groups.c | 4 ++--
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/block/io.c b/block/io.c
index 209a6da0c8e..e7f9448d5a3 100644
--- a/block/io.c
+++ b/block/io.c
@@ -387,7 +387,8 @@ void bdrv_do_drained_begin_quiesce(BlockDriverState *bs, BdrvChild *parent)
     bdrv_do_drained_begin(bs, parent, false);
 }
 
-void bdrv_drained_begin(BlockDriverState *bs)
+void coroutine_mixed_fn
+bdrv_drained_begin(BlockDriverState *bs)
 {
     IO_OR_GS_CODE();
     bdrv_do_drained_begin(bs, NULL, true);
@@ -506,7 +507,7 @@ void bdrv_drain_all_begin_nopoll(void)
     }
 }
 
-void bdrv_drain_all_begin(void)
+void coroutine_mixed_fn bdrv_drain_all_begin(void)
 {
     BlockDriverState *bs = NULL;
 
diff --git a/block/qcow2.c b/block/qcow2.c
index af43d59d768..5a3c537f146 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -5288,7 +5288,7 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs,
     return spec_info;
 }
 
-static int qcow2_has_zero_init(BlockDriverState *bs)
+static int coroutine_mixed_fn qcow2_has_zero_init(BlockDriverState *bs)
 {
     BDRVQcow2State *s = bs->opaque;
     bool preallocated;
diff --git a/block/qed.c b/block/qed.c
index b2604d9dad3..45ae320290d 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -570,8 +570,8 @@ static void coroutine_fn bdrv_qed_open_entry(void *opaque)
     qemu_co_mutex_unlock(&s->table_lock);
 }
 
-static int bdrv_qed_open(BlockDriverState *bs, QDict *options, int flags,
-                         Error **errp)
+static int coroutine_mixed_fn bdrv_qed_open(BlockDriverState *bs, QDict *options,
+                                            int flags, Error **errp)
 {
     QEDOpenCo qoc = {
         .bs = bs,
diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 3eda4c4e3de..f5c0fac5814 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -317,8 +317,8 @@ static bool coroutine_fn throttle_group_co_restart_queue(ThrottleGroupMember *tg
  * @tgm:       the current ThrottleGroupMember
  * @direction: the ThrottleDirection
  */
-static void schedule_next_request(ThrottleGroupMember *tgm,
-                                  ThrottleDirection direction)
+static void coroutine_mixed_fn schedule_next_request(ThrottleGroupMember *tgm,
+                                                     ThrottleDirection direction)
 {
     ThrottleState *ts = tgm->throttle_state;
     ThrottleGroup *tg = container_of(ts, ThrottleGroup, ts);
-- 
2.41.0


