Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBD47EAAE7
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 08:29:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2npr-0001Ut-G8; Tue, 14 Nov 2023 02:27:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r2npl-0001Ub-1a
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 02:27:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r2nph-0001BB-S5
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 02:27:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699946855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UXyEsAe5/p27gMsUmjRUyLgK169u336Qd7Wja72A0KM=;
 b=KyeI4/Kc4sQM9XI8gPJRv56hxhsLkvPBbwzgr0dPBwSNso8rYmbKWxOILb1AEYZKkUqApt
 Llmt0f4H+bE/29AAdw0SSbwYLbInXg4JmjMRSIsI41jAxK6aFsPg5Po4N4+FFTdZoHKLQY
 wwaNZxUfR+gILhp6IoksvZqwLWy+bZc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-NcXkfnLLPla6kuKSDuz6ZQ-1; Tue, 14 Nov 2023 02:27:33 -0500
X-MC-Unique: NcXkfnLLPla6kuKSDuz6ZQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 339BC811E7B;
 Tue, 14 Nov 2023 07:27:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E9BFC502E;
 Tue, 14 Nov 2023 07:27:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D5A1021E6A1F; Tue, 14 Nov 2023 08:27:31 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>,  qemu-devel@nongnu.org,  Fabiano
 Rosas <farosas@suse.de>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Thomas Huth
 <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Configuring migration
References: <87sf6k2dax.fsf@pond.sub.org> <ZSVoK6YMgNzrDYGQ@x1n>
 <878r8ajngg.fsf@pond.sub.org> <ZSWvYgKcGXlucXx6@x1n>
 <875y3dixzp.fsf@pond.sub.org> <8734yhgrzl.fsf@pond.sub.org>
 <ZShI4AucDGvUvJiS@x1n> <877cnrjd71.fsf@pond.sub.org>
 <87zfzz82xq.fsf@secure.mitica> <87msvw6xm2.fsf_-_@pond.sub.org>
 <ZUPk33GUF/PvAPPo@x1n>
Date: Tue, 14 Nov 2023 08:27:31 +0100
In-Reply-To: <ZUPk33GUF/PvAPPo@x1n> (Peter Xu's message of "Thu, 2 Nov 2023
 14:05:19 -0400")
Message-ID: <875y24iyl8.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Cc: Paolo for QOM expertise.

Peter Xu <peterx@redhat.com> writes:

> On Thu, Nov 02, 2023 at 03:25:25PM +0100, Markus Armbruster wrote:

[...]

>> Migration has its own idiosyncratic configuration interface, even though
>> its configuration needs are not special at all.  This is due to a long
>> history of decisions that made sense at the time.
>> 
>> What kind of interface would we choose if we could start over now?
>> 
>> Let's have a look at what I consider the two most complex piece of
>> configuration to date, namely block backends and QOM objects.
>> 
>> In both cases, configuration is a QAPI object type: BlockdevOptions and
>> ObjectOptions.
>> 
>> The common members are the configuration common to all block backends /
>> objects.  One of them is the type of block backend ("driver" in block
>> parlance) or QOM object ("qom-type").
>> 
>> A type's variant members are the configuration specific to that type.
>> 
>> This is suitably expressive.
>> 
>> We create a state object for a given configuration object with
>> blockdev-add / object-add.
>> 
>> For block devices, we even have a way to modify a state object's
>> configuration: blockdev-reopen.  For QOM objects, there's qom-set, but I
>> don't expect that to work in the general case.  Where "not work" can
>> range from "does nothing" to "explodes".
>> 
>> Now let's try to apply this to migration.
>> 
>> As long as we can have just one migration, we need just one QAPI object
>> to configure it.
>> 
>> We could create the object with -object / object_add.  For convenience,
>> we'd probably want to create one with default configuration
>> automatically on demand.
>> 
>> We could use qom-set to change configuration.  If we're not comfortable
>> with using qom-set for production, we could do something like
>> blockdev-reopen instead.
>> 
>> Could we move towards such a design?  Turn the existing ad hoc interface
>> into compatibility sugar for it?
>
> Sounds doable to me.
>
> I'm not familiar with BlockdevOptions, it looks like something setup once
> and for all for all relevant parameters need to be set in the same request?

Yes, but you can "reopen", which replaces the entire configuration.

blockdev-add creates a new block backend device, and blockdev-reopen
reopens a set of existing ones.  Both take the same arguments for each
device.

> Migration will require each cap/parameter to be set separately anytime,
> e.g., the user can adjust downtime / bandwidth even during migration in
> progress.

"Replace entire configuration" isn't a good fit then, because users
would have to repeat the entire configuration just to tweak one thing.

> Making all caps/parameters QOM objects, or one object containing both
> attributes, sounds like a good fit.  object_property_* APIs allows setters,
> I think that's good enough for migration to trigger whatever needed (e.g.
> migration_rate_set() updates after bandwidth modifications).
>
> We can convert e.g. qmp set parameters into a loop of setting each
> property, it'll be slightly slower because we'll need to do sanity check
> for each property after each change, but that shouldn't be a hot path
> anyway so seems fine.

I figure doing initial configuration in one command is convenient.  The
obvious existing command for that is object-add.

The obvious interface for modifying configuration is a command to change
just one parameter.  The obvious existing command for that is qom-set.

Problem: qom-set is a death trap in general.  It can modify any QOM
property with a setter, and we test basically none of them.  Using it
for modifying migration configuration would signal it's okay to use
elsewhere, too.  I'm not sure we want to send that message.  Maybe we
want to do the opposite, and make it an unstable interface.

Aside: I believe the root problem is our failure to tie "can write" to
the object's state.  Just because a property can be set with object-add
doesn't mean it can be validly changed at any time during the object's
life.

Problem: when several parameters together have to satisfy constraints,
going from one valid configuration to another valid configuration may
require changing several parameters at once, or else go through invalid
intermediate configurations.

This problem is not at all specific to the migration object.

One solution is careful design to ensure that there's always a sequence
of transitions through valid configuration.  Can become complicated as
configuration evolves.  Possible even impractical or impossible.

Another solution is a command to modify multiple parameters together,
leaving alone the others (unlike blockdev-reopen, which overwrites all
of them).

> It'l still be a pity that we still cannot reduce the triplications of qapi
> docs immediately even with that.  But with that, it seems doable if we will
> obsolete QMP migrate-set-parameters after we can do QOM-set.

Yes.


