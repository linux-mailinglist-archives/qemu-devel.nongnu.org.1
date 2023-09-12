Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8728679D9EF
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 22:16:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg9nM-00043E-OQ; Tue, 12 Sep 2023 16:15:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qg9nI-00041l-Ij
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 16:15:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qg9nG-0003wO-0Q
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 16:15:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694549727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MZh2aFobc/12C3oOL4aOgfTqS83j8pOUXDNS6OLJddw=;
 b=GMoBPUNHFhII9nrvbSBSufnCHFdWlycqn8/kVAN9pz13hLsuG05FX1awc27EUwKocoS/L+
 XHnmzAGkYqRNZvg30Btm/8fSFjtIsqscb5echrwc4M+uViNA66/1C+yE+qEtiiCDKzMEJk
 J7AsafUzD8MLOWtkgQvB9bliCIyRBfc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-lxUyneP3OgeVP7_wMxNFyQ-1; Tue, 12 Sep 2023 16:15:25 -0400
X-MC-Unique: lxUyneP3OgeVP7_wMxNFyQ-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-414e9f38bc9so16734571cf.1
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 13:15:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694549725; x=1695154525;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MZh2aFobc/12C3oOL4aOgfTqS83j8pOUXDNS6OLJddw=;
 b=o1O6UR2057hX3lkOhcu8NNY/oiCJ2pJhdHColi0F/QbEwsHPtKfnJnQKZ30seFGvoC
 DO+acUlGwBg8iKyeCPqaad8ELNKsGTtg+SSHAfjyzliNntC5n5zS0EOBk2bHNWoRZYaT
 JS8n0ATmRSWwjI3mzQEBOWUqE7beK+b2q4a369iI9uqzmmuKj5otU70Jrg1M+7WwLR/R
 DigMmMr4PdLOG2kQTPo5njR8MXmYyLzKvLcm9jNBaIaU+S91OXQ52+OY3In5XT2Lywn4
 0HEclzN+LijyHrL/xUlqZqAyDIxt+F7RgNrqmpL0HSsErr3UOzPVuWcJjsVu95FrtL0w
 dOow==
X-Gm-Message-State: AOJu0YxrKa8PO0ibCEnLAzNN677MFYyPRMd3eFGuiv7lyIjL1zYj8Tnl
 08K+OFKV0tLPmLBlQ6DAtrbbdRp7wX5CEj8sVnihO8n8HFxg2hSNZeqAMZ45wqigTTYSjzqBrU1
 XTly+OJL59tvcEnU=
X-Received: by 2002:ac8:5744:0:b0:412:d46:a8df with SMTP id
 4-20020ac85744000000b004120d46a8dfmr472526qtx.1.1694549724953; 
 Tue, 12 Sep 2023 13:15:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0eUM9crI+K45N6kDY8DtCSjxcjO1dOsW79thQnr+gPuFw7T9NjqUPr4YWETMow6PGIdSbyQ==
X-Received: by 2002:ac8:5744:0:b0:412:d46:a8df with SMTP id
 4-20020ac85744000000b004120d46a8dfmr472509qtx.1.1694549724598; 
 Tue, 12 Sep 2023 13:15:24 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 x18-20020ac86b52000000b004109d386323sm3490504qts.66.2023.09.12.13.15.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 13:15:24 -0700 (PDT)
Date: Tue, 12 Sep 2023 16:14:57 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH 2/9] migration: Let migrate_set_error() take ownership
Message-ID: <ZQDGwVh+czaI09d6@x1n>
References: <20230829214235.69309-1-peterx@redhat.com>
 <20230829214235.69309-3-peterx@redhat.com> <87cyynkwo1.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87cyynkwo1.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URG_BIZ=0.573 autolearn=no autolearn_force=no
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

On Tue, Sep 12, 2023 at 04:40:14PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > migrate_set_error() used one error_copy() so it always copy an error.
> > However that's not the major use case - the major use case is one would
> > like to pass the error to migrate_set_error() without further touching the
> > error.
> >
> > It can be proved if we see most of the callers are freeing the error
> > explicitly right afterwards.  There're a few outliers (only if when the
> > caller) where we can use error_copy() explicitly there.
> >
> > Reviewed-by: Fabiano Rosas <farosas@suse.de>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/migration.h    |  4 ++--
> >  migration/channel.c      |  1 -
> >  migration/migration.c    | 22 ++++++++++++++++------
> >  migration/multifd.c      | 10 ++++------
> >  migration/postcopy-ram.c |  1 -
> >  migration/ram.c          |  1 -
> >  6 files changed, 22 insertions(+), 17 deletions(-)
> >
> > diff --git a/migration/migration.h b/migration/migration.h
> > index 6eea18db36..76e35a5ecf 100644
> > --- a/migration/migration.h
> > +++ b/migration/migration.h
> > @@ -465,7 +465,7 @@ bool  migration_has_all_channels(void);
> >  
> >  uint64_t migrate_max_downtime(void);
> >  
> > -void migrate_set_error(MigrationState *s, const Error *error);
> > +void migrate_set_error(MigrationState *s, Error *error);
> >  
> >  void migrate_fd_connect(MigrationState *s, Error *error_in);
> >  
> > @@ -510,7 +510,7 @@ int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque);
> >  void migration_make_urgent_request(void);
> >  void migration_consume_urgent_request(void);
> >  bool migration_rate_limit(void);
> > -void migration_cancel(const Error *error);
> > +void migration_cancel(Error *error);
> >  
> >  void populate_vfio_info(MigrationInfo *info);
> >  void reset_vfio_bytes_transferred(void);
> > diff --git a/migration/channel.c b/migration/channel.c
> > index ca3319a309..48b3f6abd6 100644
> > --- a/migration/channel.c
> > +++ b/migration/channel.c
> > @@ -90,7 +90,6 @@ void migration_channel_connect(MigrationState *s,
> >          }
> >      }
> >      migrate_fd_connect(s, error);
> > -    error_free(error);
> >  }
> >  
> >  
> > diff --git a/migration/migration.c b/migration/migration.c
> > index c60064d48e..0f3ca168ed 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -162,7 +162,7 @@ void migration_object_init(void)
> >      dirty_bitmap_mig_init();
> >  }
> >  
> > -void migration_cancel(const Error *error)
> > +void migration_cancel(Error *error)
> >  {
> >      if (error) {
> >          migrate_set_error(current_migration, error);
> > @@ -1218,11 +1218,22 @@ static void migrate_fd_cleanup_bh(void *opaque)
> >      object_unref(OBJECT(s));
> >  }
> >  
> > -void migrate_set_error(MigrationState *s, const Error *error)
> > +/*
> > + * Set error for current migration state.  The `error' ownership will be
> > + * moved from the caller to MigrationState, so the caller doesn't need to
> > + * free the error.
> > + *
> > + * If the caller still needs to reference the `error' passed in, one should
> > + * use error_copy() explicitly.
> > + */
> > +void migrate_set_error(MigrationState *s, Error *error)
> >  {
> >      QEMU_LOCK_GUARD(&s->error_mutex);
> >      if (!s->error) {
> > -        s->error = error_copy(error);
> > +        /* Record the first error triggered */
> > +        s->error = error;
> > +    } else {
> > +        error_free(error);
> 
> This will conflict logically with 908927db28 ("migration: Update error
> description whenever migration fails") which does:
> 
> +            migrate_set_error(s, local_err);
> +            error_report_err(local_err);
> 
> both functions may now try to free the error.

Indeed, thanks for spotting this.  Perhaps I should just drop the
error_report_err() if we've set the error already anyway.

> 
> 
> I'm working on top of this series to try to get rid of all of those
> qemu_file_set_error() we have. I'm trying to use migrate_set_error()
> whenever possible and only set f->last_error at the very bottom IO
> functions.

I'll read when it comes.

-- 
Peter Xu


