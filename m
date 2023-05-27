Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE9F713327
	for <lists+qemu-devel@lfdr.de>; Sat, 27 May 2023 09:47:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2occ-0002E8-Mo; Sat, 27 May 2023 03:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2oca-0002E0-Fu
 for qemu-devel@nongnu.org; Sat, 27 May 2023 03:45:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2ocM-0006M9-S9
 for qemu-devel@nongnu.org; Sat, 27 May 2023 03:45:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685173537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SAwgJdzl54VJ+/wE9FNiLzQlibi4isfzw8XbIDM5RHI=;
 b=GLzHiUfJFKlK/K6s+8i/KNeppTURCsw0QfLESqmmmhwFsoAjkzh4l2oQhNPy8aK1MTujmS
 c1aCC9d4HR553MkRGt2P0l2wPZLR7VX1BByk2cvDggTawQ53ODLyPcGTWg2prWxuKK3YKf
 RCuB9Sxne1ZlQBISY3vr73bRdfTQ7JE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-T3v96A6GPcWyfROTZU5Caw-1; Sat, 27 May 2023 03:45:31 -0400
X-MC-Unique: T3v96A6GPcWyfROTZU5Caw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E63E9800B2A;
 Sat, 27 May 2023 07:45:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A20D353BB;
 Sat, 27 May 2023 07:45:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5E22621E692E; Sat, 27 May 2023 09:45:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org,  philmd@linaro.org,  wangyanan55@huawei.com,
 pbonzini@redhat.com,  thuth@redhat.com,  Peter Maydell
 <peter.maydell@linaro.org>,  =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: The madness of ad hoc special IDs
References: <20230522131717.3780533-1-imammedo@redhat.com>
 <877csz6xgd.fsf@pond.sub.org>
 <20230523145655.739f0014@imammedo.users.ipa.redhat.com>
Date: Sat, 27 May 2023 09:45:29 +0200
In-Reply-To: <20230523145655.739f0014@imammedo.users.ipa.redhat.com> (Igor
 Mammedov's message of "Tue, 23 May 2023 14:56:55 +0200")
Message-ID: <87ttvyz086.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Igor Mammedov <imammedo@redhat.com> writes:

> On Tue, 23 May 2023 14:31:30 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
>
>> Igor Mammedov <imammedo@redhat.com> writes:
>> 
>> > QEMU aborts when default RAM backend should be used (i.e. no
>> > explicit '-machine memory-backend=' specified) but user
>> > has created an object which 'id' equals to default RAM backend
>> > name used by board.
>> >
>> >  $QEMU -machine pc \
>> >        -object memory-backend-ram,id=pc.ram,size=4294967296
>> >
>> >  Actual results:
>> >  QEMU 7.2.0 monitor - type 'help' for more information
>> >  (qemu) Unexpected error in object_property_try_add() at ../qom/object.c:1239:
>> >  qemu-kvm: attempt to add duplicate property 'pc.ram' to object (type 'container')
>> >  Aborted (core dumped)
>> >
>> > Instead of abort, check for the conflicting 'id' and exit with
>> > an error, suggesting how to remedy the issue.  
>> 
>> This is an instance of an (unfortunately common) anti-pattern.
>> 
>> The point of an ID is to *identify*.  To do that, IDs of the same kind
>> must be unique.  "Of the same kind" because we let different kinds of
>> objects have the same ID[*].
>> 
>> IDs are arbitrary strings.  The user may pick any ID, as long as it's
>> unique.  Unique not only among the user's IDs, but the system's, too.
>> 
>> Every time we add code that picks an ID, we break backward
>> compatibility: user configurations that use this ID no longer work.
>> Thus, system-picked IDs are part of the external interface.
>
> in this case, IDs are there to keep backward compatibility
> (so migration won't fail) and it affects only default (legacy**)
> path where user doesn't provide memory-backend explicitly
> (which could be named anything that doesn't collide with other objects)
>
>> We don't treat them as such.  They are pretty much undocumented, and
>> when we add new ones, we break the external interface silently.
>
> this ID in particular is introspect-able (a part of qmp_query_machines output)
> to help mgmt pick backward compatible ID when switching to explicit
> RAM backend CLI (current libvirt behaviour).
>
>> How exactly things go wrong on a clash is detail from an interface
>> design point of view.  This patch changes one instance from "crash" to
>> "fatal error".  No objections, just pointing out we're playing whack a
>> mole there.
>> 
>> The fundamental mistake we made was not reserving IDs for the system's
>> own use.
>> 
>> The excuse I heard back then was that IDs are for the user, and the
>> system isn't supposed to pick any.  Well, it does.
>> 
>> To stop creating more moles, we need to reserve IDs for the system's
>> use, and let the system pick only reserved IDs going forward.
>> 
>> There would be two kinds of reserved IDs: 1. an easily documented,
>> easily checked ID pattern, e.g. "starts with <prefix>", to be used by
>> the system going forward, and 2. the messy zoo of system IDs we have
>> accumulated so far.
>> 
>> Thoughts?
>
> I'd vote for #1 only, however that isn't an option
> as renaming existing internal IDs will for sure break backward compat.

Yes.  Reducing the zoo by dropping and/or renaming IDs would be slow and
painful at best.

> So perhaps a mix of #1 (for all new internal IDs) and #2 for
> legacy ones, with some centralized place to keep track of them.

Yes, this is what I had in mind.

Action items:

1. Reserve ID name space for the system's use

1.a. Document

1.b. Stop letting users use reserved IDs

     Either deprecate & warn for a while, then reject, or reject right
     away.

2. Grandfather existing system-picked IDs

   The ones we care to track down we can document as reserved.

   The others we'll have to hand-wave.

Makes sense?

>> [...]
>> 
>> 
>> [*] Questionable idea if you ask me, but tangential to the point I'm
>> trying to make in this memo.
>> 
>
> [**] If it were up to me, I'd drop implicit RAM backend creation
> and require explicit backend being provided on CLI by user
> instead of making thing up for the sake of convenience.
> (If there is a support in favor of this, I'll gladly post a patch)

I lack the expertise to advise on this.


