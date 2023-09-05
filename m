Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B0D79206D
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 08:01:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdP79-0007Ru-EG; Tue, 05 Sep 2023 02:00:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qdP76-0007Qz-R9
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 02:00:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qdP74-0003VS-E5
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 02:00:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693893633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+Q15gsoXB4jZg6t6m2ioP1nIcgUWDAZ71tljX7UIjA0=;
 b=UPnwfI535RM1m0G7WFfudJDJykTevkh/kSwz2PXOICfkDHgRxkau01qjs7v7zAP34ra6S/
 CzKOrykQ0JHkHGqrAOB1oOAaYN8cTETy40WiJ8y4CVaHanVeQ6rNOVJ8v9EMZixDVGHWFb
 Y7cM7Eu/5BR9k+O379GJtt4kyXn6lno=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-86FHeNlZNcGn8MRqcsPh4g-1; Tue, 05 Sep 2023 02:00:31 -0400
X-MC-Unique: 86FHeNlZNcGn8MRqcsPh4g-1
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-7a4ee7d28cfso701418241.0
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 23:00:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693893630; x=1694498430;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+Q15gsoXB4jZg6t6m2ioP1nIcgUWDAZ71tljX7UIjA0=;
 b=fHr044qC80qtZeT01QGqYszXNiMjCCy34EQNKlMIJBGUoFUOaHXHKu5g8YybMjKqxc
 YBAOkMLu9KP0mpcPeaa7mXW+pt8a2l/DM/wJmCqUHpYzxdf+SoxSQQmxyXhhiRqo/gsH
 cIADJP71MukQQpYInt21Gwoy2O5BUcXf6n0AsO6SV9LFKWRZAHh+d6PhwGTNUphgk18m
 C0Gn+SVWSXS8O1eigFMEfb0l4PRo57K6uGKFEHRkvA8VPFqGSCmW8HmdMOJeJmY4zs51
 D5MOYydSI3p7taqlzbT+0AIQ3DPnyNKBjV9ENFDRg+Ovo4pfNWOUlPY7BBtsK6fHHg11
 NmTQ==
X-Gm-Message-State: AOJu0Yx8BM9HKdAOUdJ1nsLmhR7LSWGtSy+eUOmFJAiVt/C7hVd0KmmQ
 pEj6oveH4TsHRGVZA+2Mpu1oKKAR++jHkzRGzgikhApYIlv+m9m4dMAD7+DtoDtklVvPaABdutZ
 T4jfPGDtjxixJi6EZZMqTVwi7PayOGEHDtR72niA=
X-Received: by 2002:a67:f7d4:0:b0:44d:482a:5444 with SMTP id
 a20-20020a67f7d4000000b0044d482a5444mr10074463vsp.21.1693893630424; 
 Mon, 04 Sep 2023 23:00:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6adQJrq0FM0UDkva9k4N5ylFKPuw1C9uUfc6/80WiRQeKr0x7EbvlbNeQGkzfe6F7c7CMzVLHN4v8q9HLnAY=
X-Received: by 2002:a67:f7d4:0:b0:44d:482a:5444 with SMTP id
 a20-20020a67f7d4000000b0044d482a5444mr10074457vsp.21.1693893630232; Mon, 04
 Sep 2023 23:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230904095720.154738-1-pbonzini@redhat.com>
 <20230904095720.154738-2-pbonzini@redhat.com>
 <2fdf3391-bef5-7d86-d066-1f687cec1285@linaro.org>
In-Reply-To: <2fdf3391-bef5-7d86-d066-1f687cec1285@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 5 Sep 2023 08:00:00 +0200
Message-ID: <CABgObfa-65y-y1u=ztQ9RdaP7ub7VZAoDjm9e+q8xmCwkxgtSw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] Python: Drop support for Python 3.7
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, John Snow <jsnow@redhat.com>, 
 "Armbruster, Markus" <armbru@redhat.com>, "Maydell,
 Peter" <peter.maydell@linaro.org>, 
 "P. Berrange, Daniel" <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000001e1fb3060496586c"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000001e1fb3060496586c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il lun 4 set 2023, 12:34 Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> ha
scritto:

> > Since it is safe to under our supported platform policy, bump our
>
> Is 'under' a verb? This sentence is not obvious to me.
>

No, just drop "to".

Paolo


> > minimum supported version of Python to 3.8.  The two most interesting
> > features to have by default include:
> >
> > - the importlib.metadata module, whose lack is responsible for over 100
> >    lines of code in mkvenv.py
> >
> > - improvements to asyncio, for example asyncio.CancelledError
> >    inherits from BaseException rather than Exception
> >
> > In addition, code can now use the assignment operator ':=3D'
> >
> > Because mypy now learns about importlib.metadata, a small change to
> > mkvenv.py is needed to pass type checking.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >   configure                | 8 ++++----
> >   python/Makefile          | 8 ++++----
> >   python/scripts/mkvenv.py | 5 ++++-
> >   python/setup.cfg         | 7 +++----
> >   python/tests/minreqs.txt | 2 +-
> >   scripts/qapi/mypy.ini    | 2 +-
> >   6 files changed, 17 insertions(+), 15 deletions(-)
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
>

--0000000000001e1fb3060496586c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il lun 4 set 2023, 12:34 Philippe Mathieu-Daud=C3=A9 &=
lt;<a href=3D"mailto:philmd@linaro.org">philmd@linaro.org</a>&gt; ha scritt=
o:</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex">
&gt; Since it is safe to under our supported platform policy, bump our<br>
<br>
Is &#39;under&#39; a verb? This sentence is not obvious to me.<br></blockqu=
ote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">No, just drop=
 &quot;to&quot;.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</=
div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote=
"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">
<br>
&gt; minimum supported version of Python to 3.8.=C2=A0 The two most interes=
ting<br>
&gt; features to have by default include:<br>
&gt; <br>
&gt; - the importlib.metadata module, whose lack is responsible for over 10=
0<br>
&gt;=C2=A0 =C2=A0 lines of code in mkvenv.py<br>
&gt; <br>
&gt; - improvements to asyncio, for example asyncio.CancelledError<br>
&gt;=C2=A0 =C2=A0 inherits from BaseException rather than Exception<br>
&gt; <br>
&gt; In addition, code can now use the assignment operator &#39;:=3D&#39;<b=
r>
&gt; <br>
&gt; Because mypy now learns about importlib.metadata, a small change to<br=
>
&gt; mkvenv.py is needed to pass type checking.<br>
&gt; <br>
&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0configure=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 8 ++++----<br>
&gt;=C2=A0 =C2=A0python/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 8 ++++=
----<br>
&gt;=C2=A0 =C2=A0python/scripts/mkvenv.py | 5 ++++-<br>
&gt;=C2=A0 =C2=A0python/setup.cfg=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 7 +++-=
---<br>
&gt;=C2=A0 =C2=A0python/tests/minreqs.txt | 2 +-<br>
&gt;=C2=A0 =C2=A0scripts/qapi/mypy.ini=C2=A0 =C2=A0 | 2 +-<br>
&gt;=C2=A0 =C2=A06 files changed, 17 insertions(+), 15 deletions(-)<br>
<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linar=
o.org" target=3D"_blank" rel=3D"noreferrer">philmd@linaro.org</a>&gt;<br>
<br>
</blockquote></div></div></div>

--0000000000001e1fb3060496586c--


