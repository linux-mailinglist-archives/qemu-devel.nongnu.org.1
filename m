Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA4673FF57
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 17:12:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEALI-0001VW-7b; Tue, 27 Jun 2023 11:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qEALB-0001Un-Kg
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 11:10:53 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qEAL9-0004N2-Qh
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 11:10:49 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-4fb7acaa7a5so2835988e87.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 08:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687878645; x=1690470645;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+ueOz7sP4wIb7ymSJvUuPl4vY2ZobrlJeJB/XLoABJ0=;
 b=I5uk+zElkTCYnOs0gV8vxOYq5PF2lczWP+QPkP20CvflNNi8WjTMvMKzxFdIi6MQ6c
 y8u8oX39J/32nRMYYBPSBmaG/j85P1g0Nt2vLIYALs5DIw/mWM2YdQrMKQYBI3qh6N3H
 JwDryOGQDb/usRi7uN3Pj10aFzZ1FqyulDnR9ft9w0sUD+hhDthy3TDIwzW2pKByURyD
 +1QV3R2RIE8OwrQvF7q+5/FGjHHjqBH9fcSCa7bxWfjVkNl7SjvlWIcnBliYJP3YCdgp
 xxWVPyjbxX+izUsUlwk4f0STjXUazQBMBcz3cmasOchr2ok6B73wfHgb2WGvNDvVb6bW
 Qk/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687878645; x=1690470645;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+ueOz7sP4wIb7ymSJvUuPl4vY2ZobrlJeJB/XLoABJ0=;
 b=iwNzFSEnTuKzceKaCcTEhisMxerke53RX+kEiMWI4/64RMSjj5PvZtXosMcDUIGr8r
 MIC4Eo8JTcwGCusnVa6ZE12tfu58OoBFYv368YzLI/HaKzwiYEzhWq8HgqAKGHU5e02F
 Tfa0dzCmSTl2JWsDIlwyoDYWPMrXXvYwYRPZ9RyJhrbTmI/pisC8X0K3LIhazIdSHamk
 cd2TVeUtZ/p190Ww8n86u35Bnea1Vlwr3rRwcz/MvbFnDomipRA77igM+t2+1si02fep
 frOoXrm5uyNYkCiX/Cn1c3eVUH45MC5bqM5sCm+JhVdWRy84zAT5RvBIpMFewBFGoLMw
 Es6g==
X-Gm-Message-State: AC+VfDwslOA05yGv3XzSG4RzECmjuK+rUhNjok8T09I1nEnAkuzemL0l
 rkRX8mcvuj+J0xc+lPPt3KChwjSE2Lir2wSJfx0=
X-Google-Smtp-Source: ACHHUZ50tHuTPgrhLUFgVnefYUV195+2+Z7M5k4GYSp9ODAjz/V/v6LxjrN2gJvdikhXwPnNMzJfh2RzVLNgghCWq4k=
X-Received: by 2002:ac2:5e64:0:b0:4fb:8680:138a with SMTP id
 a4-20020ac25e64000000b004fb8680138amr1271652lfr.22.1687878644549; Tue, 27 Jun
 2023 08:10:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
 <20230627130231.1614896-5-marcandre.lureau@redhat.com>
 <3798dec7-5798-5703-86f9-fd45787eaac2@linaro.org>
In-Reply-To: <3798dec7-5798-5703-86f9-fd45787eaac2@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 27 Jun 2023 17:10:33 +0200
Message-ID: <CAJ+F1C+RfK-QfSu32rphUqr2oeyCagoh-nYmim4QacT4tr9_jQ@mail.gmail.com>
Subject: Re: [PULL 04/33] virtio-gpu: Optimize 2D resource data transfer
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Keqian Zhu <zhukeqian1@huawei.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000084e2e05ff1ddf84"
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-lf1-x134.google.com
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

--000000000000084e2e05ff1ddf84
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Jun 27, 2023 at 5:04=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 6/27/23 15:02, marcandre.lureau@redhat.com wrote:
> > From: Keqian Zhu via <qemu-devel@nongnu.org>
>
> You need to fix the author for this patch.
>
>
>
ok done, do you want me to re-send the whole PR or is that enough?

The following changes since commit 4329d049d5b8d4af71c6b399d64a6d1b98856318=
:

  Merge tag 'pull-tcg-20230626' of https://gitlab.com/rth7680/qemu into
staging (2023-06-26 17:40:38 +0200)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pull-request

for you to fetch changes up to de1f8ce0abb8c43d1e6a00c31c6d24dfe0505b92:

  ui/dbus: use shared D3D11 Texture2D when possible (2023-06-27 17:08:56
+0200)



> r~
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000084e2e05ff1ddf84
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 27, 2023 at 5:04=E2=80=
=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org"=
>richard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">On 6/27/23 15:02, <a href=3D"mailto:marcandre.=
lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a> wrote:=
<br>
&gt; From: Keqian Zhu via &lt;<a href=3D"mailto:qemu-devel@nongnu.org" targ=
et=3D"_blank">qemu-devel@nongnu.org</a>&gt;<br>
<br>
You need to fix the author for this patch.<br>
<br>
<br></blockquote><div><br></div><div>ok done, do you want me to re-send the=
 whole PR or is that enough?</div><div><br></div><div>The following changes=
 since commit 4329d049d5b8d4af71c6b399d64a6d1b98856318:<br><br>=C2=A0 Merge=
 tag &#39;pull-tcg-20230626&#39; of <a href=3D"https://gitlab.com/rth7680/q=
emu">https://gitlab.com/rth7680/qemu</a> into staging (2023-06-26 17:40:38 =
+0200)<br><br>are available in the Git repository at:<br><br>=C2=A0 <a href=
=3D"https://gitlab.com/marcandre.lureau/qemu.git">https://gitlab.com/marcan=
dre.lureau/qemu.git</a> tags/ui-pull-request<br><br>for you to fetch change=
s up to de1f8ce0abb8c43d1e6a00c31c6d24dfe0505b92:<br><br>=C2=A0 ui/dbus: us=
e shared D3D11 Texture2D when possible (2023-06-27 17:08:56 +0200)<br></div=
><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
r~<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--000000000000084e2e05ff1ddf84--

