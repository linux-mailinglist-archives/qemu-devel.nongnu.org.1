Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B8B787EA2
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 05:37:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZNct-00050Q-6C; Thu, 24 Aug 2023 23:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qZNcr-0004w1-4a; Thu, 24 Aug 2023 23:36:45 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qZNco-0005uc-HG; Thu, 24 Aug 2023 23:36:44 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-52a0856b4fdso699810a12.1; 
 Thu, 24 Aug 2023 20:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692934600; x=1693539400;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s7zR0ygLEHh4fNAYjTlS+SpsoUSYtzSwhL+EoN4fISA=;
 b=QAttBe29MpKJPpxHYxgd3OCrsse/OGcKHCQaMHg4WFaQnRr8feAn684JHGuby5SdHS
 FHBywEdRc1iPLillAX4mXvYR2DkgMAF2HjMSGz1Yq6OzoDJZmlK5kGR+K76q8Lty0xAW
 Z5QNtvgrIGfzMr+t954GYY1pY1bhDQUQpu2GXMqw2t6qfiLowJDhu0pdA12k8b34xGKi
 DJzIw0pcq861/9qUlGeAHJtUxr6er3mnECmPI+Mmnu4q2uY5IBEFW6u9+YzbW3tlNHvV
 kNmHnJYlvk4ajPUNx8NWjwuoCuvdXtZK6laUC2K0C56vn5hv9xFXjySbM4hAfYr9B7it
 4fhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692934600; x=1693539400;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s7zR0ygLEHh4fNAYjTlS+SpsoUSYtzSwhL+EoN4fISA=;
 b=U6zZbjk3zh6/J03zBVQlZvubGrBg7eVY4qiCgpAKbv0Pvj+Acf8UwjAsI9J69y/x9d
 +LCzyzKspNyasP3rUnWY+NozGhUoZiEnK565l/FfR0AN7aFic7NnKTAyAtlYPbG+420y
 KPDDwIR70lgDdR/hMKCLZ9ilv+eGdAID/tKNAiGeENSL3N6VgmVmfHedonOuo5ssVvRB
 zsA5aLAkZNKC0qR1wiQZ0qpJ5j78+pw0jcxqCLYpu7p8WCriYqLf2Aoo+ZjcEsj4DsKx
 pgDvq66ooJfFun4ErHLJcCWePRdLm9PkjeoQX0J00v5cHef71WbUKOedOeR4viMfrLpP
 lOCw==
X-Gm-Message-State: AOJu0Yy5kMGhHqd4HKr84Yyl9FE5OseBs9vnOTc65HpHxfXmws0GjSEW
 bLOxeBeX3cu1CZ5tgMnv0m0aqR0dsZhz0apz1xo=
X-Google-Smtp-Source: AGHT+IHFRg/Un8VUekBkvgzRr8NOPglHLY8cbOF1vtBqrvYfp4jNMJwgNI4r6rvFqtwZSk6Y29id1V78oijriDa+OcQ=
X-Received: by 2002:aa7:d617:0:b0:52a:1d54:2531 with SMTP id
 c23-20020aa7d617000000b0052a1d542531mr7116943edr.30.1692934599513; Thu, 24
 Aug 2023 20:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230824173957.8472-1-faithilikerun@gmail.com>
 <8ec9d245-d729-2dd5-11de-e437bd37cdb8@kernel.org>
 <CAAAx-8KETdKpvSwuTERBdJEWdJbA34DhqKduajZd7QXF41Ee-A@mail.gmail.com>
 <7db0c1d5-455e-4431-c517-f0c216827029@kernel.org>
In-Reply-To: <7db0c1d5-455e-4431-c517-f0c216827029@kernel.org>
From: Sam Li <faithilikerun@gmail.com>
Date: Fri, 25 Aug 2023 11:36:10 +0800
Message-ID: <CAAAx-8KiuLadzWg8ofCFE4BHG7mDBo+6J=LTEs=azcsTseS+Bg@mail.gmail.com>
Subject: Re: [PATCH] block/file-posix: fix update_zones_wp() caller
To: Damien Le Moal <dlemoal@kernel.org>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 stefanha@redhat.com, hare@suse.de, dmitry.fomichev@wdc.com, 
 Hanna Reitz <hreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=faithilikerun@gmail.com; helo=mail-ed1-x535.google.com
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
=97=A5=E5=91=A8=E4=BA=94 11:32=E5=86=99=E9=81=93=EF=BC=9A
>
> On 8/25/23 12:05, Sam Li wrote:
> > Damien Le Moal <dlemoal@kernel.org> =E4=BA=8E2023=E5=B9=B48=E6=9C=8825=
=E6=97=A5=E5=91=A8=E4=BA=94 07:49=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On 8/25/23 02:39, Sam Li wrote:
> >>> When the zoned requests that may change wp fail, it needs to
> >>> update only wps of the zones within the range of the requests
> >>> for not disrupting the other in-flight requests. The wp is updated
> >>> successfully after the request completes.
> >>>
> >>> Fixed the callers with right offset and nr_zones.
> >>>
> >>> Signed-off-by: Sam Li <faithilikerun@gmail.com>
> >>> ---
> >>>  block/file-posix.c | 5 +++--
> >>>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/block/file-posix.c b/block/file-posix.c
> >>> index b16e9c21a1..22559d6c2d 100644
> >>> --- a/block/file-posix.c
> >>> +++ b/block/file-posix.c
> >>> @@ -2522,7 +2522,8 @@ out:
> >>>          }
> >>>      } else {
> >>>          if (type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) {
> >>> -            update_zones_wp(bs, s->fd, 0, 1);
> >>> +            update_zones_wp(bs, s->fd, offset,
> >>> +                            ROUND_UP(bytes, bs->bl.zone_size));
> >>
> >> Write and zone append operations are not allowed to cross zone boundar=
ies. So I
> >> the number of zones should always be 1. The above changes a number of =
zones to a
> >> number of bytes, which seems wrong. The correct fix is I think:
> >>
> >>                 update_zones_wp(bs, s->fd, offset, 1);
> >>
> >
> > I see. I forgot this constraint.
> >
> >>>          }
> >>>      }
> >>>
> >>> @@ -3472,7 +3473,7 @@ static int coroutine_fn raw_co_zone_mgmt(BlockD=
riverState *bs, BlockZoneOp op,
> >>>                          len >> BDRV_SECTOR_BITS);
> >>>      ret =3D raw_thread_pool_submit(handle_aiocb_zone_mgmt, &acb);
> >>>      if (ret !=3D 0) {
> >>> -        update_zones_wp(bs, s->fd, offset, i);
> >>> +        update_zones_wp(bs, s->fd, offset, nrz);
> >>
> >> Same here. Why would you need to update all zones wp ? This will affec=
t zones
> >> that do not have a write error and potentially change there correct in=
-memory wp
> >> to a wrong value. I think this also should be:
> >>
> >>            update_zones_wp(bs, s->fd, offset, 1);
> >>
> >
> > Is update_zones_wp for cancelling the writes on invalid zones or
> > updating corrupted write pointers caused by caller (write, append or
> > zone_mgmt)?
> >
> > My thought is based on the latter. Zone_mgmt can manage multiple zones
> > with a single request. When the request fails, it's hard to tell which
> > zone is corrupted. The relation between the req (zone_mgmt) and
> > update_zones_wp is: if req succeeds, no updates; if req fails,
> > consider the req never happens and do again.
>
> You should update the wp of the zones that were touched by the operation =
that
> failed. No other zone should have its wp updated as that could cause corr=
uptions
> of the wp if there are on-going writes on these other zones.
>
> so the call should be "update_zones_wp(bs, s->fd, offset, n);"
>
> with n being the number of zones that the operation targeted.

Yes, so it's nrz in zone_mgmt. Thanks!

>
> >
> > If the former is right, then it assumes only the first zone may
> > contain an error. I am not sure it's right.
> >
> >>>          error_report("ioctl %s failed %d", op_name, ret);
> >>>          return ret;
> >>>      }
> >>
> >> --
> >> Damien Le Moal
> >> Western Digital Research
> >>
>
> --
> Damien Le Moal
> Western Digital Research
>

