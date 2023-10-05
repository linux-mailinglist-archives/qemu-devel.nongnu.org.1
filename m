Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8497BAA47
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 21:37:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoU9I-0000Uo-6I; Thu, 05 Oct 2023 15:36:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qoU9A-0000UU-Or
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 15:36:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qoU94-0004Kr-4O
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 15:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696534585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B0Mzri2azjtlEesCzKKu2jkuuu422eaKgRVPQNwoxmc=;
 b=b+cU8KxwAhek4cXaZR4VX5P9r6KC6e41wL7fvZN+hN1eA3mFkC385dhiXwgxOAzUgWiv4P
 6HI4FfqT2m7lQM9TroaWnLUuDw6z2BC70QeTTy/fA2bdwY8j4gg8hn50VqBSMvNgsxOn68
 XM4oBMeJBKgSh0DesrgYRFbZ9SwAFkE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-92kuQJACOeiIo0b-HHpyrA-1; Thu, 05 Oct 2023 15:35:18 -0400
X-MC-Unique: 92kuQJACOeiIo0b-HHpyrA-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-77422b20b13so26564485a.1
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 12:35:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696534509; x=1697139309;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B0Mzri2azjtlEesCzKKu2jkuuu422eaKgRVPQNwoxmc=;
 b=ODcGAUCnYxhHjwhZbLsTXdGS0ktnYUiP0tpPFkqd6ZGO+ttQhyiLo4SNmFvRE9TA+O
 yH61annTG+erD0Ygq8r5i8pBiMLYu5Nux3OL+Mu+lZ/IHeo5Q5rq2N6rNT0PezU+OeUS
 F+a69iqSLdg6JBSCiiVyTe9U7yeISYULHvx3shqn/PxMPcppbKMO5yfsL3NLjjliW2J9
 sQ0ZsPxNprQQAxBliCeZhYJ+CimHaRHMd4IEdvlQz3Dl0Z1sQY73QtTGbFDV2pYhT2Mh
 kYZq+/+8pDcYfD7Wh2XcOr/Ct29oJnVdJWodD4v8p46Jko+wTETJ+fOOfF7zoh/pMy70
 alyQ==
X-Gm-Message-State: AOJu0YzU5D75GfEfrZj0/D2xn5bxT0PokYoAy8hzTti1ijvag4nDYpnY
 Mr1hl5WXxuzTAacG9ry3SbBC0D0wP04ee69kmYl57AhrzbIxVkcf7Uz2czUeB3d3HFsv2PznTEQ
 INfhtA0wx663Jcn4=
X-Received: by 2002:a05:620a:2456:b0:76d:95d3:800f with SMTP id
 h22-20020a05620a245600b0076d95d3800fmr6765506qkn.3.1696534508850; 
 Thu, 05 Oct 2023 12:35:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbPce0WOi/QKC8rAB7UxuO5NeU4Exq1WcInbbd3VnNMdxQ7stZWNbLDNXyoJ7g0lcUCGQqWg==
X-Received: by 2002:a05:620a:2456:b0:76d:95d3:800f with SMTP id
 h22-20020a05620a245600b0076d95d3800fmr6765490qkn.3.1696534508457; 
 Thu, 05 Oct 2023 12:35:08 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 c24-20020a05620a11b800b0076ee973b9a7sm716401qkk.27.2023.10.05.12.35.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 12:35:08 -0700 (PDT)
Date: Thu, 5 Oct 2023 15:35:05 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v3 03/10] migration: Refactor error handling in source
 return path
Message-ID: <ZR8P6Qul8UD0JeBT@x1n>
References: <20231004220240.167175-1-peterx@redhat.com>
 <20231004220240.167175-4-peterx@redhat.com>
 <87wmw1o4v7.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wmw1o4v7.fsf@secure.mitica>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, Oct 05, 2023 at 10:22:52AM +0200, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > rp_state.error was a boolean used to show error happened in return path
> > thread.  That's not only duplicating error reporting (migrate_set_error),
> > but also not good enough in that we only do error_report() and set it to
> > true, we never can keep a history of the exact error and show it in
> > query-migrate.
> >
> > To make this better, a few things done:
> >
> >   - Use error_setg() rather than error_report() across the whole lifecycle
> >     of return path thread, keeping the error in an Error*.
> 
> Good.
> 
> >   - Use migrate_set_error() to apply that captured error to the global
> >     migration object when error occured in this thread.
> 
> Good.
> 
> >   - With above, no need to have mark_source_rp_bad(), remove it, alongside
> >     with rp_state.error itself.
> 
> Good.
> 
> >  uint64_t ram_pagesize_summary(void);
> > -int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len);
> > +int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len,
> > +                         Error **errp);
> 
> 
> good.
> 
> > @@ -1793,37 +1782,36 @@ static void migrate_handle_rp_req_pages(MigrationState *ms, const char* rbname,
> >       */
> >      if (!QEMU_IS_ALIGNED(start, our_host_ps) ||
> >          !QEMU_IS_ALIGNED(len, our_host_ps)) {
> > -        error_report("%s: Misaligned page request, start: " RAM_ADDR_FMT
> > -                     " len: %zd", __func__, start, len);
> > -        mark_source_rp_bad(ms);
> > +        error_setg(errp, "MIG_RP_MSG_REQ_PAGES: Misaligned page request, start:"
> > +                   RAM_ADDR_FMT " len: %zd", start, len);
> >          return;
> >      }
> >  
> > -    if (ram_save_queue_pages(rbname, start, len)) {
> > -        mark_source_rp_bad(ms);
> > -    }
> > +    ram_save_queue_pages(rbname, start, len, errp);
> 
> ram_save_queue_pages() returns an int.
> I think this function should return an int.

Phil suggested something similar for the other patch, instead of also let
this function return int, I'll add one more patch to let it return boolean
to show whether there's an error, keeping the real error in errp.

> 
> Next is independent of this patch:
> 
> > -static int migrate_handle_rp_recv_bitmap(MigrationState *s, char *block_name)
> > +static int migrate_handle_rp_recv_bitmap(MigrationState *s, char *block_name,
> > +                                         Error **errp)
> >  {
> >      RAMBlock *block = qemu_ram_block_by_name(block_name);
> >  
> >      if (!block) {
> > -        error_report("%s: invalid block name '%s'", __func__, block_name);
> > +        error_setg(errp, "MIG_RP_MSG_RECV_BITMAP has invalid block name '%s'",
> > +                   block_name);
> >          return -EINVAL;
> 
> We sent -EINVAL.
> 
> >      }
> >  
> >      /* Fetch the received bitmap and refresh the dirty bitmap */
> > -    return ram_dirty_bitmap_reload(s, block);
> > +    return ram_dirty_bitmap_reload(s, block, errp);
> >  }
> >  
> > -static int migrate_handle_rp_resume_ack(MigrationState *s, uint32_t value)
> > +static int migrate_handle_rp_resume_ack(MigrationState *s,
> > +                                        uint32_t value, Error **errp)
> >  {
> >      trace_source_return_path_thread_resume_ack(value);
> >  
> >      if (value != MIGRATION_RESUME_ACK_VALUE) {
> > -        error_report("%s: illegal resume_ack value %"PRIu32,
> > -                     __func__, value);
> > +        error_setg(errp, "illegal resume_ack value %"PRIu32, value);
> >          return -1;
> 
> And here -1.
> 
> On both callers we just check if it is different from zero.  We never
> use the return value as errno, so I think we should move to -1, if there
> is an error, that is what errp is for.

Right.  I'll switch all rp-return thread paths to use boolean as return, as
long as there's errp.

> 
> 
> > -/* Returns 0 if the RP was ok, otherwise there was an error on the RP */
> > -static int await_return_path_close_on_source(MigrationState *ms)
> > +static void await_return_path_close_on_source(MigrationState *ms)
> >  {
> > -    int ret;
> > -
> >      if (!ms->rp_state.rp_thread_created) {
> > -        return 0;
> > +        return;
> >      }
> >  
> >      trace_migration_return_path_end_before();
> > @@ -2060,18 +2050,10 @@ static int await_return_path_close_on_source(MigrationState *ms)
> >          }
> >      }
> >  
> > -    trace_await_return_path_close_on_source_joining();
> >      qemu_thread_join(&ms->rp_state.rp_thread);
> >      ms->rp_state.rp_thread_created = false;
> > -    trace_await_return_path_close_on_source_close();
> > -
> > -    ret = ms->rp_state.error;
> > -    ms->rp_state.error = false;
> > -
> >      migration_release_dst_files(ms);
> > -
> > -    trace_migration_return_path_end_after(ret);
> > -    return ret;
> > +    trace_migration_return_path_end_after();
> >  }
> >  
> >  static inline void
> > @@ -2367,7 +2349,10 @@ static void migration_completion(MigrationState *s)
> >          goto fail;
> >      }
> >  
> > -    if (await_return_path_close_on_source(s)) {
> > +    await_return_path_close_on_source(s);
> > +
> > +    /* If return path has error, should have been set here */
> > +    if (migrate_has_error(s)) {
> >          goto fail;
> >      }
> 
> In general, I think this is bad.  We are moving for
> 
> int foo(..)
> {
> 
> }
> 
> ....
> 
> if (foo()) {
>      goto fail;
> }
> 
> to:
> 
> void foo(..)
> {
> 
> }
> 
> ....
> 
> foo();
> 
> if (bar()) {
>      goto fail;
> }
> 
> I would preffer to move the other way around.  Move the error
> synchrconously. My plan is that at some point in time
> qemu_file_get_error() dissapears, i.e. we return the error when we
> receive it and we handle it synchronously.
> 
> And yes, that is a something will take a lot of time, but I will hope we
> move on that direction, not in trusting more setting internal errors,
> use void functions and then check with yet another functions.

IIUC "synchronous" here means we can have the Error* returned from
pthread_join(), but I worry that might be too late, that the real return
path Error* doesn't get its chance to set into MigrationState.error because
there can already be some error set.

I can at least move that check into await_return_path_close_on_source()
again, so it keeps returning something.  Does that sound like okay for now?

> 
> 
> On top of your changes:
> 
> > -int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block)
> > +int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block, Error **errp)
> >  {
> >      int ret = -EINVAL;
> >      /* from_dst_file is always valid because we're within rp_thread */
> > @@ -4163,8 +4165,8 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block)
> >      trace_ram_dirty_bitmap_reload_begin(block->idstr);
> >  
> >      if (s->state != MIGRATION_STATUS_POSTCOPY_RECOVER) {
> > -        error_report("%s: incorrect state %s", __func__,
> > -                     MigrationStatus_str(s->state));
> > +        error_setg(errp, "Reload bitmap in incorrect state %s",
> > +                   MigrationStatus_str(s->state));
> >          return -EINVAL;
> 
> return -1
> 
> same for the rest of the cases. Callers only check for != 0, and if you
> want details, you need to look at errp.

I'll let them return boolean here too to be consistent.

Thanks,

-- 
Peter Xu


