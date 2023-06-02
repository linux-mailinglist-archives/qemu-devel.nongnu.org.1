Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F75E720853
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 19:24:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q58V4-00052u-FA; Fri, 02 Jun 2023 13:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1q58V2-00052P-A7; Fri, 02 Jun 2023 13:23:40 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1q58V0-0007k0-L6; Fri, 02 Jun 2023 13:23:40 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2af7081c9ebso33608951fa.1; 
 Fri, 02 Jun 2023 10:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685726616; x=1688318616;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/PUooaiw2ZIPI7gYsUUnC0DsYq4uCelc7iYtK5+GZiQ=;
 b=l+v4G/lPceM/uqygQf0IOaZtx0t0TGr4nlSdT/o9TjbZ9xkfdHcwPn8MY1PVFk5QbZ
 X6f6XZWsYFuzqfcOEQw7lj5+wlfB33zk/74JN9j3GenhzOd2XR++bC4uoe20WmW9WmOM
 myIYBFjpPB+mR2w9F7qSONLbqAXECc5Y+YAl0Wh+PNmHAyDt7/Pp6amh9y/5lYmFuu9t
 bWBfo5BxzNk19o6HHLKyHYBaV+U1mMFI77CKJDpwq0nDHzFykIMvxDsD75Q7OVaWGgvK
 LJ8u3tKqwl9XdRmhzgIgn+BWMW30A+hh52ttWTbuYvqDUQFMP+BmkCyKJa0Dzq1R6pug
 WFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685726616; x=1688318616;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/PUooaiw2ZIPI7gYsUUnC0DsYq4uCelc7iYtK5+GZiQ=;
 b=PCbkgnHHxuXJ3qSzDDq6k2DndpgNQ12SBTD8Zv0YeJ5wtL5toRyr5PZMldRcQXQ5mv
 3BGshx+yiZjPnxGpI4ROdgw8wK4Q6bu4x9CjShxWWfPViSF5Wk5nw2vpeLj2Ik4L0h+N
 k2IdK8En+FCAf4gjEbpn2H9OlSIbD1MzP+issKi25ryqrgRDU6ByGFTkR5EaZlAJkR/Q
 o5jdLC3Sw+/dkhw9bogltw6dhmEjFWzCw7/6BTgBIB0q0HjDp/CNrafSNIzrO8V+FbIr
 SlAxDZGe/uf/+G8ZQAVHSZi4+CayvyLO08IuZbU/QyZnozEKgRUhHTKRNJZ4PDPke1on
 XVbA==
X-Gm-Message-State: AC+VfDz0FvIAhWfridzU9ENpfriQW1CSQJ9+ymuDfMOWk/GfVPnXZiCB
 FiYpsqsJRZX+KTKJIRP8zb3GTHa6673+FBdv8d4=
X-Google-Smtp-Source: ACHHUZ70CmwJr95EePxKAh11s0Fnwjl1APVvzyX3TvrWdK+86xHap5dDQoWGWR44RpZhzCkbffByO2H71ivVNvUiv40=
X-Received: by 2002:a2e:3506:0:b0:2af:32a7:4eef with SMTP id
 z6-20020a2e3506000000b002af32a74eefmr391032ljz.35.1685726615577; Fri, 02 Jun
 2023 10:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230515160506.1776883-1-stefanha@redhat.com>
 <20230515160506.1776883-11-stefanha@redhat.com>
 <CAFEAcA9bDh12FSk8CjEkBZjQOEBVd6-=fVwnM9bx8aoXvQdMuw@mail.gmail.com>
In-Reply-To: <CAFEAcA9bDh12FSk8CjEkBZjQOEBVd6-=fVwnM9bx8aoXvQdMuw@mail.gmail.com>
From: Sam Li <faithilikerun@gmail.com>
Date: Sat, 3 Jun 2023 01:23:09 +0800
Message-ID: <CAAAx-8L4Z3tBzV5DMEy0WnG=3y67bp_1g-+2kUhrY+rp2knNKA@mail.gmail.com>
Subject: Re: [PULL v2 10/16] block: introduce zone append write for zoned
 devices
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Dmitry Fomichev <dmitry.fomichev@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=faithilikerun@gmail.com; helo=mail-lj1-x231.google.com
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
=E6=97=A5=E5=91=A8=E5=85=AD 00:52=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, 15 May 2023 at 17:06, Stefan Hajnoczi <stefanha@redhat.com> wrote=
:
> >
> > From: Sam Li <faithilikerun@gmail.com>
> >
> > A zone append command is a write operation that specifies the first
> > logical block of a zone as the write position. When writing to a zoned
> > block device using zone append, the byte offset of the call may point a=
t
> > any position within the zone to which the data is being appended. Upon
> > completion the device will respond with the position where the data has
> > been written in the zone.
> >
> > Signed-off-by: Sam Li <faithilikerun@gmail.com>
> > Reviewed-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Message-id: 20230508051510.177850-3-faithilikerun@gmail.com
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>
> Hi; Coverity flagged up a possible bug here (CID 1512459):
>
> > @@ -2453,8 +2454,12 @@ static int coroutine_fn raw_co_prw(BlockDriverSt=
ate *bs, uint64_t offset,
> >      if (fd_open(bs) < 0)
> >          return -EIO;
> >  #if defined(CONFIG_BLKZONED)
> > -    if (type & QEMU_AIO_WRITE && bs->wps) {
> > +    if ((type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) && bs->wps) {
>
> Here we check for bs->wps being NULL, which implies that it might be NULL=
...
>
> >          qemu_co_mutex_lock(&bs->wps->colock);
> > +        if (type & QEMU_AIO_ZONE_APPEND && bs->bl.zone_size) {
> > +            int index =3D offset / bs->bl.zone_size;
> > +            offset =3D bs->wps->wp[index];
> > +        }
> >      }
> >  #endif
> >
> > @@ -2502,9 +2507,13 @@ out:
> >  {
> >      BlockZoneWps *wps =3D bs->wps;
> >      if (ret =3D=3D 0) {
> > -        if (type & QEMU_AIO_WRITE && wps && bs->bl.zone_size) {
> > +        if ((type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND))
> > +            && wps && bs->bl.zone_size) {
> >              uint64_t *wp =3D &wps->wp[offset / bs->bl.zone_size];
> >              if (!BDRV_ZT_IS_CONV(*wp)) {
> > +                if (type & QEMU_AIO_ZONE_APPEND) {
> > +                    *s->offset =3D *wp;
> > +                }
> >                  /* Advance the wp if needed */
> >                  if (offset + bytes > *wp) {
> >                      *wp =3D offset + bytes;
> > @@ -2512,12 +2521,12 @@ out:
> >              }
> >          }
> >      } else {
> > -        if (type & QEMU_AIO_WRITE) {
> > +        if (type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) {
>
> ...but here we do not, even though update_zones_wp() can
> dereference bs->wps in some code paths.
>
> Should we be checking for NULL here before calling, or
> should update_zones_wp() handle a NULL bs->wps, or something else?

Hi Peter,

Thanks for spotting this. You are right that bs->wps is not checked in
this code path. I think the get_zones_wp() should handle a NULL
bs->wps which is the function calling wps directly.

Would you like to submit a patch for this? Or I can do it if you are
not available.

Thanks,
Sam

>
> >              update_zones_wp(bs, s->fd, 0, 1);
> >          }
> >      }
> >
> > -    if (type & QEMU_AIO_WRITE && wps) {
> > +    if ((type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) && wps) {
> >          qemu_co_mutex_unlock(&wps->colock);
> >      }
> >  }
>
> thanks
> -- PMM

