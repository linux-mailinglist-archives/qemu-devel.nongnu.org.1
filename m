Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40475733FE8
	for <lists+qemu-devel@lfdr.de>; Sat, 17 Jun 2023 11:43:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qASRv-00005Z-PN; Sat, 17 Jun 2023 05:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qASRt-00005P-No
 for qemu-devel@nongnu.org; Sat, 17 Jun 2023 05:42:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qASRr-0005Fd-QQ
 for qemu-devel@nongnu.org; Sat, 17 Jun 2023 05:42:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686994942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RqcZIotmCKnATTd15geStq/pRMWKnAlvLha8f8Oi0G8=;
 b=D/a8qs2bWi/RQ17TYZcsdKKslrrboFH8jUjf5M0MnhBeGYzIy0YxBOwMZGNpQC0iE+VcVW
 1s2WXs4iwuVVZZYHugajeMSAHGHbq7N2qgU/8ajF63LPIYrj7g6RivjZ4NwfGWqxMT+Qpn
 kkHd3/ETY7B6yhe5fsFoklWWxOrWoIY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-KkzuE4aWPEuRe6GLTAYrzQ-1; Sat, 17 Jun 2023 05:42:20 -0400
X-MC-Unique: KkzuE4aWPEuRe6GLTAYrzQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-51866148986so992499a12.3
 for <qemu-devel@nongnu.org>; Sat, 17 Jun 2023 02:42:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686994938; x=1689586938;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RqcZIotmCKnATTd15geStq/pRMWKnAlvLha8f8Oi0G8=;
 b=jgFuBueHGpoM05F384F+bqwIBl1FQIe/3JphNzp0uv/qDfhCHpFUl0MWARnEpo+pKu
 CiMRah4MFhxuvhDyQD5/+BEGObCRFrhCJn9JyspTTfuvS8pQ+yQSsL5W9Pyl/bEuLVTw
 5aAUcwAxu/VTVXqigyxqhbOua33Dt5F5Lnko8mPQ3kO5aMifNR/YGE3iGxfWyWl8UbOt
 d+cwdeDLfVUmtCJLNFmXAR+hrnNi0m8GG5JiD9pSFuxPpCOuwdczp5i3fUX9+NNjg6zj
 dsDvX/xXyLAxXBQq1fAILOzJKMiwrSMipt0bDcaKIRE6mk+PICXYQRuirZVdazjTmTAf
 siVw==
X-Gm-Message-State: AC+VfDwv4bj/OBVqqxODECsgyrMGqSbJb+iKwxPbh1fgldOOCMYdY3Px
 QmI6kfEgVpyTUzKbKcNTN+kY7fYypNqxJAx9x3p0GtsRqBCkRoSAQo/esOSI7tELT+IBhYVuYxR
 lI9SeWqERIA788cazenNV77r6tb29OrMU15cJ+7+iBQ==
X-Received: by 2002:aa7:c706:0:b0:51a:3fc2:f60f with SMTP id
 i6-20020aa7c706000000b0051a3fc2f60fmr2101852edq.42.1686994938326; 
 Sat, 17 Jun 2023 02:42:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4MxQFnikpN7izcQ2fLyn51x1RYe61UXw8PCYPAIpa9ImzHaKHcaebw0sswhaQKRsWbrMmZHKBKa1I+5+TeReo=
X-Received: by 2002:aa7:c706:0:b0:51a:3fc2:f60f with SMTP id
 i6-20020aa7c706000000b0051a3fc2f60fmr2101847edq.42.1686994938015; Sat, 17 Jun
 2023 02:42:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAMxuvawc2x2mt4Kk4V1U0fMeNKZj5qE_Lai8Gjo38T_Q_cVdpQ@mail.gmail.com>
 <tencent_9F4A874CACFEABCB1C69837F59A54A3B820A@qq.com>
In-Reply-To: <tencent_9F4A874CACFEABCB1C69837F59A54A3B820A@qq.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sat, 17 Jun 2023 11:42:06 +0200
Message-ID: <CAMxuvax0L=9dPM1+K+2vW_pXRLpZ7WJsmai_qG5gtm9_GeOt7Q@mail.gmail.com>
Subject: Re: [PATCH] chardev/char-win-stdio: Support VT sequences on Windows
 11 host
To: Zhang Huasen <huasenzhang@foxmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000004c98305fe501e63"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--00000000000004c98305fe501e63
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Jun 16, 2023 at 7:41=E2=80=AFAM Zhang Huasen <huasenzhang@foxmail.c=
om>
wrote:

> From: Huasen Zhang <huasenzhang@foxmail.com>
>
> Hello,
>
> On Thu, 15 Jun 2023 12:57:55 +0200 Marc-Andr=C3=A9 Lureau <
> marcandre.lureau@redhat.com>
> wrote:
> > Hi
> >
> > On Thu, Jun 15, 2023 at 12:36=E2=80=AFPM Zhang Huasen <huasenzhang@foxm=
ail.com>
> > wrote:
> >
> > > If the monitor or the serial port use STDIO as backend on Windows 11
> host,
> > > e.g. -nographic options is used, the monitor or the guest Linux do no=
t
> > > response to arrow keys.
> > >
> > > When Windows creates a console, ENABLE_VIRTUAL_PROCESS_INPUT is
> disabled
> > > by default. Arrow keys cannot be retrieved by ReadFile or
> ReadConsoleInput
> > > functions.
> > >
> > > Add ENABLE_VIRTUAL_PROCESS_INPUT to the flag which is passed to
> > > SetConsoleMode,
> > > when opening stdio console.
> > >
> > > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1674
> > >
> > > Signed-off-by: Zhang Huasen <huasenzhang@foxmail.com>
> > > ---
> > >  chardev/char-win-stdio.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/chardev/char-win-stdio.c b/chardev/char-win-stdio.c
> > > index eb830eabd9..1a18999e78 100644
> > > --- a/chardev/char-win-stdio.c
> > > +++ b/chardev/char-win-stdio.c
> > > @@ -190,7 +190,7 @@ static void qemu_chr_open_stdio(Chardev *chr,
> > >          }
> > >      }
> > >
> > > -    dwMode |=3D ENABLE_LINE_INPUT;
> > > +    dwMode |=3D ENABLE_LINE_INPUT | ENABLE_VIRTUAL_TERMINAL_INPUT;
> > >
> >
> > I think we should set it only when is_console (although that may not
> make a
> > difference otherwise)
>
> It is okay to set ENABLE_VIRTUAL_TERMINAL_INPUT only when is_console is
> TRUE.
>
> I do not understand some points of original code.
> If the stdin is not a console, i.e. GetConsoleMode fails, we still
> call SetConsoleMode and set ENABLE_LINE_INPUT.
> Could you please tell what the purpose is?
>

I have no clue. It has been this way since the beginning (commit db418a0a7)=
.

The code doesn't check SetConsoleMode() return value, so I'd just go with
your patch for now.

--00000000000004c98305fe501e63
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jun 16, 2023 at 7:41=E2=80=
=AFAM Zhang Huasen &lt;<a href=3D"mailto:huasenzhang@foxmail.com">huasenzha=
ng@foxmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">From: Huasen Zhang &lt;<a href=3D"mailto:huasenzhang@foxmail.=
com" target=3D"_blank">huasenzhang@foxmail.com</a>&gt;<br>
<br>
Hello,<br>
<br>
On Thu, 15 Jun 2023 12:57:55 +0200 Marc-Andr=C3=A9 Lureau &lt;<a href=3D"ma=
ilto:marcandre.lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat=
.com</a>&gt;<br>
wrote:<br>
&gt; Hi<br>
&gt; <br>
&gt; On Thu, Jun 15, 2023 at 12:36=E2=80=AFPM Zhang Huasen &lt;<a href=3D"m=
ailto:huasenzhang@foxmail.com" target=3D"_blank">huasenzhang@foxmail.com</a=
>&gt;<br>
&gt; wrote:<br>
&gt; <br>
&gt; &gt; If the monitor or the serial port use STDIO as backend on Windows=
 11 host,<br>
&gt; &gt; e.g. -nographic options is used, the monitor or the guest Linux d=
o not<br>
&gt; &gt; response to arrow keys.<br>
&gt; &gt;<br>
&gt; &gt; When Windows creates a console, ENABLE_VIRTUAL_PROCESS_INPUT is d=
isabled<br>
&gt; &gt; by default. Arrow keys cannot be retrieved by ReadFile or ReadCon=
soleInput<br>
&gt; &gt; functions.<br>
&gt; &gt;<br>
&gt; &gt; Add ENABLE_VIRTUAL_PROCESS_INPUT to the flag which is passed to<b=
r>
&gt; &gt; SetConsoleMode,<br>
&gt; &gt; when opening stdio console.<br>
&gt; &gt;<br>
&gt; &gt; Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issue=
s/1674" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-projec=
t/qemu/-/issues/1674</a><br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Zhang Huasen &lt;<a href=3D"mailto:huasenzhang@fox=
mail.com" target=3D"_blank">huasenzhang@foxmail.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 chardev/char-win-stdio.c | 2 +-<br>
&gt; &gt;=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/chardev/char-win-stdio.c b/chardev/char-win-stdio.c<=
br>
&gt; &gt; index eb830eabd9..1a18999e78 100644<br>
&gt; &gt; --- a/chardev/char-win-stdio.c<br>
&gt; &gt; +++ b/chardev/char-win-stdio.c<br>
&gt; &gt; @@ -190,7 +190,7 @@ static void qemu_chr_open_stdio(Chardev *chr,=
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 dwMode |=3D ENABLE_LINE_INPUT;<br>
&gt; &gt; +=C2=A0 =C2=A0 dwMode |=3D ENABLE_LINE_INPUT | ENABLE_VIRTUAL_TER=
MINAL_INPUT;<br>
&gt; &gt;<br>
&gt; <br>
&gt; I think we should set it only when is_console (although that may not m=
ake a<br>
&gt; difference otherwise)<br>
<br>
It is okay to set ENABLE_VIRTUAL_TERMINAL_INPUT only when is_console is TRU=
E.<br>
<br>
I do not understand some points of original code.<br>
If the stdin is not a console, i.e. GetConsoleMode fails, we still<br>
call SetConsoleMode and set ENABLE_LINE_INPUT.<br>
Could you please tell what the purpose is?<br></blockquote><div><br></div>I=
 have no clue. It has been this way since the beginning (commit db418a0a7).=
</div><div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">The c=
ode doesn&#39;t check SetConsoleMode() return value, so I&#39;d just go wit=
h your patch for now.<br></div></div>

--00000000000004c98305fe501e63--


