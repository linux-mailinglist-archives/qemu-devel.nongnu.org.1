Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E99607DA29A
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 23:47:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwUek-0002zd-45; Fri, 27 Oct 2023 17:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qwUei-0002zR-R3
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 17:46:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qwUeh-0007Wi-D9
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 17:46:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698443169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZKD8RjLfkavthBQ05RYyRcCHEQGYzq3daRw9GKYkXiU=;
 b=FhJ68i4St6pkqLEdNlmxK/mPko40lKrbH1jnzFLeNMm1KHrHudlkHjaQfvx6yfqyr77gmU
 vyhaEh2t9PtY690uUnakaQzoXZHfvhi3F1sHw0dC0IqeWf3V3Uq3hNiou5xI5zJo50R/bO
 fwfoZNugW70mwc2Gwn4sc3ezvSONpmU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-i5k74y1NP-eflfz1JMCiTQ-1; Fri,
 27 Oct 2023 17:46:06 -0400
X-MC-Unique: i5k74y1NP-eflfz1JMCiTQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F379D3812580;
 Fri, 27 Oct 2023 21:46:05 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.114])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 837F7492BFC;
 Fri, 27 Oct 2023 21:46:04 +0000 (UTC)
Date: Fri, 27 Oct 2023 16:46:02 -0500
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, eesposit@redhat.com, 
 pbonzini@redhat.com, vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: Re: [PATCH 17/24] block: Protect bs->backing with graph_lock
Message-ID: <7qvfxxc6gdw4uuonbg7bm6myo24o5i2l36gxmsrwma5z4dd5to@o7abqtbe6fof>
References: <20231027155333.420094-1-kwolf@redhat.com>
 <20231027155333.420094-18-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027155333.420094-18-kwolf@redhat.com>
User-Agent: NeoMutt/20231023
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Oct 27, 2023 at 05:53:26PM +0200, Kevin Wolf wrote:
> Almost all functions that access bs->backing already take the graph
> lock now. Add locking to the remaining users and finally annotate the
> struct field itself as protected by the graph lock.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/block_int-common.h |  2 +-
>  block.c                          | 27 +++++++++++++++++----------
>  block/commit.c                   |  5 ++++-
>  block/mirror.c                   | 17 ++++++++++++-----
>  block/qed.c                      |  2 +-
>  block/replication.c              |  7 ++++++-
>  block/vmdk.c                     |  7 ++++---
>  tests/unit/test-bdrv-drain.c     | 22 ++++++++++++++++++----
>  tests/unit/test-bdrv-graph-mod.c |  5 ++++-
>  9 files changed, 67 insertions(+), 27 deletions(-)
> 
> +++ b/block.c
...
> @@ -5204,10 +5208,11 @@ static void bdrv_close(BlockDriverState *bs)
>      QLIST_FOREACH_SAFE(child, &bs->children, next, next) {
>          bdrv_unref_child(bs, child);
>      }
> -    bdrv_graph_wrunlock();
>  
>      assert(!bs->backing);
>      assert(!bs->file);
> +    bdrv_graph_wrunlock();
> +
>      g_free(bs->opaque);

At first I wondered why you needed code motion to pull the asserts
inside the lock.  But now I get it - direct access to bs->backing
itself now requires a slightly larger lock scope.

>  static int coroutine_fn mirror_run(Job *job, Error **errp)
>  {
>      MirrorBlockJob *s = container_of(job, MirrorBlockJob, common.job);
> -    BlockDriverState *bs = s->mirror_top_bs->backing->bs;
> +    BlockDriverState *bs;
>      MirrorBDSOpaque *mirror_top_opaque = s->mirror_top_bs->opaque;
>      BlockDriverState *target_bs = blk_bs(s->target);
>      bool need_drain = true;
> @@ -935,6 +939,7 @@ static int coroutine_fn mirror_run(Job *job, Error **errp)
>      }
>  
>      bdrv_graph_co_rdlock();
> +    bs = bdrv_filter_bs(s->mirror_top_bs);

Interesting change to prefer bdrv_filter_bs() instead of direct access
to ->backing->bs; but I think it's okay.

> +++ b/tests/unit/test-bdrv-drain.c
> @@ -218,8 +218,14 @@ static void do_drain_end_unlocked(enum drain_type drain_type, BlockDriverState *
>      }
>  }
>  
> -static void test_drv_cb_common(BlockBackend *blk, enum drain_type drain_type,
> -                               bool recursive)
> +/*
> + * Locking the block graph would be a bit cumbersome here because this function
> + * is called both in coroutine and non-coroutine context. We know this is a test
> + * and nothing else is running, so don't bother with TSA.
> + */
> +static void coroutine_mixed_fn TSA_NO_TSA
> +test_drv_cb_common(BlockBackend *blk, enum drain_type drain_type,
> +                   bool recursive)

Fair enough.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


