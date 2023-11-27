Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 894E57F9B33
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 08:55:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7WR3-0007ci-Cm; Mon, 27 Nov 2023 02:53:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1r7WR1-0007c9-GK; Mon, 27 Nov 2023 02:53:39 -0500
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1r7WQx-0006Sx-EZ; Mon, 27 Nov 2023 02:53:39 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 8700CB80882;
 Mon, 27 Nov 2023 07:53:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B819EC433C7;
 Mon, 27 Nov 2023 07:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1701071605;
 bh=FjX40ZkH7oJRwHH2uwlJVeJk/DbjdlXnx9YzoM/SsNs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=OgwfaDGstsjJIlNX9lBprQl7PP0FGO+uz+Cg5iUNnDqwgcwUzkB8QM/6qXIpxEIeB
 i96pWoFrYLZ3feMyuXv54UspuI9nfiK8JWU5vk5sNUb0AuWwtOQ7xa8oYYOrWYe4rW
 U+OFFAVli3PyiRXm2EqUNrt4HlU8T4isLHGbFzUM/BlhZwtsRbg9V8VLb0ShyR9S+2
 8nFSi0Ktp4adKg90uaRliY1iqIc5oRqHiFMoqTizqtNeS32DCTtMzzuW2MKHLv20MT
 mXrgnnixAtUmGDxoNzBWouh3p5xFdTwEOKFPmYpUFptVREQ+qbNCeDkck0nNxXxaf3
 Pk5M7f8poAFAQ==
Message-ID: <3d65356f-8834-441c-bd9d-64e07848ce32@kernel.org>
Date: Mon, 27 Nov 2023 16:53:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] qcow2: add zoned emulation capability
Content-Language: en-US
To: Sam Li <faithilikerun@gmail.com>, qemu-devel@nongnu.org
Cc: dmitry.fomichev@wdc.com, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, hare@suse.de, Hanna Reitz
 <hreitz@redhat.com>, stefanha@redhat.com, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20231127043703.49489-1-faithilikerun@gmail.com>
 <20231127043703.49489-4-faithilikerun@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20231127043703.49489-4-faithilikerun@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2604:1380:4601:e00::1;
 envelope-from=dlemoal@kernel.org; helo=ams.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11/27/23 13:37, Sam Li wrote:
> By adding zone operations and zoned metadata, the zoned emulation
> capability enables full emulation support of zoned device using
> a qcow2 file. The zoned device metadata includes zone type,
> zoned device state and write pointer of each zone, which is stored
> to an array of unsigned integers.
> 
> Each zone of a zoned device makes state transitions following
> the zone state machine. The zone state machine mainly describes
> five states, IMPLICIT OPEN, EXPLICIT OPEN, FULL, EMPTY and CLOSED.
> READ ONLY and OFFLINE states will generally be affected by device
> internal events. The operations on zones cause corresponding state
> changing.
> 
> Zoned devices have a limit on zone resources, which puts constraints on
> write operations into zones. It is managed by active zone lists
> following LRU policy.
> 
> Signed-off-by: Sam Li <faithilikerun@gmail.com>
> ---
>  block/qcow2.c        | 741 ++++++++++++++++++++++++++++++++++++++++++-
>  block/trace-events   |   2 +
>  include/qemu/queue.h |   1 +
>  3 files changed, 742 insertions(+), 2 deletions(-)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 9a92cd242c..26f2bb4a87 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -195,6 +195,179 @@ qcow2_extract_crypto_opts(QemuOpts *opts, const char *fmt, Error **errp)
>      return cryptoopts_qdict;
>  }
>  
> +#define QCOW2_ZT_IS_CONV(wp)    (wp & 1ULL << 59)
> +
> +/*
> + * To emulate a real zoned device, closed, empty and full states are
> + * preserved after a power cycle. Open states are in-memory and will
> + * be lost after closing the device. Read-only and offline states are
> + * device-internal events, which are not considered for simplicity.
> + */
> +static inline BlockZoneState qcow2_get_zone_state(BlockDriverState *bs,
> +                                                  uint32_t index)
> +{
> +    BDRVQcow2State *s = bs->opaque;
> +    Qcow2ZoneListEntry *zone_entry = &s->zone_list_entries[index];
> +    uint64_t zone_wp = bs->wps->wp[index];
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
> +    zone_start = index * bs->bl.zone_size;
> +    if (zone_wp == zone_start) {
> +        return BLK_ZS_EMPTY;
> +    }
> +    if (zone_wp >= zone_start + bs->bl.zone_capacity) {
> +        return BLK_ZS_FULL;
> +    }
> +    if (zone_wp > zone_start) {
> +        return BLK_ZS_CLOSED;
> +    }
> +    return BLK_ZS_NOT_WP;
> +}
> +
> +/*
> + * Write the new wp value to the dedicated location of the image file.
> + */
> +static int qcow2_write_wp_at(BlockDriverState *bs, uint64_t *wp,
> +                             uint32_t index) {
> +    BDRVQcow2State *s = bs->opaque;
> +    uint64_t wpv = *wp;
> +    int ret;
> +
> +    ret = bdrv_pwrite(bs->file, s->zoned_header.zonedmeta_offset
> +        + sizeof(uint64_t) * index, sizeof(uint64_t), wp, 0);
> +    if (ret < 0) {
> +        goto exit;
> +    }
> +    trace_qcow2_wp_tracking(index, *wp >> BDRV_SECTOR_BITS);
> +    return ret;
> +
> +exit:
> +    *wp = wpv;
> +    error_report("Failed to write metadata with file");
> +    return ret;
> +}
> +
> +static bool qcow2_can_activate_zone(BlockDriverState *bs)
> +{
> +    BDRVQcow2State *s = bs->opaque;

A white line here after the declaration would be nice.

> +    /* When the max active zone is zero, there is no limit on active zones */
> +    if (!s->zoned_header.max_active_zones) {
> +        return true;
> +    }
> +
> +    /* The active zones are zones with the states of open and closed */

	/* Active zones are zones that are open or closed */

> +    if (s->nr_zones_exp_open + s->nr_zones_imp_open + s->nr_zones_closed
> +        < s->zoned_header.max_active_zones) {

	return s->nr_zones_exp_open + s->nr_zones_imp_open +
		s->nr_zones_closed < s->zoned_header.max_active_zones;

> +        return true;
> +    }
> +
> +    return false;
> +}
> +
> +/*
> + * This function manages open zones under active zones limit. It checks
> + * if a zone can transition to open state while maintaining max open and
> + * active zone limits.
> + */
> +static bool qcow2_can_open_zone(BlockDriverState *bs)
> +{
> +    BDRVQcow2State *s = bs->opaque;
> +    Qcow2ZoneListEntry *zone_entry;
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
> +     * Zones are managed once at a time. Thus, the number of implicitly open

s/once/one

> +     * zone can never be over the open zone limit. When the active zone limit
> +     * is not reached, close only one implicitly open zone.
> +     */
> +    if (qcow2_can_activate_zone(bs)) {
> +        /*
> +         * The LRU policy is used for handling active zone lists. When

active cone lists -> list of active zones

> +         * removing a random zone entry, we discard the least recently used

random zone entry ? What does this mean ?

> +         * list item. The list item at the last is the least recently used
> +         * one. The zone list maintained this property by removing the last
> +         * entry and inserting before the first entry.
> +         */

Why not simply:

	/*
	 * The list of active zones is managed using an LRU policy: the last
	 * zone is the list is always the one that was lest recently used for
	 * writing and is chosen as the zone to close to be able to implicitly
	 * open another zone.
	 */

> +        zone_entry = QLIST_LAST(&s->imp_open_zones, imp_open_zone_entry);
> +        QLIST_REMOVE(zone_entry, imp_open_zone_entry);
> +        s->nr_zones_imp_open--;
> +        trace_qcow2_imp_open_zones(0x23, s->nr_zones_imp_open);
> +        QLIST_INSERT_HEAD(&s->closed_zones, zone_entry, closed_zone_entry);
> +        s->nr_zones_closed++;
> +        return true;
> +    }
> +    return false;
> +}
> +
> +/*
> + * The zoned device has limited zone resources on open, closed, active
> + * zones.

Limits are optional, so being affirmative like this is incorrect. Why not:

/*
 * Check a device open and active zone limits, if any.
 */

> + */
> +static int qcow2_check_zone_resources(BlockDriverState *bs,
> +                                      BlockZoneState zs)
> +{
> +    switch (zs) {
> +    case BLK_ZS_EMPTY:
> +        if (!qcow2_can_activate_zone(bs)) {
> +            error_report("No enough active zones");

error_report("Active zone limits reached"); ?

> +            return -EINVAL;

	return -EBUSY;

may be more correct here. But I think this function should return a bool and the
caller can decide on what error applies in case false is returned.


> +        }
> +        break;
> +    case BLK_ZS_CLOSED:
> +        if (!qcow2_can_open_zone(bs)) {
> +            error_report("No enough open zones");
> +            return -EINVAL;
> +        }
> +        break;
> +    default:
> +        /* Other states will not affect zone resources management */

Then why return an error ? This is confusing...
Overall, this function is highly confusing because you check the current state
without having information about the action that is about to be performed. E.g.
For a closed zone, we do not need to check resources when we reset the zone. So
while the function name is very generic, its use is not and very limited...

> +        return -EINVAL;
> +    }
> +    return 0;
> +}
> +
> +static inline int qcow2_refresh_zonedmeta(BlockDriverState *bs)
> +{
> +    int ret;
> +    BDRVQcow2State *s = bs->opaque;
> +    uint64_t wps_size = s->zoned_header.zonedmeta_size;
> +    g_autofree uint64_t *temp = NULL;

No need for the NULL initializer. And a white line after this declaration would
be nice.

> +    temp = g_new(uint64_t, wps_size);
> +    ret = bdrv_pread(bs->file, s->zoned_header.zonedmeta_offset,
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
>   * Passing by the zoned device configurations by a zoned_header struct, check
>   * if the zone device options are under constraints. Return false when some
> @@ -508,7 +681,25 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
>                  be32_to_cpu(zoned_ext.max_active_zones);
>              zoned_ext.max_append_bytes =
>                  be32_to_cpu(zoned_ext.max_append_bytes);
> +            zoned_ext.zonedmeta_offset =
> +                be64_to_cpu(zoned_ext.zonedmeta_offset);
> +            zoned_ext.zonedmeta_size = be64_to_cpu(zoned_ext.zonedmeta_size);
>              s->zoned_header = zoned_ext;
> +            bs->wps = g_malloc(sizeof(BlockZoneWps)
> +                + s->zoned_header.zonedmeta_size);
> +            ret = qcow2_refresh_zonedmeta(bs);
> +            if (ret < 0) {
> +                error_setg_errno(errp, -ret, "zonedmeta: "
> +                                             "Could not update zoned meta");

Update ? qcow2_refresh_zonedmeta() only reads the metadata, it does not update
them. So this is confucing. There is an error message in
qcow2_refresh_zonedmeta(). So may be keep only one ?

> +                return ret;
> +            }
> +
> +            s->zone_list_entries = g_new0(Qcow2ZoneListEntry,
> +                                          zoned_ext.nr_zones);
> +            QLIST_INIT(&s->exp_open_zones);
> +            QLIST_INIT(&s->imp_open_zones);
> +            QLIST_INIT(&s->closed_zones);
> +            qemu_co_mutex_init(&bs->wps->colock);
>  
>              /* refuse to open broken images */
>              if (zoned_ext.nr_zones != DIV_ROUND_UP(bs->total_sectors *
> @@ -2776,9 +2967,37 @@ qcow2_co_pwritev_part(BlockDriverState *bs, int64_t offset, int64_t bytes,
>      uint64_t host_offset;
>      QCowL2Meta *l2meta = NULL;
>      AioTaskPool *aio = NULL;
> +    int64_t start_offset, start_bytes;
> +    BlockZoneState zs;
> +    int64_t end;
> +    uint64_t *wp;
> +    int64_t zone_size = bs->bl.zone_size;
> +    int index;
>  
>      trace_qcow2_writev_start_req(qemu_coroutine_self(), offset, bytes);
>  
> +    start_offset = offset;
> +    start_bytes = bytes;
> +    if (bs->bl.zoned == BLK_Z_HM) {
> +        /*
> +         * The offset should not less than the wp of that zone where
> +         * offset starts.

	/* The write offset must be equal to the zone write pointer */

> +         */
> +        index = start_offset / zone_size;
> +        wp = &bs->wps->wp[index];
> +        if (offset < *wp) {

	   if (offset != *wp) { ?

> +            return -EINVAL;
> +        }
> +
> +        /* Only allow writes when there are zone resources left */
> +        zs = qcow2_get_zone_state(bs, index);
> +        if (zs == BLK_ZS_CLOSED || zs == BLK_ZS_EMPTY) {
> +            if (qcow2_check_zone_resources(bs, zs) < 0) {
> +                return -EINVAL;
> +            }
> +        }

This zone state check and the write offset check are not needed/incorrect for a
conventional zone. Where do you check that ? Also, is there a check that the
write does not exceed the zone capacity somewhere ? What about check for write
into FULL zone ? The above wp check will not catch that...

> +    }
> +
>      while (bytes != 0 && aio_task_pool_status(aio) == 0) {
>  
>          l2meta = NULL;
> @@ -2824,6 +3043,68 @@ qcow2_co_pwritev_part(BlockDriverState *bs, int64_t offset, int64_t bytes,
>          qiov_offset += cur_bytes;
>          trace_qcow2_writev_done_part(qemu_coroutine_self(), cur_bytes);
>      }
> +
> +    if (bs->bl.zoned == BLK_Z_HM) {
> +        index = start_offset / zone_size;
> +        wp = &bs->wps->wp[index];
> +        zs = qcow2_get_zone_state(bs, index);
> +        uint64_t wpv = *wp;
> +        if (!QCOW2_ZT_IS_CONV(wpv)) {
> +            /* align up (start_offset, zone_size), the start offset is not
> +             * necessarily power of two. */

Comment style: Start with "/*" line.

> +            end = ((start_offset + zone_size) / zone_size) * zone_size;

		end = (index + 1) * zone_size;

is simpler. But:

		end = start_offset + zone_size;

is what you want, no ?

> +            if (start_offset + start_bytes <= end) {
> +                *wp = start_offset + start_bytes;
> +            } else {
> +                ret = -EINVAL;
> +                goto fail_nometa;
> +            }

This is odd. Why not check this in the first hunk above ? If you really need to
do the check here, please add a comment explaining why. And also, reverse the if
to make this less verbose:

		if (start_offset + start_bytes > end) {
		    ret = -EINVAL;
		    goto fail_nometa;
		}
		*wp = start_offset + start_bytes;

But, you are checking against zone size. You should be checking against zone
capacity.

> +
> +            ret = qcow2_write_wp_at(bs, wp, index);
> +            if (ret < 0) {
> +                goto fail_nometa;
> +            }
> +
> +            /*
> +             * The zone state transitions to implicit open when the original
> +             * state is empty or closed. When the wp reaches the end, the
> +             * open states (explicit open, implicit open) become full.
> +             */
> +            Qcow2ZoneListEntry *zone_entry = &s->zone_list_entries[index];
> +            if (!(*wp & (zone_size - 1))) {
> +                /* Being aligned to zone size implies full state */
> +                if (QLIST_IS_INSERTED(zone_entry, exp_open_zone_entry)) {
> +                    QLIST_REMOVE(zone_entry, exp_open_zone_entry);
> +                    s->nr_zones_exp_open--;
> +                } else if (QLIST_IS_INSERTED(zone_entry, imp_open_zone_entry)) {
> +                    QLIST_REMOVE(zone_entry, imp_open_zone_entry);
> +                    s->nr_zones_imp_open--;
> +                    trace_qcow2_imp_open_zones(0x24,
> +                                               s->nr_zones_imp_open);
> +                }
> +            } else {
> +                if (zs == BLK_ZS_CLOSED || zs == BLK_ZS_EMPTY) {
> +                    QLIST_INSERT_HEAD(&s->imp_open_zones, zone_entry,
> +                                      imp_open_zone_entry);
> +                    s->nr_zones_imp_open++;
> +
> +                    if (zs == BLK_ZS_CLOSED) {
> +                        s->nr_zones_closed--;
> +                    }
> +                } else if (zs == BLK_ZS_IOPEN) {
> +                    /*
> +                     * The LRU policy: update the zone that is most recently
> +                     * used to the head of the zone list
> +                     */
> +                    QLIST_REMOVE(zone_entry, imp_open_zone_entry);
> +                    QLIST_INSERT_HEAD(&s->imp_open_zones, zone_entry,
> +                                      imp_open_zone_entry);
> +                    trace_qcow2_imp_open_zones(0x24,
> +                                               s->nr_zones_imp_open);
> +                }
> +            }

Nit: the zone state transition should be done *before* writing. This way would
more correctly emulate a real drive which is going to do zone management before
it can write to the zone. So even if the write fails, the zone state may have
changed, but that is OK. Real drives will have that behavior.

> +        }
> +    }
>      ret = 0;
>  
>      qemu_co_mutex_lock(&s->lock);
> @@ -2882,6 +3163,26 @@ static int GRAPH_RDLOCK qcow2_inactivate(BlockDriverState *bs)
>      return result;
>  }
>  
> +static void qcow2_zoned_close(BDRVQcow2State *s)

qcow2_zoned_close_all() ?

This is closing all open zones, right ?

> +{
> +    Qcow2ZoneListEntry *zone_entry, *next;
> +
> +    QLIST_FOREACH_SAFE(zone_entry, &s->imp_open_zones, imp_open_zone_entry,
> +                       next) {
> +        QLIST_REMOVE(zone_entry, imp_open_zone_entry);
> +        s->nr_zones_imp_open--;
> +        trace_qcow2_imp_open_zones(0x22, s->nr_zones_imp_open);
> +    }
> +
> +    QLIST_FOREACH_SAFE(zone_entry, &s->exp_open_zones, exp_open_zone_entry,
> +                       next) {
> +        QLIST_REMOVE(zone_entry, exp_open_zone_entry);
> +        s->nr_zones_exp_open--;
> +    }
> +
> +    assert(s->nr_zones_imp_open + s->nr_zones_exp_open == 0);
> +}
> +
>  static void coroutine_mixed_fn GRAPH_RDLOCK
>  qcow2_do_close(BlockDriverState *bs, bool close_data_file)
>  {
> @@ -2921,6 +3222,8 @@ qcow2_do_close(BlockDriverState *bs, bool close_data_file)
>  
>      qcow2_refcount_close(bs);
>      qcow2_free_snapshots(bs);
> +    qcow2_zoned_close(s);
> +    g_free(bs->wps);
>  }
>  
>  static void GRAPH_UNLOCKED qcow2_close(BlockDriverState *bs)
> @@ -3235,7 +3538,10 @@ int qcow2_update_header(BlockDriverState *bs)
>              .max_active_zones   =
>                  cpu_to_be32(s->zoned_header.max_active_zones),
>              .max_append_bytes =
> -                cpu_to_be32(s->zoned_header.max_append_bytes)
> +                cpu_to_be32(s->zoned_header.max_append_bytes),
> +            .zonedmeta_offset   =
> +                cpu_to_be64(s->zoned_header.zonedmeta_offset),
> +            .zonedmeta_size     = cpu_to_be64(s->zoned_header.zonedmeta_size),
>          };
>          ret = header_ext_add(buf, QCOW2_EXT_MAGIC_ZONED_FORMAT,
>                               &zoned_header, sizeof(zoned_header),
> @@ -3643,7 +3949,8 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
>      int version;
>      int refcount_order;
>      uint64_t *refcount_table;
> -    int ret;
> +    uint64_t zoned_meta_size, zoned_clusterlen;
> +    int ret, offset, i;
>      uint8_t compression_type = QCOW2_COMPRESSION_TYPE_ZLIB;
>  
>      assert(create_options->driver == BLOCKDEV_DRIVER_QCOW2);
> @@ -3985,6 +4292,45 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
>              ret = -EINVAL;
>              goto out;
>          }
> +
> +        uint32_t nrz = s->zoned_header.nr_zones;
> +        zoned_meta_size =  sizeof(uint64_t) * nrz;
> +        g_autofree uint64_t *meta = NULL;
> +        meta = g_new0(uint64_t, nrz);
> +
> +        for (i = 0; i < s->zoned_header.conventional_zones; ++i) {
> +            meta[i] = i * s->zoned_header.zone_size;
> +            meta[i] |= 1ULL << 59;
> +        }
> +
> +        for (; i < nrz; ++i) {
> +            meta[i] = i * s->zoned_header.zone_size;
> +        }
> +
> +        offset = qcow2_alloc_clusters(blk_bs(blk), zoned_meta_size);
> +        if (offset < 0) {
> +            error_setg_errno(errp, -offset, "Could not allocate clusters "
> +                                            "for zoned metadata size");
> +            goto out;
> +        }
> +        s->zoned_header.zonedmeta_offset = offset;
> +        s->zoned_header.zonedmeta_size = zoned_meta_size;
> +
> +        zoned_clusterlen = size_to_clusters(s, zoned_meta_size)
> +                * s->cluster_size;
> +        assert(qcow2_pre_write_overlap_check(bs, 0, offset,
> +                                             zoned_clusterlen,false) == 0);
> +        ret = bdrv_pwrite_zeroes(blk_bs(blk)->file, offset,
> +                                 zoned_clusterlen, 0);
> +        if (ret < 0) {
> +            error_setg_errno(errp, -ret, "Could not zero fill zoned metadata");
> +            goto out;
> +        }
> +        ret = bdrv_pwrite(blk_bs(blk)->file, offset, zoned_meta_size, meta, 0);
> +        if (ret < 0) {
> +            error_setg_errno(errp, -ret, "Could not write zoned metadata "
> +                                         "to disk");
> +        }
>      } else {
>          s->zoned_header.zoned = BLK_Z_NONE;
>      }
> @@ -4324,6 +4670,393 @@ qcow2_co_pdiscard(BlockDriverState *bs, int64_t offset, int64_t bytes)
>      return ret;
>  }
>  
> +static int coroutine_fn
> +qcow2_co_zone_report(BlockDriverState *bs, int64_t offset,
> +                     unsigned int *nr_zones, BlockZoneDescriptor *zones)
> +{
> +    BDRVQcow2State *s = bs->opaque;
> +    uint64_t zone_size = s->zoned_header.zone_size;
> +    int64_t capacity = bs->total_sectors << BDRV_SECTOR_BITS;
> +    int64_t size = bs->bl.nr_zones * zone_size;
> +    unsigned int nrz = *nr_zones;
> +    int i = 0;
> +    int si;
> +
> +    if (offset >= capacity) {
> +        error_report("offset %" PRId64 " is equal to or greater than the "
> +                     "device capacity %" PRId64 "", offset, capacity);
> +        return -EINVAL;
> +    }
> +
> +    if (nrz > bs->bl.nr_zones) {
> +        error_report("nr_zones %" PRId32 " should not exceed the device zones"
> +                     "%" PRId32 "", nrz, bs->bl.nr_zones);
> +        return -EINVAL;

This should not be an error. You should simply return up to the last zone. No
need to fail the command for this.

> +    }
> +
> +    if (zone_size > 0) {

Why would this function ever be called on a device that does not have a zone
size > 0 ?

> +        si = offset / zone_size;
> +        qemu_co_mutex_lock(&bs->wps->colock);
> +        for (; i < nrz; ++i) {
> +            if (i + si >= bs->bl.nr_zones) {
> +                break;
> +            }
> +
> +            zones[i].start = (si + i) * zone_size;
> +
> +            /* The last zone can be smaller than the zone size */
> +            if ((si + i + 1) == bs->bl.nr_zones && size > capacity) {
> +                uint32_t l = zone_size - (size - capacity);
> +                zones[i].length = l;
> +                zones[i].cap = l;
> +            } else {
> +                zones[i].length = zone_size;
> +                zones[i].cap = zone_size;
> +            }
> +
> +            uint64_t wp = bs->wps->wp[si + i];
> +            if (QCOW2_ZT_IS_CONV(wp)) {
> +                zones[i].type = BLK_ZT_CONV;
> +                zones[i].state = BLK_ZS_NOT_WP;
> +                /* Clear the zone type bit */
> +                wp &= ~(1ULL << 59);
> +            } else {
> +                zones[i].type = BLK_ZT_SWR;
> +                zones[i].state = qcow2_get_zone_state(bs, si + i);
> +            }
> +            zones[i].wp = wp;
> +        }
> +        qemu_co_mutex_unlock(&bs->wps->colock);
> +    }
> +    *nr_zones = i;
> +    return 0;
> +}
> +
> +static int qcow2_open_zone(BlockDriverState *bs, uint32_t index) {
> +    BDRVQcow2State *s = bs->opaque;
> +    int ret;
> +
> +    qemu_co_mutex_lock(&bs->wps->colock);
> +    uint64_t *wp = &bs->wps->wp[index];
> +    BlockZoneState zs = qcow2_get_zone_state(bs, index);
> +
> +    switch(zs) {
> +    case BLK_ZS_EMPTY:
> +        ret = qcow2_check_zone_resources(bs, BLK_ZS_EMPTY);

Reading how you use qcow2_check_zone_resources(), I think you really should get
rid of that function and directly use can_open() etc functions here. That would
make reading the code far easier and less error prone. And overall simpler code.

> +        if (ret < 0) {
> +            goto unlock;
> +        }
> +        break;
> +    case BLK_ZS_IOPEN:
> +        QLIST_REMOVE(&s->zone_list_entries[index], imp_open_zone_entry);
> +        s->nr_zones_imp_open--;
> +        trace_qcow2_imp_open_zones(BLK_ZO_OPEN, s->nr_zones_imp_open);
> +        break;
> +    case BLK_ZS_EOPEN:
> +        return 0;
> +    case BLK_ZS_CLOSED:
> +        ret = qcow2_check_zone_resources(bs, BLK_ZS_CLOSED);
> +        if (ret < 0) {
> +            goto unlock;
> +        }
> +        s->nr_zones_closed--;
> +        break;
> +    case BLK_ZS_FULL:
> +        break;
> +    default:
> +        ret = -EINVAL;
> +        goto unlock;
> +    }
> +
> +    ret = qcow2_write_wp_at(bs, wp, index);
> +    if (!ret) {
> +        QLIST_INSERT_HEAD(&s->exp_open_zones, &s->zone_list_entries[index],
> +                          exp_open_zone_entry);
> +        s->nr_zones_exp_open++;
> +    }
> +
> +unlock:
> +    qemu_co_mutex_unlock(&bs->wps->colock);
> +    return ret;
> +}
> +
> +static int qcow2_close_zone(BlockDriverState *bs, uint32_t index) {
> +    BDRVQcow2State *s = bs->opaque;
> +    int ret;
> +
> +    qemu_co_mutex_lock(&bs->wps->colock);
> +    BlockZoneState zs = qcow2_get_zone_state(bs, index);
> +
> +    switch(zs) {
> +    case BLK_ZS_EMPTY:
> +        break;
> +    case BLK_ZS_IOPEN:
> +        QLIST_REMOVE(&s->zone_list_entries[index], imp_open_zone_entry);
> +        s->nr_zones_imp_open--;
> +        trace_qcow2_imp_open_zones(BLK_ZO_CLOSE, s->nr_zones_imp_open);
> +        break;
> +    case BLK_ZS_EOPEN:
> +        QLIST_REMOVE(&s->zone_list_entries[index], exp_open_zone_entry);
> +        s->nr_zones_exp_open--;
> +        break;
> +    case BLK_ZS_CLOSED:
> +        ret = qcow2_check_zone_resources(bs, BLK_ZS_CLOSED);

Same remark as for open.

> +        if (ret < 0) {
> +            goto unlock;
> +        }
> +        s->nr_zones_closed--;
> +        break;
> +    case BLK_ZS_FULL:
> +        break;
> +    default:
> +        ret = -EINVAL;
> +        goto unlock;
> +    }
> +
> +    if (qcow2_get_zone_state(bs, index) == BLK_ZS_CLOSED) {
> +        s->nr_zones_closed++;
> +    }
> +    ret = 0;
> +
> +unlock:
> +    qemu_co_mutex_unlock(&bs->wps->colock);
> +    return ret;
> +}
> +
> +static int qcow2_finish_zone(BlockDriverState *bs, uint32_t index) {
> +    BDRVQcow2State *s = bs->opaque;
> +    int ret;
> +
> +    qemu_co_mutex_lock(&bs->wps->colock);
> +    uint64_t *wp = &bs->wps->wp[index];
> +    BlockZoneState zs = qcow2_get_zone_state(bs, index);
> +
> +    switch(zs) {
> +    case BLK_ZS_EMPTY:
> +        ret = qcow2_check_zone_resources(bs, BLK_ZS_EMPTY);

Ditto.

> +        if (ret < 0) {
> +            goto unlock;
> +        }
> +        break;
> +    case BLK_ZS_IOPEN:
> +        QLIST_REMOVE(&s->zone_list_entries[index], imp_open_zone_entry);
> +        s->nr_zones_imp_open--;
> +        trace_qcow2_imp_open_zones(BLK_ZO_FINISH, s->nr_zones_imp_open);
> +        break;
> +    case BLK_ZS_EOPEN:
> +        QLIST_REMOVE(&s->zone_list_entries[index], exp_open_zone_entry);
> +        s->nr_zones_exp_open--;
> +        break;
> +    case BLK_ZS_CLOSED:
> +        ret = qcow2_check_zone_resources(bs, BLK_ZS_CLOSED);
> +        if (ret < 0) {
> +            goto unlock;
> +        }
> +        s->nr_zones_closed--;
> +        break;
> +    case BLK_ZS_FULL:
> +        ret = 0;
> +        goto unlock;
> +    default:
> +        ret = -EINVAL;
> +        goto unlock;
> +    }
> +
> +    *wp = ((uint64_t)index + 1) * s->zoned_header.zone_size;
> +    ret = qcow2_write_wp_at(bs, wp, index);
> +
> +unlock:
> +    qemu_co_mutex_unlock(&bs->wps->colock);
> +    return ret;
> +}
> +
> +static int qcow2_reset_zone(BlockDriverState *bs, uint32_t index,
> +                            int64_t len) {
> +    BDRVQcow2State *s = bs->opaque;
> +    int nrz = bs->bl.nr_zones;
> +    int zone_size = bs->bl.zone_size;
> +    int n, ret = 0;
> +
> +    qemu_co_mutex_lock(&bs->wps->colock);
> +    uint64_t *wp = &bs->wps->wp[index];
> +    if (len == bs->total_sectors << BDRV_SECTOR_BITS) {
> +        n = nrz;
> +        index = 0;
> +    } else {
> +        n = len / zone_size;
> +    }
> +
> +    for (int i = 0; i < n; ++i) {
> +        uint64_t *wp_i = (uint64_t *)(wp + i);
> +        uint64_t wpi_v = *wp_i;
> +        if (QCOW2_ZT_IS_CONV(wpi_v)) {
> +            continue;
> +        }
> +        
> +        BlockZoneState zs = qcow2_get_zone_state(bs, index + i);
> +        switch (zs) {
> +        case BLK_ZS_EMPTY:
> +            break;
> +        case BLK_ZS_IOPEN:
> +            QLIST_REMOVE(&s->zone_list_entries[index + i], imp_open_zone_entry);
> +            s->nr_zones_imp_open--;
> +            trace_qcow2_imp_open_zones(BLK_ZO_RESET, s->nr_zones_imp_open);
> +            break;
> +        case BLK_ZS_EOPEN:
> +            QLIST_REMOVE(&s->zone_list_entries[index + i], exp_open_zone_entry);
> +            s->nr_zones_exp_open--;
> +            break;
> +        case BLK_ZS_CLOSED:
> +            s->nr_zones_closed--;

No removing from the close list ?

This all should be coded with a small helpers qcow2_do_imp_open_zone(),
qcow2_do_exp_open_zone(), qcow2_do_close_zone() etc. That would simplify the
code in these higher level functions and simplify things overall as that would
avoid these QLIST calls all over the place.

> +            break;
> +        case BLK_ZS_FULL:
> +            break;
> +        default:
> +            ret = -EINVAL;
> +            goto unlock;
> +        }
> +
> +        if (zs == BLK_ZS_EMPTY) {
> +            continue;
> +        }
> +
> +        *wp_i = ((uint64_t)index + i) * zone_size;
> +        ret = qcow2_write_wp_at(bs, wp_i, index + i);
> +        if (ret < 0) {
> +            goto unlock;
> +        }
> +        /* clear data */
> +        ret = qcow2_co_pwrite_zeroes(bs, *wp_i, zone_size, 0);
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
> +static int coroutine_fn qcow2_co_zone_mgmt(BlockDriverState *bs, BlockZoneOp op,
> +                                           int64_t offset, int64_t len)
> +{
> +    BDRVQcow2State *s = bs->opaque;
> +    int ret = 0;
> +    int64_t capacity = bs->total_sectors << BDRV_SECTOR_BITS;
> +    int64_t zone_size = s->zoned_header.zone_size;
> +    int64_t zone_size_mask = zone_size - 1;
> +    uint32_t index = offset / zone_size;
> +    BlockZoneWps *wps = bs->wps;
> +
> +    if (offset >= capacity) {
> +        error_report("offset %" PRId64 " is equal to or greater than the"
> +                     "device capacity %" PRId64 "", offset, capacity);
> +        return -EINVAL;
> +    }
> +
> +    if (offset & zone_size_mask) {
> +        error_report("sector offset %" PRId64 " is not aligned to zone size"
> +                     " %" PRId64 "", offset / 512, zone_size / 512);
> +        return -EINVAL;
> +    }
> +
> +    if (((offset + len) < capacity && len & zone_size_mask) ||
> +        offset + len > capacity) {
> +        error_report("number of sectors %" PRId64 " is not aligned to zone"
> +                     " size %" PRId64 "", len / 512, zone_size / 512);
> +        return -EINVAL;
> +    }
> +
> +    qemu_co_mutex_lock(&wps->colock);
> +    uint64_t wpv = wps->wp[index];
> +    if (QCOW2_ZT_IS_CONV(wpv) && len != capacity) {
> +        error_report("zone mgmt operations are not allowed for "
> +                     "conventional zones");
> +        ret = -EIO;
> +        goto unlock;
> +    }
> +    qemu_co_mutex_unlock(&wps->colock);
> +
> +    switch(op) {
> +    case BLK_ZO_OPEN:
> +        ret = qcow2_open_zone(bs, index);
> +        break;
> +    case BLK_ZO_CLOSE:
> +        ret = qcow2_close_zone(bs, index);
> +        break;
> +    case BLK_ZO_FINISH:
> +        ret = qcow2_finish_zone(bs, index);
> +        break;
> +    case BLK_ZO_RESET:
> +        ret = qcow2_reset_zone(bs, index, len);
> +        break;
> +    default:
> +        error_report("Unsupported zone op: 0x%x", op);
> +        ret = -ENOTSUP;
> +        break;
> +    }
> +    return ret;
> +
> +unlock:
> +    qemu_co_mutex_unlock(&wps->colock);
> +    return ret;
> +}
> +
> +static int coroutine_fn
> +qcow2_co_zone_append(BlockDriverState *bs, int64_t *offset, QEMUIOVector *qiov,
> +                     BdrvRequestFlags flags)
> +{
> +    assert(flags == 0);
> +    int64_t capacity = bs->total_sectors << BDRV_SECTOR_BITS;
> +    uint32_t index;
> +    int ret;
> +    int64_t zone_size_mask = bs->bl.zone_size - 1;
> +    int64_t iov_len = 0;
> +    int64_t len = 0;
> +
> +    if (*offset >= capacity) {
> +        error_report("*offset %" PRId64 " is equal to or greater than the"
> +                     "device capacity %" PRId64 "", *offset, capacity);
> +        return -EINVAL;
> +    }
> +
> +    /* offset + len should not pass the end of that zone starting from offset */
> +    if (*offset & zone_size_mask) {
> +        error_report("sector offset %" PRId64 " is not aligned to zone size "
> +                     "%" PRId32 "", *offset / 512, bs->bl.zone_size / 512);
> +        return -EINVAL;
> +    }
> +
> +    int64_t wg = bs->bl.write_granularity;
> +    int64_t wg_mask = wg - 1;
> +    for (int i = 0; i < qiov->niov; i++) {
> +        iov_len = qiov->iov[i].iov_len;
> +        if (iov_len & wg_mask) {
> +            error_report("len of IOVector[%d] %" PRId64 " is not aligned to "
> +                         "block size %" PRId64 "", i, iov_len, wg);
> +            return -EINVAL;
> +        }
> +    }
> +    len = qiov->size;
> +    index = *offset / bs->bl.zone_size;
> +
> +    if ((len >> BDRV_SECTOR_BITS) > bs->bl.max_append_sectors) {
> +        return -ENOTSUP;
> +    }
> +
> +    qemu_co_mutex_lock(&bs->wps->colock);
> +    uint64_t wp_i = bs->wps->wp[index];
> +    ret = qcow2_co_pwritev_part(bs, wp_i, len, qiov, 0, 0);
> +    if (ret == 0) {
> +        *offset = wp_i;
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
> @@ -6383,6 +7116,10 @@ BlockDriver bdrv_qcow2 = {
>      .bdrv_co_pwritev_compressed_part    = qcow2_co_pwritev_compressed_part,
>      .bdrv_make_empty                    = qcow2_make_empty,
>  
> +    .bdrv_co_zone_report    = qcow2_co_zone_report,
> +    .bdrv_co_zone_mgmt    = qcow2_co_zone_mgmt,
> +    .bdrv_co_zone_append    = qcow2_co_zone_append,
> +
>      .bdrv_snapshot_create               = qcow2_snapshot_create,
>      .bdrv_snapshot_goto                 = qcow2_snapshot_goto,
>      .bdrv_snapshot_delete               = qcow2_snapshot_delete,
> diff --git a/block/trace-events b/block/trace-events
> index 8e789e1f12..e35222e079 100644
> --- a/block/trace-events
> +++ b/block/trace-events
> @@ -82,6 +82,8 @@ qcow2_writev_data(void *co, uint64_t offset) "co %p offset 0x%" PRIx64
>  qcow2_pwrite_zeroes_start_req(void *co, int64_t offset, int64_t bytes) "co %p offset 0x%" PRIx64 " bytes %" PRId64
>  qcow2_pwrite_zeroes(void *co, int64_t offset, int64_t bytes) "co %p offset 0x%" PRIx64 " bytes %" PRId64
>  qcow2_skip_cow(void *co, uint64_t offset, int nb_clusters) "co %p offset 0x%" PRIx64 " nb_clusters %d"
> +qcow2_wp_tracking(int index, uint64_t wp) "wps[%d]: 0x%" PRIx64
> +qcow2_imp_open_zones(uint8_t op, int nrz) "nr_imp_open_zones after op 0x%x: %d"
>  
>  # qcow2-cluster.c
>  qcow2_alloc_clusters_offset(void *co, uint64_t offset, int bytes) "co %p offset 0x%" PRIx64 " bytes %d"
> diff --git a/include/qemu/queue.h b/include/qemu/queue.h
> index e029e7bf66..3f0a48740e 100644
> --- a/include/qemu/queue.h
> +++ b/include/qemu/queue.h
> @@ -179,6 +179,7 @@ struct {                                                                \
>  #define QLIST_EMPTY(head)                ((head)->lh_first == NULL)
>  #define QLIST_FIRST(head)                ((head)->lh_first)
>  #define QLIST_NEXT(elm, field)           ((elm)->field.le_next)
> +#define QLIST_LAST(head, field)          (*(head)->lh_first->field.le_prev)
>  
>  
>  /*

-- 
Damien Le Moal
Western Digital Research


