Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D227CCFE5
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 00:12:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qssHi-0000T8-NJ; Tue, 17 Oct 2023 18:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qssHa-0000So-M3
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 18:11:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qssHY-00022X-WB
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 18:11:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697580680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AKX0p9c/ECNwwnU8GJdz82OtvqAdF1BIqudDgZvMRhA=;
 b=Tz+F6vP+lOxtyI77xmtloWscZJxGFfVvBI+OokAE8Ni2KEPOdqXRz9bPeYqwDzQFkifzjM
 k3qrmBNGbSfRQwRbkxowizgoOiSNPPDOpfpZIE1yXM5n/ZAgB1h25MLNQetuIpdnOEXSDw
 tRjvAa7786V3m9Hv8U1Nm4XJm3dTCvw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-552-oNQ8tAemOMCtLh4U4Spwiw-1; Tue, 17 Oct 2023 18:11:12 -0400
X-MC-Unique: oNQ8tAemOMCtLh4U4Spwiw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B02D729AB3E5;
 Tue, 17 Oct 2023 22:11:11 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 614AFC15BB8;
 Tue, 17 Oct 2023 22:11:10 +0000 (UTC)
Date: Tue, 17 Oct 2023 17:11:08 -0500
From: Eric Blake <eblake@redhat.com>
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Lieven <pl@kamp.de>, 
 Jeff Cody <codyprime@gmail.com>, "open list:Block Jobs" <qemu-block@nongnu.org>
Subject: Re: [RFC PATCH v2 02/78] block: add fallthrough pseudo-keyword
Message-ID: <7efwgbjschmbjc2fjzuvwphwtl5ltfjydkvslctr5tfh6g7mqb@x2hf2cgps2yb>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
 <e54aa70630d6d524886d7950b84d5bda39c3d605.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e54aa70630d6d524886d7950b84d5bda39c3d605.1697183699.git.manos.pitsidianakis@linaro.org>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Oct 13, 2023 at 10:56:29AM +0300, Emmanouil Pitsidianakis wrote:
> In preparation of raising -Wimplicit-fallthrough to 5, replace all
> fall-through comments with the fallthrough attribute pseudo-keyword.
> 
> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  block/block-copy.c    |  1 +
>  block/file-posix.c    |  1 +
>  block/io.c            |  1 +
>  block/iscsi.c         |  1 +
>  block/qcow2-cluster.c |  5 ++++-
>  block/vhdx.c          | 17 +++++++++++++----
>  6 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/block/block-copy.c b/block/block-copy.c
> index 1c60368d72..b4ceb6a079 100644
> --- a/block/block-copy.c
> +++ b/block/block-copy.c
...
>      case COPY_RANGE_FULL:
>          ret = bdrv_co_copy_range(s->source, offset, s->target, offset, nbytes,
>                                   0, s->write_flags);
>          if (ret >= 0) {
>              /* Successful copy-range, increase chunk size.  */
>              *method = COPY_RANGE_FULL;
>              return 0;
>          }
>  
>          trace_block_copy_copy_range_fail(s, offset, ret);
>          *method = COPY_READ_WRITE;
>          /* Fall through to read+write with allocated buffer */
> +        fallthrough;
>  
>      case COPY_READ_WRITE_CLUSTER:
>      case COPY_READ_WRITE:

I like how you kept the comments.

> +++ b/block/qcow2-cluster.c
> @@ -1327,36 +1327,39 @@ static int coroutine_fn calculate_l2_meta(BlockDriverState *bs,
>  /*
>   * Returns true if writing to the cluster pointed to by @l2_entry
>   * requires a new allocation (that is, if the cluster is unallocated
>   * or has refcount > 1 and therefore cannot be written in-place).
>   */
>  static bool cluster_needs_new_alloc(BlockDriverState *bs, uint64_t l2_entry)
>  {
>      switch (qcow2_get_cluster_type(bs, l2_entry)) {
>      case QCOW2_CLUSTER_NORMAL:
> +        fallthrough;
>      case QCOW2_CLUSTER_ZERO_ALLOC:

Why is this one needed?  It looks two case labels for the same code is
okay; the fallthrough attribute is only needed once a case label is no
lonter empty.

>          if (l2_entry & QCOW_OFLAG_COPIED) {
>              return false;
>          }
> -        /* fallthrough */
> +        fallthrough;

This one makes sense.

>      case QCOW2_CLUSTER_UNALLOCATED:
> +        fallthrough;
>      case QCOW2_CLUSTER_COMPRESSED:
> +        fallthrough;

These two also look spurious.

>      case QCOW2_CLUSTER_ZERO_PLAIN:
>          return true;
>      default:
>          abort();
>      }
>  }
...
> +++ b/block/vhdx.c
> @@ -1176,60 +1176,65 @@ static int coroutine_fn GRAPH_RDLOCK
>  vhdx_co_readv(BlockDriverState *bs, int64_t sector_num, int nb_sectors,
>                QEMUIOVector *qiov)
...
>              /* check the payload block state */
>              switch (s->bat[sinfo.bat_idx] & VHDX_BAT_STATE_BIT_MASK) {
> -            case PAYLOAD_BLOCK_NOT_PRESENT: /* fall through */
> +            case PAYLOAD_BLOCK_NOT_PRESENT:
> +                fallthrough;
>              case PAYLOAD_BLOCK_UNDEFINED:
> +                fallthrough;
>              case PAYLOAD_BLOCK_UNMAPPED:
> +                fallthrough;
>              case PAYLOAD_BLOCK_UNMAPPED_v095:
> +                fallthrough;

All four of these look spurious; although the old comment is also
spurious, so I'd be happy with deleting it without replacement.

>              case PAYLOAD_BLOCK_ZERO:
>                  /* return zero */
>                  qemu_iovec_memset(&hd_qiov, 0, 0, sinfo.bytes_avail);
>                  break;
>              case PAYLOAD_BLOCK_FULLY_PRESENT:
>                  qemu_co_mutex_unlock(&s->lock);
>                  ret = bdrv_co_preadv(bs->file, sinfo.file_offset,
>                                       sinfo.sectors_avail * BDRV_SECTOR_SIZE,
>                                       &hd_qiov, 0);
>                  qemu_co_mutex_lock(&s->lock);
>                  if (ret < 0) {
>                      goto exit;
>                  }
>                  break;
>              case PAYLOAD_BLOCK_PARTIALLY_PRESENT:
>                  /* we don't yet support difference files, fall through
>                   * to error */
> +                fallthrough;
>              default:

But keeping this one because of the comment is reasonable.

...
>              switch (bat_state) {
>              case PAYLOAD_BLOCK_ZERO:
>                  /* in this case, we need to preserve zero writes for
>                   * data that is not part of this write, so we must pad
>                   * the rest of the buffer to zeroes */
>                  use_zero_buffers = true;
> -                /* fall through */
> -            case PAYLOAD_BLOCK_NOT_PRESENT: /* fall through */
> +                fallthrough;
> +            case PAYLOAD_BLOCK_NOT_PRESENT:

This one is necessary;

> +                fallthrough;
>              case PAYLOAD_BLOCK_UNMAPPED:
> +                fallthrough;
>              case PAYLOAD_BLOCK_UNMAPPED_v095:
> +                fallthrough;
>              case PAYLOAD_BLOCK_UNDEFINED:

but these three seem spurious.

I like the direction this is headed in, but there's enough I pointed
out that I'll withhold R-b on this version.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


