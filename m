Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB307918D5
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 15:42:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd9pp-00073a-MR; Mon, 04 Sep 2023 09:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qd9pm-0006yj-3y
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 09:41:42 -0400
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qd9pg-0003cn-GI
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 09:41:41 -0400
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-41205469f4eso5478151cf.0
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 06:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693834895; x=1694439695; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HqPv8TFWPh2gl+iqgwBGWkgSr/ap2i+gwaKgPg8ano4=;
 b=Cd78wXQxXbo0+Wh1pG33SAcKhV4YCxw8wladwjvkX6tg/e+7ogjB2W+oW5S2JRedW7
 bb2S5gsHP2Js97ZjX4zhTrd+LAi/jTpIKkuwFzC/k5qJhkTzhp+5na2zV2jAHfUFYhcP
 5djr0Kt+yUPwuBRhdm0IcG2EYYDhMrX0oDnh7GMhGbl5Yo7pD51B1Ey010b2eCPodun+
 lEiQPe9mSK1aGyh200Aedr5xVAV6tBk4fwn6BryQjJENMbDyV4qJDwy0fWx8LIpjl62u
 xuELLxWtyvXx8N1fTZU1vnr9+1PHWLiLer2kvgMkwq6Vk4YY7OZ0VaKAkRwQeC8uBvdR
 TJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693834895; x=1694439695;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HqPv8TFWPh2gl+iqgwBGWkgSr/ap2i+gwaKgPg8ano4=;
 b=CIhVABUW5bDsUI6LqZQp/H5+MC05eptQCKPWnOBPYc77lHhOVKscdWlPDn8oHNMLER
 /rRsLBdxEG9Eg7q4zIuOuCrIbgKu4N5Lzk7gZOzAaE/kbWGZpB/inCJikUynnbPA5t9+
 A9p6VCmV+acZhNpDnvuFmZt4CXEXRCcY4uMmEKiR0WlIycqKlcSrDoivgkXToK8U3GTD
 4FMq44YzH5yOz2FWVstPw+7rAyHb21jbT+iMcVZFL9YVgjODbiy9fOTykUY374t4gNzc
 1fnmLaBYYkDpJmM6DQuTjf/IaGrh2vvzDzQ//ffiH/RwwMkhNPIOcei7wQcbU06cI8tJ
 LIHA==
X-Gm-Message-State: AOJu0YxfydQ3GysPEB47yaNJk/upMzH5CL57PwZ5Ay/ogUx9vWc6TUYo
 qpOs4fp9JMyDFLXILBn+oA/WCEid+EGMilmTwm4=
X-Google-Smtp-Source: AGHT+IE+bWOFv/HV2s3XNTdtBP1JdZk53DjwT8wNfD4s6Q97+XtN2bMIdi/dwU6iM4SY630cYW/Ak++jyg1LYFvGPcc=
X-Received: by 2002:a05:622a:4d1:b0:3f9:aa80:b48a with SMTP id
 q17-20020a05622a04d100b003f9aa80b48amr14531141qtx.8.1693834894611; Mon, 04
 Sep 2023 06:41:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
 <20230830093843.3531473-55-marcandre.lureau@redhat.com>
 <ZPIfJd0h6h5zeiMa@redhat.com>
In-Reply-To: <ZPIfJd0h6h5zeiMa@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 4 Sep 2023 17:41:23 +0400
Message-ID: <CAJ+F1C+ZAzG16vaPoDgzUybSbnk0sWjDhH0nSjU7P71btp2d9g@mail.gmail.com>
Subject: Re: [PATCH 54/67] ui/vc: console-vc requires PIXMAN
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::836;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x836.google.com
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

On Fri, Sep 1, 2023 at 9:28=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Wed, Aug 30, 2023 at 01:38:28PM +0400, marcandre.lureau@redhat.com wro=
te:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Add stubs for the fallback paths.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  ui/console-vc-stubs.c | 59 +++++++++++++++++++++++++++++++++++++++++++
> >  ui/meson.build        |  2 +-
> >  2 files changed, 60 insertions(+), 1 deletion(-)
> >  create mode 100644 ui/console-vc-stubs.c
> >
> > diff --git a/ui/console-vc-stubs.c b/ui/console-vc-stubs.c
> > new file mode 100644
> > index 0000000000..76ea880d27
> > --- /dev/null
> > +++ b/ui/console-vc-stubs.c
> > @@ -0,0 +1,59 @@
> > +/*
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + * QEMU VC stubs
> > + */
> > +#include "qemu/osdep.h"
> > +
> > +#include "qapi/error.h"
> > +#include "qemu/error-report.h"
> > +#include "qemu/option.h"
> > +#include "chardev/char.h"
> > +#include "ui/console-priv.h"
> > +
> > +void qemu_text_console_select(QemuTextConsole *c)
> > +{
> > +}
> > +
> > +const char * qemu_text_console_get_label(QemuTextConsole *c)
> > +{
> > +    return NULL;
> > +}
> > +
> > +void qemu_text_console_update_cursor(void)
> > +{
> > +}
> > +
> > +void qemu_text_console_handle_keysym(QemuTextConsole *s, int keysym)
> > +{
> > +}
> > +
> > +#define TYPE_CHARDEV_VC "chardev-vc"
> > +
> > +static void vc_chr_parse(QemuOpts *opts, ChardevBackend *backend, Erro=
r **errp)
> > +{
> > +    const char *id =3D qemu_opts_id(opts);
> > +
> > +    warn_report("%s: this is a dummy VC driver. "
> > +                "Use '-nographic' or a different chardev.", id);
> > +}
>
> Why should this be an error_setg() call given we have a errp
> parameter, so make this unsupportable config into an error ?
> Ignoring invalid user configs is not desirable in general.

This was to keep starting as default, regardless of pixman support.

Since, by default, QEMU will create the following VCs (vl.c):

            add_device_config(DEV_SERIAL, "vc:80Cx24C");
            add_device_config(DEV_PARALLEL, "vc:80Cx24C");
            monitor_parse("vc:80Cx24C", "readline", false);

With SDL or VNC, this will associate the QemuTextConsole(s), which is
disabled without pixman. Maybe we shouldn't create those VC by default
when the backend doesn't support it (but to null instead).

Yes, if the user supplied -chardev vc manually, we should error out
instead. I'll try to update the patch.



(btw, I agree with you it would have been nice to make VC an abstract
base chardev, and only allow final types)

>
> > +
> > +static void char_vc_class_init(ObjectClass *oc, void *data)
> > +{
> > +    ChardevClass *cc =3D CHARDEV_CLASS(oc);
> > +
> > +    cc->parse =3D vc_chr_parse;
> > +}
> > +
> > +static const TypeInfo char_vc_type_info =3D {
> > +    .name =3D TYPE_CHARDEV_VC,
> > +    .parent =3D TYPE_CHARDEV,
> > +    .class_init =3D char_vc_class_init,
> > +};
> > +
> > +void qemu_console_early_init(void)
> > +{
> > +    /* set the default vc driver */
> > +    if (!object_class_by_name(TYPE_CHARDEV_VC)) {
> > +        type_register(&char_vc_type_info);
> > +    }
> > +}
> > diff --git a/ui/meson.build b/ui/meson.build
> > index 0a1e8272a3..3085e10a72 100644
> > --- a/ui/meson.build
> > +++ b/ui/meson.build
> > @@ -6,7 +6,6 @@ system_ss.add(png)
> >  system_ss.add(files(
> >    'clipboard.c',
> >    'console.c',
> > -  'console-vc.c',
> >    'cursor.c',
> >    'input-keymap.c',
> >    'input-legacy.c',
> > @@ -19,6 +18,7 @@ system_ss.add(files(
> >    'ui-qmp-cmds.c',
> >    'util.c',
> >  ))
> > +system_ss.add(when: pixman, if_true: files('console-vc.c'), if_false: =
files('console-vc-stubs.c'))
> >  if dbus_display
> >    system_ss.add(files('dbus-module.c'))
> >  endif
> > --
> > 2.41.0
> >
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>
>


--=20
Marc-Andr=C3=A9 Lureau

