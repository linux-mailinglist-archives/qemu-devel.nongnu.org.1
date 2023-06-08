Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DC2727520
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 04:45:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q75dr-00048r-Su; Wed, 07 Jun 2023 22:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1q75dp-00048Z-W3; Wed, 07 Jun 2023 22:44:50 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1q75do-0000oB-GE; Wed, 07 Jun 2023 22:44:49 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5169f614977so121094a12.3; 
 Wed, 07 Jun 2023 19:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686192286; x=1688784286;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k2JP6d6p5N6vI2JDzcNHkZUnMIji/sgD1lXGlTeU1kQ=;
 b=G1c9zzGv7WEra2xF1ITjXIJxCNS/Wrus2vvNbZnD7u3ZHcqgCQvzlOEa+94wJZiPX7
 9m2wVLlyaqnKvarCFWm6Kr/peDVMV/Jrg+IdqOrHgbuO/PQwszWqtV7iiYYQGiEWnGnl
 esb2vOIoOTgadoamqCJg8OJ5HJ/wRzeC9gTlzBIfaJHHU42YXK9ZiIKnTgZCiAhD/s8u
 gDC0T8cN/+TT/7x8Ebi17EfBvcJeZXSSIOd0Zeb8w3WQLyaaeog3G4XNrPaywCslZgck
 UdK16q3HouC0XYpOFmz2FvHW07gX8fVLgzYEfCPYnhCD2zYas2MjE0Q9+xeZdQqdC3xi
 +mKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686192286; x=1688784286;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k2JP6d6p5N6vI2JDzcNHkZUnMIji/sgD1lXGlTeU1kQ=;
 b=RGhw4NVVWLXNB/zku3TAewosZUnTHkUR4jNw1UwIZdYd8cXsGW8fvz/QC2L1JBsdIU
 zIeWIpnyo+M7D0qFD0w+t45qM7pVBazQXcsL/TDvg7b8SweyJ+5NYP2Bbw3uia6FXq2N
 lyQImJeCKh55BKQsuIEpvkCWU+DBmHauC7FURn7oEibhmHUoGc2So0xybBtDFtdmmVHy
 joke/8KI8r5mTh9QtBXYlQY/+aiQYNAd97gb5mSCcK9g2+9V94V319DC4rnL8k0IZ1kq
 JH3B704qbVo6Stj9d9c4Kzw5np3EX9gayg0mZzyznsGbHgMglaz0zllios2E8ezBqf7T
 Mlxg==
X-Gm-Message-State: AC+VfDyRI73myK1H/v+7wVUJP93dArL0XGNUIdbW2ffhmwZQFsEgyPwe
 Nh6Mf9CakJWPswqMjc5cmDHFuLMkUVgqsoP5wL6bBK2uQ+XlGabVZsY=
X-Google-Smtp-Source: ACHHUZ4OLbw5MjyfCzu2LV3xui20aCrccj4gO066xNKAcLqgBNNyAasK8KXd1x1dwN3odVw9KEmk+0fbVCcSQMdgYB4=
X-Received: by 2002:a17:907:8a15:b0:974:1c98:d2d9 with SMTP id
 sc21-20020a1709078a1500b009741c98d2d9mr8380724ejc.3.1686192286090; Wed, 07
 Jun 2023 19:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230607185741.4238-1-faithilikerun@gmail.com>
 <6c2621d5-5446-7cd5-2b03-2eb9b99ae64b@kernel.org>
In-Reply-To: <6c2621d5-5446-7cd5-2b03-2eb9b99ae64b@kernel.org>
From: Sam Li <faithilikerun@gmail.com>
Date: Thu, 8 Jun 2023 10:44:19 +0800
Message-ID: <CAAAx-8+f7ETeQrAAUROtYYUbpqceRvevo05PRNP9w-g8jf1Mug@mail.gmail.com>
Subject: Re: [PATCH v2] block/file-posix: fix wps checking in raw_co_prw
To: Damien Le Moal <dlemoal@kernel.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Hanna Reitz <hreitz@redhat.com>, stefanha@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, dmitry.fomichev@wdc.com, hare@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=faithilikerun@gmail.com; helo=mail-ed1-x530.google.com
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

Damien Le Moal <dlemoal@kernel.org> =E4=BA=8E2023=E5=B9=B46=E6=9C=888=E6=97=
=A5=E5=91=A8=E5=9B=9B 09:29=E5=86=99=E9=81=93=EF=BC=9A
>
> On 6/8/23 03:57, Sam Li wrote:
> > If the write operation fails and the wps is NULL, then accessing it wil=
l
> > lead to data corruption.
> >
> > Solving the issue by adding a nullptr checking in get_zones_wp() where
> > the wps is used.
> >
> > This issue is found by Peter Maydell using the Coverity Tool (CID
> > 1512459).
> >
> > Signed-off-by: Sam Li <faithilikerun@gmail.com>
> > ---
> >  block/file-posix.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/block/file-posix.c b/block/file-posix.c
> > index ac1ed54811..4a6c71c7f5 100644
> > --- a/block/file-posix.c
> > +++ b/block/file-posix.c
> > @@ -2523,7 +2523,7 @@ out:
> >              }
> >          }
> >      } else {
> > -        if (type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) {
> > +        if (type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND) && wps) {
> >              update_zones_wp(bs, s->fd, 0, 1);
>
> Nit: this could be:
>
>         } else if (wps && type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND))=
 {
>
> However, both if & else side do something only if the above condition is =
true
> and we only need to that for a zoned drive. So the entire code block coul=
d
> really be simplified to be a lot more readable. Something like this (tota=
lly
> untested, not even compiled):
>
> #if defined(CONFIG_BLKZONED)
>     if (bs->bl.zone_size && (type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEN=
D))) {
>         BlockZoneWps *wps =3D bs->wps;
>         uint64_t *wp;
>
>         if (!wps) {
>             return ret;
>         }
>
>         if (ret) {
>             /* write error: update the wp from the underlying device */
>             update_zones_wp(bs, s->fd, 0, 1);
>             goto unlock;
>         }
>
>         wp =3D &wps->wp[offset / bs->bl.zone_size];
>         if (BDRV_ZT_IS_CONV(*wp)) {
>             /* Conventional zones do not have a write pointer */
>             goto unlock;
>         }
>
>         /* Return the written position for zone append */
>         if (type & QEMU_AIO_ZONE_APPEND) {
>             *s->offset =3D *wp;
>             trace_zbd_zone_append_complete(bs,
>                     *s->offset >> BDRV_SECTOR_BITS);
>         }
>
>         /* Advance the wp if needed */
>         if (offset + bytes > *wp) {
>             *wp =3D offset + bytes;
>         }
>
> unlock:
>         qemu_co_mutex_unlock(&wps->colock);
>     }
> #endif
>
> And making this entire block a helper function (e.g. advance_zone_wp()) w=
ould
> further clean the code. But that should be done in another patch. Care to=
 send one ?

Sure. If replacing the current code block by saying advance_zone_wp(),
I guess this patch won't be necessary. So I will send another patch
(advance_zone_wp()...) after testing.

Sam

