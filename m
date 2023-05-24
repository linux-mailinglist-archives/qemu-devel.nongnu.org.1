Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AA770F50D
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 13:24:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1mbE-00049i-30; Wed, 24 May 2023 07:24:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1q1mbB-00049Y-LQ
 for qemu-devel@nongnu.org; Wed, 24 May 2023 07:24:09 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1q1mb9-0007hK-NQ
 for qemu-devel@nongnu.org; Wed, 24 May 2023 07:24:09 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-4f13d8f74abso752670e87.0
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 04:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684927446; x=1687519446;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WwtTBeZMESAoinrTqn4Ani/eOMsDNnrtJ7uV3CjZocI=;
 b=bjjhjp8TOG7ldoFU4X58c2pUKTpPlxLNPWR70PNZvm9+kDR9k5CgN8556iTzQ7n445
 9BPJz7qo40XN6fbRLUDSsj+GR41oYE8CHjVFy3vkHN+IWJsSDXzSFq9luUaT6L/Z8dTf
 Brk+2OCYTIOVrG11yZGx2giAVrIfYc3nHhQKSHTVmTLmALnqUm8U4++IjrZzjeahdonX
 7TYFTJfjsjF9p+j0nWIWAOg0ihMajjGOKpc1EQzpBhl0qMpSE4PoPmHXAvY6LR8tp7xm
 dLymnbsJ/7ajkQ5fsIWsqbPg85Hyt+TTKPFHin5Mame2t1mtgnAwiwFpxRNNigHX6+0a
 g6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684927446; x=1687519446;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WwtTBeZMESAoinrTqn4Ani/eOMsDNnrtJ7uV3CjZocI=;
 b=TXXH19hqcaKhHMZFEPB/nxnEAz1mfA165RgPd1sSTOSGy60h/zHbxERme7X6gZuYoX
 nlRla7vLwgq31OMAFap6JuuqwDOGHQRtYs9Fft+79D8pZfSwbzWwqC4lZxm5diX7J8w4
 8Youcxjinlcg8mV43stzigNUAk7nx+ahb1bxJcX3UM3EVEvA224VRpuNMCt3X4Iob3pz
 tWULFacM3J1KHC5WbJ3oXYN844/vIZMVHGQNtJWgyNsSLRaVJXICtKD8/yRHBb0jvc01
 PHSdTHiqb16IcMimTV2N2qZGaQnxZ/GMdFOLsKlYx6Sc5l8+0KHZyN8Of3S6YCqLLspX
 2gBw==
X-Gm-Message-State: AC+VfDzoAcqvEX+cR6mSF3Sm7Yg3ObUsVr5jvcy65/+yGq6GeN26HYJu
 gD9ULmbgZ2GqnIhM3bf3TaJKuaZ1rq8jYsrzSuA=
X-Google-Smtp-Source: ACHHUZ7gUtUV9bWb8SkGsQnFMOrSkr1EBRfrQH9vrIc40e7PYCtMkHGngdGJNgCr5mslqIMeVb3Qt+vxYQU7QbeUc30=
X-Received: by 2002:ac2:4c27:0:b0:4e8:4bc3:fe8a with SMTP id
 u7-20020ac24c27000000b004e84bc3fe8amr5187025lfq.25.1684927445605; Wed, 24 May
 2023 04:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230511125803.594963-1-ernunes@redhat.com>
 <CAJ+F1CK8+kPrGZfhWnk=91tUQCAggH=qHXjZ73K9ZF0t-1aTBA@mail.gmail.com>
 <c42827cb-5201-1e2e-1dae-099527081d60@redhat.com>
In-Reply-To: <c42827cb-5201-1e2e-1dae-099527081d60@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 24 May 2023 15:23:54 +0400
Message-ID: <CAJ+F1C+eGxZtdu033HP-UdowLKrz94LdKwkRB=hfDm3amv1C-g@mail.gmail.com>
Subject: Re: [PATCH 0/2] vhost-user-gpu get_edid feature
To: Erico Nunes <ernunes@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, kraxel@redhat.com
Content-Type: multipart/alternative; boundary="000000000000de241005fc6ebd52"
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-lf1-x12c.google.com
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

--000000000000de241005fc6ebd52
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Erico

On Wed, May 17, 2023 at 8:09=E2=80=AFPM Erico Nunes <ernunes@redhat.com> wr=
ote:

> On 15/05/2023 13:38, Marc-Andr=C3=A9 Lureau wrote:
> > However, I worry about using the new backend (calling GET_EDID) with an
> > older front-end/QEMU. It may just hang, since
> > vhost_user_gpu_handle_display() won't reply to unknown messages. That's
> > what PROTOCOL_FEATURES were meant for, iirc. Can you check? thanks
>
> Indeed as you say, there is a hang with older qemu.
>
> From what I see there are the generic protocol_features and also a
> vhost-user-gpu message for them. I assume it is so that we don't have to
> add vhost-user-gpu specific features to the generic set?
> In any case, the current vhost-user-gpu specific protocol_features
> negotiation happens too late to enable or disable virtio-gpu features
> (triggered by VHOST_USER_GPU_SET_SOCKET). I suppose we could move it
> earlier to the time the generic protocol_features are negotiated,
> through the callback hooks that already exist in the vhost-user layer
> (not implemented so far by vhost-user-gpu though).
> So I guess we could remove the protocol_features negotiation that is
> currently triggered by VHOST_USER_GPU_SET_SOCKET and use that to prevent
> exposing VIRTIO_GPU_F_EDID at all. Does that make sense?
>
>
Wouldn't this work?

If VIRTIO_GPU_F_EDID is set and during protocol_features the GET_EDID
feature is not negotiated, exit the gpu backend with an error.

Otherwise, if we keep exposing VIRTIO_GPU_F_EDID and just not sending
> VHOST_USER_GPU_GET_EDID then the get_edid feature is not quite
> functional overall, which doesn't sound too great.
>
> Thanks
>
> Erico
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000de241005fc6ebd52
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Erico<br></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 17, 2023 at 8:09=
=E2=80=AFPM Erico Nunes &lt;<a href=3D"mailto:ernunes@redhat.com">ernunes@r=
edhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On 15/05/2023 13:38, Marc-Andr=C3=A9 Lureau wrote:<br>
&gt; However, I worry about using the new backend (calling GET_EDID) with a=
n<br>
&gt; older front-end/QEMU. It may just hang, since<br>
&gt; vhost_user_gpu_handle_display() won&#39;t reply to unknown messages. T=
hat&#39;s<br>
&gt; what PROTOCOL_FEATURES were meant for, iirc. Can you check? thanks<br>
<br>
Indeed as you say, there is a hang with older qemu.<br>
<br>
From what I see there are the generic protocol_features and also a<br>
vhost-user-gpu message for them. I assume it is so that we don&#39;t have t=
o<br>
add vhost-user-gpu specific features to the generic set?<br>
In any case, the current vhost-user-gpu specific protocol_features<br>
negotiation happens too late to enable or disable virtio-gpu features<br>
(triggered by VHOST_USER_GPU_SET_SOCKET). I suppose we could move it<br>
earlier to the time the generic protocol_features are negotiated,<br>
through the callback hooks that already exist in the vhost-user layer<br>
(not implemented so far by vhost-user-gpu though).<br>
So I guess we could remove the protocol_features negotiation that is<br>
currently triggered by VHOST_USER_GPU_SET_SOCKET and use that to prevent<br=
>
exposing VIRTIO_GPU_F_EDID at all. Does that make sense?<br>
<br></blockquote><div><br></div><div>Wouldn&#39;t this work?<br></div><div>=
<br></div><div>If VIRTIO_GPU_F_EDID is set and during protocol_features the=
 GET_EDID feature is not negotiated, exit the gpu backend with an error.<br=
></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Otherwise, if we keep exposing VIRTIO_GPU_F_EDID and just not sending<br>
VHOST_USER_GPU_GET_EDID then the get_edid feature is not quite<br>
functional overall, which doesn&#39;t sound too great.<br>
<br>
Thanks<br>
<br>
Erico<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--000000000000de241005fc6ebd52--

