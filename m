Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC15787E43
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 05:07:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZN97-0000Bs-PW; Thu, 24 Aug 2023 23:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qZN95-00009S-GN; Thu, 24 Aug 2023 23:05:59 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qZN92-0007gc-Ph; Thu, 24 Aug 2023 23:05:58 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5256d74dab9so711349a12.1; 
 Thu, 24 Aug 2023 20:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692932755; x=1693537555;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tNYYuR7cPWG0CdY7Lwx+MQ2sL87MiEehS1KRd/6PGlc=;
 b=m4yaNSRU856Fu5ICsLdHNB9cl8+vO2motaZjGWDx6d2b1I9rhaLFuaKzL2Ew68O6dy
 2KEE+8vILSXVftK5H9t7R7l0qLjPr/gvwOuWFZoLmtMeQwPsX7ZpwBm54dV6j8bmYJAh
 LsTeOgPxo1Gqs40I8rF4BhAfSPXnMvbmN4FDbcyWvptVcYPVQfhcCH1BbUXwz9AWaX4v
 2nmKN49s1yzy2Z4+nTjIciNkpzcZ5BCB2DjkUQElLVvyIHxCn3drM0bgel4jJXmSRM+O
 BcTzcuqN3vX+Zt+TbN0CI/ZaNiain4GeRCdVZHwise/A93f+dVaz8pp4PTRHqHbdku35
 0TBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692932755; x=1693537555;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tNYYuR7cPWG0CdY7Lwx+MQ2sL87MiEehS1KRd/6PGlc=;
 b=UO/lrbFKEPb+eHE+5x094yFSLWyP9KLs1QSlLAEEx6Zv+LM47pTGB2xglXuP1Arwuv
 2aSvhe8/kXuJBqJNJU2WEUsddtBWDH9w3PA/sH6v04J1Y6fH3n9MaH3yEsFxc7P2WOUq
 OV+h6+qp2lMbduMdwhU2LaA4lM4dQ4dRSCRA3Jpx+3K4m3jSm4fhi1AjqWeKpdfz+o8g
 O1lxjC44HVpE/Y2gND8Oldy/iBnWITTDUOdYjMy7zgzAYp/I8D31xmq3c4Et/AnTjRMc
 gcxbLUwpdVyu5PUnVF95VOf6PCEzyEHZ2evlPhmooRpIf3mjO8lQNwLlrkwFd5VtzPpt
 32/w==
X-Gm-Message-State: AOJu0YzTiu7Fd2g5crgcQU6siTq6rWiO+lM6s619rKhsyX3rUNCkt5Zn
 fl8B4rMjOUQs9EH2RXYvByhQsqkOx2dEvYK+twA=
X-Google-Smtp-Source: AGHT+IGtGXq13rbmiRSvjfRuEcq+HJo4ZoKdoQr9GjeXBvXBV5v40R3OjKUUJeYIPjZr7l15bFdl+A1+/6CP4Sh6DtU=
X-Received: by 2002:aa7:c508:0:b0:524:547b:59eb with SMTP id
 o8-20020aa7c508000000b00524547b59ebmr13124810edq.15.1692932754128; Thu, 24
 Aug 2023 20:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230824173957.8472-1-faithilikerun@gmail.com>
 <8ec9d245-d729-2dd5-11de-e437bd37cdb8@kernel.org>
In-Reply-To: <8ec9d245-d729-2dd5-11de-e437bd37cdb8@kernel.org>
From: Sam Li <faithilikerun@gmail.com>
Date: Fri, 25 Aug 2023 11:05:25 +0800
Message-ID: <CAAAx-8KETdKpvSwuTERBdJEWdJbA34DhqKduajZd7QXF41Ee-A@mail.gmail.com>
Subject: Re: [PATCH] block/file-posix: fix update_zones_wp() caller
To: Damien Le Moal <dlemoal@kernel.org>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 stefanha@redhat.com, hare@suse.de, dmitry.fomichev@wdc.com, 
 Hanna Reitz <hreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=faithilikerun@gmail.com; helo=mail-ed1-x52f.google.com
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

Damien Le Moal <dlemoal@kernel.org> =E4=BA=8E2023=E5=B9=B48=E6=9C=8825=E6=
=97=A5=E5=91=A8=E4=BA=94 07:49=E5=86=99=E9=81=93=EF=BC=9A
>
> On 8/25/23 02:39, Sam Li wrote:
> > When the zoned requests that may change wp fail, it needs to
> > update only wps of the zones within the range of the requests
> > for not disrupting the other in-flight requests. The wp is updated
> > successfully after the request completes.
> >
> > Fixed the callers with right offset and nr_zones.
> >
> > Signed-off-by: Sam Li <faithilikerun@gmail.com>
> > ---
> >  block/file-posix.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/block/file-posix.c b/block/file-posix.c
> > index b16e9c21a1..22559d6c2d 100644
> > --- a/block/file-posix.c
> > +++ b/block/file-posix.c
> > @@ -2522,7 +2522,8 @@ out:
> >          }
> >      } else {
> >          if (type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) {
> > -            update_zones_wp(bs, s->fd, 0, 1);
> > +            update_zones_wp(bs, s->fd, offset,
> > +                            ROUND_UP(bytes, bs->bl.zone_size));
>
> Write and zone append operations are not allowed to cross zone boundaries=
. So I
> the number of zones should always be 1. The above changes a number of zon=
es to a
> number of bytes, which seems wrong. The correct fix is I think:
>
>                 update_zones_wp(bs, s->fd, offset, 1);
>

I see. I forgot this constraint.

> >          }
> >      }
> >
> > @@ -3472,7 +3473,7 @@ static int coroutine_fn raw_co_zone_mgmt(BlockDri=
verState *bs, BlockZoneOp op,
> >                          len >> BDRV_SECTOR_BITS);
> >      ret =3D raw_thread_pool_submit(handle_aiocb_zone_mgmt, &acb);
> >      if (ret !=3D 0) {
> > -        update_zones_wp(bs, s->fd, offset, i);
> > +        update_zones_wp(bs, s->fd, offset, nrz);
>
> Same here. Why would you need to update all zones wp ? This will affect z=
ones
> that do not have a write error and potentially change there correct in-me=
mory wp
> to a wrong value. I think this also should be:
>
>            update_zones_wp(bs, s->fd, offset, 1);
>

Is update_zones_wp for cancelling the writes on invalid zones or
updating corrupted write pointers caused by caller (write, append or
zone_mgmt)?

My thought is based on the latter. Zone_mgmt can manage multiple zones
with a single request. When the request fails, it's hard to tell which
zone is corrupted. The relation between the req (zone_mgmt) and
update_zones_wp is: if req succeeds, no updates; if req fails,
consider the req never happens and do again.

If the former is right, then it assumes only the first zone may
contain an error. I am not sure it's right.

> >          error_report("ioctl %s failed %d", op_name, ret);
> >          return ret;
> >      }
>
> --
> Damien Le Moal
> Western Digital Research
>

