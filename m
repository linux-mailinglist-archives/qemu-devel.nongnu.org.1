Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B3176D38D
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 18:20:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qREZY-00064H-8F; Wed, 02 Aug 2023 12:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qREZW-000643-HT
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 12:19:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qREZU-0006IS-SN
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 12:19:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690993175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fsubpjFb4taNAYIlV0ZJg+QXZBCLZHykOtNxRPrRKtc=;
 b=LTBP/HFLFaQ10CJz7vGwTiCg7rIqsxmysfSEtVsyHmY0AnOOUv18XY9+KulohtqEwQOtIw
 3pMg4OLUQSG2HoSbBDnlyHxWZUBtUeVpC/1aMw/aqUA3E3Tn8f0dCu7bM0MduLSGcGbghW
 +3E/1CqPFuYRyXgtHfDDHDCcMsdhENA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-XZZBfFIfNpuSpK-e-HCgYA-1; Wed, 02 Aug 2023 12:19:34 -0400
X-MC-Unique: XZZBfFIfNpuSpK-e-HCgYA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-63c9463c116so9416d6.0
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 09:19:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690993174; x=1691597974;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fsubpjFb4taNAYIlV0ZJg+QXZBCLZHykOtNxRPrRKtc=;
 b=PFA+ukkrDun3nHNvGUGPKTaYPYAX2zRghIW6DzJy43zTr2wWSQVNNUlPMZjbUMFkTW
 NuGIYoRv3CW7PAarv1Rl2ke9vBsKVFeAvikK0ztB3rJp0kbKKmxpqbcZojz3N+BtaRV0
 6j+N45yHgth6esL61ixOM0p6NkKG8e+D663hpkUi3iCUBZQF9/Y40rYbtXHBZTVYzUb0
 uUxsRGHF4uWuQPjGAmqh8hSpGfzlAg/g9Kz/vga5YTnPynoKT8Ax+Xfvw6yZI5B3u+BS
 N9DfR+HRXsflhhKSOqzh0x8DCtpIuomeL12PxjQyOv6MUFHLMTUQ4Teu/VY73qdXp8J+
 74Lw==
X-Gm-Message-State: ABy/qLZVjvDwTfSVIKeAgAkUlzslH87/ak3RS9pXWTsfDvqUEyxn92o3
 52CjxCpfRTuQzlZAqrWPMM2CHEFcU//l81FxvihC/HaCyZGQ6noYBFf/e1b/jN7WDP14V0MfgAQ
 V2QvmRDviQJQ+Itw=
X-Received: by 2002:a05:6214:242a:b0:635:d9d0:cccf with SMTP id
 gy10-20020a056214242a00b00635d9d0cccfmr13090949qvb.4.1690993174070; 
 Wed, 02 Aug 2023 09:19:34 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF55dz86PRm0GG5OMe7RNxhZ1ZTy7kCPskNEAHI7uIOdMoIymNU1ycPVQ+KWqdRMJaZocBO9w==
X-Received: by 2002:a05:6214:242a:b0:635:d9d0:cccf with SMTP id
 gy10-20020a056214242a00b00635d9d0cccfmr13090932qvb.4.1690993173738; 
 Wed, 02 Aug 2023 09:19:33 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 d7-20020a0cb2c7000000b0063d2b827bbfsm5655329qvf.49.2023.08.02.09.19.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 09:19:33 -0700 (PDT)
Date: Wed, 2 Aug 2023 12:19:32 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v2 1/2] migration: Split await_return_path_close_on_source
Message-ID: <ZMqCFIXONOxUCeSE@x1n>
References: <20230802143644.7534-1-farosas@suse.de>
 <20230802143644.7534-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230802143644.7534-2-farosas@suse.de>
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

On Wed, Aug 02, 2023 at 11:36:43AM -0300, Fabiano Rosas wrote:
> This function currently has a straight-forward part which is waiting
> for the thread to join and a complicated part which is doing a
> qemu_file_shutdown() on the return path file.
> 
> The shutdown is tricky because all calls to qemu_file_shutdown() set
> f->last_error to -EIO, which means we can never know if an error is an
> actual error or if we cleanly shutdown the file previously.
> 
> This is particularly bothersome for postcopy because it would send the
> return path thread into the retry routine which would wait on the
> postcopy_pause_rp_sem and consequently block the main thread. We
> haven't had reports of this so I must presume we never reach here with
> postcopy.
> 
> The shutdown call is also racy because since it doesn't take the
> qemu_file_lock, it could NULL-dereference if the return path thread
> happens to be in the middle of the critical region at
> migration_release_dst_files().

After you rework the thread model on resume, shall we move
migration_release_dst_files() into the migration thread to be after the
pthread_join()?  I assume then we don't even need a mutex to protect it?

> 
> Move this more complicated part of the code to a separate routine so
> we can wait on the thread without all of this baggage.

I think you mentioned "some nuance" on having mark_source_rp_bad() in
await_return_path_close_on_source(), I did remember I tried to look into
that "nuance" too a long time ago but I just forgot what was that.  Great
if you can share some details.

> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/migration.c | 46 +++++++++++++++++++++++++------------------
>  1 file changed, 27 insertions(+), 19 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 91bba630a8..58f09275a8 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2038,6 +2038,25 @@ static int open_return_path_on_source(MigrationState *ms,
>  /* Returns 0 if the RP was ok, otherwise there was an error on the RP */
>  static int await_return_path_close_on_source(MigrationState *ms)
>  {
> +    if (!ms->rp_state.rp_thread_created) {
> +        return 0;
> +    }
> +
> +    trace_await_return_path_close_on_source_joining();
> +    qemu_thread_join(&ms->rp_state.rp_thread);
> +    ms->rp_state.rp_thread_created = false;
> +    trace_await_return_path_close_on_source_close();
> +    return ms->rp_state.error;
> +}
> +
> +static int close_return_path_on_source(MigrationState *ms)
> +{
> +    int ret;
> +
> +    if (!ms->rp_state.rp_thread_created) {
> +        return 0;
> +    }

Can we still rely on the await_return_path_close_on_source() check, so as
to dedup this one?

> +
>      /*
>       * If this is a normal exit then the destination will send a SHUT and the
>       * rp_thread will exit, however if there's an error we need to cause
> @@ -2051,11 +2070,12 @@ static int await_return_path_close_on_source(MigrationState *ms)
>          qemu_file_shutdown(ms->rp_state.from_dst_file);
>          mark_source_rp_bad(ms);
>      }
> -    trace_await_return_path_close_on_source_joining();
> -    qemu_thread_join(&ms->rp_state.rp_thread);
> -    ms->rp_state.rp_thread_created = false;
> -    trace_await_return_path_close_on_source_close();
> -    return ms->rp_state.error;
> +
> +    trace_migration_return_path_end_before();
> +    ret = await_return_path_close_on_source(ms);
> +    trace_migration_return_path_end_after(ret);
> +
> +    return ret;
>  }
>  
>  static inline void
> @@ -2351,20 +2371,8 @@ static void migration_completion(MigrationState *s)
>          goto fail;
>      }
>  
> -    /*
> -     * If rp was opened we must clean up the thread before
> -     * cleaning everything else up (since if there are no failures
> -     * it will wait for the destination to send it's status in
> -     * a SHUT command).
> -     */
> -    if (s->rp_state.rp_thread_created) {
> -        int rp_error;
> -        trace_migration_return_path_end_before();
> -        rp_error = await_return_path_close_on_source(s);
> -        trace_migration_return_path_end_after(rp_error);
> -        if (rp_error) {
> -            goto fail;
> -        }
> +    if (close_return_path_on_source(s)) {
> +        goto fail;
>      }
>  
>      if (qemu_file_get_error(s->to_dst_file)) {
> -- 
> 2.35.3
> 

-- 
Peter Xu


