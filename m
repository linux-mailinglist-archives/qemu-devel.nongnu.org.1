Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5519B7FA774
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 18:04:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7f0H-000341-Rn; Mon, 27 Nov 2023 12:02:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r7f05-0002sv-B6
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 12:02:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r7f01-0003Tk-K4
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 12:02:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701104537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=he3Z/ilRUOu18I2Tb4luTuvdI1AreeJO6qRYtRye6U0=;
 b=FTGKMEZ//O+mMYDUhxRXyaNSM0b3TZ8RedOVVU639ALpYqzYAwJjdmesH1G+cplPMGZDr5
 aLZgPi4zOPz10Tcbrijub2+b3MZhk2ydm3QAgpCmtabRTZVbB27j/nYcwSVf9T8yeFCoV8
 kwWC4y9wEdvCm+2z6+xH3GVZzocVWEA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-351-mqPKmX6sM7WpcXvSPt9mOA-1; Mon,
 27 Nov 2023 12:02:12 -0500
X-MC-Unique: mqPKmX6sM7WpcXvSPt9mOA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D4C3F3C100A1;
 Mon, 27 Nov 2023 17:02:11 +0000 (UTC)
Received: from localhost (unknown [10.39.195.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5BAA85028;
 Mon, 27 Nov 2023 17:02:11 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Emanuele Giuseppe Esposito <eesposit@redhat.com>, <qemu-block@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH] tests/unit/test-blockjob: delete complete_in_standby test
Date: Mon, 27 Nov 2023 12:02:09 -0500
Message-ID: <20231127170210.422728-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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

Commit b6903cbe3a2e ("tests/unit/test-blockjob: Disable
complete_in_standby test") disabled complete_in_standby unless the
QEMU_TEST_FLAKY_TESTS environment variable is set because it suffers
from a race with the IOThread.

This patch removes the test case completely. While the test case made
sense in the past when the AioContext lock prevented block jobs from
running, that hasn't been the case at least since the introduction of
the finer-grained job lock.

I am not aware of a replacement mechanism that would make this test
deterministic. I'm currently working on removing
aio_context_acquire()/aio_context_release() so this test case will make
even less sense when they are gone. Let's delete the test case
completely.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/unit/test-blockjob.c | 133 -------------------------------------
 1 file changed, 133 deletions(-)

diff --git a/tests/unit/test-blockjob.c b/tests/unit/test-blockjob.c
index a130f6fefb..230ff50eec 100644
--- a/tests/unit/test-blockjob.c
+++ b/tests/unit/test-blockjob.c
@@ -391,132 +391,6 @@ static void test_cancel_concluded(void)
     cancel_common(s);
 }
 
-/* (See test_yielding_driver for the job description) */
-typedef struct YieldingJob {
-    BlockJob common;
-    bool should_complete;
-} YieldingJob;
-
-static void yielding_job_complete(Job *job, Error **errp)
-{
-    YieldingJob *s = container_of(job, YieldingJob, common.job);
-    s->should_complete = true;
-    job_enter(job);
-}
-
-static int coroutine_fn yielding_job_run(Job *job, Error **errp)
-{
-    YieldingJob *s = container_of(job, YieldingJob, common.job);
-
-    job_transition_to_ready(job);
-
-    while (!s->should_complete) {
-        job_yield(job);
-    }
-
-    return 0;
-}
-
-/*
- * This job transitions immediately to the READY state, and then
- * yields until it is to complete.
- */
-static const BlockJobDriver test_yielding_driver = {
-    .job_driver = {
-        .instance_size  = sizeof(YieldingJob),
-        .free           = block_job_free,
-        .user_resume    = block_job_user_resume,
-        .run            = yielding_job_run,
-        .complete       = yielding_job_complete,
-    },
-};
-
-/*
- * Test that job_complete_locked() works even on jobs that are in a paused
- * state (i.e., STANDBY).
- *
- * To do this, run YieldingJob in an IO thread, get it into the READY
- * state, then have a drained section.  Before ending the section,
- * acquire the context so the job will not be entered and will thus
- * remain on STANDBY.
- *
- * job_complete_locked() should still work without error.
- *
- * Note that on the QMP interface, it is impossible to lock an IO
- * thread before a drained section ends.  In practice, the
- * bdrv_drain_all_end() and the aio_context_acquire() will be
- * reversed.  However, that makes for worse reproducibility here:
- * Sometimes, the job would no longer be in STANDBY then but already
- * be started.  We cannot prevent that, because the IO thread runs
- * concurrently.  We can only prevent it by taking the lock before
- * ending the drained section, so we do that.
- *
- * (You can reverse the order of operations and most of the time the
- * test will pass, but sometimes the assert(status == STANDBY) will
- * fail.)
- */
-static void test_complete_in_standby(void)
-{
-    BlockBackend *blk;
-    IOThread *iothread;
-    AioContext *ctx;
-    Job *job;
-    BlockJob *bjob;
-
-    /* Create a test drive, move it to an IO thread */
-    blk = create_blk(NULL);
-    iothread = iothread_new();
-
-    ctx = iothread_get_aio_context(iothread);
-    blk_set_aio_context(blk, ctx, &error_abort);
-
-    /* Create our test job */
-    bjob = mk_job(blk, "job", &test_yielding_driver, true,
-                  JOB_MANUAL_FINALIZE | JOB_MANUAL_DISMISS);
-    job = &bjob->job;
-    assert_job_status_is(job, JOB_STATUS_CREATED);
-
-    /* Wait for the job to become READY */
-    job_start(job);
-    /*
-     * Here we are waiting for the status to change, so don't bother
-     * protecting the read every time.
-     */
-    AIO_WAIT_WHILE_UNLOCKED(ctx, job->status != JOB_STATUS_READY);
-
-    /* Begin the drained section, pausing the job */
-    bdrv_drain_all_begin();
-    assert_job_status_is(job, JOB_STATUS_STANDBY);
-
-    /* Lock the IO thread to prevent the job from being run */
-    aio_context_acquire(ctx);
-    /* This will schedule the job to resume it */
-    bdrv_drain_all_end();
-    aio_context_release(ctx);
-
-    WITH_JOB_LOCK_GUARD() {
-        /* But the job cannot run, so it will remain on standby */
-        assert(job->status == JOB_STATUS_STANDBY);
-
-        /* Even though the job is on standby, this should work */
-        job_complete_locked(job, &error_abort);
-
-        /* The test is done now, clean up. */
-        job_finish_sync_locked(job, NULL, &error_abort);
-        assert(job->status == JOB_STATUS_PENDING);
-
-        job_finalize_locked(job, &error_abort);
-        assert(job->status == JOB_STATUS_CONCLUDED);
-
-        job_dismiss_locked(&job, &error_abort);
-    }
-
-    aio_context_acquire(ctx);
-    destroy_blk(blk);
-    aio_context_release(ctx);
-    iothread_join(iothread);
-}
-
 int main(int argc, char **argv)
 {
     qemu_init_main_loop(&error_abort);
@@ -532,12 +406,5 @@ int main(int argc, char **argv)
     g_test_add_func("/blockjob/cancel/pending", test_cancel_pending);
     g_test_add_func("/blockjob/cancel/concluded", test_cancel_concluded);
 
-    /*
-     * This test is flaky and sometimes fails in CI and otherwise:
-     * don't run unless user opts in via environment variable.
-     */
-    if (getenv("QEMU_TEST_FLAKY_TESTS")) {
-        g_test_add_func("/blockjob/complete_in_standby", test_complete_in_standby);
-    }
     return g_test_run();
 }
-- 
2.42.0


