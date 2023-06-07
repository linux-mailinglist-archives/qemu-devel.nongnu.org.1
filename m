Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D30B72697A
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 21:08:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6yV3-0002VU-VR; Wed, 07 Jun 2023 15:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1q6yV1-0002Ue-5K; Wed, 07 Jun 2023 15:07:15 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1q6yUy-0005NL-9t; Wed, 07 Jun 2023 15:07:14 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-565d354b59fso88924817b3.0; 
 Wed, 07 Jun 2023 12:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686164829; x=1688756829;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yy7TTiEqRMErlx7mdBjXFg0mfRxaju7z6bSULD2X5g0=;
 b=H+SSOX4Oa4PP2wCETXY7VO/DsxRWhbL2zPOiZWTcQuCc9nOgPFb1a3whDrxaMge2od
 fDspbzrxHHgWFAzPvG7gL3rXtsLHRqsrLsvdKjKIMMsfr0rDJ/D3B9COgAhlU9ITsZRY
 NMyWtlVN98fkXNGCc7V9XuTVt6D+VyCOtNgIAf1bShQPFiCfaRToWu2gvrq+ooSWHngI
 dXhy0Cs/Lrd79/qtGJy59EZBkZWqwiGQr40GdXrR+feKacyKfKEwEfWg4EHxykrSUCRP
 8rYZtATZVtckThko5bQ93vjrtcGk5ClKca94EqFEtWLvj1x5dhIzAzG0Q2+J7egxCx/p
 Ivdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686164829; x=1688756829;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yy7TTiEqRMErlx7mdBjXFg0mfRxaju7z6bSULD2X5g0=;
 b=hlJMLNplT4w50BcDyCrahIia9xKpsmiXWwp/cUn1Uw592frs7pT5iTusev6vck9Kpn
 8B9eKatIbKFvAzuU18vzIRtzHtWPTHEkKGViIDEUZlwKtNVM2N+ZMlsoS6ZQDoUexqd0
 lA/ze3xblZUeIBylOZhzwvn+no74PmtB0vduPOzSJimLf32/rIeOMfSmxYPgZzaFBDhm
 G9vlPIoAvvN65IC4omWs1VoyGqLPFUEsbE09Mf1nwmMmm2zvxSxHe+c6O3Zb/U92tdki
 wnt/Ti1lzK8pW7kYYJ5wpjXWCy8turZHL7dobOKvY5lOQX5P31qpCf7sSOsqovPcEcvZ
 Ir7w==
X-Gm-Message-State: AC+VfDwi0I4/yYsveziXIWCrPWVGor8cT3OXxdEDKsgYla7aemsvPdja
 V3vq9SSG8FIReVdHXTz+wHFGnhJbV8BHOMzxAHU=
X-Google-Smtp-Source: ACHHUZ48RkLLY4HyXXHIJGMn2vdxzNAFYiM28t7aniPyxDfUJ78jEkBlVZQ6f3avRDVNX76oZ3W3C+OaSiR+xUL+W14=
X-Received: by 2002:a81:4ec8:0:b0:561:81b:734b with SMTP id
 c191-20020a814ec8000000b00561081b734bmr6578829ywb.39.1686164828551; Wed, 07
 Jun 2023 12:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230523100508.32564-1-qianfanguijin@163.com>
 <CAPan3Wr1phuot=613sXh-hT0An1-A5vuhcxMZ9SCGTze9w_PdQ@mail.gmail.com>
 <CAFEAcA_6hcAVef1HCcQHMF4qsxGrMGuFeATviJdnCzVXSkvZng@mail.gmail.com>
In-Reply-To: <CAFEAcA_6hcAVef1HCcQHMF4qsxGrMGuFeATviJdnCzVXSkvZng@mail.gmail.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Wed, 7 Jun 2023 21:06:57 +0200
Message-ID: <CAPan3WoUMVszi2UJtw-LHt6iASNFBftkdw_on+fRvOCRVket-A@mail.gmail.com>
Subject: Re: [PATCH v5 00/11] *** Add allwinner-r40 support ***
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qianfanguijin@163.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Beniamino Galvani <b.galvani@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000a37f8405fd8ed7bd"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=nieklinnenbank@gmail.com; helo=mail-yw1-x1136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

--000000000000a37f8405fd8ed7bd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter, Qianfan,

On Mon, Jun 5, 2023 at 5:31=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org>
wrote:

> On Thu, 1 Jun 2023 at 19:48, Niek Linnenbank <nieklinnenbank@gmail.com>
> wrote:
> >
> > Hi Qianfan,
> >
> > Thanks for sending the v5. From my side, I have no further comments on
> the content.
> > So please feel free to add the following to each of the patches 01-11 i=
n
> the series:
> >
> > Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> >
> > As a reminder and explained here on this page, you'll need to make sure
> these lines gets added to each of the commit messages:
> >
> https://www.qemu.org/docs/master/devel/submitting-a-patch.html#proper-use=
-of-reviewed-by-tags-can-aid-review
> >
> > Doing so would require you to send another updated v6, and baselined on
> the latest master.
>
> The rebase was simple, so I've applied this v5 to target-arm.next.
>
Great news!


> (The patch application tools can pick up Reviewed-by tags that are
> on-list without requiring a respin just for that.)
>
Ahh right, I wasn't aware of that. Thanks, I learned something new here.


>
> Qianfan: thanks for working on this feature and for your efforts
> in working through our patch review process.
>
Yes, great work indeed!

>
> Niek: thanks very much for taking the lead on the patch review of
> this series, it's been a tremendous help.
>
I'm glad to help. I only do qemu work in my spare time when I can, so it's
not much.
But I enjoy doing it and learn something new in the process also.

Regards,
Niek


>
> -- PMM
>


--=20
Niek Linnenbank

--000000000000a37f8405fd8ed7bd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Peter, Qianfan,<br></div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jun 5, 2023 at 5:31=E2=
=80=AFPM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">pete=
r.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">On Thu, 1 Jun 2023 at 19:48, Niek Linnenbank &lt;<a hre=
f=3D"mailto:nieklinnenbank@gmail.com" target=3D"_blank">nieklinnenbank@gmai=
l.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi Qianfan,<br>
&gt;<br>
&gt; Thanks for sending the v5. From my side, I have no further comments on=
 the content.<br>
&gt; So please feel free to add the following to each of the patches 01-11 =
in the series:<br>
&gt;<br>
&gt; Reviewed-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmai=
l.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
&gt;<br>
&gt; As a reminder and explained here on this page, you&#39;ll need to make=
 sure these lines gets added to each of the commit messages:<br>
&gt; <a href=3D"https://www.qemu.org/docs/master/devel/submitting-a-patch.h=
tml#proper-use-of-reviewed-by-tags-can-aid-review" rel=3D"noreferrer" targe=
t=3D"_blank">https://www.qemu.org/docs/master/devel/submitting-a-patch.html=
#proper-use-of-reviewed-by-tags-can-aid-review</a><br>
&gt;<br>
&gt; Doing so would require you to send another updated v6, and baselined o=
n the latest master.<br>
<br>
The rebase was simple, so I&#39;ve applied this v5 to target-arm.next.<br><=
/blockquote><div>Great news!<br></div><div>=C2=A0</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
(The patch application tools can pick up Reviewed-by tags that are<br>
on-list without requiring a respin just for that.)<br></blockquote><div>Ahh=
 right, I wasn&#39;t aware of that. Thanks, I learned something new here.<b=
r></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Qianfan: thanks for working on this feature and for your efforts<br>
in working through our patch review process.<br></blockquote><div>Yes, grea=
t work indeed!<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Niek: thanks very much for taking the lead on the patch review of<br>
this series, it&#39;s been a tremendous help.<br></blockquote><div>I&#39;m =
glad to help. I only do qemu work in my spare time when I can, so it&#39;s =
not much.</div><div>But I enjoy doing it and learn something new in the pro=
cess also.</div><div><br></div><div>Regards,</div><div>Niek<br></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
-- PMM<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"l=
tr"><div>Niek Linnenbank<br><br></div></div></div></div>

--000000000000a37f8405fd8ed7bd--

