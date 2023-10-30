Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC507DB806
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 11:26:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxPSu-00040X-Eo; Mon, 30 Oct 2023 06:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qxPS7-000407-18; Mon, 30 Oct 2023 06:24:59 -0400
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qxPS5-0006Me-CH; Mon, 30 Oct 2023 06:24:58 -0400
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-777719639adso301157685a.3; 
 Mon, 30 Oct 2023 03:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698661495; x=1699266295; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DWWv+1gy5wIn2Fqf6c6WT9OflRfRsVZTjv6+t0iRdpU=;
 b=SlZDj79Wf0Ci2pmnbvDNTVFSNKIoLTNnRM8DkU2GS9mQs5rZb+28U0n5jFE7n9/KcZ
 EjhmaSznjPaG+KMKM5MRePWCnbntbKZJBESiUPXopHvtpKMfJ9/lcoR0U+C5xjT5rfDn
 xVp+bwAz6l8egc3SqV+huhKKi6IZeieV+ELIZOo7BIfz5GuKeIlUXIns933mT7O8jbKk
 4uxWyxDvMlpC9JEdstvXYwHxLxaE6Fa71HUAdG5sTfAZFDjm2ePjaoDOzPm0WCKxfu6c
 fuUliVH0srTcwUZw5jiZqwp6niJWMiX65b31OvmjvRJHUMnVlG8Eu3tjpIf31uoMTGcb
 qEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698661495; x=1699266295;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DWWv+1gy5wIn2Fqf6c6WT9OflRfRsVZTjv6+t0iRdpU=;
 b=MPpWi4aAnzWWhMLPejcVkSOmUFKn+I2QJmJZgzh3vwzkFGbj8x/XPN9KJvlck3J63L
 kjstDIxXPIX+8qINviorIyZxQuZDVb9HkS6esAtVyOB5wnsbKNgwI53ObM6MhaDMVzO+
 rrxXzncN+MibGbgS3ILnRa9u9ZNU6dicX2D6l2/jiL0MuVno4REc4QfRgF0VPLKah2fc
 w4bqG7j1IFad7GehNgXI2AJQ2fWARjQnLDiUyXo1DLuraqgYBy9Y+uN0p6kj6Ja5uQsn
 4vmI5Eepo8wd6UzjCvmkh/V2eLGoEoqCHy/1lYWsSv1ccS5n+vNP0d57EtKh+Ig3rTVd
 wH1g==
X-Gm-Message-State: AOJu0YzQ+LS2py5WdOurc41XyCwrEIEcdTIb/A/PMCmdUnL+ZYqhxxdf
 FNbbVfIxmV3KacAIzv9MLQewaEBFz339vdWBM90=
X-Google-Smtp-Source: AGHT+IF+rvELbPbZhqOJ+Pj7e3rVKl90W7QhHI3ySg2A+7WGT6PFdQHcP8dVjTmNiGYVrgzzgTdji+7QYeoVL+rRJdU=
X-Received: by 2002:a05:6214:da2:b0:672:6450:f7ef with SMTP id
 h2-20020a0562140da200b006726450f7efmr2958700qvh.49.1698661495272; Mon, 30 Oct
 2023 03:24:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231025190818.3278423-1-marcandre.lureau@redhat.com>
 <20231025190818.3278423-16-marcandre.lureau@redhat.com>
 <4b2a7827-b0a0-4cd5-81a4-d4129a53ac82@redhat.com>
 <CAJ+F1C+q1N0MWGHH=L82iyL-gCp__U+eELo9=y5fz0rexUFptQ@mail.gmail.com>
 <d41aa305-6d3d-478a-82c7-e9a8789bdfce@redhat.com>
In-Reply-To: <d41aa305-6d3d-478a-82c7-e9a8789bdfce@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 30 Oct 2023 14:24:43 +0400
Message-ID: <CAJ+F1CLrjvVC_Cm9M9gVnxXvFVU-pxzoJX72nxd13yc+dhGq5A@mail.gmail.com>
Subject: Re: [PATCH v6 15/23] ui/gl: opengl doesn't require PIXMAN
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::72c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x72c.google.com
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

On Thu, Oct 26, 2023 at 12:45=E2=80=AFPM Thomas Huth <thuth@redhat.com> wro=
te:
>
> On 26/10/2023 10.09, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Thu, Oct 26, 2023 at 10:44=E2=80=AFAM Thomas Huth <thuth@redhat.com>=
 wrote:
> >>
> >> On 25/10/2023 21.08, marcandre.lureau@redhat.com wrote:
> >>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>>
> >>> The QEMU fallback covers the requirements. We still need the flags of
> >>> header inclusion with CONFIG_PIXMAN.
> >>>
> >>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>> ---
> >>>    ui/meson.build | 4 ++--
> >>>    1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/ui/meson.build b/ui/meson.build
> >>> index 3085e10a72..7c99613950 100644
> >>> --- a/ui/meson.build
> >>> +++ b/ui/meson.build
> >>> @@ -60,8 +60,8 @@ endif
> >>>    system_ss.add(opengl)
> >>>    if opengl.found()
> >>>      opengl_ss =3D ss.source_set()
> >>> -  opengl_ss.add(gbm)
> >>> -  opengl_ss.add(when: [opengl, pixman],
> >>> +  opengl_ss.add(gbm, pixman)
> >>
> >> I don't quite get the above line (sorry, meson ignorant here) ... does
> >> "pixman" simply get ignored here if it has not been found?
> >>
> >
> > Yes, when it is 'not_found", it's simply ignored. Essentially, this is
> > making pixman from required to optional to build the opengl source
> > set.
>
> All right, then I think the patch is fine:
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>
> But one more cosmetic question:
>
> +  opengl_ss.add(when: [opengl],
>                   if_true: files('shader.c', 'console-gl.c',
> 'egl-helpers.c', 'egl-context.c'))
>
> Do we still need the "when: [opengl]" part here? ... there is already the
> "if opengl.found()" earlier in this file, so it looks like this is not
> necessary anymore now?

Yes, to get the flags for those units.


--=20
Marc-Andr=C3=A9 Lureau

