Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF037D7E05
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 10:04:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvvL4-0005bA-VP; Thu, 26 Oct 2023 04:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qvvKm-0005Va-Vc; Thu, 26 Oct 2023 04:03:18 -0400
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qvvKl-0006LW-6R; Thu, 26 Oct 2023 04:03:16 -0400
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-41cd8bd5727so4433031cf.3; 
 Thu, 26 Oct 2023 01:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698307393; x=1698912193; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=khtl84scTpSjIHQq6UYNUcz/DnzrlZyEL1AYEbkgclo=;
 b=EBe40OHF5ozMYCdGYynD340w7ImoAbwGJL2zMt9xroO4+lkCDE5yGEFXSc3wPKCMnI
 lUhE/BtYeui2GwTo5TljuRdaYPo3K90mUt7Gya26iRGVfZsfjuAUVLd7yxU4J/mANpJR
 VetG/y1ms8+lyVASXCvnhZMJ0ENPmoA2uzCy3kRnJqs9kRK+/0xKOL8rZSP9R7WZeDvw
 sceHgdtpqTAdsvbjQyj91iIQyKl1MmPcCkel2qLcDVGYinF9jqjaQFWvmNbAy9GF0Ks3
 21hQcuCv3LTnZuERh1Ff0RkwRoKFyhxhm/bNqvJNG9sMXF3Joh4z+tZ5nRBohIwWTN8N
 bT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698307393; x=1698912193;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=khtl84scTpSjIHQq6UYNUcz/DnzrlZyEL1AYEbkgclo=;
 b=a4DtQjYjimKE2T7NrTp2+DXWPQ8xt5svYfaT0skpZD2g1dUzFs7924A2lZltDdIYu7
 Anod+9hdHu6aGk7RAiaYNpGRSNj/+4lcOsl+4h2ckCXfn7Ge4KlqdYe09sfR9OO9fmkR
 yD8ShOhz+ReZ7VeHzKAPwO1lDN/vggD4nELEoN09SAMlw1ahqLJtCW11i6dRXhCu1I79
 VVlEZR105dPUS4I9GaJMcclxrXJyulLrnBHD6KG9qwLmS032+4+kbOydoNCg6jBvKFel
 cYT6vGTsgsfll6vvAaI8hXjgJbCURh/JuW42YrvHJ+O9LVMdkXxGk9dfZ1bYtzB/bSv6
 h0RQ==
X-Gm-Message-State: AOJu0YzLihh1t1jpZ8T9rAWFRKnhZ9yHqaISAFvKCU4EgItWQGYQObFJ
 DgOSb3IWr8gJlwOCchI1xEXCQWFu7VMIAmaNeJ8=
X-Google-Smtp-Source: AGHT+IEYmQo91OknyW76upmBwMo88HT8UpAa8UpnPtNQhprjZqvE+RnGWmquEJp3GwQ+Vojh/FxVJWq7RZNSqOCFXG4=
X-Received: by 2002:ac8:5886:0:b0:40f:f0e0:a008 with SMTP id
 t6-20020ac85886000000b0040ff0e0a008mr21589887qta.53.1698307393094; Thu, 26
 Oct 2023 01:03:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231025190818.3278423-1-marcandre.lureau@redhat.com>
 <20231025190818.3278423-15-marcandre.lureau@redhat.com>
 <bc6d4505-df80-8179-0201-7eb396a22547@eik.bme.hu>
In-Reply-To: <bc6d4505-df80-8179-0201-7eb396a22547@eik.bme.hu>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 26 Oct 2023 12:03:00 +0400
Message-ID: <CAJ+F1CK+FwTd=A1KncqQuO_gPsf+anwWYProiPchK_t04wpTcA@mail.gmail.com>
Subject: Re: [PATCH v6 14/23] vhost-user-gpu: skip VHOST_USER_GPU_UPDATE when
 !PIXMAN
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
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

On Thu, Oct 26, 2023 at 12:58=E2=80=AFAM BALATON Zoltan <balaton@eik.bme.hu=
> wrote:
>
> On Wed, 25 Oct 2023, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > This simply means that 2d drawing updates won't be handled, but 3d
> > should work.
>
> Does this silently break guest display when !PIXMAN or I don't understand
> what this means (I don't know how this device works). If it causes missin=
g
> display without PIXMAN should this need pixman or print a warning about
> that?

The 2D updates will not be displayed. There will be a warning of
"unhandled message 8" for each update.

3D updates are still handled, so you could skip the boot phase until
the guest 3d driver is loaded, or you could have a vhost-user-gpu
backend that only provides 3D updates (aka dmabuf)

>
> Regards,
> BALATON Zoltan
>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > hw/display/vhost-user-gpu.c | 2 ++
> > 1 file changed, 2 insertions(+)
> >
> > diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
> > index 1150521d9d..709c8a02a1 100644
> > --- a/hw/display/vhost-user-gpu.c
> > +++ b/hw/display/vhost-user-gpu.c
> > @@ -307,6 +307,7 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, Vhos=
tUserGpuMsg *msg)
> >         dpy_gl_update(con, m->x, m->y, m->width, m->height);
> >         break;
> >     }
> > +#ifdef CONFIG_PIXMAN
> >     case VHOST_USER_GPU_UPDATE: {
> >         VhostUserGpuUpdate *m =3D &msg->payload.update;
> >
> > @@ -334,6 +335,7 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, Vhos=
tUserGpuMsg *msg)
> >         }
> >         break;
> >     }
> > +#endif
> >     default:
> >         g_warning("unhandled message %d %d", msg->request, msg->size);
> >     }
> >



--=20
Marc-Andr=C3=A9 Lureau

