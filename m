Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FBA85F9D2
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Feb 2024 14:30:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd99E-0003Bi-Ll; Thu, 22 Feb 2024 08:30:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rd99B-0003Ae-UN
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 08:29:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rd999-0003bT-FE
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 08:29:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708608594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c9toZM3VCvQ7EGL14qyF7DJrWbBkfquvrwHIiQ/XDYU=;
 b=LMPPGBCnT+0b2/mwsfH+9eUKIGvL1bkvtuJ2JzBnIxXtTofpwmdM93KIWWBVmpEukXqNd8
 fmKPAXU+Fj89dGwGAk1zQ/pIhfO3XOk2SD/WEnC82SQ75abu0Qx1KeDZ2TQAEuBpw5utFY
 c888YRRzHAcYpXT8fM9/WqSyp+KMo6Q=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-OcjYjsd0PI-J0ulqwauRpw-1; Thu, 22 Feb 2024 08:29:52 -0500
X-MC-Unique: OcjYjsd0PI-J0ulqwauRpw-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-29999b97b39so1750147a91.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 05:29:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708608591; x=1709213391;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c9toZM3VCvQ7EGL14qyF7DJrWbBkfquvrwHIiQ/XDYU=;
 b=cvbjKGyK9LuopHDnCnI724yyopa+DbCFfR5JWXuhCkCesg8a+FLS7sRWYqB6T+3EMb
 T/E9nZ8TfSgloFkg6rMSZ8yPsOY840kjTBf21v9nFP+h9PgMqrm+q/q8ImgCfwf4yalM
 Hxa0PEDCWp/05/Pj5S9ALlmLksE68+noiwE4bbbnmLtM3exStf9pmZY3F+WWEbf8x3mu
 0BzHzE3El/zslHEB4ZvJg9jzZKJ4BGsZcnYAWe8MxBGPQ1j1zYdnKd7p3K64p6Lyy3tG
 srUZQFVYByM7oGrLBYJ/bPluuTFYtta5BeRLXPx6akYcJyrV2iBIQ5DXIhoMjtj9+AvZ
 XB5A==
X-Gm-Message-State: AOJu0YzmOUpD535f5HYSgPoU7qhRSynPQSsjJtwWHnp7rv+oL9/5jchG
 UZJtDf0mE/AoX2y06a4AZsyRjRGR2S5NJQds20cW6cB41Igt73//1IEBNYTG4rkUtd66FDUFMG8
 Cl7AVOQ80MuM675Mql6Tdvpjz69uClkLO71/Y/oZ9AZy9bihLQ7N0/kAP3e1mc2o=
X-Received: by 2002:a17:902:bb81:b0:1d8:ca3a:9d2a with SMTP id
 m1-20020a170902bb8100b001d8ca3a9d2amr21537769pls.4.1708608591164; 
 Thu, 22 Feb 2024 05:29:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlbZE+P9kRMO+hRz9F9njXPmnW+WdNSFX+hL4tinfRLN+xqnYYouBxTp0gIhDrFtcG3QYipA==
X-Received: by 2002:a17:902:bb81:b0:1d8:ca3a:9d2a with SMTP id
 m1-20020a170902bb8100b001d8ca3a9d2amr21537749pls.4.1708608590698; 
 Thu, 22 Feb 2024 05:29:50 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 m20-20020a170902f21400b001d8e22d6a2dsm9940035plc.72.2024.02.22.05.29.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 05:29:50 -0800 (PST)
Date: Thu, 22 Feb 2024 21:29:42 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] migration: Fix qmp_query_migrate mbps value
Message-ID: <ZddMRroqCeuRWGFA@x1n>
References: <20240219194457.26923-1-farosas@suse.de> <ZdVlUsTDJA4hdNhg@x1n>
 <87y1beascb.fsf@suse.de> <ZdcWmVffLWhNB-Q8@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZdcWmVffLWhNB-Q8@x1n>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.002,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Feb 22, 2024 at 05:40:41PM +0800, Peter Xu wrote:
> On Wed, Feb 21, 2024 at 09:56:36AM -0300, Fabiano Rosas wrote:
> > Peter Xu <peterx@redhat.com> writes:
> > 
> > > On Mon, Feb 19, 2024 at 04:44:57PM -0300, Fabiano Rosas wrote:
> > >> The QMP command query_migrate might see incorrect throughput numbers
> > >> if it runs after we've set the migration completion status but before
> > >> migration_calculate_complete() has updated s->total_time and s->mbps.
> > >> 
> > >> The migration status would show COMPLETED, but the throughput value
> > >> would be the one from the last iteration and not the one from the
> > >> whole migration. This will usually be a larger value due to the time
> > >> period being smaller (one iteration).
> > >> 
> > >> Move migration_calculate_complete() earlier so that the status
> > >> MIGRATION_STATUS_COMPLETED is only emitted after the final counters
> > >> update.
> > >> 
> > >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> > >> ---
> > >> CI run: https://gitlab.com/farosas/qemu/-/pipelines/1182405776
> > >> ---
> > >>  migration/migration.c | 10 ++++++----
> > >>  1 file changed, 6 insertions(+), 4 deletions(-)
> > >> 
> > >> diff --git a/migration/migration.c b/migration/migration.c
> > >> index ab21de2cad..7486d59da0 100644
> > >> --- a/migration/migration.c
> > >> +++ b/migration/migration.c
> > >> @@ -102,6 +102,7 @@ static int migration_maybe_pause(MigrationState *s,
> > >>                                   int new_state);
> > >>  static void migrate_fd_cancel(MigrationState *s);
> > >>  static bool close_return_path_on_source(MigrationState *s);
> > >> +static void migration_calculate_complete(MigrationState *s);
> > >>  
> > >>  static void migration_downtime_start(MigrationState *s)
> > >>  {
> > >> @@ -2746,6 +2747,7 @@ static void migration_completion(MigrationState *s)
> > >>          migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> > >>                            MIGRATION_STATUS_COLO);
> > >>      } else {
> > >> +        migration_calculate_complete(s);
> > >>          migrate_set_state(&s->state, current_active_state,
> > >>                            MIGRATION_STATUS_COMPLETED);
> > >>      }
> > >> @@ -2784,6 +2786,7 @@ static void bg_migration_completion(MigrationState *s)
> > >>          goto fail;
> > >>      }
> > >>  
> > >> +    migration_calculate_complete(s);
> > >>      migrate_set_state(&s->state, current_active_state,
> > >>                        MIGRATION_STATUS_COMPLETED);
> > >>      return;
> > >> @@ -2993,12 +2996,15 @@ static void migration_calculate_complete(MigrationState *s)
> > >>      int64_t end_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> > >>      int64_t transfer_time;
> > >>  
> > >> +    /* QMP could read from these concurrently */
> > >> +    bql_lock();
> > >>      migration_downtime_end(s);
> > >>      s->total_time = end_time - s->start_time;
> > >>      transfer_time = s->total_time - s->setup_time;
> > >>      if (transfer_time) {
> > >>          s->mbps = ((double) bytes * 8.0) / transfer_time / 1000;
> > >>      }
> > >> +    bql_unlock();
> > >
> > > The lock is not needed?
> > >
> > > AFAIU that was needed because of things like runstate_set() rather than
> > > setting of these fields.
> > >
> > 
> > Don't we need to keep the total_time and mbps update atomic? Otherwise
> > query-migrate might see (say) total_time=0 and mbps=<correct value> or
> > total_time=<correct value> and mbps=<previous value>.
> 
> I thought it wasn't a major concern, but what you said makes sense; taking
> it one more time doesn't really hurt after all to provide such benefit.
> 
> > 
> > Also, what orders s->mbps update before the s->state update? I'd say we
> > should probably hold the lock around the whole total_time,mbps,state
> > update.
> 
> IMHO that's fine; mutex unlock implies a RELEASE.  See atomic.rst:
> 
> - ``pthread_mutex_lock`` has acquire semantics, ``pthread_mutex_unlock`` has
>   release semantics and synchronizes with a ``pthread_mutex_lock`` for the
>   same mutex.

Hmm perhaps I wrote too soon.. it should only guarantee the ordering of the
update on the lock variable itself v.s. any previous R&Ws, nothing else.
Only if the other side uses bql_lock() will it guarantee proper ordering.

Put them in bql should work, but I hesitate such use to start using bql
to protect state updates.

How about we drop the lock, but use an explicit smp_mb_release()?  We may
also want to use smb_load_acquire() in fill_source_migration_info() to use
on reading &s->state (all will need some comment).  To me, making sure the
total mbps is valid seems more important; while the other races are less
harmful, and may not be a major concern?

PS: logically I think smp_mb_release() is not needed either, because state
is updated using qatomic_cmpxchg(), which implies a full __ATOMIC_SEQ_CST.

> 
> > 
> > I'm not entirely sure, what do you think?
> > 
> > > See migration_update_counters() where it also updates mbps without holding
> > > a lock.
> > 
> > Here it might be less important since it's the middle of the migration,
> > there will proabably be more than one query-migrate which would see the
> > correct values.
> 
> Yep.  I queued this.
> 
> Thanks,
> 
> -- 
> Peter Xu

-- 
Peter Xu


