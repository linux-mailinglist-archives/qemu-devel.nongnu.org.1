Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E131381479C
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 13:05:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rE6vy-0001nZ-09; Fri, 15 Dec 2023 07:04:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rE6vv-0001nH-S9
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 07:04:47 -0500
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rE6vu-0005Vx-9h
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 07:04:47 -0500
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-425f5964ce1so4865601cf.1
 for <qemu-devel@nongnu.org>; Fri, 15 Dec 2023 04:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702641885; x=1703246685; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=naNVVqQ2Iq4vqK97XIGkVsEswToV81QezveyGttzatA=;
 b=VUCRh8TQI6b56f2xwYnMD+TczMuo129K+zuG6Vb7egRODGb9JH2LT5ejUDryhQoWSR
 cpTkzt5zIrYvS4/W8zWzv++qYxgT0eScYBo8F4TEgH8mNLnzrYy5dc8jCzuz1E3Ktk6E
 k0Uevq5YPwcaxr5rA6WKqQmti9pXU0A1Z39m99kc/FgD/89CvgsWfvtkNonJ39Gu2vuk
 YQgKvXGiKw9oc3Stn4x042nIJETBmZHvLPFUB4Euk1B3rwBMz6JskF7A4AdtzJTSkksW
 vTXHZccidnJBxww+AjX3FgvOWzfR1O3dAPQAkKallX6DasNyPaYeAFiLeIg1D4Mz+5Sz
 SlAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702641885; x=1703246685;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=naNVVqQ2Iq4vqK97XIGkVsEswToV81QezveyGttzatA=;
 b=DVPQ+RGO6suCHMPQgCEOZG5Kf/KZ9IeIKBdfRBcFuiK+psxntR7GK6LVeMWYWdzbWv
 mI/wpYpmkrwd7qnhrg72bzUOjXaaRCVWo/FsVhJa2F9Kx3z5t+5wrXWZxgTTWqNNUM2k
 BY0AQsBy2qX65R7rtEQNSf5HuSJShnRUC01fs2l9AWhZNur9fVjXIzn/cuj2pjX4NrQg
 GGbIUlWoSQBBbiSlMSonZqkBMQahhDjvTls1ejDUP73Ke5M6NOVDwb7sWba3gD+8Rvob
 oHcGwkzJqW1m0WuYya7U5PQBnA8G8BJb9CLO4lwtXrjkOWNLxx716PKSFLinHkHIjamX
 +sfQ==
X-Gm-Message-State: AOJu0Yw2NhrMDfUBnZ8ed1plYVYdZ0PywEM17OlqBlsuRfoAekpdaBuj
 LXvXEF6LrgUd53/QF6lgpky3+D1i8k61f1MyNH1WjcYC7yc=
X-Google-Smtp-Source: AGHT+IGO0KqEmpOXos+mdOsUagLBKC+W6XUgxHYJFM9mxjlsYKixZsyJshRix0+pF0gdW0XWGEG9fFe52izfKtfb3Ws=
X-Received: by 2002:ac8:7f48:0:b0:425:4043:50f0 with SMTP id
 g8-20020ac87f48000000b00425404350f0mr15337453qtk.127.1702641885112; Fri, 15
 Dec 2023 04:04:45 -0800 (PST)
MIME-Version: 1.0
References: <20231215-dbus-v2-0-1e2e6aa02115@daynix.com>
 <20231215-dbus-v2-2-1e2e6aa02115@daynix.com>
In-Reply-To: <20231215-dbus-v2-2-1e2e6aa02115@daynix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 15 Dec 2023 16:04:34 +0400
Message-ID: <CAJ+F1CJRu+cAq+8w0hVLaxpEH6SJ1z5fEEFrPUbaJnjTQt8vsQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] audio: Depend on dbus_display1_dep
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x830.google.com
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

On Fri, Dec 15, 2023 at 3:29=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> dbusaudio needs dbus_display1_dep.
>
> Fixes: 739362d4205c ("audio: add "dbus" audio backend")

The build didn't fail, did it? You don't need to backport this, thus I
don't think "Fixes" apply here.

(furthermore, dbus_display1_dep was added later, in commit 1222070e7
"meson: ensure dbus-display generated code is built before other
units")

> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

otherwise, lgtm
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  audio/meson.build | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/audio/meson.build b/audio/meson.build
> index c8f658611f42..608f35e6af78 100644
> --- a/audio/meson.build
> +++ b/audio/meson.build
> @@ -30,7 +30,8 @@ endforeach
>
>  if dbus_display
>      module_ss =3D ss.source_set()
> -    module_ss.add(when: [gio, pixman], if_true: files('dbusaudio.c'))
> +    module_ss.add(when: [gio, dbus_display1_dep, pixman],
> +                  if_true: files('dbusaudio.c'))
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

