Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5418706EC3
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 18:53:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzKNN-00044n-KW; Wed, 17 May 2023 12:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1pzKNI-00040W-FQ
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:51:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1pzKNG-0001S3-Js
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:51:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684342296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rr1TucJqp+IIm096jK8/R7QHSZpWnM6VF3aeyatA+MI=;
 b=g+FgdexKY6ubV2htbVm/mHb2GBP/HqobvEqd+yNLd0dCN9nYuYD1KfKjWCpKaojlx6J40d
 3UCHfcjOL2x4KLtfcu65gTINBsvAAoEpBl5o+UWJ+knFaHkCY0gAjWybxffeiRf+ZwAvLN
 iIUViF02bQByO5wpBzVsQiZ7Q/ikdHg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-232-MuELR3u2Pcmthli_9v3r9w-1; Wed, 17 May 2023 12:51:33 -0400
X-MC-Unique: MuELR3u2Pcmthli_9v3r9w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2593D29AB3F0;
 Wed, 17 May 2023 16:51:33 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6D4B340C6EC4;
 Wed, 17 May 2023 16:51:32 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 10/18] qcow2: Unlock the graph in qcow2_do_open() where
 necessary
Date: Wed, 17 May 2023 18:51:08 +0200
Message-Id: <20230517165116.475123-11-kwolf@redhat.com>
In-Reply-To: <20230517165116.475123-1-kwolf@redhat.com>
References: <20230517165116.475123-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

qcow2_do_open() calls a few no_co_wrappers that wrap functions taking
the graph lock internally as a writer. Therefore, it can't hold the
reader lock across these calls, it causes deadlocks. Drop the lock
temporarily around the calls.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20230510203601.418015-4-kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index 73f36447f9..b00b4e7575 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1619,9 +1619,11 @@ qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
 
     if (open_data_file) {
         /* Open external data file */
+        bdrv_graph_co_rdunlock();
         s->data_file = bdrv_co_open_child(NULL, options, "data-file", bs,
                                           &child_of_bds, BDRV_CHILD_DATA,
                                           true, errp);
+        bdrv_graph_co_rdlock();
         if (*errp) {
             ret = -EINVAL;
             goto fail;
@@ -1629,10 +1631,12 @@ qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
 
         if (s->incompatible_features & QCOW2_INCOMPAT_DATA_FILE) {
             if (!s->data_file && s->image_data_file) {
+                bdrv_graph_co_rdunlock();
                 s->data_file = bdrv_co_open_child(s->image_data_file, options,
                                                   "data-file", bs,
                                                   &child_of_bds,
                                                   BDRV_CHILD_DATA, false, errp);
+                bdrv_graph_co_rdlock();
                 if (!s->data_file) {
                     ret = -EINVAL;
                     goto fail;
@@ -1857,7 +1861,9 @@ qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
  fail:
     g_free(s->image_data_file);
     if (open_data_file && has_data_file(bs)) {
+        bdrv_graph_co_rdunlock();
         bdrv_unref_child(bs, s->data_file);
+        bdrv_graph_co_rdlock();
         s->data_file = NULL;
     }
     g_free(s->unknown_header_fields);
-- 
2.40.1


