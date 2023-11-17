Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 410887EF031
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 11:23:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3vzD-0001WC-Dx; Fri, 17 Nov 2023 05:22:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r3vym-00018q-GG
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 05:21:40 -0500
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r3vyk-000655-F6
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 05:21:40 -0500
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-41e3e77e675so10174741cf.1
 for <qemu-devel@nongnu.org>; Fri, 17 Nov 2023 02:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700216497; x=1700821297; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SShuaqOYC/5DjCvbDYpSYYu0tgc9g7OWXuH65nmeWIY=;
 b=N/bJjtXjRj35Ikc2r7fkpsY5C1jJmmfYm9V/CPev1NB88ZEGHXeYN25dhhmr7WI1NW
 PYGrWEGE239OIAgmdFZ+ek3yyIittovI01AOeRapjstRyefIq8mWLnSrFx5Pv7P28b2f
 2A72pO76f96knAYmOh90o/0RUQstPxaNlohB+EExuPjd5JJmgGpOO7bA/3FXgE6yAkIf
 a/+vk3IcikE3BOJyq/u4cWEmfhnKQ4gpzN4ynlV2BcBxMx22WhF+oSZLUHWqsXV+Ugff
 B39Dos2XG/MJ6qG5qtDD1BDF8iNrxN8vPOXKG9D7vuKY9GiB4sHC2Gx61wk1u2vFBmS1
 oOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700216497; x=1700821297;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SShuaqOYC/5DjCvbDYpSYYu0tgc9g7OWXuH65nmeWIY=;
 b=ATakaR6bPBPPGl34JcjYkVUgPHRCcLxaxJZsLb9YRKGvjEx1swrub62V2r5mZByPpD
 +G8W3lpKgWcScZ+v/CgVbq0dTTGq7HGSGEPNFJ+F16riuvpUSVhNJ2zPo2UeT/dwtXRf
 EZpqVlGhcbIUO06wwNQZ54Qsy/6CL3BwDKsaiv0qfF9hBjxwz1Xk68CT5fNIF0iBzzIw
 pV7LPamGqW/QRdQr9PyAEYP1r4+z0MsWMpHD496/W95kmzimssa0seIgdPppybUC152f
 YSsTkmRfaP7S5j5vaZVndVSS+fLlyp/Ug/Heq6XcRR0iXLCUjVAKOh0qm+6Amv/dyYKb
 lfVw==
X-Gm-Message-State: AOJu0YyvYXZ5CN5sxALfN89/ObhOgu1p+9engf/PBk4Ew7dMTBx+xEeL
 KmsqBOB4kxt8o7TRx6K0ToMvFojAEHl5XdxW7Fg=
X-Google-Smtp-Source: AGHT+IFhOBNVQMGqwIiQo4lWcSbXzxUK9tWHy6KvMu1xP47tUPRpymZHhcgpyAH/jwGK9XefhcQoWOhP5euCE/9Nmh8=
X-Received: by 2002:a05:622a:174a:b0:41e:173e:82b7 with SMTP id
 l10-20020a05622a174a00b0041e173e82b7mr11288936qtk.66.1700216496667; Fri, 17
 Nov 2023 02:21:36 -0800 (PST)
MIME-Version: 1.0
References: <20231116182228.3062796-1-peter.maydell@linaro.org>
In-Reply-To: <20231116182228.3062796-1-peter.maydell@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 17 Nov 2023 14:21:25 +0400
Message-ID: <CAJ+F1C+o-jAZu-tmJvUvF+E2HtXBARTAGAYNsCicnc6zVqhYnA@mail.gmail.com>
Subject: Re: [PATCH for-8.2] Revert "ui/console: allow to override the default
 VC"
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82c.google.com
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

On Thu, Nov 16, 2023 at 10:25=E2=80=AFPM Peter Maydell <peter.maydell@linar=
o.org> wrote:
>
> This reverts commit 1bec1cc0da497e55c16e2a7b50f94cdb2a02197f.  This
> commit changed the behaviour of the "-display none" option, so that
> it now creates a QEMU monitor on the terminal.  "-display none"
> should not be tangled up with whether we create a monitor or a serial
> terminal; it should purely and only disable the graphical window.
> Changing its behaviour like this breaks command lines which, for
> example, use semihosting for their output and don't want a graphical
> window, as they now get a monitor they never asked for.
>
> It also breaks the command line we document for Xen in
> docs/system/i386/xen.html:
>
>  $ ./qemu-system-x86_64 --accel kvm,xen-version=3D0x40011,kernel-irqchip=
=3Dsplit \
>     -display none -chardev stdio,mux=3Don,id=3Dchar0,signal=3Doff -mon ch=
ar0 \
>     -device xen-console,chardev=3Dchar0  -drive file=3D${GUEST_IMAGE},if=
=3Dxen
>
> qemu-system-x86_64: cannot use stdio by multiple character devices
> qemu-system-x86_64: could not connect serial device to character backend =
'stdio'
>
> Revert the commit to restore the previous handling of "-display
> none".
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1974
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

By simply reverting, we break qemu with --disable-pixman:
qemu-system-x86_64: 'vc' is not a valid char driver name

The change of behaviour was a consequence of Paolo suggestion from v2:
https://patchew.org/QEMU/20230918135206.2739222-1-marcandre.lureau@redhat.c=
om/20230918135206.2739222-6-marcandre.lureau@redhat.com/#4b890258-3426-0e0f=
-dd65-6114b9bee5e3@redhat.com

Let's get back to the current behaviour and not add muxed console in
any case (disable pixman or not). I'll try to make a patch asap.

> ---
>  include/ui/console.h |  2 --
>  system/vl.c          | 27 ++++++++++-----------------
>  ui/console.c         | 17 -----------------
>  3 files changed, 10 insertions(+), 36 deletions(-)
>
> diff --git a/include/ui/console.h b/include/ui/console.h
> index a4a49ffc640..acb61a7f152 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -462,14 +462,12 @@ struct QemuDisplay {
>      DisplayType type;
>      void (*early_init)(DisplayOptions *opts);
>      void (*init)(DisplayState *ds, DisplayOptions *opts);
> -    const char *vc;
>  };
>
>  void qemu_display_register(QemuDisplay *ui);
>  bool qemu_display_find_default(DisplayOptions *opts);
>  void qemu_display_early_init(DisplayOptions *opts);
>  void qemu_display_init(DisplayState *ds, DisplayOptions *opts);
> -const char *qemu_display_get_vc(DisplayOptions *opts);
>  void qemu_display_help(void);
>
>  /* vnc.c */
> diff --git a/system/vl.c b/system/vl.c
> index 5af7ced2a16..3d64a90f253 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -1372,7 +1372,6 @@ static void qemu_setup_display(void)
>  static void qemu_create_default_devices(void)
>  {
>      MachineClass *machine_class =3D MACHINE_GET_CLASS(current_machine);
> -    const char *vc =3D qemu_display_get_vc(&dpy);
>
>      if (is_daemonized()) {
>          /* According to documentation and historically, -nographic redir=
ects
> @@ -1391,30 +1390,24 @@ static void qemu_create_default_devices(void)
>          }
>      }
>
> -    if (nographic || (!vc && !is_daemonized() && isatty(STDOUT_FILENO)))=
 {
> -        if (default_parallel) {
> +    if (nographic) {
> +        if (default_parallel)
>              add_device_config(DEV_PARALLEL, "null");
> -        }
>          if (default_serial && default_monitor) {
>              add_device_config(DEV_SERIAL, "mon:stdio");
>          } else {
> -            if (default_serial) {
> +            if (default_serial)
>                  add_device_config(DEV_SERIAL, "stdio");
> -            }
> -            if (default_monitor) {
> +            if (default_monitor)
>                  monitor_parse("stdio", "readline", false);
> -            }
>          }
>      } else {
> -        if (default_serial) {
> -            add_device_config(DEV_SERIAL, vc ?: "null");
> -        }
> -        if (default_parallel) {
> -            add_device_config(DEV_PARALLEL, vc ?: "null");
> -        }
> -        if (default_monitor && vc) {
> -            monitor_parse(vc, "readline", false);
> -        }
> +        if (default_serial)
> +            add_device_config(DEV_SERIAL, "vc:80Cx24C");
> +        if (default_parallel)
> +            add_device_config(DEV_PARALLEL, "vc:80Cx24C");
> +        if (default_monitor)
> +            monitor_parse("vc:80Cx24C", "readline", false);
>      }
>
>      if (default_net) {
> diff --git a/ui/console.c b/ui/console.c
> index 8e688d35695..676d0cbaba2 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -1677,23 +1677,6 @@ void qemu_display_init(DisplayState *ds, DisplayOp=
tions *opts)
>      dpys[opts->type]->init(ds, opts);
>  }
>
> -const char *qemu_display_get_vc(DisplayOptions *opts)
> -{
> -    assert(opts->type < DISPLAY_TYPE__MAX);
> -    if (opts->type =3D=3D DISPLAY_TYPE_NONE) {
> -        return NULL;
> -    }
> -    assert(dpys[opts->type] !=3D NULL);
> -    if (dpys[opts->type]->vc) {
> -        return dpys[opts->type]->vc;
> -    } else {
> -#ifdef CONFIG_PIXMAN
> -        return "vc:80Cx24C";
> -#endif
> -    }
> -    return NULL;
> -}
> -
>  void qemu_display_help(void)
>  {
>      int idx;
> --
> 2.34.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

