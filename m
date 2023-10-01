Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 197CF7B48C5
	for <lists+qemu-devel@lfdr.de>; Sun,  1 Oct 2023 19:10:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmzwc-0002Zt-2B; Sun, 01 Oct 2023 13:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mike.maslenkin@gmail.com>)
 id 1qmzwY-0002ZQ-JE; Sun, 01 Oct 2023 13:09:22 -0400
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mike.maslenkin@gmail.com>)
 id 1qmzwG-0006hp-Ie; Sun, 01 Oct 2023 13:09:22 -0400
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-d81adf0d57fso17422103276.1; 
 Sun, 01 Oct 2023 10:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696180143; x=1696784943; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AedRd7FJkFSoIT0C5rDSxfq1CAc2E2H+da9lGgp/59I=;
 b=Y8p8/FjhcimvN+2pyJX3u+T09IPjA9wIC0P5A6R9Opmaw41uNdOCzTbROPI0viaXDh
 g4s6J/SWZ1k7QAwKRbs6nPSbDffisxxBrmJiiz45PrVvICOW5TsfTNWzLZFXustCMz1/
 +R3Nw6TSDc21cLVgNWyIrIqetExQiGQ7Kst17jWhqpOkqVX5VPjgwze3m51enMAuT6UI
 HR86qsbJrU9Ip3bl4R1kgbgFqZQkZoWxV+I6kl4yOJXkbF70zYccyeSoFwawtwOpdbkw
 nKqq/7PndVvxqNVR0BxVHlp+UoPBexVhtUEkwr54yj6WbVRkVnJ00caCoc6c69gyDWgf
 fDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696180143; x=1696784943;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AedRd7FJkFSoIT0C5rDSxfq1CAc2E2H+da9lGgp/59I=;
 b=l4BegbSsQmgBf0l2vkobdtYYOFoBESFkKd6fszPzFQZoQDXxhyYsn5vsZpjZ+V5jVF
 JDR2TTfPg+VDJcN9GBFNGKClBqNfUUC6BF4regT7oZveHRQBpnJGp8IDX+2s155WgmxL
 cD0+zZwl0BcOPgyRnq5NiYvZRxlpIjOXofxcspD7CYVGBNHcxQGUMTOTPkv5CAYT2Vug
 58U6+UZw08bsVnxOHvUFarZ3nO8W7MCyThvDYf9oE4flJwDojbsrks9SfK+mIZD5OqS4
 BcdHAzLjs+TChQGb7NIUTTnYPe6yaJSFno/2ignPZTKCib56vH6EmtlHvH2SlSDWrwta
 sv2w==
X-Gm-Message-State: AOJu0YypPRQpihckIzvERw5i3eOotxObn4iJ5yPxv2KQs61jehPyhYY5
 F0bdY0wy6FR9RFigoLPar6GPcVnD7rTmGaS2ANI=
X-Google-Smtp-Source: AGHT+IHEB/Bz7sAuGBzuGFWuhkJCdGv2Cp7MFhzkmvdxCWfc525rSlnsvmFvFVMhUDNjqauN0A+UfjI5GFabmjsAu98=
X-Received: by 2002:a25:734d:0:b0:d89:46da:91c1 with SMTP id
 o74-20020a25734d000000b00d8946da91c1mr9180698ybc.21.1696180142818; Sun, 01
 Oct 2023 10:09:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230930203157.85766-1-mike.maslenkin@gmail.com>
 <15609bb5-95d0-3d38-4c44-bcd313dc723b@virtuozzo.com>
In-Reply-To: <15609bb5-95d0-3d38-4c44-bcd313dc723b@virtuozzo.com>
From: Mike Maslenkin <mike.maslenkin@gmail.com>
Date: Sun, 1 Oct 2023 20:08:26 +0300
Message-ID: <CAL77WPAHSG-B3J_G8JzJHS5OhjsnsDs_wjYyGyPcBbeyS0z8=A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] qemu-img: do not erase destination file in
 qemu-img dd command
To: "Denis V. Lunev" <den@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, 
 hreitz@redhat.com, den@openvz.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=mike.maslenkin@gmail.com; helo=mail-yb1-xb35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

I thought about "conv=3Dnotrunc", but my main concern is changed virtual
disk metadata.
It depends on how qemu-img used.
May be I followed to wrong pattern, but pros and cons of adding "conv"
parameter was not in my mind in scope of the first patch version.
I see 4 obvious ways of using `qemu-img dd`:
1. Copy virtual disk data between images of same format. I think disk
geometry must be preserved in this case.
2. Copy virtual disk data between different formats. It is a valid
pattern? May be `qemu-img convert` should to be used instead?
3. Merge snapshots to specified disk image, i.e read current state and
write it to new disk image.
4. Copy virtual disk data to raw binary file. Actually this patch
breaks 'dd' behavior for this case when source image is less (in terms
of logical blocks) than existed raw binary file.
    May be for this case condition can be improved to smth like
   if (strcmp(fmt, "raw") || !g_file_test(out.filename,
G_FILE_TEST_EXISTS)) . And parameter "conv=3Dnotrunc" may be implemented
additionally for this case.

Three of above do not require  "conv=3D" parameter from my point of view.

I would be glad to hear other opinions.

Regards,
Mike.


On Sun, Oct 1, 2023 at 3:25=E2=80=AFPM Denis V. Lunev <den@virtuozzo.com> w=
rote:
>
> On 9/30/23 22:31, Mike Maslenkin wrote:
> > Add a check that destination file exists and do not call bdrv_create fo=
r
> > this case.
> >
> > Currently `qemu-img dd` command destroys content of destination file.
> > Effectively this means that parameters (geometry) of destination image
> > file are changing. This can be undesirable behavior for user especially
> > if format of destination image does not support resizing.
> >
> > Steps to reproduce:
> >    1. Create empty disk image with some non default size.
> >         `qemu-img  create -f qcow2 $DEST_IMG 3T`
> >       Remember that `qemu-img info $DEST_IMG` returns:
> >         virtual size: 3 TiB (3298534883328 bytes)
> >         disk size: 240 KiB
> >         cluster_size: 65536
> >    2. Run `qemu-img dd -O qcow2 of=3D$DEST_IMG if=3D$SRC_IMG bs=3D1M co=
unt=3D100`
> >    3. Check `qemu-img info $DEST_IMG` output:
> >         virtual size: 100 MiB (104857600 bytes)
> >         disk size: 112 MiB
> >         cluster_size: 65536
> >
> > Parameters of $DEST_IMG were changed. Actually `qemu-img dd` has create=
d
> > a new disk based on current default geometry for particular format.
> > For example for "parallels" format default BAT for 256GB disk is writte=
n
> > to empty file prior writing disk image data.
> >
> > With this patch virtual disk metadata and geometry of a destination ima=
ge
> > are preserved. As another visible change of `qemu-img dd` behavior is t=
hat
> > if destination image is less than source it can finish with error (simi=
lar
> > to "dd" utility):
> >    qemu-img: error while writing to output image file: Input/output err=
or
> >
> > Signed-off-by: Mike Maslenkin <mike.maslenkin@gmail.com>
> > ---
> >    diff from v1: removed additional fprintf call leaved in patch by acc=
ident
> > ---
> >   qemu-img.c | 17 ++++++++++-------
> >   1 file changed, 10 insertions(+), 7 deletions(-)
> >
> > diff --git a/qemu-img.c b/qemu-img.c
> > index a48edb71015c..1a83c14212fb 100644
> > --- a/qemu-img.c
> > +++ b/qemu-img.c
> > @@ -5150,13 +5150,15 @@ static int img_dd(int argc, char **argv)
> >                               size - in.bsz * in.offset, &error_abort);
> >       }
> >
> > -    ret =3D bdrv_create(drv, out.filename, opts, &local_err);
> > -    if (ret < 0) {
> > -        error_reportf_err(local_err,
> > -                          "%s: error while creating output image: ",
> > -                          out.filename);
> > -        ret =3D -1;
> > -        goto out;
> > +    if (!g_file_test(out.filename, G_FILE_TEST_EXISTS)) {
> > +        ret =3D bdrv_create(drv, out.filename, opts, &local_err);
> > +        if (ret < 0) {
> > +            error_reportf_err(local_err,
> > +                               "%s: error while creating output image:=
 ",
> > +                               out.filename);
> > +            ret =3D -1;
> > +            goto out;
> > +        }
> >       }
> >
> >       /* TODO, we can't honour --image-opts for the target,
> may be it would be worth to follow conventional
> 'dd' approach, i.e. add conv=3Dnocreat option which
> will do the trick?
>
> Den

