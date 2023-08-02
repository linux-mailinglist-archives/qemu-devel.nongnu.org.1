Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A327F76D8C5
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 22:45:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRIhk-0007Ly-76; Wed, 02 Aug 2023 16:44:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qRIhh-0007LQ-L4
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 16:44:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qRIhg-000586-57
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 16:44:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691009059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0OP3/JGLKFhhm/nYQqrlNPhFrxGEbUXGpb78q5XYx/8=;
 b=HDDO3T3OxxEi9pYsihh6RJePh6NiWBqartcz9zl546PYrcPMgbdCoLybpZEuUCjAmltH3v
 lk7VLfnBHkSHhmqC16pJG4F39Uh0qkJns7eNx+7043OWV2a5MbnIbeMgdHrLHjjnqN1R+0
 RbVwo3VT1Pl9BhOmgAR/1tYdnmoSI14=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-YLTd_koTNWu9yQJqxaY8zA-1; Wed, 02 Aug 2023 16:44:17 -0400
X-MC-Unique: YLTd_koTNWu9yQJqxaY8zA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-63cebe9238bso565206d6.1
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 13:44:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691009057; x=1691613857;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0OP3/JGLKFhhm/nYQqrlNPhFrxGEbUXGpb78q5XYx/8=;
 b=VCgdicSMi/h7nY8m99KCdf/zcN/tdd+xIlkNAgRmw+QcCU8K0mLivQJemJaM+sqrCa
 vPtH4KlQ2PSJO5XiaeaVBpv4T0Pft6yoMD+26yURqRrDkKROcaaB9TCAPC7kWokwPBn8
 LlxdYzhyE1KLFSoPfVRSvjfFIMjnrYOjnUucFPGLXVf7CM5z2xBX0v4I4h5/6Pk4/i0K
 pVkA0Ft2AkNL5Z+6qSTKsBeVVKhMKBcDLJn4ULZPERKcKOndMRPDTwwF+MtMZDTHyMmG
 cf446apPqe68+79EN/Dn1gDjFWx/6cox+jn0PVEJ3WTGIZKRs9QKUdMHzMAtz54ILCsR
 pKcQ==
X-Gm-Message-State: ABy/qLYIDd3qn321VnGRgkK0N7+ww5SsViTwTJ7U53LgzWHDRZZs9p01
 qtwycDP2ohNgrnA2c8AeWpQYxEdspKyYqbeyD7MejoIkEUjFFtw3UzLYlW9Sm7Z/d3nQaDAeEM2
 ZPtpWGiVnqPypvX0=
X-Received: by 2002:a05:6214:27eb:b0:626:2305:6073 with SMTP id
 jt11-20020a05621427eb00b0062623056073mr16870363qvb.4.1691009057383; 
 Wed, 02 Aug 2023 13:44:17 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE2tw/qDrDFih+Vw6W26MzUDh0gl/rjeMxUZfLh6DAfU43ovpgdIhr6kiK9UjZzjlu4QbeV/g==
X-Received: by 2002:a05:6214:27eb:b0:626:2305:6073 with SMTP id
 jt11-20020a05621427eb00b0062623056073mr16870355qvb.4.1691009057127; 
 Wed, 02 Aug 2023 13:44:17 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 s9-20020a0ca609000000b006300e1db3ecsm4343679qva.141.2023.08.02.13.44.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 13:44:16 -0700 (PDT)
Date: Wed, 2 Aug 2023 16:44:15 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v2 2/2] migration: Replace the return path retry logic
Message-ID: <ZMrAH2U8GOV/FwNS@x1n>
References: <20230802143644.7534-1-farosas@suse.de>
 <20230802143644.7534-3-farosas@suse.de> <ZMp+DsWuAZHr5Sj/@x1n>
 <871qglcisi.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871qglcisi.fsf@suse.de>
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

On Wed, Aug 02, 2023 at 05:04:45PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> >> +        if (await_return_path_close_on_source(s)) {
> >> +            trace_migration_return_path_pause_err();
> >> +            return MIG_THR_ERR_FATAL;
> >> +        }
> >
> > I see that here on return path failures we'll bail out, and actually it's
> > against the instinction (that when pause it should have failed, so it's
> > weird why it's returning 0).
> >
> > So how about above suggestion, plus here we just call
> > await_return_path_close_on_source(), without caring about the retval?
> 
> So you are suggesting to remove the knowledge of the retry entirely from
> the thread. It just reports the error and the postcopy_pause takes the
> responsibility of ignoring it when we want to retry... It could be
> clearer that way indeed.

That error doesn't really important IMHO here, because the to-dst-file
should have already errored out anyway.

I just think it cleaner if we reset rp_error only until the new thread
created.

> 
> >> +
> >>          migrate_set_state(&s->state, s->state,
> >>                            MIGRATION_STATUS_POSTCOPY_PAUSED);
> >>  
> >> @@ -2566,12 +2542,6 @@ static MigThrError postcopy_pause(MigrationState *s)
> >>          if (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER) {
> >>              /* Woken up by a recover procedure. Give it a shot */
> >>  
> >> -            /*
> >> -             * Firstly, let's wake up the return path now, with a new
> >> -             * return path channel.
> >> -             */
> >> -            qemu_sem_post(&s->postcopy_pause_rp_sem);
> >> -
> >>              /* Do the resume logic */
> >>              if (postcopy_do_resume(s) == 0) {
> >>                  /* Let's continue! */
> >> @@ -3259,7 +3229,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
> >>       * QEMU uses the return path.
> >>       */
> >>      if (migrate_postcopy_ram() || migrate_return_path()) {
> >> -        if (open_return_path_on_source(s, !resume)) {
> >> +        if (open_return_path_on_source(s)) {
> >>              error_report("Unable to open return-path for postcopy");
> >>              migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
> >>              migrate_fd_cleanup(s);
> >> @@ -3320,7 +3290,6 @@ static void migration_instance_finalize(Object *obj)
> >>      qemu_sem_destroy(&ms->rate_limit_sem);
> >>      qemu_sem_destroy(&ms->pause_sem);
> >>      qemu_sem_destroy(&ms->postcopy_pause_sem);
> >> -    qemu_sem_destroy(&ms->postcopy_pause_rp_sem);
> >>      qemu_sem_destroy(&ms->rp_state.rp_sem);
> >>      qemu_sem_destroy(&ms->rp_state.rp_pong_acks);
> >>      qemu_sem_destroy(&ms->postcopy_qemufile_src_sem);
> >> @@ -3340,7 +3309,6 @@ static void migration_instance_init(Object *obj)
> >>      migrate_params_init(&ms->parameters);
> >>  
> >>      qemu_sem_init(&ms->postcopy_pause_sem, 0);
> >> -    qemu_sem_init(&ms->postcopy_pause_rp_sem, 0);
> >>      qemu_sem_init(&ms->rp_state.rp_sem, 0);
> >>      qemu_sem_init(&ms->rp_state.rp_pong_acks, 0);
> >>      qemu_sem_init(&ms->rate_limit_sem, 0);
> >> diff --git a/migration/migration.h b/migration/migration.h
> >> index b7c8b67542..e78db5361c 100644
> >> --- a/migration/migration.h
> >> +++ b/migration/migration.h
> >> @@ -382,7 +382,6 @@ struct MigrationState {
> >>  
> >>      /* Needed by postcopy-pause state */
> >>      QemuSemaphore postcopy_pause_sem;
> >> -    QemuSemaphore postcopy_pause_rp_sem;
> >>      /*
> >>       * Whether we abort the migration if decompression errors are
> >>       * detected at the destination. It is left at false for qemu
> >> diff --git a/migration/trace-events b/migration/trace-events
> >> index 5259c1044b..19ec649d1d 100644
> >> --- a/migration/trace-events
> >> +++ b/migration/trace-events
> >> @@ -164,6 +164,7 @@ migration_rate_limit_pre(int ms) "%d ms"
> >>  migration_rate_limit_post(int urgent) "urgent: %d"
> >>  migration_return_path_end_before(void) ""
> >>  migration_return_path_end_after(int rp_error) "%d"
> >> +migration_return_path_pause_err(void) ""
> >
> > If it should never trigger, it shouldn't need a tracepoint.  It needs an
> > assertion if we're 100% confident, or error_report_once() perhaps would be
> > more suitable.
> 
> It would trigger when a rp error happened that wasn't related to the
> QEMUFile. If we go with your suggestion above, then this goes away.

With your current patch where rp_error seems to be always reset when thread
quit, if that's true then it'll 100% happen that this will not trigger.

But yeah this is a trivial spot, feel free to choose the best if you plan
to reorganize this patch a bit.  Thanks.

-- 
Peter Xu


