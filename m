Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1D281C011
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 22:26:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGQXV-0001gb-Mh; Thu, 21 Dec 2023 16:25:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rGQXJ-0001Nu-B6
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 16:24:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rGQXH-0008Fb-Px
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 16:24:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703193895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ItrW+68VN/dZ4oq02R4iFcVnPR+krV8iH4Zjoyatvx0=;
 b=O42V7zVvH6FGHhvVXPoNyLnHCo8cif5GZFC1xkSxD7ywk9AWJn7bX9brjRwOnBsOtOIDR2
 eXzct/UDiFKWGg4TfyyZDnGB/9AJFwgZOfsB1BtLuVjM3T02LyX7KcYR22C/vjB/cHCdXZ
 gh7PSZOl2fou794dd5eHNoHNiiv4UtI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-nZPs3R4WMbWaBIre9PQmjQ-1; Thu,
 21 Dec 2023 16:24:51 -0500
X-MC-Unique: nZPs3R4WMbWaBIre9PQmjQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7ACF83806066;
 Thu, 21 Dec 2023 21:24:51 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 05F02C15968;
 Thu, 21 Dec 2023 21:24:49 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 27/33] job: remove outdated AioContext locking comments
Date: Thu, 21 Dec 2023 22:23:32 +0100
Message-ID: <20231221212339.164439-28-kwolf@redhat.com>
In-Reply-To: <20231221212339.164439-1-kwolf@redhat.com>
References: <20231221212339.164439-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

The AioContext lock no longer exists.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-ID: <20231205182011.1976568-14-stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/qemu/job.h | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/include/qemu/job.h b/include/qemu/job.h
index e502787dd8..9ea98b5927 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -67,8 +67,6 @@ typedef struct Job {
 
     /**
      * The completion function that will be called when the job completes.
-     * Called with AioContext lock held, since many callback implementations
-     * use bdrv_* functions that require to hold the lock.
      */
     BlockCompletionFunc *cb;
 
@@ -264,9 +262,6 @@ struct JobDriver {
      *
      * This callback will not be invoked if the job has already failed.
      * If it fails, abort and then clean will be called.
-     *
-     * Called with AioContext lock held, since many callbacs implementations
-     * use bdrv_* functions that require to hold the lock.
      */
     int (*prepare)(Job *job);
 
@@ -277,9 +272,6 @@ struct JobDriver {
      *
      * All jobs will complete with a call to either .commit() or .abort() but
      * never both.
-     *
-     * Called with AioContext lock held, since many callback implementations
-     * use bdrv_* functions that require to hold the lock.
      */
     void (*commit)(Job *job);
 
@@ -290,9 +282,6 @@ struct JobDriver {
      *
      * All jobs will complete with a call to either .commit() or .abort() but
      * never both.
-     *
-     * Called with AioContext lock held, since many callback implementations
-     * use bdrv_* functions that require to hold the lock.
      */
     void (*abort)(Job *job);
 
@@ -301,9 +290,6 @@ struct JobDriver {
      * .commit() or .abort(). Regardless of which callback is invoked after
      * completion, .clean() will always be called, even if the job does not
      * belong to a transaction group.
-     *
-     * Called with AioContext lock held, since many callbacs implementations
-     * use bdrv_* functions that require to hold the lock.
      */
     void (*clean)(Job *job);
 
@@ -318,17 +304,12 @@ struct JobDriver {
      * READY).
      * (If the callback is NULL, the job is assumed to terminate
      * without I/O.)
-     *
-     * Called with AioContext lock held, since many callback implementations
-     * use bdrv_* functions that require to hold the lock.
      */
     bool (*cancel)(Job *job, bool force);
 
 
     /**
      * Called when the job is freed.
-     * Called with AioContext lock held, since many callback implementations
-     * use bdrv_* functions that require to hold the lock.
      */
     void (*free)(Job *job);
 };
@@ -424,7 +405,6 @@ void job_ref_locked(Job *job);
  * Release a reference that was previously acquired with job_ref_locked() or
  * job_create(). If it's the last reference to the object, it will be freed.
  *
- * Takes AioContext lock internally to invoke a job->driver callback.
  * Called with job lock held.
  */
 void job_unref_locked(Job *job);
-- 
2.43.0


