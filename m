Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A551B769710
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 15:04:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQSZc-0001xw-VN; Mon, 31 Jul 2023 09:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qQSZb-0001xU-ED
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 09:04:31 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qQSZZ-0000yv-GA
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 09:04:31 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 382922222E;
 Mon, 31 Jul 2023 13:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1690808668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vs4Fzts90JJmVjii4KN0ZhOg0pTZQs/yWz56Ins7eDs=;
 b=xOdJBJ2Lj7sK70vVv+ZU2QNhD9II6yCKXUgDgZx1QcR6Bc5oasc04noqydGNeByFToGjxQ
 /6bZpbj9kK5mYwzO5A1vWUMXAmm7pC3tsrxq5t4h/0WhoUgr7u5Zn3W+1pGc952cbvYUig
 m0Ov4aoYYKgWuLichF6mOkHhvyjjZYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1690808668;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vs4Fzts90JJmVjii4KN0ZhOg0pTZQs/yWz56Ins7eDs=;
 b=6se748/P3/rWoznBH3LeyycBWEkjFTql+bY/eXYm1s7tGmae0YZ+yAiZrnTOMvXvXX69+E
 QtjZlxE209JIvNDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC361133F7;
 Mon, 31 Jul 2023 13:04:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qdVLIVuxx2R+LQAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 31 Jul 2023 13:04:27 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, Leonardo
 Bras <leobras@redhat.com>
Subject: Re: [PATCH 3/3] migration: Replace the return path retry logic
In-Reply-To: <ZMQ29X5/pcDkR7RC@x1n>
References: <20230728121516.16258-1-farosas@suse.de>
 <20230728121516.16258-4-farosas@suse.de> <ZMQ29X5/pcDkR7RC@x1n>
Date: Mon, 31 Jul 2023 10:04:25 -0300
Message-ID: <87ila08c6e.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Peter Xu <peterx@redhat.com> writes:

> On Fri, Jul 28, 2023 at 09:15:16AM -0300, Fabiano Rosas wrote:
>> Replace the return path retry logic with finishing and restarting the
>> thread. This fixes a race when resuming the migration that leads to a
>> segfault.
>> 
>> Currently when doing postcopy we consider that an IO error on the
>> return path file could be due to a network intermittency. We then keep
>> the thread alive but have it do cleanup of the 'from_dst_file' and
>> wait on the 'postcopy_pause_rp' semaphore. When the user issues a
>> migrate resume, a new return path is opened and the thread is allowed
>> to continue.
>> 
>> There's a race condition in the above mechanism. It is possible for
>> the new return path file to be setup *before* the cleanup code in the
>> return path thread has had a chance to run, leading to the *new* file
>> being closed and the pointer set to NULL. When the thread is released
>> after the resume, it tries to dereference 'from_dst_file' and crashes:
>> 
>> Thread 7 "return path" received signal SIGSEGV, Segmentation fault.
>> [Switching to Thread 0x7fffd1dbf700 (LWP 9611)]
>> 0x00005555560e4893 in qemu_file_get_error_obj (f=0x0, errp=0x0) at ../migration/qemu-file.c:154
>> 154         return f->last_error;
>> 
>> (gdb) bt
>>  #0  0x00005555560e4893 in qemu_file_get_error_obj (f=0x0, errp=0x0) at ../migration/qemu-file.c:154
>>  #1  0x00005555560e4983 in qemu_file_get_error (f=0x0) at ../migration/qemu-file.c:206
>>  #2  0x0000555555b9a1df in source_return_path_thread (opaque=0x555556e06000) at ../migration/migration.c:1876
>>  #3  0x000055555602e14f in qemu_thread_start (args=0x55555782e780) at ../util/qemu-thread-posix.c:541
>>  #4  0x00007ffff38d76ea in start_thread (arg=0x7fffd1dbf700) at pthread_create.c:477
>>  #5  0x00007ffff35efa6f in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
>> 
>> Here's the race (important bit is open_return_path happening before
>> migration_release_dst_files):
>> 
>> migration                 | qmp                         | return path
>> --------------------------+-----------------------------+---------------------------------
>> 			    qmp_migrate_pause()
>> 			     shutdown(ms->to_dst_file)
>> 			      f->last_error = -EIO
>> migrate_detect_error()
>>  postcopy_pause()
>>   set_state(PAUSED)
>>   wait(postcopy_pause_sem)
>> 			    qmp_migrate(resume)
>> 			    migrate_fd_connect()
>> 			     resume = state == PAUSED
>> 			     open_return_path <-- TOO SOON!
>> 			     set_state(RECOVER)
>> 			     post(postcopy_pause_sem)
>> 							(incoming closes to_src_file)
>> 							res = qemu_file_get_error(rp)
>> 							migration_release_dst_files()
>> 							ms->rp_state.from_dst_file = NULL
>>   post(postcopy_pause_rp_sem)
>> 							postcopy_pause_return_path_thread()
>> 							  wait(postcopy_pause_rp_sem)
>> 							rp = ms->rp_state.from_dst_file
>> 							goto retry
>> 							qemu_file_get_error(rp)
>> 							SIGSEGV
>> -------------------------------------------------------------------------------------------
>> 
>> We can keep the retry logic without having the thread alive and
>> waiting. The only piece of data used by it is the 'from_dst_file' and
>> it is only allowed to proceed after a migrate resume is issued and the
>> semaphore released at migrate_fd_connect().
>> 
>> Move the retry logic to outside the thread by having
>> open_return_path_on_source() wait for the thread to finish before
>> creating a new one with the updated 'from_dst_file'.
>
> If we can remove that (along with the sync sem) it'll be pretty nice.  If
> you want, and if this works well, not sure whether you're interested in
> doing similarly to the other threads.  Currently we halt all the threads,
> I'm not sure whether we can do similiar things on dest and whether that can
> also benefit on sync efforts.

I'm interested but I don't know the postcopy code too well, I'll have to
spend some time with it.

Next on my list was the multifd p->running flag which seems entirely
superfluous to me.

>
> Still one comment below.
>
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/migration.c | 72 +++++++++++++++----------------------------
>>  migration/migration.h |  1 -
>>  2 files changed, 25 insertions(+), 48 deletions(-)
>> 
>> diff --git a/migration/migration.c b/migration/migration.c
>> index d6f4470265..36cdd7bda8 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -97,6 +97,7 @@ static int migration_maybe_pause(MigrationState *s,
>>                                   int *current_active_state,
>>                                   int new_state);
>>  static void migrate_fd_cancel(MigrationState *s);
>> +static int await_return_path_close_on_source(MigrationState *ms);
>>  
>>  static bool migration_needs_multiple_sockets(void)
>>  {
>> @@ -1764,18 +1765,6 @@ static void migrate_handle_rp_req_pages(MigrationState *ms, const char* rbname,
>>      }
>>  }
>>  
>> -/* Return true to retry, false to quit */
>> -static bool postcopy_pause_return_path_thread(MigrationState *s)
>> -{
>> -    trace_postcopy_pause_return_path();
>> -
>> -    qemu_sem_wait(&s->postcopy_pause_rp_sem);
>> -
>> -    trace_postcopy_pause_return_path_continued();
>> -
>> -    return true;
>> -}
>> -
>>  static int migrate_handle_rp_recv_bitmap(MigrationState *s, char *block_name)
>>  {
>>      RAMBlock *block = qemu_ram_block_by_name(block_name);
>> @@ -1859,7 +1848,6 @@ static void *source_return_path_thread(void *opaque)
>>      trace_source_return_path_thread_entry();
>>      rcu_register_thread();
>>  
>> -retry:
>>      while (!ms->rp_state.error && !qemu_file_get_error(rp) &&
>>             migration_is_setup_or_active(ms->state)) {
>>          trace_source_return_path_thread_loop_top();
>> @@ -1981,28 +1969,18 @@ retry:
>>      }
>>  
>>  out:
>> -    res = qemu_file_get_error(rp);
>> -    if (res) {
>> -        if (res && migration_in_postcopy()) {
>> +    if (qemu_file_get_error(rp)) {
>> +        if (migration_in_postcopy()) {
>>              /*
>> -             * Maybe there is something we can do: it looks like a
>> -             * network down issue, and we pause for a recovery.
>> +             * This could be a network issue that would have been
>> +             * detected by the main migration thread and caused the
>> +             * migration to pause. Do cleanup and finish.
>>               */
>> -            migration_release_dst_files(ms);
>> -            rp = NULL;
>> -            if (postcopy_pause_return_path_thread(ms)) {
>> -                /*
>> -                 * Reload rp, reset the rest.  Referencing it is safe since
>> -                 * it's reset only by us above, or when migration completes
>> -                 */
>> -                rp = ms->rp_state.from_dst_file;
>> -                ms->rp_state.error = false;
>> -                goto retry;
>> -            }
>> +            ms->rp_state.error = false;
>> +        } else {
>> +            trace_source_return_path_thread_bad_end();
>> +            mark_source_rp_bad(ms);
>>          }
>> -
>> -        trace_source_return_path_thread_bad_end();
>> -        mark_source_rp_bad(ms);
>>      }
>>  
>>      trace_source_return_path_thread_end();
>> @@ -2012,8 +1990,21 @@ out:
>>  }
>>  
>>  static int open_return_path_on_source(MigrationState *ms,
>> -                                      bool create_thread)
>> +                                      bool resume)
>>  {
>> +    if (resume) {
>> +        assert(ms->state == MIGRATION_STATUS_POSTCOPY_PAUSED);
>> +
>> +        /*
>> +         * We're resuming from a paused postcopy migration. Wait for
>> +         * the thread to do its cleanup before re-opening the return
>> +         * path.
>> +         */
>> +        if (await_return_path_close_on_source(ms)) {
>> +            return -1;
>> +        }
>
> This smells a bit hacky.  Can we do this in postcopy_pause(), perhaps
> before we switch to PAUSED state?  Then we know after being PAUSED we're
> ready to recover.

It looks like we could. I'll move it.


