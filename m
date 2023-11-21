Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FA77F343E
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 17:52:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Tym-00079m-9u; Tue, 21 Nov 2023 11:52:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r5Tyk-00079U-Oq
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 11:52:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r5Tyi-0006uO-Vr
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 11:52:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700585519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kc97JysrYdBwQlDMSF6p3np3Ib7NMKF9w1LU8zn8O/I=;
 b=KNCeb5tiBfpqr/FAp3YbcSsnV3CxGGDHTWpxf1+lWrewCHABKmfQR0/R29Gz1G3HwAHS41
 GFpxcBmHyxULaeWq2g3yfK3OdvsShQGz8KMbvnj3lTLQN6llyVM/IZAtCi3mW5Q9DUeCvt
 EJWdoiud6NxeKperiws6gTwelDAk3Ps=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-oAN-b1RRN3aIwQDDhrsCbw-1; Tue, 21 Nov 2023 11:51:57 -0500
X-MC-Unique: oAN-b1RRN3aIwQDDhrsCbw-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-6b243dc6aeeso6885772b3a.3
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 08:51:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700585515; x=1701190315;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kc97JysrYdBwQlDMSF6p3np3Ib7NMKF9w1LU8zn8O/I=;
 b=sdD9tJwmPPY17RQqS7/1dP7d6jCXYb54SguaUnYrYuaAXOCWc+lOs5pxlXUoR6BDQp
 EGWlq/DN/Z0Y8shqYLmPWC2S9LvqgsGtTrBklhbVD36te/iwLzBo4PK0baVCqM/2923Q
 9McKn992FSMIH5Ww5ybvnG4Jgvdxn73UnfvTVa7AfMeuWo/hUvCOJG7ntAz/cc809mpT
 KpcU+0yjG+gGJWiyM5Pp5Y7FK5c9aeuOt2SDr6RkQVAoQUXfwjXx+vPTHw0Rd1zIKiFT
 C1OojCTxSy/DdkT5AseXJQrqBZ25uOtYRYwz5ueV9oDbJm6bzKdOrLs8FwwGeJ7wCF2k
 TCiQ==
X-Gm-Message-State: AOJu0Yw4BmaodE21CA0l3YjK8Z9qumrzZFOxza8F1dp0E1p3LqTeJ3h4
 UoyCGe0/l+hujFewHuuH6eNg7rhAHc6m6YbcCBX9hRnJxJhYmVQMWb7JtqENS2HTe94Fqmo+ujk
 JoN4wFw/ChZ8SHRR437TGC/6mH1NPA8AxafaSXro=
X-Received: by 2002:aa7:9310:0:b0:6c3:3213:2d17 with SMTP id
 cz16-20020aa79310000000b006c332132d17mr9185400pfb.29.1700585514639; 
 Tue, 21 Nov 2023 08:51:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFT0RxziMPZ5Sh9x0lq42N6kGn7xJwq6cLRgRj/21cW1PMsqOulsuG3lp/TYUyakD7gC7J5bossL0Fx8OoXe5A=
X-Received: by 2002:aa7:9310:0:b0:6c3:3213:2d17 with SMTP id
 cz16-20020aa79310000000b006c332132d17mr9185379pfb.29.1700585514337; Tue, 21
 Nov 2023 08:51:54 -0800 (PST)
MIME-Version: 1.0
References: <20231116014350.653792-1-jsnow@redhat.com>
 <20231116014350.653792-11-jsnow@redhat.com>
 <87fs0z2nbk.fsf@pond.sub.org>
In-Reply-To: <87fs0z2nbk.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 21 Nov 2023 11:51:43 -0500
Message-ID: <CAFn=p-Y3OJ1mcvbwhCbddZfL8_Ow2y=wvtjx-QpooY--93iQYw@mail.gmail.com>
Subject: Re: [PATCH 10/19] qapi/schema: make QAPISchemaArrayType.element_type
 non-Optional
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="0000000000007e22ca060aac6b13"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--0000000000007e22ca060aac6b13
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 21, 2023, 9:28 AM Markus Armbruster <armbru@redhat.com> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > This field should always be present and defined. Change this to be a
> > runtime @property that can emit an error if it's called prior to
> > check().
> >
> > This helps simplify typing by avoiding the need to interrogate the value
> > for None at multiple callsites.
> >
> > RFC: Yes, this is a slightly different technique than the one I used for
> > QAPISchemaObjectTypeMember.type;
>
> In PATCH 04.
>
> >                                  I think I prefer this one as being a
> > little less hokey, but it is more SLOC. Dealer's choice for which style
> > wins out -- now you have an example of both.
>
> Thanks for letting us see both.
>

My pleasure ;)


> I believe all the extra lines accomplish is a different exception
> RuntimeError with a custom message vs. plain AttributeError.
>
> I don't think the more elaborate exception is worth the extra code.
>

Hmm, shame. You're the boss :)


> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  scripts/qapi/schema.py | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> > index c9a194103e1..462acb2bb61 100644
> > --- a/scripts/qapi/schema.py
> > +++ b/scripts/qapi/schema.py
> > @@ -366,7 +366,16 @@ def __init__(self, name, info, element_type):
> >          super().__init__(name, info, None)
> >          assert isinstance(element_type, str)
> >          self._element_type_name = element_type
> > -        self.element_type = None
> > +        self._element_type: Optional[QAPISchemaType] = None
> > +
> > +    @property
> > +    def element_type(self) -> QAPISchemaType:
> > +        if self._element_type is None:
> > +            raise RuntimeError(
> > +                "QAPISchemaArray has no element_type until "
> > +                "after check() has been run."
> > +            )
> > +        return self._element_type
> >
> >      def need_has_if_optional(self):
> >          # When FOO is an array, we still need has_FOO to distinguish
> > @@ -375,7 +384,7 @@ def need_has_if_optional(self):
> >
> >      def check(self, schema):
> >          super().check(schema)
> > -        self.element_type = schema.resolve_type(
> > +        self._element_type = schema.resolve_type(
> >              self._element_type_name, self.info,
> >              self.info and self.info.defn_meta)
> >          assert not isinstance(self.element_type, QAPISchemaArrayType)
>
>

--0000000000007e22ca060aac6b13
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Tue, Nov 21, 2023, 9:28 AM Markus Armbruster &lt;<a=
 href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redh=
at.com" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt; write=
s:<br>
<br>
&gt; This field should always be present and defined. Change this to be a<b=
r>
&gt; runtime @property that can emit an error if it&#39;s called prior to<b=
r>
&gt; check().<br>
&gt;<br>
&gt; This helps simplify typing by avoiding the need to interrogate the val=
ue<br>
&gt; for None at multiple callsites.<br>
&gt;<br>
&gt; RFC: Yes, this is a slightly different technique than the one I used f=
or<br>
&gt; QAPISchemaObjectTypeMember.type;<br>
<br>
In PATCH 04.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 I think I prefer this one =
as being a<br>
&gt; little less hokey, but it is more SLOC. Dealer&#39;s choice for which =
style<br>
&gt; wins out -- now you have an example of both.<br>
<br>
Thanks for letting us see both.<br></blockquote></div></div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">My pleasure ;)</div><div dir=3D"auto"><br></=
div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex">
<br>
I believe all the extra lines accomplish is a different exception<br>
RuntimeError with a custom message vs. plain AttributeError.<br>
<br>
I don&#39;t think the more elaborate exception is worth the extra code.<br>=
</blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Hmm,=
 shame. You&#39;re the boss :)</div><div dir=3D"auto"><br></div><div dir=3D=
"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 scripts/qapi/schema.py | 13 +++++++++++--<br>
&gt;=C2=A0 1 file changed, 11 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py<br>
&gt; index c9a194103e1..462acb2bb61 100644<br>
&gt; --- a/scripts/qapi/schema.py<br>
&gt; +++ b/scripts/qapi/schema.py<br>
&gt; @@ -366,7 +366,16 @@ def __init__(self, name, info, element_type):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 super().__init__(name, info, None)<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert isinstance(element_type, str)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._element_type_name =3D element_=
type<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.element_type =3D None<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._element_type: Optional[QAPISchemaTy=
pe] =3D None<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 @property<br>
&gt; +=C2=A0 =C2=A0 def element_type(self) -&gt; QAPISchemaType:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self._element_type is None:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise RuntimeError(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;QAPISch=
emaArray has no element_type until &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;after c=
heck() has been run.&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self._element_type<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 def need_has_if_optional(self):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # When FOO is an array, we still nee=
d has_FOO to distinguish<br>
&gt; @@ -375,7 +384,7 @@ def need_has_if_optional(self):<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 def check(self, schema):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 super().check(schema)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.element_type =3D schema.resolve_type=
(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._element_type =3D schema.resolve_typ=
e(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._element_type_nam=
e, <a href=3D"http://self.info" rel=3D"noreferrer noreferrer" target=3D"_bl=
ank">self.info</a>,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://self=
.info" rel=3D"noreferrer noreferrer" target=3D"_blank">self.info</a> and se=
lf.info.defn_meta)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert not isinstance(self.element_t=
ype, QAPISchemaArrayType)<br>
<br>
</blockquote></div></div></div>

--0000000000007e22ca060aac6b13--


