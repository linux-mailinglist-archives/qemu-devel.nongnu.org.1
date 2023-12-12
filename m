Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E67980EE35
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 14:59:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD3H5-0007QK-EH; Tue, 12 Dec 2023 08:58:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smarkusg@gmail.com>)
 id 1rCyMG-0005yI-Ed
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 03:43:16 -0500
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smarkusg@gmail.com>)
 id 1rCyME-00017U-JF
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 03:43:16 -0500
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-7b6f2dd5633so332487039f.2
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 00:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702370593; x=1702975393; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c3oMpyEqOieLY/HlUR21unBugAHwY0RZux5V0L7p944=;
 b=CewehZgDI3gM8iai1RReHL7V4Ok/6leeFkPcek3AfogzaM2e6UcksWkLcau3lmhxx1
 oVTqlDa12o/3tVl5hs+p75bXO6qU//YQ4Jv6ZhiSxZnftaIZ8C07rZ2rW3ZPREPI6tRg
 hVQ+mmBtdZv+s1xxMqJXw70XBZ25lkWLEVM0TDB6fKjxOVLB/7cdUnSaKOK5xqPnXso5
 if60l426TiFUsSj+FO9dMq/iZ/RPEkEIQ2FccNWzdm/BBvgGiHazTnTF9YHQzv9WiaMx
 EdFKmSop0BTq3bV4PDEdd97AQShSk1nLfNhWRRvFOdO4qqJuVVcm3QudDtkp7FCnbuzj
 hbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702370593; x=1702975393;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c3oMpyEqOieLY/HlUR21unBugAHwY0RZux5V0L7p944=;
 b=kCudw5EvYmn267V35jmf6gh44p5ZzSXUgSMpxSugTiMeEYf2jxk/nM1hptm6N2RH8U
 6BKuO/1oC+CPNDeYAR3CMuttJPO6L0oVRIFpTG4PPHGhjI/yeklZ36InKRy1Dkm0ltAh
 LhX1XAc4RPbOccx2esaNyYa7F6Rwgf7PCVpOyB8FpXg6cJ9Sz0+3pSJ0fi8Uuej6UmU6
 Xf/dpICRNd93by8RBVQYO7DMxZCi9SaQdicelJTeAhhJ0bbGduj6XUMySybaPhQqdQ9/
 uGjpI4gixezkmhvkH3fRGsnmdQThdl8ufogVTtg7L73LGydwX4hx5pRdSrjA3beK3gLv
 DJaQ==
X-Gm-Message-State: AOJu0Yynn378Mndjk6nXsgnP9NuCEPJZfo2U+rm+8K1yn+5/lEn5s+D1
 1jQSVsCB6KavsxzmrmznV0g93gJ7yRJ/A7xXRVg=
X-Google-Smtp-Source: AGHT+IHsUbbf3w8SPhjbVqDHQhALjuSwxd9kvbojCo4+ZNo8YzK/eHfotd7ZmNbGNozbQcc1T8WK+G2+d0jhHiyInvY=
X-Received: by 2002:a05:6e02:1526:b0:35d:59a2:2bb with SMTP id
 i6-20020a056e02152600b0035d59a202bbmr9207893ilu.91.1702370593376; Tue, 12 Dec
 2023 00:43:13 -0800 (PST)
MIME-Version: 1.0
References: <20231211-cocoa-v6-1-49f3be0191f2@daynix.com>
 <CADfA342Dr5troPrjE6Sf2+mMuPL5J1Q_zuXhJxrUnNo9tT6KsQ@mail.gmail.com>
 <3f15630b-4373-4fbc-83cf-ca568341b4d6@daynix.com>
In-Reply-To: <3f15630b-4373-4fbc-83cf-ca568341b4d6@daynix.com>
From: Marek Glogowski <smarkusg@gmail.com>
Date: Tue, 12 Dec 2023 09:43:02 +0100
Message-ID: <CADfA340BGjC7vvWfx9xRL=MPpZHLkWX8=3y2uqSiD9EWdZpbzw@mail.gmail.com>
Subject: Re: [PATCH v6] ui/cocoa: Use NSWindow's ability to resize
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000007e902c060c4c0aad"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2d;
 envelope-from=smarkusg@gmail.com; helo=mail-io1-xd2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 12 Dec 2023 08:58:06 -0500
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

--0000000000007e902c060c4c0aad
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for the information.
I know you're busy so I appreciate you taking the time to do a quick check
:-)

Marek G=C5=82ogowski

wt., 12 gru 2023 o 09:28 Akihiko Odaki <akihiko.odaki@daynix.com>
napisa=C5=82(a):

> On 2023/12/12 17:04, Marek Glogowski wrote:
> > Hi
> >
> > I checked on the emulation "qemu-system-ppc -machine pegasos".
> > Full-screen seems to work fine. The screen is correctly initialised in
> > full-screen mode and there are no problems with closing the window when
> > the session is suspended.
> > With this series of patches, there is also the option "Move to", which
> > makes it possible to move the screen to an external device such as an
> IPad.
> > Thank you for the ui/cocoa acumen
> >
> > Additionally, how can I use this message on qemu-devel.
> > It has a post for people who use Macos or Asahi Linux. Verify random
> > qemu sessions under Macos .Some are faster others are slow.
> > The topic is posted on qemu-discuss@nongnu.org
> > <mailto:qemu-discuss@nongnu.org> (I don't know if developers look there
> > often)
> >
> > https://lists.nongnu.org/archive/html/qemu-discuss/2023-12/msg00008.htm=
l
> > <
> https://lists.nongnu.org/archive/html/qemu-discuss/2023-12/msg00008.html>
> >
> > The program posted there was prepared by one of the maintainers of ppc
> > qemu machines "BALATON Zoltan".
> > We are starting to gather as much information as possible for it.
> > I hope nobody will be offended about this information in this topic. I
> > do not want to start a topic and litter other lists
> >
> > Best regards
> > Marek G=C5=82ogowski
>
> Hi,
>
> I have confirmed the tests run in about 25 seconds for each trial on
> Asahi Linux (Arch Linux ARM) on M2 MacBook Air so it may be specific to
> macOS. It needs some serious debugging but I don't have free time to do
> that these days.
>
> Regards,
> Akihiko Odaki
>

--0000000000007e902c060c4c0aad
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Thank you for the information.=C2=A0=
</div><div>I know you&#39;re busy so I appreciate you taking the time to do=
 a quick check :-)</div><div><br></div><div>Marek G=C5=82ogowski</div></div=
></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr"=
>wt., 12 gru 2023 o 09:28=C2=A0Akihiko Odaki &lt;<a href=3D"mailto:akihiko.=
odaki@daynix.com">akihiko.odaki@daynix.com</a>&gt; napisa=C5=82(a):<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">On 2023/12/12 17:04, Ma=
rek Glogowski wrote:<br>
&gt; Hi<br>
&gt; <br>
&gt; I checked on the emulation &quot;qemu-system-ppc -machine pegasos&quot=
;.<br>
&gt; Full-screen seems to work fine. The screen is correctly initialised in=
 <br>
&gt; full-screen mode and there are no problems with closing the window whe=
n <br>
&gt; the session is suspended.<br>
&gt; With this series of patches, there is also the option &quot;Move to&qu=
ot;, which <br>
&gt; makes it possible to move the screen to an external device such as an =
IPad.<br>
&gt; Thank you for the ui/cocoa acumen<br>
&gt; <br>
&gt; Additionally, how can I use this message on qemu-devel.<br>
&gt; It has a post for people who use Macos or Asahi Linux. Verify random <=
br>
&gt; qemu sessions under Macos .Some are faster others are slow.<br>
&gt; The topic is posted on <a href=3D"mailto:qemu-discuss@nongnu.org" targ=
et=3D"_blank">qemu-discuss@nongnu.org</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:qemu-discuss@nongnu.org" target=3D"_blank=
">qemu-discuss@nongnu.org</a>&gt; (I don&#39;t know if developers look ther=
e <br>
&gt; often)<br>
&gt; <br>
&gt; <a href=3D"https://lists.nongnu.org/archive/html/qemu-discuss/2023-12/=
msg00008.html" rel=3D"noreferrer" target=3D"_blank">https://lists.nongnu.or=
g/archive/html/qemu-discuss/2023-12/msg00008.html</a> <br>
&gt; &lt;<a href=3D"https://lists.nongnu.org/archive/html/qemu-discuss/2023=
-12/msg00008.html" rel=3D"noreferrer" target=3D"_blank">https://lists.nongn=
u.org/archive/html/qemu-discuss/2023-12/msg00008.html</a>&gt;<br>
&gt; <br>
&gt; The program posted there was prepared by one of the maintainers of ppc=
 <br>
&gt; qemu machines &quot;BALATON Zoltan&quot;.<br>
&gt; We are starting to gather as much information as possible for it.<br>
&gt; I hope nobody will be offended about this information in this topic. I=
 <br>
&gt; do not want to start a topic and litter other lists<br>
&gt; <br>
&gt; Best regards<br>
&gt; Marek G=C5=82ogowski<br>
<br>
Hi,<br>
<br>
I have confirmed the tests run in about 25 seconds for each trial on <br>
Asahi Linux (Arch Linux ARM) on M2 MacBook Air so it may be specific to <br=
>
macOS. It needs some serious debugging but I don&#39;t have free time to do=
 <br>
that these days.<br>
<br>
Regards,<br>
Akihiko Odaki<br>
</blockquote></div>

--0000000000007e902c060c4c0aad--

