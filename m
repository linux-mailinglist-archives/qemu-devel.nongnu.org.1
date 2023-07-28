Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FED767888
	for <lists+qemu-devel@lfdr.de>; Sat, 29 Jul 2023 00:38:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPVHN-0002K2-1A; Fri, 28 Jul 2023 17:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qPVHI-0002Jo-JB
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 17:45:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qPVHG-0002AH-Go
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 17:45:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690580737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6ykmY6BUvATQgByvoqaH0/uDvW04aMyknP6w9OXMfGc=;
 b=f5lDpRQBwLm/NwdR1651wzPvN8iMmeJqlzJTj5TjKoc3wNTF1pvvms/rf2+pLPLPN20gaw
 TWeTqiJPndXXKidNaxAkEXHY0X5SkSH5y1ehPK4RVSCgCAEIDBg6DaNOrGN2Vih9cKUGAp
 aD840VFsHn4MPKRmH44WKVP9+EYgIGk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-LPOmzV0oPeOWvdtx5ViUTQ-1; Fri, 28 Jul 2023 17:45:36 -0400
X-MC-Unique: LPOmzV0oPeOWvdtx5ViUTQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-63cc3a44aedso6178796d6.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 14:45:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690580735; x=1691185535;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ykmY6BUvATQgByvoqaH0/uDvW04aMyknP6w9OXMfGc=;
 b=d+D1CdA0FoLw7Gv2fEherJEIoGNGfAMuKNRSlfwPIDnSSbEUla3taV98GmvMCSmMRb
 bdTIOYH2YNSJIFjjmBHLtCdupxJH8O5f07XK/QOxiUTwgHwa/2FsmuV8foY0SxgPxmzB
 pBOf0BNwXYlmxYS8lKJvEaJrJmD/+CHjtitnRQG2TYZPq/Ndq+EKKC9DxOykS2mLNugu
 JsV6G2RWnyM7qjpc/iINEHX1593r3P/wAC5eYjrFr6XaDSInaJhayQtlpuCWqYw+Xotc
 QpUp4eDQzrX/TuCv01ob7MmLKtS//x7t7h+uddVmMUYTbeRqKUMUjbvg0wXX1fQGbwKQ
 Kb1w==
X-Gm-Message-State: ABy/qLY76LohQ9zTDUiCu0QDHsLt1GhUg4sW1dSFX7t4Z09mdr1DwPKB
 9CF3ryse0GVvkPbEdCwODXKHmlBLQK2RoiNvBkacAydIN7QKpJY8WX/Vv4+mqVvc0SggQ0UTNP4
 T6ReIy+IW1WKIvI0=
X-Received: by 2002:a05:6214:27c6:b0:621:65de:f60c with SMTP id
 ge6-20020a05621427c600b0062165def60cmr566674qvb.3.1690580735435; 
 Fri, 28 Jul 2023 14:45:35 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF/Ql2BlGxq5D4IByNSW/f4sYBTdg/Wg8LH/JLA/DLGzTkaMsV1ToI5XtwFllUJeVR5Ifcfyw==
X-Received: by 2002:a05:6214:27c6:b0:621:65de:f60c with SMTP id
 ge6-20020a05621427c600b0062165def60cmr566658qvb.3.1690580735104; 
 Fri, 28 Jul 2023 14:45:35 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 h16-20020a0cf410000000b0063d119034a3sm1549308qvl.94.2023.07.28.14.45.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jul 2023 14:45:34 -0700 (PDT)
Date: Fri, 28 Jul 2023 17:45:25 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 3/3] migration: Replace the return path retry logic
Message-ID: <ZMQ29X5/pcDkR7RC@x1n>
References: <20230728121516.16258-1-farosas@suse.de>
 <20230728121516.16258-4-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230728121516.16258-4-farosas@suse.de>
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

On Fri, Jul 28, 2023 at 09:15:16AM -0300, Fabiano Rosas wrote:
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

If we can remove that (along with the sync sem) it'll be pretty nice.  If
you want, and if this works well, not sure whether you're interested in
doing similarly to the other threads.  Currently we halt all the threads,
I'm not sure whether we can do similiar things on dest and whether that can
also benefit on sync efforts.

Still one comment below.

> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/migration.c | 72 +++++++++++++++----------------------------
>  migration/migration.h |  1 -
>  2 files changed, 25 insertions(+), 48 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index d6f4470265..36cdd7bda8 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -97,6 +97,7 @@ static int migration_maybe_pause(MigrationState *s,
>                                   int *current_active_state,
>                                   int new_state);
>  static void migrate_fd_cancel(MigrationState *s);
> +static int await_return_path_close_on_source(MigrationState *ms);
>  
>  static bool migration_needs_multiple_sockets(void)
>  {
> @@ -1764,18 +1765,6 @@ static void migrate_handle_rp_req_pages(MigrationState *ms, const char* rbname,
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
> @@ -1859,7 +1848,6 @@ static void *source_return_path_thread(void *opaque)
>      trace_source_return_path_thread_entry();
>      rcu_register_thread();
>  
> -retry:
>      while (!ms->rp_state.error && !qemu_file_get_error(rp) &&
>             migration_is_setup_or_active(ms->state)) {
>          trace_source_return_path_thread_loop_top();
> @@ -1981,28 +1969,18 @@ retry:
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
> @@ -2012,8 +1990,21 @@ out:
>  }
>  
>  static int open_return_path_on_source(MigrationState *ms,
> -                                      bool create_thread)
> +                                      bool resume)
>  {
> +    if (resume) {
> +        assert(ms->state == MIGRATION_STATUS_POSTCOPY_PAUSED);
> +
> +        /*
> +         * We're resuming from a paused postcopy migration. Wait for
> +         * the thread to do its cleanup before re-opening the return
> +         * path.
> +         */
> +        if (await_return_path_close_on_source(ms)) {
> +            return -1;
> +        }

This smells a bit hacky.  Can we do this in postcopy_pause(), perhaps
before we switch to PAUSED state?  Then we know after being PAUSED we're
ready to recover.

Thanks,

> +    }
> +
>      ms->rp_state.from_dst_file = qemu_file_get_return_path(ms->to_dst_file);
>      if (!ms->rp_state.from_dst_file) {
>          return -1;
> @@ -2021,11 +2012,6 @@ static int open_return_path_on_source(MigrationState *ms,
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
> @@ -2550,12 +2536,6 @@ static MigThrError postcopy_pause(MigrationState *s)
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
> @@ -3243,7 +3223,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>       * QEMU uses the return path.
>       */
>      if (migrate_postcopy_ram() || migrate_return_path()) {
> -        if (open_return_path_on_source(s, !resume)) {
> +        if (open_return_path_on_source(s, resume)) {
>              error_report("Unable to open return-path for postcopy");
>              migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
>              migrate_fd_cleanup(s);
> @@ -3304,7 +3284,6 @@ static void migration_instance_finalize(Object *obj)
>      qemu_sem_destroy(&ms->rate_limit_sem);
>      qemu_sem_destroy(&ms->pause_sem);
>      qemu_sem_destroy(&ms->postcopy_pause_sem);
> -    qemu_sem_destroy(&ms->postcopy_pause_rp_sem);
>      qemu_sem_destroy(&ms->rp_state.rp_sem);
>      qemu_sem_destroy(&ms->rp_state.rp_pong_acks);
>      qemu_sem_destroy(&ms->postcopy_qemufile_src_sem);
> @@ -3324,7 +3303,6 @@ static void migration_instance_init(Object *obj)
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
> -- 
> 2.35.3
> 

-- 
Peter Xu


