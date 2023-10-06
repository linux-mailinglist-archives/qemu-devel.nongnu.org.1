Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3977BBFCE
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 21:46:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoqkC-0000dC-MM; Fri, 06 Oct 2023 15:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mike.maslenkin@gmail.com>)
 id 1qoqkA-0000cg-I5; Fri, 06 Oct 2023 15:44:14 -0400
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mike.maslenkin@gmail.com>)
 id 1qoqk8-0005Zl-UO; Fri, 06 Oct 2023 15:44:14 -0400
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-d77ad095f13so2702622276.2; 
 Fri, 06 Oct 2023 12:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696621451; x=1697226251; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=74lPEca/UAU2oWCd/4/zo/d1fg9MPRz7UmeXpNS4ykM=;
 b=V79k9vsTqLPWTmT69bnST1fvyhr5wMsc0mWzyhYonerwxuahMbaYFJQ6Ys5WnqO0mG
 cuO0N2MaHL3tPkQ39f3nXRTxs8Yr7XqmSaBrkK22p6LkY/4puP3YW1QM5/ESk7C91mt+
 4ecyIeEFnwSi7mWecYmEkkxvQeZtMduw00iYKPb3yOydYj2EaLXhiP52B1aGKP6QL55x
 WUW+sXdELUzryvEKe1cFpwm3ubmVaFli2lREoDa7GryrS3wk1hnXgPO9tYvDJaMb7nG2
 hboTAzK/FLu7+43usaiWvEQVS4rbouE614ZEbuoYg1XgjM+9ZLTGzikHZNEBIJoqKpiq
 x6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696621451; x=1697226251;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=74lPEca/UAU2oWCd/4/zo/d1fg9MPRz7UmeXpNS4ykM=;
 b=o6X4Kg7womGobopI3YNb2c5wc5vkEjMIFm5crHf2eGyKesET6xvj2w7DV4AvSVVeWi
 7ZafIZA0SGtOiEgTCEBrycw9PALr+9Moe86OuT2Ymn2Wml8zfcUVygp/iwsRateq8O6X
 8Nc89ELYcJh6fnjaangpQEjHcaZIb25hd70nmcWw/oYJ4TQ5reod6I0+XY43fP//R2Zq
 pAkMCnVPGS4GyELayFl8Zq49G6kNJ2lyMf3KcbtqJ+jLbPQuuL+i3qlXQOVzp3XjJz3h
 yofD+hjFqBtb0zfHfbIiq1gEyeBNcqqpGxJGvms2UuZ0Uust7J8rAQ/fbuZWIVEcaqEj
 Ec8w==
X-Gm-Message-State: AOJu0YxwWEe102yxq6Z9eEKVSTLwubhZeHA2E3kKU0fh5B6tk8DHKtMD
 uweYvd7mibrARxbdVXwN/G0EjmhAvjClWQnfXJw=
X-Google-Smtp-Source: AGHT+IG5d0DUaFzkELvBpWrMBjIiWXc50qzMqREzZdUs3T0SM7TFjbyzTHaBkM8SRq+UO7Iv1l/SuNhAgXADXwJq7OY=
X-Received: by 2002:a25:cb8b:0:b0:d47:47c0:d7c1 with SMTP id
 b133-20020a25cb8b000000b00d4747c0d7c1mr9978673ybg.62.1696621451003; Fri, 06
 Oct 2023 12:44:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231002085738.369684-1-alexander.ivanov@virtuozzo.com>
 <20231002085738.369684-16-alexander.ivanov@virtuozzo.com>
In-Reply-To: <20231002085738.369684-16-alexander.ivanov@virtuozzo.com>
From: Mike Maslenkin <mike.maslenkin@gmail.com>
Date: Fri, 6 Oct 2023 22:43:34 +0300
Message-ID: <CAL77WPCgbWch6TqjBucJJ_MfG2nOFtoA=oT9EbAE+V_kDTfCgA@mail.gmail.com>
Subject: Re: [PATCH 15/19] parallels: Remove unnecessary data_end field
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, den@virtuozzo.com, 
 stefanha@redhat.com, vsementsov@yandex-team.ru, kwolf@redhat.com, 
 hreitz@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=mike.maslenkin@gmail.com; helo=mail-yb1-xb33.google.com
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

On Mon, Oct 2, 2023 at 12:01=E2=80=AFPM Alexander Ivanov
<alexander.ivanov@virtuozzo.com> wrote:
>
> Since we have used bitmap, field data_end in BDRVParallelsState is
> redundant and can be removed.
>
> Add parallels_data_end() helper and remove data_end handling.
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>  block/parallels.c | 33 +++++++++++++--------------------
>  block/parallels.h |  1 -
>  2 files changed, 13 insertions(+), 21 deletions(-)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 48ea5b3f03..80a7171b84 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -265,6 +265,13 @@ static void parallels_free_used_bitmap(BlockDriverSt=
ate *bs)
>      g_free(s->used_bmap);
>  }
>
> +static int64_t parallels_data_end(BDRVParallelsState *s)
> +{
> +    int64_t data_end =3D s->data_start * BDRV_SECTOR_SIZE;
> +    data_end +=3D s->used_bmap_size * s->cluster_size;
> +    return data_end;
> +}
> +
>  int64_t parallels_allocate_host_clusters(BlockDriverState *bs,
>                                           int64_t *clusters)
>  {
> @@ -275,7 +282,7 @@ int64_t parallels_allocate_host_clusters(BlockDriverS=
tate *bs,
>
>      first_free =3D find_first_zero_bit(s->used_bmap, s->used_bmap_size);
>      if (first_free =3D=3D s->used_bmap_size) {
> -        host_off =3D s->data_end * BDRV_SECTOR_SIZE;
> +        host_off =3D parallels_data_end(s);
>          prealloc_clusters =3D *clusters + s->prealloc_size / s->tracks;
>          bytes =3D prealloc_clusters * s->cluster_size;
>
> @@ -297,9 +304,6 @@ int64_t parallels_allocate_host_clusters(BlockDriverS=
tate *bs,
>          s->used_bmap =3D bitmap_zero_extend(s->used_bmap, s->used_bmap_s=
ize,
>                                            new_usedsize);
>          s->used_bmap_size =3D new_usedsize;
> -        if (host_off + bytes > s->data_end * BDRV_SECTOR_SIZE) {
> -            s->data_end =3D (host_off + bytes) / BDRV_SECTOR_SIZE;
> -        }
>      } else {
>          next_used =3D find_next_bit(s->used_bmap, s->used_bmap_size, fir=
st_free);
>
> @@ -315,8 +319,7 @@ int64_t parallels_allocate_host_clusters(BlockDriverS=
tate *bs,
>           * branch. In the other case we are likely re-using hole. Preall=
ocate
>           * the space if required by the prealloc_mode.
>           */
> -        if (s->prealloc_mode =3D=3D PRL_PREALLOC_MODE_FALLOCATE &&
> -                host_off < s->data_end * BDRV_SECTOR_SIZE) {
> +        if (s->prealloc_mode =3D=3D PRL_PREALLOC_MODE_FALLOCATE) {
>              ret =3D bdrv_pwrite_zeroes(bs->file, host_off, bytes, 0);
>              if (ret < 0) {
>                  return ret;
> @@ -757,13 +760,7 @@ parallels_check_outside_image(BlockDriverState *bs, =
BdrvCheckResult *res,
>          }
>      }
>
> -    if (high_off =3D=3D 0) {
> -        res->image_end_offset =3D s->data_end << BDRV_SECTOR_BITS;
> -    } else {
> -        res->image_end_offset =3D high_off + s->cluster_size;
> -        s->data_end =3D res->image_end_offset >> BDRV_SECTOR_BITS;
> -    }
> -
> +    res->image_end_offset =3D parallels_data_end(s);
>      return 0;
>  }
>
> @@ -806,7 +803,6 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckR=
esult *res,
>              res->check_errors++;
>              return ret;
>          }
> -        s->data_end =3D res->image_end_offset >> BDRV_SECTOR_BITS;
>
>          parallels_free_used_bitmap(bs);
>          ret =3D parallels_fill_used_bitmap(bs);
> @@ -1361,8 +1357,7 @@ static int parallels_open(BlockDriverState *bs, QDi=
ct *options, int flags,
>      }
>
>      s->data_start =3D data_start;
> -    s->data_end =3D s->data_start;
> -    if (s->data_end < (s->header_size >> BDRV_SECTOR_BITS)) {
> +    if (s->data_start < (s->header_size >> BDRV_SECTOR_BITS)) {
>          /*
>           * There is not enough unused space to fit to block align betwee=
n BAT
>           * and actual data. We can't avoid read-modify-write...
> @@ -1403,11 +1398,10 @@ static int parallels_open(BlockDriverState *bs, Q=
Dict *options, int flags,
>
>      for (i =3D 0; i < s->bat_size; i++) {
>          sector =3D bat2sect(s, i);
> -        if (sector + s->tracks > s->data_end) {
> -            s->data_end =3D sector + s->tracks;
> +        if (sector + s->tracks > file_nb_sectors) {
> +            need_check =3D true;
>          }
>      }
> -    need_check =3D need_check || s->data_end > file_nb_sectors;
>
>      ret =3D parallels_fill_used_bitmap(bs);
>      if (ret =3D=3D -ENOMEM) {
> @@ -1461,7 +1455,6 @@ static int parallels_truncate_unused_clusters(Block=
DriverState *bs)
>          end_off =3D (end_off + 1) * s->cluster_size;
>      }
>      end_off +=3D s->data_start * BDRV_SECTOR_SIZE;
> -    s->data_end =3D end_off / BDRV_SECTOR_SIZE;
>      return bdrv_truncate(bs->file, end_off, true, PREALLOC_MODE_OFF, 0, =
NULL);
>  }
>
> diff --git a/block/parallels.h b/block/parallels.h
> index 18b4f8068e..a6a048d890 100644
> --- a/block/parallels.h
> +++ b/block/parallels.h
> @@ -79,7 +79,6 @@ typedef struct BDRVParallelsState {
>      unsigned int bat_size;
>
>      int64_t  data_start;
> -    int64_t  data_end;
>      uint64_t prealloc_size;
>      ParallelsPreallocMode prealloc_mode;
>
> --
> 2.34.1
>

Is it intended behavior?

Run:
1. ./qemu-img create -f parallels $TEST_IMG 1T
2. dd if=3D/dev/zero of=3D$TEST_IMG oseek=3D12  bs=3D1M count=3D128 conv=3D=
notrunc
3. ./qemu-img check  $TEST_IMG
       No errors were found on the image.
       Image end offset: 150994944

Without this patch `qemu-img check` reports:
       ERROR space leaked at the end of the image 145752064

      139 leaked clusters were found on the image.
      This means waste of disk space, but no harm to data.
      Image end offset: 5242880

Note: there is another issue caused by previous commits exists.
g_free asserts from parallels_free_used_bitmap() because of
s->used_bmap is NULL.

To reproduce this crash at revision before or without patch 15/19, run comm=
ands:
1. ./qemu-img create -f parallels $TEST_IMG 1T
2. dd if=3D/dev/zero of=3D$TEST_IMG oseek=3D12  bs=3D1M count=3D128 conv=3D=
notrunc
3. ./qemu-img check -r leaks $TEST_IMG

Regards,
Mike.

