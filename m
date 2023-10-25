Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 961997D6A2D
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 13:30:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvc42-0000tr-H0; Wed, 25 Oct 2023 07:28:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qvc3z-0000tI-LF; Wed, 25 Oct 2023 07:28:39 -0400
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qvc3y-00085d-20; Wed, 25 Oct 2023 07:28:39 -0400
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-41cd7a3e8f8so36022911cf.0; 
 Wed, 25 Oct 2023 04:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698233316; x=1698838116; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WbLBpKqa/wwy2au0ZyTQd2y19yy13XiYOJBECTm5beU=;
 b=Hcqs3RC+cw133yIpZELSWfz9x3wExcwRVGsjM8hS5Y2GO8KGfHv/CpKdbGcNQETd4D
 uze/EY/FiGecaqFHsei+tlMV6EIOrVuBoL9zAQJIdcr/aUtE7v1QhWWOCINc+j+iTq2/
 8sUVZsvjcE25KJQN3EXneS5BBi3PRRTHslAPjBbcTB0onj73ch0bbxxtjFOU1IVOLkuy
 gXiuq0/4CVi7ZSghJVf0ReN0mdosSciBg93AGqLbrGIQWuJoGmS6daEXmJFf8q2hGeSA
 ffSgJDDwlT2xWl8WxdTzYAIX3LFSeZaCDIYqU/Hd5XyizlQEE+2st2OYhR82dFpqKUCP
 G6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698233316; x=1698838116;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WbLBpKqa/wwy2au0ZyTQd2y19yy13XiYOJBECTm5beU=;
 b=ZV6Q4juVKP8BgVybHfljwsvamjnc/V1ETVSPHknOPmmlCyqWszaEvSOfUOdXiAd8O7
 YmleE+cuxq6AsttI/ILJDAYDjmmC0t5wvoSRrBELMa0puRJb1jUvSEQI67bdKqQW8kt0
 gij0Z3AoiEZL7nZmeTvGmOHMsTNCEK7RLcPGELaZTS6opjv5WuiY/X0HlZdyx2oGaX/+
 EyTl2KPgo7Dcmm99J0qJxiUgmJDGeu/nu4lTl8iU/w85iu90kAxOa5h8HdS3qpNm/2rb
 DQQoC950+CAnsTa5bLHvHuZZdn0mIQTuOJJ8LvGJHHqCImrCt2oXNy7O6IKPjBqxTzSL
 CUlw==
X-Gm-Message-State: AOJu0YznQW0t0BnPJO3qUp1Ju6Ty5r5xc/lixTm4U9NxYXaGf9LgkXUr
 b1ARWF5pOgfpzRPdy2k8O+5Fj+C/W7CnhZJiW4c=
X-Google-Smtp-Source: AGHT+IF6lqCt4b9WUXfyww33qlyuymlQI421aPyrS3O8hNXvPP3cpYwu93SqCtXwjzKH82LRDTUvXuGbE+DAaIVBhMw=
X-Received: by 2002:ac8:7dce:0:b0:418:134f:17f4 with SMTP id
 c14-20020ac87dce000000b00418134f17f4mr19890943qte.22.1698233316095; Wed, 25
 Oct 2023 04:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <20231023113047.2572137-1-marcandre.lureau@redhat.com>
 <20231023113047.2572137-4-marcandre.lureau@redhat.com>
 <1390cf2c-0da0-43b8-8b50-d393f9d932a8@redhat.com>
In-Reply-To: <1390cf2c-0da0-43b8-8b50-d393f9d932a8@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 25 Oct 2023 15:28:25 +0400
Message-ID: <CAJ+F1CJmHGtzkhPLKsBihRX5EDetEsQ+hj0Wf=dmJgW2EBhQmw@mail.gmail.com>
Subject: Re: [PATCH v5 03/19] ui: add pixman-compat.h
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>,
 "open list:sPAPR pseries" <qemu-ppc@nongnu.org>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM" <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, Eric Blake <eblake@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000008d3d4c060888c157"
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x835.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000008d3d4c060888c157
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 25 oct. 2023, 15:18, Thomas Huth <thuth@redhat.com> a =C3=A9crit :

> On 23/10/2023 13.30, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > This is a tiny subset of PIXMAN API that is used pervasively in QEMU
> > codebase to manage images and identify the underlying format.
> >
> > It doesn't seems worth to wrap this in a QEMU-specific API.
>
> IMHO it's not very beautiful, but after thinking about it for a while, I
> think it's acceptable and likely still better than disabling all the
> dependend devices...
>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   include/ui/pixman-compat.h | 195 ++++++++++++++++++++++++++++++++++++=
+
>
> Just a matter of taste, but I think I'd rather name it "pixman-minimal.h"
> instead.
>
> Anyway:
> Acked-by: Thomas Huth <thuth@redhat.com


Good suggestion =F0=9F=91=8D

>
>

--0000000000008d3d4c060888c157
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Le mer. 25 oct. 2023, 15:18, Thomas Huth &lt;<a href=
=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; a =C3=A9crit=C2=A0:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex">On 23/10/2023 13.30, <a href=3D"mail=
to:marcandre.lureau@redhat.com" target=3D"_blank" rel=3D"noreferrer">marcan=
dre.lureau@redhat.com</a> wrote:<br>
&gt; From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@re=
dhat.com" target=3D"_blank" rel=3D"noreferrer">marcandre.lureau@redhat.com<=
/a>&gt;<br>
&gt; <br>
&gt; This is a tiny subset of PIXMAN API that is used pervasively in QEMU<b=
r>
&gt; codebase to manage images and identify the underlying format.<br>
&gt; <br>
&gt; It doesn&#39;t seems worth to wrap this in a QEMU-specific API.<br>
<br>
IMHO it&#39;s not very beautiful, but after thinking about it for a while, =
I <br>
think it&#39;s acceptable and likely still better than disabling all the <b=
r>
dependend devices...<br>
<br>
&gt; Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.=
lureau@redhat.com" target=3D"_blank" rel=3D"noreferrer">marcandre.lureau@re=
dhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0include/ui/pixman-compat.h | 195 +++++++++++++++++++++++++=
++++++++++++<br>
<br>
Just a matter of taste, but I think I&#39;d rather name it &quot;pixman-min=
imal.h&quot; <br>
instead.<br>
<br>
Anyway:<br>
Acked-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=3D"_bl=
ank" rel=3D"noreferrer">thuth@redhat.com</a></blockquote></div></div><div d=
ir=3D"auto"><br></div><div dir=3D"auto">Good suggestion =F0=9F=91=8D</div><=
div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
<br></blockquote></div></div></div>

--0000000000008d3d4c060888c157--

