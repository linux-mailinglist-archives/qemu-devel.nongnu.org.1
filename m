Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 043AF7A3560
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 13:42:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhq90-00058e-9x; Sun, 17 Sep 2023 07:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mike.maslenkin@gmail.com>)
 id 1qhq8r-00057h-T7; Sun, 17 Sep 2023 07:40:45 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mike.maslenkin@gmail.com>)
 id 1qhq8q-00056J-3S; Sun, 17 Sep 2023 07:40:45 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-59c0b9ad491so21238507b3.1; 
 Sun, 17 Sep 2023 04:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694950842; x=1695555642; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WaWxjJR4/oR93XXFsAzWB8yTVlXhFUiFTDV5oBt9SvE=;
 b=PM0kZjwuNMpj6iLjS5OTu9+jjYsWw+P+28WXjzb6qgPNvMdcDeaHhkiaLB252NBZ/x
 /IlFnIrEcKxwRVpMDtlysbDgQTNM+AVJYVV05FOKPTtd+k2CD/OOxcDHP8ykaWs/miZl
 w7XtRVX4K1ltnWMRvvlaJFZ2JWy72Y4RAJC7jkZcG9f+pSejDUp/fUouRNyQpqADWOg/
 ggtCWhLteCGe8bSLs6IumjkTlHmxCqxiPXeekY7SPJXASPGKU/qMoe6Qs+eZ6J1w6Vzr
 JMnJstsNzkxJXd28M8a08hVjtB/G3Cx4vmirnjrBElxoAdJpj4UbKhTOKWBpGlMQTe35
 kkww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694950842; x=1695555642;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WaWxjJR4/oR93XXFsAzWB8yTVlXhFUiFTDV5oBt9SvE=;
 b=d7Cj5M/AxCN8iYDVS/tDgR1qezAcEuX1PQow4TsUSUxGSPtcRzjjc6W4h9FK+e1jHD
 IPy8dpeVOiqmYHv64yUcoras/PcrbVHMtUyYPOwpWVXAoAVas014NfryWiSvcSx32kEx
 7TToeKWSaHmzzYUIlpTa9Cav4Se7AQQRK6fXf173qE2XDVAN8OIhx5Ib7vxberxFIb6z
 TuhD/k/+T4QQQGQEpnBIVkM64eUf5xxBZi1Q7AdrgCVVPPxDKoEDC87z2qihWAoPXq3u
 9Kg8p4/DvxbzDrw6oS65rl2hDwauZDVYOhrLUvBxZQ02Jsp/RH5k+enA1SucwdrIRnxT
 NI5w==
X-Gm-Message-State: AOJu0Yx8mW9tjVXvuqMOjyPLtFIURKWVf4JSNGiyb7miwkGsgrwGsuL2
 1ldEKNwthKVhnlqIuJeLMk1pcxfN3ADnNRQrvCw=
X-Google-Smtp-Source: AGHT+IGRVGrq/3+LrllJh2X7tpd+P7/cJs/eEldkbyENc60Nkfnri3Zg4p1GAwruJ5j8Qu214u/47bkya0eveEOYlxI=
X-Received: by 2002:a81:840f:0:b0:59b:f61d:2e9c with SMTP id
 u15-20020a81840f000000b0059bf61d2e9cmr6588458ywf.15.1694950842005; Sun, 17
 Sep 2023 04:40:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230915184130.403366-1-den@openvz.org>
 <20230915184130.403366-5-den@openvz.org>
In-Reply-To: <20230915184130.403366-5-den@openvz.org>
From: Mike Maslenkin <mike.maslenkin@gmail.com>
Date: Sun, 17 Sep 2023 14:40:06 +0300
Message-ID: <CAL77WPBGUyrLmYLeosKmcDTiifi0j77TqdSQoGrmnC2pPzaxuA@mail.gmail.com>
Subject: Re: [PATCH 03/21] parallels: invent parallels_opts_prealloc() helper
 to parse prealloc opts
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com, 
 alexander.ivanov@virtuozzo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=mike.maslenkin@gmail.com; helo=mail-yw1-x112e.google.com
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

This is not introduced by this patch,
but looks like qemu_opts_del(opts) missed.

On Fri, Sep 15, 2023 at 9:41=E2=80=AFPM Denis V. Lunev <den@openvz.org> wro=
te:
>
> This patch creates above mentioned helper and moves its usage to the
> beginning of parallels_open(). This simplifies parallels_open() a bit.
>
> The patch also ensures that we store prealloc_size on block driver state
> always in sectors. This makes code cleaner and avoids wrong opinion at
> the assignment that the value is in bytes.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>  block/parallels.c | 65 +++++++++++++++++++++++++++--------------------
>  1 file changed, 38 insertions(+), 27 deletions(-)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 428f72de1c..1d5409f2ba 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -1025,6 +1025,38 @@ static int parallels_update_header(BlockDriverStat=
e *bs)
>      return bdrv_pwrite_sync(bs->file, 0, size, s->header, 0);
>  }
>
> +
> +static int parallels_opts_prealloc(BlockDriverState *bs, QDict *options,
> +                                   Error **errp)
> +{
> +    char *buf;
> +    int64_t bytes;
> +    BDRVParallelsState *s =3D bs->opaque;
> +    Error *local_err =3D NULL;
> +    QemuOpts *opts =3D qemu_opts_create(&parallels_runtime_opts, NULL, 0=
, errp);
> +    if (!opts) {
> +        return -ENOMEM;
> +    }
> +
> +    if (!qemu_opts_absorb_qdict(opts, options, errp)) {
> +        return -EINVAL;
> +    }
> +
> +    bytes =3D qemu_opt_get_size_del(opts, PARALLELS_OPT_PREALLOC_SIZE, 0=
);
> +    s->prealloc_size =3D bytes >> BDRV_SECTOR_BITS;

qemu_opt_get_size_del returns uint64_t, so what's a reason to declare
"bytes" variable  as int64_t
and then shift it to the right?  I see here it can not be negative,
but it's a common to use signed values and not to add explicit check
before shifting to right In this file
I takes time to ensure that initial values are not negative.

Regards,
Mike.



> +    buf =3D qemu_opt_get_del(opts, PARALLELS_OPT_PREALLOC_MODE);
> +    /* prealloc_mode can be downgraded later during allocate_clusters */
> +    s->prealloc_mode =3D qapi_enum_parse(&prealloc_mode_lookup, buf,
> +                                       PRL_PREALLOC_MODE_FALLOCATE,
> +                                       &local_err);
> +    g_free(buf);
> +    if (local_err !=3D NULL) {
> +        error_propagate(errp, local_err);
> +        return -EINVAL;
> +    }
> +    return 0;
> +}
> +
>  static int parallels_open(BlockDriverState *bs, QDict *options, int flag=
s,
>                            Error **errp)
>  {
> @@ -1033,11 +1065,13 @@ static int parallels_open(BlockDriverState *bs, Q=
Dict *options, int flags,
>      int ret, size, i;
>      int64_t file_nb_sectors, sector;
>      uint32_t data_start;
> -    QemuOpts *opts =3D NULL;
> -    Error *local_err =3D NULL;
> -    char *buf;
>      bool data_off_is_correct;
>
> +    ret =3D parallels_opts_prealloc(bs, options, errp);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
>      ret =3D bdrv_open_file_child(NULL, options, "file", bs, errp);
>      if (ret < 0) {
>          return ret;
> @@ -1078,6 +1112,7 @@ static int parallels_open(BlockDriverState *bs, QDi=
ct *options, int flags,
>          ret =3D -EFBIG;
>          goto fail;
>      }
> +    s->prealloc_size =3D MAX(s->tracks, s->prealloc_size);
>      s->cluster_size =3D s->tracks << BDRV_SECTOR_BITS;
>
>      s->bat_size =3D le32_to_cpu(ph.bat_entries);
> @@ -1117,29 +1152,6 @@ static int parallels_open(BlockDriverState *bs, QD=
ict *options, int flags,
>          s->header_size =3D size;
>      }
>
> -    opts =3D qemu_opts_create(&parallels_runtime_opts, NULL, 0, errp);
> -    if (!opts) {
> -        goto fail_options;
> -    }
> -
> -    if (!qemu_opts_absorb_qdict(opts, options, errp)) {
> -        goto fail_options;
> -    }
> -
> -    s->prealloc_size =3D
> -        qemu_opt_get_size_del(opts, PARALLELS_OPT_PREALLOC_SIZE, 0);
> -    s->prealloc_size =3D MAX(s->tracks, s->prealloc_size >> BDRV_SECTOR_=
BITS);
> -    buf =3D qemu_opt_get_del(opts, PARALLELS_OPT_PREALLOC_MODE);
> -    /* prealloc_mode can be downgraded later during allocate_clusters */
> -    s->prealloc_mode =3D qapi_enum_parse(&prealloc_mode_lookup, buf,
> -                                       PRL_PREALLOC_MODE_FALLOCATE,
> -                                       &local_err);
> -    g_free(buf);
> -    if (local_err !=3D NULL) {
> -        error_propagate(errp, local_err);
> -        goto fail_options;
> -    }
> -
>      if (ph.ext_off) {
>          if (flags & BDRV_O_RDWR) {
>              /*
> @@ -1214,7 +1226,6 @@ static int parallels_open(BlockDriverState *bs, QDi=
ct *options, int flags,
>
>  fail_format:
>      error_setg(errp, "Image not in Parallels format");
> -fail_options:
>      ret =3D -EINVAL;
>  fail:
>      /*
> --
> 2.34.1
>

