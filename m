Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 574537AB126
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 13:47:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjebx-0007DM-Pl; Fri, 22 Sep 2023 07:46:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qjebr-0007Bu-T8
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 07:46:12 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qjebp-0000XX-VM
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 07:46:11 -0400
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-412989e3b7bso12591191cf.1
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 04:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695383164; x=1695987964; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IKlKVMzbhNC6QnFM5serjBzBN+trg+W5rm99fZZVjWA=;
 b=NVMagNQ4N4LMZfXYrdQwk4kW8tKTrc0+SC48HOsy86QtqKspQIcQf+CR/BvocKtvR9
 ODWqrJvx81mNQ0GOMbSct5PIGP1KuY8Fey/bO8cO4loESOBZVNUyEjzuuJBnbS47O86f
 XN86JW5keoVbz0hXqm3E8a9auowHVGwgqkH8kOA6NZJzVIbD3zp/xZ5V8PYrWyVIkniL
 uuNCn7bfpixuJBJTnkWaNWdN36KvTHdbcsezXp/GcqK9P/wqzdkxwYmOeOlBoZCgC9Py
 ZZo5zFkvH07HTb8NDgQ8UCVnNM1Hi6cLyPvgxQ93mx2ccG25vg9dS8HLrhdb43i/7lgI
 KFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695383164; x=1695987964;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IKlKVMzbhNC6QnFM5serjBzBN+trg+W5rm99fZZVjWA=;
 b=FSBGkPjNfHgHZBQlg4t5R5J7Vho7U517QeJBMgxhES+CmsyRwEDfzQTUYqD0pH09Y8
 AygnNWYYx6oLovqPbuc0UsIj5n703qNEOZbBE8VuvYrJ2LS4rv3VFRdU2F140K8D8xPE
 mpeWgtBpoiXbT8I/5cqRvWh4GKvFdQpPn6IU/Tuw7YB0evBdq3kw1SrM+nQ1V/PNsyEw
 tQ4xJkdt83PJiagDkMR8LH3gM0FhzodXv5dK4EJvAcRm9ikgjYBeprj9ro5coaDJNe3p
 uyFhOG625YzKBu4nE4yQu99haaxtwlUkmjaOFhuTFMoML1NLvFv9FCq4PBHtSgD6LZeV
 oKyg==
X-Gm-Message-State: AOJu0Yw4ir+Ye2FBWOrG97fx2QgoLa3vD7uI98MIKwBm12i4YqULszHK
 zAtddKVk7D5AS8kS2GyLYlsdOZfXhVggbBRzjgY=
X-Google-Smtp-Source: AGHT+IEEyf3rWZ9WKp8jbGtFmMjStTw+8qz8YHZHGF5SBzky94JQnxym1o2PP/2cdqcjUyh4+faszCK1bthxEBYAzgM=
X-Received: by 2002:ac8:5fcf:0:b0:412:bf83:e759 with SMTP id
 k15-20020ac85fcf000000b00412bf83e759mr8288286qta.42.1695383164037; Fri, 22
 Sep 2023 04:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230922094459.265509-1-pbonzini@redhat.com>
 <20230922094459.265509-2-pbonzini@redhat.com>
In-Reply-To: <20230922094459.265509-2-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 22 Sep 2023 15:45:52 +0400
Message-ID: <CAJ+F1C+Vg4n9v26t+PQLnELasdEajADXn7TJwbVabs_uNz3wdg@mail.gmail.com>
Subject: Re: [PATCH 1/9] audio: Add easy dummy audio initialiser
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, mkletzan@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 22, 2023 at 1:46=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> From: Martin Kletzander <mkletzan@redhat.com>
>
> In case of sound devices which are created by default (some of them even =
with
> -nodefaults) it would not be nice to users if qemu required explicit:
>
>   -audiodev driver=3Dnone,id=3Daudio0 -machine audiodev=3Daudio0
>
> when they just want to run a VM and not care about any audio output.  Ins=
tead
> this little helper makes it easy to create a dummy audiodev (driver=3Dnon=
e) in
> case there is no audiodev specified for the machine.  To make sure users
> are not surprised by no sound output a helping message is also printed ou=
t.
>
> Signed-off-by: Martin Kletzander <mkletzan@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  audio/audio.c | 34 ++++++++++++++++++++++++++++++++++
>  audio/audio.h |  2 ++
>  2 files changed, 36 insertions(+)
>
> diff --git a/audio/audio.c b/audio/audio.c
> index d72e7db7fb9..8c74bc6b88c 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -41,6 +41,7 @@
>  #include "sysemu/runstate.h"
>  #include "ui/qemu-spice.h"
>  #include "trace.h"
> +#include "hw/boards.h"
>
>  #define AUDIO_CAP "audio"
>  #include "audio_int.h"
> @@ -2174,6 +2175,39 @@ bool audio_init_audiodevs(void)
>      return true;
>  }
>
> +static void audio_init_dummy(const char *id)
> +{
> +    Audiodev *dev =3D g_new0(Audiodev, 1);
> +    AudiodevListEntry *e =3D g_new0(AudiodevListEntry, 1);
> +
> +    dev->driver =3D AUDIODEV_DRIVER_NONE;
> +    dev->id =3D g_strdup(id);
> +
> +    audio_validate_opts(dev, &error_abort);
> +    audio_init(dev, NULL);
> +
> +    e->dev =3D dev;
> +    QSIMPLEQ_INSERT_TAIL(&audiodevs, e, next);
> +}
> +
> +const char *audio_maybe_init_dummy(const char *default_id)
> +{
> +    MachineState *ms =3D MACHINE(qdev_get_machine());
> +
> +    if (ms->default_audiodev) {
> +        return ms->default_audiodev;
> +    }

../audio/audio.c:2197:11: error: =E2=80=98MachineState=E2=80=99 {aka =E2=80=
=98struct
MachineState=E2=80=99} has no member named =E2=80=98default_audiodev=E2=80=
=99
 2197 |     if (ms->default_audiodev) {

introduced in next patch

> +
> +    dolog("warning: No audiodev specified for implicit machine devices, =
"
> +          "no audio output will be available for these. "
> +          "For setting a backend audiodev for such devices try using "
> +          "the audiodev machine option.\n");
> +
> +    audio_init_dummy(default_id);
> +
> +    return default_id;
> +}
> +
>  audsettings audiodev_to_audsettings(AudiodevPerDirectionOptions *pdo)
>  {
>      return (audsettings) {
> diff --git a/audio/audio.h b/audio/audio.h
> index a276ec13eba..81d39526625 100644
> --- a/audio/audio.h
> +++ b/audio/audio.h
> @@ -176,6 +176,8 @@ void audio_help(void);
>  AudioState *audio_state_by_name(const char *name);
>  const char *audio_get_id(QEMUSoundCard *card);
>
> +const char *audio_maybe_init_dummy(const char *default_id);
> +
>  #define DEFINE_AUDIO_PROPERTIES(_s, _f)         \
>      DEFINE_PROP_AUDIODEV("audiodev", _s, _f)
>
> --
> 2.41.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

