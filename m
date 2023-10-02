Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB827B520A
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 14:01:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnHcR-0006oe-BQ; Mon, 02 Oct 2023 08:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qnHcH-0006mR-MW
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 08:01:41 -0400
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qnHcG-0003V3-4E
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 08:01:37 -0400
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-4180f5c51f8so16461621cf.1
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 05:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696248094; x=1696852894; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MDtsErlso7Nun7z/muIK/tlJ7Q3ciucTR0ccNpJrEhM=;
 b=bv9gfUMsQa6oZsBQaBAWE9QwyFv7BmPr3M4TZfSQ/0saiPrVIpA+vRLRAuCxUUTc0s
 dx0fHowaVBb1mAsk8X2UP1b/LOF3y9CjOyjaXGWHERZa0Qcb5bOUc5wQS0zZS6H5nkt/
 VhqnMgB7C8NMaz2gubjBxSICh9elpmU6xeQBqXVGVu4GLROE52vtkYn+XUPRwbn7Ppxv
 RCT9maFNRuXBacMTVb7jfX5Z0qVKHeBF9rGzaYUSbJpAi1hYdQlpMKUIPkgx+ASLzJJT
 MB8u7YEPudAoxMc7ypYZ5aHc45nYO2TGGfAxheRQzu6j4S50wcmN7ZiXt7AzF2KNMyA6
 wxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696248094; x=1696852894;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MDtsErlso7Nun7z/muIK/tlJ7Q3ciucTR0ccNpJrEhM=;
 b=SuRCjTGffFG0KEg9H/gv8anvElNfHpZSb9FeM1299EgwQ+U5HRs1KN0XLPfXWXK8Mb
 tzEpWY2xVstooDiinnPLcBvjucTgGZ/ugxih8kegXMoq70XQfEVN8bBtD//FqnjZGkgM
 ZnkhYHI5urLYx21+Mm3e62n5S0+/HVWbl/SELtTThc0r3hCF8dey3h1uQI6J6VMZ7R4+
 NlEi64H/BY3Ask41+N9c0wkqqoYJyPoQvbL813IQmkH88SuRvBTiYoduMLqDYpSNnbky
 R96/B9Uo8YcxjbRUYRtLEUz7+Tq75FRu4yXNNy0ak/PGehwE5fNSxG4bPiRxSN7Oz4YW
 QvGw==
X-Gm-Message-State: AOJu0YwYpZW1Fi4Ub/QKtZ3thLwtdiT5WCRCaTKbQ0Ktt5KhjRwXtK5A
 GQmdQwBArHwitdfOH7BQVgbbqZuj8kTycNBPMCgwvEe+F9E=
X-Google-Smtp-Source: AGHT+IGfYqHtYyu6Vj8L0FMICmBya3tMRVtOkYVyxAzOuPbzLsk/aGYAiQSqOnFNlJzfIabKgziV+DGnYOQBPJa2Mt8=
X-Received: by 2002:ac8:5c88:0:b0:410:a895:21fd with SMTP id
 r8-20020ac85c88000000b00410a89521fdmr11741719qta.23.1696248093383; Mon, 02
 Oct 2023 05:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <20231002111154.1002655-1-marcandre.lureau@redhat.com>
 <20231002111154.1002655-4-marcandre.lureau@redhat.com>
In-Reply-To: <20231002111154.1002655-4-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 2 Oct 2023 16:01:22 +0400
Message-ID: <CAJ+F1CKzPOAPGc+cp=ytqARUWPq2bhi3vWE_b3MiZXebVTwJxg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] ramfb: implement migration support
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, lersek@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x830.google.com
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

On Mon, Oct 2, 2023 at 3:12=E2=80=AFPM <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Implementing RAMFB migration is quite straightforward. One caveat is to
> treat the whole RAMFBCfg as a blob, since that's what is exposed to the
> guest directly. This avoid having to fiddle with endianness issues if we
> were to migrate fields individually as integers.
>
> The following patches turns the migration only on machine >=3D 8.2.
>
> Fixes:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1859424
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/display/ramfb.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
> index 79b9754a58..4aaaa7d653 100644
> --- a/hw/display/ramfb.c
> +++ b/hw/display/ramfb.c
> @@ -12,6 +12,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "migration/vmstate.h"
>  #include "qapi/error.h"
>  #include "hw/loader.h"
>  #include "hw/display/ramfb.h"
> @@ -28,6 +29,8 @@ struct QEMU_PACKED RAMFBCfg {
>      uint32_t stride;
>  };
>
> +typedef struct RAMFBCfg RAMFBCfg;
> +
>  struct RAMFBState {
>      DisplaySurface *ds;
>      uint32_t width, height;
> @@ -115,6 +118,23 @@ void ramfb_display_update(QemuConsole *con, RAMFBSta=
te *s)
>      dpy_gfx_update_full(con);
>  }
>
> +static int ramfb_post_load(void *opaque, int version_id)
> +{
> +    ramfb_fw_cfg_write(opaque, 0, 0);
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_ramfb =3D {
> +    .name =3D "ramfb",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .post_load =3D ramfb_post_load,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_BUFFER_UNSAFE(cfg, RAMFBState, 0, sizeof(RAMFBCfg)),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  RAMFBState *ramfb_setup(Error **errp)
>  {
>      FWCfgState *fw_cfg =3D fw_cfg_find();
> @@ -127,6 +147,7 @@ RAMFBState *ramfb_setup(Error **errp)
>
>      s =3D g_new0(RAMFBState, 1);
>
> +    vmstate_register(NULL, 0, &vmstate_ramfb, s);

wip:
I am going to make it attached to the actual device.




--=20
Marc-Andr=C3=A9 Lureau

