Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 969B57F33B5
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 17:30:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5TcH-00056b-6f; Tue, 21 Nov 2023 11:28:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r5TcE-000562-0D
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 11:28:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r5Tc3-0001xX-98
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 11:28:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700584114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IAM3vTV3C+kSrl5CA8Q7g3veLiDe+ByrDnpUe0UROaY=;
 b=CjaiTIhXqgJ134hlWcCZrUdY5pNhwMM7sxaTS1tdxhh+aMXAIbYYH53EZmL0R11PeKcjNC
 z3OnsBrV44jJZ4GvstM1mGRii2sfyEBHATPM6GMzexU+wl0e9SmqVFrmXRVIjAOlzLOvYI
 wUDt7t4ko2jm7tRGtHFjFJXVIke9kVo=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-olEWaISjP1y7tt3VZX4DeQ-1; Tue, 21 Nov 2023 11:28:32 -0500
X-MC-Unique: olEWaISjP1y7tt3VZX4DeQ-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-28004d4462dso8341905a91.0
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 08:28:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700584109; x=1701188909;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IAM3vTV3C+kSrl5CA8Q7g3veLiDe+ByrDnpUe0UROaY=;
 b=Z4PvS4K6usVr5a+OiTEWNk+e+tHZioIoFZwtE3LhTO4ir9sLy/FdlrMlk28Eyb+bgx
 9lwMuvaiEkKXrsBIprD2uYO49eCsDjUPRpX4uyB+sYMisXCgctJifL/hNDjeOz5YlaUI
 N+JH1qaSElJBSCROmu/5Pd2L3LfVCTvC49EWQTA3z0/kDBKoLuzpRf1e+YEhHF1pablo
 oMy3DlR2fm7fqjiUCcQ2NjkGUINs5MS2e8Km/fE58E8rBjyhXvGXfgqdkNgWVNHH5jPJ
 N50JcNXYXkXgprufb00bzeWLcLYBdaBH+UwN/lr90Qb9+0Zbikx9REkwBz7FjmJuWBVN
 qMZw==
X-Gm-Message-State: AOJu0YwNuUOEcq/uXWzWBwPzBr+yEGg4P2Pwbv5HF/lknO7aCp7xEmIK
 jwStVedQOxS0zzWp3Ln1S7T6yIT7aHpZeqqwmTHgx6384/lEKJemiuiW9c5gdOLMbQzyFJJne6Q
 Se8IKsEHTJLWuPBCE4ixRqOLivXnbvns=
X-Received: by 2002:a17:90b:17c6:b0:280:cc88:2a46 with SMTP id
 me6-20020a17090b17c600b00280cc882a46mr11409056pjb.4.1700584108858; 
 Tue, 21 Nov 2023 08:28:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECmo5jDpUJgE3OfXcxDI/79iVCaIdMA12VbQHlkThQIkmCyp54TdR4aIUV6voI6QBqtj/AfG4+8RsnyNOHfcM=
X-Received: by 2002:a17:90b:17c6:b0:280:cc88:2a46 with SMTP id
 me6-20020a17090b17c600b00280cc882a46mr11409039pjb.4.1700584108503; Tue, 21
 Nov 2023 08:28:28 -0800 (PST)
MIME-Version: 1.0
References: <20231116014350.653792-1-jsnow@redhat.com>
 <20231116014350.653792-6-jsnow@redhat.com>
 <87jzqb4495.fsf@pond.sub.org> <ZVy0BAmoJ3ZcWg8q@redhat.com>
In-Reply-To: <ZVy0BAmoJ3ZcWg8q@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 21 Nov 2023 11:28:17 -0500
Message-ID: <CAFn=p-b76n31iBw3JQ3ofQwWofBjAEF-bGXZpOVLMJms9akvxg@mail.gmail.com>
Subject: Re: [PATCH 05/19] qapi/schema: make c_type() and json_type() abstract
 methods
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000b2d283060aac1758"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--000000000000b2d283060aac1758
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023, 8:43 AM Daniel P. Berrang=C3=A9 <berrange@redhat.com>
wrote:

> On Tue, Nov 21, 2023 at 02:36:54PM +0100, Markus Armbruster wrote:
> > John Snow <jsnow@redhat.com> writes:
> >
> > > These methods should always return a str, it's only the default
> abstract
> > > implementation that doesn't. They can be marked "abstract" by raising
> > > NotImplementedError(), which requires subclasses to override the meth=
od
> > > with the proper return type.
> > >
> > > Signed-off-by: John Snow <jsnow@redhat.com>
> > > ---
> > >  scripts/qapi/schema.py | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> > > index c5fdd625452..4600a566005 100644
> > > --- a/scripts/qapi/schema.py
> > > +++ b/scripts/qapi/schema.py
> > > @@ -233,8 +233,8 @@ def visit(self, visitor):
> > >  class QAPISchemaType(QAPISchemaEntity):
> > >      # Return the C type for common use.
> > >      # For the types we commonly box, this is a pointer type.
> > > -    def c_type(self):
> > > -        pass
> > > +    def c_type(self) -> str:
> > > +        raise NotImplementedError()
> > >
> > >      # Return the C type to be used in a parameter list.
> > >      def c_param_type(self):
> > > @@ -244,8 +244,8 @@ def c_param_type(self):
> > >      def c_unboxed_type(self):
> > >          return self.c_type()
> > >
> > > -    def json_type(self):
> > > -        pass
> > > +    def json_type(self) -> str:
> > > +        raise NotImplementedError()
> > >
> > >      def alternate_qtype(self):
> > >          json2qtype =3D {
> >
> > I wish abstract methods could be done in a more concise way.
>
> The canonical way would be to use the 'abc' module:
>
>   from abc import ABCMeta, abstractmethod
>
>   class A(metaclass=3DABCMeta):
>       @abstractmethod
>       def foo(self): pass
>
> Not sure if the @abstractmethod decorator is enough to keep the static
> typing checker happy about a 'str' return type, when there is no body
> impl
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>

In practice, I'm under the belief that mypy and pylint both recognize a
method raising NotImplementedError as marking an abstract method without
needing to explicitly inherit from the ABC.

I suppose there's also
https://docs.python.org/3/library/abc.html#abc.abstractmethod which I am
guessing just does this same thing. I'll see what makes mypy happy. I'm
assuming Markus would like to see something like this decorator to make it
more obvious that it's an abstract method.

--js

>

--000000000000b2d283060aac1758
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Tue, Nov 21, 2023, 8:43 AM Daniel P. Berrang=C3=A9 =
&lt;<a href=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">On Tue, Nov 21, 2023 at 02:36:54=
PM +0100, Markus Armbruster wrote:<br>
&gt; John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank" re=
l=3D"noreferrer">jsnow@redhat.com</a>&gt; writes:<br>
&gt; <br>
&gt; &gt; These methods should always return a str, it&#39;s only the defau=
lt abstract<br>
&gt; &gt; implementation that doesn&#39;t. They can be marked &quot;abstrac=
t&quot; by raising<br>
&gt; &gt; NotImplementedError(), which requires subclasses to override the =
method<br>
&gt; &gt; with the proper return type.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" =
target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 scripts/qapi/schema.py | 8 ++++----<br>
&gt; &gt;=C2=A0 1 file changed, 4 insertions(+), 4 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py<br>
&gt; &gt; index c5fdd625452..4600a566005 100644<br>
&gt; &gt; --- a/scripts/qapi/schema.py<br>
&gt; &gt; +++ b/scripts/qapi/schema.py<br>
&gt; &gt; @@ -233,8 +233,8 @@ def visit(self, visitor):<br>
&gt; &gt;=C2=A0 class QAPISchemaType(QAPISchemaEntity):<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 # Return the C type for common use.<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 # For the types we commonly box, this is a po=
inter type.<br>
&gt; &gt; -=C2=A0 =C2=A0 def c_type(self):<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 pass<br>
&gt; &gt; +=C2=A0 =C2=A0 def c_type(self) -&gt; str:<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise NotImplementedError()<br>
&gt; &gt;=C2=A0 <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 # Return the C type to be used in a parameter=
 list.<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 def c_param_type(self):<br>
&gt; &gt; @@ -244,8 +244,8 @@ def c_param_type(self):<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 def c_unboxed_type(self):<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return self.c_type()<br>
&gt; &gt;=C2=A0 <br>
&gt; &gt; -=C2=A0 =C2=A0 def json_type(self):<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 pass<br>
&gt; &gt; +=C2=A0 =C2=A0 def json_type(self) -&gt; str:<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise NotImplementedError()<br>
&gt; &gt;=C2=A0 <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 def alternate_qtype(self):<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 json2qtype =3D {<br>
&gt; <br>
&gt; I wish abstract methods could be done in a more concise way.<br>
<br>
The canonical way would be to use the &#39;abc&#39; module:<br>
<br>
=C2=A0 from abc import ABCMeta, abstractmethod<br>
<br>
=C2=A0 class A(metaclass=3DABCMeta):<br>
=C2=A0 =C2=A0 =C2=A0 @abstractmethod<br>
=C2=A0 =C2=A0 =C2=A0 def foo(self): pass<br>
<br>
Not sure if the @abstractmethod decorator is enough to keep the static<br>
typing checker happy about a &#39;str&#39; return type, when there is no bo=
dy<br>
impl<br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer noreferrer" target=3D=
"_blank">https://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a h=
ref=3D"https://www.flickr.com/photos/dberrange" rel=3D"noreferrer noreferre=
r" target=3D"_blank">https://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer noreferrer" target=3D"=
_blank">https://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com=
" rel=3D"noreferrer noreferrer" target=3D"_blank">https://fstop138.berrange=
.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer noreferrer" tar=
get=3D"_blank">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0=
 <a href=3D"https://www.instagram.com/dberrange" rel=3D"noreferrer noreferr=
er" target=3D"_blank">https://www.instagram.com/dberrange</a> :|<br></block=
quote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">In practice=
, I&#39;m under the belief that mypy and pylint both recognize a method rai=
sing NotImplementedError as marking an abstract method without needing to e=
xplicitly inherit from the ABC.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">I suppose there&#39;s also=C2=A0<a href=3D"https://docs.python.or=
g/3/library/abc.html#abc.abstractmethod">https://docs.python.org/3/library/=
abc.html#abc.abstractmethod</a> which I am guessing just does this same thi=
ng. I&#39;ll see what makes mypy happy. I&#39;m assuming Markus would like =
to see something like this decorator to make it more obvious that it&#39;s =
an abstract method.</div><div dir=3D"auto"><br></div><div dir=3D"auto">--js=
</div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex"></blockquote></div></div></div>

--000000000000b2d283060aac1758--


