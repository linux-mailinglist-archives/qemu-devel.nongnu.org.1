Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83961805E57
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 20:07:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAak6-00047m-4r; Tue, 05 Dec 2023 14:06:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <venture@google.com>)
 id 1rAak1-00046g-EK
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 14:05:58 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <venture@google.com>)
 id 1rAajz-0007l5-DL
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 14:05:57 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-54c77d011acso1286a12.1
 for <qemu-devel@nongnu.org>; Tue, 05 Dec 2023 11:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1701803147; x=1702407947; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gw+HClEm0o3m3bd5eihfgY7qr1l46Gguv1nAmvhNjC0=;
 b=F/bQ1EB/NFdU0u4FbxOATjcSx4PmND0AD3bwPXxH2z0vJwembSsw4d2uXzwSfIzy2N
 w97KKMXP3302LXS77Z+4kRr5erkDTs3990FGA+G0a7antL8TH+8xh/fFYzeT7Yw6jHQn
 J1dYGyq1yrloJUaZHHPia8ls1GVHFkU5I436tfe49Z40o/+JRqQ6cejg3Y0eQT7c0Hkt
 NQdz31/sYqb9uqSKhnQaZanMMze/sNxbkSye/s28hiYjQQH9wJV4FvTHG3oKQubxSUBI
 rhw/+4S63oQthpqmxK3N1YLaHkjJA0epTnWxDmZzAyWDeFs0nU3/qUe9PzbDkmOM8cFF
 UkDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701803147; x=1702407947;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gw+HClEm0o3m3bd5eihfgY7qr1l46Gguv1nAmvhNjC0=;
 b=D1tp1Zle+iLcFg1omKa/aGFZv+M9m+7uI4IdESl6ua8Ah+cGalDf5K7VXqgbemzgWp
 QMKppelJXA4AFxxDJCwwA9zEngwh4ZzGJul2QeSKofmW1CC013zaQehfAatheL62npcS
 x0n2nJxjIpF93rXYAwz7RLG6KCSpmksiSukyHinA58JO0WHAPEy9ex6oKZ0HMet+PrNp
 NWqlAEVRZAnPs088QIWDdoGWPgP86/UEvnoT1ENq9lesqiGe7BevJReZbS8hAxRceVFj
 jsGaZ3rc2q8TZ5wtWsa/3JtAjcc8lCINr8RaE5yuFYUltSJTMMwywpn2lY9VcHqaQN1f
 jqcg==
X-Gm-Message-State: AOJu0Yz+PWF3qtvdBzOIuPVR+XUtg3LreQhwKMxz3XTZvOw+JLxywM2m
 hcD7cXWKnM4wS7PRV/X8fZYhQqIttZygHsKY5tXMUQ==
X-Google-Smtp-Source: AGHT+IEPdkLzR70RVDG+MuqjAYxalxOHK8MZ2PgsyzInuyk6LNA6LO1KI2uvRiyddjhHTItTFITJScKyPTmnFMI/svk=
X-Received: by 2002:a50:aacf:0:b0:54b:321:ef1a with SMTP id
 r15-20020a50aacf000000b0054b0321ef1amr4516edc.6.1701803146467; Tue, 05 Dec
 2023 11:05:46 -0800 (PST)
MIME-Version: 1.0
References: <20231113063156.2264941-1-potin.lai.pt@gmail.com>
 <ZVQDHlS7TgZpXms8@mail.minyard.net>
In-Reply-To: <ZVQDHlS7TgZpXms8@mail.minyard.net>
From: Patrick Venture <venture@google.com>
Date: Tue, 5 Dec 2023 11:05:33 -0800
Message-ID: <CAO=notw8mNjiCGK1h7CjmhyHwvXY92BYKW5qvh6NO5romZ7LGA@mail.gmail.com>
Subject: Re: [PATCH 1/1] hw/i2c: add pca9543 i2c-mux switch
To: minyard@acm.org
Cc: Potin Lai <potin.lai.pt@gmail.com>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000006be7a060bc7ec8c"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=venture@google.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

--00000000000006be7a060bc7ec8c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 3:30=E2=80=AFPM Corey Minyard <minyard@acm.org> wro=
te:

> On Mon, Nov 13, 2023 at 02:31:56PM +0800, Potin Lai wrote:
> > Add pca9543 2-channel i2c-mux switch support.
> >
> > Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
>
> Looks good to me.
>
> Acked-by: Corey Minyard <cminyard@mvista.com>
>
> > ---
> >  hw/i2c/i2c_mux_pca954x.c         | 12 ++++++++++++
> >  include/hw/i2c/i2c_mux_pca954x.h |  1 +
> >  2 files changed, 13 insertions(+)
> >
> > diff --git a/hw/i2c/i2c_mux_pca954x.c b/hw/i2c/i2c_mux_pca954x.c
> > index db5db956a6..6aace0fc47 100644
> > --- a/hw/i2c/i2c_mux_pca954x.c
> > +++ b/hw/i2c/i2c_mux_pca954x.c
> > @@ -30,6 +30,7 @@
> >
> >  #define PCA9548_CHANNEL_COUNT 8
> >  #define PCA9546_CHANNEL_COUNT 4
> > +#define PCA9543_CHANNEL_COUNT 2
> >
> >  /*
> >   * struct Pca954xState - The pca954x state object.
> > @@ -172,6 +173,12 @@ I2CBus *pca954x_i2c_get_bus(I2CSlave *mux, uint8_t
> channel)
> >      return pca954x->bus[channel];
> >  }
> >
> > +static void pca9543_class_init(ObjectClass *klass, void *data)
> > +{
> > +    Pca954xClass *s =3D PCA954X_CLASS(klass);
> > +    s->nchans =3D PCA9543_CHANNEL_COUNT;
> > +}
> > +
> >  static void pca9546_class_init(ObjectClass *klass, void *data)
> >  {
> >      Pca954xClass *s =3D PCA954X_CLASS(klass);
> > @@ -246,6 +253,11 @@ static const TypeInfo pca954x_info[] =3D {
> >          .class_init    =3D pca954x_class_init,
> >          .abstract      =3D true,
> >      },
> > +    {
> > +        .name          =3D TYPE_PCA9543,
> > +        .parent        =3D TYPE_PCA954X,
> > +        .class_init    =3D pca9543_class_init,
> > +    },
> >      {
> >          .name          =3D TYPE_PCA9546,
> >          .parent        =3D TYPE_PCA954X,
> > diff --git a/include/hw/i2c/i2c_mux_pca954x.h
> b/include/hw/i2c/i2c_mux_pca954x.h
> > index 3dd25ec983..1da5508ed5 100644
> > --- a/include/hw/i2c/i2c_mux_pca954x.h
> > +++ b/include/hw/i2c/i2c_mux_pca954x.h
> > @@ -3,6 +3,7 @@
> >
> >  #include "hw/i2c/i2c.h"
> >
> > +#define TYPE_PCA9543 "pca9543"
> >  #define TYPE_PCA9546 "pca9546"
> >  #define TYPE_PCA9548 "pca9548"
> >
> > --
> > 2.31.1
> >
> >


Corey, can you include this in a pull email? I don't quite have that set up
at present, Titus is going to help me figure it out.

Patrick

--00000000000006be7a060bc7ec8c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Nov 14, 2023 at 3:30=E2=80=AF=
PM Corey Minyard &lt;<a href=3D"mailto:minyard@acm.org">minyard@acm.org</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On M=
on, Nov 13, 2023 at 02:31:56PM +0800, Potin Lai wrote:<br>
&gt; Add pca9543 2-channel i2c-mux switch support.<br>
&gt; <br>
&gt; Signed-off-by: Potin Lai &lt;<a href=3D"mailto:potin.lai.pt@gmail.com"=
 target=3D"_blank">potin.lai.pt@gmail.com</a>&gt;<br>
<br>
Looks good to me.<br>
<br>
Acked-by: Corey Minyard &lt;<a href=3D"mailto:cminyard@mvista.com" target=
=3D"_blank">cminyard@mvista.com</a>&gt;<br>
<br>
&gt; ---<br>
&gt;=C2=A0 hw/i2c/i2c_mux_pca954x.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 12 +=
+++++++++++<br>
&gt;=C2=A0 include/hw/i2c/i2c_mux_pca954x.h |=C2=A0 1 +<br>
&gt;=C2=A0 2 files changed, 13 insertions(+)<br>
&gt; <br>
&gt; diff --git a/hw/i2c/i2c_mux_pca954x.c b/hw/i2c/i2c_mux_pca954x.c<br>
&gt; index db5db956a6..6aace0fc47 100644<br>
&gt; --- a/hw/i2c/i2c_mux_pca954x.c<br>
&gt; +++ b/hw/i2c/i2c_mux_pca954x.c<br>
&gt; @@ -30,6 +30,7 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #define PCA9548_CHANNEL_COUNT 8<br>
&gt;=C2=A0 #define PCA9546_CHANNEL_COUNT 4<br>
&gt; +#define PCA9543_CHANNEL_COUNT 2<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /*<br>
&gt;=C2=A0 =C2=A0* struct Pca954xState - The pca954x state object.<br>
&gt; @@ -172,6 +173,12 @@ I2CBus *pca954x_i2c_get_bus(I2CSlave *mux, uint8_=
t channel)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return pca954x-&gt;bus[channel];<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +static void pca9543_class_init(ObjectClass *klass, void *data)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 Pca954xClass *s =3D PCA954X_CLASS(klass);<br>
&gt; +=C2=A0 =C2=A0 s-&gt;nchans =3D PCA9543_CHANNEL_COUNT;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 static void pca9546_class_init(ObjectClass *klass, void *data)<b=
r>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Pca954xClass *s =3D PCA954X_CLASS(klass);<br>
&gt; @@ -246,6 +253,11 @@ static const TypeInfo pca954x_info[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D pca954x=
_class_init,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .abstract=C2=A0 =C2=A0 =C2=A0 =3D tr=
ue,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=3D TYPE_PCA9543,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TY=
PE_PCA954X,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D pca9543_clas=
s_init,<br>
&gt; +=C2=A0 =C2=A0 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =3D TYPE_PCA9546,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=3D TYPE_PCA954X,<br>
&gt; diff --git a/include/hw/i2c/i2c_mux_pca954x.h b/include/hw/i2c/i2c_mux=
_pca954x.h<br>
&gt; index 3dd25ec983..1da5508ed5 100644<br>
&gt; --- a/include/hw/i2c/i2c_mux_pca954x.h<br>
&gt; +++ b/include/hw/i2c/i2c_mux_pca954x.h<br>
&gt; @@ -3,6 +3,7 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;hw/i2c/i2c.h&quot;<br>
&gt;=C2=A0 <br>
&gt; +#define TYPE_PCA9543 &quot;pca9543&quot;<br>
&gt;=C2=A0 #define TYPE_PCA9546 &quot;pca9546&quot;<br>
&gt;=C2=A0 #define TYPE_PCA9548 &quot;pca9548&quot;<br>
&gt;=C2=A0 <br>
&gt; -- <br>
&gt; 2.31.1<br>
&gt; <br>
&gt;</blockquote><div><br></div><div>Corey, can you include this in a pull =
email? I don&#39;t quite have that set up at present, Titus is going to hel=
p me figure it out.</div><div><br></div><div>Patrick=C2=A0</div></div></div=
>

--00000000000006be7a060bc7ec8c--

