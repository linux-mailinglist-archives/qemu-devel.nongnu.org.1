Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA837D2D90
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 11:03:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quqos-0006xv-Uf; Mon, 23 Oct 2023 05:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1quqor-0006xK-0l
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 05:01:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1quqop-0007IF-2v
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 05:01:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698051708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mi7FgVo+iRm4mw3RKsvYzsu8ywMmB+4deJxtNMszD1A=;
 b=QJFbBrAtGKOlo2iK1ABHpyXmk8FXPDiYMG6rjHbliq4frfkClCWFdc4MJ7IbB+t/yucILS
 GgfpsjnKyJBBwItwq+qNG41yHW7wzS75cmWLTZuFiQ0UhS9eSeyYIZINmL3ARWvvjxeGaL
 QVwvq4XC8GCv+DxGXOSypfRd554yLTM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-444-W-thhzu2M7aVy9gsZDVa6Q-1; Mon, 23 Oct 2023 05:01:45 -0400
X-MC-Unique: W-thhzu2M7aVy9gsZDVa6Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 75E0F3C176E7;
 Mon, 23 Oct 2023 09:01:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3645E2166B26;
 Mon, 23 Oct 2023 09:01:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3F10321E6A1F; Mon, 23 Oct 2023 11:01:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,  qemu-devel@nongnu.org,
 prerna.saxena@nutanix.com,  dgilbert@redhat.com,  pbonzini@redhat.com,
 eblake@redhat.com,  manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com,  Het Gala <het.gala@nutanix.com>,  Juan
 Quintela <quintela@redhat.com>,  Peter Xu <peterx@redhat.com>,  Leonardo
 Bras <leobras@redhat.com>
Subject: Should we replace QAPI? (was: [PATCH v14 02/14] fixup! migration:
 New QAPI type 'MigrateAddress')
References: <20231019192353.31500-1-farosas@suse.de>
 <20231019192353.31500-3-farosas@suse.de> <87y1fxc27m.fsf@pond.sub.org>
 <87wmvhh4zm.fsf@suse.de> <87o7gt1ncz.fsf@pond.sub.org>
 <ZTKBIUEayhIOshcD@redhat.com>
Date: Mon, 23 Oct 2023 11:01:43 +0200
In-Reply-To: <ZTKBIUEayhIOshcD@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Fri, 20 Oct 2023 14:31:13 +0100")
Message-ID: <87h6mhr9u0.fsf_-_@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ONE_TIME=0.714, PLING_QUERY=0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Oct 20, 2023 at 02:37:16PM +0200, Markus Armbruster wrote:
>> Fabiano Rosas <farosas@suse.de> writes:
>>=20
>> > Markus Armbruster <armbru@redhat.com> writes:
>> >
>> >> Fabiano Rosas <farosas@suse.de> writes:
>> >>
>> >>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> >
>> > Side question: are we using valid JSON at all? I threw this in a random
>> > online linter and it complains about the single quotes. We could have a
>> > proper tool doing the validation in CI.
>>=20
>> You've come a sad, sad place.
>>=20
>> docs/devel/qapi-code-gen.rst:
>>=20
>>     Schema syntax
>>     -------------
>>=20
>>     Syntax is loosely based on `JSON <http://www.ietf.org/rfc/rfc8259.tx=
t>`_.
>>     Differences:
>>=20
>>     * Comments: start with a hash character (``#``) that is not part of a
>>       string, and extend to the end of the line.
>>=20
>>     * Strings are enclosed in ``'single quotes'``, not ``"double quotes"=
``.
>>=20
>>     * Strings are restricted to printable ASCII, and escape sequences to
>>       just ``\\``.
>>=20
>>     * Numbers and ``null`` are not supported.
>>=20
>> If your reaction to item 2 is "this is stupid", you'd be exactly right.
>>=20
>> Here's the conclusion of a discussion on possible improvements we had in
>> 2020:
>> https://lore.kernel.org/qemu-devel/877dt5ofoi.fsf@dusky.pond.sub.org/
>
> Looking at those options again I so strongly want to be able to
> say "none of the above".
>
> We have a need to describe data structures, and generate code for
> serializing/deserializing them on the wire. We created a language
> for this and wrote our own C code generator, our own docs generator,
> own our json parser & formatter, and now are also writing our own
> Go code generator (Python, Rust too ?).
>
> IMHO this is way too much NiH for my likely, and creates a maint
> burden for ourselves that we could do without.
>
> <open-can-of-worms>
> At the point in time we invented QAPI this was perhaps justifiable,
> though even back then I thought we should have done a binary format
> and used XDR to describe it, as a standard pre-existing language and
> toolset.

Path dependence...

I wasn't involved in the decisions that led to QAPI, nor its initial
design and implementation.

Its design was substantially constrained by QMP, which predates QAPI by
almost two years.  I was involved in QMP's design for a bit.  We argued
back and forth, and I eventually stepped aside to let the guys doing the
actual work make the decisions.

QAPI was further constrained by the desire to use it with QOM.  The two
are joined at the hip by visitors.  Nevertheless, QOM and QAPI are
integrated poorly.

My general attitude towards generating source code is "don't; use a more
powerful programming language".  Instead of creating yet another pillar
supporting Greenspun's Tenth Rule, I feel we should have embedded a
sufficiently powerful programming language, and used it for the control
plane.  My choice would've been Lisp.

The maintenance burden is modest, but real.  The QAPI generator has
gotten ~1.6 patches per week for the last five years, trending down.  In
the last year, it's been 68 patches, 437 insertions, 338 deletions
total, much of it in docs/devel/qapi-code-gen.rst.  Meanwhile, the
entire project has had 130 times as many patches, 620 times as many
insertions, and 400 times as many deletions.

QAPI infrastructure maintenance is dwarved several times over by QAPI
schema maintenance.  Chiefly patch review.

To be fair, adding language bindings will take a non-trivial one time
investment plus ongoing maintenance for each language.

> Today I wouldn't suggest XDR, but would be inclined to suggest
> Protobuf. This already has code & docs generators for every
> programming language we would ever need.
>
> Protobuf has a defined serialization format too though which is
> binary based IIUC, so distinct from our JSON wire format.
>
> The interesting question though is whether it would be feasible to
> transition to this today, despite our historical baggage ? With
> recent interest in accessing QAPI for many more languages, it

Go, Rust, and what else?

> is timely to consider if we can adopt a standardized toolset to
> reduce this burden of talking to QEMU from other languages.
>
> A transition would need several big ticket items
>
>  * A QAPI visitor impl that can spit out the protobuf document.
>    ie to translate all our existing QAPI formats into protobuf,
>    as doing this manually would be madness. This is probably
>    the easy bit.

This is about machine-assisted translation of the QAPI schema to
protobuf, isn't it?

>  * A custom protobuf visitor impl that can spit out C code
>    that has the same API as our QAPI C generator. ie so we can
>    avoid a big bang to convert all of QEMU internals. I suspect
>    this is quite alot of work.

The alternative is a big bang to convert, which could be less work or
more.

>  * A custom protobuf serializer compatible with our current
>    JSON format. ie so that QEMU can continue to expose the
>    current QMP protocol to apps for legacy compat for some
>    period of time, while also exposing a new native binary
>    protobuf protocol for future usage. Also probably quite
>    alot of work.

No alternative.

> That's all certainly quite alot of work and probably things I have
> forgotten.

QOM's use of QAPI might add problems.

>            Above all it does assume it is possible to define a
> loss-less mapping from QAPI -> Protobuf language. I've not proved
> this is possible, but my inclination is that it probably should be,
> and if not, we could likely enable it by strategically deprecated
> and then deleting troublesome bits prior to a conversion.
> </open-can-of-worms>

While I share your distaste for the massive NIH QAPI has become, I'm not
sure replacing it now is economical.  It requires a massive one-time
investment, offset by saving us one-time investments into QAPI bindings
for other languages of interest.  Whether it can actually reduce ongoing
maintenance appreciably after the replacement is unclear.

Pretty much the same for QOM.


