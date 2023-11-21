Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9817F2B20
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 11:59:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5OSx-0008BI-Ae; Tue, 21 Nov 2023 05:58:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r5OSu-0008B2-Ur; Tue, 21 Nov 2023 05:58:48 -0500
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r5OSs-00070a-Lq; Tue, 21 Nov 2023 05:58:48 -0500
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-41cc75c55f0so54274891cf.1; 
 Tue, 21 Nov 2023 02:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700564325; x=1701169125; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PEaONqdOt2Eyq+HE+uFwNnlWxug0GrbxQFhqUJNirOQ=;
 b=RV9GrDafW/ZWwNrMIeWbL1v5esNQ8h79eh7YG16PafXm6YfOhJyLgfYRukHh1OQrhO
 yhxBaQ7LuP4LsCqS7l+cIMfYKZDENcv52nidg5P6JFczxARhqRk4LGcySO10XIxy37es
 AHgS72wVIygDmShMyea0Kv8G0+PNfsXmkbS4eshqxKgFyHh0TKgiBNlUE86bZO7tWPD4
 mEo42LjO16Df4CT3H2KpZ7KtxKNboiNcbTHwB5M1dmJpJdVEMwtAzSnBu1yyiv8U4+/p
 eQuDiO5lRRl5BnVFVG0mo7Rs+z36lBWqHDHEeFX+dIISRqmYBBR4fPPvCcOE39s8pElj
 HCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700564325; x=1701169125;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PEaONqdOt2Eyq+HE+uFwNnlWxug0GrbxQFhqUJNirOQ=;
 b=sTgK4h3VPK4e0dalWcaNSXxHBouo6q40XxP3QrCh/PMaCYx6Cu7YG7s8Mcykpy6h/v
 5xngVs2jeKnfu92tpneTKjOkujuNhvbE6nVXSKZVCMsFKkA4sNKORZWpcUXBtF/tF2Bn
 BNupLOel04cgHnh8hAHbDvoB9Tqe+vSRmHZds1XmQEroBKxLIvsg68m1XvwUMvoKcMPj
 nFKcPSRnt+cN9xbmCv5NiQrtlku17F8bwOJja9ox3IezziwTRSXvJMGaNTy+VFbGYVCh
 TsBFzWntcknxzoXFhDoK02r9DM/NL5GqvEOotCMpEWJ35jyGwiYWBa72XmjC5AlEfdot
 AkRg==
X-Gm-Message-State: AOJu0YyMAguWQ61jOkmQXSFR77LwIOD72K69at6T8n531DBeJceEcEm8
 hrlluojdrU+68FOWvdNMlHywpg4q78rFkK6cEoA=
X-Google-Smtp-Source: AGHT+IHBbREzLOIE6nFdzvpoaPkUDaqOq3VkvAP3+FMAblmioHciJ9MM77weoABuaqSRzDWhDYmGJ0HvV+WwDJlHN7A=
X-Received: by 2002:ac8:4655:0:b0:423:7637:149c with SMTP id
 f21-20020ac84655000000b004237637149cmr92946qto.4.1700564325006; Tue, 21 Nov
 2023 02:58:45 -0800 (PST)
MIME-Version: 1.0
References: <20231115172723.1161679-1-dwmw2@infradead.org>
 <20231115172723.1161679-3-dwmw2@infradead.org>
 <CAJ+F1C+3UQoEEvFgg8ENjR0xv-LTiPckx4XkCjVqOe2Jnx1EeA@mail.gmail.com>
In-Reply-To: <CAJ+F1C+3UQoEEvFgg8ENjR0xv-LTiPckx4XkCjVqOe2Jnx1EeA@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 21 Nov 2023 14:58:33 +0400
Message-ID: <CAJ+F1CLA-gxmwuMqzjF-dhVqoTqpx1dsC5zNtoh4geLUzpbbVg@mail.gmail.com>
Subject: Re: [PATCH 2/3] vl: disable default serial when xen-console is enabled
To: David Woodhouse <dwmw2@infradead.org>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org,
 qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82d.google.com
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

On Tue, Nov 21, 2023 at 2:57=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Wed, Nov 15, 2023 at 9:28=E2=80=AFPM David Woodhouse <dwmw2@infradead.=
org> wrote:
> >
> > From: David Woodhouse <dwmw@amazon.co.uk>
> >
> > If a Xen console is configured on the command line, do not add a defaul=
t
> > serial port.
> >
> > Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> > ---
> >  system/vl.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/system/vl.c b/system/vl.c
> > index 5af7ced2a1..8109231834 100644
> > --- a/system/vl.c
> > +++ b/system/vl.c
> > @@ -198,6 +198,7 @@ static const struct {
> >      const char *driver;
> >      int *flag;
> >  } default_list[] =3D {
> > +    { .driver =3D "xen-console",          .flag =3D &default_serial   =
 },
> >      { .driver =3D "isa-serial",           .flag =3D &default_serial   =
 },
> >      { .driver =3D "isa-parallel",         .flag =3D &default_parallel =
 },
> >      { .driver =3D "isa-fdc",              .flag =3D &default_floppy   =
 },
>
> Consistent with the rest of the lines (no conditional compilation nor
> driver #define..)
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> btw, while quickly testing this (do we have any test for xen-console?):
>
> $ qemu --accel kvm,xen-version=3D0x40011,kernel-irqchip=3Dsplit -device
> xen-console,chardev=3Dfoo -chardev stdio,id=3Dfoo
> (and close gtk window)
>
> Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
> 0x0000555555c11695 in qemu_free_net_client (nc=3D0x0) at ../net/net.c:387
> 387        if (nc->incoming_queue) {
> (gdb) bt
> #0  0x0000555555c11695 in qemu_free_net_client (nc=3D0x0) at ../net/net.c=
:387
> #1  0x0000555555c11a14 in qemu_del_nic (nic=3D0x555558b6f930) at ../net/n=
et.c:459
> #2  0x00005555559e398b in xen_netdev_unrealize (xendev=3D0x555558b6b510)
> at ../hw/net/xen_nic.c:550
> #3  0x0000555555b6e22f in xen_device_unrealize (dev=3D0x555558b6b510) at
> ../hw/xen/xen-bus.c:973
> #4  0x0000555555b6e351 in xen_device_exit (n=3D0x555558b6b5e0, data=3D0x0=
)
> at ../hw/xen/xen-bus.c:1002
> #5  0x00005555560bc3fc in notifier_list_notify (list=3D0x5555570b5fc0
> <exit_notifiers>, data=3D0x0) at ../util/notify.c:39
> #6  0x0000555555ba1d49 in qemu_run_exit_notifiers () at ../system/runstat=
e.c:800

Ok, I found related "[PATCH 1/3] net: do not delete nics in net_cleanup()"



--=20
Marc-Andr=C3=A9 Lureau

