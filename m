Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4488A82B717
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 23:25:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rO3TN-0002hZ-Rh; Thu, 11 Jan 2024 17:24:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rO3TK-0002hG-Qi
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 17:24:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rO3TH-0005NG-5q
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 17:24:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705011857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Q3LRjMikW0GFKbshCfeg0iFzqx7v23xx668rgSlaj4=;
 b=bDnPlHHie5gFlmatnTfexmdr0vrdnb4iktj9scdtJZPAvFQSVrwzSAobFw3UsYbmRRpGwF
 J/pwfRslodUc5e06t3JZWiRfJGcJ0fHXc5dZ0YdzcISyk3Q6hlm5fks5+JylFkRHKa/jMS
 iX6pdZ2QmELgEMVkv4ju39SOmVa1SJg=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-CYhGQAx8M-i6MxxuHUazyA-1; Thu, 11 Jan 2024 17:24:14 -0500
X-MC-Unique: CYhGQAx8M-i6MxxuHUazyA-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-5cdfd47de98so3234927a12.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 14:24:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705011853; x=1705616653;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Q3LRjMikW0GFKbshCfeg0iFzqx7v23xx668rgSlaj4=;
 b=tZZgIbcRsHX2JChbM82FgLXMOHdpX7Jxa8w3sUrBH5/vXZn8xBfOUUZgtCNYmIcX6W
 yJP6oe6/7otG2gBzv/H1HueZQAgAUx32qDyRC2qu6Qwh4Qh0Ed9cmo19w/JpN9chvBkv
 kOs6J5PZ3f8ElVspMjfKJyYsiV4aMqEErcVPMBMxSccd3q4kR6oueNPtOxQs2aq2eGOo
 GCtF6XzRswcx2wyUsRU+bqb68i9QXhfbRg02DClp8Ib4pdrQEqWqpSd73nPuHy1TGI5j
 JI5wVNWbnA3qh3XNy5uTXJWFnX8z478I5WwYWX+CW6IfDNskT4Wg12fw+HYsQz8UH26n
 YwxQ==
X-Gm-Message-State: AOJu0YyUcf1DtZ3rGE2fFCDdlDkoUUirSTcZ6pKJhY8axE/SGn77trwf
 uZlYIAiq3H2hKRhA6QF8HzejO+S3AJ9KGWGQ6EaxKESutY2bfMQSBWXWoGO4LZlGxMUq7j8ttXi
 rVbFeLuokmCy1HXG1Tbtsb03C0O+zEEZ/BhJUiPw=
X-Received: by 2002:a05:6a20:3c89:b0:19a:6ca2:c343 with SMTP id
 b9-20020a056a203c8900b0019a6ca2c343mr77894pzj.13.1705011853430; 
 Thu, 11 Jan 2024 14:24:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVOm+NiCN+FhsBuvRAfbgsffjeuLoNvwMn+q4oSpfrmDL4ozPVq2obtO54fH4jU1haGpSkl6mAD+ccCvOKpHY=
X-Received: by 2002:a05:6a20:3c89:b0:19a:6ca2:c343 with SMTP id
 b9-20020a056a203c8900b0019a6ca2c343mr77883pzj.13.1705011853039; Thu, 11 Jan
 2024 14:24:13 -0800 (PST)
MIME-Version: 1.0
References: <20231116014350.653792-1-jsnow@redhat.com>
 <20231116014350.653792-12-jsnow@redhat.com>
 <874jhedjv0.fsf@pond.sub.org>
 <CAFn=p-YZAZtX1SKAs2mFpGL7XhFPvsr68ipFqv+E_ZM_wV_Kig@mail.gmail.com>
 <87wmu84o6a.fsf@pond.sub.org>
 <CAFn=p-aFOhQ8+96cRasYmnF64g1CH_bdH0LiUAa98rkV9cbZXA@mail.gmail.com>
 <87jzog1afc.fsf@pond.sub.org>
In-Reply-To: <87jzog1afc.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 11 Jan 2024 17:24:01 -0500
Message-ID: <CAFn=p-aL9LmTKLdZ7CPo9rTjsBriQAxLQP88ZtRfwE4RDiXA9Q@mail.gmail.com>
Subject: Re: [PATCH 11/19] qapi/schema: fix QAPISchemaArrayType.check's call
 to resolve_type
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.467,
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

On Thu, Jan 11, 2024 at 4:33=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > On Thu, Nov 23, 2023, 8:03 AM Markus Armbruster <armbru@redhat.com> wro=
te:
> >
> >> John Snow <jsnow@redhat.com> writes:
> >>
> >> > On Wed, Nov 22, 2023 at 7:59=E2=80=AFAM Markus Armbruster <armbru@re=
dhat.com> wrote:
> >> >>
> >> >> John Snow <jsnow@redhat.com> writes:
> >> >>
> >> >> > There's more conditionals in here than we can reasonably pack int=
o a
> >> >> > terse little statement, so break it apart into something more> ex=
plicit.
> >> >> >
> >> >> > (When would a built-in array ever cause a QAPISemError? I don't k=
now,
> >> >> > maybe never - but the type system wasn't happy all the same.)
> >> >> >
> >> >> > Signed-off-by: John Snow <jsnow@redhat.com>
> >> >> > ---
> >> >> >  scripts/qapi/schema.py | 11 +++++++++--
> >> >> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >> >> >
> >> >> > diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> >> >> > index 462acb2bb61..164d86c4064 100644
> >> >> > --- a/scripts/qapi/schema.py
> >> >> > +++ b/scripts/qapi/schema.py
> >> >> > @@ -384,9 +384,16 @@ def need_has_if_optional(self):
> >> >> >
> >> >> >      def check(self, schema):
> >> >> >          super().check(schema)
> >> >> > +
> >> >> > +        if self.info:
> >> >> > +            assert self.info.defn_meta  # guaranteed to be set b=
y> expr.py
> >> >> > +            what =3D self.info.defn_meta
> >> >> > +        else:
> >> >> > +            what =3D 'built-in array'
> >> >> > +
> >> >> >          self._element_type =3D schema.resolve_type(
> >> >> > -            self._element_type_name, self.info,
> >> >> > -            self.info and self.info.defn_meta)
> >> >> > +            self._element_type_name, self.info, what
> >> >> > +        )
> >> 0>> >          assert not isinstance(self.element_type, QAPISchemaArra=
yType)
> >> >> >
> >> >> >      def set_module(self, schema):
> >> >>
> >> >> What problem are you solving here?
> >> >>
> >> >
> >> > 1. "self.info and self.info.defn_meta" is the wrong type ifn't self.=
info
> >>
> >> self.info is Optional[QAPISourceInfo].
> >>
> >> When self.info, then self.info.defn_meta is is Optional[str].
> >>
> >> Naive me expects self.info and self.info.defn_meta to be Optional[str]=
.
> >> Playing with mypy...  it seems to be Union[QAPISourceInfo, None, str].
> >> Type inference too weak.
> >>
> >
> > I think my expectations match yours: "x and y" should return either x o=
r y,
> > so the resulting type would naively be Union[X | Y], which would indeed=
 be
> > Union[QAPISourceInfo | None | str], but:
> >
> > If QAPISourceInfo is *false-y*, but not None, it'd be possible for the
> > expression to yield a QAPISourceInfo. mypy does not understand that
> > QAPISourceInfo can never be false-y.
> >
> > (That I know of. Maybe there's a trick to annotate it. I like your solu=
tion
> > below better anyway, just curious about the exact nature of this
> > limitation.)
> >
> >
> >> > 2. self.info.defn_meta is *also* not guaranteed by static types
> >>
> >> Yes.  We know it's not None ("guaranteed to be set by expr.py"), but t=
he
> >> type system doesn't.
> >>
> >
> > Mmhmm.
> >
> >
> >> > ultimately: we need to assert self.info and self.info.defn_meta both=
;
> >> > but it's possible (?) that we don't have self.info in the case that
> >> > we're a built-in array, so I handle that.
> >>
> >> This bring us back to the question in your commit message: "When would=
 a
> >> built-in array ever cause a QAPISemError?"  Short answer: never.
> >
> > Right, okay. I just couldn't guarantee it statically. I knew this patch=
 was
> > a little bananas, sorry for tossing you the stinkbomb.
>
> No need to be sorry!  Feels like an efficient way to collaborate with
> me.
>
> >> Long answer.  We're dealing with a *specific* QAPISemError here, namel=
y
> >> .resolve_type()'s "uses unknown type".  If this happens for a built-in
> >> array, it's a programming error.
> >>
> >> Let's commit such an error to see what happens: stick
> >>
> >>         self._make_array_type('xxx', None)
> >>
> >> Dies like this:
> >>
> >>     Traceback (most recent call last):
> >>       File "/work/armbru/qemu/scripts/qapi/main.py", line 94, in main
> >>         generate(args.schema,
> >>       File "/work/armbru/qemu/scripts/qapi/main.py", line 50, in gener=
ate
> >>         schema =3D QAPISchema(schema_file)
> >>                  ^^^^^^^^^^^^^^^^^^^^^^^
> >>       File "/work/armbru/qemu/scripts/qapi/schema.py", line 938, in
> >> __init__
> >>         self.check()
> >>       File "/work/armbru/qemu/scripts/qapi/schema.py", line 1225, in c=
heck
> >>         ent.check(self)
> >>       File "/work/armbru/qemu/scripts/qapi/schema.py", line 373, in ch=
eck
> >>         self.element_type =3D schema.resolve_type(
> >>                             ^^^^^^^^^^^^^^^^^^^^
> >>       File "/work/armbru/qemu/scripts/qapi/schema.py", line 973, in
> >> resolve_type
> >>         raise QAPISemError(
> >>     qapi.error.QAPISemError: <exception str() failed>
> >>
> >>     During handling of the above exception, another exception occurred=
:
> >>
> >>     Traceback (most recent call last):
> >>       File "/work/armbru/qemu/scripts/qapi-gen.py", line 19, in <modul=
e>
> >>         sys.exit(main.main())
> >>                  ^^^^^^^^^^^
> >>       File "/work/armbru/qemu/scripts/qapi/main.py", line 101, in main
> >>         print(err, file=3Dsys.stderr)
> >>       File "/work/armbru/qemu/scripts/qapi/error.py", line 41, in __st=
r__
> >>         assert self.info is not None
> >>                ^^^^^^^^^^^^^^^^^^^^^
> >>     AssertionError
> >>
> >> Same before and after your patch.  The patch's change of what=3DNone t=
o
> >> what=3D'built-in array' has no effect.
> >>
> >> Here's a slightly simpler patch:
> >>
> >> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> >> index 46004689f0..feb0023d25 100644
> >> --- a/scripts/qapi/schema.py
> >> +++ b/scripts/qapi/schema.py
> >> @@ -479,7 +479,7 @@ def check(self, schema: QAPISchema) -> None:
> >>          super().check(schema)
> >>          self._element_type =3D schema.resolve_type(
> >>              self._element_type_name, self.info,
> >> -            self.info and self.info.defn_meta)
> >> +            self.info.defn_meta if self.info else None)
> >>
> >
> > Yep.
> >
> >          assert not isinstance(self.element_type, QAPISchemaArrayType)
> >>
> >>      def set_module(self, schema: QAPISchema) -> None:
> >> @@ -1193,7 +1193,7 @@ def resolve_type(
> >>          self,
> >>          name: str,
> >>          info: Optional[QAPISourceInfo],
> >> -        what: Union[str, Callable[[Optional[QAPISourceInfo]], str]],
> >> +        what: Union[None, str, Callable[[Optional[QAPISourceInfo]], s=
tr]],
> >>      ) -> QAPISchemaType:
> >>          typ =3D self.lookup_type(name)
> >>          if not typ:
> >>
> >> The first hunk works around mypy's type inference weakness.  It rewrit=
es
> >>
> >>     A and B
> >>
> >> as
> >>
> >>     B if A else A
> >>
> >> and then partially evaluates to
> >>
> >>     B if A else None
> >>
> >> exploiting the fact that falsy A can only be None.  It replaces this
> >> patch.
> >
> > Sounds good to me!
>
> Does it need a comment explaining the somewhat awkward coding?  Probably
> not.

git blame should cover it for the curious; otherwise if someone
decides to simplify it they'll find out quickly enough when the test
chirps. (Oh, assuming I actually get this into a test suite soon...)

--js

>
> >> The second hunk corrects .resolve_type()'s typing to accept what=3DNon=
e.
> >> It's meant to be squashed into PATCH 16.
> >>
> >> What do you think?
> >>
> >
> > I'm on my mobile again, but at a glance I like it. Except that I'm a li=
ttle
> > reluctant to allow what to be None if this is the *only* caller known t=
o
> > possibly do it, and only in a circumstance that we assert elsewhere tha=
t it
> > should never happen.
> >
> > Can we do:
> >
> > what =3D self.info.defn_meta if self.info else None
> > assert what [is not None]  # Depending on taste
> >
> > instead?
> >
> > No sem error, no new unit test needed, assertion provides the correct f=
rame
> > of mind (programmer error), stronger typing on resolve_type.
> >
> > (I really love eliminating None when I can as a rule because I like how
> > much more it tells you about the nature of all callers, it's a much
> > stronger decree. Worth pursuing where you can, IMO, but I'm not gonna d=
ie
> > on the hill for a patch like this - just sharing my tendencies for
> > discussion.)
>
> Suggest you post the patch, so I can see it more easily in context.

Kay, coming right up.

--js


