Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6B2741399
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 16:18:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEVy8-0000Ag-PY; Wed, 28 Jun 2023 10:16:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qEVxz-0008KI-T2
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 10:16:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qEVxv-0005Ju-UR
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 10:16:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687961773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NNdey+2prP52WwmuB2h/vSY2F10MfJd4l5OxAv2Ta2I=;
 b=C+WTi/QR0dTM/C+sgS044AnL+MH8tlWy6UXwswJVoNsZVBVCESEoS4jD//FW5fN8XkoMlz
 9baObCbB1a4ziZqhvAeuLnvyevLJyvPSFs2yIZL+ey8fq6fuOpvltb4QcXjr3cu7JrE9jI
 ztyeBEvn1CoCZxqjGomtSzPRdeFF3r8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-pelGskSnMymMV-6lCu1gcw-1; Wed, 28 Jun 2023 10:16:09 -0400
X-MC-Unique: pelGskSnMymMV-6lCu1gcw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 434893C11A3D;
 Wed, 28 Jun 2023 14:15:53 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.195.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 902D340C2063;
 Wed, 28 Jun 2023 14:15:52 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 13/23] qed: mark more functions as coroutine_fns and
 GRAPH_RDLOCK
Date: Wed, 28 Jun 2023 16:15:16 +0200
Message-ID: <20230628141526.293104-14-kwolf@redhat.com>
In-Reply-To: <20230628141526.293104-1-kwolf@redhat.com>
References: <20230628141526.293104-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Paolo Bonzini <pbonzini@redhat.com>

Mark functions as coroutine_fn when they are only called by other coroutine_fns
and they can suspend.  Change calls to co_wrappers to use the non-wrapped
functions, which in turn requires adding GRAPH_RDLOCK annotations.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20230601115145.196465-3-pbonzini@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qed-check.c | 5 +++--
 block/qed.c       | 7 ++++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/qed-check.c b/block/qed-check.c
index 8fd94f405e..6a01b94f9c 100644
--- a/block/qed-check.c
+++ b/block/qed-check.c
@@ -200,7 +200,8 @@ static void qed_check_for_leaks(QEDCheck *check)
 /**
  * Mark an image clean once it passes check or has been repaired
  */
-static void qed_check_mark_clean(BDRVQEDState *s, BdrvCheckResult *result)
+static void coroutine_fn GRAPH_RDLOCK
+qed_check_mark_clean(BDRVQEDState *s, BdrvCheckResult *result)
 {
     /* Skip if there were unfixable corruptions or I/O errors */
     if (result->corruptions > 0 || result->check_errors > 0) {
@@ -213,7 +214,7 @@ static void qed_check_mark_clean(BDRVQEDState *s, BdrvCheckResult *result)
     }
 
     /* Ensure fixes reach storage before clearing check bit */
-    bdrv_flush(s->bs);
+    bdrv_co_flush(s->bs);
 
     s->header.features &= ~QED_F_NEED_CHECK;
     qed_write_header_sync(s);
diff --git a/block/qed.c b/block/qed.c
index 9a0350b534..2cab3540a9 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -195,14 +195,15 @@ static bool qed_is_image_size_valid(uint64_t image_size, uint32_t cluster_size,
  *
  * The string is NUL-terminated.
  */
-static int qed_read_string(BdrvChild *file, uint64_t offset, size_t n,
-                           char *buf, size_t buflen)
+static int coroutine_fn GRAPH_RDLOCK
+qed_read_string(BdrvChild *file, uint64_t offset,
+                size_t n, char *buf, size_t buflen)
 {
     int ret;
     if (n >= buflen) {
         return -EINVAL;
     }
-    ret = bdrv_pread(file, offset, n, buf, 0);
+    ret = bdrv_co_pread(file, offset, n, buf, 0);
     if (ret < 0) {
         return ret;
     }
-- 
2.41.0


