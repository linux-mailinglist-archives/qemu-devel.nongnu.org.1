Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B9082AB13
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 10:34:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNrRl-0004kl-8i; Thu, 11 Jan 2024 04:33:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rNrRi-0004kL-NT
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 04:33:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rNrRf-0001F1-IO
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 04:33:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704965628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AcQHZ7lV88685vs3PP8OIvSJtk39y7HViWYg9kFtC+4=;
 b=NTwfpNJ5iOqEANybEJQ//5YMwx8wK/a/PvucvFYoWw7TwVjMeNnLQgCGazFWxIL1u1whZP
 NE54HlohF0LWRixRlbdydfu/zTi33sUlheNWgMrKz03XY1x1rctTk09nDTk+ilJBDIqzmf
 mzyuMC5UIgGvod71jUuRDmN7pmZZBYs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-y9gUHfosPrOgacIx_9YMHw-1; Thu,
 11 Jan 2024 04:33:45 -0500
X-MC-Unique: y9gUHfosPrOgacIx_9YMHw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E60D51C04351;
 Thu, 11 Jan 2024 09:33:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.71])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A76F83C25;
 Thu, 11 Jan 2024 09:33:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A0A9021E6682; Thu, 11 Jan 2024 10:33:43 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 11/19] qapi/schema: fix QAPISchemaArrayType.check's call
 to resolve_type
In-Reply-To: <CAFn=p-aFOhQ8+96cRasYmnF64g1CH_bdH0LiUAa98rkV9cbZXA@mail.gmail.com>
 (John Snow's message of "Wed, 10 Jan 2024 14:33:05 -0500")
References: <20231116014350.653792-1-jsnow@redhat.com>
 <20231116014350.653792-12-jsnow@redhat.com>
 <874jhedjv0.fsf@pond.sub.org>
 <CAFn=p-YZAZtX1SKAs2mFpGL7XhFPvsr68ipFqv+E_ZM_wV_Kig@mail.gmail.com>
 <87wmu84o6a.fsf@pond.sub.org>
 <CAFn=p-aFOhQ8+96cRasYmnF64g1CH_bdH0LiUAa98rkV9cbZXA@mail.gmail.com>
Date: Thu, 11 Jan 2024 10:33:43 +0100
Message-ID: <87jzog1afc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.774,
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

John Snow <jsnow@redhat.com> writes:

> On Thu, Nov 23, 2023, 8:03 AM Markus Armbruster <armbru@redhat.com> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > On Wed, Nov 22, 2023 at 7:59=E2=80=AFAM Markus Armbruster <armbru@redh=
at.com> wrote:
>> >>
>> >> John Snow <jsnow@redhat.com> writes:
>> >>
>> >> > There's more conditionals in here than we can reasonably pack into a
>> >> > terse little statement, so break it apart into something more> expl=
icit.
>> >> >
>> >> > (When would a built-in array ever cause a QAPISemError? I don't kno=
w,
>> >> > maybe never - but the type system wasn't happy all the same.)
>> >> >
>> >> > Signed-off-by: John Snow <jsnow@redhat.com>
>> >> > ---
>> >> >  scripts/qapi/schema.py | 11 +++++++++--
>> >> >  1 file changed, 9 insertions(+), 2 deletions(-)
>> >> >
>> >> > diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
>> >> > index 462acb2bb61..164d86c4064 100644
>> >> > --- a/scripts/qapi/schema.py
>> >> > +++ b/scripts/qapi/schema.py
>> >> > @@ -384,9 +384,16 @@ def need_has_if_optional(self):
>> >> >
>> >> >      def check(self, schema):
>> >> >          super().check(schema)
>> >> > +
>> >> > +        if self.info:
>> >> > +            assert self.info.defn_meta  # guaranteed to be set by>=
 expr.py
>> >> > +            what =3D self.info.defn_meta
>> >> > +        else:
>> >> > +            what =3D 'built-in array'
>> >> > +
>> >> >          self._element_type =3D schema.resolve_type(
>> >> > -            self._element_type_name, self.info,
>> >> > -            self.info and self.info.defn_meta)
>> >> > +            self._element_type_name, self.info, what
>> >> > +        )
>> 0>> >          assert not isinstance(self.element_type, QAPISchemaArrayT=
ype)
>> >> >
>> >> >      def set_module(self, schema):
>> >>
>> >> What problem are you solving here?
>> >>
>> >
>> > 1. "self.info and self.info.defn_meta" is the wrong type ifn't self.in=
fo
>>
>> self.info is Optional[QAPISourceInfo].
>>
>> When self.info, then self.info.defn_meta is is Optional[str].
>>
>> Naive me expects self.info and self.info.defn_meta to be Optional[str].
>> Playing with mypy...  it seems to be Union[QAPISourceInfo, None, str].
>> Type inference too weak.
>>
>
> I think my expectations match yours: "x and y" should return either x or =
y,
> so the resulting type would naively be Union[X | Y], which would indeed be
> Union[QAPISourceInfo | None | str], but:
>
> If QAPISourceInfo is *false-y*, but not None, it'd be possible for the
> expression to yield a QAPISourceInfo. mypy does not understand that
> QAPISourceInfo can never be false-y.
>
> (That I know of. Maybe there's a trick to annotate it. I like your soluti=
on
> below better anyway, just curious about the exact nature of this
> limitation.)
>
>
>> > 2. self.info.defn_meta is *also* not guaranteed by static types
>>
>> Yes.  We know it's not None ("guaranteed to be set by expr.py"), but the
>> type system doesn't.
>>
>
> Mmhmm.
>
>
>> > ultimately: we need to assert self.info and self.info.defn_meta both;
>> > but it's possible (?) that we don't have self.info in the case that
>> > we're a built-in array, so I handle that.
>>
>> This bring us back to the question in your commit message: "When would a
>> built-in array ever cause a QAPISemError?"  Short answer: never.
>
> Right, okay. I just couldn't guarantee it statically. I knew this patch w=
as
> a little bananas, sorry for tossing you the stinkbomb.

No need to be sorry!  Feels like an efficient way to collaborate with
me.

>> Long answer.  We're dealing with a *specific* QAPISemError here, namely
>> .resolve_type()'s "uses unknown type".  If this happens for a built-in
>> array, it's a programming error.
>>
>> Let's commit such an error to see what happens: stick
>>
>>         self._make_array_type('xxx', None)
>>
>> Dies like this:
>>
>>     Traceback (most recent call last):
>>       File "/work/armbru/qemu/scripts/qapi/main.py", line 94, in main
>>         generate(args.schema,
>>       File "/work/armbru/qemu/scripts/qapi/main.py", line 50, in generate
>>         schema =3D QAPISchema(schema_file)
>>                  ^^^^^^^^^^^^^^^^^^^^^^^
>>       File "/work/armbru/qemu/scripts/qapi/schema.py", line 938, in
>> __init__
>>         self.check()
>>       File "/work/armbru/qemu/scripts/qapi/schema.py", line 1225, in che=
ck
>>         ent.check(self)
>>       File "/work/armbru/qemu/scripts/qapi/schema.py", line 373, in check
>>         self.element_type =3D schema.resolve_type(
>>                             ^^^^^^^^^^^^^^^^^^^^
>>       File "/work/armbru/qemu/scripts/qapi/schema.py", line 973, in
>> resolve_type
>>         raise QAPISemError(
>>     qapi.error.QAPISemError: <exception str() failed>
>>
>>     During handling of the above exception, another exception occurred:
>>
>>     Traceback (most recent call last):
>>       File "/work/armbru/qemu/scripts/qapi-gen.py", line 19, in <module>
>>         sys.exit(main.main())
>>                  ^^^^^^^^^^^
>>       File "/work/armbru/qemu/scripts/qapi/main.py", line 101, in main
>>         print(err, file=3Dsys.stderr)
>>       File "/work/armbru/qemu/scripts/qapi/error.py", line 41, in __str__
>>         assert self.info is not None
>>                ^^^^^^^^^^^^^^^^^^^^^
>>     AssertionError
>>
>> Same before and after your patch.  The patch's change of what=3DNone to
>> what=3D'built-in array' has no effect.
>>
>> Here's a slightly simpler patch:
>>
>> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
>> index 46004689f0..feb0023d25 100644
>> --- a/scripts/qapi/schema.py
>> +++ b/scripts/qapi/schema.py
>> @@ -479,7 +479,7 @@ def check(self, schema: QAPISchema) -> None:
>>          super().check(schema)
>>          self._element_type =3D schema.resolve_type(
>>              self._element_type_name, self.info,
>> -            self.info and self.info.defn_meta)
>> +            self.info.defn_meta if self.info else None)
>>
>
> Yep.
>
>          assert not isinstance(self.element_type, QAPISchemaArrayType)
>>
>>      def set_module(self, schema: QAPISchema) -> None:
>> @@ -1193,7 +1193,7 @@ def resolve_type(
>>          self,
>>          name: str,
>>          info: Optional[QAPISourceInfo],
>> -        what: Union[str, Callable[[Optional[QAPISourceInfo]], str]],
>> +        what: Union[None, str, Callable[[Optional[QAPISourceInfo]], str=
]],
>>      ) -> QAPISchemaType:
>>          typ =3D self.lookup_type(name)
>>          if not typ:
>>
>> The first hunk works around mypy's type inference weakness.  It rewrites
>>
>>     A and B
>>
>> as
>>
>>     B if A else A
>>
>> and then partially evaluates to
>>
>>     B if A else None
>>
>> exploiting the fact that falsy A can only be None.  It replaces this
>> patch.
>
> Sounds good to me!

Does it need a comment explaining the somewhat awkward coding?  Probably
not.

>> The second hunk corrects .resolve_type()'s typing to accept what=3DNone.
>> It's meant to be squashed into PATCH 16.
>>
>> What do you think?
>>
>
> I'm on my mobile again, but at a glance I like it. Except that I'm a litt=
le
> reluctant to allow what to be None if this is the *only* caller known to
> possibly do it, and only in a circumstance that we assert elsewhere that =
it
> should never happen.
>
> Can we do:
>
> what =3D self.info.defn_meta if self.info else None
> assert what [is not None]  # Depending on taste
>
> instead?
>
> No sem error, no new unit test needed, assertion provides the correct fra=
me
> of mind (programmer error), stronger typing on resolve_type.
>
> (I really love eliminating None when I can as a rule because I like how
> much more it tells you about the nature of all callers, it's a much
> stronger decree. Worth pursuing where you can, IMO, but I'm not gonna die
> on the hill for a patch like this - just sharing my tendencies for
> discussion.)

Suggest you post the patch, so I can see it more easily in context.


