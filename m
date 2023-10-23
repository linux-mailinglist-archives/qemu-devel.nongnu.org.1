Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 368377D3656
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 14:21:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qutv7-00055a-Kq; Mon, 23 Oct 2023 08:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qutv3-00052Q-Um
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 08:20:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qutuv-00062M-Ia
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 08:20:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698063620;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fnzNXiWLDv7ylhgL/fLLFDEJj0ulw28+W2ZEyDUtu50=;
 b=hGenCNi7feQyBQniPanWNiLA8uERPlbMjbzDMluj4hI3/H5dWY5hEVG3/loOKxVHo6Mghi
 QEmYl6BrS9Y4j4Ww8Wj1WPwu1hdXKqK2kHX4LoPKtQILCWNNRUJduyD8jm3jdT7in23Yul
 6ZzuOPI1xEllwun1Y4Wl2jdhkB27Hy8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-DdvojmYtOXWl_0EYKFqyvg-1; Mon,
 23 Oct 2023 08:20:08 -0400
X-MC-Unique: DdvojmYtOXWl_0EYKFqyvg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6AF283813F34;
 Mon, 23 Oct 2023 12:20:08 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.124])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 83E47503B;
 Mon, 23 Oct 2023 12:20:06 +0000 (UTC)
Date: Mon, 23 Oct 2023 13:20:02 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 prerna.saxena@nutanix.com, dgilbert@redhat.com, pbonzini@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: Should we replace QAPI? (was: [PATCH v14 02/14] fixup!
 migration: New QAPI type 'MigrateAddress')
Message-ID: <ZTZk8oDcqiIWbuh5@redhat.com>
References: <20231019192353.31500-1-farosas@suse.de>
 <20231019192353.31500-3-farosas@suse.de>
 <87y1fxc27m.fsf@pond.sub.org> <87wmvhh4zm.fsf@suse.de>
 <87o7gt1ncz.fsf@pond.sub.org> <ZTKBIUEayhIOshcD@redhat.com>
 <87h6mhr9u0.fsf_-_@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h6mhr9u0.fsf_-_@pond.sub.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ONE_TIME=0.714, PLING_QUERY=0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Oct 23, 2023 at 11:01:43AM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Fri, Oct 20, 2023 at 02:37:16PM +0200, Markus Armbruster wrote:
> >> Fabiano Rosas <farosas@suse.de> writes:
> >> 
> >> > Markus Armbruster <armbru@redhat.com> writes:
> >> >
> >> >> Fabiano Rosas <farosas@suse.de> writes:
> >> >>
> >> >>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> >
> >> > Side question: are we using valid JSON at all? I threw this in a random
> >> > online linter and it complains about the single quotes. We could have a
> >> > proper tool doing the validation in CI.
> >> 
> >> You've come a sad, sad place.
> >> 
> >> docs/devel/qapi-code-gen.rst:
> >> 
> >>     Schema syntax
> >>     -------------
> >> 
> >>     Syntax is loosely based on `JSON <http://www.ietf.org/rfc/rfc8259.txt>`_.
> >>     Differences:
> >> 
> >>     * Comments: start with a hash character (``#``) that is not part of a
> >>       string, and extend to the end of the line.
> >> 
> >>     * Strings are enclosed in ``'single quotes'``, not ``"double quotes"``.
> >> 
> >>     * Strings are restricted to printable ASCII, and escape sequences to
> >>       just ``\\``.
> >> 
> >>     * Numbers and ``null`` are not supported.
> >> 
> >> If your reaction to item 2 is "this is stupid", you'd be exactly right.
> >> 
> >> Here's the conclusion of a discussion on possible improvements we had in
> >> 2020:
> >> https://lore.kernel.org/qemu-devel/877dt5ofoi.fsf@dusky.pond.sub.org/
> >
> > Looking at those options again I so strongly want to be able to
> > say "none of the above".
> >
> > We have a need to describe data structures, and generate code for
> > serializing/deserializing them on the wire. We created a language
> > for this and wrote our own C code generator, our own docs generator,
> > own our json parser & formatter, and now are also writing our own
> > Go code generator (Python, Rust too ?).
> >
> > IMHO this is way too much NiH for my likely, and creates a maint
> > burden for ourselves that we could do without.
> >
> > <open-can-of-worms>
> > At the point in time we invented QAPI this was perhaps justifiable,
> > though even back then I thought we should have done a binary format
> > and used XDR to describe it, as a standard pre-existing language and
> > toolset.
> 
> Path dependence...
> 
> I wasn't involved in the decisions that led to QAPI, nor its initial
> design and implementation.
> 
> Its design was substantially constrained by QMP, which predates QAPI by
> almost two years.  I was involved in QMP's design for a bit.  We argued
> back and forth, and I eventually stepped aside to let the guys doing the
> actual work make the decisions.

I'm somewhat conflating QMP & QAPI in my previous message too.

> The maintenance burden is modest, but real.  The QAPI generator has
> gotten ~1.6 patches per week for the last five years, trending down.  In
> the last year, it's been 68 patches, 437 insertions, 338 deletions
> total, much of it in docs/devel/qapi-code-gen.rst.  Meanwhile, the
> entire project has had 130 times as many patches, 620 times as many
> insertions, and 400 times as many deletions.
> 
> QAPI infrastructure maintenance is dwarved several times over by QAPI
> schema maintenance.  Chiefly patch review.

Yeah, patch review on new additions is primary amount and work
and indeed the bit we actually do want to be investing most
time in, as API modelling is a hard problem that needs careful
review.

> To be fair, adding language bindings will take a non-trivial one time
> investment plus ongoing maintenance for each language.

As well as the developer & reviewer man hours cost from creatnig
such language bindings, there's also the negative impact of
potential developers being discouraged from interacting with QEMU
precisely to avoid taking on this man hours cost. Impossible to
quantify, as we can't measure how many projects haven't even been
started, due to such avoidance. This hidden cost of discouragement
is where I think the value of using standard protocols wins out
the most.

> 
> > Today I wouldn't suggest XDR, but would be inclined to suggest
> > Protobuf. This already has code & docs generators for every
> > programming language we would ever need.
> >
> > Protobuf has a defined serialization format too though which is
> > binary based IIUC, so distinct from our JSON wire format.
> >
> > The interesting question though is whether it would be feasible to
> > transition to this today, despite our historical baggage ? With
> > recent interest in accessing QAPI for many more languages, it
> 
> Go, Rust, and what else?

The big one is Python, which we should have done years ago, since
we use it widely in our own test suites.

Over time QEMU is widely used enough though, that it would be
conceptually useful for many other non-niche languages to have
formal APIs for talking to QEMU, but not compelling enough to
justify manually writing such APIs or code generators ourselves.

> > is timely to consider if we can adopt a standardized toolset to
> > reduce this burden of talking to QEMU from other languages.
> >
> > A transition would need several big ticket items
> >
> >  * A QAPI visitor impl that can spit out the protobuf document.
> >    ie to translate all our existing QAPI formats into protobuf,
> >    as doing this manually would be madness. This is probably
> >    the easy bit.
> 
> This is about machine-assisted translation of the QAPI schema to
> protobuf, isn't it?

Yeah, schema conversion.


> >            Above all it does assume it is possible to define a
> > loss-less mapping from QAPI -> Protobuf language. I've not proved
> > this is possible, but my inclination is that it probably should be,
> > and if not, we could likely enable it by strategically deprecated
> > and then deleting troublesome bits prior to a conversion.
> > </open-can-of-worms>
> 
> While I share your distaste for the massive NIH QAPI has become, I'm not
> sure replacing it now is economical.  It requires a massive one-time
> investment, offset by saving us one-time investments into QAPI bindings
> for other languages of interest.  Whether it can actually reduce ongoing
> maintenance appreciably after the replacement is unclear.

This is the really hard to answer question, as the calculating value of
a conversion relies on predicting an unknowable future. It is right to
be sceptical about the value of changing, but also worth thinking about
it none the less.

Its probably the kind of project that someone who doesn't have to justify
their time would do as an experiment in a fork of QEMU for a while to
see how it actually works out.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


