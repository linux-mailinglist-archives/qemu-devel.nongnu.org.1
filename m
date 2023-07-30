Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AD476875A
	for <lists+qemu-devel@lfdr.de>; Sun, 30 Jul 2023 21:18:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQBuu-0003DE-Pg; Sun, 30 Jul 2023 15:17:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qQBur-0003D2-6A; Sun, 30 Jul 2023 15:17:21 -0400
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qQBup-0002Pa-MX; Sun, 30 Jul 2023 15:17:20 -0400
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-40849e69eb5so10580711cf.1; 
 Sun, 30 Jul 2023 12:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690744637; x=1691349437;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IC9+2XmSwELvjjFh+s/lbhVTMpjfnGZKtH/c+xknbh0=;
 b=VBQAkdFHlq7dHGBkAxioRf1wCQhWkh+ImCJ9qmFqviJ5GIxjNlVMhrr7uwis3Y+C8y
 WxVw+xqBEtpD9mq+fbHmNfaD+lwEzXDHSgaZBlRA9loKPB9dHRUUVavaPv3xeDoxFIfB
 H6OSwpGUWmyFtZqegsGn93ALzX6TJZDEbZqGgfxYZ3B+FVp0xe0Joh3rxzVVwFUsOGXT
 Q0sjIxETv03RJaLYM03ufdKQkx0YCuLaFlDjOJu9j4EhLtkohBAPmKnSq+hdAoldEkTt
 LcEZDPqAfMNo93GzHT1NdPyh9qRPiKn9nbhMiUtYGP0JCpgid5kP0Nvbmv+XpGJXi3SL
 0tiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690744637; x=1691349437;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IC9+2XmSwELvjjFh+s/lbhVTMpjfnGZKtH/c+xknbh0=;
 b=gJSky5ZaHUIaDSUxEf+kfCd0kaJYZGaYsYT+LBk++lvv0Kv7QSUhmYpYEC2C6m0f18
 P9rfbO+6uWmZO3HKVOKNYl5QshY5QH/gTtmOjrpWURpHgwX4y1G2YCwTy3NN10xdtvZm
 vSq+nPM2JtjbnURFGf5qEZaxUgtQcLr8Ll7KD98LWWjppyb740oZNBn9QiVjG9qQ0KWK
 L2evJeP9NKDc2M7nAC2+XjIN63g+wQb6JvAx3f8s4niE2xSLMjrGNhaQSX3i1qJpAgU/
 d5xFhvnTS1LFUG3XcjLkG5aALzjTCuGVEBO0k1r/UeUK/e1ckIA7RWNCzXpIwZxG8eil
 Umuw==
X-Gm-Message-State: ABy/qLZVML00RHWsQjbIFF+AYT6hrpKYadFhmyDem2a2ELCNZQOzKI+A
 Hxac1DkCBs13dbY2JkFSN4PwQy7V1qh7afu3b6A=
X-Google-Smtp-Source: APBJJlHk+k8RdMbKN4hUMkqYe8m53ghhUmgLDhEsiaF9g4+ySWP2kf1eOrtRO/nn9emu7OPxot3WZNAnuUyH06sxueU=
X-Received: by 2002:a05:622a:3cf:b0:406:948b:1b29 with SMTP id
 k15-20020a05622a03cf00b00406948b1b29mr9969473qtx.17.1690744637084; Sun, 30
 Jul 2023 12:17:17 -0700 (PDT)
MIME-Version: 1.0
References: <TYCP286MB12667F4B46EE030F93FFDA47ED04A@TYCP286MB1266.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <TYCP286MB12667F4B46EE030F93FFDA47ED04A@TYCP286MB1266.JPNP286.PROD.OUTLOOK.COM>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sun, 30 Jul 2023 23:17:05 +0400
Message-ID: <CAJ+F1CLxhmRgtFetFrpTz8pJzYQCY6Y-xmR1FMOS4Zh+s9esPg@mail.gmail.com>
Subject: Re: [PATCH] hda-audio: use log-scale for amplifier levels
To: Yuanqing Li <liyq.yuanqing@outlook.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi

On Sun, Jul 30, 2023 at 5:52=E2=80=AFPM Yuanqing Li <liyq.yuanqing@outlook.=
com> wrote:
>
> According Intel's High Definition Audio Specification (Revision 1.0a,
> Section 7.3.4.10: Amplifier Capabilities), the amplifier gain levels
> should be evenly spaced in dB, i.e. using a log scale instead of linear.
>
> Here, the hda-codec reports amplifier levels from 0 to -48 dB at 1-dB
> steps matching the 8-bit dynamic range, and the -49 dB level is mapped
> to 0 (muted).
>
> Signed-off-by: Yuanqing Li <liyq.yuanqing@outlook.com>
> ---
>  hw/audio/hda-codec.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
> index c51d8ba617..c2aa71624b 100644
> --- a/hw/audio/hda-codec.c
> +++ b/hw/audio/hda-codec.c
> @@ -121,7 +121,7 @@ static void hda_codec_parse_fmt(uint32_t format, stru=
ct audsettings *as)
>  #define QEMU_HDA_PCM_FORMATS (AC_SUPPCM_BITS_16 |       \
>                                0x1fc /* 16 -> 96 kHz */)
>  #define QEMU_HDA_AMP_NONE    (0)
> -#define QEMU_HDA_AMP_STEPS   0x4a
> +#define QEMU_HDA_AMP_STEPS   0x31 /* 20 * log10(255) =3D 48 dB dynamic r=
ange */
>
>  #define   PARAM mixemu
>  #define   HDA_MIXER
> @@ -433,6 +433,14 @@ static void hda_audio_set_running(HDAAudioStream *st=
, bool running)
>      }
>  }
>
> +/* first muted; then from -48 dB to 0 dB */
> +static const uint32_t hda_vol_table[] =3D {
> +    0,   1,   1,   1,   1,   2,   2,   2,   2,   3,   3,   3,   4,   4, =
  5,
> +    5,   6,   6,   7,   8,   9,   10,  11,  13,  14,  16,  18,  20,  23,=
  26,
> +    29,  32,  36,  40,  45,  51,  57,  64,  72,  81,  90,  102, 114, 128=
, 143,
> +    161, 181, 203, 227, 255
> +}

It was not clear to me which scale is applied by the backend. I guess
mixeng uses linear, and thus all others should too.

> +
>  static void hda_audio_set_amp(HDAAudioStream *st)
>  {
>      bool muted;
> @@ -446,8 +454,8 @@ static void hda_audio_set_amp(HDAAudioStream *st)
>      left  =3D st->mute_left  ? 0 : st->gain_left;
>      right =3D st->mute_right ? 0 : st->gain_right;
>
> -    left =3D left * 255 / QEMU_HDA_AMP_STEPS;
> -    right =3D right * 255 / QEMU_HDA_AMP_STEPS;
> +    left =3D hda_vol_table[left];
> +    right =3D hda_vol_table[right];
>

Whoo, better check bounds here. (value can go up to AC_AMP_GAIN 0x7f,
reading the code)

Definitely not trivial material imho

--=20
Marc-Andr=C3=A9 Lureau

