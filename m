Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DFB79C126
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 02:33:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfrK3-000738-06; Mon, 11 Sep 2023 20:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qfrK1-00072y-7Z
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 20:32:05 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qfrJy-0003tB-Cj
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 20:32:04 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 20D691F8C3;
 Tue, 12 Sep 2023 00:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694478718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jlbm1bJsUQJwXfCbLo5zGlKNOQB0RbHkbzF8jCf6hU8=;
 b=wxUhEi4aCF0xiP6s7F7lBEJhEUjEwSJt22jYa6EawQ+++JCdwPjoD/AbK0TBw82RxY1+kI
 npuGX4R6nWZPB24j5cYTXC9ktAyLJJ4vYJy9q2PklSRmgNNkvbjaT0+dn64BdgrGfFKO+H
 nXfFqDIpFXmeFykGL4yvEJEBHKG8rGY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694478718;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jlbm1bJsUQJwXfCbLo5zGlKNOQB0RbHkbzF8jCf6hU8=;
 b=uf92GXNYC7rW7oCtL+61JxGdNj7b9aOCnmjy3XvGerMSd+twcrDhDV/o7B9tVBzSu+EoQT
 68122I6MZ46ooaCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 67CA313780;
 Tue, 12 Sep 2023 00:31:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id UT19BH2x/2TBVQAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 12 Sep 2023 00:31:57 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juan Quintela <quintela@redhat.com>, Xiaohui Li
 <xiaohli@redhat.com>
Subject: Re: [PATCH 9/9] migration/postcopy: Allow network to fail even
 during recovery
In-Reply-To: <20230829214235.69309-10-peterx@redhat.com>
References: <20230829214235.69309-1-peterx@redhat.com>
 <20230829214235.69309-10-peterx@redhat.com>
Date: Mon, 11 Sep 2023 21:31:51 -0300
Message-ID: <877cowmdu0.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Peter Xu <peterx@redhat.com> writes:

Hi, sorry it took me so long to get to this.

> Normally the postcopy recover phase should only exist for a super short
> period, that's the duration when QEMU is trying to recover from an
> interrupted postcopy migration, during which handshake will be carried out
> for continuing the procedure with state changes from PAUSED -> RECOVER ->
> POSTCOPY_ACTIVE again.
>
> Here RECOVER phase should be super small, that happens right after the
> admin specified a new but working network link for QEMU to reconnect to
> dest QEMU.
>
> However there can still be case where the channel is broken in this small
> RECOVER window.
>
> If it happens, with current code there's no way the src QEMU can got kicked
> out of RECOVER stage. No way either to retry the recover in another channel
> when established.
>
> This patch allows the RECOVER phase to fail itself too - we're mostly
> ready, just some small things missing, e.g. properly kick the main
> migration thread out when sleeping on rp_sem when we found that we're at
> RECOVER stage.  When this happens, it fails the RECOVER itself, and
> rollback to PAUSED stage.  Then the user can retry another round of
> recovery.
>
> To make it even stronger, teach QMP command migrate-pause to explicitly
> kick src/dst QEMU out when needed, so even if for some reason the migration
> thread didn't got kicked out already by a failing rethrn-path thread, the
> admin can also kick it out.
>
> This will be an super, super corner case, but still try to cover that.

It would be nice to have a test for this. Being such a corner case, it
will be hard to keep this scenario working.

I wrote two tests[1] that do the recovery each using a different URI:
1) fd: using a freshly opened file,
2) fd: using a socketpair that simply has nothing on the other end.

These might be too far from the original bug, but it seems to exercise
some of the same paths:

Scenario 1:
/x86_64/migration/postcopy/recovery/fail-twice

the stacks are:

Thread 8 (Thread 0x7fffd5ffe700 (LWP 30282) "live_migration"):
 qemu_sem_wait
 ram_dirty_bitmap_sync_all
 ram_resume_prepare
 qemu_savevm_state_resume_prepare
 postcopy_do_resume
 postcopy_pause
 migration_detect_error
 migration_thread

Thread 7 (Thread 0x7fffd67ff700 (LWP 30281) "return path"):
 qemu_sem_wait
 postcopy_pause_return_path_thread
 source_return_path_thread

This patch seems to fix it, although we cannot call qmp_migrate_recover
a second time because the mis state is now in RECOVER:

  "Migrate recover can only be run when postcopy is paused."

Do we maybe need to return the state to PAUSED, or allow
qmp_migrate_recover to run in RECOVER, like you did on the src side?


Scenario 2:
/x86_64/migration/postcopy/recovery/fail-twice/rp

Thread 8 (Thread 0x7fffd5ffe700 (LWP 30456) "live_migration"):
 qemu_sem_wait
 ram_dirty_bitmap_sync_all
 ram_resume_prepare
 qemu_savevm_state_resume_prepare
 postcopy_do_resume
 postcopy_pause
 migration_detect_error
 migration_thread

Thread 7 (Thread 0x7fffd67ff700 (LWP 30455) "return path"):
 recvmsg
 qio_channel_socket_readv
 qio_channel_readv_full
 qio_channel_read
 qemu_fill_buffer
 qemu_peek_byte
 qemu_get_byte
 qemu_get_be16
 source_return_path_thread

Here, with this patch the migration gets stuck unless we call
migrate_pause() one more time. After another round of migrate_pause +
recover, it finishes properly.


1- hacked-together test:
-->8--
From a34685c8795799350665a880cd2ddddbf53c5812 Mon Sep 17 00:00:00 2001
From: Fabiano Rosas <farosas@suse.de>
Date: Mon, 11 Sep 2023 20:45:33 -0300
Subject: [PATCH] test patch

---
 tests/qtest/migration-test.c | 87 ++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 1b43df5ca7..4d9d2209c1 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -695,6 +695,7 @@ typedef struct {
     /* Postcopy specific fields */
     void *postcopy_data;
     bool postcopy_preempt;
+    int postcopy_recovery_method;
 } MigrateCommon;
 
 static int test_migrate_start(QTestState **from, QTestState **to,
@@ -1357,6 +1358,61 @@ static void test_postcopy_preempt_tls_psk(void)
 }
 #endif
 
+static void postcopy_recover_fail(QTestState *from, QTestState *to, int method)
+{
+    int src, dst;
+
+    if (method == 1) {
+        /* give it some random fd to recover */
+        g_autofree char *uri = g_strdup_printf("%s/noop", tmpfs);
+        src = dst = open(uri, O_CREAT|O_RDWR);
+    } else if (method == 2) {
+        int ret, pair1[2], pair2[2];
+
+        /* create two unrelated socketpairs */
+        ret = qemu_socketpair(PF_LOCAL, SOCK_STREAM, 0, pair1);
+        g_assert_cmpint(ret, ==, 0);
+
+        ret = qemu_socketpair(PF_LOCAL, SOCK_STREAM, 0, pair2);
+        g_assert_cmpint(ret, ==, 0);
+
+        /* give the guests unpaired ends of the sockets */
+        src = pair1[0];
+        dst = pair2[0];
+    }
+
+    qtest_qmp_fds_assert_success(to, &src, 1,
+                                 "{ 'execute': 'getfd',"
+                                 "  'arguments': { 'fdname': 'fd-mig' }}");
+
+    qtest_qmp_fds_assert_success(from, &dst, 1,
+                                 "{ 'execute': 'getfd',"
+                                 "  'arguments': { 'fdname': 'fd-mig' }}");
+
+    migrate_recover(to, "fd:fd-mig");
+
+    wait_for_migration_status(from, "postcopy-paused",
+                              (const char * []) { "failed", "active",
+                                  "completed", NULL });
+    migrate_qmp(from, "fd:fd-mig", "{'resume': true}");
+
+    printf("WAIT\n");
+    if (method == 2) {
+        /* This would be issued by the admin upon noticing the hang */
+        migrate_pause(from);
+    }
+
+    wait_for_migration_status(from, "postcopy-paused",
+                              (const char * []) { "failed", "active",
+                                  "completed", NULL });
+    printf("PAUSED\n");
+
+    close(src);
+    if (method == 2) {
+        close(dst);
+    }
+}
+
 static void test_postcopy_recovery_common(MigrateCommon *args)
 {
     QTestState *from, *to;
@@ -1396,6 +1452,13 @@ static void test_postcopy_recovery_common(MigrateCommon *args)
                               (const char * []) { "failed", "active",
                                                   "completed", NULL });
 
+    if (args->postcopy_recovery_method) {
+        /* fail the recovery */
+        postcopy_recover_fail(from, to, args->postcopy_recovery_method);
+
+        /* continue with a good recovery */
+    }
+
     /*
      * Create a new socket to emulate a new channel that is different
      * from the broken migration channel; tell the destination to
@@ -1435,6 +1498,24 @@ static void test_postcopy_recovery_compress(void)
     test_postcopy_recovery_common(&args);
 }
 
+static void test_postcopy_recovery_fail(void)
+{
+    MigrateCommon args = {
+        .postcopy_recovery_method = 1,
+    };
+
+    test_postcopy_recovery_common(&args);
+}
+
+static void test_postcopy_recovery_fail_rp(void)
+{
+    MigrateCommon args = {
+        .postcopy_recovery_method = 2,
+    };
+
+    test_postcopy_recovery_common(&args);
+}
+
 #ifdef CONFIG_GNUTLS
 static void test_postcopy_recovery_tls_psk(void)
 {
@@ -2825,6 +2906,12 @@ int main(int argc, char **argv)
             qtest_add_func("/migration/postcopy/recovery/compress/plain",
                            test_postcopy_recovery_compress);
         }
+        qtest_add_func("/migration/postcopy/recovery/fail-twice",
+                       test_postcopy_recovery_fail);
+
+        qtest_add_func("/migration/postcopy/recovery/fail-twice/rp",
+                       test_postcopy_recovery_fail_rp);
+
     }
 
     qtest_add_func("/migration/bad_dest", test_baddest);
-- 
2.35.3


