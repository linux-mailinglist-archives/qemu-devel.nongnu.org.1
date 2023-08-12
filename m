Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E974779F8C
	for <lists+qemu-devel@lfdr.de>; Sat, 12 Aug 2023 13:15:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUmZH-0007TH-My; Sat, 12 Aug 2023 07:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qUmZF-0007T7-N3
 for qemu-devel@nongnu.org; Sat, 12 Aug 2023 07:14:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qUmZD-0003rP-FH
 for qemu-devel@nongnu.org; Sat, 12 Aug 2023 07:14:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691838836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3WIA/AMDJPiBAJOPlwAWVftPis0DNsfCIMH5CQxAGgA=;
 b=ZN5ySu2JfBR3YbA1//YW2prWSWb7qWX3xJ2egHjzFHigg6TY+ADyPCF5MXnSgbMWDcwo8W
 zPlK037y08AskklVtL/boNArr5opT8CTx1n0v81oBf6ClZ8PYYQ/4vRUiDpII4EEs8Vz9p
 MvX47A7kGP9UgToN/BkLACgFCYrrAy8=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-XqIyUQqzPbmnYzM_hublGA-1; Sat, 12 Aug 2023 07:13:54 -0400
X-MC-Unique: XqIyUQqzPbmnYzM_hublGA-1
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-487190e1ebbso1322067e0c.2
 for <qemu-devel@nongnu.org>; Sat, 12 Aug 2023 04:13:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691838834; x=1692443634;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3WIA/AMDJPiBAJOPlwAWVftPis0DNsfCIMH5CQxAGgA=;
 b=H1AhUtIlWCM+5cJNZWNmLB2B724a+0hTU2t2VR6RIcPIJrEInZjJ3ruWuJlsCbiIzO
 r9rKnOCM/RJJwWSSkDWCSSb+i03EaQjjGg9IHBKGIDSUyvKO9fEfxd0HSiEG20EimTsS
 mZyqqcNIQ2g6tL1R/pxj4+2zPRD2Mf2c4EP2AhiI26hY6GQiirUVidg9HUGsjx7iii1n
 kgpiK00/XvlmLKYNqNkQJaw5OfoALBhej28OZOKzmilwmeK0Nip9Eg2lMyDy8ZpogWxU
 Fa+M6q+4/gL4noGVMn8ogK8n9zpU4ngw4Y5iFi0deWVVlj3Fd7Iz8NbAdQG58wmy9X0H
 mIAw==
X-Gm-Message-State: AOJu0Yx6XFU0iWswQdxz3DNC7h1B6EP1a1mGxYGiJ37hyK0h8bMe0vcA
 6TsCQqBozIMufSetRLIf1I8OK3+fL4NgX74ZC5eYXSKgfB4AEu+N42AJ5CCyKtCdsuxatMgoWAX
 xDakna/6hQprzdnX9ukoihAEIId5BRAk=
X-Received: by 2002:a1f:ebc1:0:b0:486:45cb:e203 with SMTP id
 j184-20020a1febc1000000b0048645cbe203mr5488665vkh.8.1691838834255; 
 Sat, 12 Aug 2023 04:13:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjFa7e/6WmJlktP1/gQMKSvxQyFxSQ5mgCsj6rH5Oh6wbKP7AE0Un4//WuvJVhyNAqZtqCNcBXr7jQh2KTemM=
X-Received: by 2002:a1f:ebc1:0:b0:486:45cb:e203 with SMTP id
 j184-20020a1febc1000000b0048645cbe203mr5488646vkh.8.1691838833959; Sat, 12
 Aug 2023 04:13:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230812061540.5398-1-akihiko.odaki@daynix.com>
 <8bb503c3-5b45-f686-a0d8-24799d69f6b1@tls.msk.ru>
 <c9f3232c-5103-410c-a158-e56d26331968@daynix.com>
In-Reply-To: <c9f3232c-5103-410c-a158-e56d26331968@daynix.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 12 Aug 2023 13:13:40 +0200
Message-ID: <CABgObfa1LpESDH+BGs3xr4R5vXn+Yt8a9VSKVwUVxXDjMnAGcw@mail.gmail.com>
Subject: Re: [PATCH] meson: Fix MESONINTROSPECT parsing
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel <qemu-devel@nongnu.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000b739220602b7ec4f"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

--000000000000b739220602b7ec4f
Content-Type: text/plain; charset="UTF-8"

Please apply this patch without my intervention, I won't have access to
Gitlab for a few days.

Paolo

Il sab 12 ago 2023, 11:16 Akihiko Odaki <akihiko.odaki@daynix.com> ha
scritto:

> On 2023/08/12 17:01, Michael Tokarev wrote:
> > 12.08.2023 09:15, Akihiko Odaki wrote:
> >> The arguments in MESONINTROSPECT are quoted with shlex.quote() so it
> >> must be parsed with shlex.split().
> >>
> >> Fixes: cf60ccc330 ("cutils: Introduce bundle mechanism")
> >> Reported-by: Michael Tokarev <mjt@tls.msk.ru>
> >> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >> ---
> >>   scripts/symlink-install-tree.py | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/scripts/symlink-install-tree.py
> >> b/scripts/symlink-install-tree.py
> >> index 8ed97e3c94..b72563895c 100644
> >> --- a/scripts/symlink-install-tree.py
> >> +++ b/scripts/symlink-install-tree.py
> >> @@ -4,6 +4,7 @@
> >>   import errno
> >>   import json
> >>   import os
> >> +import shlex
> >>   import subprocess
> >>   import sys
> >> @@ -14,7 +15,7 @@ def destdir_join(d1: str, d2: str) -> str:
> >>       return str(PurePath(d1, *PurePath(d2).parts[1:]))
> >>   introspect = os.environ.get('MESONINTROSPECT')
> >> -out = subprocess.run([*introspect.split(' '), '--installed'],
> >> +out = subprocess.run([*shlex.split(introspect), '--installed'],
> >>                        stdout=subprocess.PIPE, check=True).stdout
> >>   for source, dest in json.loads(out).items():
> >>       bundle_dest = destdir_join('qemu-bundle', dest)
> >
> > This fixes one of the two issues, - the script is being run
> > now without failures.
> >
> > Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
> > Tested-by: Michael Tokarev <mjt@tls.msk.ru>
> >
> > There's one more possible problem which is worth to fix, I'd say:
> > it is the fact that script failure is not detected in any way.
> > Shouldn't subprocess.run raise an exception in case of failure?
> > I think it needs check=True (since python 3.5 iirc).
>
> I missed that you noted this failure is not detected by configure. It is
> certainly better to fix.
>
> It does have check=True but it's rather a obfuscated way to say that
> when you can just use subprocess.check_output(). I sent another patch to
> use subprocess.check_output().
>
> The reason why configure does not detect the failure is that Meson
> ignores postconf script failures. I opened a pull request upstream:
> https://github.com/mesonbuild/meson/pull/12115
>
> Regards,
> Akihiko Odaki
>
>

--000000000000b739220602b7ec4f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Please apply this patch without my intervention, I won&#3=
9;t have access to Gitlab for a few days.<div dir=3D"auto"><br></div><div d=
ir=3D"auto">Paolo</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr=
" class=3D"gmail_attr">Il sab 12 ago 2023, 11:16 Akihiko Odaki &lt;<a href=
=3D"mailto:akihiko.odaki@daynix.com">akihiko.odaki@daynix.com</a>&gt; ha sc=
ritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex">On 2023/08/12 17:01, Michael=
 Tokarev wrote:<br>
&gt; 12.08.2023 09:15, Akihiko Odaki wrote:<br>
&gt;&gt; The arguments in MESONINTROSPECT are quoted with shlex.quote() so =
it<br>
&gt;&gt; must be parsed with shlex.split().<br>
&gt;&gt;<br>
&gt;&gt; Fixes: cf60ccc330 (&quot;cutils: Introduce bundle mechanism&quot;)=
<br>
&gt;&gt; Reported-by: Michael Tokarev &lt;<a href=3D"mailto:mjt@tls.msk.ru"=
 target=3D"_blank" rel=3D"noreferrer">mjt@tls.msk.ru</a>&gt;<br>
&gt;&gt; Signed-off-by: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@d=
aynix.com" target=3D"_blank" rel=3D"noreferrer">akihiko.odaki@daynix.com</a=
>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; =C2=A0 scripts/symlink-install-tree.py | 3 ++-<br>
&gt;&gt; =C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/scripts/symlink-install-tree.py <br>
&gt;&gt; b/scripts/symlink-install-tree.py<br>
&gt;&gt; index 8ed97e3c94..b72563895c 100644<br>
&gt;&gt; --- a/scripts/symlink-install-tree.py<br>
&gt;&gt; +++ b/scripts/symlink-install-tree.py<br>
&gt;&gt; @@ -4,6 +4,7 @@<br>
&gt;&gt; =C2=A0 import errno<br>
&gt;&gt; =C2=A0 import json<br>
&gt;&gt; =C2=A0 import os<br>
&gt;&gt; +import shlex<br>
&gt;&gt; =C2=A0 import subprocess<br>
&gt;&gt; =C2=A0 import sys<br>
&gt;&gt; @@ -14,7 +15,7 @@ def destdir_join(d1: str, d2: str) -&gt; str:<br=
>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return str(PurePath(d1, *PurePath(d=
2).parts[1:]))<br>
&gt;&gt; =C2=A0 introspect =3D os.environ.get(&#39;MESONINTROSPECT&#39;)<br=
>
&gt;&gt; -out =3D subprocess.run([*introspect.split(&#39; &#39;), &#39;--in=
stalled&#39;],<br>
&gt;&gt; +out =3D subprocess.run([*shlex.split(introspect), &#39;--installe=
d&#39;],<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stdout=
=3Dsubprocess.PIPE, check=3DTrue).stdout<br>
&gt;&gt; =C2=A0 for source, dest in json.loads(out).items():<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bundle_dest =3D destdir_join(&#39;q=
emu-bundle&#39;, dest)<br>
&gt; <br>
&gt; This fixes one of the two issues, - the script is being run<br>
&gt; now without failures.<br>
&gt; <br>
&gt; Reviewed-by: Michael Tokarev &lt;<a href=3D"mailto:mjt@tls.msk.ru" tar=
get=3D"_blank" rel=3D"noreferrer">mjt@tls.msk.ru</a>&gt;<br>
&gt; Tested-by: Michael Tokarev &lt;<a href=3D"mailto:mjt@tls.msk.ru" targe=
t=3D"_blank" rel=3D"noreferrer">mjt@tls.msk.ru</a>&gt;<br>
&gt; <br>
&gt; There&#39;s one more possible problem which is worth to fix, I&#39;d s=
ay:<br>
&gt; it is the fact that script failure is not detected in any way.<br>
&gt; Shouldn&#39;t subprocess.run raise an exception in case of failure?<br=
>
&gt; I think it needs check=3DTrue (since python 3.5 iirc).<br>
<br>
I missed that you noted this failure is not detected by configure. It is <b=
r>
certainly better to fix.<br>
<br>
It does have check=3DTrue but it&#39;s rather a obfuscated way to say that =
<br>
when you can just use subprocess.check_output(). I sent another patch to <b=
r>
use subprocess.check_output().<br>
<br>
The reason why configure does not detect the failure is that Meson <br>
ignores postconf script failures. I opened a pull request upstream:<br>
<a href=3D"https://github.com/mesonbuild/meson/pull/12115" rel=3D"noreferre=
r noreferrer" target=3D"_blank">https://github.com/mesonbuild/meson/pull/12=
115</a><br>
<br>
Regards,<br>
Akihiko Odaki<br>
<br>
</blockquote></div>

--000000000000b739220602b7ec4f--


