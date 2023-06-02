Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7083720865
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 19:31:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q58c1-0000Sh-04; Fri, 02 Jun 2023 13:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q58bz-0000SM-DY
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 13:30:51 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q58bw-0001B3-Fb
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 13:30:51 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5149e65c218so3397135a12.2
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 10:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685727046; x=1688319046;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TKs6mbm6PlCOoo73/sckpDOq9f6yHhZmygSlDlv+ln4=;
 b=h5Zzs3bP3EwPQAw8bsTYi9kAAwn+NWD+2UWq3YUkYF+wuECP83rdljZwU2GN4NYTzD
 jv/ltCqGkiEgbZu/P0jECKsJiWj9Uh/dVPHhpxYsrmmRsY+3fkOy2BNh9+3UwbBvwIB4
 t2e1AS6F86BV902r4BvD+c9G+lKJp/sbVawaNJcQVv0CFP3pAc/072FbXwwMLWJQQio0
 tQh6A06EMQDByyLseUDXoIaA9oartT3PZV7VvRixmrCI9mrK3N78acS7WXPxG13f7d8r
 MIT7QAtDkcb3hPGatkzYu4ZPJQxCIVOSqIK2L4HnULIA6BSq8uscjuOpLmYMD1u8/CKX
 KFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685727046; x=1688319046;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TKs6mbm6PlCOoo73/sckpDOq9f6yHhZmygSlDlv+ln4=;
 b=LXKIK72HyFmL9S29lrraz5/HbM/xAHW/IGRmTHfvlPkkMd0NFtreYmlVebzkTytfc5
 hytusqSyElGOknicvc8966f05XJPre6Hqu6pNWMgBpboat72emNNB6SXyBi4AsmxA5CA
 NAdlLyRH1AiSnHJcQDcTydx/YCK27ygOhpUBs8mTU6pmzK0GCvsrE9h+lAAz0pbTs5CL
 R2uZuQNKIFTljBoWp61cb6xRTkQK4wfPPRHaMu+H2kZ5ChnoC8G5/TxMa+5ROJqv/+mq
 T+MK09mXTQ62WGLPfyU6R84irxASomEisD4ARRR271xZt7xkYIXXy2IYOWyahi2hVz0D
 1suQ==
X-Gm-Message-State: AC+VfDzuraUkoVLbMBo9cMZ1rL6fWaiqYcIsmAwNgv5RvzWQkwQmhd+x
 u3R6eHw/JoPKEppVmfUdHkJWiQKtymihB6zvpCPHLw==
X-Google-Smtp-Source: ACHHUZ5noom2WNYrBRS3WYd/6UHd91qG0w/hXAaRz1yVZZfQvCsS4IzFTNdAns3MiA3SUfvkFOub4mRW//wiRR4aRlA=
X-Received: by 2002:a05:6402:343:b0:514:abb9:7ab1 with SMTP id
 r3-20020a056402034300b00514abb97ab1mr2493469edw.8.1685727046691; Fri, 02 Jun
 2023 10:30:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230515160506.1776883-1-stefanha@redhat.com>
 <20230515160506.1776883-11-stefanha@redhat.com>
 <CAFEAcA9bDh12FSk8CjEkBZjQOEBVd6-=fVwnM9bx8aoXvQdMuw@mail.gmail.com>
 <CAAAx-8L4Z3tBzV5DMEy0WnG=3y67bp_1g-+2kUhrY+rp2knNKA@mail.gmail.com>
In-Reply-To: <CAAAx-8L4Z3tBzV5DMEy0WnG=3y67bp_1g-+2kUhrY+rp2knNKA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Jun 2023 18:30:35 +0100
Message-ID: <CAFEAcA-WMkcreH7csiNyMBXCsS5XhcPK0vdRKiL70M_r18oYYg@mail.gmail.com>
Subject: Re: [PULL v2 10/16] block: introduce zone append write for zoned
 devices
To: Sam Li <faithilikerun@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Dmitry Fomichev <dmitry.fomichev@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, 2 Jun 2023 at 18:23, Sam Li <faithilikerun@gmail.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> =E4=BA=8E2023=E5=B9=B46=E6=9C=88=
3=E6=97=A5=E5=91=A8=E5=85=AD 00:52=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Mon, 15 May 2023 at 17:06, Stefan Hajnoczi <stefanha@redhat.com> wro=
te:
> > >
> > > From: Sam Li <faithilikerun@gmail.com>
> > >
> > > A zone append command is a write operation that specifies the first
> > > logical block of a zone as the write position. When writing to a zone=
d
> > > block device using zone append, the byte offset of the call may point=
 at
> > > any position within the zone to which the data is being appended. Upo=
n
> > > completion the device will respond with the position where the data h=
as
> > > been written in the zone.
> > >
> > > Signed-off-by: Sam Li <faithilikerun@gmail.com>
> > > Reviewed-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > Message-id: 20230508051510.177850-3-faithilikerun@gmail.com
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> >
> > Hi; Coverity flagged up a possible bug here (CID 1512459):
> >
> > > @@ -2453,8 +2454,12 @@ static int coroutine_fn raw_co_prw(BlockDriver=
State *bs, uint64_t offset,
> > >      if (fd_open(bs) < 0)
> > >          return -EIO;
> > >  #if defined(CONFIG_BLKZONED)
> > > -    if (type & QEMU_AIO_WRITE && bs->wps) {
> > > +    if ((type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) && bs->wps)=
 {
> >
> > Here we check for bs->wps being NULL, which implies that it might be NU=
LL...
> >
> > >          qemu_co_mutex_lock(&bs->wps->colock);
> > > +        if (type & QEMU_AIO_ZONE_APPEND && bs->bl.zone_size) {
> > > +            int index =3D offset / bs->bl.zone_size;
> > > +            offset =3D bs->wps->wp[index];
> > > +        }
> > >      }
> > >  #endif
> > >
> > > @@ -2502,9 +2507,13 @@ out:
> > >  {
> > >      BlockZoneWps *wps =3D bs->wps;
> > >      if (ret =3D=3D 0) {
> > > -        if (type & QEMU_AIO_WRITE && wps && bs->bl.zone_size) {
> > > +        if ((type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND))
> > > +            && wps && bs->bl.zone_size) {
> > >              uint64_t *wp =3D &wps->wp[offset / bs->bl.zone_size];
> > >              if (!BDRV_ZT_IS_CONV(*wp)) {
> > > +                if (type & QEMU_AIO_ZONE_APPEND) {
> > > +                    *s->offset =3D *wp;
> > > +                }
> > >                  /* Advance the wp if needed */
> > >                  if (offset + bytes > *wp) {
> > >                      *wp =3D offset + bytes;
> > > @@ -2512,12 +2521,12 @@ out:
> > >              }
> > >          }
> > >      } else {
> > > -        if (type & QEMU_AIO_WRITE) {
> > > +        if (type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) {
> >
> > ...but here we do not, even though update_zones_wp() can
> > dereference bs->wps in some code paths.
> >
> > Should we be checking for NULL here before calling, or
> > should update_zones_wp() handle a NULL bs->wps, or something else?
>
> Hi Peter,
>
> Thanks for spotting this. You are right that bs->wps is not checked in
> this code path. I think the get_zones_wp() should handle a NULL
> bs->wps which is the function calling wps directly.
>
> Would you like to submit a patch for this? Or I can do it if you are
> not available.

I don't know anything about this code, so I'm not really in
a position to write a patch. I'm just passing on the information
from the Coverity scanner -- it scales a lot better that way
than trying to write fixes for everything myself :-)

thanks
-- PMM

