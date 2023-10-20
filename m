Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FB77D1092
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 15:31:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtpbB-00020p-Iy; Fri, 20 Oct 2023 09:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qtpb4-00020P-5z
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 09:31:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qtpb2-0005Fi-A4
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 09:31:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697808683;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=GG9pTKYbltb1koDZqGHiiBXr29+ecbw/CISoOKANdio=;
 b=hy7jh6bCZ+e1Jr0j10Z8jDo0CAuYkjRRhlJUayeEG+DEJKwMULMHejr6leK0ikuyZjZASu
 LW/4L1/iLTNKCu4SCtzs4DIjzTl0Jt+xT0iWxYnT7kxuwKgnp8e5cJuoFVwELKbHsgiHAK
 DXWozS0P38tw9nKU3kqfd4IFRfw/9fI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-369--S2QclppP4KF7pcdvZjEsg-1; Fri, 20 Oct 2023 09:31:19 -0400
X-MC-Unique: -S2QclppP4KF7pcdvZjEsg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 351A488B779;
 Fri, 20 Oct 2023 13:31:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.125])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F39F492BFB;
 Fri, 20 Oct 2023 13:31:15 +0000 (UTC)
Date: Fri, 20 Oct 2023 14:31:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 prerna.saxena@nutanix.com, dgilbert@redhat.com, pbonzini@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v14 02/14] fixup! migration: New QAPI type 'MigrateAddress'
Message-ID: <ZTKBIUEayhIOshcD@redhat.com>
References: <20231019192353.31500-1-farosas@suse.de>
 <20231019192353.31500-3-farosas@suse.de>
 <87y1fxc27m.fsf@pond.sub.org> <87wmvhh4zm.fsf@suse.de>
 <87o7gt1ncz.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o7gt1ncz.fsf@pond.sub.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, Oct 20, 2023 at 02:37:16PM +0200, Markus Armbruster wrote:
> Fabiano Rosas <farosas@suse.de> writes:
> 
> > Markus Armbruster <armbru@redhat.com> writes:
> >
> >> Fabiano Rosas <farosas@suse.de> writes:
> >>
> >>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >
> > Side question: are we using valid JSON at all? I threw this in a random
> > online linter and it complains about the single quotes. We could have a
> > proper tool doing the validation in CI.
> 
> You've come a sad, sad place.
> 
> docs/devel/qapi-code-gen.rst:
> 
>     Schema syntax
>     -------------
> 
>     Syntax is loosely based on `JSON <http://www.ietf.org/rfc/rfc8259.txt>`_.
>     Differences:
> 
>     * Comments: start with a hash character (``#``) that is not part of a
>       string, and extend to the end of the line.
> 
>     * Strings are enclosed in ``'single quotes'``, not ``"double quotes"``.
> 
>     * Strings are restricted to printable ASCII, and escape sequences to
>       just ``\\``.
> 
>     * Numbers and ``null`` are not supported.
> 
> If your reaction to item 2 is "this is stupid", you'd be exactly right.
> 
> Here's the conclusion of a discussion on possible improvements we had in
> 2020:
> https://lore.kernel.org/qemu-devel/877dt5ofoi.fsf@dusky.pond.sub.org/

Looking at those options again I so strongly want to be able to
say "none of the above".

We have a need to describe data structures, and generate code for
serializing/deserializing them on the wire. We created a language
for this and wrote our own C code generator, our own docs generator,
own our json parser & formatter, and now are also writing our own
Go code generator (Python, Rust too ?).

IMHO this is way too much NiH for my likely, and creates a maint
burden for ourselves that we could do without.

<open-can-of-worms>
At the point in time we invented QAPI this was perhaps justifiable,
though even back then I thought we should have done a binary format
and used XDR to describe it, as a standard pre-existing language and
toolset.

Today I wouldn't suggest XDR, but would be inclined to suggest
Protobuf. This already has code & docs generators for every
programming language we would ever need.

Protobuf has a defined serialization format too though which is
binary based IIUC, so distinct from our JSON wire format.

The interesting question though is whether it would be feasible to
transition to this today, despite our historical baggage ? With
recent interest in accessing QAPI for many more languages, it
is timely to consider if we can adopt a standardized toolset to
reduce this burden of talking to QEMU from other languages.

A transition would need several big ticket items

 * A QAPI visitor impl that can spit out the protobuf document.
   ie to translate all our existing QAPI formats into protobuf,
   as doing this manually would be madness. This is probably
   the easy bit.

 * A custom protobuf visitor impl that can spit out C code
   that has the same API as our QAPI C generator. ie so we can
   avoid a big bang to convert all of QEMU internals. I suspect
   this is quite alot of work.

 * A custom protobuf serializer compatible with our current
   JSON format. ie so that QEMU can continue to expose the
   current QMP protocol to apps for legacy compat for some
   period of time, while also exposing a new native binary
   protobuf protocol for future usage. Also probably quite
   alot of work.

That's all certainly quite alot of work and probably things I have
forgotten. Above all it does assume it is possible to define a
loss-less mapping from QAPI -> Protobuf language. I've not proved
this is possible, but my inclination is that it probably should be,
and if not, we could likely enable it by strategically deprecated
and then deleting troublesome bits prior to a conversion.
</open-can-of-worms>

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


