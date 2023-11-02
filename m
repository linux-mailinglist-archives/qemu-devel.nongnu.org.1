Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F347DF4E3
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 15:26:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyYda-0005U0-08; Thu, 02 Nov 2023 10:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qyYdY-0005Sw-3f
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 10:25:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qyYdW-0006qW-7l
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 10:25:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698935128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZruysNYiW5kjOO84rQGiRez4WN8ZN6SUOBtXT+edmxE=;
 b=fjQDa+sqtpHHbuPKpZuNSgvjQUW6ZhtMTbi8v5IjAZyjsmChrzvAL9G7/qmtoYY9K0StOU
 uGIkr7k1kxuRYQoYDEKQEel3RPVdwTMRQ7McWDV4bq4uQQ9hy/eJwYhiGaah5eTAHUKEZa
 9YholEc4P9DDloMkWDpYC1/uPISuRkE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-lxJkK8pcOJOlCXF8a-ZtfQ-1; Thu, 02 Nov 2023 10:25:26 -0400
X-MC-Unique: lxJkK8pcOJOlCXF8a-ZtfQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4BBAF101A53B;
 Thu,  2 Nov 2023 14:25:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D1BC25C0;
 Thu,  2 Nov 2023 14:25:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 170C021E6A1F; Thu,  2 Nov 2023 15:25:25 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: Peter Xu <peterx@redhat.com>,  qemu-devel@nongnu.org,  Fabiano Rosas
 <farosas@suse.de>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Thomas Huth
 <thuth@redhat.com>
Subject: Configuring migration (was: [PATCH v3 3/4] migration/qapi: Replace
 @MigrateSetParameters with @MigrationParameters)
References: <20230905162335.235619-1-peterx@redhat.com>
 <20230905162335.235619-4-peterx@redhat.com>
 <87fs30is78.fsf@pond.sub.org> <ZRsff7Lmy7TnggK9@x1n>
 <87sf6k2dax.fsf@pond.sub.org> <ZSVoK6YMgNzrDYGQ@x1n>
 <878r8ajngg.fsf@pond.sub.org> <ZSWvYgKcGXlucXx6@x1n>
 <875y3dixzp.fsf@pond.sub.org> <8734yhgrzl.fsf@pond.sub.org>
 <ZShI4AucDGvUvJiS@x1n> <877cnrjd71.fsf@pond.sub.org>
 <87zfzz82xq.fsf@secure.mitica>
Date: Thu, 02 Nov 2023 15:25:25 +0100
In-Reply-To: <87zfzz82xq.fsf@secure.mitica> (Juan Quintela's message of "Tue, 
 31 Oct 2023 12:08:17 +0100")
Message-ID: <87msvw6xm2.fsf_-_@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Juan Quintela <quintela@redhat.com> writes:

> Markus Armbruster <armbru@redhat.com> wrote:
>> Peter Xu <peterx@redhat.com> writes:
>>
>>> On Wed, Oct 11, 2023 at 04:21:02PM +0200, Markus Armbruster wrote:
>
>>> IIRC both of them used to be the goals: either allow compat properties for
>>> old machine types, or specify migration parameters in cmdline for easier
>>> debugging and tests.  I use "-global" in mostly every migration test script
>>> after it's introduced.
>>
>> You use -global just because it's easier than using monitor commands,
>> correct?
>
> It is long history.  But to make things easier I will try to resume.
> In the beggining there was no "defer" method, so it was imposible to
> setup migration-channels and that kind of information.
> So we created that -global migration properties.
>
> Time pass, and we need to fix that for real, because more and more
> migration parameters need to be set bofer we start incoming migration.
> So we create migration "defer" method.  And now we can set things from
> the command line/QMP.
>
> But when one is testing (i.e. migration developers), using the global
> property is much easier.
>
> I am always tempted to modify the monitor command line to allow "read
> the commands from this file at startup".
>
>> Configuration is almost entirely special (own QMP commands for
>> everything), with a little abuse of general infrastructure stirred in
>> (-global, compat props).  Having capabilities in addition to parameters
>> is a useless complication.  Too many features of questionable utility
>> with way too many configuration knobs.
>
> I also remember that one.
> In the beggining all migration options were bools.  So we have named
> capabilities.  At some point we needed parameters that were not bools,
> so we had to get the parameters thing because all the migration code
> supposed that the capabilities were bool.
>
> No, I am not defending the choices we made at the time, but that is how
> it happened.

Decisions that make sense at the time can stop making sense later.

>               To be fair, when I have a new "bool" to add to migration,
> I am never sure if I have to add it as a capability or as a parameter
> that returns bool.

I'd be unsure, too.


Migration has its own idiosyncratic configuration interface, even though
its configuration needs are not special at all.  This is due to a long
history of decisions that made sense at the time.

What kind of interface would we choose if we could start over now?

Let's have a look at what I consider the two most complex piece of
configuration to date, namely block backends and QOM objects.

In both cases, configuration is a QAPI object type: BlockdevOptions and
ObjectOptions.

The common members are the configuration common to all block backends /
objects.  One of them is the type of block backend ("driver" in block
parlance) or QOM object ("qom-type").

A type's variant members are the configuration specific to that type.

This is suitably expressive.

We create a state object for a given configuration object with
blockdev-add / object-add.

For block devices, we even have a way to modify a state object's
configuration: blockdev-reopen.  For QOM objects, there's qom-set, but I
don't expect that to work in the general case.  Where "not work" can
range from "does nothing" to "explodes".

Now let's try to apply this to migration.

As long as we can have just one migration, we need just one QAPI object
to configure it.

We could create the object with -object / object_add.  For convenience,
we'd probably want to create one with default configuration
automatically on demand.

We could use qom-set to change configuration.  If we're not comfortable
with using qom-set for production, we could do something like
blockdev-reopen instead.


Could we move towards such a design?  Turn the existing ad hoc interface
into compatibility sugar for it?


