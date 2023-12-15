Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1D181478F
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 13:02:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rE6sa-0000Ze-5q; Fri, 15 Dec 2023 07:01:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rE6sM-0000Yb-Is
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 07:01:08 -0500
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rE6sJ-0002DG-1g
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 07:01:05 -0500
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-425959f36b0so5059571cf.3
 for <qemu-devel@nongnu.org>; Fri, 15 Dec 2023 04:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702641660; x=1703246460; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oz69BKEs+xhmhhbGH+/+NJbLNPeOprZVW9G1Y3elaK0=;
 b=XTZ7CK0L7AwZA35aAouo/h9mctnizHwZeESvCwToaE6ZIKTyI0RDc5n4epc64rI+7Q
 r5hJf9ZWLwQKr5W9HSOwWAk1gr2AdLHGNdsH8A2uwu8pe7xOlZR/EUdyvhtLUxoS3yLM
 /dFiaNtWNusoCIIYBkSwN5OZNu/j0MEcfsUmmpc1HPUjq8y9O3+svr/4hfrSeE4xFRwD
 3GDBIZNIIZCY6dtnmdTB8oQsX3Tbo8xCdZ76KrMaH85qTdjKsgrk0xKk7wM/FI0JDD9V
 3Uz3HcEIVuZXVaBXpqeYalZVWnfv4NTczE3uvzlZUERc3XXuz6/yfLE8U+nGfRezIpcg
 B7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702641660; x=1703246460;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oz69BKEs+xhmhhbGH+/+NJbLNPeOprZVW9G1Y3elaK0=;
 b=pcAcMr3XbWRZEWODlEAgvpIuBxIcHHfRQ1RfvcdIRoaOBDtv1ZzItG5nls7Zs+35zG
 F2D7Ju8xjEl8Fjtu5mBMmsOvipalWciG4CMs9fwLqjt2peMGxlcO9DmH7fOnkwE6WevG
 DHcXxvxcHkTO294R09Poe9kGlcoTfrgKkxubjtLoC8jUOm7X7lunaqmL9iCcRPIynGJj
 Gh2K2SW2Bax35hU6sDYYe1V/l+2xW0akC8Jz08mfD4k9roS1z2ThV60EkOC+ngh5q/i4
 5qDDMdQfQXqPzTEoDTqZyfmzUnw33dCm5u274q6g40qZQCUkg4nyukQ0JE+ixTjLh66j
 Eq5w==
X-Gm-Message-State: AOJu0YxQW2KdctEbc79RWtgNoXQOlcuCXXbxGZpbNaeVCB1dCZl6vgVF
 WqWzVZohw7STTuQcy4N94dzJ9l9ygRbnR7CGx68=
X-Google-Smtp-Source: AGHT+IGqTbFWA5AiU/rqYIR8K5DGMKArBRzdjPNxPsKKF7FFD49lovNXRjn6BDQcI8y62+SZrgocgL+DZqh6C3trzjo=
X-Received: by 2002:ac8:5ad1:0:b0:425:9d92:821d with SMTP id
 d17-20020ac85ad1000000b004259d92821dmr18859119qtd.135.1702641660460; Fri, 15
 Dec 2023 04:01:00 -0800 (PST)
MIME-Version: 1.0
References: <20231215-dbus-v2-0-1e2e6aa02115@daynix.com>
 <20231215-dbus-v2-1-1e2e6aa02115@daynix.com>
In-Reply-To: <20231215-dbus-v2-1-1e2e6aa02115@daynix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 15 Dec 2023 16:00:48 +0400
Message-ID: <CAJ+F1C+pvRDmZpODinFuSzVYwPdrkar-ceo1aqWwAPtKbQztiw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] Move dbus-display1 out of ui
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::836;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x836.google.com
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
> Despite its name, dbus-display1 does not only provide DBus interfaces
> for the display but also for the audio.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

It can actually do a lot more, since you can arbitrarily redirect
chardev devices.. USB, smartcard, QMP and what's not are possible.

Yet, this is a -display module, so we should leave it under ui/ for now imh=
o

> ---
>  MAINTAINERS                               |  1 +
>  meson.build                               | 21 +++++++++++++++++++++
>  ui/dbus.h                                 |  2 +-
>  audio/dbusaudio.c                         |  2 +-
>  tests/qtest/dbus-display-test.c           |  2 +-
>  ui/dbus-display1.xml =3D> dbus-display1.xml |  0
>  ui/meson.build                            | 18 ------------------
>  7 files changed, 25 insertions(+), 21 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 695e0bd34fbb..0c2630d0e264 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3389,6 +3389,7 @@ F: docs/sphinx/dbus*
>  F: docs/sphinx/fakedbusdoc.py
>  F: tests/qtest/dbus*
>  F: scripts/xml-preprocess*
> +F: dbus-display.xml
>
>  Seccomp
>  M: Daniel P. Berrange <berrange@redhat.com>
> diff --git a/meson.build b/meson.build
> index ec01f8b138aa..5e1b25a47184 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2014,6 +2014,27 @@ dbus_display =3D get_option('dbus_display') \
>             error_message: gdbus_codegen_error.format('-display dbus')) \
>    .allowed()
>
> +if dbus_display
> +  env =3D environment()
> +  env.set('TARGETOS', targetos)
> +  xml =3D custom_target('dbus-display preprocess',
> +                      input: 'dbus-display1.xml',
> +                      output: 'dbus-display1.xml',
> +                      env: env,
> +                      command: [xml_pp, '@INPUT@', '@OUTPUT@'])
> +  dbus_display1 =3D custom_target('dbus-display gdbus-codegen',
> +                                output: ['dbus-display1.h', 'dbus-displa=
y1.c'],
> +                                input: xml,
> +                                command: [gdbus_codegen, '@INPUT@',
> +                                          '--glib-min-required', '2.64',
> +                                          '--output-directory', meson.cu=
rrent_build_dir(),
> +                                          '--interface-prefix', 'org.qem=
u.',
> +                                          '--c-namespace', 'QemuDBus',
> +                                          '--generate-c-code', '@BASENAM=
E@'])
> +  dbus_display1_lib =3D static_library('dbus-display1', dbus_display1, d=
ependencies: gio)
> +  dbus_display1_dep =3D declare_dependency(link_with: dbus_display1_lib,=
 include_directories: include_directories('.'))
> +endif
> +
>  have_virtfs =3D get_option('virtfs') \
>      .require(targetos =3D=3D 'linux' or targetos =3D=3D 'darwin',
>               error_message: 'virtio-9p (virtfs) requires Linux or macOS'=
) \
> diff --git a/ui/dbus.h b/ui/dbus.h
> index 1e8c24a48e32..ba9bab9f84d9 100644
> --- a/ui/dbus.h
> +++ b/ui/dbus.h
> @@ -31,7 +31,7 @@
>  #include "ui/console.h"
>  #include "ui/clipboard.h"
>
> -#include "ui/dbus-display1.h"
> +#include "dbus-display1.h"
>
>  typedef struct DBusClipboardRequest {
>      GDBusMethodInvocation *invocation;
> diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
> index 60fcf643ecf8..5222b3c68804 100644
> --- a/audio/dbusaudio.c
> +++ b/audio/dbusaudio.c
> @@ -34,7 +34,7 @@
>  #endif
>
>  #include "ui/dbus.h"
> -#include "ui/dbus-display1.h"
> +#include "dbus-display1.h"
>
>  #define AUDIO_CAP "dbus"
>  #include "audio.h"
> diff --git a/tests/qtest/dbus-display-test.c b/tests/qtest/dbus-display-t=
est.c
> index 21edaa1e321f..a15e9c377b08 100644
> --- a/tests/qtest/dbus-display-test.c
> +++ b/tests/qtest/dbus-display-test.c
> @@ -5,7 +5,7 @@
>  #include <gio/gio.h>
>  #include <gio/gunixfdlist.h>
>  #include "libqtest.h"
> -#include "ui/dbus-display1.h"
> +#include "dbus-display1.h"
>
>  static GDBusConnection*
>  test_dbus_p2p_from_fd(int fd)
> diff --git a/ui/dbus-display1.xml b/dbus-display1.xml
> similarity index 100%
> rename from ui/dbus-display1.xml
> rename to dbus-display1.xml
> diff --git a/ui/meson.build b/ui/meson.build
> index 0ccb3387ee6a..bbb7c5242d55 100644
> --- a/ui/meson.build
> +++ b/ui/meson.build
> @@ -75,24 +75,6 @@ endif
>
>  if dbus_display
>    dbus_ss =3D ss.source_set()
> -  env =3D environment()
> -  env.set('TARGETOS', targetos)
> -  xml =3D custom_target('dbus-display preprocess',
> -                      input: 'dbus-display1.xml',
> -                      output: 'dbus-display1.xml',
> -                      env: env,
> -                      command: [xml_pp, '@INPUT@', '@OUTPUT@'])
> -  dbus_display1 =3D custom_target('dbus-display gdbus-codegen',
> -                                output: ['dbus-display1.h', 'dbus-displa=
y1.c'],
> -                                input: xml,
> -                                command: [gdbus_codegen, '@INPUT@',
> -                                          '--glib-min-required', '2.64',
> -                                          '--output-directory', meson.cu=
rrent_build_dir(),
> -                                          '--interface-prefix', 'org.qem=
u.',
> -                                          '--c-namespace', 'QemuDBus',
> -                                          '--generate-c-code', '@BASENAM=
E@'])
> -  dbus_display1_lib =3D static_library('dbus-display1', dbus_display1, d=
ependencies: gio)
> -  dbus_display1_dep =3D declare_dependency(link_with: dbus_display1_lib,=
 include_directories: include_directories('.'))
>    dbus_ss.add(when: [gio, dbus_display1_dep],
>                if_true: [files(
>                  'dbus-chardev.c',
>
> --
> 2.43.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

