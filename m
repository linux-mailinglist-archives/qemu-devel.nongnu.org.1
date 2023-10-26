Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC987D84FA
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 16:43:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw1Y7-0001k4-Gp; Thu, 26 Oct 2023 10:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qw1Y5-0001jj-PU; Thu, 26 Oct 2023 10:41:25 -0400
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qw1Y4-0007UE-0b; Thu, 26 Oct 2023 10:41:25 -0400
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-41e1921da84so6776291cf.1; 
 Thu, 26 Oct 2023 07:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698331282; x=1698936082; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fCSN8nUInCVgzcv47Urswfs8EVHYc4O4rVQBVENV3SI=;
 b=ilyVvAwv8KfPHI/0IzzH6Qh6VfT3JAliPQfGUSxlOMr9gI9EGoPMuyyygA90KAUWGA
 X3bsEqATxF6Le0UwtyhbWPCKDWpanZJEgpkLRBNJB+XElME2gURWPir2koCE+UOHe6tz
 NN1nEkfEO5B69ZaZt3Mva6ttz8qQ3az7R/hzLDwOV1VPEc74YJJNLLCT31dPHvjSQLML
 Gq5PcvG4A8iu2RvpoIOWwBoFU7Q+jmAU6c46bzq8GFQcwiBEwK4DW3v91LVqkdK0ZwwO
 s6QwcjwGeBBdaPPRjy7epM35PbOUGmW6KHQgGZqgf6+D4/QEToWi+JV5IzlxKia42q1j
 qfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698331282; x=1698936082;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fCSN8nUInCVgzcv47Urswfs8EVHYc4O4rVQBVENV3SI=;
 b=hdHwsB+Rodf1kPvdWueGkqV4g40roG/lzWm71rlSseKhCniTH7SlZ6lEGtZuhh4FIJ
 2JxWPqMJqrFw7o6M3P1t8g+PAE2Kw/RIhyaLdjsA60Dc5do/twz1MgbMeOce8orqhmkb
 9pGQU9SvUhvu2jFf1EAKM1dR57CtwPqVpmr4jaMU6AGHddLZUCaZM4fqwm4GL3rw0DM/
 ab9qRFf9Jzz3iMtxdgdBLHzUB/YlOu+T7uMWByAXHQD1Uo/q+Ix1jfFokDKOvJ01iEGc
 +4C8sIlP5l0iRu/glDGLDYj/eyn1kgvQoBDYSKbrcVuAFtXajtwsre1/iN5wcHUtofQx
 CQWg==
X-Gm-Message-State: AOJu0YyOZoesfxKJg4qELhvFtpcmpauxFFPPd98PpjgOQyPciCtW/fS+
 wmVrziJ5w8xBrkYSw0pwPlPv85iuObVsfUZ+zMc=
X-Google-Smtp-Source: AGHT+IFwIslOYRe6DOrwSgI1/nCtwwlF7VZYs9RG49tEl98B9FUiFJXmdB5548JkpbY+eu3vbJM3MLXOdnGGzPJYOq0=
X-Received: by 2002:a05:622a:408:b0:41e:2d40:5e64 with SMTP id
 n8-20020a05622a040800b0041e2d405e64mr8411481qtx.51.1698331282115; Thu, 26 Oct
 2023 07:41:22 -0700 (PDT)
MIME-Version: 1.0
References: <20231025190818.3278423-1-marcandre.lureau@redhat.com>
 <20231025190818.3278423-23-marcandre.lureau@redhat.com>
 <63e8196a-da54-83fa-0eea-ed9a4b669186@eik.bme.hu>
In-Reply-To: <63e8196a-da54-83fa-0eea-ed9a4b669186@eik.bme.hu>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 26 Oct 2023 18:41:10 +0400
Message-ID: <CAJ+F1CJaS_OOJPu+QF8Xv1zdU_1NUY0nZS1J5TFaDZbA64rx=g@mail.gmail.com>
Subject: Re: [PATCH v6 22/23] hw/display: make ATI_VGA depend on PIXMAN
To: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x834.google.com
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

On Thu, Oct 26, 2023 at 1:07=E2=80=AFAM BALATON Zoltan <balaton@eik.bme.hu>=
 wrote:
>
> On Wed, 25 Oct 2023, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Acked-by: BALATON Zoltan <balaton@eik.bme.hu>
> > ---
> > configs/devices/mips64el-softmmu/default.mak | 2 +-
> > hw/display/Kconfig                           | 2 +-
> > hw/display/meson.build                       | 2 +-
> > 3 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/configs/devices/mips64el-softmmu/default.mak b/configs/dev=
ices/mips64el-softmmu/default.mak
> > index d5188f7ea5..8d85607571 100644
> > --- a/configs/devices/mips64el-softmmu/default.mak
> > +++ b/configs/devices/mips64el-softmmu/default.mak
> > @@ -3,7 +3,7 @@
> > include ../mips-softmmu/common.mak
> > CONFIG_FULOONG=3Dy
> > CONFIG_LOONGSON3V=3Dy
> > -CONFIG_ATI_VGA=3Dy
> > +# CONFIG_ATI_VGA=3Dn
>
> I think I've asked this before but forgot the answer... However fuloong2e
> has an on board ati-vga so does this (or should it) disable CONFIG_FULOON=
G
> when !PIXMAN? Or that machine should omit the on board graphics in this
> case?
>

yes, it is not obvious to spot, because it's a run time error (the
"ati-vga" device creation).

I think we should express this like that, but it fails with:
KconfigDataError: cycle found including PCI_BONITO

And I have no idea why. Paolo, any idea?

diff --git a/configs/devices/mips64el-softmmu/default.mak
b/configs/devices/mips64el-softmmu/default.mak
index 8d85607571..4d80d60511 100644
--- a/configs/devices/mips64el-softmmu/default.mak
+++ b/configs/devices/mips64el-softmmu/default.mak
@@ -1,9 +1,8 @@
 # Default configuration for mips64el-softmmu

 include ../mips-softmmu/common.mak
-CONFIG_FULOONG=3Dy
+#CONFIG_FULOONG=3Dy
 CONFIG_LOONGSON3V=3Dy
-# CONFIG_ATI_VGA=3Dn
 CONFIG_RTL8139_PCI=3Dy
 CONFIG_JAZZ=3Dy
 CONFIG_VT82C686=3Dy
diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index ac1eb06a51..48bb15fdd3 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -32,7 +32,9 @@ config JAZZ

 config FULOONG
     bool
+    default y if MIPS
     select PCI_BONITO
+    depends on ATI_VGA



> Regards,
> BALATON Zoltan
>
> > CONFIG_RTL8139_PCI=3Dy
> > CONFIG_JAZZ=3Dy
> > CONFIG_VT82C686=3Dy
> > diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> > index 1aafe1923d..4d8a6c4af8 100644
> > --- a/hw/display/Kconfig
> > +++ b/hw/display/Kconfig
> > @@ -125,7 +125,7 @@ config DPCD
> > config ATI_VGA
> >     bool
> >     default y if PCI_DEVICES
> > -    depends on PCI
> > +    depends on PCI && PIXMAN
> >     select VGA
> >     select BITBANG_I2C
> >     select DDC
> > diff --git a/hw/display/meson.build b/hw/display/meson.build
> > index 9c06aaee20..344dfe3d8c 100644
> > --- a/hw/display/meson.build
> > +++ b/hw/display/meson.build
> > @@ -62,7 +62,7 @@ system_ss.add(when: 'CONFIG_XLNX_DISPLAYPORT', if_tru=
e: files('xlnx_dp.c'))
> >
> > system_ss.add(when: 'CONFIG_ARTIST', if_true: files('artist.c'))
> >
> > -system_ss.add(when: [pixman, 'CONFIG_ATI_VGA'], if_true: files('ati.c'=
, 'ati_2d.c', 'ati_dbg.c'))
> > +system_ss.add(when: 'CONFIG_ATI_VGA', if_true: [files('ati.c', 'ati_2d=
.c', 'ati_dbg.c'), pixman])
> >
> >
> > if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
> >



--=20
Marc-Andr=C3=A9 Lureau

