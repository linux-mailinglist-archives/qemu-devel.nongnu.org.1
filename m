Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEB5878F16
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Mar 2024 08:33:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjwcr-0004bf-Ks; Tue, 12 Mar 2024 03:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rjwch-0004b1-EZ
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 03:32:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rjwcd-0008Nw-9W
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 03:32:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710228740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QERrIPigsceGck5mOEFw3c8mKGL8ZIpArdqU2tQjykk=;
 b=dIV1YcH7RdOGo9wowbqLAh9cxL7LZNgpfh/riJx6uCR6Njs8lLcyWM6cgI5XT4N9sLfLvF
 yYx4/sCE0JynzImtyzl9PUmOyYkxnEjS8RNp+/cySj2I2km2IQDwR6HIrHVTMG0C3u2q1T
 BqsawjgzBdCrXngEss9vJlQ26/fT7vc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-wl_1h86nNPqFuyc45nJbFw-1; Tue,
 12 Mar 2024 03:32:16 -0400
X-MC-Unique: wl_1h86nNPqFuyc45nJbFw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 871EE1C05AAC;
 Tue, 12 Mar 2024 07:32:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A5FB540C6DAD;
 Tue, 12 Mar 2024 07:31:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4EF1D21E6A24; Tue, 12 Mar 2024 08:32:15 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v3 08/20] qapi/schema: add type narrowing to lookup_type()
In-Reply-To: <CAFn=p-YkNHQM7QQUfd+p9E7d4BpdS4JpfGw30RJ6SsVmeWGZmw@mail.gmail.com>
 (John Snow's message of "Mon, 11 Mar 2024 14:26:43 -0400")
References: <20240201224246.39480-1-jsnow@redhat.com>
 <20240201224246.39480-9-jsnow@redhat.com>
 <87zfvvberq.fsf@pond.sub.org>
 <CAFn=p-amLiQmaFoN3J+m=Yrij_JLzzezW8QFd3t+8N1ETfmUHA@mail.gmail.com>
 <CAFn=p-YkNHQM7QQUfd+p9E7d4BpdS4JpfGw30RJ6SsVmeWGZmw@mail.gmail.com>
Date: Tue, 12 Mar 2024 08:32:15 +0100
Message-ID: <87sf0voqgw.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
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

John Snow <jsnow@redhat.com> writes:

> On Mon, Mar 11, 2024 at 2:14=E2=80=AFPM John Snow <jsnow@redhat.com> wrot=
e:
>>
>> On Tue, Feb 20, 2024 at 5:39=E2=80=AFAM Markus Armbruster <armbru@redhat=
.com> wrote:
>> >
>> > John Snow <jsnow@redhat.com> writes:
>> >
>> > > This function is a bit hard to type as-is; mypy needs some assertion=
s to
>> > > assist with the type narrowing.
>> > >
>> > > Signed-off-by: John Snow <jsnow@redhat.com>
>> > > ---
>> > >  scripts/qapi/schema.py | 4 +++-
>> > >  1 file changed, 3 insertions(+), 1 deletion(-)
>> > >
>> > > diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
>> > > index 043ee7556e6..e617abb03af 100644
>> > > --- a/scripts/qapi/schema.py
>> > > +++ b/scripts/qapi/schema.py
>> > > @@ -997,7 +997,9 @@ def lookup_entity(self, name, typ=3DNone):
>> >        def lookup_entity(self, name, typ=3DNone):
>> >            ent =3D self._entity_dict.get(name)
>> >            if typ and not isinstance(ent, typ):
>> >                return None
>> > >          return ent
>> > >
>> > >      def lookup_type(self, name):
>> > > -        return self.lookup_entity(name, QAPISchemaType)
>> > > +        typ =3D self.lookup_entity(name, QAPISchemaType)
>> > > +        assert typ is None or isinstance(typ, QAPISchemaType)
>> > > +        return typ
>> > >
>> > >      def resolve_type(self, name, info, what):
>> > >          typ =3D self.lookup_type(name)
>> >
>> > I figure the real trouble-maker is .lookup_entity().
>> >
>> > When not passed an optional type argument, it returns QAPISchemaEntity.
>> >
>> > When passed an optional type argument, it returns that type or None.
>> >
>> > Too cute for type hints to express, I guess.
>> >
>> > What if we drop .lookup_entity()'s optional argument?  There are just
>> > three callers:
>> >
>> > 1. .lookup_type(), visible above.
>> >
>> >        def lookup_type(self, name):
>> >            ent =3D self.lookup_entity(name)
>> >            if isinstance(ent, QAPISchemaType):
>> >                return ent
>> >            return None
>> >
>> >     This should permit typing it as -> Optional[QAPISchemaType] without
>> >     further ado.
>> >
>> > 2. ._make_implicit_object_type() below
>> >
>> >    Uses .lookup_type() to check whether the implicit object type alrea=
dy
>> >    exists.  We figure we could
>> >
>> >            typ =3D self.lookup_entity(name)
>> >            if typ:
>> >                assert(isinstance(typ, QAPISchemaObjectType))
>> >                # The implicit object type has multiple users.  This can
>> >
>> > 3. QAPIDocDirective.run() doesn't pass a type argument, so no change.
>> >
>> > Thoughts?
>> >
>> > If you'd prefer not to rock the boat for this series, could it still
>> > make sense as a followup?
>>
>> It makes sense as a follow-up, I think. I had other patches in the
>> past that attempted to un-cuten these functions and make them more
>> statically solid, but the shifting sands kept making it easier to put
>> off until later.
>>
>> Lemme see if I can just tack this on to the end of the series and see
>> how it behaves...
>
> Oh, I see what you're doing. Well, I think it's fine if you want to,
> but it's also fine to keep this "stricter" method. There's also ways
> to type it using mypy's @overload which I've monkey'd with in the
> past. Dealer's choice, honestly, but I think I'm eager to just get to
> the "fully typed" baseline and then worry about changing more stuff.

That's okay.  However, a good part of the typing exercise's benefit is
the pinpointing of needlessly cute code, i.e. code that could be just as
well be less cute.  To actually reap the benefit, we need to make it
less cute.  If we put it off, we risk to forget.  Acceptable if we take
appropriate steps not to forget.


