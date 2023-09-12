Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F5B79DC33
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 00:50:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgCCb-0002pc-UL; Tue, 12 Sep 2023 18:49:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qgCCZ-0002pI-Vm
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 18:49:48 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qgCCX-0004qG-97
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 18:49:47 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 769931F88D;
 Tue, 12 Sep 2023 22:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694558982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QDrAC6A0YewYjLDXBqTcFiind/EKHj33S7kNH4QYUMk=;
 b=VUST4MxqYp25l80XCSSvzaBFiBAz6zhHi9MZuDsySQ8zqpl3Td7LRPloxPh/0Xh7HlVFpN
 3P/70ujIx8Q7C9sAQQHHDIAwdRn/z0KY0puXl7HSH/5oAd99aJi+UTOEE2z+/CiibyLc5Z
 ChaXBCiEEvVee02PIj5NtAILa0/ecPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694558982;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QDrAC6A0YewYjLDXBqTcFiind/EKHj33S7kNH4QYUMk=;
 b=3QlYbTKmV3upvqATrdno+F+bMiOuBwGjTwPhIB/FZ4HaHsSaobaJg5P+zpGu65qNCsKfBk
 Opptcm0lAlDeU+Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC681139DB;
 Tue, 12 Sep 2023 22:49:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id vDgnGgTrAGUnNQAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 12 Sep 2023 22:49:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, Xiaohui Li
 <xiaohli@redhat.com>
Subject: Re: [PATCH 9/9] migration/postcopy: Allow network to fail even
 during recovery
In-Reply-To: <ZQDEh85X2IcC+o8M@x1n>
References: <20230829214235.69309-1-peterx@redhat.com>
 <20230829214235.69309-10-peterx@redhat.com> <877cowmdu0.fsf@suse.de>
 <ZQDEh85X2IcC+o8M@x1n>
Date: Tue, 12 Sep 2023 19:49:37 -0300
Message-ID: <87a5trknwe.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
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

>> Scenario 1:
>> /x86_64/migration/postcopy/recovery/fail-twice
>> 
>> the stacks are:
>> 
>> Thread 8 (Thread 0x7fffd5ffe700 (LWP 30282) "live_migration"):
>>  qemu_sem_wait
>>  ram_dirty_bitmap_sync_all
>>  ram_resume_prepare
>>  qemu_savevm_state_resume_prepare
>>  postcopy_do_resume
>>  postcopy_pause
>>  migration_detect_error
>>  migration_thread
>> 
>> Thread 7 (Thread 0x7fffd67ff700 (LWP 30281) "return path"):
>>  qemu_sem_wait
>>  postcopy_pause_return_path_thread
>>  source_return_path_thread
>
> I guess this is because below path triggers:
>
>     if (len > 0) {
>         f->buf_size += len;
>         f->total_transferred += len;
>     } else if (len == 0) {
>         qemu_file_set_error_obj(f, -EIO, local_error);     <-----------
>     } else {
>         qemu_file_set_error_obj(f, len, local_error);
>     }
>
> So the src can always write anything into the tmp file, but any read will
> return 0 immediately because file offset is always pointing to the file
> size.

Yes, a 0 return would mean EOF indeed.

>> 
>> This patch seems to fix it, although we cannot call qmp_migrate_recover
>> a second time because the mis state is now in RECOVER:
>> 
>>   "Migrate recover can only be run when postcopy is paused."
>> 
>> Do we maybe need to return the state to PAUSED, or allow
>> qmp_migrate_recover to run in RECOVER, like you did on the src side?

I figured what is going on here (test #1). At postcopy_pause_incoming()
the state transition is ACTIVE -> PAUSED, but when the first recovery
fails on the incoming side, the transition would have to be RECOVER ->
PAUSED.

Could you add that change to this patch?

>
> Ouch, I just noticed that my patch was wrong.
>
> I probably need this:
>
> ===8<===
> From 8c2fb7b4c7488002283c7fb6a5e2aae81b21e04b Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Tue, 12 Sep 2023 15:49:54 -0400
> Subject: [PATCH] fixup! migration/postcopy: Allow network to fail even during
>  recovery
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.h | 2 +-
>  migration/migration.c | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/migration/migration.h b/migration/migration.h
> index e7f48e736e..7e61e2ece7 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -482,7 +482,7 @@ int migrate_init(MigrationState *s, Error **errp);
>  bool migration_is_blocked(Error **errp);
>  /* True if outgoing migration has entered postcopy phase */
>  bool migration_in_postcopy(void);
> -bool migration_postcopy_is_alive(void);
> +bool migration_postcopy_is_alive(int state);
>  MigrationState *migrate_get_current(void);
>  
>  uint64_t ram_get_total_transferred_pages(void);
> diff --git a/migration/migration.c b/migration/migration.c
> index de2146c6fc..a9d381886c 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1349,7 +1349,7 @@ bool migration_in_postcopy(void)
>      }
>  }
>  
> -bool migration_postcopy_is_alive(void)
> +bool migration_postcopy_is_alive(int state)
>  {
>      MigrationState *s = migrate_get_current();
>  

Note there's a missing hunk here to actually use the 'state'.

> @@ -1569,7 +1569,7 @@ void qmp_migrate_pause(Error **errp)
>      MigrationIncomingState *mis = migration_incoming_get_current();
>      int ret;
>  
> -    if (migration_postcopy_is_alive()) {
> +    if (migration_postcopy_is_alive(ms->state)) {
>          /* Source side, during postcopy */
>          Error *error = NULL;
>  
> @@ -1593,7 +1593,7 @@ void qmp_migrate_pause(Error **errp)
>          return;
>      }
>  
> -    if (migration_postcopy_is_alive()) {
> +    if (migration_postcopy_is_alive(mis->state)) {
>          ret = qemu_file_shutdown(mis->from_src_file);
>          if (ret) {
>              error_setg(errp, "Failed to pause destination migration");
> -- 
> 2.41.0
> ===8<===
>> 
>> 
>> Scenario 2:
>> /x86_64/migration/postcopy/recovery/fail-twice/rp
>> 
>> Thread 8 (Thread 0x7fffd5ffe700 (LWP 30456) "live_migration"):
>>  qemu_sem_wait
>>  ram_dirty_bitmap_sync_all
>>  ram_resume_prepare
>>  qemu_savevm_state_resume_prepare
>>  postcopy_do_resume
>>  postcopy_pause
>>  migration_detect_error
>>  migration_thread
>> 
>> Thread 7 (Thread 0x7fffd67ff700 (LWP 30455) "return path"):
>>  recvmsg
>>  qio_channel_socket_readv
>>  qio_channel_readv_full
>>  qio_channel_read
>>  qemu_fill_buffer
>>  qemu_peek_byte
>>  qemu_get_byte
>>  qemu_get_be16
>>  source_return_path_thread
>> 
>> Here, with this patch the migration gets stuck unless we call
>> migrate_pause() one more time. After another round of migrate_pause +
>> recover, it finishes properly.

Here (test #2), the issue is that the sockets are unpaired, so there's
no G_IO_IN to trigger the qio_channel watch callback. The incoming side
never calls fd_accept_incoming_migration() and the RP hangs waiting for
something. I think there's no other way to unblock aside from the
explicit qmp_migrate_pause().

>> 
>> 
>> 1- hacked-together test:
>> -->8--
>> From a34685c8795799350665a880cd2ddddbf53c5812 Mon Sep 17 00:00:00 2001
>> From: Fabiano Rosas <farosas@suse.de>
>> Date: Mon, 11 Sep 2023 20:45:33 -0300
>> Subject: [PATCH] test patch
>> 
>> ---
>>  tests/qtest/migration-test.c | 87 ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 87 insertions(+)
>> 
>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>> index 1b43df5ca7..4d9d2209c1 100644
>> --- a/tests/qtest/migration-test.c
>> +++ b/tests/qtest/migration-test.c
>> @@ -695,6 +695,7 @@ typedef struct {
>>      /* Postcopy specific fields */
>>      void *postcopy_data;
>>      bool postcopy_preempt;
>> +    int postcopy_recovery_method;
>>  } MigrateCommon;
>>  
>>  static int test_migrate_start(QTestState **from, QTestState **to,
>> @@ -1357,6 +1358,61 @@ static void test_postcopy_preempt_tls_psk(void)
>>  }
>>  #endif
>>  
>> +static void postcopy_recover_fail(QTestState *from, QTestState *to, int method)
>> +{
>> +    int src, dst;
>> +
>> +    if (method == 1) {
>> +        /* give it some random fd to recover */
>> +        g_autofree char *uri = g_strdup_printf("%s/noop", tmpfs);
>> +        src = dst = open(uri, O_CREAT|O_RDWR);
>
> This is slightly weird.

Yeah, I was just trying to give some sort of bad input that would still
be accepted.

>
> We opened a file, making it RW and pass it over to both QEMUs.
>
> I think the result can be unpredictable for the reader, that if the reader
> reads before any prior writes it'll just quickly fail, or I think it can
> also happen that the read is slower than the write so it can read
> something..  until it reads to the EOF and fail that fd at some point.
>
> Not sure whether it'll cause some behavior difference and uncertainty on
> the test case.

I see qmp_migrate_recover() failing consistently and since the src is
only resumed later, it sees an unresponsive dst and the RP goes into the
retry path.

We could give them both separate files and the result would be more
predictable.

>
> Maybe we drop this method but only keep the below one?
>

Yeah, maybe this is just too weird. I'm fine either way.

[snip]
>>      qtest_add_func("/migration/bad_dest", test_baddest);
>
> Thanks for contributing the test case!
>
> Do you want me to pick this patch up (with modifications) and repost
> together with this series?  It'll also work if you want to send a separate
> test patch.  Let me know!

You can take it. Or drop it if it ends being too artificial. I'll be
focusing on implementing some of the qemu-file.c improvements we
discussed in the past on top of this series.

