Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE10F74B2AC
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 16:06:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHm58-0007Fx-Hf; Fri, 07 Jul 2023 10:05:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qHm56-0007Fk-4X
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 10:05:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qHm54-0006ey-J7
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 10:05:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688738705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=egLmGHYzJ5jcgzMSdhnJkDOb+oxOW2sFwQBXhiPEb0k=;
 b=KoiL+PBWbe0BW+bULYco4klLlYGnTPCIDzwzBcCPh7jTeZCzlz2aCFCPGaEnuTwB+RTSR/
 kY5bWx4a57ttnBNjVvC1qor1rKcNeIxZEFjLT10B+3f9xsZKCQyg2ZY70/Z7IlKjsd3QS7
 BahUBYFN+N6tfa6525b+1/+AJdQota4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-EC6PG1WvOAead8iuJ_VwYQ-1; Fri, 07 Jul 2023 10:05:03 -0400
X-MC-Unique: EC6PG1WvOAead8iuJ_VwYQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b6f0527454so19553571fa.1
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 07:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688738702; x=1691330702;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=egLmGHYzJ5jcgzMSdhnJkDOb+oxOW2sFwQBXhiPEb0k=;
 b=X5w/RGJEfgG84c9MOerygwSL77SQXJ0PaC2j/Ar/se/PD2VBo+An1qxYjxtEk0DNVy
 z/BwnIDmOgyserEvIlr/97lRa0PxXRsGZXgmhl7iaopFchHw/t31Dej+bFN0chXwOqjO
 GAaG0sOJ50Qgdup8vh1Z/EYuiQRp9M2g+QcVKsNNRNxDW0Z01LCry3y14reTUfiXX7Hy
 lsJHOjjwzzV4qq+/Z25k50zbJiynSHGGjONIUKphsAqdGGoTcmtZQVxHIYiRYdjETfM8
 yqF9Po5EEvwE8Z5hLWg2DbNsEYL8YmJanK37cFL9MaToGzl9C54Zov1qtR5RI4ytL7g6
 4/cg==
X-Gm-Message-State: ABy/qLY3+rEEXtnKJs3sdc/iEh7jJ+B6JDkci2VjFilqaiSt86PR6t4t
 UQZ5byKnPLQhfGebakqOuZnm8iBB0dgC6XPxg6qHrIjf834hG8OdAJucPMsNoCER6jjPnPX6KRD
 rrncgaZqXEwBsv+G8J/YWDptSoKGmMz4=
X-Received: by 2002:a2e:8295:0:b0:2b6:9ab8:9031 with SMTP id
 y21-20020a2e8295000000b002b69ab89031mr1750264ljg.16.1688738701922; 
 Fri, 07 Jul 2023 07:05:01 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHlrA0RXhXQo+EMOt15kVkrHcw4srI2oRTBV77wwMnk/ZWIUc/ZnQnqBN5iJjFTUpIjfydU0iB+o6TP/bo+mm4=
X-Received: by 2002:a2e:8295:0:b0:2b6:9ab8:9031 with SMTP id
 y21-20020a2e8295000000b002b69ab89031mr1750242ljg.16.1688738701653; Fri, 07
 Jul 2023 07:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230707092258.768420-1-kkostiuk@redhat.com>
 <20230707092258.768420-3-kkostiuk@redhat.com>
 <7c8cff75-158a-cbb6-bd0a-da5effe03577@linaro.org>
In-Reply-To: <7c8cff75-158a-cbb6-bd0a-da5effe03577@linaro.org>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Fri, 7 Jul 2023 17:04:50 +0300
Message-ID: <CAPMcbCovNsKW7wbjkwNvqS5p5JHV3gn3ZpW5RsMnpFbKjdyZmQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] QGA VSS: Replace 'fprintf(stderr' with PRINT_DEBUG
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="0000000000006e4cbe05ffe61ef8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
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

--0000000000006e4cbe05ffe61ef8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 7, 2023 at 1:34=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org>
wrote:

> On 7/7/23 11:22, Konstantin Kostiuk wrote:
> > Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
> > ---
> >   qga/vss-win32/install.cpp   | 12 ++++++------
> >   qga/vss-win32/requester.cpp |  9 +++++----
> >   2 files changed, 11 insertions(+), 10 deletions(-)
>
>
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
> Previous has 3 "\n", not necessary? Otherwise:
>

I think 3 "\n" is not necessary. The line is still human-readable.


>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> >       if (!PathFileExists(tlbPath)) {
> >           hr =3D HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND);
> >           errmsg(hr, "Failed to lookup tlb");
>
>
>

--0000000000006e4cbe05ffe61ef8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br clear=3D"all"><br></div><br><div clas=
s=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 7, 2023=
 at 1:34=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philm=
d@linaro.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On 7/7/23 11:22, Konstantin Kostiuk wrote:=
<br>
&gt; Signed-off-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkostiuk@redha=
t.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0qga/vss-win32/install.cpp=C2=A0 =C2=A0| 12 ++++++------<br=
>
&gt;=C2=A0 =C2=A0qga/vss-win32/requester.cpp |=C2=A0 9 +++++----<br>
&gt;=C2=A0 =C2=A02 files changed, 11 insertions(+), 10 deletions(-)<br>
<br>
<br>
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
Previous has 3 &quot;\n&quot;, not necessary? Otherwise:<br></blockquote><d=
iv><br></div><div>I think 3 &quot;\n&quot; is not necessary. The line is st=
ill human-readable.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linar=
o.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!PathFileExists(tlbPath)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hr =3D HRESULT_FROM_WIN32(ERRO=
R_FILE_NOT_FOUND);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0errmsg(hr, &quot;Failed to loo=
kup tlb&quot;);<br>
<br>
<br>
</blockquote></div></div>

--0000000000006e4cbe05ffe61ef8--


