Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A317E1A42
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 07:34:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztAh-0007lV-69; Mon, 06 Nov 2023 01:33:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qztAf-0007l6-9Z
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:33:13 -0500
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qztAd-0005Yp-S9
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:33:13 -0500
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-41eae4f0ee6so8105721cf.3
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 22:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699252389; x=1699857189; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fRXP+ZoCneuNGIjxwzjTwvfnxeMN/u7HIZsT5LVa77Q=;
 b=DUkI2K0gqxUqioFbV7HhPX7lXk4CF2Djjky3t2Zlcvj/G+hUjc+eMaRHN4SZp5VS9s
 Jt12YtyLY4rJmeZ1NMYrQvkEJEii2B8BbLEZ7mLOKCdu3zj6Hb6J6oYm4dwh9YN/tzXW
 119aJtqxo0rvypxhe0WdjcJo6iICXj/NFxlyL/g2OEEuE6Tl9EmPpPrwc1ofYJugIDGt
 kpOIo7J699F3yX3aATbB3rRlT9nwh9Ak/d0wvUpVRLDZqQD9zEqbkXKnukal4ClZUSJx
 81sPJcaRBVeYaamamAKV+hqvW5LX697GaEf0wHNy2blgRe66HawutiZzWm/eSZ8dRs07
 pbbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699252389; x=1699857189;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fRXP+ZoCneuNGIjxwzjTwvfnxeMN/u7HIZsT5LVa77Q=;
 b=VF9SRg1Y9MBJvnJUXXYkIw6yCnHNhiWPFWDNNC2pR+cDf6qNtqdbBSaPLu1SHNCjoI
 R2eRwiSFo9NKp6UxuqWenvwIv2ZYoczFWNuwQe5ddFcQNFkW+gAxmI11Sv5HaaueCjHq
 IuEVDRP68Gz2m5lBc7Vp6zji7PPLmCAnBlYi8Et7M9SWcU8zgAf1lTGFKhE9+TuPetCi
 mdRdZ/5j1yyF4uQfctsIqKOhmpa5X7SUq577fN96z3uU1uJKUTWL+Sd3dGmN7QfSsBPs
 wnm1zHNOlHJ6ajaka90j2HkwXi0zThcDd7sbJc+F/XZ6jAKvfAzh+TacKUaJJb21NAZH
 F8CQ==
X-Gm-Message-State: AOJu0YweAMb5pftqGj/lZtPzOlyl/NIUWKvtmQWPBrbIULBIFYP1qVHn
 2k4cM9Yl9Y1X3ALK14ZnWYe4Gh4jCPPJnB/Qy8M=
X-Google-Smtp-Source: AGHT+IGEM5XaxI8UEjNIkzkYYihryHx958epKFffhTuk9ufSdnpwVuZ2evQdXPzubnOo53HnIWwZ1zJTV5U1QK2Aj0E=
X-Received: by 2002:a05:622a:550:b0:41c:e1a7:664 with SMTP id
 m16-20020a05622a055000b0041ce1a70664mr30168047qtx.59.1699252389105; Sun, 05
 Nov 2023 22:33:09 -0800 (PST)
MIME-Version: 1.0
References: <6f8b1f96-4520-49d5-8a09-b2935ab4bd9d@t-online.de>
 <20231105172552.8405-2-vr_qemu@t-online.de>
In-Reply-To: <20231105172552.8405-2-vr_qemu@t-online.de>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 6 Nov 2023 10:32:57 +0400
Message-ID: <CAJ+F1CKvNncNFg+ZP=ZS2gKdNE3WuaOpudazCJ8nD5W1=Rh+wA@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/audio/hda-codec: reenable the audio mixer
To: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Martin Kletzander <mkletzan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82e.google.com
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

On Sun, Nov 5, 2023 at 9:26=E2=80=AFPM Volker R=C3=BCmelin <vr_qemu@t-onlin=
e.de> wrote:
>
> Commit b7639b7dd0 ("hw/audio: Simplify hda audio init") inverted
> the sense of hda codec property mixer during initialization.
> Change the code so that mixer=3Don enables the hda mixer emulation
> and mixer=3Doff disables the hda mixer emulation.
>
> With this change audio playback and recording streams don't start
> muted by default.
>
> Fixes: b7639b7dd0 ("hw/audio: Simplify hda audio init")
> Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/audio/hda-codec.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
> index f756e419bb..0bc20d49f6 100644
> --- a/hw/audio/hda-codec.c
> +++ b/hw/audio/hda-codec.c
> @@ -868,10 +868,10 @@ static Property hda_audio_properties[] =3D {
>  static void hda_audio_init_output(HDACodecDevice *hda, Error **errp)
>  {
>      HDAAudioState *a =3D HDA_AUDIO(hda);
> -    const struct desc_codec *desc =3D &output_nomixemu;
> +    const struct desc_codec *desc =3D &output_mixemu;
>
>      if (!a->mixer) {
> -        desc =3D &output_mixemu;
> +        desc =3D &output_nomixemu;
>      }
>
>      hda_audio_init(hda, desc, errp);
> @@ -880,10 +880,10 @@ static void hda_audio_init_output(HDACodecDevice *h=
da, Error **errp)
>  static void hda_audio_init_duplex(HDACodecDevice *hda, Error **errp)
>  {
>      HDAAudioState *a =3D HDA_AUDIO(hda);
> -    const struct desc_codec *desc =3D &duplex_nomixemu;
> +    const struct desc_codec *desc =3D &duplex_mixemu;
>
>      if (!a->mixer) {
> -        desc =3D &duplex_mixemu;
> +        desc =3D &duplex_nomixemu;
>      }
>
>      hda_audio_init(hda, desc, errp);

It could be even further simplified:

    hda_audio_init(hda, a->mixer ? &output_mixemu : &output_nomixemu, errp)=
;

> @@ -892,10 +892,10 @@ static void hda_audio_init_duplex(HDACodecDevice *h=
da, Error **errp)
>  static void hda_audio_init_micro(HDACodecDevice *hda, Error **errp)
>  {
>      HDAAudioState *a =3D HDA_AUDIO(hda);
> -    const struct desc_codec *desc =3D &micro_nomixemu;
> +    const struct desc_codec *desc =3D &micro_mixemu;
>
>      if (!a->mixer) {
> -        desc =3D &micro_mixemu;
> +        desc =3D &micro_nomixemu;
>      }
>
>      hda_audio_init(hda, desc, errp);
> --
> 2.35.3
>
>


--=20
Marc-Andr=C3=A9 Lureau

