Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B046B76D33C
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 18:04:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qREJ9-00020P-9N; Wed, 02 Aug 2023 12:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qREIw-0001uo-QB
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 12:02:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qREIu-00079B-Km
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 12:02:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690992147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ocjnCiGM3/vSzt2vAlVRPlILsWOhnvY8JChFg27p+3A=;
 b=NJbHUMmGX9yRNLzFzOah9FCHKc3ABZLIX5yOSlVw9cLTscu0aAvzbYjqk7bFYF04jxQuiv
 YHK9vwHesPQS2jGoU61MdalpgHneRRYSklygahGysa6MvCMFZtS2KX4DB4XsiSs/n34Dz9
 vmIaAy/w7GFBB1sqnzSeocp/SkCfZhU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-ddMX4nclO2O2OEvhTYoSsg-1; Wed, 02 Aug 2023 12:02:24 -0400
X-MC-Unique: ddMX4nclO2O2OEvhTYoSsg-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-40559875dd1so13196721cf.1
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 09:02:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690992144; x=1691596944;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ocjnCiGM3/vSzt2vAlVRPlILsWOhnvY8JChFg27p+3A=;
 b=QqcsfQjBgP/ge4PnoHcpxIq482bfk9c8ONd1k24C4mDZ/95XtnEuwqWbBa28eJxcXL
 iScAiESkOiTaNOrZZaTNSjlgXvNgd2MVRxymv0luJVd3kM71xi4dqrto1t/X3MpnHc2l
 rnWtwVqJ9Q6NcqgDw2ZT51FSdHvTic03qvH81nk3dm++t/lUuhlVc/sTt4c9OQ++3Tdq
 PmekLAXQwkP6Ir+ZP2wevZoiFUUCYB1+itOfCdv3Ygpbge++Sx9O/ZtxdvB1DlE/CZSj
 5dd1Eh3Etab+j18nEGk25afdeUKUr0tOvaGrdAGs9029x+FIosa2MB8F1Y2USWkY87fa
 OVAw==
X-Gm-Message-State: ABy/qLbBU09IX37aAbuCo3h/43lfH3MgYq/7Ddi1HcjkrfJKNPm3/9oh
 o4sKZVt+Pg2EhohqXw9RPFj1H+7y9iIwQoT4NgP1io1ebBpTFbUaLqmKDdqmpcnxRwSyU1qR6sZ
 +/KuuUGu31ZKueSA=
X-Received: by 2002:a05:6214:b65:b0:636:dae2:dc4 with SMTP id
 ey5-20020a0562140b6500b00636dae20dc4mr18021033qvb.5.1690992144150; 
 Wed, 02 Aug 2023 09:02:24 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF5NIqeyF+6ujxcp9UzFo4eqpbyU5pPApOb/LOYNgp+Ev9N+l2X+rpN56y39pWQZ0NzxkuY9Q==
X-Received: by 2002:a05:6214:b65:b0:636:dae2:dc4 with SMTP id
 ey5-20020a0562140b6500b00636dae20dc4mr18021003qvb.5.1690992143750; 
 Wed, 02 Aug 2023 09:02:23 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 m18-20020a0cf192000000b0063cfc393c0csm5047243qvl.86.2023.08.02.09.02.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 09:02:23 -0700 (PDT)
Date: Wed, 2 Aug 2023 12:02:22 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v2 2/2] migration: Replace the return path retry logic
Message-ID: <ZMp+DsWuAZHr5Sj/@x1n>
References: <20230802143644.7534-1-farosas@suse.de>
 <20230802143644.7534-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230802143644.7534-3-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Wed, Aug 02, 2023 at 11:36:44AM -0300, Fabiano Rosas wrote:
> Replace the return path retry logic with finishing and restarting the
> thread. This fixes a race when resuming the migration that leads to a
> segfault.
> 
> Currently when doing postcopy we consider that an IO error on the
> return path file could be due to a network intermittency. We then keep
> the thread alive but have it do cleanup of the 'from_dst_file' and
> wait on the 'postcopy_pause_rp' semaphore. When the user issues a
> migrate resume, a new return path is opened and the thread is allowed
> to continue.
> 
> There's a race condition in the above mechanism. It is possible for
> the new return path file to be setup *before* the cleanup code in the
> return path thread has had a chance to run, leading to the *new* file
> being closed and the pointer set to NULL. When the thread is released
> after the resume, it tries to dereference 'from_dst_file' and crashes:
> 
> Thread 7 "return path" received signal SIGSEGV, Segmentation fault.
> [Switching to Thread 0x7fffd1dbf700 (LWP 9611)]
> 0x00005555560e4893 in qemu_file_get_error_obj (f=0x0, errp=0x0) at ../migration/qemu-file.c:154
> 154         return f->last_error;
> 
> (gdb) bt
>  #0  0x00005555560e4893 in qemu_file_get_error_obj (f=0x0, errp=0x0) at ../migration/qemu-file.c:154
>  #1  0x00005555560e4983 in qemu_file_get_error (f=0x0) at ../migration/qemu-file.c:206
>  #2  0x0000555555b9a1df in source_return_path_thread (opaque=0x555556e06000) at ../migration/migration.c:1876
>  #3  0x000055555602e14f in qemu_thread_start (args=0x55555782e780) at ../util/qemu-thread-posix.c:541
>  #4  0x00007ffff38d76ea in start_thread (arg=0x7fffd1dbf700) at pthread_create.c:477
>  #5  0x00007ffff35efa6f in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
> 
> Here's the race (important bit is open_return_path happening before
> migration_release_dst_files):
> 
> migration                 | qmp                         | return path
> --------------------------+-----------------------------+---------------------------------
> 			    qmp_migrate_pause()
> 			     shutdown(ms->to_dst_file)
> 			      f->last_error = -EIO
> migrate_detect_error()
>  postcopy_pause()
>   set_state(PAUSED)
>   wait(postcopy_pause_sem)
> 			    qmp_migrate(resume)
> 			    migrate_fd_connect()
> 			     resume = state == PAUSED
> 			     open_return_path <-- TOO SOON!
> 			     set_state(RECOVER)
> 			     post(postcopy_pause_sem)
> 							(incoming closes to_src_file)
> 							res = qemu_file_get_error(rp)
> 							migration_release_dst_files()
> 							ms->rp_state.from_dst_file = NULL
>   post(postcopy_pause_rp_sem)
> 							postcopy_pause_return_path_thread()
> 							  wait(postcopy_pause_rp_sem)
> 							rp = ms->rp_state.from_dst_file
> 							goto retry
> 							qemu_file_get_error(rp)
> 							SIGSEGV
> -------------------------------------------------------------------------------------------
> 
> We can keep the retry logic without having the thread alive and
> waiting. The only piece of data used by it is the 'from_dst_file' and
> it is only allowed to proceed after a migrate resume is issued and the
> semaphore released at migrate_fd_connect().
> 
> Move the retry logic to outside the thread by having
> open_return_path_on_source() wait for the thread to finish before
> creating a new one with the updated 'from_dst_file'.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/migration.c  | 64 +++++++++++-------------------------------
>  migration/migration.h  |  1 -
>  migration/trace-events |  1 +
>  3 files changed, 17 insertions(+), 49 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 58f09275a8..1356269122 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1764,18 +1764,6 @@ static void migrate_handle_rp_req_pages(MigrationState *ms, const char* rbname,
>      }
>  }
>  
> -/* Return true to retry, false to quit */
> -static bool postcopy_pause_return_path_thread(MigrationState *s)
> -{
> -    trace_postcopy_pause_return_path();
> -
> -    qemu_sem_wait(&s->postcopy_pause_rp_sem);
> -
> -    trace_postcopy_pause_return_path_continued();
> -
> -    return true;
> -}
> -
>  static int migrate_handle_rp_recv_bitmap(MigrationState *s, char *block_name)
>  {
>      RAMBlock *block = qemu_ram_block_by_name(block_name);
> @@ -1859,7 +1847,6 @@ static void *source_return_path_thread(void *opaque)
>      trace_source_return_path_thread_entry();
>      rcu_register_thread();
>  
> -retry:
>      while (!ms->rp_state.error && !qemu_file_get_error(rp) &&
>             migration_is_setup_or_active(ms->state)) {
>          trace_source_return_path_thread_loop_top();
> @@ -1981,28 +1968,18 @@ retry:
>      }
>  
>  out:
> -    res = qemu_file_get_error(rp);
> -    if (res) {
> -        if (res && migration_in_postcopy()) {
> +    if (qemu_file_get_error(rp)) {
> +        if (migration_in_postcopy()) {
>              /*
> -             * Maybe there is something we can do: it looks like a
> -             * network down issue, and we pause for a recovery.
> +             * This could be a network issue that would have been
> +             * detected by the main migration thread and caused the
> +             * migration to pause. Do cleanup and finish.
>               */
> -            migration_release_dst_files(ms);
> -            rp = NULL;
> -            if (postcopy_pause_return_path_thread(ms)) {
> -                /*
> -                 * Reload rp, reset the rest.  Referencing it is safe since
> -                 * it's reset only by us above, or when migration completes
> -                 */
> -                rp = ms->rp_state.from_dst_file;
> -                ms->rp_state.error = false;
> -                goto retry;
> -            }
> +            ms->rp_state.error = false;

Logically we should reflect an error here after the thread quited.  I think
you cleared it for the next resume which also makes sense, but would it be
better to reset it when creating the rp return thread always?

I noticed this because..

> +        } else {
> +            trace_source_return_path_thread_bad_end();
> +            mark_source_rp_bad(ms);
>          }
> -
> -        trace_source_return_path_thread_bad_end();
> -        mark_source_rp_bad(ms);
>      }
>  
>      trace_source_return_path_thread_end();
> @@ -2011,8 +1988,7 @@ out:
>      return NULL;
>  }
>  
> -static int open_return_path_on_source(MigrationState *ms,
> -                                      bool create_thread)
> +static int open_return_path_on_source(MigrationState *ms)
>  {
>      ms->rp_state.from_dst_file = qemu_file_get_return_path(ms->to_dst_file);
>      if (!ms->rp_state.from_dst_file) {
> @@ -2021,11 +1997,6 @@ static int open_return_path_on_source(MigrationState *ms,
>  
>      trace_open_return_path_on_source();
>  
> -    if (!create_thread) {
> -        /* We're done */
> -        return 0;
> -    }
> -
>      qemu_thread_create(&ms->rp_state.rp_thread, "return path",
>                         source_return_path_thread, ms, QEMU_THREAD_JOINABLE);
>      ms->rp_state.rp_thread_created = true;
> @@ -2549,6 +2520,11 @@ static MigThrError postcopy_pause(MigrationState *s)
>          qemu_file_shutdown(file);
>          qemu_fclose(file);
>  
> +        if (await_return_path_close_on_source(s)) {
> +            trace_migration_return_path_pause_err();
> +            return MIG_THR_ERR_FATAL;
> +        }

I see that here on return path failures we'll bail out, and actually it's
against the instinction (that when pause it should have failed, so it's
weird why it's returning 0).

So how about above suggestion, plus here we just call
await_return_path_close_on_source(), without caring about the retval?

> +
>          migrate_set_state(&s->state, s->state,
>                            MIGRATION_STATUS_POSTCOPY_PAUSED);
>  
> @@ -2566,12 +2542,6 @@ static MigThrError postcopy_pause(MigrationState *s)
>          if (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER) {
>              /* Woken up by a recover procedure. Give it a shot */
>  
> -            /*
> -             * Firstly, let's wake up the return path now, with a new
> -             * return path channel.
> -             */
> -            qemu_sem_post(&s->postcopy_pause_rp_sem);
> -
>              /* Do the resume logic */
>              if (postcopy_do_resume(s) == 0) {
>                  /* Let's continue! */
> @@ -3259,7 +3229,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>       * QEMU uses the return path.
>       */
>      if (migrate_postcopy_ram() || migrate_return_path()) {
> -        if (open_return_path_on_source(s, !resume)) {
> +        if (open_return_path_on_source(s)) {
>              error_report("Unable to open return-path for postcopy");
>              migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
>              migrate_fd_cleanup(s);
> @@ -3320,7 +3290,6 @@ static void migration_instance_finalize(Object *obj)
>      qemu_sem_destroy(&ms->rate_limit_sem);
>      qemu_sem_destroy(&ms->pause_sem);
>      qemu_sem_destroy(&ms->postcopy_pause_sem);
> -    qemu_sem_destroy(&ms->postcopy_pause_rp_sem);
>      qemu_sem_destroy(&ms->rp_state.rp_sem);
>      qemu_sem_destroy(&ms->rp_state.rp_pong_acks);
>      qemu_sem_destroy(&ms->postcopy_qemufile_src_sem);
> @@ -3340,7 +3309,6 @@ static void migration_instance_init(Object *obj)
>      migrate_params_init(&ms->parameters);
>  
>      qemu_sem_init(&ms->postcopy_pause_sem, 0);
> -    qemu_sem_init(&ms->postcopy_pause_rp_sem, 0);
>      qemu_sem_init(&ms->rp_state.rp_sem, 0);
>      qemu_sem_init(&ms->rp_state.rp_pong_acks, 0);
>      qemu_sem_init(&ms->rate_limit_sem, 0);
> diff --git a/migration/migration.h b/migration/migration.h
> index b7c8b67542..e78db5361c 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -382,7 +382,6 @@ struct MigrationState {
>  
>      /* Needed by postcopy-pause state */
>      QemuSemaphore postcopy_pause_sem;
> -    QemuSemaphore postcopy_pause_rp_sem;
>      /*
>       * Whether we abort the migration if decompression errors are
>       * detected at the destination. It is left at false for qemu
> diff --git a/migration/trace-events b/migration/trace-events
> index 5259c1044b..19ec649d1d 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -164,6 +164,7 @@ migration_rate_limit_pre(int ms) "%d ms"
>  migration_rate_limit_post(int urgent) "urgent: %d"
>  migration_return_path_end_before(void) ""
>  migration_return_path_end_after(int rp_error) "%d"
> +migration_return_path_pause_err(void) ""

If it should never trigger, it shouldn't need a tracepoint.  It needs an
assertion if we're 100% confident, or error_report_once() perhaps would be
more suitable.

Thanks,

>  migration_thread_after_loop(void) ""
>  migration_thread_file_err(void) ""
>  migration_thread_setup_complete(void) ""
> -- 
> 2.35.3
> 

-- 
Peter Xu


