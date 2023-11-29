Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D1C7FE0A3
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 20:58:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8Qfn-0007QU-5T; Wed, 29 Nov 2023 14:56:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r8Qfl-0007Py-Bi
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 14:56:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r8Qfj-0004Oy-NH
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 14:56:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701287795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=83h9xdcT8cxTipojEBiD6nbiYOvpd9inCN42JPs/T+c=;
 b=IRxc47RZFY/7v/aYceTPgu7YKBmPeQ1KQKsePM9Uegy3qgPNT95O21I4Uk3CGJ91hA/bn0
 9WoyYyQh7Vaahcc5yqAiszLEvmxLAmC83WArjpIadKE+G7IGPdp+OtIRd1029n8qCrwwwG
 sYPl4iPCtC3NXYD4gJ7xIHqZJjTjQeM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-wzqmuO4bOQ6Hmrn3niRbLQ-1; Wed, 29 Nov 2023 14:56:32 -0500
X-MC-Unique: wzqmuO4bOQ6Hmrn3niRbLQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5AFAE805143;
 Wed, 29 Nov 2023 19:56:30 +0000 (UTC)
Received: from localhost (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B3A01121308;
 Wed, 29 Nov 2023 19:56:29 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alberto Garcia <berto@igalia.com>,
 Emanuele Giuseppe Esposito <eesposit@redhat.com>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 <qemu-block@nongnu.org>, xen-devel@lists.xenproject.org,
 Coiby Xu <Coiby.Xu@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Xie Changlong <xiechanglong.d@gmail.com>, Ari Sundholm <ari@tuxera.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Cleber Rosa <crosa@redhat.com>,
 Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Zhang Chen <chen.zhang@intel.com>, Peter Xu <peterx@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Leonardo Bras <leobras@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Fam Zheng <fam@euphon.net>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 11/12] job: remove outdated AioContext locking comments
Date: Wed, 29 Nov 2023 14:55:52 -0500
Message-ID: <20231129195553.942921-12-stefanha@redhat.com>
In-Reply-To: <20231129195553.942921-1-stefanha@redhat.com>
References: <20231129195553.942921-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The AioContext lock no longer exists.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
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
2.42.0


