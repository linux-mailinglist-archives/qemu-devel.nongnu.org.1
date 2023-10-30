Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C69C77DB49F
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 08:52:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxN3p-0004rK-3W; Mon, 30 Oct 2023 03:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qxN3a-0004pQ-BV; Mon, 30 Oct 2023 03:51:30 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qxN3Y-0005Zr-Gu; Mon, 30 Oct 2023 03:51:30 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5409bc907edso6329992a12.0; 
 Mon, 30 Oct 2023 00:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698652286; x=1699257086; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MyYwVEx8NrpucrT4xPSd3/u6LXtXEv+Us/EXosObXPs=;
 b=agGDQ+k5lxy2CHTonQPPU6LrampPWvly0A4+47TgBl62PVWf+YO/cYRM7uyDfnAXuD
 kWC3HMUj132nsGwn7p9DLRMkCd5mGQWTfDJDrYs5FJemaVLY+92fMPPj2IEhH2W1etLh
 vNkzwTzAty8vgDa2bUXsnueivDhujnMi/V5fr4ZmUERbP+a95eM3pRV8lFZM2F/rg7o9
 BAQlUa7FjZysf4CzrW4yb8Q88La3pjbE6k4Ba4bZX62HXlJ3OUT+cWIaTNKLJiJ77av+
 CHphZrPDhkpPJ8CcWhQUWG4JckvTlb7fn2XfEebIDe9UbNEe7CUslxP3ZUlhKsvVz6Lg
 LXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698652286; x=1699257086;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MyYwVEx8NrpucrT4xPSd3/u6LXtXEv+Us/EXosObXPs=;
 b=wALkcJ8MP0Jir4grd1UNXRxkgNfZGuoKVtHT1Z7JvzTwep+eRfQuf1EKGCyzt3XvZR
 KpkbCTRGNX+r6Z4nvUnEwEoSPIgYyWC9BYzThlhS4v5vuvdCtEm7dSO0jydHceHcNvxc
 3pj8t7NOSLGNiGCydHwBjXi2piIy+3A2SVq5uUmOCHKANw6XY5zEgZHL2VbPZiPbU0Zd
 ETRSDljHIo5lqIKYzs/gqygFY9HzWulA8kyYSncVhV+inu5HXHxBGmBME1xbgFLQD5Qz
 xqsmw9rS0ChPdf5ljykIOgsytlAbjj5+FJ1rH7+wTahPz0r5SEkYKuAL1+uVX2aRNtp/
 rrrg==
X-Gm-Message-State: AOJu0YwKJ4rHdIlSqHbpuIXXzWxAFjdwq8yz7zGuVAvLz9euNDAOXTyH
 86GQtUVRAuABgVvNMXJs+h3sgEn0cn8H/9tvRcc=
X-Google-Smtp-Source: AGHT+IE9Uy4ehqtLkDnDsaZBXuRX8rcnMEq4p4EPOmRYTbWEswZ+/DvxvtuBWyAhqk9R2boF/dK6BEotKFYF/13CfUE=
X-Received: by 2002:aa7:c309:0:b0:53d:eca8:8775 with SMTP id
 l9-20020aa7c309000000b0053deca88775mr7269326edq.26.1698652285548; Mon, 30 Oct
 2023 00:51:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231030073853.2601162-1-naohiro.aota@wdc.com>
In-Reply-To: <20231030073853.2601162-1-naohiro.aota@wdc.com>
From: Sam Li <faithilikerun@gmail.com>
Date: Mon, 30 Oct 2023 15:50:58 +0800
Message-ID: <CAAAx-8LtFaFpa4rMjhKdC1wWnm9YFexW4Xm1xcmUNDkp2VjZKg@mail.gmail.com>
Subject: Re: [PATCH] file-posix: fix over-writing of returning zone_append
 offset
To: Naohiro Aota <nao.aota@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Damien Le Moal <Damien.LeMoal@wdc.com>, 
 Naohiro Aota <naohiro.aota@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=faithilikerun@gmail.com; helo=mail-ed1-x52b.google.com
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

Naohiro Aota <nao.aota@gmail.com> =E4=BA=8E2023=E5=B9=B410=E6=9C=8830=E6=97=
=A5=E5=91=A8=E4=B8=80 15:39=E5=86=99=E9=81=93=EF=BC=9A
>
> raw_co_zone_append() sets "s->offset" where "BDRVRawState *s". This point=
er
> is used later at raw_co_prw() to save the block address where the data is
> written.
>
> When multiple IOs are on-going at the same time, a later IO's
> raw_co_zone_append() call over-writes a former IO's offset address before
> raw_co_prw() completes. As a result, the former zone append IO returns th=
e
> initial value (=3D the start address of the writing zone), instead of the
> proper address.
>
> Fix the issue by passing the offset pointer to raw_co_prw() instead of
> passing it through s->offset. Also, remove "offset" from BDRVRawState as
> there is no usage anymore.
>
> Fixes: 4751d09adcc3 ("block: introduce zone append write for zoned device=
s")
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  block/file-posix.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)

Thanks!

Reviewed-by: Sam Li <faithilikerun@gmail.com>

>
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 50e2b20d5c45..c39209358909 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -160,7 +160,6 @@ typedef struct BDRVRawState {
>      bool has_write_zeroes:1;
>      bool use_linux_aio:1;
>      bool use_linux_io_uring:1;
> -    int64_t *offset; /* offset of zone append operation */
>      int page_cache_inconsistent; /* errno from fdatasync failure */
>      bool has_fallocate;
>      bool needs_alignment;
> @@ -2445,12 +2444,13 @@ static bool bdrv_qiov_is_aligned(BlockDriverState=
 *bs, QEMUIOVector *qiov)
>      return true;
>  }
>
> -static int coroutine_fn raw_co_prw(BlockDriverState *bs, uint64_t offset=
,
> +static int coroutine_fn raw_co_prw(BlockDriverState *bs, int64_t *offset=
_ptr,
>                                     uint64_t bytes, QEMUIOVector *qiov, i=
nt type)
>  {
>      BDRVRawState *s =3D bs->opaque;
>      RawPosixAIOData acb;
>      int ret;
> +    uint64_t offset =3D *offset_ptr;
>
>      if (fd_open(bs) < 0)
>          return -EIO;
> @@ -2513,8 +2513,8 @@ out:
>              uint64_t *wp =3D &wps->wp[offset / bs->bl.zone_size];
>              if (!BDRV_ZT_IS_CONV(*wp)) {
>                  if (type & QEMU_AIO_ZONE_APPEND) {
> -                    *s->offset =3D *wp;
> -                    trace_zbd_zone_append_complete(bs, *s->offset
> +                    *offset_ptr =3D *wp;
> +                    trace_zbd_zone_append_complete(bs, *offset_ptr
>                          >> BDRV_SECTOR_BITS);
>                  }
>                  /* Advance the wp if needed */
> @@ -2536,14 +2536,14 @@ static int coroutine_fn raw_co_preadv(BlockDriver=
State *bs, int64_t offset,
>                                        int64_t bytes, QEMUIOVector *qiov,
>                                        BdrvRequestFlags flags)
>  {
> -    return raw_co_prw(bs, offset, bytes, qiov, QEMU_AIO_READ);
> +    return raw_co_prw(bs, &offset, bytes, qiov, QEMU_AIO_READ);
>  }
>
>  static int coroutine_fn raw_co_pwritev(BlockDriverState *bs, int64_t off=
set,
>                                         int64_t bytes, QEMUIOVector *qiov=
,
>                                         BdrvRequestFlags flags)
>  {
> -    return raw_co_prw(bs, offset, bytes, qiov, QEMU_AIO_WRITE);
> +    return raw_co_prw(bs, &offset, bytes, qiov, QEMU_AIO_WRITE);
>  }
>
>  static int coroutine_fn raw_co_flush_to_disk(BlockDriverState *bs)
> @@ -3506,8 +3506,6 @@ static int coroutine_fn raw_co_zone_append(BlockDri=
verState *bs,
>      int64_t zone_size_mask =3D bs->bl.zone_size - 1;
>      int64_t iov_len =3D 0;
>      int64_t len =3D 0;
> -    BDRVRawState *s =3D bs->opaque;
> -    s->offset =3D offset;
>
>      if (*offset & zone_size_mask) {
>          error_report("sector offset %" PRId64 " is not aligned to zone s=
ize "
> @@ -3528,7 +3526,7 @@ static int coroutine_fn raw_co_zone_append(BlockDri=
verState *bs,
>      }
>
>      trace_zbd_zone_append(bs, *offset >> BDRV_SECTOR_BITS);
> -    return raw_co_prw(bs, *offset, len, qiov, QEMU_AIO_ZONE_APPEND);
> +    return raw_co_prw(bs, offset, len, qiov, QEMU_AIO_ZONE_APPEND);
>  }
>  #endif
>
> --
> 2.42.0
>

