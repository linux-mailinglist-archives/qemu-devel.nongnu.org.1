Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 960477D1D3F
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 15:31:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quC3c-0007nh-6s; Sat, 21 Oct 2023 09:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mike.maslenkin@gmail.com>)
 id 1quC3a-0007nM-PF; Sat, 21 Oct 2023 09:30:22 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mike.maslenkin@gmail.com>)
 id 1quC3Y-00035V-Ri; Sat, 21 Oct 2023 09:30:22 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5a7c95b8d14so19244657b3.3; 
 Sat, 21 Oct 2023 06:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697895019; x=1698499819; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=otU1AWG3xSpe3glyASDzGHIOy7EUJ4K/omdEwJr/xAw=;
 b=gpn7sC0V6NVIxALV2J7xVP9U+S5JVvVgVThSo9jBhrblumy+YxtCPu3Ayq3Vqy22ES
 M1ClE7+1ZOwiWVMqjs9a541N9aI8S5MvSEQlJ4Cd7AGYPdJxVtkrE8/PM5dNcR/lsZcn
 Wx/r5IqUo+MJX8oyhDFn/45FOVz5ZwJMpG+22vL9lJ/Z/YjwqRLYGAzaBso/xQaC2WiD
 Jh0lVWk1LJGRV48rRJ+lwII155990nqUKz2eelVGoKAsy0OIYbmmA7U4NfWBfldX+43/
 3UGIrsCWqWDnh6m9T5CRUGB+lDC2cg+VqS02rZo7MjJFqpOUcPpcPtQpzoAZ3noax2DI
 D/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697895019; x=1698499819;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=otU1AWG3xSpe3glyASDzGHIOy7EUJ4K/omdEwJr/xAw=;
 b=mmcbbfboIYXpnDpdD+8mslg015avlzq+dbEdhnIm57Rx42ZKQ6E9MdbacopoEppp7w
 HlZfQuwJg1sUL9rJgzvzktxi0Uq1tkTxA868mJFZnB7Nk4GvlXQZRnYZ0bDqIyTl4WIm
 0UGKWKfj6BmpQDxNFq9wY8medlsCBpfHHwztqd8P2+HMvu7HjBAieKyQ2Yq2j8vtQiHs
 w30JjWa+z+U5z4nti9IV7qR9ElK+F6yEaD9KwhfZxbIt+kAHcQExhyK5MKiYEc8f7nse
 T4BM6EAaAEqwfrKun3m8uU1MISK0ZXOpBvfTUiF2le7CVbBs89WG+GSJHwf5rNFDPtrf
 dd6g==
X-Gm-Message-State: AOJu0YydH/d1p30dLqBerGxO1+cUp3snx3xfhl/6U0YVWrXm0JjYJ1gz
 xBpvuuPkqTOtGVHFeECQtoHf19bScmcKiKyjImM=
X-Google-Smtp-Source: AGHT+IHNQSRhWqhY0ZAurcRRGbaII3mu8sbrk/mhyVE2m66xOP4CW8WlkqT5vSLg5hTCmNqrTMlzqKOSy2eHHAVglbY=
X-Received: by 2002:a81:9181:0:b0:5a7:be33:8bd4 with SMTP id
 i123-20020a819181000000b005a7be338bd4mr5691916ywg.2.1697895018871; Sat, 21
 Oct 2023 06:30:18 -0700 (PDT)
MIME-Version: 1.0
References: <20231019125854.390385-1-alexander.ivanov@virtuozzo.com>
 <20231019125854.390385-10-alexander.ivanov@virtuozzo.com>
In-Reply-To: <20231019125854.390385-10-alexander.ivanov@virtuozzo.com>
From: Mike Maslenkin <mike.maslenkin@gmail.com>
Date: Sat, 21 Oct 2023 16:29:42 +0300
Message-ID: <CAL77WPCgQNFTiGqJ=dJNNa1qYGYZOtp2LoM7CtKj50_=UvKKQg@mail.gmail.com>
Subject: Re: [PATCH v2 09/20] parallels: Make mark_used() and mark_unused()
 global functions
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, den@virtuozzo.com, 
 stefanha@redhat.com, vsementsov@yandex-team.ru, kwolf@redhat.com, 
 hreitz@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=mike.maslenkin@gmail.com; helo=mail-yw1-x1132.google.com
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

On Thu, Oct 19, 2023 at 5:23=E2=80=AFPM Alexander Ivanov
<alexander.ivanov@virtuozzo.com> wrote:
>
> We will need these functions in parallels-ext.c too. Let them be global
> functions parallels_mark_used() and parallels_mark_unused().
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>  block/parallels.c | 22 ++++++++++++----------
>  block/parallels.h |  5 +++++
>  2 files changed, 17 insertions(+), 10 deletions(-)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index a22ab7f2fc..2ee2b42038 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -178,8 +178,8 @@ static void parallels_set_bat_entry(BDRVParallelsStat=
e *s,
>      bitmap_set(s->bat_dirty_bmap, bat_entry_off(index) / s->bat_dirty_bl=
ock, 1);
>  }
>
> -static int mark_used(BlockDriverState *bs, unsigned long *bitmap,
> -                     uint32_t bitmap_size, int64_t off, uint32_t count)
> +int parallels_mark_used(BlockDriverState *bs, unsigned long *bitmap,
> +                        uint32_t bitmap_size, int64_t off, uint32_t coun=
t)
>  {
>      BDRVParallelsState *s =3D bs->opaque;
>      uint32_t cluster_index =3D host_cluster_index(s, off);
> @@ -195,8 +195,8 @@ static int mark_used(BlockDriverState *bs, unsigned l=
ong *bitmap,
>      return 0;
>  }
>
> -static int mark_unused(BlockDriverState *bs, unsigned long *bitmap,
> -                       uint32_t bitmap_size, int64_t off, uint32_t count=
)
> +int parallels_mark_unused(BlockDriverState *bs, unsigned long *bitmap,
> +                          uint32_t bitmap_size, int64_t off, uint32_t co=
unt)
>  {
>      BDRVParallelsState *s =3D bs->opaque;
>      uint32_t cluster_index =3D host_cluster_index(s, off);
> @@ -249,7 +249,8 @@ static int parallels_fill_used_bitmap(BlockDriverStat=
e *bs)
>              continue;
>          }
>
> -        err2 =3D mark_used(bs, s->used_bmap, s->used_bmap_size, host_off=
, 1);
> +        err2 =3D parallels_mark_used(bs, s->used_bmap, s->used_bmap_size=
,
> +                                   host_off, 1);
>          if (err2 < 0 && err =3D=3D 0) {
>              err =3D err2;
>          }
> @@ -326,7 +327,8 @@ int64_t parallels_allocate_host_clusters(BlockDriverS=
tate *bs,
>          }
>      }
>
> -    ret =3D mark_used(bs, s->used_bmap, s->used_bmap_size, host_off, *cl=
usters);
> +    ret =3D parallels_mark_used(bs, s->used_bmap, s->used_bmap_size,
> +                              host_off, *clusters);
>      if (ret < 0) {
>          /* Image consistency is broken. Alarm! */
>          return ret;
> @@ -393,8 +395,8 @@ allocate_clusters(BlockDriverState *bs, int64_t secto=
r_num,
>
>          qemu_vfree(buf);
>          if (ret < 0) {
> -            mark_unused(bs, s->used_bmap, s->used_bmap_size,
> -                        host_off, to_allocate);
> +            parallels_mark_unused(bs, s->used_bmap, s->used_bmap_size,
> +                                  host_off, to_allocate);
>              return ret;
>          }
>      }
> @@ -868,7 +870,7 @@ parallels_check_duplicate(BlockDriverState *bs, BdrvC=
heckResult *res,
>              continue;
>          }
>
> -        ret =3D mark_used(bs, bitmap, bitmap_size, host_off, 1);
> +        ret =3D parallels_mark_used(bs, bitmap, bitmap_size, host_off, 1=
);
>          assert(ret !=3D -E2BIG);
>          if (ret =3D=3D 0) {
>              continue;
> @@ -928,7 +930,7 @@ parallels_check_duplicate(BlockDriverState *bs, BdrvC=
heckResult *res,
>           * considered, and the bitmap size doesn't change. This specific=
ally
>           * means that -E2BIG is OK.
>           */
> -        ret =3D mark_used(bs, bitmap, bitmap_size, host_off, 1);
> +        ret =3D parallels_mark_used(bs, bitmap, bitmap_size, host_off, 1=
);
>          if (ret =3D=3D -EBUSY) {
>              res->check_errors++;
>              goto out_repair_bat;
> diff --git a/block/parallels.h b/block/parallels.h
> index 3e4f397502..4e7aa6b80f 100644
> --- a/block/parallels.h
> +++ b/block/parallels.h
> @@ -90,6 +90,11 @@ typedef struct BDRVParallelsState {
>      Error *migration_blocker;
>  } BDRVParallelsState;
>
> +int parallels_mark_used(BlockDriverState *bs, unsigned long *bitmap,
> +                        uint32_t bitmap_size, int64_t off, uint32_t coun=
t);
> +int parallels_mark_unused(BlockDriverState *bs, unsigned long *bitmap,
> +                          uint32_t bitmap_size, int64_t off, uint32_t co=
unt);
> +
>  int64_t parallels_allocate_host_clusters(BlockDriverState *bs,
>                                           int64_t *clusters);
>
> --
> 2.34.1
>
>

Just a note: parallels_mark_unused() could be initially declared as
global just because after patch 3/20 there can be compilation warning:
warning: unused function 'mark_unused' [-Wunused-function]
:)

I do not have strong opinion about how to avoid such compilation
warning in the middle of the patch series.
The simplest and straightforward way is to declare this function as
static in patch 4.

I do not have any other objections for the series except misplaced
NULL assignment.

Regards,
Mike.

