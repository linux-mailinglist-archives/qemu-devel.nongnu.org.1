Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6F77D1C90
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 12:42:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu9Pe-0003tT-9O; Sat, 21 Oct 2023 06:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mike.maslenkin@gmail.com>)
 id 1qu9Pc-0003st-5W; Sat, 21 Oct 2023 06:40:56 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mike.maslenkin@gmail.com>)
 id 1qu9Pa-0006U1-E0; Sat, 21 Oct 2023 06:40:55 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5a7ad24b3aaso17939417b3.2; 
 Sat, 21 Oct 2023 03:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697884850; x=1698489650; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vax6jvyg94k0q9hBh/i6NbA+Wqghm8enlHaYcchqmXA=;
 b=Tf3VYyMULAGb9UZZGxzJLuUDPCeAo5PK1jyIJDR9Zst65eUJ8XAJQk3uV5LCKGkLW/
 m//K720FFGcq8iQJLQO5Hi2gaQkUKl1dFbrF59aN4PSw73ZNzffvsp7bXLRpQd1Cbg/a
 oxSCuwx7aGYRO9WHj0DYYODuVYHcMpEopct2C1kvTMT51m3I7+PAAPGQa+b21oafA1Aq
 3LM27XoSMEGDLaGZ5MVm90z7w5XbWrLpRQ93Fvd+TayeLrmVIgneOBDz7FbYrorYP40e
 ejSp36Q3n35426BC9Ew1jv8nZLjkoI/945/BRb0prtgDABUf8ONfbYxzo5/d+uYfdNzD
 OgfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697884850; x=1698489650;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vax6jvyg94k0q9hBh/i6NbA+Wqghm8enlHaYcchqmXA=;
 b=tljjYbYd8f2UsVocX+Vw4avQ4tPwwReo2nV4JDCBBo6W3AeVsKrqrT3OPHs41YSANy
 JEYENtbN11ryvo0TI4k0giOek26makne0F/824GOow6mG0xoV4OMuImrrHX+wlrQzQQm
 85gVWNHcFbMJ8mDCxU0xQ1AThlSkf0GMuOHmMMlpW5wDa8irlkPLPjW56s3wGulVpjWO
 sPJSuL481iY2jYOyDNXxZhb0p2omwIgzhGDH8T5Zsa+RpiUziJ8mR5JWUGpv3pDaNm2g
 VR/tHzJwQKrnJjX2OEWVE2QEUJGiYGFkLsAW2l1WFaF/6CtNSR2o3cynCqjsDqvSvs5w
 rh7g==
X-Gm-Message-State: AOJu0YyM9gkl8Nzs3rWPaWRvEgY1h48Vks0pthQkC8+m25qiwWTTqheV
 l+SxatcHl8XnIRoxSUBTvEdH7+Bve9yS+CNRvVI=
X-Google-Smtp-Source: AGHT+IH6CV0MREb9RtNCxS2KiznjhcqZ86abLUI8FBL4ohpJVzIpUVwf5VDGsN2GhDGd6vh2WB8pbl0mT3wnKf3FM+0=
X-Received: by 2002:a0d:d613:0:b0:59e:7fc1:dba0 with SMTP id
 y19-20020a0dd613000000b0059e7fc1dba0mr4844409ywd.44.1697884850299; Sat, 21
 Oct 2023 03:40:50 -0700 (PDT)
MIME-Version: 1.0
References: <20231019125854.390385-1-alexander.ivanov@virtuozzo.com>
 <20231019125854.390385-11-alexander.ivanov@virtuozzo.com>
In-Reply-To: <20231019125854.390385-11-alexander.ivanov@virtuozzo.com>
From: Mike Maslenkin <mike.maslenkin@gmail.com>
Date: Sat, 21 Oct 2023 13:40:14 +0300
Message-ID: <CAL77WPA8u84+-QoNHmwMOnaG-g=0natYd-R_Bo_g-suk_ZBupg@mail.gmail.com>
Subject: Re: [PATCH v2 10/20] parallels: Add dirty bitmaps saving
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, den@virtuozzo.com, 
 stefanha@redhat.com, vsementsov@yandex-team.ru, kwolf@redhat.com, 
 hreitz@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=mike.maslenkin@gmail.com; helo=mail-yw1-x112c.google.com
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

On Thu, Oct 19, 2023 at 4:05=E2=80=AFPM Alexander Ivanov
<alexander.ivanov@virtuozzo.com> wrote:
>
> Now dirty bitmaps can be loaded but there is no their saving. Add code fo=
r
> dirty bitmap storage.
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>  block/parallels-ext.c | 167 ++++++++++++++++++++++++++++++++++++++++++
>  block/parallels.c     |  16 +++-
>  block/parallels.h     |   5 ++
>  3 files changed, 186 insertions(+), 2 deletions(-)
>
> diff --git a/block/parallels-ext.c b/block/parallels-ext.c
> index 8a109f005a..0a632a2331 100644
> --- a/block/parallels-ext.c
> +++ b/block/parallels-ext.c
> @@ -24,6 +24,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "qapi/error.h"
>  #include "block/block-io.h"
>  #include "block/block_int.h"
> @@ -301,3 +302,169 @@ out:
>
>      return ret;
>  }
> +
> +static void parallels_save_bitmap(BlockDriverState *bs, BdrvDirtyBitmap =
*bitmap,
> +                                  uint8_t **buf, int *buf_size)
> +{
> +    BDRVParallelsState *s =3D bs->opaque;
> +    ParallelsFeatureHeader *fh;
> +    ParallelsDirtyBitmapFeature *bh;
> +    uint64_t *l1_table, l1_size, granularity, limit;
> +    int64_t bm_size, ser_size, offset, buf_used;
> +    int64_t alloc_size =3D 1;
> +    const char *name;
> +    uint8_t *bm_buf;
> +    QemuUUID uuid;
> +    int ret =3D 0;
> +
> +    if (!bdrv_dirty_bitmap_get_persistence(bitmap) ||
> +        bdrv_dirty_bitmap_inconsistent(bitmap)) {
> +        return;
> +    }
> +
> +    bm_size =3D bdrv_dirty_bitmap_size(bitmap);
> +    granularity =3D bdrv_dirty_bitmap_granularity(bitmap);
> +    limit =3D bdrv_dirty_bitmap_serialization_coverage(s->cluster_size, =
bitmap);
> +    ser_size =3D bdrv_dirty_bitmap_serialization_size(bitmap, 0, bm_size=
);
> +    l1_size =3D DIV_ROUND_UP(ser_size, s->cluster_size);
> +
> +    buf_used =3D l1_size * 8 + sizeof(*fh) + sizeof(*bh);
> +    /* Check if there is enough space for the final section */
> +    if (*buf_size - buf_used < sizeof(*fh)) {
> +        return;
> +    }
> +
> +    name =3D bdrv_dirty_bitmap_name(bitmap);
> +    ret =3D qemu_uuid_parse(name, &uuid);
> +    if (ret < 0) {
> +        error_report("Can't save dirty bitmap: ID parsing error: '%s'", =
name);
> +        return;
> +    }
> +
> +    fh =3D (ParallelsFeatureHeader *)*buf;
> +    bh =3D (ParallelsDirtyBitmapFeature *)(*buf + sizeof(*fh));
> +    l1_table =3D (uint64_t *)((uint8_t *)bh + sizeof(*bh));
> +
> +    fh->magic =3D cpu_to_le64(PARALLELS_DIRTY_BITMAP_FEATURE_MAGIC);
> +    fh->data_size =3D cpu_to_le32(l1_size * 8 + sizeof(*bh));
> +
> +    bh->l1_size =3D cpu_to_le32(l1_size);
> +    bh->size =3D cpu_to_le64(bm_size >> BDRV_SECTOR_BITS);
> +    bh->granularity =3D cpu_to_le32(granularity >> BDRV_SECTOR_BITS);
> +    memcpy(bh->id, &uuid, sizeof(uuid));
> +
> +    bm_buf =3D qemu_blockalign(bs, s->cluster_size);
> +
> +    offset =3D 0;
> +    while ((offset =3D bdrv_dirty_bitmap_next_dirty(bitmap, offset, bm_s=
ize)) >=3D 0) {
> +        uint64_t idx =3D offset / limit;
> +        int64_t cluster_off, end, write_size;
> +
> +        offset =3D QEMU_ALIGN_DOWN(offset, limit);
> +        end =3D MIN(bm_size, offset + limit);
> +        write_size =3D bdrv_dirty_bitmap_serialization_size(bitmap, offs=
et,
> +                                                          end - offset);
> +        assert(write_size <=3D s->cluster_size);
> +
> +        bdrv_dirty_bitmap_serialize_part(bitmap, bm_buf, offset, end - o=
ffset);
> +        if (write_size < s->cluster_size) {
> +            memset(bm_buf + write_size, 0, s->cluster_size - write_size)=
;
> +        }
> +
> +        cluster_off =3D parallels_allocate_host_clusters(bs, &alloc_size=
);
> +        if (cluster_off <=3D 0) {
> +            goto end;
> +        }
> +
> +        ret =3D bdrv_pwrite(bs->file, cluster_off, s->cluster_size, bm_b=
uf, 0);
> +        if (ret < 0) {
> +            memset(&fh->magic, 0, sizeof(fh->magic));
> +            parallels_mark_unused(bs, s->used_bmap, s->used_bmap_size,
> +                                  cluster_off, 1);
> +            goto end;
> +        }
> +
> +        l1_table[idx] =3D cpu_to_le64(cluster_off >> BDRV_SECTOR_BITS);
> +        offset =3D end;
> +    }
> +
> +    *buf_size -=3D buf_used;
> +    *buf +=3D buf_used;
> +
> +end:
> +    qemu_vfree(bm_buf);
> +}
> +
> +void parallels_store_persistent_dirty_bitmaps(BlockDriverState *bs,
> +                                              Error **errp)
> +{
> +    BDRVParallelsState *s =3D bs->opaque;
> +    BdrvDirtyBitmap *bitmap;
> +    ParallelsFormatExtensionHeader *eh;
> +    int remaining =3D s->cluster_size;
> +    uint8_t *buf, *pos;
> +    int64_t header_off, alloc_size =3D 1;
> +    g_autofree uint8_t *hash =3D NULL;
> +    size_t hash_len =3D 0;
> +    int ret;
> +
> +    s->header->ext_off =3D 0;
> +
> +    if (!bdrv_has_named_bitmaps(bs)) {
> +        return;
> +    }
> +
> +    buf =3D qemu_blockalign0(bs, s->cluster_size);
> +
> +    eh =3D (ParallelsFormatExtensionHeader *)buf;
> +    pos =3D buf + sizeof(*eh);
> +
> +    eh->magic =3D cpu_to_le64(PARALLELS_FORMAT_EXTENSION_MAGIC);
> +
> +    FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
> +        parallels_save_bitmap(bs, bitmap, &pos, &remaining);
> +    }
> +
> +    header_off =3D parallels_allocate_host_clusters(bs, &alloc_size);
> +    if (header_off < 0) {
> +        error_report("Can't save dirty bitmap: cluster allocation error"=
);
> +        ret =3D header_off;
> +        goto end;
> +    }
> +
> +    ret =3D qcrypto_hash_bytes(QCRYPTO_HASH_ALG_MD5,
> +                             (const char *)(buf + sizeof(*eh)),
> +                             s->cluster_size - sizeof(*eh),
> +                             &hash, &hash_len, errp);
> +    if (ret < 0 || hash_len !=3D sizeof(eh->check_sum)) {
> +        error_report("Can't save dirty bitmap: hash error");
> +        ret =3D -EINVAL;
> +        goto end;
> +    }
> +    memcpy(eh->check_sum, hash, hash_len);
> +
> +    ret =3D bdrv_pwrite(bs->file, header_off, s->cluster_size, buf, 0);
> +    if (ret < 0) {
> +        error_report("Can't save dirty bitmap: IO error");
> +        parallels_mark_unused(bs, s->used_bmap, s->used_bmap_size,
> +                              header_off, 1);
> +        goto end;
> +    }
> +
> +    s->header->ext_off =3D cpu_to_le64(header_off / BDRV_SECTOR_SIZE);
> +end:
> +    qemu_vfree(buf);
> +}
> +
> +bool coroutine_fn parallels_co_can_store_new_dirty_bitmap(BlockDriverSta=
te *bs,
> +                                                          const char *na=
me,
> +                                                          uint32_t granu=
larity,
> +                                                          Error **errp)
> +{
> +    if (bdrv_find_dirty_bitmap(bs, name)) {
> +        error_setg(errp, "Bitmap already exists: %s", name);
> +        return false;
> +    }
> +
> +    return true;
> +}
> diff --git a/block/parallels.c b/block/parallels.c
> index 2ee2b42038..bb1e765ec8 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -1470,14 +1470,25 @@ fail:
>  static int parallels_inactivate(BlockDriverState *bs)
>  {
>      BDRVParallelsState *s =3D bs->opaque;
> +    Error *err =3D NULL;
>      int ret;
>
> +    parallels_store_persistent_dirty_bitmaps(bs, &err);
> +    if (err !=3D NULL) {
> +        error_reportf_err(err, "Lost persistent bitmaps during "
> +                          "inactivation of node '%s': ",
> +                          bdrv_get_device_or_node_name(bs));
> +    }
> +
>      s->header->inuse =3D 0;
>      parallels_update_header(bs);
>

Recently bdrv_get_device_or_node_name() calls were guarded by
bdrv_graph_rd{,un}lock_main_loop.
There are no annotations for parallels_close() or
parallels_inactivate(), so may be it should be done in the same way?

