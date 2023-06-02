Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA255720872
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 19:36:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q58gr-0004w9-3k; Fri, 02 Jun 2023 13:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1q58gn-0004tl-ML; Fri, 02 Jun 2023 13:35:50 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1q58gl-0002CK-6P; Fri, 02 Jun 2023 13:35:49 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9745baf7c13so198780766b.1; 
 Fri, 02 Jun 2023 10:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685727345; x=1688319345;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6M2oiCN0fX+sRz7mXmfJvMhPVmpyT6tLzz9F1MC0C08=;
 b=J9NWyy0K5IJ8GkMVW/OCeyMlgR5JJiqRLUFoTZrpFgqjbUDcunPBI4jmGVxKoPbRXb
 vzfv5gmEsTiv3IGNZfZsxGvoLVKsuFSh3bHrGHxLhSsk6ydi5pSoIfbCgnkQpnJwmFmn
 Rzl+evt9i+/uzWlHJj51W/PJKxN8Z1WR3OgNE4l2yYxeUcthBOB2HElzbQPrB4gFFunw
 U5l63ufDDhLfhc4uIX5bEH9eC+IEZmjUZQ0gs8C9bSWWQMH2vfxDLBD9w/Z2Y7SqPeVT
 1o72gp9bTODLyA6qKyCn+wTavzG1/2bzYbWEZ0eA4Q71rrGby+yG1iWMUH0AU121QnaK
 NdWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685727345; x=1688319345;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6M2oiCN0fX+sRz7mXmfJvMhPVmpyT6tLzz9F1MC0C08=;
 b=Jpim7LIsvpYmFShx7WGg5NE5KFOcJVQyLgeRq9XHvk10gmxb7N0FsZGBeXTCv5u3TX
 eTEJEAQoCH9RIM0phMHvPYns9bantxNPLRmKFM9KqO2qjU903MGCSFM6U8p9WU/BuQMY
 mou35Ryom1eQeiNLfBip6nPj5QhdIs0Ekod4SXjCLTHVwVo5m8y3y3lEoHiahQMwLCTy
 eCtxYaIuAyOqU4OX+stutqfZAfxXC8VQFwz/FRHqXas+rFgX0RjcdZsnmrKBOGvIxdJL
 JFT1pdeZoXdV9bI8drUcba2HSGEOBSqGhtpQ0VRCfBK8gJ0+qkmtOAxCcP4XoX7sojfk
 +/kw==
X-Gm-Message-State: AC+VfDxW7bHf189XqZvoDMXF+GUuH63pGZYjIH9TrZ3JPAWNrgTNF/sL
 SCcno3wg55I+1v46iZ6roYdEPKyGqlME4lzFJCxtIQjc7D0gvS8u
X-Google-Smtp-Source: ACHHUZ7eB7oFTr2GQWbde0PRu/dpxK+FGfrdykHEvdq0EA7k097pAFfSbvfwKlxNJrHTKdT+YzGkmB+YjUs4KPAsiWc=
X-Received: by 2002:a17:907:6e90:b0:974:6335:4239 with SMTP id
 sh16-20020a1709076e9000b0097463354239mr2281761ejc.34.1685727344555; Fri, 02
 Jun 2023 10:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230515160506.1776883-1-stefanha@redhat.com>
 <20230515160506.1776883-11-stefanha@redhat.com>
 <CAFEAcA9bDh12FSk8CjEkBZjQOEBVd6-=fVwnM9bx8aoXvQdMuw@mail.gmail.com>
 <CAAAx-8L4Z3tBzV5DMEy0WnG=3y67bp_1g-+2kUhrY+rp2knNKA@mail.gmail.com>
 <CAFEAcA-WMkcreH7csiNyMBXCsS5XhcPK0vdRKiL70M_r18oYYg@mail.gmail.com>
In-Reply-To: <CAFEAcA-WMkcreH7csiNyMBXCsS5XhcPK0vdRKiL70M_r18oYYg@mail.gmail.com>
From: Sam Li <faithilikerun@gmail.com>
Date: Sat, 3 Jun 2023 01:35:18 +0800
Message-ID: <CAAAx-8LY9NX8veVhin=ThpqbpgP82GV4X9sXMzD9D0r2BqANxw@mail.gmail.com>
Subject: Re: [PULL v2 10/16] block: introduce zone append write for zoned
 devices
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Dmitry Fomichev <dmitry.fomichev@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=faithilikerun@gmail.com; helo=mail-ej1-x629.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FREEMAIL_REPLY=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> =E4=BA=8E2023=E5=B9=B46=E6=9C=883=
=E6=97=A5=E5=91=A8=E5=85=AD 01:30=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, 2 Jun 2023 at 18:23, Sam Li <faithilikerun@gmail.com> wrote:
> >
> > Peter Maydell <peter.maydell@linaro.org> =E4=BA=8E2023=E5=B9=B46=E6=9C=
=883=E6=97=A5=E5=91=A8=E5=85=AD 00:52=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Mon, 15 May 2023 at 17:06, Stefan Hajnoczi <stefanha@redhat.com> w=
rote:
> > > >
> > > > From: Sam Li <faithilikerun@gmail.com>
> > > >
> > > > A zone append command is a write operation that specifies the first
> > > > logical block of a zone as the write position. When writing to a zo=
ned
> > > > block device using zone append, the byte offset of the call may poi=
nt at
> > > > any position within the zone to which the data is being appended. U=
pon
> > > > completion the device will respond with the position where the data=
 has
> > > > been written in the zone.
> > > >
> > > > Signed-off-by: Sam Li <faithilikerun@gmail.com>
> > > > Reviewed-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> > > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > Message-id: 20230508051510.177850-3-faithilikerun@gmail.com
> > > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > >
> > > Hi; Coverity flagged up a possible bug here (CID 1512459):
> > >
> > > > @@ -2453,8 +2454,12 @@ static int coroutine_fn raw_co_prw(BlockDriv=
erState *bs, uint64_t offset,
> > > >      if (fd_open(bs) < 0)
> > > >          return -EIO;
> > > >  #if defined(CONFIG_BLKZONED)
> > > > -    if (type & QEMU_AIO_WRITE && bs->wps) {
> > > > +    if ((type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) && bs->wp=
s) {
> > >
> > > Here we check for bs->wps being NULL, which implies that it might be =
NULL...
> > >
> > > >          qemu_co_mutex_lock(&bs->wps->colock);
> > > > +        if (type & QEMU_AIO_ZONE_APPEND && bs->bl.zone_size) {
> > > > +            int index =3D offset / bs->bl.zone_size;
> > > > +            offset =3D bs->wps->wp[index];
> > > > +        }
> > > >      }
> > > >  #endif
> > > >
> > > > @@ -2502,9 +2507,13 @@ out:
> > > >  {
> > > >      BlockZoneWps *wps =3D bs->wps;
> > > >      if (ret =3D=3D 0) {
> > > > -        if (type & QEMU_AIO_WRITE && wps && bs->bl.zone_size) {
> > > > +        if ((type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND))
> > > > +            && wps && bs->bl.zone_size) {
> > > >              uint64_t *wp =3D &wps->wp[offset / bs->bl.zone_size];
> > > >              if (!BDRV_ZT_IS_CONV(*wp)) {
> > > > +                if (type & QEMU_AIO_ZONE_APPEND) {
> > > > +                    *s->offset =3D *wp;
> > > > +                }
> > > >                  /* Advance the wp if needed */
> > > >                  if (offset + bytes > *wp) {
> > > >                      *wp =3D offset + bytes;
> > > > @@ -2512,12 +2521,12 @@ out:
> > > >              }
> > > >          }
> > > >      } else {
> > > > -        if (type & QEMU_AIO_WRITE) {
> > > > +        if (type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) {
> > >
> > > ...but here we do not, even though update_zones_wp() can
> > > dereference bs->wps in some code paths.
> > >
> > > Should we be checking for NULL here before calling, or
> > > should update_zones_wp() handle a NULL bs->wps, or something else?
> >
> > Hi Peter,
> >
> > Thanks for spotting this. You are right that bs->wps is not checked in
> > this code path. I think the get_zones_wp() should handle a NULL
> > bs->wps which is the function calling wps directly.
> >
> > Would you like to submit a patch for this? Or I can do it if you are
> > not available.
>
> I don't know anything about this code, so I'm not really in
> a position to write a patch. I'm just passing on the information
> from the Coverity scanner -- it scales a lot better that way
> than trying to write fixes for everything myself :-)

I see. I'll fix it. Wish I had known more about this tool when I was
testing this code.

Thanks,
Sam

