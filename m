Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1F579D9E3
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 22:06:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg9dk-0005Yc-H1; Tue, 12 Sep 2023 16:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qg9dh-0005YB-KL
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 16:05:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qg9de-0001AV-PV
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 16:05:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694549134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nkqprTKS9Sdw+1xe+T0689l+Gti0AoreI2AWTdYRYpU=;
 b=WI4W9GmYkMxVyR99cgo4e7nGun+6a/yMhQkq1L2B+rVgS4iiMDZ372h96ESDEKRsiCZ2ej
 /05LkWEwus2qeyEZUyGquPJhLUBPBUEXGK4yxL7KapSKUgAKfBXqKmo68B4nHh80DfpvCd
 tQaKErcNs7MKyErLvNtWV+0cXRklduw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244--rRH9j6uPDGGbOTp-zL6RQ-1; Tue, 12 Sep 2023 16:05:30 -0400
X-MC-Unique: -rRH9j6uPDGGbOTp-zL6RQ-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-413650a9d6dso16230601cf.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 13:05:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694549130; x=1695153930;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nkqprTKS9Sdw+1xe+T0689l+Gti0AoreI2AWTdYRYpU=;
 b=LIsolMbjB6q91jcETx62gJ8o/D0FWTJ6mLiFiF2+DTRCUuT3+TKWvmM0BNsupT/qr0
 Ny8u4cd6tkq3JJL2e41Knq5isaguN4iEQ483bIPU5zl7YrYNyTRDSJ+gEWGyA5LyQHLK
 pfl2KwO5ZHl/ZX/me4V1GG9a8oSYD5ZnMJskXEC6Op2+R3ZhLXM6fK0fhwGAnT4dJyXK
 VTEgfW8hhz8XvyMYm1EMa8NS430Uf6TUgLpdlnWg/wdb+rxplpbo8NMj7/0g1NL1gEp4
 FxCm4CZ3bzRohZR2Ab1lm1khOxIWfEVYwnJVktim3OvccRg8nr7vxJYhD7fO66O4XYZm
 hNKg==
X-Gm-Message-State: AOJu0YxAJCxYrL2YaILJuVYRTrx+dYIKCMd8S3K+7BA06ICGD4TB0PGn
 fsdSXLvq7OPcnG4it0XUb5Q9LOKyIl21ta7rbxV/V+qdi44UuzKkVy3mUkjAOqzk6Zo2sUc3W8F
 hSPZ+2dvEUUvzWTM=
X-Received: by 2002:a05:6214:76e:b0:653:576d:1ec with SMTP id
 f14-20020a056214076e00b00653576d01ecmr462683qvz.3.1694549130211; 
 Tue, 12 Sep 2023 13:05:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5Y8uelUs0zO6dJHMh+I0msjqVj+DSSgC2vXjkscIbiRzW6OjyfPQplCac2aAfZo8LiE52nQ==
X-Received: by 2002:a05:6214:76e:b0:653:576d:1ec with SMTP id
 f14-20020a056214076e00b00653576d01ecmr462671qvz.3.1694549129808; 
 Tue, 12 Sep 2023 13:05:29 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 f10-20020a0ccc8a000000b0064f4258184csm3900897qvl.53.2023.09.12.13.05.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 13:05:29 -0700 (PDT)
Date: Tue, 12 Sep 2023 16:05:27 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Xiaohui Li <xiaohli@redhat.com>
Subject: Re: [PATCH 9/9] migration/postcopy: Allow network to fail even
 during recovery
Message-ID: <ZQDEh85X2IcC+o8M@x1n>
References: <20230829214235.69309-1-peterx@redhat.com>
 <20230829214235.69309-10-peterx@redhat.com>
 <877cowmdu0.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877cowmdu0.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Mon, Sep 11, 2023 at 09:31:51PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> Hi, sorry it took me so long to get to this.

Not a problem.

> 
> > Normally the postcopy recover phase should only exist for a super short
> > period, that's the duration when QEMU is trying to recover from an
> > interrupted postcopy migration, during which handshake will be carried out
> > for continuing the procedure with state changes from PAUSED -> RECOVER ->
> > POSTCOPY_ACTIVE again.
> >
> > Here RECOVER phase should be super small, that happens right after the
> > admin specified a new but working network link for QEMU to reconnect to
> > dest QEMU.
> >
> > However there can still be case where the channel is broken in this small
> > RECOVER window.
> >
> > If it happens, with current code there's no way the src QEMU can got kicked
> > out of RECOVER stage. No way either to retry the recover in another channel
> > when established.
> >
> > This patch allows the RECOVER phase to fail itself too - we're mostly
> > ready, just some small things missing, e.g. properly kick the main
> > migration thread out when sleeping on rp_sem when we found that we're at
> > RECOVER stage.  When this happens, it fails the RECOVER itself, and
> > rollback to PAUSED stage.  Then the user can retry another round of
> > recovery.
> >
> > To make it even stronger, teach QMP command migrate-pause to explicitly
> > kick src/dst QEMU out when needed, so even if for some reason the migration
> > thread didn't got kicked out already by a failing rethrn-path thread, the
> > admin can also kick it out.
> >
> > This will be an super, super corner case, but still try to cover that.
> 
> It would be nice to have a test for this. Being such a corner case, it
> will be hard to keep this scenario working.

Yes makes sense.

> 
> I wrote two tests[1] that do the recovery each using a different URI:
> 1) fd: using a freshly opened file,
> 2) fd: using a socketpair that simply has nothing on the other end.
> 
> These might be too far from the original bug, but it seems to exercise
> some of the same paths:
> 
> Scenario 1:
> /x86_64/migration/postcopy/recovery/fail-twice
> 
> the stacks are:
> 
> Thread 8 (Thread 0x7fffd5ffe700 (LWP 30282) "live_migration"):
>  qemu_sem_wait
>  ram_dirty_bitmap_sync_all
>  ram_resume_prepare
>  qemu_savevm_state_resume_prepare
>  postcopy_do_resume
>  postcopy_pause
>  migration_detect_error
>  migration_thread
> 
> Thread 7 (Thread 0x7fffd67ff700 (LWP 30281) "return path"):
>  qemu_sem_wait
>  postcopy_pause_return_path_thread
>  source_return_path_thread

I guess this is because below path triggers:

    if (len > 0) {
        f->buf_size += len;
        f->total_transferred += len;
    } else if (len == 0) {
        qemu_file_set_error_obj(f, -EIO, local_error);     <-----------
    } else {
        qemu_file_set_error_obj(f, len, local_error);
    }

So the src can always write anything into the tmp file, but any read will
return 0 immediately because file offset is always pointing to the file
size.

> 
> This patch seems to fix it, although we cannot call qmp_migrate_recover
> a second time because the mis state is now in RECOVER:
> 
>   "Migrate recover can only be run when postcopy is paused."
> 
> Do we maybe need to return the state to PAUSED, or allow
> qmp_migrate_recover to run in RECOVER, like you did on the src side?

Ouch, I just noticed that my patch was wrong.

I probably need this:

===8<===
From 8c2fb7b4c7488002283c7fb6a5e2aae81b21e04b Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Tue, 12 Sep 2023 15:49:54 -0400
Subject: [PATCH] fixup! migration/postcopy: Allow network to fail even during
 recovery

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h | 2 +-
 migration/migration.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index e7f48e736e..7e61e2ece7 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -482,7 +482,7 @@ int migrate_init(MigrationState *s, Error **errp);
 bool migration_is_blocked(Error **errp);
 /* True if outgoing migration has entered postcopy phase */
 bool migration_in_postcopy(void);
-bool migration_postcopy_is_alive(void);
+bool migration_postcopy_is_alive(int state);
 MigrationState *migrate_get_current(void);
 
 uint64_t ram_get_total_transferred_pages(void);
diff --git a/migration/migration.c b/migration/migration.c
index de2146c6fc..a9d381886c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1349,7 +1349,7 @@ bool migration_in_postcopy(void)
     }
 }
 
-bool migration_postcopy_is_alive(void)
+bool migration_postcopy_is_alive(int state)
 {
     MigrationState *s = migrate_get_current();
 
@@ -1569,7 +1569,7 @@ void qmp_migrate_pause(Error **errp)
     MigrationIncomingState *mis = migration_incoming_get_current();
     int ret;
 
-    if (migration_postcopy_is_alive()) {
+    if (migration_postcopy_is_alive(ms->state)) {
         /* Source side, during postcopy */
         Error *error = NULL;
 
@@ -1593,7 +1593,7 @@ void qmp_migrate_pause(Error **errp)
         return;
     }
 
-    if (migration_postcopy_is_alive()) {
+    if (migration_postcopy_is_alive(mis->state)) {
         ret = qemu_file_shutdown(mis->from_src_file);
         if (ret) {
             error_setg(errp, "Failed to pause destination migration");
-- 
2.41.0
===8<===

> 
> 
> Scenario 2:
> /x86_64/migration/postcopy/recovery/fail-twice/rp
> 
> Thread 8 (Thread 0x7fffd5ffe700 (LWP 30456) "live_migration"):
>  qemu_sem_wait
>  ram_dirty_bitmap_sync_all
>  ram_resume_prepare
>  qemu_savevm_state_resume_prepare
>  postcopy_do_resume
>  postcopy_pause
>  migration_detect_error
>  migration_thread
> 
> Thread 7 (Thread 0x7fffd67ff700 (LWP 30455) "return path"):
>  recvmsg
>  qio_channel_socket_readv
>  qio_channel_readv_full
>  qio_channel_read
>  qemu_fill_buffer
>  qemu_peek_byte
>  qemu_get_byte
>  qemu_get_be16
>  source_return_path_thread
> 
> Here, with this patch the migration gets stuck unless we call
> migrate_pause() one more time. After another round of migrate_pause +
> recover, it finishes properly.
> 
> 
> 1- hacked-together test:
> -->8--
> From a34685c8795799350665a880cd2ddddbf53c5812 Mon Sep 17 00:00:00 2001
> From: Fabiano Rosas <farosas@suse.de>
> Date: Mon, 11 Sep 2023 20:45:33 -0300
> Subject: [PATCH] test patch
> 
> ---
>  tests/qtest/migration-test.c | 87 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 87 insertions(+)
> 
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 1b43df5ca7..4d9d2209c1 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -695,6 +695,7 @@ typedef struct {
>      /* Postcopy specific fields */
>      void *postcopy_data;
>      bool postcopy_preempt;
> +    int postcopy_recovery_method;
>  } MigrateCommon;
>  
>  static int test_migrate_start(QTestState **from, QTestState **to,
> @@ -1357,6 +1358,61 @@ static void test_postcopy_preempt_tls_psk(void)
>  }
>  #endif
>  
> +static void postcopy_recover_fail(QTestState *from, QTestState *to, int method)
> +{
> +    int src, dst;
> +
> +    if (method == 1) {
> +        /* give it some random fd to recover */
> +        g_autofree char *uri = g_strdup_printf("%s/noop", tmpfs);
> +        src = dst = open(uri, O_CREAT|O_RDWR);

This is slightly weird.

We opened a file, making it RW and pass it over to both QEMUs.

I think the result can be unpredictable for the reader, that if the reader
reads before any prior writes it'll just quickly fail, or I think it can
also happen that the read is slower than the write so it can read
something..  until it reads to the EOF and fail that fd at some point.

Not sure whether it'll cause some behavior difference and uncertainty on
the test case.

Maybe we drop this method but only keep the below one?

> +    } else if (method == 2) {
> +        int ret, pair1[2], pair2[2];
> +
> +        /* create two unrelated socketpairs */
> +        ret = qemu_socketpair(PF_LOCAL, SOCK_STREAM, 0, pair1);
> +        g_assert_cmpint(ret, ==, 0);
> +
> +        ret = qemu_socketpair(PF_LOCAL, SOCK_STREAM, 0, pair2);
> +        g_assert_cmpint(ret, ==, 0);
> +
> +        /* give the guests unpaired ends of the sockets */
> +        src = pair1[0];
> +        dst = pair2[0];
> +    }
> +
> +    qtest_qmp_fds_assert_success(to, &src, 1,
> +                                 "{ 'execute': 'getfd',"
> +                                 "  'arguments': { 'fdname': 'fd-mig' }}");
> +
> +    qtest_qmp_fds_assert_success(from, &dst, 1,
> +                                 "{ 'execute': 'getfd',"
> +                                 "  'arguments': { 'fdname': 'fd-mig' }}");
> +
> +    migrate_recover(to, "fd:fd-mig");
> +
> +    wait_for_migration_status(from, "postcopy-paused",
> +                              (const char * []) { "failed", "active",
> +                                  "completed", NULL });
> +    migrate_qmp(from, "fd:fd-mig", "{'resume': true}");
> +
> +    printf("WAIT\n");
> +    if (method == 2) {
> +        /* This would be issued by the admin upon noticing the hang */
> +        migrate_pause(from);
> +    }
> +
> +    wait_for_migration_status(from, "postcopy-paused",
> +                              (const char * []) { "failed", "active",
> +                                  "completed", NULL });
> +    printf("PAUSED\n");
> +
> +    close(src);
> +    if (method == 2) {
> +        close(dst);
> +    }
> +}
> +
>  static void test_postcopy_recovery_common(MigrateCommon *args)
>  {
>      QTestState *from, *to;
> @@ -1396,6 +1452,13 @@ static void test_postcopy_recovery_common(MigrateCommon *args)
>                                (const char * []) { "failed", "active",
>                                                    "completed", NULL });
>  
> +    if (args->postcopy_recovery_method) {
> +        /* fail the recovery */
> +        postcopy_recover_fail(from, to, args->postcopy_recovery_method);
> +
> +        /* continue with a good recovery */
> +    }
> +
>      /*
>       * Create a new socket to emulate a new channel that is different
>       * from the broken migration channel; tell the destination to
> @@ -1435,6 +1498,24 @@ static void test_postcopy_recovery_compress(void)
>      test_postcopy_recovery_common(&args);
>  }
>  
> +static void test_postcopy_recovery_fail(void)
> +{
> +    MigrateCommon args = {
> +        .postcopy_recovery_method = 1,
> +    };
> +
> +    test_postcopy_recovery_common(&args);
> +}
> +
> +static void test_postcopy_recovery_fail_rp(void)
> +{
> +    MigrateCommon args = {
> +        .postcopy_recovery_method = 2,
> +    };
> +
> +    test_postcopy_recovery_common(&args);
> +}
> +
>  #ifdef CONFIG_GNUTLS
>  static void test_postcopy_recovery_tls_psk(void)
>  {
> @@ -2825,6 +2906,12 @@ int main(int argc, char **argv)
>              qtest_add_func("/migration/postcopy/recovery/compress/plain",
>                             test_postcopy_recovery_compress);
>          }
> +        qtest_add_func("/migration/postcopy/recovery/fail-twice",
> +                       test_postcopy_recovery_fail);
> +
> +        qtest_add_func("/migration/postcopy/recovery/fail-twice/rp",
> +                       test_postcopy_recovery_fail_rp);
> +
>      }
>  
>      qtest_add_func("/migration/bad_dest", test_baddest);

Thanks for contributing the test case!

Do you want me to pick this patch up (with modifications) and repost
together with this series?  It'll also work if you want to send a separate
test patch.  Let me know!

-- 
Peter Xu


