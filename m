Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C22D7B64FB
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 11:08:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnbNO-0004zE-Tz; Tue, 03 Oct 2023 05:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qnbNL-0004yr-Qy
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 05:07:31 -0400
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qnbNJ-00088h-TW
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 05:07:31 -0400
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-419628fb297so4828811cf.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 02:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696324048; x=1696928848; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qrql+GDN6oLAt86RvLYDCjMx+gn2d06QJ0eqKxLFzXk=;
 b=enV0D0cuemDz3zL4/a45VnMdGEp1YWdPfcgpT9Oq7Ml4ow8VLXTlX/KlFihUyGS+Qy
 Ou+PRwLu/osjR16LQwG1FhEm6ayu/iDm8iylbwm5ZP5vebq9Z4XFVaJC6jOnGU1VXa9d
 Zshav2HhLuLrX3xgnH7hSrHd7IgOb5HAKwkLLLpD/fi878I31OQPOBjtaB72suSiBO5U
 rcg+8tPxqda/BntQQCQFihjgNAgjKOX9TNoZgUxPkPmuDlAnno3Fj+Egc3OAsCVnSifU
 BYRHbiX338CoYvGTtL4FGtTa9KXWZ6l3cmSCJa/YMvkP2M7xxxqg24ty/fiuPR9HtuIM
 dXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696324048; x=1696928848;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qrql+GDN6oLAt86RvLYDCjMx+gn2d06QJ0eqKxLFzXk=;
 b=uRSBfVPHihTdyECHr75spr/y2JtqCR2yp7YmpPdjF2s6Donntda9zot8dAczCUJkmc
 nx//9qnQyF1h6qBI9JEHsBYCw04z8q86PL8cJS13Oxz0wL3xjKQSykKtJwsOGXj9Ge39
 BeH55en3W/q8U2y+lsdoSGUelfPJZZv6hygtl9ZUusefx4brsa0EmvxeFQN72FVGUHuN
 LN1htGKzUG7qoy9CgUufbcHb0i01CgqUyqui+otw0PZTIrMvl7OTdbn0hONlqaGrLCe9
 qqq0YFnj/QeLlirRVEKPwdFYy9ILqEQz1d7CEFJiMgiWVsZ11hhXxUw5XEbgpN5MY3LK
 PHvg==
X-Gm-Message-State: AOJu0Yx8KWB3xfslwiumfQxWtwurqnW+/GsfPWstEusXJvQfsvG41rKu
 0lCGVIfdJeLbSneFPW3z/uZsb3xk1/FLcydadQU=
X-Google-Smtp-Source: AGHT+IFz619RA3kxvDpOwpc/748OsNkZEf9fA/jiEe+Ew2oAS0Z6eY47ghAuj60xq1omIhkeTmkuSwDSTzJBoLZQpO4=
X-Received: by 2002:a05:622a:20f:b0:417:d6c7:ea69 with SMTP id
 b15-20020a05622a020f00b00417d6c7ea69mr16296543qtx.7.1696324048611; Tue, 03
 Oct 2023 02:07:28 -0700 (PDT)
MIME-Version: 1.0
References: <20231002111154.1002655-1-marcandre.lureau@redhat.com>
 <20231002111154.1002655-6-marcandre.lureau@redhat.com>
 <33b5425f-8e8c-5bde-99ed-41f28097e4e4@redhat.com>
In-Reply-To: <33b5425f-8e8c-5bde-99ed-41f28097e4e4@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 3 Oct 2023 13:07:17 +0400
Message-ID: <CAJ+F1CLSRP=7veJV4iZxXoM+=2hNer8obe_8R9hq1=BHmPyGYw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] hw: turn off ramfb migration for machines <= 8.1
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x832.google.com
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

On Mon, Oct 2, 2023 at 6:42=E2=80=AFPM Laszlo Ersek <lersek@redhat.com> wro=
te:
>
> On 10/2/23 13:11, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > For compatibility reasons.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  hw/core/machine.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index 68cb556197..2fa7647422 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -30,7 +30,10 @@
> >  #include "hw/virtio/virtio-pci.h"
> >  #include "hw/virtio/virtio-net.h"
> >
> > -GlobalProperty hw_compat_8_1[] =3D {};
> > +GlobalProperty hw_compat_8_1[] =3D {
> > +    { "ramfb", "migrate", "off" },
> > +    { "vfio-pci-nohotplug", "ramfb-migrate", "off" }
> > +};
> >  const size_t hw_compat_8_1_len =3D G_N_ELEMENTS(hw_compat_8_1);
> >
> >  GlobalProperty hw_compat_8_0[] =3D {
>
> In the other discussion, you mentioned the concrete reason for this -- I
> think if we don't do this, then the ramfb vmstate blocks backward
> migration? Can you document the reason here explicitly (commit message,
> I mean, doesn't have to be a code comment)?

By using device section/subsection in v3, I changed a little bit the
reasons for the properties. Now it falls under the common issue
documented in migration.rst "Changing migration data structure".

From v3, let me know if you still think we should document that better
in the commit message.

thanks

--=20
Marc-Andr=C3=A9 Lureau

