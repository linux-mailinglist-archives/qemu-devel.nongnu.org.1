Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E6D7B3126
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 13:19:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmBUx-0007Sn-32; Fri, 29 Sep 2023 07:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qmBUt-0007SL-A4; Fri, 29 Sep 2023 07:17:27 -0400
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qmBUp-00073J-K0; Fri, 29 Sep 2023 07:17:26 -0400
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-4180d962b68so71378871cf.1; 
 Fri, 29 Sep 2023 04:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695986240; x=1696591040; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xb6jUNkqwweHyA/sE8pSXkT8Y2pnKhjC9oY9Jf2LBS4=;
 b=HUN6rm475iLOdq2wEQAPK8WJVgRKvH/f5kE62Q9sxXuZNcaFhNEVD/KrfOAFr3we8o
 lOZwNsBrN5etsWz7/d8FUohDZxAzYxw6Vy0tfUzWnRvSbD3+m78ZXWhrVf0gT7p8Rp1p
 G5mbi1LT5XHL+5LSGZQraw9z68VhxAEd6tK92r0vxVfp8gSBwJ4J5HvuOTPsZwPI1yax
 iyEnQYy4YYz2+13SCbAEC5zIJOMEimAJM0okXj4wpz+kPIEci6ZXMb3K8zktU0+kX6jF
 ibB4YcYuJBrZM9GTSS5bVvs/cdTxUTIHyKnc2YYWA/6ZpQybz6SVWLTdk9BeeJreoSTc
 q7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695986240; x=1696591040;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xb6jUNkqwweHyA/sE8pSXkT8Y2pnKhjC9oY9Jf2LBS4=;
 b=H7fzInUNTN+lPJuT4DnYkrl4EgJoi0UbR72u0m651lhZ7sJBR9RcNBLTVbw0PM3+gu
 91uNyyBiXGDZdrDZ2fw+azOIcfAZwWuj3eAvkOu3CEc1gydIcN31U+YM5y4MNxMiVPbV
 DuQ0nndXl6hIZEkdrTxpK7MUzMznagRy6O4b7gWrbWkYY2zHYFA3WZnfiAwGNngq+eQL
 7X8Z/7uMyiAihHrGwcautLreNFCnckX/RompyMI7iSoB3GSva4nhHclRHFDiWDXYRUon
 1B81M9tnvwrh5xCvXiSiLou15rmQMCWNJ1jCI38Lxu7UKNqFD52EB/XU2NdFaNrgSVHy
 EdzQ==
X-Gm-Message-State: AOJu0Yw78p8ceewMlkhubTA8E9HGhMavln4ixSBr0jzzKHjz/ZmKfIeM
 xLPt6CNahrUD9tG2hSQ00ufx+qbcYrasojes8j8=
X-Google-Smtp-Source: AGHT+IHKOkKmCGlyaJx2q+/ZawkNE0M94eZEOx3u6kyeDacDtfOy/tRGE8ggItT+qg2DDv/JQNWDc1QZetGFePVSokw=
X-Received: by 2002:ac8:5a8c:0:b0:40a:fc6a:e87b with SMTP id
 c12-20020ac85a8c000000b0040afc6ae87bmr4694152qtc.22.1695986240534; Fri, 29
 Sep 2023 04:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230919131955.27223-1-lersek@redhat.com>
 <7ee37181-526e-2b6a-6b42-09340a9e70a9@redhat.com>
In-Reply-To: <7ee37181-526e-2b6a-6b42-09340a9e70a9@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 29 Sep 2023 15:17:09 +0400
Message-ID: <CAJ+F1CK0FaMfm-ZUz7KB0erFRLBWTa7yHMxhiX0+J0ZxNp34bw@mail.gmail.com>
Subject: Re: [PATCH] hw/display/ramfb: plug slight guest-triggerable leak on
 mode setting
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x829.google.com
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

On Wed, Sep 27, 2023 at 7:46=E2=80=AFPM Laszlo Ersek <lersek@redhat.com> wr=
ote:
>
> On 9/19/23 15:19, Laszlo Ersek wrote:
> > The fw_cfg DMA write callback in ramfb prepares a new display surface i=
n
> > QEMU; this new surface is put to use ("swapped in") upon the next displ=
ay
> > update. At that time, the old surface (if any) is released.
> >
> > If the guest triggers the fw_cfg DMA write callback at least twice betw=
een
> > two adjacent display updates, then the second callback (and further suc=
h
> > callbacks) will leak the previously prepared (but not yet swapped in)
> > display surface.
> >
> > The issue can be shown by:
> >
> > (1) starting QEMU with "-trace displaysurface_free", and
> >
> > (2) running the following program in the guest UEFI shell:
> >
> >> #include <Library/ShellCEntryLib.h>           // ShellAppMain()
> >> #include <Library/UefiBootServicesTableLib.h> // gBS
> >> #include <Protocol/GraphicsOutput.h>          // EFI_GRAPHICS_OUTPUT_P=
ROTOCOL
> >>
> >> INTN
> >> EFIAPI
> >> ShellAppMain (
> >>   IN UINTN   Argc,
> >>   IN CHAR16  **Argv
> >>   )
> >> {
> >>   EFI_STATUS                    Status;
> >>   VOID                          *Interface;
> >>   EFI_GRAPHICS_OUTPUT_PROTOCOL  *Gop;
> >>   UINT32                        Mode;
> >>
> >>   Status =3D gBS->LocateProtocol (
> >>                   &gEfiGraphicsOutputProtocolGuid,
> >>                   NULL,
> >>                   &Interface
> >>                   );
> >>   if (EFI_ERROR (Status)) {
> >>     return 1;
> >>   }
> >>
> >>   Gop =3D Interface;
> >>
> >>   Mode =3D 1;
> >>   for ( ; ;) {
> >>     Status =3D Gop->SetMode (Gop, Mode);
> >>     if (EFI_ERROR (Status)) {
> >>       break;
> >>     }
> >>
> >>     Mode =3D 1 - Mode;
> >>   }
> >>
> >>   return 1;
> >> }
> >
> > The symptom is then that:
> >
> > - only one trace message appears periodically,
> >
> > - the time between adjacent messages keeps increasing -- implying that
> >   some list structure (containing the leaked resources) keeps growing,
> >
> > - the "surface" pointer is ever different.
> >
> >> 18566@1695127471.449586:displaysurface_free surface=3D0x7f2fcc09a7c0
> >> 18566@1695127471.529559:displaysurface_free surface=3D0x7f2fcc9dac10
> >> 18566@1695127471.659812:displaysurface_free surface=3D0x7f2fcc441dd0
> >> 18566@1695127471.839669:displaysurface_free surface=3D0x7f2fcc0363d0
> >> 18566@1695127472.069674:displaysurface_free surface=3D0x7f2fcc413a80
> >> 18566@1695127472.349580:displaysurface_free surface=3D0x7f2fcc09cd00
> >> 18566@1695127472.679783:displaysurface_free surface=3D0x7f2fcc1395f0
> >> 18566@1695127473.059848:displaysurface_free surface=3D0x7f2fcc1cae50
> >> 18566@1695127473.489724:displaysurface_free surface=3D0x7f2fcc42fc50
> >> 18566@1695127473.969791:displaysurface_free surface=3D0x7f2fcc45dcc0
> >> 18566@1695127474.499708:displaysurface_free surface=3D0x7f2fcc70b9d0
> >> 18566@1695127475.079769:displaysurface_free surface=3D0x7f2fcc82acc0
> >> 18566@1695127475.709941:displaysurface_free surface=3D0x7f2fcc369c00
> >> 18566@1695127476.389619:displaysurface_free surface=3D0x7f2fcc32b910
> >> 18566@1695127477.119772:displaysurface_free surface=3D0x7f2fcc0d5a20
> >> 18566@1695127477.899517:displaysurface_free surface=3D0x7f2fcc086c40
> >> 18566@1695127478.729962:displaysurface_free surface=3D0x7f2fccc72020
> >> 18566@1695127479.609839:displaysurface_free surface=3D0x7f2fcc185160
> >> 18566@1695127480.539688:displaysurface_free surface=3D0x7f2fcc23a7e0
> >> 18566@1695127481.519759:displaysurface_free surface=3D0x7f2fcc3ec870
> >> 18566@1695127482.549930:displaysurface_free surface=3D0x7f2fcc634960
> >> 18566@1695127483.629661:displaysurface_free surface=3D0x7f2fcc26b140
> >> 18566@1695127484.759987:displaysurface_free surface=3D0x7f2fcc321700
> >> 18566@1695127485.940289:displaysurface_free surface=3D0x7f2fccaad100
> >
> > We figured this wasn't a CVE-worthy problem, as only small amounts of
> > memory were leaked (the framebuffer itself is mapped from guest RAM, QE=
MU
> > only allocates administrative structures), plus libvirt restricts QEMU
> > memory footprint anyway, thus the guest can only DoS itself.
> >
> > Plug the leak, by releasing the last prepared (not yet swapped in) disp=
lay
> > surface, if any, in the fw_cfg DMA write callback.
> >
> > Regarding the "reproducer", with the fix in place, the log is flooded w=
ith
> > trace messages (one per fw_cfg write), *and* the trace message alternat=
es
> > between just two "surface" pointer values (i.e., nothing is leaked, the
> > allocator flip-flops between two objects in effect).
> >
> > This issue appears to date back to the introducion of ramfb (995b30179b=
dc,
> > "hw/display: add ramfb, a simple boot framebuffer living in guest ram",
> > 2018-06-18).
> >
> > Cc: Gerd Hoffmann <kraxel@redhat.com> (maintainer:ramfb)
> > Cc: qemu-stable@nongnu.org
> > Fixes: 995b30179bdc
> > Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> > ---
> >  hw/display/ramfb.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
> > index 79b9754a5820..c2b002d53480 100644
> > --- a/hw/display/ramfb.c
> > +++ b/hw/display/ramfb.c
> > @@ -97,6 +97,7 @@ static void ramfb_fw_cfg_write(void *dev, off_t offse=
t, size_t len)
> >
> >      s->width =3D width;
> >      s->height =3D height;
> > +    qemu_free_displaysurface(s->ds);
> >      s->ds =3D surface;
> >  }

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Incidentally I found the same issue:
https://patchew.org/QEMU/20230920082634.3349487-1-marcandre.lureau@redhat.c=
om/


fwiw, my migration support patch is still unreviewed:
https://patchew.org/QEMU/20230920082651.3349712-1-marcandre.lureau@redhat.c=
om/

--=20
Marc-Andr=C3=A9 Lureau

