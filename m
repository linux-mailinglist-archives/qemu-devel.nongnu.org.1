Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E46AE810B95
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 08:32:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDJiq-0007iR-8q; Wed, 13 Dec 2023 02:32:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rDJij-0007i3-DO
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 02:31:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rDJih-0006JF-Lb
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 02:31:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702452709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G54hkUl3s/HAXq0yA0vbudaG7cfPSUDIDcvCAkS+IH0=;
 b=IMN0Nmovu8FX3tF1HgQ2f7brRz8S0yVaj+JXdFeJWPM9ZAsr1psg+TKHmqDo2+afcFqVhx
 1OayaBvxP2ffqAO8qc2XVH9pLecl4siIyfvJED/dtoJ+n3uYvMM44hkubP/GT/BYrp9s25
 4+tzCDdEdEg/oQO4wnsdCo5b5xe3iHM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-HHQc1Z7dMHq9n9mVUXr_sA-1; Wed, 13 Dec 2023 02:31:47 -0500
X-MC-Unique: HHQc1Z7dMHq9n9mVUXr_sA-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-54c6b97fea7so4014356a12.0
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 23:31:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702452706; x=1703057506;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G54hkUl3s/HAXq0yA0vbudaG7cfPSUDIDcvCAkS+IH0=;
 b=mLxN5Fx+KizCKu1yFa4FZr15SARklLzBcRYhuNLzBECY+IkNramHhlTKkKBCf9Hoqw
 ObBEe5QpTGmm0JfQIZJCRp9rua+ZvD3WvAvLxWNg7P2TzDnSPOKYFXHy34NLEUsv1D7D
 0xsyr0QXS0Uv/VGWsr97H+p0jKdRjIUIhY+Vwu4XlL2rrBs3NUkoGwAeIdHm1751FUTK
 ZAKqn95muE9XersUsTFhAwHE6z0Adezxrzbxk3FdmVV87F693Kjg+MZvoxzlBg+6AhtI
 kM+JCYkoPqTDBfjm+gFFAjjQsQt6WSCjdFKoP8oZqGQwGMMrknP/mVZbvZyIXnjOBewG
 NWKA==
X-Gm-Message-State: AOJu0Ywp/zdffnBFWocyENsm/3P3AT/Yy52U21U2IdD4IrgtkD7olDxx
 MMiJYisFVNIMPW80Mc79TcLMDY/upWUZ2QXPmWPgvdCawqEe5QCPTbM3cV9n32L1wFp+Uu4jTF/
 AqOYZMSu7380fCKdOAVhyarKaEpIpl2XKqLDVCpWTuw==
X-Received: by 2002:a50:d654:0:b0:552:2aad:dac9 with SMTP id
 c20-20020a50d654000000b005522aaddac9mr121487edj.60.1702452705847; 
 Tue, 12 Dec 2023 23:31:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELIdaJRVs1sf4V/TzL1boTaJi4d1POJeGH32ri16tODiuGN/K2Y0nPaj5AXrcssKk3aA3JSZjDeipEtfqYAbs=
X-Received: by 2002:a50:d654:0:b0:552:2aad:dac9 with SMTP id
 c20-20020a50d654000000b005522aaddac9mr121481edj.60.1702452705476; Tue, 12 Dec
 2023 23:31:45 -0800 (PST)
MIME-Version: 1.0
References: <20231213065201.886391-1-frolov@swemel.ru>
In-Reply-To: <20231213065201.886391-1-frolov@swemel.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 13 Dec 2023 11:31:32 +0400
Message-ID: <CAMxuvay5gb6XBMpHB3gu-U=sJ-PqF-oB7jeuiD6rifhWg16bAw@mail.gmail.com>
Subject: Re: [PATCH] ui: fix DIV_BY_ZERO in tightvnc
To: Dmitry Frolov <frolov@swemel.ru>
Cc: kraxel@redhat.com, sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Dec 13, 2023 at 11:08=E2=80=AFAM Dmitry Frolov <frolov@swemel.ru> w=
rote:
>
> Division by zero may occur in rare constellation of conditions if:
> 1. not TrueColor mode on the client side
>    tight_detect_smooth_image16() and tight_detect_smooth_image32(),
>    defined by macro DEFINE_DETECT_FUNCTION()2, are affected.
> 2. if all pixels on the screen are equal, then pixels =3D=3D stats[0]
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>

What about the tight_detect_smooth_image24() division?
    errors /=3D (pixels * 3 - stats[0]);

It should probably have a similar safety check.

The code is originally from libvncserver, but they completely changed
their implementation in:
https://github.com/LibVNC/libvncserver/commit/7124b5fbcf0df8db4d3f73023d77a=
f6ea56409e7

otherwise,
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  ui/vnc-enc-tight.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/ui/vnc-enc-tight.c b/ui/vnc-enc-tight.c
> index 41f559eb83..f1249ab136 100644
> --- a/ui/vnc-enc-tight.c
> +++ b/ui/vnc-enc-tight.c
> @@ -284,6 +284,9 @@ tight_detect_smooth_image24(VncState *vs, int w, int =
h)
>          for (; c < 256; c++) {                                          =
\
>              errors +=3D stats[c] * (c * c);                             =
  \
>          }                                                               =
\
> +        if (pixels =3D=3D stats[0]) {                                   =
    \
> +            return 0;                                                   =
\
> +        }                                                               =
\
>          errors /=3D (pixels - stats[0]);                                =
  \
>                                                                          =
\
>          return errors;                                                  =
\
> --
> 2.34.1
>


