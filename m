Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7647DF98D
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 19:06:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyc4b-0002ah-R3; Thu, 02 Nov 2023 14:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qyc4Q-0002XN-P6
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 14:05:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qyc4O-0006VS-Pe
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 14:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698948326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QBKMTwocqj55qPJHPIAvcbzrkwaljnepMoWDnZa6fLs=;
 b=EGGehWDm0EZDjn2xLqFGqvG1dX+xaLVrZXPkup7xH/abGVckoMaUe2MSZ1FnrzxFk6Fj/c
 JCEJBrJ9exOyGc6WKqGnw3sP7EoB1kUbkrcyeLGIQnSwRZRAA8i0QgtBc9Hw7eU3gr5Mmb
 yFv1SwCh4ZJiqN75SMl6J/HcsnyC4C0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-S6CQzlq6NTinv4cGV4zA5Q-1; Thu, 02 Nov 2023 14:05:24 -0400
X-MC-Unique: S6CQzlq6NTinv4cGV4zA5Q-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7789cde7421so10616285a.1
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 11:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698948323; x=1699553123;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QBKMTwocqj55qPJHPIAvcbzrkwaljnepMoWDnZa6fLs=;
 b=mygm2s0yMJooyaE1vMz4JdXgFc9hmz6P+gYr1XKHzRfUjCh23C1ZpoykFy2IKgPE+e
 70VK6waQVq1IVYk4eQlLajbER/f1IsYyr/IxCGyfwlPvVSTP5C7HLt/CNUpnXkvyWLnF
 MRoxhtIGbN6TC2w5wngwo+IbaMvPCww8PQQB+ba14Kxx9BmJ9WA+dcgDc0ojxac81YXq
 7SR35vK01HUJIk3nEQWJNPN76duBBbQNsZoIUhseDag3nsraPPLqsZUlKs2XZr2lkGF/
 KLAj3p2NtDp0OF3JTyTptcQbbZ8kjntKNcp5Z5Wc+6jrjYqrgmXJCMtoIJPsZYkE4Asq
 G2Jw==
X-Gm-Message-State: AOJu0Yygd8MdszEjCxEWUsvrikkX+Y8YLC2VQkkcHOyLy5USf6CS/UaL
 hK1SqZkeXj7y8q3kDLUK7VORqB4rKpJByGtREJcoM0Zv0beXyafmnwHOEdlNYlxI8n+vmIg1HnQ
 JLgiLHWNPmz7PqrA=
X-Received: by 2002:a05:620a:488d:b0:76f:1846:2f6b with SMTP id
 ea13-20020a05620a488d00b0076f18462f6bmr19772365qkb.1.1698948322778; 
 Thu, 02 Nov 2023 11:05:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzo8SeH2dvnk9hKj5E4StkIeFC9sO+gE+ZES4/xaSSfA/pO+oMSbGaN6m4J5hWpH8+5XSVfw==
X-Received: by 2002:a05:620a:488d:b0:76f:1846:2f6b with SMTP id
 ea13-20020a05620a488d00b0076f18462f6bmr19772342qkb.1.1698948322466; 
 Thu, 02 Nov 2023 11:05:22 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 bj3-20020a05620a190300b00773fe8971bbsm140900qkb.90.2023.11.02.11.05.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 11:05:22 -0700 (PDT)
Date: Thu, 2 Nov 2023 14:05:19 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: Configuring migration (was: [PATCH v3 3/4] migration/qapi:
 Replace @MigrateSetParameters with @MigrationParameters)
Message-ID: <ZUPk33GUF/PvAPPo@x1n>
References: <87sf6k2dax.fsf@pond.sub.org> <ZSVoK6YMgNzrDYGQ@x1n>
 <878r8ajngg.fsf@pond.sub.org> <ZSWvYgKcGXlucXx6@x1n>
 <875y3dixzp.fsf@pond.sub.org> <8734yhgrzl.fsf@pond.sub.org>
 <ZShI4AucDGvUvJiS@x1n> <877cnrjd71.fsf@pond.sub.org>
 <87zfzz82xq.fsf@secure.mitica> <87msvw6xm2.fsf_-_@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87msvw6xm2.fsf_-_@pond.sub.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
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

On Thu, Nov 02, 2023 at 03:25:25PM +0100, Markus Armbruster wrote:
> Juan Quintela <quintela@redhat.com> writes:
> 
> > Markus Armbruster <armbru@redhat.com> wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >>
> >>> On Wed, Oct 11, 2023 at 04:21:02PM +0200, Markus Armbruster wrote:
> >
> >>> IIRC both of them used to be the goals: either allow compat properties for
> >>> old machine types, or specify migration parameters in cmdline for easier
> >>> debugging and tests.  I use "-global" in mostly every migration test script
> >>> after it's introduced.
> >>
> >> You use -global just because it's easier than using monitor commands,
> >> correct?
> >
> > It is long history.  But to make things easier I will try to resume.
> > In the beggining there was no "defer" method, so it was imposible to
> > setup migration-channels and that kind of information.
> > So we created that -global migration properties.
> >
> > Time pass, and we need to fix that for real, because more and more
> > migration parameters need to be set bofer we start incoming migration.
> > So we create migration "defer" method.  And now we can set things from
> > the command line/QMP.
> >
> > But when one is testing (i.e. migration developers), using the global
> > property is much easier.
> >
> > I am always tempted to modify the monitor command line to allow "read
> > the commands from this file at startup".
> >
> >> Configuration is almost entirely special (own QMP commands for
> >> everything), with a little abuse of general infrastructure stirred in
> >> (-global, compat props).  Having capabilities in addition to parameters
> >> is a useless complication.  Too many features of questionable utility
> >> with way too many configuration knobs.
> >
> > I also remember that one.
> > In the beggining all migration options were bools.  So we have named
> > capabilities.  At some point we needed parameters that were not bools,
> > so we had to get the parameters thing because all the migration code
> > supposed that the capabilities were bool.
> >
> > No, I am not defending the choices we made at the time, but that is how
> > it happened.
> 
> Decisions that make sense at the time can stop making sense later.
> 
> >               To be fair, when I have a new "bool" to add to migration,
> > I am never sure if I have to add it as a capability or as a parameter
> > that returns bool.
> 
> I'd be unsure, too.
> 
> 
> Migration has its own idiosyncratic configuration interface, even though
> its configuration needs are not special at all.  This is due to a long
> history of decisions that made sense at the time.
> 
> What kind of interface would we choose if we could start over now?
> 
> Let's have a look at what I consider the two most complex piece of
> configuration to date, namely block backends and QOM objects.
> 
> In both cases, configuration is a QAPI object type: BlockdevOptions and
> ObjectOptions.
> 
> The common members are the configuration common to all block backends /
> objects.  One of them is the type of block backend ("driver" in block
> parlance) or QOM object ("qom-type").
> 
> A type's variant members are the configuration specific to that type.
> 
> This is suitably expressive.
> 
> We create a state object for a given configuration object with
> blockdev-add / object-add.
> 
> For block devices, we even have a way to modify a state object's
> configuration: blockdev-reopen.  For QOM objects, there's qom-set, but I
> don't expect that to work in the general case.  Where "not work" can
> range from "does nothing" to "explodes".
> 
> Now let's try to apply this to migration.
> 
> As long as we can have just one migration, we need just one QAPI object
> to configure it.
> 
> We could create the object with -object / object_add.  For convenience,
> we'd probably want to create one with default configuration
> automatically on demand.
> 
> We could use qom-set to change configuration.  If we're not comfortable
> with using qom-set for production, we could do something like
> blockdev-reopen instead.
> 
> Could we move towards such a design?  Turn the existing ad hoc interface
> into compatibility sugar for it?

Sounds doable to me.

I'm not familiar with BlockdevOptions, it looks like something setup once
and for all for all relevant parameters need to be set in the same request?
Migration will require each cap/parameter to be set separately anytime,
e.g., the user can adjust downtime / bandwidth even during migration in
progress.

Making all caps/parameters QOM objects, or one object containing both
attributes, sounds like a good fit.  object_property_* APIs allows setters,
I think that's good enough for migration to trigger whatever needed (e.g.
migration_rate_set() updates after bandwidth modifications).

We can convert e.g. qmp set parameters into a loop of setting each
property, it'll be slightly slower because we'll need to do sanity check
for each property after each change, but that shouldn't be a hot path
anyway so seems fine.

It'l still be a pity that we still cannot reduce the triplications of qapi
docs immediately even with that.  But with that, it seems doable if we will
obsolete QMP migrate-set-parameters after we can do QOM-set.

Thanks,

-- 
Peter Xu


