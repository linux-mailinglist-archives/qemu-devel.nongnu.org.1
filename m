Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1051D765A7F
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 19:36:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP4JN-0005t6-EP; Thu, 27 Jul 2023 12:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qP4JK-0005su-6s
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 12:57:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qP4Iz-0001Ir-7G
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 12:57:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690477056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l8ckzjPwir78HT0GjuYrlbpQl3qKpFIfwFeQxwaMtww=;
 b=EHIehpDKoFkvys+aAIxninMnTEEZOhXe79K0IONfC0bT3SorIq/ZbTRv/K+OKWnKmt16Lu
 Ijufw5VB3sEF/RRM9eZa1yKtclz/gpvawNnTii3SFMh7sl0dD4tDvbbTeTwLCehFunFkUw
 z14X5AQV9Prskn9cdGsVQBwy+mVnHTQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-CcVkurklPr2nOvLr7kq69g-1; Thu, 27 Jul 2023 12:57:34 -0400
X-MC-Unique: CcVkurklPr2nOvLr7kq69g-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-267f61da571so1080941a91.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 09:57:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690477053; x=1691081853;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l8ckzjPwir78HT0GjuYrlbpQl3qKpFIfwFeQxwaMtww=;
 b=cJsDxu5USooKvaKw49lq72qW0u5Y5+2TzGjtwCHyz2Bkac2HCmWG57a+qeovvmH6MU
 Lhxo8yIi7wRtFUNz4AxenVOL6Ne5yr+AnurJjwoXaKcD3EBJid7jd15EIHP7purZ/p1p
 SCoJbXh+JkMwU2Oixh/we7hR0Fh5hihCnVrBeQqbp1BJcqB3RadXbt399338fJW/8CoB
 mB+glZDOAXe+hUGv0/w/UU0sn/1kFAulZWc0g1b0n550ZW7nguyWoJyEyWd2mfvQGYKd
 xFVk4799DewEYSa9VPDlxZO3n/4KoROKxtXugz9W/YW6ae3ofvWgqwx+K2xRu4mLtZyd
 WO3Q==
X-Gm-Message-State: ABy/qLbcRWML42Sw34dpZf5d/bSoendQqYlnId6mn18eOJScQl17+rPv
 BkrrywdC010RsLIfAx+zRWK3etUp7AMjPl82fdMIB0Cubi2j715PJRe2B0/CYAnCjl0Hgz9w7Ou
 TM1jXJ/4e99wwgY2sG8Xa84I53fWcEiI=
X-Received: by 2002:a17:90a:2fc8:b0:268:51ab:a84a with SMTP id
 n8-20020a17090a2fc800b0026851aba84amr5024505pjm.4.1690477052965; 
 Thu, 27 Jul 2023 09:57:32 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE6IzsY8epr6BhaP9TGLBYLzkdchJzZFhqWas/9v+HL/Erm2qMVISLuvm+UAbjLAUIuYUtGoBZY0IUEPQWoxVA=
X-Received: by 2002:a17:90a:2fc8:b0:268:51ab:a84a with SMTP id
 n8-20020a17090a2fc800b0026851aba84amr5024495pjm.4.1690477052649; Thu, 27 Jul
 2023 09:57:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAFn=p-aKWG7r2zRdQ-O6kod_jVOTMELGi_ObbKBAM=9ZgXt7Ww@mail.gmail.com>
 <ZMJLOJYueAWYA1mN@redhat.com>
 <CAFn=p-Z+Tn08gGa2vb+RRYF=0PLys+qL6wMw+vLN-eXAzUh=vg@mail.gmail.com>
 <ZMKg9QY8+2D3GKxO@redhat.com>
In-Reply-To: <ZMKg9QY8+2D3GKxO@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Thu, 27 Jul 2023 12:57:20 -0400
Message-ID: <CAFn=p-Y+H_5iHQyzsUshg+BAdLPuwK7yN=qhOeK7eodW7ZeXWA@mail.gmail.com>
Subject: Re: Implementing "tee" in python asyncio
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000397e9006017adc24"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

--000000000000397e9006017adc24
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2023, 12:53 PM Daniel P. Berrang=C3=A9 <berrange@redhat.com=
>
wrote:

> On Thu, Jul 27, 2023 at 12:49:10PM -0400, John Snow wrote:
> > On Thu, Jul 27, 2023, 6:47 AM Daniel P. Berrang=C3=A9 <berrange@redhat.=
com>
> > wrote:
> >
> > > On Wed, Jul 26, 2023 at 04:25:34PM -0400, John Snow wrote:
> > > > Hi folks,
> > > >
> > > > I'm currently wondering how to take a StreamReader as found on
> > > >
> > >
> https://docs.python.org/3/library/asyncio-subprocess.html#asyncio.subproc=
ess.Process
> > > > and to consume the data while optionally re-streaming it to a
> > > > secondary consumer.
> > > >
> > > > What I'd like to do is create a StreamWatcher class that consumes
> > > > console data while optionally logging to python logging and/or a
> file;
> > > > but re-buffers the data into an async stream where an additional
> > > > consumer is free to use the "standard asyncio API" to consume conso=
le
> > > > data at their leisure in a way that's unsurprising.
> > > >
> > > > What I'd like this *for* is to be able to do aggressive logging of
> > > > stdout/stderr and console data without denying tests the ability to
> > > > consume the data as they see fit for their testing purposes. I want
> to
> > > > have my cake and eat it too, and we don't do a good job of managing
> > > > this consistently across the board.
> > > >
> > > > I am wondering if there's any way around creating a literal
> socketpair
> > > > and suffering the creation of a full four StreamReader/StreamWriter
> > > > instances (one pair per socket...) and then just hanging on to the
> > > > "unused" reader/writer per each. It seems kind of foolishly
> excessive.
> > > > It also seems like it might be a pain in the butt if I want
> > > > cross-platform compatibility with windows for the machine appliance=
.
> > > >
> > > > Anyone got any bright ideas?
> > >
> > > Don't bother with any of the above, just add 'logfile=3D/path/to/log'
> > > to the -chardev argument.
> > >
> >
> > Part of me feels like it'd be a shame to miss out on the chance to do t=
he
> > logging in the library, but it *would* be a lot easier to just not worr=
y
> > about it.
> >
> > anyway, this is easy for console, what about stdio? is there a way to r=
un
> > that through a chardev that's just connected to stdio but we attach a
> > logfile?
>
> When you say 'stdio' are you refering to a '-chardev stdio' backend, or
> simply whatever the python code dup()s onto stdio when spawnnig QEMU ?
> The former case can use ',logfile=3D...', and in the latter case we could
> open a log file and dup() its FD onto stdout/stderr when spawning QEMU.
>

I mean stdout and stderr for the QEMU process itself. Some tests like to
watch the output for various strings, but we also need to capture and log
that output to be able to show it during unhandled exceptions, etc.


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
>

--000000000000397e9006017adc24
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, Jul 27, 2023, 12:53 PM Daniel P. Berrang=C3=A9=
 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">On Thu, Jul 27, 2023 at 12:49:1=
0PM -0400, John Snow wrote:<br>
&gt; On Thu, Jul 27, 2023, 6:47 AM Daniel P. Berrang=C3=A9 &lt;<a href=3D"m=
ailto:berrange@redhat.com" target=3D"_blank" rel=3D"noreferrer">berrange@re=
dhat.com</a>&gt;<br>
&gt; wrote:<br>
&gt; <br>
&gt; &gt; On Wed, Jul 26, 2023 at 04:25:34PM -0400, John Snow wrote:<br>
&gt; &gt; &gt; Hi folks,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I&#39;m currently wondering how to take a StreamReader as fo=
und on<br>
&gt; &gt; &gt;<br>
&gt; &gt; <a href=3D"https://docs.python.org/3/library/asyncio-subprocess.h=
tml#asyncio.subprocess.Process" rel=3D"noreferrer noreferrer" target=3D"_bl=
ank">https://docs.python.org/3/library/asyncio-subprocess.html#asyncio.subp=
rocess.Process</a><br>
&gt; &gt; &gt; and to consume the data while optionally re-streaming it to =
a<br>
&gt; &gt; &gt; secondary consumer.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; What I&#39;d like to do is create a StreamWatcher class that=
 consumes<br>
&gt; &gt; &gt; console data while optionally logging to python logging and/=
or a file;<br>
&gt; &gt; &gt; but re-buffers the data into an async stream where an additi=
onal<br>
&gt; &gt; &gt; consumer is free to use the &quot;standard asyncio API&quot;=
 to consume console<br>
&gt; &gt; &gt; data at their leisure in a way that&#39;s unsurprising.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; What I&#39;d like this *for* is to be able to do aggressive =
logging of<br>
&gt; &gt; &gt; stdout/stderr and console data without denying tests the abi=
lity to<br>
&gt; &gt; &gt; consume the data as they see fit for their testing purposes.=
 I want to<br>
&gt; &gt; &gt; have my cake and eat it too, and we don&#39;t do a good job =
of managing<br>
&gt; &gt; &gt; this consistently across the board.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I am wondering if there&#39;s any way around creating a lite=
ral socketpair<br>
&gt; &gt; &gt; and suffering the creation of a full four StreamReader/Strea=
mWriter<br>
&gt; &gt; &gt; instances (one pair per socket...) and then just hanging on =
to the<br>
&gt; &gt; &gt; &quot;unused&quot; reader/writer per each. It seems kind of =
foolishly excessive.<br>
&gt; &gt; &gt; It also seems like it might be a pain in the butt if I want<=
br>
&gt; &gt; &gt; cross-platform compatibility with windows for the machine ap=
pliance.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Anyone got any bright ideas?<br>
&gt; &gt;<br>
&gt; &gt; Don&#39;t bother with any of the above, just add &#39;logfile=3D/=
path/to/log&#39;<br>
&gt; &gt; to the -chardev argument.<br>
&gt; &gt;<br>
&gt; <br>
&gt; Part of me feels like it&#39;d be a shame to miss out on the chance to=
 do the<br>
&gt; logging in the library, but it *would* be a lot easier to just not wor=
ry<br>
&gt; about it.<br>
&gt; <br>
&gt; anyway, this is easy for console, what about stdio? is there a way to =
run<br>
&gt; that through a chardev that&#39;s just connected to stdio but we attac=
h a<br>
&gt; logfile?<br>
<br>
When you say &#39;stdio&#39; are you refering to a &#39;-chardev stdio&#39;=
 backend, or<br>
simply whatever the python code dup()s onto stdio when spawnnig QEMU ?<br>
The former case can use &#39;,logfile=3D...&#39;, and in the latter case we=
 could<br>
open a log file and dup() its FD onto stdout/stderr when spawning QEMU.<br>=
</blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">I me=
an stdout and stderr for the QEMU process itself. Some tests like to watch =
the output for various strings, but we also need to capture and log that ou=
tput to be able to show it during unhandled exceptions, etc.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
<br>
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
er" target=3D"_blank">https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div></div></div>

--000000000000397e9006017adc24--


