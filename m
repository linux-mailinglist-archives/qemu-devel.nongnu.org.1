Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE4E75B8CF
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 22:39:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMaPi-0000mC-Bq; Thu, 20 Jul 2023 16:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qMaPg-0000m0-A8
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 16:38:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qMaPe-0006CC-LU
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 16:38:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689885491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nIsBIssIRgwegln3SGbmDiBER5KLf/xLQEoqAd3kXhk=;
 b=B0HJJVL0dABhfEwr5O+2IxJyUAx/5/UktrQ5BrUIlv1n7OVw8xABNMpa8dDEwSjGrFs1k7
 wqZdhwPQ9hgJMyKtz6pQ57qfBy8XkIlxLFGC7d7aqzFhnn5qOskp/ZoTWrxVJ2nKPB6vv/
 Knm4Zswdyj/OZATGeqfPKJq/GzmbbbA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-FgDVs728OByaHokAf7aNMw-1; Thu, 20 Jul 2023 16:38:09 -0400
X-MC-Unique: FgDVs728OByaHokAf7aNMw-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-635de6f75e0so3006036d6.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 13:38:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689885488; x=1690490288;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIsBIssIRgwegln3SGbmDiBER5KLf/xLQEoqAd3kXhk=;
 b=gvioY4tsZDX4K1u+M2I3Fh0yh3vjDHIy1PhpsFBBD814LVLMwMt/J+crLaRtZsaQl2
 jv7idle+7HDH0U08Ds0Xy/qbAlH7nsFp6gj9qesvGVSIJaSVE8yI+3gcbC6ugRHBlBZ2
 Ed785hNOQgOzAyG0fa51jkKshKyBrLmsFbZx8yzVLOvirdywWbEWekgxGJyYqvJkYWyq
 M8lsqSe12dwjtIIWy5NNG8lQImHUYxcYKGpiONONbn/4xm+GOhXm0r2699dYie59MSl5
 YlasUFElY36jRyWcvDmwAlQGO8ShZkIf5lBhUK599nzSsV7dqp47hekZaPEStkH4gVXM
 13Ig==
X-Gm-Message-State: ABy/qLYODikZwiGdKngyTKC9w9t1hx649H4TvNI6Y/uEiKg9iVVOn+mS
 LVqSKsCcfTa4BKNyKOrcP3lBDOCu5KT3LkthsKK4bgDhw21MwKOYRQfApT/V+IAz22rn3TAHNYH
 HhQnM0e9sIq+GKt4=
X-Received: by 2002:a05:6214:528d:b0:62d:fdc4:1e8b with SMTP id
 kj13-20020a056214528d00b0062dfdc41e8bmr210782qvb.2.1689885488575; 
 Thu, 20 Jul 2023 13:38:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHwcyFj9Z0eoch7vUmGVYBR7S9DmZ1gsKTW18s8kg8l/rTgAfbwu66GGyoVjnw3bFHSesXAuQ==
X-Received: by 2002:a05:6214:528d:b0:62d:fdc4:1e8b with SMTP id
 kj13-20020a056214528d00b0062dfdc41e8bmr210766qvb.2.1689885488305; 
 Thu, 20 Jul 2023 13:38:08 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 j2-20020a0cae82000000b00635e9db359bsm707457qvd.82.2023.07.20.13.38.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jul 2023 13:38:07 -0700 (PDT)
Date: Thu, 20 Jul 2023 16:38:01 -0400
From: Peter Xu <peterx@redhat.com>
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: Isaku Yamahata <isaku.yamahata@gmail.com>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v1] migration: refactor migration_completion
Message-ID: <ZLmbKSqrDvg7Tx4A@x1n>
References: <20230714124823.25142-1-wei.w.wang@intel.com>
 <20230718054425.GA1807130@ls.amr.corp.intel.com>
 <DS0PR11MB6373E417A60B2DEF9EFE3697DC38A@DS0PR11MB6373.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DS0PR11MB6373E417A60B2DEF9EFE3697DC38A@DS0PR11MB6373.namprd11.prod.outlook.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Tue, Jul 18, 2023 at 01:25:12PM +0000, Wang, Wei W wrote:
> On Tuesday, July 18, 2023 1:44 PM, Isaku Yamahata wrote:
> > > --- a/migration/migration.c
> > > +++ b/migration/migration.c
> > > @@ -2058,6 +2058,21 @@ static int
> > await_return_path_close_on_source(MigrationState *ms)
> > >      return ms->rp_state.error;
> > >  }
> > >
> > > +static int close_return_path_on_source(MigrationState *ms) {
> > > +    int ret;
> > > +
> > > +    if (!ms->rp_state.rp_thread_created) {
> > > +        return 0;
> > > +    }
> > > +
> > > +    trace_migration_return_path_end_before();
> > > +    ret = await_return_path_close_on_source(ms);
> > > +    trace_migration_return_path_end_after(ret);
> > > +
> > > +    return ret;
> > > +}
> > > +
> > 
> > There is only one caller, migration_completion().  We can consolidate two
> > functions, await_return_path_close_on_source() and
> > close_return_path_on_source(), into single function.
> 
> Sounds good, thanks.
> 
> > > +static int migration_completion_postcopy(MigrationState *s) {
> > > +    trace_migration_completion_postcopy_end();
> > > +
> > > +    qemu_mutex_lock_iothread();
> > > +    qemu_savevm_state_complete_postcopy(s->to_dst_file);
> > > +    qemu_mutex_unlock_iothread();
> > > +
> > > +    /*
> > > +     * Shutdown the postcopy fast path thread.  This is only needed when
> > dest
> > > +     * QEMU binary is old (7.1/7.2).  QEMU 8.0+ doesn't need this.
> > > +     */
> > > +    if (migrate_postcopy_preempt() && s->preempt_pre_7_2) {
> > > +        postcopy_preempt_shutdown_file(s);
> > > +    }
> > > +
> > > +    trace_migration_completion_postcopy_end_after_complete();
> > > +
> > > +    return 0;
> > 
> > Always return 0?  Make it void.
> 
> OK.
> 
> > > +static void migration_completion(MigrationState *s) {
> > > +    int ret = -1;
> > > +    int current_active_state = s->state;
> > > +
> > > +    if (s->state == MIGRATION_STATUS_ACTIVE) {
> > > +        ret = migration_completion_precopy(s, &current_active_state);
> > > +    } else if (s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
> > > +        ret = migration_completion_postcopy(s);
> > 
> > Here we can set ret = 0.
> 
> Yes, after migration_completion_postcopy is made "void".

Looks good to me, after addressing Isaku's comments.

The current_active_state is very unfortunate, along with most of the calls
to migrate_set_state() - I bet most of the code will definitely go wrong if
that cmpxchg didn't succeed inside of migrate_set_state(), IOW in most
cases we simply always want:

  migrate_set_state(&s->state, s->state, XXX);

Not sure whether one pre-requisite patch is good to have so we can rename
migrate_set_state() to something like __migrate_set_state(), then:

  migrate_set_state(s, XXX) {
    __migrate_set_state(&s->state, s->state, XXX);
  }

I don't even know whether there's any call site that will need
__migrate_set_state() for real..

Thanks,

-- 
Peter Xu


