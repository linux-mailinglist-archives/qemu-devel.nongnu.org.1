Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8817A355F
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 13:42:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhq9G-0005CX-LX; Sun, 17 Sep 2023 07:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mike.maslenkin@gmail.com>)
 id 1qhq9B-0005BU-Lh; Sun, 17 Sep 2023 07:41:05 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mike.maslenkin@gmail.com>)
 id 1qhq9A-00059v-5A; Sun, 17 Sep 2023 07:41:05 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-59bfb0825efso29633517b3.3; 
 Sun, 17 Sep 2023 04:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694950863; x=1695555663; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GiRyz1eEKZa+Ip9XwnjHPZQ9rkOelHYzafwzVygA0pA=;
 b=Q3tAzUFhURhSten59zqB4RI4wVx4kAv16R095kA6yztsqKtXeBQ9cXZD4SsEg/oTon
 WyBcmxD0UomWsQKLPmm6IWx2rQv6oHeZD0zo2Q7E9LqD71qLMxE+lc3UdXiRkGPmvnH+
 DUK5xMTw9TMKhq5CuURNMCHDYUqnfsA43gt1GSccafjhO9AM/Ffi2UZjmtzEkEa9AQgX
 SCYKHMjz4qXin8S4w8mnlF51uIreDTuIXVRGGWXsp8W7keb8qGo9zrmtSprXIHwQyln0
 mw0Y3SQBIypdrIwkicDe5bCWDvALK/lXdmIryWM4HQiOOyyOLcV06Qd3FIAfIf5X2Oo3
 NGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694950863; x=1695555663;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GiRyz1eEKZa+Ip9XwnjHPZQ9rkOelHYzafwzVygA0pA=;
 b=c1ysMn0xHb2y44mOvMmUQJMeNlE8J3s2Hy7YFSFemVoK4JqlOkvaqjFl6+nMLDo+7g
 I1k8Mc5kor+C//hMWWlyflUq5BnJxNWFp2lcAUig0tNcsFw2DGaHUAZ1pp70srI6AoxP
 kScbHEXtB2Sec+DdBrRw8Oiy7y4WDdALjm6geWpwPRe4R4+flXLFVAVPbc8AJKQ4LReh
 kKJZOCJLFU/hbSyUJ20Zm6zxZHrBUrI/lsZFya8gj6sDAybSdfL/B2p/yMPa2FCBJOTe
 IjBGhxTz/8YfHn4oUsUonEE5O9ewCiAjq5JIOqakqCVjiMi6k8VDH4xCHINB0oaDfhL+
 Sy8Q==
X-Gm-Message-State: AOJu0YxJT5Obpc6Fu0/RmRN8yh/9givkAs10oSCOpcJM9xRvqfPYZTxd
 RXRXUKtw/YAIsAtOeTrYdXwZOy+1NxwzmDl3xsE=
X-Google-Smtp-Source: AGHT+IHXZlcsSpFBuMbxGrrf6IalK1yEFDrhmHF6MsAKs64hfYO9hxuO+oGbUl7Zva/YctJg+qkz144p+PzdBGX2uEc=
X-Received: by 2002:a0d:d993:0:b0:59b:e658:ee67 with SMTP id
 b141-20020a0dd993000000b0059be658ee67mr6811790ywe.1.1694950862928; Sun, 17
 Sep 2023 04:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230915184130.403366-1-den@openvz.org>
 <20230915184130.403366-21-den@openvz.org>
In-Reply-To: <20230915184130.403366-21-den@openvz.org>
From: Mike Maslenkin <mike.maslenkin@gmail.com>
Date: Sun, 17 Sep 2023 14:40:27 +0300
Message-ID: <CAL77WPBGZT5re+8ZOY1ymb9wqivUBAnM5AgANSO4My9+SOO7aQ@mail.gmail.com>
Subject: Re: [PATCH 18/21] parallels: naive implementation of
 parallels_co_pdiscard
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com, 
 alexander.ivanov@virtuozzo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=mike.maslenkin@gmail.com; helo=mail-yw1-x1133.google.com
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

I got a warning after this patch:

../block/parallels.c:541:25: warning: 'guarded_by' attribute only
applies to non-static data members and global variables
[-Wignored-attributes]
static int coroutine_fn GRAPH_RDLOCK_PTR
                        ^
/Users/mg/sources/qemu/include/block/graph-lock.h:85:26: note:
expanded from macro 'GRAPH_RDLOCK_PTR'
#define GRAPH_RDLOCK_PTR TSA_GUARDED_BY(graph_lock)
                         ^
/Users/mg/sources/qemu/include/qemu/clang-tsa.h:48:31: note: expanded
from macro 'TSA_GUARDED_BY'
#define TSA_GUARDED_BY(x) TSA(guarded_by(x))

Regards,
Mike.


On Fri, Sep 15, 2023 at 9:42=E2=80=AFPM Denis V. Lunev <den@openvz.org> wro=
te:
>
> * Discarding with backing stores is not supported by the format.
> * There is no buffering/queueing of the discard operation.
> * Only operations aligned to the cluster are supported.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>  block/parallels.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 76aedfd7c4..83cb8d6722 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -537,6 +537,52 @@ parallels_co_readv(BlockDriverState *bs, int64_t sec=
tor_num, int nb_sectors,
>      return ret;
>  }
>
> +
> +static int coroutine_fn GRAPH_RDLOCK_PTR
> +parallels_co_pdiscard(BlockDriverState *bs, int64_t offset, int64_t byte=
s)
> +{
> +    int ret =3D 0;
> +    uint32_t cluster, count;
> +    BDRVParallelsState *s =3D bs->opaque;
> +
> +    /*
> +     * The image does not support ZERO mark inside the BAT, which means =
that
> +     * stale data could be exposed from the backing file.
> +     */
> +    if (bs->backing) {
> +        return -ENOTSUP;
> +    }
> +
> +    if (!QEMU_IS_ALIGNED(offset, s->cluster_size)) {
> +        return -ENOTSUP;
> +    } else if (!QEMU_IS_ALIGNED(bytes, s->cluster_size)) {
> +        return -ENOTSUP;
> +    }
> +
> +    cluster =3D offset / s->cluster_size;
> +    count =3D bytes / s->cluster_size;
> +
> +    qemu_co_mutex_lock(&s->lock);
> +    for (; count > 0; cluster++, count--) {
> +        int64_t host_off =3D bat2sect(s, cluster) << BDRV_SECTOR_BITS;
> +        if (host_off =3D=3D 0) {
> +            continue;
> +        }
> +
> +        ret =3D bdrv_co_pdiscard(bs->file, cluster * s->cluster_size,
> +                               s->cluster_size);
> +        if (ret < 0) {
> +            goto done;
> +        }
> +
> +        parallels_set_bat_entry(s, cluster, 0);
> +        bitmap_clear(s->used_bmap, host_cluster_index(s, host_off), 1);
> +    }
> +done:
> +    qemu_co_mutex_unlock(&s->lock);
> +    return ret;
> +}
> +
>  static void parallels_check_unclean(BlockDriverState *bs,
>                                      BdrvCheckResult *res,
>                                      BdrvCheckMode fix)
> @@ -1409,6 +1455,7 @@ static BlockDriver bdrv_parallels =3D {
>      .bdrv_co_create             =3D parallels_co_create,
>      .bdrv_co_create_opts        =3D parallels_co_create_opts,
>      .bdrv_co_check              =3D parallels_co_check,
> +    .bdrv_co_pdiscard           =3D parallels_co_pdiscard,
>  };
>
>  static void bdrv_parallels_init(void)
> --
> 2.34.1
>

