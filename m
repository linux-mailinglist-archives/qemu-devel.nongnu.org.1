Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7096E879C0B
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Mar 2024 20:04:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk7OD-0002gt-5T; Tue, 12 Mar 2024 15:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rk7O7-0002g7-51
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 15:02:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rk7O3-0005G1-GT
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 15:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710270126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vjQ1ZwMA1z8vagbWOKf0A0WFi91LafA3CP1q+6Xq9xk=;
 b=dTmbOdvpjVVGp7zij8seS67VSG5kHGhHi4ga4KuW5bXsAyUoKU/K92rdtWMApPj3diNwvs
 DAf2EkpvCzOX0kRFK2A2U0p59w1zkQfLrIQ4S9qTcGJfosvkIymvaiU5nhNWH7YkPjLfKa
 Y1oIqwHlXtW+wrKxdCdGH21eGph+VEE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-pkSXOiSPNXioRvMxpSqlfw-1; Tue, 12 Mar 2024 15:02:02 -0400
X-MC-Unique: pkSXOiSPNXioRvMxpSqlfw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 557FF84B0C3;
 Tue, 12 Mar 2024 19:02:02 +0000 (UTC)
Received: from localhost (unknown [10.39.192.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3BB2F1121306;
 Tue, 12 Mar 2024 19:02:01 +0000 (UTC)
Date: Tue, 12 Mar 2024 14:30:10 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, dlemoal@kernel.org,
 Hanna Reitz <hreitz@redhat.com>, dmitry.fomichev@wdc.com,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, hare@suse.de,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v7 3/4] qcow2: add zoned emulation capability
Message-ID: <20240312183010.GB389553@fedora>
References: <20240122184830.40094-1-faithilikerun@gmail.com>
 <20240122184830.40094-4-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="is5OYHNShkDwiSMv"
Content-Disposition: inline
In-Reply-To: <20240122184830.40094-4-faithilikerun@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


--is5OYHNShkDwiSMv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 07:48:29PM +0100, Sam Li wrote:
> By adding zone operations and zoned metadata, the zoned emulation
> capability enables full emulation support of zoned device using
> a qcow2 file. The zoned device metadata includes zone type,
> zoned device state and write pointer of each zone, which is stored
> to an array of unsigned integers.
>=20
> Each zone of a zoned device makes state transitions following
> the zone state machine. The zone state machine mainly describes
> five states, IMPLICIT OPEN, EXPLICIT OPEN, FULL, EMPTY and CLOSED.
> READ ONLY and OFFLINE states will generally be affected by device
> internal events. The operations on zones cause corresponding state
> changing.
>=20
> Zoned devices have a limit on zone resources, which puts constraints on
> write operations into zones. It is managed by active zone lists
> following LRU policy.
>=20
> Signed-off-by: Sam Li <faithilikerun@gmail.com>
> ---
>  block/qcow2.c        | 791 ++++++++++++++++++++++++++++++++++++++++++-
>  block/trace-events   |   2 +
>  include/qemu/queue.h |   1 +
>  3 files changed, 792 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index b987f1e751..db28585b82 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -195,6 +195,274 @@ qcow2_extract_crypto_opts(QemuOpts *opts, const cha=
r *fmt, Error **errp)
>      return cryptoopts_qdict;
>  }
> =20
> +#define QCOW2_ZT_IS_CONV(wp)    (wp & 1ULL << 59)
> +
> +/*
> + * To emulate a real zoned device, closed, empty and full states are
> + * preserved after a power cycle. The open states are in-memory and will
> + * be lost after closing the device. Read-only and offline states are
> + * device-internal events, which are not considered for simplicity.
> + */
> +static inline BlockZoneState qcow2_get_zone_state(BlockDriverState *bs,
> +                                                  uint32_t index)
> +{
> +    BDRVQcow2State *s =3D bs->opaque;
> +    Qcow2ZoneListEntry *zone_entry =3D &s->zone_list_entries[index];
> +    uint64_t zone_wp =3D bs->wps->wp[index];
> +    uint64_t zone_start;
> +
> +    if (QCOW2_ZT_IS_CONV(zone_wp)) {
> +        return BLK_ZS_NOT_WP;
> +    }
> +
> +    if (QLIST_IS_INSERTED(zone_entry, exp_open_zone_entry)) {
> +        return BLK_ZS_EOPEN;
> +    }
> +    if (QLIST_IS_INSERTED(zone_entry, imp_open_zone_entry)) {
> +        return BLK_ZS_IOPEN;
> +    }
> +
> +    zone_start =3D index * bs->bl.zone_size;
> +    if (zone_wp =3D=3D zone_start) {
> +        return BLK_ZS_EMPTY;
> +    }
> +    if (zone_wp >=3D zone_start + bs->bl.zone_capacity) {
> +        return BLK_ZS_FULL;
> +    }
> +    if (zone_wp > zone_start) {
> +        if (!QLIST_IS_INSERTED(zone_entry, closed_zone_entry)) {
> +            /*
> +             * The number of closed zones is not always updated in time =
when
> +             * the device is closed. However, it only matters when doing
> +             * zone report. Refresh the count and list of closed zones to
> +             * provide correct zone states for zone report.
> +             */
> +            QLIST_INSERT_HEAD(&s->closed_zones, zone_entry, closed_zone_=
entry);
> +            s->nr_zones_closed++;
> +        }
> +        return BLK_ZS_CLOSED;
> +    }
> +    return BLK_ZS_NOT_WP;
> +}
> +
> +static void qcow2_rm_exp_open_zone(BDRVQcow2State *s,
> +                                   uint32_t index)
> +{
> +    Qcow2ZoneListEntry *zone_entry =3D &s->zone_list_entries[index];
> +
> +    QLIST_REMOVE(zone_entry, exp_open_zone_entry);
> +    s->nr_zones_exp_open--;
> +}
> +
> +static void qcow2_rm_imp_open_zone(BDRVQcow2State *s,
> +                                   int32_t index)
> +{
> +    Qcow2ZoneListEntry *zone_entry;
> +    if (index < 0) {
> +        /* Apply LRU when the index is not specified. */
> +        zone_entry =3D QLIST_LAST(&s->imp_open_zones, imp_open_zone_entr=
y);
> +    } else {
> +        zone_entry =3D &s->zone_list_entries[index];
> +    }
> +
> +    QLIST_REMOVE(zone_entry, imp_open_zone_entry);
> +    s->nr_zones_imp_open--;
> +}
> +
> +static void qcow2_rm_open_zone(BDRVQcow2State *s,
> +                               uint32_t index)
> +{
> +    Qcow2ZoneListEntry *zone_entry =3D &s->zone_list_entries[index];
> +
> +    if (QLIST_IS_INSERTED(zone_entry, exp_open_zone_entry)) {
> +        qcow2_rm_exp_open_zone(s, index);
> +    } else if (QLIST_IS_INSERTED(zone_entry, imp_open_zone_entry)) {
> +        qcow2_rm_imp_open_zone(s, index);
> +    }
> +}
> +
> +static void qcow2_rm_closed_zone(BDRVQcow2State *s,
> +                                 uint32_t index)
> +{
> +    Qcow2ZoneListEntry *zone_entry =3D &s->zone_list_entries[index];
> +
> +    QLIST_REMOVE(zone_entry, closed_zone_entry);
> +    s->nr_zones_closed--;
> +}
> +
> +static void qcow2_do_imp_open_zone(BDRVQcow2State *s,
> +                                   uint32_t index,
> +                                   BlockZoneState zs)
> +{
> +    Qcow2ZoneListEntry *zone_entry =3D &s->zone_list_entries[index];
> +
> +    switch (zs) {
> +    case BLK_ZS_EMPTY:
> +        break;
> +    case BLK_ZS_CLOSED:
> +        s->nr_zones_closed--;
> +        break;

Does the zone entry need to be removed from the closed zone list? If
yes, then qcow2_rm_closed_zone() could be called here instead of
decrementing nr_zones_closed ourselves.

> +    case BLK_ZS_IOPEN:
> +        /*
> +         * The LRU policy: update the zone that is most recently
> +         * used to the head of the zone list
> +         */
> +        if (zone_entry =3D=3D QLIST_FIRST(&s->imp_open_zones)) {
> +            return;
> +        }
> +        QLIST_REMOVE(zone_entry, imp_open_zone_entry);
> +        s->nr_zones_imp_open--;
> +        break;
> +    default:
> +        return;
> +    }
> +
> +    QLIST_INSERT_HEAD(&s->imp_open_zones, zone_entry, imp_open_zone_entr=
y);
> +    s->nr_zones_imp_open++;
> +}
> +
> +static void qcow2_do_exp_open_zone(BDRVQcow2State *s,
> +                                   uint32_t index)
> +{
> +    Qcow2ZoneListEntry *zone_entry =3D &s->zone_list_entries[index];
> +
> +    QLIST_INSERT_HEAD(&s->exp_open_zones, zone_entry, exp_open_zone_entr=
y);
> +    s->nr_zones_exp_open++;
> +}
> +
> +/*
> + * The list of zones is managed using an LRU policy: the last
> + * zone of the list is always the one that was least recently used
> + * for writing and is chosen as the zone to close to be able to
> + * implicitly open another zone.
> + *
> + * We can only close the open zones. The index is not specified
> + * when it is less than 0.
> + */
> +static void qcow2_do_close_zone(BlockDriverState *bs,
> +                                int32_t index,
> +                                BlockZoneState zs)
> +{
> +    BDRVQcow2State *s =3D bs->opaque;
> +    Qcow2ZoneListEntry *zone_entry;
> +
> +    if (index < 0 && zs =3D=3D BLK_ZS_IOPEN) {
> +        /* before removal of the last implicitly open zone */
> +        zone_entry =3D QLIST_LAST(&s->imp_open_zones, imp_open_zone_entr=
y);
> +        qcow2_rm_imp_open_zone(s, index);
> +        goto close_zone;
> +    }
> +
> +    if (index >=3D 0 && zs =3D=3D BLK_ZS_EOPEN) {
> +        zone_entry =3D &s->zone_list_entries[index];
> +        qcow2_rm_exp_open_zone(s, index);
> +        /*
> +         * The zone state changes when the zone is removed from the list=
 of
> +         * open zones (explicitly open -> empty)
> +         */
> +        qcow2_get_zone_state(bs, index);
> +    }
> +    return;
> +
> +close_zone:
> +    QLIST_INSERT_HEAD(&s->closed_zones, zone_entry, closed_zone_entry);
> +    s->nr_zones_closed++;
> +}
> +
> +/*
> + * Write the new wp value to the dedicated location of the image file.
> + */
> +static int coroutine_fn GRAPH_RDLOCK
> +qcow2_write_wp_at(BlockDriverState *bs, uint64_t *wp,
> +                             int32_t index) {
> +    BDRVQcow2State *s =3D bs->opaque;
> +    uint64_t wpv =3D *wp;
> +    int ret;
> +
> +    ret =3D bdrv_pwrite(bs->file, s->zoned_header.zonedmeta_offset
> +        + sizeof(uint64_t) * index, sizeof(uint64_t), wp, 0);
> +    if (ret < 0) {
> +        goto exit;
> +    }
> +    trace_qcow2_wp_tracking(index, *wp >> BDRV_SECTOR_BITS);
> +    return ret;
> +
> +exit:
> +    *wp =3D wpv;
> +    error_report("Failed to write metadata with file");
> +    return ret;
> +}
> +
> +static bool qcow2_can_activate_zone(BlockDriverState *bs)
> +{
> +    BDRVQcow2State *s =3D bs->opaque;
> +
> +    /* When the max active zone is zero, there is no limit on active zon=
es */
> +    if (!s->zoned_header.max_active_zones) {
> +        return true;
> +    }
> +
> +    /* Active zones are zones that are open or closed */
> +    return s->nr_zones_exp_open + s->nr_zones_imp_open + s->nr_zones_clo=
sed
> +        < s->zoned_header.max_active_zones;
> +}
> +
> +/*
> + * This function manages open zones under active zones limit. It checks
> + * if a zone can transition to open state while maintaining max open and
> + * active zone limits.
> + */
> +static bool qcow2_can_open_zone(BlockDriverState *bs)
> +{
> +    BDRVQcow2State *s =3D bs->opaque;
> +
> +    /* When the max open zone is zero, there is no limit on open zones */
> +    if (!s->zoned_header.max_open_zones) {
> +        return true;
> +    }
> +
> +    /*
> +     * The open zones are zones with the states of explicitly and
> +     * implicitly open.
> +     */
> +    if (s->nr_zones_imp_open + s->nr_zones_exp_open <
> +        s->zoned_header.max_open_zones) {
> +        return true;
> +    }
> +
> +    /*
> +     * Zones are managed one at a time. Thus, the number of implicitly o=
pen
> +     * zone can never be over the open zone limit. When the active zone =
limit
> +     * is not reached, close only one implicitly open zone.
> +     */
> +    if (qcow2_can_activate_zone(bs)) {
> +        qcow2_do_close_zone(bs, -1, BLK_ZS_IOPEN);
> +        trace_qcow2_imp_open_zones(0x23, s->nr_zones_imp_open);
> +        return true;
> +    }
> +    return false;
> +}
> +
> +static inline int coroutine_fn GRAPH_RDLOCK
> +qcow2_refresh_zonedmeta(BlockDriverState *bs)
> +{
> +    int ret;
> +    BDRVQcow2State *s =3D bs->opaque;
> +    uint64_t wps_size =3D s->zoned_header.zonedmeta_size;
> +    g_autofree uint64_t *temp;
> +
> +    temp =3D g_new(uint64_t, wps_size);
> +    ret =3D bdrv_pread(bs->file, s->zoned_header.zonedmeta_offset,
> +                     wps_size, temp, 0);
> +    if (ret < 0) {
> +        error_report("Can not read metadata");
> +        return ret;
> +    }
> +
> +    memcpy(bs->wps->wp, temp, wps_size);
> +    return 0;
> +}
> +
>  /*
>   * Passing by the zoned device configurations by a zoned_header struct, =
check
>   * if the zone device options are under constraints. Return false when s=
ome
> @@ -521,7 +789,23 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_t=
 start_offset,
>                  be32_to_cpu(zoned_ext.max_active_zones);
>              zoned_ext.max_append_bytes =3D
>                  be32_to_cpu(zoned_ext.max_append_bytes);
> +            zoned_ext.zonedmeta_offset =3D
> +                be64_to_cpu(zoned_ext.zonedmeta_offset);
> +            zoned_ext.zonedmeta_size =3D be64_to_cpu(zoned_ext.zonedmeta=
_size);
>              s->zoned_header =3D zoned_ext;
> +            bs->wps =3D g_malloc(sizeof(BlockZoneWps)
> +                + s->zoned_header.zonedmeta_size);
> +            ret =3D qcow2_refresh_zonedmeta(bs);
> +            if (ret < 0) {
> +                return ret;
> +            }
> +
> +            s->zone_list_entries =3D g_new0(Qcow2ZoneListEntry,
> +                                          zoned_ext.nr_zones);
> +            QLIST_INIT(&s->exp_open_zones);
> +            QLIST_INIT(&s->imp_open_zones);
> +            QLIST_INIT(&s->closed_zones);
> +            qemu_co_mutex_init(&bs->wps->colock);
> =20
>              /* refuse to open broken images */
>              if (zoned_ext.nr_zones !=3D DIV_ROUND_UP(bs->total_sectors *
> @@ -2789,9 +3073,68 @@ qcow2_co_pwritev_part(BlockDriverState *bs, int64_=
t offset, int64_t bytes,
>      uint64_t host_offset;
>      QCowL2Meta *l2meta =3D NULL;
>      AioTaskPool *aio =3D NULL;
> +    int64_t start_offset, start_bytes;
> +    BlockZoneState zs;
> +    int64_t end_zone, end_offset;
> +    uint64_t *wp;
> +    int64_t zone_size =3D bs->bl.zone_size;
> +    int64_t zone_capacity =3D bs->bl.zone_capacity;
> +    int index;
> =20
>      trace_qcow2_writev_start_req(qemu_coroutine_self(), offset, bytes);
> =20
> +    start_offset =3D offset;
> +    start_bytes =3D bytes;
> +    end_offset =3D start_offset + start_bytes;
> +    if (bs->bl.zoned =3D=3D BLK_Z_HM) {
> +        index =3D start_offset / zone_size;
> +        wp =3D &bs->wps->wp[index];

This function must be thread-safe. The write pointer probably needs to
be protected by bs->wps->colock because we are checking and modifying
it.

> +        if (!QCOW2_ZT_IS_CONV(*wp)) {
> +            /* The write offset must be equal to the zone write pointer =
*/
> +            if (offset !=3D *wp) {
> +                return -EINVAL;
> +            }
> +
> +            /* Only allow writes when there are zone resources left */
> +            zs =3D qcow2_get_zone_state(bs, index);
> +            if (zs =3D=3D BLK_ZS_CLOSED || zs =3D=3D BLK_ZS_EMPTY) {
> +                if (!qcow2_can_open_zone(bs)) {
> +                    return -EINVAL;
> +                }
> +            }
> +
> +            /*
> +             * Align up (start_offset, zone_size), the start offset is n=
ot
> +             * necessarily power of two.
> +             */
> +            end_zone =3D index * zone_size + zone_capacity;
> +            /* Write cannot exceed the zone capacity. */
> +            if (end_offset > end_zone) {
> +                return -EINVAL;
> +            }
> +
> +            /*
> +             * Real drives change states before it can write to the zone=
=2E If
> +             * the write fails, the zone state may have changed.
> +             *
> +             * The zone state transitions to implicit open when the orig=
inal
> +             * state is empty or closed. When the wp reaches the end, the
> +             * open states (explicit open, implicit open) become full.
> +             */
> +            zs =3D qcow2_get_zone_state(bs, index);
> +            if (!(end_offset & (zone_capacity - 1))) {
> +                /* Being aligned to zone capacity implies full state */
> +                qcow2_rm_open_zone(s, index);
> +                trace_qcow2_imp_open_zones(0x24,
> +                                           s->nr_zones_imp_open);
> +            } else {
> +                qcow2_do_imp_open_zone(s, index, zs);
> +                trace_qcow2_imp_open_zones(0x24,
> +                                           s->nr_zones_imp_open);
> +            }
> +        }
> +    }
> +
>      while (bytes !=3D 0 && aio_task_pool_status(aio) =3D=3D 0) {
> =20
>          l2meta =3D NULL;
> @@ -2837,6 +3180,19 @@ qcow2_co_pwritev_part(BlockDriverState *bs, int64_=
t offset, int64_t bytes,
>          qiov_offset +=3D cur_bytes;
>          trace_qcow2_writev_done_part(qemu_coroutine_self(), cur_bytes);
>      }
> +
> +    if (bs->bl.zoned =3D=3D BLK_Z_HM) {
> +        index =3D start_offset / zone_size;
> +        wp =3D &bs->wps->wp[index];
> +        if (!QCOW2_ZT_IS_CONV(*wp)) {
> +            /* Advance the write pointer when the write completes */

Updating the write pointer after I/O does not prevent other write
requests from beginning at the same offset as this request. Multiple
write request coroutines can run concurrently and only the first one
should succeed. The others should fail if they are using the same
offset.

The comment above says "Real drives change states before it can write to
the zone" and I think it's appropriate to update the write pointer
before performing the write too. The qcow2 zone emulation code is
different from the file-posix.c passthrough code. We are responsible for
maintaining zoned metadata state and cannot wait for the result of the
I/O to tell us what happened.

> +            *wp =3D end_offset;
> +            ret =3D qcow2_write_wp_at(bs, wp, index);
> +            if (ret < 0) {
> +                goto fail_nometa;
> +            }
> +        }
> +    }
>      ret =3D 0;
> =20
>      qemu_co_mutex_lock(&s->lock);
> @@ -2895,6 +3251,25 @@ static int GRAPH_RDLOCK qcow2_inactivate(BlockDriv=
erState *bs)
>      return result;
>  }
> =20
> +static void qcow2_do_close_all_zone(BDRVQcow2State *s)
> +{
> +    Qcow2ZoneListEntry *zone_entry, *next;
> +
> +    QLIST_FOREACH_SAFE(zone_entry, &s->imp_open_zones, imp_open_zone_ent=
ry,
> +                       next) {
> +        QLIST_REMOVE(zone_entry, imp_open_zone_entry);
> +        s->nr_zones_imp_open--;
> +    }
> +
> +    QLIST_FOREACH_SAFE(zone_entry, &s->exp_open_zones, exp_open_zone_ent=
ry,
> +                       next) {
> +        QLIST_REMOVE(zone_entry, exp_open_zone_entry);
> +        s->nr_zones_exp_open--;
> +    }
> +
> +    assert(s->nr_zones_imp_open + s->nr_zones_exp_open =3D=3D 0);
> +}
> +
>  static void coroutine_mixed_fn GRAPH_RDLOCK
>  qcow2_do_close(BlockDriverState *bs, bool close_data_file)
>  {
> @@ -2934,6 +3309,8 @@ qcow2_do_close(BlockDriverState *bs, bool close_dat=
a_file)
> =20
>      qcow2_refcount_close(bs);
>      qcow2_free_snapshots(bs);
> +    qcow2_do_close_all_zone(s);
> +    g_free(bs->wps);
>  }
> =20
>  static void GRAPH_UNLOCKED qcow2_close(BlockDriverState *bs)
> @@ -3248,7 +3625,10 @@ int qcow2_update_header(BlockDriverState *bs)
>              .max_active_zones   =3D
>                  cpu_to_be32(s->zoned_header.max_active_zones),
>              .max_append_bytes =3D
> -                cpu_to_be32(s->zoned_header.max_append_bytes)
> +                cpu_to_be32(s->zoned_header.max_append_bytes),
> +            .zonedmeta_offset   =3D
> +                cpu_to_be64(s->zoned_header.zonedmeta_offset),
> +            .zonedmeta_size     =3D cpu_to_be64(s->zoned_header.zonedmet=
a_size),
>          };
>          ret =3D header_ext_add(buf, QCOW2_EXT_MAGIC_ZONED_FORMAT,
>                               &zoned_header, sizeof(zoned_header),
> @@ -3656,7 +4036,8 @@ qcow2_co_create(BlockdevCreateOptions *create_optio=
ns, Error **errp)
>      int version;
>      int refcount_order;
>      uint64_t *refcount_table;
> -    int ret;
> +    uint64_t zoned_meta_size, zoned_clusterlen;
> +    int ret, offset, i;
>      uint8_t compression_type =3D QCOW2_COMPRESSION_TYPE_ZLIB;
> =20
>      assert(create_options->driver =3D=3D BLOCKDEV_DRIVER_QCOW2);
> @@ -3997,6 +4378,46 @@ qcow2_co_create(BlockdevCreateOptions *create_opti=
ons, Error **errp)
>              ret =3D -EINVAL;
>              goto unlock;
>          }
> +
> +        uint32_t nrz =3D s->zoned_header.nr_zones;
> +        zoned_meta_size =3D  sizeof(uint64_t) * nrz;
> +        g_autofree uint64_t *meta =3D NULL;
> +        meta =3D g_new0(uint64_t, nrz);
> +
> +        for (i =3D 0; i < s->zoned_header.conventional_zones; ++i) {

Is it necessary to store conventional_zones in the header? This option
is only used during image creation time.

> +            meta[i] =3D i * s->zoned_header.zone_size;
> +            meta[i] |=3D 1ULL << 59;
> +        }
> +
> +        for (; i < nrz; ++i) {
> +            meta[i] =3D i * s->zoned_header.zone_size;
> +        }
> +
> +        offset =3D qcow2_alloc_clusters(blk_bs(blk), zoned_meta_size);
> +        if (offset < 0) {
> +            error_setg_errno(errp, -offset, "Could not allocate clusters=
 "
> +                                            "for zoned metadata size");

Missing:
ret =3D offset;

> +            goto unlock;
> +        }
> +        s->zoned_header.zonedmeta_offset =3D offset;
> +        s->zoned_header.zonedmeta_size =3D zoned_meta_size;
> +
> +        zoned_clusterlen =3D size_to_clusters(s, zoned_meta_size)
> +                * s->cluster_size;
> +        assert(qcow2_pre_write_overlap_check(bs, 0, offset,
> +                                             zoned_clusterlen,false) =3D=
=3D 0);
> +        ret =3D bdrv_pwrite_zeroes(blk_bs(blk)->file, offset,
> +                                 zoned_clusterlen, 0);

I don't think it's necessary to zero zonedmeta since it's about to be
overwritten. There may be some padding until the end of the last
cluster, but there is no need to zero it.

> +        if (ret < 0) {
> +            error_setg_errno(errp, -ret, "Could not zero fill zoned meta=
data");
> +            goto unlock;
> +        }
> +        ret =3D bdrv_pwrite(blk_bs(blk)->file, offset, zoned_meta_size, =
meta, 0);
> +        if (ret < 0) {
> +            error_setg_errno(errp, -ret, "Could not write zoned metadata=
 "
> +                                         "to disk");
> +            goto unlock;
> +        }
>      } else {
>          s->zoned_header.zoned =3D BLK_Z_NONE;
>      }
> @@ -4339,6 +4760,368 @@ qcow2_co_pdiscard(BlockDriverState *bs, int64_t o=
ffset, int64_t bytes)
>      return ret;
>  }
> =20
> +static int coroutine_fn
> +qcow2_co_zone_report(BlockDriverState *bs, int64_t offset,
> +                     unsigned int *nr_zones, BlockZoneDescriptor *zones)
> +{
> +    BDRVQcow2State *s =3D bs->opaque;
> +    uint64_t zone_size =3D s->zoned_header.zone_size;
> +    int64_t capacity =3D bs->total_sectors << BDRV_SECTOR_BITS;
> +    int64_t size =3D bs->bl.nr_zones * zone_size;
> +    unsigned int nrz;
> +    int i =3D 0;
> +    int si;
> +
> +    if (offset >=3D capacity) {
> +        error_report("offset %" PRId64 " is equal to or greater than the=
 "
> +                     "device capacity %" PRId64 "", offset, capacity);
> +        return -EINVAL;
> +    }
> +
> +    nrz =3D ((*nr_zones) < bs->bl.nr_zones) ? (*nr_zones) : bs->bl.nr_zo=
nes;
> +    si =3D offset / zone_size; /* Zone size cannot be 0 for zoned device=
 */
> +    qemu_co_mutex_lock(&bs->wps->colock);
> +    for (; i < nrz; ++i) {
> +        if (i + si >=3D bs->bl.nr_zones) {
> +            break;
> +        }
> +
> +        zones[i].start =3D (si + i) * zone_size;
> +
> +        /* The last zone can be smaller than the zone size */
> +        if ((si + i + 1) =3D=3D bs->bl.nr_zones && size > capacity) {
> +            uint32_t l =3D zone_size - (size - capacity);
> +            zones[i].length =3D l;
> +            zones[i].cap =3D l;
> +        } else {
> +            zones[i].length =3D zone_size;
> +            zones[i].cap =3D zone_size;
> +        }
> +
> +        uint64_t wp =3D bs->wps->wp[si + i];
> +        if (QCOW2_ZT_IS_CONV(wp)) {
> +            zones[i].type =3D BLK_ZT_CONV;
> +            zones[i].state =3D BLK_ZS_NOT_WP;
> +            /* Clear the zone type bit */
> +            wp &=3D ~(1ULL << 59);
> +        } else {
> +            zones[i].type =3D BLK_ZT_SWR;
> +            zones[i].state =3D qcow2_get_zone_state(bs, si + i);
> +        }
> +        zones[i].wp =3D wp;
> +    }
> +    qemu_co_mutex_unlock(&bs->wps->colock);
> +    *nr_zones =3D i;
> +    return 0;
> +}
> +
> +static int coroutine_fn GRAPH_RDLOCK
> +qcow2_open_zone(BlockDriverState *bs, uint32_t index) {
> +    BDRVQcow2State *s =3D bs->opaque;
> +    int ret;
> +
> +    qemu_co_mutex_lock(&bs->wps->colock);
> +    BlockZoneState zs =3D qcow2_get_zone_state(bs, index);
> +    trace_qcow2_imp_open_zones(BLK_ZO_OPEN, s->nr_zones_imp_open);
> +
> +    switch(zs) {
> +    case BLK_ZS_EMPTY:
> +        if (!qcow2_can_activate_zone(bs)) {
> +            ret =3D -EBUSY;
> +            goto unlock;
> +        }
> +        break;
> +    case BLK_ZS_IOPEN:
> +        qcow2_rm_imp_open_zone(s, index);
> +        break;
> +    case BLK_ZS_EOPEN:
> +        return 0;
> +    case BLK_ZS_CLOSED:
> +        if (!qcow2_can_open_zone(bs)) {
> +            ret =3D -EINVAL;
> +            goto unlock;
> +        }
> +        s->nr_zones_closed--;

Does the zone entry need to be removed from the closed zone list?

> +        break;
> +    case BLK_ZS_FULL:
> +        break;
> +    default:
> +        ret =3D -EINVAL;
> +        goto unlock;
> +    }
> +
> +    qcow2_do_exp_open_zone(s, index);
> +    ret =3D 0;
> +
> +unlock:
> +    qemu_co_mutex_unlock(&bs->wps->colock);
> +    return ret;
> +}
> +
> +static int qcow2_close_zone(BlockDriverState *bs, uint32_t index) {
> +    int ret;
> +
> +    qemu_co_mutex_lock(&bs->wps->colock);
> +    BlockZoneState zs =3D qcow2_get_zone_state(bs, index);
> +
> +    switch(zs) {
> +    case BLK_ZS_EMPTY:
> +        break;
> +    case BLK_ZS_IOPEN:
> +        break;
> +    case BLK_ZS_EOPEN:
> +        break;
> +    case BLK_ZS_CLOSED:
> +        /* Closing a closed zone is not an error */
> +        ret =3D 0;
> +        goto unlock;
> +    case BLK_ZS_FULL:
> +        break;
> +    default:
> +        ret =3D -EINVAL;
> +        goto unlock;
> +    }
> +    qcow2_do_close_zone(bs, index, zs);
> +    ret =3D 0;
> +
> +unlock:
> +    qemu_co_mutex_unlock(&bs->wps->colock);
> +    return ret;
> +}
> +
> +static int coroutine_fn GRAPH_RDLOCK
> +qcow2_finish_zone(BlockDriverState *bs, uint32_t index) {
> +    BDRVQcow2State *s =3D bs->opaque;
> +    int ret;
> +
> +    qemu_co_mutex_lock(&bs->wps->colock);
> +    uint64_t *wp =3D &bs->wps->wp[index];
> +    BlockZoneState zs =3D qcow2_get_zone_state(bs, index);
> +
> +    switch(zs) {
> +    case BLK_ZS_EMPTY:
> +        if (!qcow2_can_activate_zone(bs)) {
> +            ret =3D -EBUSY;
> +            goto unlock;
> +        }
> +        break;
> +    case BLK_ZS_IOPEN:
> +        qcow2_rm_imp_open_zone(s, index);
> +        trace_qcow2_imp_open_zones(BLK_ZO_FINISH, s->nr_zones_imp_open);
> +        break;
> +    case BLK_ZS_EOPEN:
> +        qcow2_rm_exp_open_zone(s, index);
> +        break;
> +    case BLK_ZS_CLOSED:
> +        if (!qcow2_can_open_zone(bs)) {
> +            ret =3D -EINVAL;
> +            goto unlock;
> +        }
> +        qcow2_rm_closed_zone(s, index);
> +        break;
> +    case BLK_ZS_FULL:
> +        ret =3D 0;
> +        goto unlock;
> +    default:
> +        ret =3D -EINVAL;
> +        goto unlock;
> +    }
> +
> +    *wp =3D ((uint64_t)index + 1) * s->zoned_header.zone_size;
> +    ret =3D qcow2_write_wp_at(bs, wp, index);
> +
> +unlock:
> +    qemu_co_mutex_unlock(&bs->wps->colock);
> +    return ret;
> +}
> +
> +static int coroutine_fn GRAPH_RDLOCK
> +qcow2_reset_zone(BlockDriverState *bs, uint32_t index,
> +                            int64_t len) {
> +    BDRVQcow2State *s =3D bs->opaque;
> +    int nrz =3D bs->bl.nr_zones;
> +    int zone_size =3D bs->bl.zone_size;
> +    int n, ret =3D 0;
> +
> +    qemu_co_mutex_lock(&bs->wps->colock);
> +    uint64_t *wp =3D &bs->wps->wp[index];
> +    if (len =3D=3D bs->total_sectors << BDRV_SECTOR_BITS) {
> +        n =3D nrz;
> +        index =3D 0;
> +    } else {
> +        n =3D len / zone_size;
> +    }
> +
> +    for (int i =3D 0; i < n; ++i) {
> +        uint64_t *wp_i =3D (uint64_t *)(wp + i);
> +        uint64_t wpi_v =3D *wp_i;
> +        if (QCOW2_ZT_IS_CONV(wpi_v)) {
> +            continue;
> +        }
> +       =20
> +        BlockZoneState zs =3D qcow2_get_zone_state(bs, index + i);
> +        switch (zs) {
> +        case BLK_ZS_EMPTY:
> +            break;
> +        case BLK_ZS_IOPEN:
> +            qcow2_rm_imp_open_zone(s, index + i);
> +            trace_qcow2_imp_open_zones(BLK_ZO_RESET, s->nr_zones_imp_ope=
n);
> +            break;
> +        case BLK_ZS_EOPEN:
> +            qcow2_rm_exp_open_zone(s, index + i);
> +            break;
> +        case BLK_ZS_CLOSED:
> +            qcow2_rm_closed_zone(s, index + i);
> +            break;
> +        case BLK_ZS_FULL:
> +            break;
> +        default:
> +            ret =3D -EINVAL;
> +            goto unlock;
> +        }
> +
> +        if (zs =3D=3D BLK_ZS_EMPTY) {
> +            continue;
> +        }
> +
> +        *wp_i =3D ((uint64_t)index + i) * zone_size;
> +        ret =3D qcow2_write_wp_at(bs, wp_i, index + i);
> +        if (ret < 0) {
> +            goto unlock;
> +        }
> +        /* clear data */
> +        ret =3D qcow2_co_pwrite_zeroes(bs, *wp_i, zone_size, 0);
> +        if (ret < 0) {
> +            error_report("Failed to reset zone at 0x%" PRIx64 "", *wp_i);
> +        }
> +    }
> +
> +unlock:
> +    qemu_co_mutex_unlock(&bs->wps->colock);
> +    return ret;
> +}
> +
> +static int coroutine_fn GRAPH_RDLOCK
> +qcow2_co_zone_mgmt(BlockDriverState *bs, BlockZoneOp op,
> +                                           int64_t offset, int64_t len)
> +{
> +    BDRVQcow2State *s =3D bs->opaque;
> +    int ret =3D 0;
> +    int64_t capacity =3D bs->total_sectors << BDRV_SECTOR_BITS;
> +    int64_t zone_size =3D s->zoned_header.zone_size;
> +    int64_t zone_size_mask =3D zone_size - 1;
> +    uint32_t index =3D offset / zone_size;
> +    BlockZoneWps *wps =3D bs->wps;
> +
> +    if (offset >=3D capacity) {
> +        error_report("offset %" PRId64 " is equal to or greater than the"
> +                     "device capacity %" PRId64 "", offset, capacity);
> +        return -EINVAL;
> +    }
> +
> +    if (offset & zone_size_mask) {
> +        error_report("sector offset %" PRId64 " is not aligned to zone s=
ize"
> +                     " %" PRId64 "", offset / 512, zone_size / 512);
> +        return -EINVAL;
> +    }
> +
> +    if (((offset + len) < capacity && len & zone_size_mask) ||
> +        offset + len > capacity) {
> +        error_report("number of sectors %" PRId64 " is not aligned to zo=
ne"
> +                     " size %" PRId64 "", len / 512, zone_size / 512);
> +        return -EINVAL;
> +    }
> +
> +    qemu_co_mutex_lock(&wps->colock);
> +    uint64_t wpv =3D wps->wp[index];
> +    if (QCOW2_ZT_IS_CONV(wpv) && len !=3D capacity) {
> +        error_report("zone mgmt operations are not allowed for "
> +                     "conventional zones");
> +        ret =3D -EIO;
> +        goto unlock;
> +    }
> +    qemu_co_mutex_unlock(&wps->colock);
> +
> +    switch(op) {
> +    case BLK_ZO_OPEN:
> +        ret =3D qcow2_open_zone(bs, index);
> +        break;
> +    case BLK_ZO_CLOSE:
> +        ret =3D qcow2_close_zone(bs, index);
> +        break;
> +    case BLK_ZO_FINISH:
> +        ret =3D qcow2_finish_zone(bs, index);
> +        break;
> +    case BLK_ZO_RESET:
> +        ret =3D qcow2_reset_zone(bs, index, len);
> +        break;
> +    default:
> +        error_report("Unsupported zone op: 0x%x", op);
> +        ret =3D -ENOTSUP;
> +        break;
> +    }
> +    return ret;
> +
> +unlock:
> +    qemu_co_mutex_unlock(&wps->colock);
> +    return ret;
> +}
> +
> +static int coroutine_fn GRAPH_RDLOCK
> +qcow2_co_zone_append(BlockDriverState *bs, int64_t *offset, QEMUIOVector=
 *qiov,
> +                     BdrvRequestFlags flags)
> +{
> +    assert(flags =3D=3D 0);
> +    int64_t capacity =3D bs->total_sectors << BDRV_SECTOR_BITS;
> +    uint32_t index;
> +    int ret;
> +    int64_t zone_size_mask =3D bs->bl.zone_size - 1;
> +    int64_t iov_len =3D 0;
> +    int64_t len =3D 0;
> +
> +    if (*offset >=3D capacity) {
> +        error_report("*offset %" PRId64 " is equal to or greater than th=
e"
> +                     "device capacity %" PRId64 "", *offset, capacity);
> +        return -EINVAL;
> +    }
> +
> +    /* offset + len should not pass the end of that zone starting from o=
ffset */
> +    if (*offset & zone_size_mask) {
> +        error_report("sector offset %" PRId64 " is not aligned to zone s=
ize "
> +                     "%" PRId32 "", *offset / 512, bs->bl.zone_size / 51=
2);
> +        return -EINVAL;
> +    }
> +
> +    int64_t wg =3D bs->bl.write_granularity;
> +    int64_t wg_mask =3D wg - 1;
> +    for (int i =3D 0; i < qiov->niov; i++) {
> +        iov_len =3D qiov->iov[i].iov_len;
> +        if (iov_len & wg_mask) {
> +            error_report("len of IOVector[%d] %" PRId64 " is not aligned=
 to "
> +                         "block size %" PRId64 "", i, iov_len, wg);
> +            return -EINVAL;
> +        }
> +    }
> +    len =3D qiov->size;
> +    index =3D *offset / bs->bl.zone_size;
> +
> +    if ((len >> BDRV_SECTOR_BITS) > bs->bl.max_append_sectors) {
> +        return -ENOTSUP;
> +    }
> +
> +    qemu_co_mutex_lock(&bs->wps->colock);
> +    uint64_t wp_i =3D bs->wps->wp[index];
> +    ret =3D qcow2_co_pwritev_part(bs, wp_i, len, qiov, 0, 0);

Is it correct to use wp_i directly without masking bits (e.g. bit 63 for
conventional zones)?

> +    if (ret =3D=3D 0) {
> +        *offset =3D wp_i;
> +    } else {
> +        error_report("qcow2: zap failed");
> +    }
> +
> +    qemu_co_mutex_unlock(&bs->wps->colock);
> +    return ret;
> +}
> +
>  static int coroutine_fn GRAPH_RDLOCK
>  qcow2_co_copy_range_from(BlockDriverState *bs,
>                           BdrvChild *src, int64_t src_offset,
> @@ -6398,6 +7181,10 @@ BlockDriver bdrv_qcow2 =3D {
>      .bdrv_co_pwritev_compressed_part    =3D qcow2_co_pwritev_compressed_=
part,
>      .bdrv_make_empty                    =3D qcow2_make_empty,
> =20
> +    .bdrv_co_zone_report    =3D qcow2_co_zone_report,
> +    .bdrv_co_zone_mgmt    =3D qcow2_co_zone_mgmt,
> +    .bdrv_co_zone_append    =3D qcow2_co_zone_append,
> +
>      .bdrv_snapshot_create               =3D qcow2_snapshot_create,
>      .bdrv_snapshot_goto                 =3D qcow2_snapshot_goto,
>      .bdrv_snapshot_delete               =3D qcow2_snapshot_delete,
> diff --git a/block/trace-events b/block/trace-events
> index 8e789e1f12..e35222e079 100644
> --- a/block/trace-events
> +++ b/block/trace-events
> @@ -82,6 +82,8 @@ qcow2_writev_data(void *co, uint64_t offset) "co %p off=
set 0x%" PRIx64
>  qcow2_pwrite_zeroes_start_req(void *co, int64_t offset, int64_t bytes) "=
co %p offset 0x%" PRIx64 " bytes %" PRId64
>  qcow2_pwrite_zeroes(void *co, int64_t offset, int64_t bytes) "co %p offs=
et 0x%" PRIx64 " bytes %" PRId64
>  qcow2_skip_cow(void *co, uint64_t offset, int nb_clusters) "co %p offset=
 0x%" PRIx64 " nb_clusters %d"
> +qcow2_wp_tracking(int index, uint64_t wp) "wps[%d]: 0x%" PRIx64
> +qcow2_imp_open_zones(uint8_t op, int nrz) "nr_imp_open_zones after op 0x=
%x: %d"
> =20
>  # qcow2-cluster.c
>  qcow2_alloc_clusters_offset(void *co, uint64_t offset, int bytes) "co %p=
 offset 0x%" PRIx64 " bytes %d"
> diff --git a/include/qemu/queue.h b/include/qemu/queue.h
> index e029e7bf66..3f0a48740e 100644
> --- a/include/qemu/queue.h
> +++ b/include/qemu/queue.h
> @@ -179,6 +179,7 @@ struct {                                             =
                   \
>  #define QLIST_EMPTY(head)                ((head)->lh_first =3D=3D NULL)
>  #define QLIST_FIRST(head)                ((head)->lh_first)
>  #define QLIST_NEXT(elm, field)           ((elm)->field.le_next)
> +#define QLIST_LAST(head, field)          (*(head)->lh_first->field.le_pr=
ev)

This assumes QLIST is a circular linked list, but it is not circular:

  #define QLIST_INSERT_HEAD(head, elm, field) do {                        \
          if (((elm)->field.le_next =3D (head)->lh_first) !=3D NULL)       =
   \
                  (head)->lh_first->field.le_prev =3D &(elm)->field.le_next=
;\
          (head)->lh_first =3D (elm);                                      =
 \
          (elm)->field.le_prev =3D &(head)->lh_first;                      =
 \
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  } while (/*CONSTCOND*/0)

head->lh_first->field.le_prev points to head's list head lh_first field,
not to the last node.

Take a look at QTAILQ or QSIMPLEQ if you need a LAST() API.

--is5OYHNShkDwiSMv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmXwnzIACgkQnKSrs4Gr
c8gf2wf6Ap9J2v2RGCaNldJ0HfJqzAvEcBic/NQxCZAFzCLpAzy5ZQxxLbr0PeP5
pya2/VH3X7nNnt7CLyyKIUojuqUrJTrnYciU+23bNIbWhMEjF5gOXnLCOoYzIED7
FjL6k8CZdPwBIPun7w8wxv3mrdFI4sdTzx6WpmyVzcpYjyl9+RTH2ZPcXUUjYumf
yFWgp7CK6f1FjJjF3YWAgVX9k3dT8Q08FzS4Jv8u9uSqPGzzWR+UkyjK1Cf2JdTE
qyazQ7u3ov1wlwZfGtrYoQkTJVae6rBbxjO9bqsp0BK7w3/xqNUNVythpq3h4C/j
KHBwuMm5px6ShUeYi/WPCEvf8LiYHw==
=vVUk
-----END PGP SIGNATURE-----

--is5OYHNShkDwiSMv--


