Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D038274CF62
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 10:04:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIlsG-0004HJ-93; Mon, 10 Jul 2023 04:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qIlsD-0004Gi-JH
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 04:03:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qIlsB-0004oT-RS
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 04:03:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688976235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5dKGGPs0xGQFxDtcvg//MxKuGRvdNQr7diJY6BqzmUU=;
 b=EVax7KX4s8rmw8YJhVAliS9F90WZpBeUmflUativPyEwTuIHnVf988e+uJbi+qGK2SpgBU
 ln2NgpiqD4TJZSps6RfMlVvAq5HBmPMCxdDPfd/I+mjA51d8VQRKg2idq/TOUfbltJEEYQ
 CpOfY5wSSX2BmjZb+jWEQKtQbalwFOw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-IMTGIsn3OYKL46nFEPGqBQ-1; Mon, 10 Jul 2023 04:03:53 -0400
X-MC-Unique: IMTGIsn3OYKL46nFEPGqBQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b6ad424a46so38173131fa.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 01:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688976232; x=1691568232;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5dKGGPs0xGQFxDtcvg//MxKuGRvdNQr7diJY6BqzmUU=;
 b=Nde2xie62jhyPPl3hfdB+cV4zI4uMQxgnsWUU0bCdwOfBsKDQL7Sms2/37XmsjU8bc
 0Ua4/M24xqe5ysAEWxQFCp/nT4J76ol1jfvYaA24JIvf/v83SYqIJGB8eFrU/c52qBE5
 +nsrwiXsXc12ZIFF7eMETFLhzt1n8/U4fcqj7YIdvEaqAyJVZZzRU2itMXgwfzqf/CFR
 oO+Btvb1GiC3kX928dd8QaQS1kbcOHMMLJdxn3A662smU1Dsy6IKx7DWLcAL3KwOgg14
 Ip61IULcD9mTj1UA6D2s4sEoR847alvFyEFHk66sZhf4pPm2el5JmWZGJFICzrjfbWxs
 Vamg==
X-Gm-Message-State: ABy/qLZieS6q6sgBw4Xk5LCXhBc8wqjwLZqqTDqCOy9eEvVn4spuUwMT
 Oz3hyuwv8ZT9pKikimJ1XwrDkrVVymBbMO4+V5OSmc6m9Q+I8DxY95Qvke713QjtIfP8kcYlYDv
 9WDzvjaz0VE7Ung2XEtjg9QEvvbiLcuY=
X-Received: by 2002:a2e:700e:0:b0:2b6:e618:b593 with SMTP id
 l14-20020a2e700e000000b002b6e618b593mr8922927ljc.31.1688976231828; 
 Mon, 10 Jul 2023 01:03:51 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHuYL0aV926c971TJx2xMUBz37dlSenkl+jwaQC/3judD20faorjaMYyrZ3WwgN0pirSCj5S7Um6rITQ95fOcs=
X-Received: by 2002:a2e:700e:0:b0:2b6:e618:b593 with SMTP id
 l14-20020a2e700e000000b002b6e618b593mr8922908ljc.31.1688976231555; Mon, 10
 Jul 2023 01:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230710074639.996030-1-kkostiuk@redhat.com>
 <20230710074639.996030-3-kkostiuk@redhat.com>
 <664eb456-d812-a5e2-4470-534777d0fda4@redhat.com>
In-Reply-To: <664eb456-d812-a5e2-4470-534777d0fda4@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Mon, 10 Jul 2023 11:03:40 +0300
Message-ID: <CAPMcbCq5ay5F5+WREJ2A=tOxUHp9MgHyFoBTJPvZsWiXqVh62Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] QGA VSS: Replace 'fprintf(stderr' with PRINT_DEBUG
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000050fb6606001d6ca0"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--00000000000050fb6606001d6ca0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2023 at 11:00=E2=80=AFAM Thomas Huth <thuth@redhat.com> wro=
te:

> On 10/07/2023 09.46, Konstantin Kostiuk wrote:
> > Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > ---
> >   qga/vss-win32/install.cpp   | 12 ++++++------
> >   qga/vss-win32/requester.cpp |  9 +++++----
> >   2 files changed, 11 insertions(+), 10 deletions(-)
> >
> > diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
> > index ff93b08a9e..9bd2c52b70 100644
> > --- a/qga/vss-win32/install.cpp
> > +++ b/qga/vss-win32/install.cpp
> > @@ -13,6 +13,7 @@
> >   #include "qemu/osdep.h"
> >
> >   #include "vss-common.h"
> > +#include "vss-debug.h"
> >   #ifdef HAVE_VSS_SDK
> >   #include <vscoordint.h>
> >   #else
> > @@ -54,7 +55,7 @@ void errmsg(DWORD err, const char *text)
> >                     FORMAT_MESSAGE_FROM_SYSTEM |
> FORMAT_MESSAGE_IGNORE_INSERTS,
> >                     NULL, err, MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT=
),
> >                     (char *)&msg, 0, NULL);
> > -    fprintf(stderr, "%.*s. (Error: %lx) %s\n", len, text, err, msg);
> > +    qga_debug("%.*s. (Error: %lx) %s\n", len, text, err, msg);
>
> Here you kept the "\n" at the end of the string...
>
>
This is miskate. Thanks!


> >       LocalFree(msg);
> >   }
> >
> > @@ -219,7 +220,7 @@ static HRESULT QGAProviderRemove(ICatalogCollection
> *coll, int i, void *arg)
> >   {
> >       HRESULT hr;
> >
> > -    fprintf(stderr, "Removing COM+ Application: %s\n",
> QGA_PROVIDER_NAME);
> > +    qga_debug("Removing COM+ Application: %s", QGA_PROVIDER_NAME);
> >       chk(coll->Remove(i));
> >   out:
> >       return hr;
> > @@ -304,9 +305,8 @@ STDAPI COMRegister(void)
> >       }
> >       strcpy(tlbPath, dllPath);
> >       strcpy(tlbPath+n-3, "tlb");
> > -    fprintf(stderr, "Registering " QGA_PROVIDER_NAME ":\n");
> > -    fprintf(stderr, "  %s\n", dllPath);
> > -    fprintf(stderr, "  %s\n", tlbPath);
> > +    qga_debug("Registering " QGA_PROVIDER_NAME ": %s %s",
> > +              dllPath, tlbPath);
>
> ... but here you remove the "\n" ... looks weird. Looking at the first
> patch, I assume the "\n" should now always be removed from the strings
> here?
>
>   Thomas
>
>

--00000000000050fb6606001d6ca0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 10, 2023 at 11:00=E2=80=
=AFAM Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">O=
n 10/07/2023 09.46, Konstantin Kostiuk wrote:<br>
&gt; Signed-off-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkostiuk@redha=
t.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;<br>
&gt; Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@=
linaro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0qga/vss-win32/install.cpp=C2=A0 =C2=A0| 12 ++++++------<br=
>
&gt;=C2=A0 =C2=A0qga/vss-win32/requester.cpp |=C2=A0 9 +++++----<br>
&gt;=C2=A0 =C2=A02 files changed, 11 insertions(+), 10 deletions(-)<br>
&gt; <br>
&gt; diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp<br>
&gt; index ff93b08a9e..9bd2c52b70 100644<br>
&gt; --- a/qga/vss-win32/install.cpp<br>
&gt; +++ b/qga/vss-win32/install.cpp<br>
&gt; @@ -13,6 +13,7 @@<br>
&gt;=C2=A0 =C2=A0#include &quot;qemu/osdep.h&quot;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0#include &quot;vss-common.h&quot;<br>
&gt; +#include &quot;vss-debug.h&quot;<br>
&gt;=C2=A0 =C2=A0#ifdef HAVE_VSS_SDK<br>
&gt;=C2=A0 =C2=A0#include &lt;vscoordint.h&gt;<br>
&gt;=C2=A0 =C2=A0#else<br>
&gt; @@ -54,7 +55,7 @@ void errmsg(DWORD err, const char *text)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0NULL, err, MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(char *)&amp;msg, 0, NULL);<br>
&gt; -=C2=A0 =C2=A0 fprintf(stderr, &quot;%.*s. (Error: %lx) %s\n&quot;, le=
n, text, err, msg);<br>
&gt; +=C2=A0 =C2=A0 qga_debug(&quot;%.*s. (Error: %lx) %s\n&quot;, len, tex=
t, err, msg);<br>
<br>
Here you kept the &quot;\n&quot; at the end of the string...<br>
<br></blockquote><div><br></div><div>This is miskate. Thanks!<br></div><div=
>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0LocalFree(msg);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; <br>
&gt; @@ -219,7 +220,7 @@ static HRESULT QGAProviderRemove(ICatalogCollectio=
n *coll, int i, void *arg)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0HRESULT hr;<br>
&gt; <br>
&gt; -=C2=A0 =C2=A0 fprintf(stderr, &quot;Removing COM+ Application: %s\n&q=
uot;, QGA_PROVIDER_NAME);<br>
&gt; +=C2=A0 =C2=A0 qga_debug(&quot;Removing COM+ Application: %s&quot;, QG=
A_PROVIDER_NAME);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0chk(coll-&gt;Remove(i));<br>
&gt;=C2=A0 =C2=A0out:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return hr;<br>
&gt; @@ -304,9 +305,8 @@ STDAPI COMRegister(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0strcpy(tlbPath, dllPath);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0strcpy(tlbPath+n-3, &quot;tlb&quot;);<br>
&gt; -=C2=A0 =C2=A0 fprintf(stderr, &quot;Registering &quot; QGA_PROVIDER_N=
AME &quot;:\n&quot;);<br>
&gt; -=C2=A0 =C2=A0 fprintf(stderr, &quot;=C2=A0 %s\n&quot;, dllPath);<br>
&gt; -=C2=A0 =C2=A0 fprintf(stderr, &quot;=C2=A0 %s\n&quot;, tlbPath);<br>
&gt; +=C2=A0 =C2=A0 qga_debug(&quot;Registering &quot; QGA_PROVIDER_NAME &q=
uot;: %s %s&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dllPath, tlbPath);<b=
r>
<br>
... but here you remove the &quot;\n&quot; ... looks weird. Looking at the =
first <br>
patch, I assume the &quot;\n&quot; should now always be removed from the st=
rings here?<br>
<br>
=C2=A0 Thomas<br>
<br>
</blockquote></div></div>

--00000000000050fb6606001d6ca0--


