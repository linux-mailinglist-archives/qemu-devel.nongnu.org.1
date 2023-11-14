Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A897EAE24
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 11:36:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2ql9-000473-Qy; Tue, 14 Nov 2023 05:35:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r2ql7-00046c-HC
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 05:35:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r2ql5-00015v-Kk
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 05:35:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699958101;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iPvaTYp6umAG9oup8+y58bUWGpXJGCojh+MB6c0YdRY=;
 b=MCEZxY0o7pMG5nJIoBy5X3Y5wRfM0kC1JK36XKL2G8+yeSSRQFzlrFjnSxDI+jQFPWYxKV
 jkW12YobdeFO+x1vVa5W6CYknfsetViI6zgjnTLCrVCK3cJ0ZdYqr47YRPxxkNpWv/TPs5
 q46PB94QznfoG0SpSsStc/z3Lhd7bKc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-Aty8uiaDMxCPm9pOtYjc5A-1; Tue,
 14 Nov 2023 05:34:57 -0500
X-MC-Unique: Aty8uiaDMxCPm9pOtYjc5A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5387529AA3A5;
 Tue, 14 Nov 2023 10:34:57 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3897036EE;
 Tue, 14 Nov 2023 10:34:56 +0000 (UTC)
Date: Tue, 14 Nov 2023 10:34:54 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: Configuring migration
Message-ID: <ZVNNTgYD2bikZVxH@redhat.com>
References: <878r8ajngg.fsf@pond.sub.org> <ZSWvYgKcGXlucXx6@x1n>
 <875y3dixzp.fsf@pond.sub.org> <8734yhgrzl.fsf@pond.sub.org>
 <ZShI4AucDGvUvJiS@x1n> <877cnrjd71.fsf@pond.sub.org>
 <87zfzz82xq.fsf@secure.mitica> <87msvw6xm2.fsf_-_@pond.sub.org>
 <ZVM5xmsaE41WJYgb@redhat.com> <87pm0cochf.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pm0cochf.fsf@secure.mitica>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Nov 14, 2023 at 11:28:28AM +0100, Juan Quintela wrote:
> Daniel P. Berrangé <berrange@redhat.com> wrote:
> > On Thu, Nov 02, 2023 at 03:25:25PM +0100, Markus Armbruster wrote:
> >> Now let's try to apply this to migration.
> >>
> >> As long as we can have just one migration, we need just one QAPI object
> >> to configure it.
> >> 
> >> We could create the object with -object / object_add.  For convenience,
> >> we'd probably want to create one with default configuration
> >> automatically on demand.
> >> 
> >> We could use qom-set to change configuration.  If we're not comfortable
> >> with using qom-set for production, we could do something like
> >> blockdev-reopen instead.
> >
> > Do we even need to do this via a QAPI object ?
> >
> > Why are we not just making the obvious design change of passing everything
> > with the 'migrate' / 'migrate-incoming' commands that kick it off:
> >
> > ie:
> >
> > { 'command': 'migrate',
> >   'data': {'uri': 'str',
> >            '*channels': [ 'MigrationChannel' ],
> > 	   '*capabilities': [ 'MigrateCapability' ],
> > 	   '*parameters': [ 'MigrateParameters' ],
> >            '*detach': 'bool', '*resume': 'bool' } }
> 
> Once that we are doing incompatible changes:

This is not incompatible - it is fully backcompatible with existing
usage initially, which should make it pretty trivial to introduce
to the code. Mgmt apps can carry on using migrate-set-capabilities
and migrate-set-parameters, and ignore these new 'capabilities'
and 'parameters' fields if desired.

Only once we decide to deprecate migrate-set-capabilities, would
it become incompatible.

> - resume can be another parameter

Potentially yes, but 'resume' is conceptually different to all
the other capabilities and parameters, so I could see it remaining
as a distinct field as it is now

> - detach is not needed.  QMP don't use it, and HMP don't need to pass it
>   to qmp_migrate() to make the non-detached implemntation.

We could deprecate that today then.

> 
> 
> >      (deprecated bits trimmed for clarity)
> >
> > and the counterpart:
> >
> > { 'command': 'migrate-incoming',
> >              'data': {'*uri': 'str',
> >                       '*channels': [ 'MigrationChannel' ],
> >                       '*capabilities': [ 'MigrateCapability' ],
> >                       '*parameters': [ 'MigrateParameters' ] } }
> >
> > such that the design is just like 99% of other commands which take
> > all their parameters directly. We already have 'migrate-set-parameters'
> > remaining for the runtime tunables, and can deprecate the usage of this
> > when migration is not already running, and similarly deprecate
> > migrate-set-capabilities.
> 
> This makes sense to me, but once that we change, we could try to merge
> capabilities and parameters.  See my other email on this topic.
> Basically the distition is arbitrary, so just have one of them.
> 
> Or better, as I said in the other email, we have two types of
> parameters:
> - the ones that need to be set before migration starts
> - the ones that can be changed at any time
> 
> So to be simpler, I think that 1st set should be passed to the commands
> themselves and the others should only be set with
> migrate_set_parameters.

As a mgmt app dev I don't want there to be an arbitrary distinction
between what I can pass with 'migrate' and what I have to use a
separate command for. If I'm starting a migration, I just want to
pass all the settings with the 'migrate' command. I should not have
to care about separate 'migrate-set-parameters' command at all, unless
I actually need to change something on the fly (many migrates will
never need this).

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


