Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5597659E8
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 19:18:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP4B8-00032z-Kq; Thu, 27 Jul 2023 12:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qP4B6-00032J-Ny
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 12:49:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qP4B3-0006u3-Uj
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 12:49:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690476564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=29BVWrILiTlj/BiZK2zZ55yG6ZUSihzfdwxv60khtH4=;
 b=ZO8QT+KCY1DpNtgKSXlCShCZF6RAGPpIFgViJEuE/WTVTKg+ZotVYqfMXqzmJKC7/swOQR
 25jX89g+v8GAuWGgU6RIapv+it9q6x02v3T8khFD0nVerzKTBfTQEz0oRaQcRa0eL1Y2my
 eSohku2gKPQCC5jP0lgR/Ab5bOhuDfk=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-IPTCRZW3PPaZQ7Be1m7a4w-1; Thu, 27 Jul 2023 12:49:23 -0400
X-MC-Unique: IPTCRZW3PPaZQ7Be1m7a4w-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-267f1559391so720603a91.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 09:49:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690476562; x=1691081362;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=29BVWrILiTlj/BiZK2zZ55yG6ZUSihzfdwxv60khtH4=;
 b=fXsYnxGngAk5tTUGolZ7VuJEGXL9Vr5TKrMkaxmFGYi+O0n3p8zxv9zqgQhoiGSbX9
 S1IRO+t1IrFVgahdXcWmVQC2ClRtuOSD4fNaEmaqPT9+ZEr5ixjnCUGTeIPi39nAttyP
 P1zGeA060UfdJ2uLRTvNrZypesd8jEyKC5kJ5kSJTBGuQvjaWgnh9fbHLS2LPQhFo9j3
 Wz+CGUCWyku7MjK84xSLjQs/W/hAdPt3n5eaj4e3VJxlUFGpPOuClyh93Tk0os7wR5My
 E8Sj0qm84fYKj5wlCn428CTSiUPYvgup6JUSJzaYjgPCP8KE91J6DLFc5mREJKftbBs6
 zGig==
X-Gm-Message-State: ABy/qLbCb0sM9DgPAUs6PS/vpUwFVUnUSDc7D3wVqXH3O1mlHWl5AzJQ
 9v5/IEBHb6hVQPI11GqlTUsQfwUaKK5+sxTdkBb/QYOEm44aMKnIeZqPNJWsdC6/dyX2crwwSEI
 ItWDJq/OubflNc9YeLrYIbIDo4vcx22MAvaTBBOc=
X-Received: by 2002:a17:90b:ed3:b0:263:f7ce:335e with SMTP id
 gz19-20020a17090b0ed300b00263f7ce335emr4339552pjb.43.1690476561766; 
 Thu, 27 Jul 2023 09:49:21 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFVgIKiLahUWjnXGC6TsQawmqwyX38TBwoyX8/J1iS76idM0PvtU+XGJz4hzhh18vj0fYW5ggQFQHVmoTbingk=
X-Received: by 2002:a17:90b:ed3:b0:263:f7ce:335e with SMTP id
 gz19-20020a17090b0ed300b00263f7ce335emr4339543pjb.43.1690476561395; Thu, 27
 Jul 2023 09:49:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAFn=p-aKWG7r2zRdQ-O6kod_jVOTMELGi_ObbKBAM=9ZgXt7Ww@mail.gmail.com>
 <ZMJLOJYueAWYA1mN@redhat.com>
In-Reply-To: <ZMJLOJYueAWYA1mN@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Thu, 27 Jul 2023 12:49:10 -0400
Message-ID: <CAFn=p-Z+Tn08gGa2vb+RRYF=0PLys+qL6wMw+vLN-eXAzUh=vg@mail.gmail.com>
Subject: Re: Implementing "tee" in python asyncio
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000f1890e06017abeab"
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

--000000000000f1890e06017abeab
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2023, 6:47 AM Daniel P. Berrang=C3=A9 <berrange@redhat.com>
wrote:

> On Wed, Jul 26, 2023 at 04:25:34PM -0400, John Snow wrote:
> > Hi folks,
> >
> > I'm currently wondering how to take a StreamReader as found on
> >
> https://docs.python.org/3/library/asyncio-subprocess.html#asyncio.subproc=
ess.Process
> > and to consume the data while optionally re-streaming it to a
> > secondary consumer.
> >
> > What I'd like to do is create a StreamWatcher class that consumes
> > console data while optionally logging to python logging and/or a file;
> > but re-buffers the data into an async stream where an additional
> > consumer is free to use the "standard asyncio API" to consume console
> > data at their leisure in a way that's unsurprising.
> >
> > What I'd like this *for* is to be able to do aggressive logging of
> > stdout/stderr and console data without denying tests the ability to
> > consume the data as they see fit for their testing purposes. I want to
> > have my cake and eat it too, and we don't do a good job of managing
> > this consistently across the board.
> >
> > I am wondering if there's any way around creating a literal socketpair
> > and suffering the creation of a full four StreamReader/StreamWriter
> > instances (one pair per socket...) and then just hanging on to the
> > "unused" reader/writer per each. It seems kind of foolishly excessive.
> > It also seems like it might be a pain in the butt if I want
> > cross-platform compatibility with windows for the machine appliance.
> >
> > Anyone got any bright ideas?
>
> Don't bother with any of the above, just add 'logfile=3D/path/to/log'
> to the -chardev argument.
>

Part of me feels like it'd be a shame to miss out on the chance to do the
logging in the library, but it *would* be a lot easier to just not worry
about it.

>
anyway, this is easy for console, what about stdio? is there a way to run
that through a chardev that's just connected to stdio but we attach a
logfile?


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

--000000000000f1890e06017abeab
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, Jul 27, 2023, 6:47 AM Daniel P. Berrang=C3=A9 =
&lt;<a href=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">On Wed, Jul 26, 2023 at 04:25:34=
PM -0400, John Snow wrote:<br>
&gt; Hi folks,<br>
&gt; <br>
&gt; I&#39;m currently wondering how to take a StreamReader as found on<br>
&gt; <a href=3D"https://docs.python.org/3/library/asyncio-subprocess.html#a=
syncio.subprocess.Process" rel=3D"noreferrer noreferrer" target=3D"_blank">=
https://docs.python.org/3/library/asyncio-subprocess.html#asyncio.subproces=
s.Process</a><br>
&gt; and to consume the data while optionally re-streaming it to a<br>
&gt; secondary consumer.<br>
&gt; <br>
&gt; What I&#39;d like to do is create a StreamWatcher class that consumes<=
br>
&gt; console data while optionally logging to python logging and/or a file;=
<br>
&gt; but re-buffers the data into an async stream where an additional<br>
&gt; consumer is free to use the &quot;standard asyncio API&quot; to consum=
e console<br>
&gt; data at their leisure in a way that&#39;s unsurprising.<br>
&gt; <br>
&gt; What I&#39;d like this *for* is to be able to do aggressive logging of=
<br>
&gt; stdout/stderr and console data without denying tests the ability to<br=
>
&gt; consume the data as they see fit for their testing purposes. I want to=
<br>
&gt; have my cake and eat it too, and we don&#39;t do a good job of managin=
g<br>
&gt; this consistently across the board.<br>
&gt; <br>
&gt; I am wondering if there&#39;s any way around creating a literal socket=
pair<br>
&gt; and suffering the creation of a full four StreamReader/StreamWriter<br=
>
&gt; instances (one pair per socket...) and then just hanging on to the<br>
&gt; &quot;unused&quot; reader/writer per each. It seems kind of foolishly =
excessive.<br>
&gt; It also seems like it might be a pain in the butt if I want<br>
&gt; cross-platform compatibility with windows for the machine appliance.<b=
r>
&gt; <br>
&gt; Anyone got any bright ideas?<br>
<br>
Don&#39;t bother with any of the above, just add &#39;logfile=3D/path/to/lo=
g&#39;<br>
to the -chardev argument.<br></blockquote></div></div><div dir=3D"auto"><br=
></div><div dir=3D"auto">Part of me feels like it&#39;d be a shame to miss =
out on the chance to do the logging in the library, but it *would* be a lot=
 easier to just not worry about it.</div><div dir=3D"auto"><div class=3D"gm=
ail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex"></blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">anyway, this is easy for console, wha=
t about stdio? is there a way to run that through a chardev that&#39;s just=
 connected to stdio but we attach a logfile?=C2=A0</div><div dir=3D"auto"><=
br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">
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

--000000000000f1890e06017abeab--


