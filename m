Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11331816708
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 08:08:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rF7iJ-0006KQ-H6; Mon, 18 Dec 2023 02:06:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rF7iG-0006KD-LW
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 02:06:52 -0500
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rF7iF-00039d-6y
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 02:06:52 -0500
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-425c54f5842so28679901cf.2
 for <qemu-devel@nongnu.org>; Sun, 17 Dec 2023 23:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702883210; x=1703488010; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hgzz9c3uSeYRxGVR8sHxPatlE80PwA0vJumlwB4wMBo=;
 b=VhjvuCnFb3Rc6dCiFN+dUagqnhTCMTVxJFaYmgvv0SS/IBt/o7mdnWCRfsbqR+7bS3
 b8qtGl4K2EB6EOetwhLidMbHSNHr0xVX2p2BkVdPC+hYuC5aGPsXeee0NGHeUqkiSoob
 +kn7GqMAT0F+7++ELpoKQB9Z7OVp58DUsAtj75QpdKdh8MNRscspI02/yLv+Q9OTVQiY
 eOQbclTNFPCIgKj8xGpmFEj5hAvKjNOOpBjEfzMCOWEcllx6bT32zvCNeXRyXnBfpfxv
 k80EMO+8nWK3kSyfBAzeJTrulOpGQ0IAikb2ki3oC06cO919GxxLzODA6+8FzL5By7ax
 dsOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702883210; x=1703488010;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hgzz9c3uSeYRxGVR8sHxPatlE80PwA0vJumlwB4wMBo=;
 b=RvbP8BletLKP6jvcG5m/KIDwgH2xbQkSRjqFK8b1Xy0G6VePTtS56NvXJP6bXzMylZ
 k3vpP4EzcFu2X2bL9/wTKcYINjMhhvdf4wfBXGcH9lLmPe//w10BrY8aX/3BWC7VUjHR
 cNofdJIEAT9GTktFtG77DElcE9W71L7962pK40hZTLA4NOblW0MrqeDCmr+vuIuN0GKT
 Pz0UYubub5DQfZAY0M+wT9luOFSGCZXPXALciw2X8lYwmCmGXvadUyMb0pvuIZuP3Oyd
 Xf6/yXdgPxDi861Zn8aRVXWi0pcn5g2zP8nQhbB1aYTGI/qNdNLidjj00IHxDMrkN/DW
 Qu0A==
X-Gm-Message-State: AOJu0YzjntuVVg4DtRtbiSvVnTKXASGBPng+JhtdfTe5mFmFTYRHY1M+
 ktxv1TdpZZs/D0xIFtXYRshpLrPzAdCJH7yP/k0=
X-Google-Smtp-Source: AGHT+IFFI2J5Tq5GxNl7na9sxLNr7vnGvaFOPPUr8gyCCtogO9+RB/EwV+5YDx866TEoufWcheJ/BkoFtOhQ/aWoXBY=
X-Received: by 2002:a05:622a:144e:b0:425:aa00:cdd9 with SMTP id
 v14-20020a05622a144e00b00425aa00cdd9mr22405048qtx.16.1702883209791; Sun, 17
 Dec 2023 23:06:49 -0800 (PST)
MIME-Version: 1.0
References: <20231217-dbus-v5-0-8122e822a392@daynix.com>
 <20231217-dbus-v5-2-8122e822a392@daynix.com>
In-Reply-To: <20231217-dbus-v5-2-8122e822a392@daynix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 18 Dec 2023 11:06:38 +0400
Message-ID: <CAJ+F1C+MSBdmtebUiiHZVMAxsT6e=diU5_c97u_hgbxON6a4Ng@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] audio: Do not include ui/dbus.h
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82f.google.com
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

On Sun, Dec 17, 2023 at 10:14=E2=80=AFAM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
>
> ui/dbusaudio.c does not depend on ui/dbus.h
>

It uses dbus_win32_import_socket()

> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  audio/dbusaudio.c | 1 -
>  audio/meson.build | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
> index 2aacdac6715b..3cd8e294501f 100644
> --- a/audio/dbusaudio.c
> +++ b/audio/dbusaudio.c
> @@ -33,7 +33,6 @@
>  #include <gio/gunixfdlist.h>
>  #endif
>
> -#include "ui/dbus.h"
>  #include "util/dbus-display1.h"
>
>  #define AUDIO_CAP "dbus"
> diff --git a/audio/meson.build b/audio/meson.build
> index c8f658611f42..8931c1697b4d 100644
> --- a/audio/meson.build
> +++ b/audio/meson.build
> @@ -30,7 +30,7 @@ endforeach
>
>  if dbus_display
>      module_ss =3D ss.source_set()
> -    module_ss.add(when: [gio, pixman], if_true: files('dbusaudio.c'))
> +    module_ss.add(when: [gio], if_true: files('dbusaudio.c'))
>      audio_modules +=3D {'dbus': module_ss}
>  endif
>
>
> --
> 2.43.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

