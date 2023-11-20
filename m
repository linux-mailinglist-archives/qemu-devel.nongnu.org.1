Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DA97F0D61
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 09:18:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4zSs-0005vJ-DY; Mon, 20 Nov 2023 03:17:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r4zSq-0005v6-1e
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 03:17:04 -0500
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r4zSo-0000Oh-2B
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 03:17:03 -0500
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-77891f362cfso343127985a.1
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 00:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700468219; x=1701073019; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mM+9E0tLZmM034xhGrnJkAtk2akDnV55hzoRD3c25NI=;
 b=go+CHKZbclx8kINAaBwd8dIOTXfMCpec1+S4dvdBFQsCWRsa9sTVxh3b/tapY8Lvx/
 ia1h4epEQZ7dX4GWLrt6Qpx4eUGEmvbTbFfq3xgT6Bk2VONhhgTFPcUBmZG1ObD+S+NZ
 gUZWkQ3dyQF00C+NW4TE1HImJSXkfU5cOgVY7fbfi7TFrOPErky9lWqBtilLcJKqmnYZ
 AmUFh7j9bAv+AXKFw8RR+lSZUspWuwJ4ol5+Muyk+oqbzd1qb02KgVR2va1GsjGpRqmU
 MUFE1wyeb1QACmMVrf1vxG/+cTpSiY3OBrkDLEcE2TdyLeGdSjMWLAas4hm+f/RqrUbk
 S5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700468219; x=1701073019;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mM+9E0tLZmM034xhGrnJkAtk2akDnV55hzoRD3c25NI=;
 b=QQe2U1GxY6Htdj2ttAliEb0lLc8PdqW9O/5pOS85vJ/7ND+11muXSvLM8JZvozRvQI
 Tt/VWCwj8s6Z1ZoBMKOpqw3AU6Us54nomr961HIJo36Gr3KhSVcWeK7150AMc4UmqmqO
 YwLI6UgiiDQfTORUKXasL2pRvL15d75A9iEfim3CVMviSstxxiTHE8asQgPbNdwTvdah
 x68y0Z2xDtlMB6LalmRnkpY8Qh/n91u6eDqqBir8JJjoGMMGjPv6x0v6ba7lT72+Yl6W
 /RthVeXArs9ovLisyGeH/t9mF0NavHSEMdCoU1ce2h2UIJmAxkPcasbBPozuSGtfS2vC
 HLCA==
X-Gm-Message-State: AOJu0YyJlcqIj65DiEphozEv0DAn/Hqqyx0WggAYzaO14U4DfEWT6QAU
 qi0oqCOJt+TF1xdFKXkWki/qel4bOLikyAWCsuY=
X-Google-Smtp-Source: AGHT+IHtanR5FoK+mIuxWHumRh7l2P7vDXe3hCW0N1IlgyePXpeFBBBOISe+b7zklOkb18sy/K1BUvaezcdopAg249w=
X-Received: by 2002:a05:620a:404b:b0:772:749a:ec13 with SMTP id
 i11-20020a05620a404b00b00772749aec13mr18818952qko.2.1700468219437; Mon, 20
 Nov 2023 00:16:59 -0800 (PST)
MIME-Version: 1.0
References: <20231116075019.296115-1-zhouyang23@xiaomi.com>
In-Reply-To: <20231116075019.296115-1-zhouyang23@xiaomi.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 20 Nov 2023 12:16:48 +0400
Message-ID: <CAJ+F1C+ZQ9m6qFiVmrpisu0tWC4U_UuwUyz6XHD+LkaAKgWgiA@mail.gmail.com>
Subject: Re: [PATCH] hw/audio: Fix logic error in hda audio
To: zhouyang23 <zhouyang23@xiaomi.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::72c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x72c.google.com
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

On Thu, Nov 16, 2023 at 1:48=E2=80=AFPM zhouyang23 via <qemu-devel@nongnu.o=
rg> wrote:
>
> Commit b7639b7dd0 introduced a logic error about mixer and nomixer.
> Cause use micro_mixemu when there is no mixer in HDAAudioState, but
> use micro_nomixemu wehen there has a mixer in HDAAuditState.
>
> Signed-off-by: zhouyang23 <zhouyang23@xiaomi.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/audio/hda-codec.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
> index b9ad1f4c39..87bacb3bee 100644
> --- a/hw/audio/hda-codec.c
> +++ b/hw/audio/hda-codec.c
> @@ -857,7 +857,7 @@ static void hda_audio_init_output(HDACodecDevice *hda=
, Error **errp)
>      HDAAudioState *a =3D HDA_AUDIO(hda);
>      const struct desc_codec *desc =3D &output_nomixemu;
>
> -    if (!a->mixer) {
> +    if (a->mixer) {
>          desc =3D &output_mixemu;
>      }
>
> @@ -869,7 +869,7 @@ static void hda_audio_init_duplex(HDACodecDevice *hda=
, Error **errp)
>      HDAAudioState *a =3D HDA_AUDIO(hda);
>      const struct desc_codec *desc =3D &duplex_nomixemu;
>
> -    if (!a->mixer) {
> +    if (a->mixer) {
>          desc =3D &duplex_mixemu;
>      }
>
> @@ -881,7 +881,7 @@ static void hda_audio_init_micro(HDACodecDevice *hda,=
 Error **errp)
>      HDAAudioState *a =3D HDA_AUDIO(hda);
>      const struct desc_codec *desc =3D &micro_nomixemu;
>
> -    if (!a->mixer) {
> +    if (a->mixer) {
>          desc =3D &micro_mixemu;
>      }
>
> --
> 2.34.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

