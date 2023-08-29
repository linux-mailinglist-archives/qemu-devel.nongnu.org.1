Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CBD78CFE3
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:07:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7mq-0000h6-SS; Tue, 29 Aug 2023 19:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qb3RE-0005gu-FS
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:27:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qb3RC-0005lO-3a
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:27:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693333656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ffeshed3PoIpheesov9LZI2N80G130mS40fJordo9cg=;
 b=d6tJbFXSGoDfYGhMFvud1UlN58vHsnO22UmVZy1jc39dXmfzCaBMQLKOle3E5rxetiXlYj
 1vIPcuZszbN1cPbGfQymEg+P6KZ8n3ytYpPm5IAl4gzumH9B6JfGLhxmt74aqYaaHEQM6e
 n7Me2g9D0afOo8IMeRd9RiKoLDXuyJM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-gfcp3zvUNOCwF_Zdlporyg-1; Tue, 29 Aug 2023 14:27:35 -0400
X-MC-Unique: gfcp3zvUNOCwF_Zdlporyg-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-411f4a7ddbdso13871911cf.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 11:27:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693333654; x=1693938454;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ffeshed3PoIpheesov9LZI2N80G130mS40fJordo9cg=;
 b=ESsKSrO7mZEp2JI1JLOG8Tft89bS6qZg5JB9iQP659ZDed8f9zuOOfPkXOmrHeyhHD
 Jyygct0CP2Z+kJ3U/7JBCRIHf5x54LQei1z2Lr2hv14IHLgdD3YnfmMJUuvRpd5bTnar
 jQdFPRWfyA3G4ijRxdDuV7tIemedWHooGYJ6MTMlarV9BJkuqKQapUHblsYQ559iNZ4M
 +aAWCcpW6gbmc1RkMsYBKjthT4ZACkj7Sa5mKJCzwCLmL3xjy6XUsyBIPO7k57LMv70R
 pQTip/4yYv9SwVXCzEI3aCIXjOwMXRTp9XwRcV0wFJ47+f/COe4wdhXPp9ra+fSR4P4N
 Eoew==
X-Gm-Message-State: AOJu0YwhLLAkHMTSrSa4lS0j/htdErzGNo/ayyGrsjdOXUq98iAwfo56
 T3IA9ctkn8WLL71n3YS09a0kQNdm0tOut5PeynV6uq1dPm9FqyS3u9In820J3xzUyRXEvRe+Nvf
 p9uGU9+7N7cRgcCE=
X-Received: by 2002:ac8:7f07:0:b0:410:839d:942f with SMTP id
 f7-20020ac87f07000000b00410839d942fmr35065392qtk.6.1693333654595; 
 Tue, 29 Aug 2023 11:27:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvQ72miyO8ge2SfXl6q3l4HbcHM3t7rGW5nzIf0/zROF8jlBpP0HHN0MQ4Tu/HqhXrO3Mqew==
X-Received: by 2002:ac8:7f07:0:b0:410:839d:942f with SMTP id
 f7-20020ac87f07000000b00410839d942fmr35065381qtk.6.1693333654297; 
 Tue, 29 Aug 2023 11:27:34 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 f23-20020a05620a12f700b0076ef0fb5050sm3275513qkl.31.2023.08.29.11.27.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 11:27:32 -0700 (PDT)
Date: Tue, 29 Aug 2023 14:27:30 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Yanghang Liu <yanghliu@redhat.com>
Subject: Re: [PATCH 5/6] vfio/migration: Block VFIO migration with postcopy
 migration
Message-ID: <ZO44klknC6hpd7mf@x1n>
References: <20230828151842.11303-1-avihaih@nvidia.com>
 <20230828151842.11303-6-avihaih@nvidia.com> <ZO4GTnuqSORbvePL@x1n>
 <b54f3ca5-9236-84a8-1b1f-9365925fa458@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b54f3ca5-9236-84a8-1b1f-9365925fa458@nvidia.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Aug 29, 2023 at 07:20:47PM +0300, Avihai Horon wrote:
> 
> On 29/08/2023 17:53, Peter Xu wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Mon, Aug 28, 2023 at 06:18:41PM +0300, Avihai Horon wrote:
> > > diff --git a/migration/options.c b/migration/options.c
> > > index 1d1e1321b0..e201053563 100644
> > > --- a/migration/options.c
> > > +++ b/migration/options.c
> > > @@ -499,6 +499,11 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
> > >               error_setg(errp, "Postcopy is not yet compatible with multifd");
> > >               return false;
> > >           }
> > > +
> > > +        if (migration_vfio_mig_active()) {
> > > +            error_setg(errp, "Postcopy is not compatible with VFIO migration");
> > > +            return false;
> > > +        }
> > Hmm.. this will add yet another vfio hard-coded line into migration/..
> > 
> > What will happen if the vfio device is hot plugged after enabling
> > postcopy-ram here?
> 
> In that case a migration blocker will be added.
> 
> > 
> > Is it possible to do it in a generic way?
> 
> What comes to my mind is to let devices register a handler for a "caps
> change" notification and allow them to object.
> But maybe that's a bit of an overkill.

This one also sounds better than hard-codes to me.

> 
> > 
> > I was thinking the only unified place to do such check is when migration
> > starts, as long as we switch to SETUP all caps are locked and doesn't allow
> > any change until it finishes or fails.
> > 
> > So, can we do this check inside vfio_save_setup(), allow vfio_save_setup()
> > to fail the whole migration early?  For example, maybe we should have an
> > Error** passed in, then if it fails it calls migrate_set_error, so
> > reflected in query-migrate later too.
> 
> Yes, I think this could work and it will simplify things because we could
> also drop the VFIO migration blockers code.
> The downside is that the user will know migration is blocked only when he
> tries to migrate, and migrate_caps_check() will not block setting postcopy
> when a VFIO device is already attached.
> I don't have a strong opinion here, so if it's fine by you and everyone
> else, I could change that to what you suggested.

Failing later would be fine in this case to me; my expectation is VFIO
users should be advanced already anyway (as the whole solution is still
pretty involved comparing to a generic VM migration) and shouldn't try to
trigger that at all in real life.  IOW I'd expect this check will be there
just for sanity, rather than being relied on to let people be aware of it
by the error message.

Meanwhile the blocker + caps check is slightly complicated to me to guard
both sides.  So I'd vote for failing at the QMP command.  But we can wait
and see whether there's other votes.

Thanks,

-- 
Peter Xu


