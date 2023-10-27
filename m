Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B637DA283
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 23:35:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwUSj-0008Pr-TV; Fri, 27 Oct 2023 17:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qwUSg-0008OX-LD
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 17:33:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qwUSS-0004yH-I8
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 17:33:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698442412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q6eMcvhaEU8Lfsw6U3AYi6Vv65GU78y8mkOc9usCfeo=;
 b=LDypHChrXACSmDnox4Q3Mq42OMFbI14uiuaFg2AXWxgM0UhXpSayO/282gAqYwb2N1AhTo
 Bcuh3EUdBJ89JsBKlYQmMVw4zSl0L5fjIplwfLbxwUegYfLmWXpghajNM4VV8obRL8qnG6
 69/HExZB9LN3mTQGxtxwdM0gCJcJdAU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-BNTNPPxTNZiQFpLi4MLHnw-1; Fri, 27 Oct 2023 17:33:28 -0400
X-MC-Unique: BNTNPPxTNZiQFpLi4MLHnw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 59239862CA1;
 Fri, 27 Oct 2023 21:33:28 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.114])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1FBE3492BFC;
 Fri, 27 Oct 2023 21:33:27 +0000 (UTC)
Date: Fri, 27 Oct 2023 16:33:25 -0500
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, eesposit@redhat.com, 
 pbonzini@redhat.com, vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: Re: [PATCH 16/24] block: Mark bdrv_replace_node() GRAPH_WRLOCK
Message-ID: <3dndhoo6fq2pes3dldplykyg7svuwyfntix5txvotr3zpklnly@gf6yi37ijtmm>
References: <20231027155333.420094-1-kwolf@redhat.com>
 <20231027155333.420094-17-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027155333.420094-17-kwolf@redhat.com>
User-Agent: NeoMutt/20231023
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
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

On Fri, Oct 27, 2023 at 05:53:25PM +0200, Kevin Wolf wrote:
> Instead of taking the writer lock internally, require callers to already
> hold it when calling bdrv_replace_node(). Its callers may already want
> to hold the graph lock and so wouldn't be able to call functions that
> take it internally.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/block-global-state.h |  6 ++++--
>  block.c                            | 26 +++++++-------------------
>  block/commit.c                     | 13 +++++++++++--
>  block/mirror.c                     | 26 ++++++++++++++++----------
>  blockdev.c                         |  5 +++++
>  tests/unit/test-bdrv-drain.c       |  6 ++++++
>  tests/unit/test-bdrv-graph-mod.c   | 13 +++++++++++--
>  7 files changed, 60 insertions(+), 35 deletions(-)
> 
> +++ b/block.c
> @@ -5484,25 +5484,7 @@ out:
>  int bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
>                        Error **errp)
>  {
> -    int ret;
> -
> -    GLOBAL_STATE_CODE();
> -
> -    /* Make sure that @from doesn't go away until we have successfully attached
> -     * all of its parents to @to. */

Useful comment that you just moved here in the previous patch...

> -    bdrv_ref(from);
> -    bdrv_drained_begin(from);
> -    bdrv_drained_begin(to);
> -    bdrv_graph_wrlock(to);
> -
> -    ret = bdrv_replace_node_common(from, to, true, false, errp);
> -
> -    bdrv_graph_wrunlock();
> -    bdrv_drained_end(to);
> -    bdrv_drained_end(from);
> -    bdrv_unref(from);
> -
> -    return ret;
> +    return bdrv_replace_node_common(from, to, true, false, errp);
>  }
>  
>  int bdrv_drop_filter(BlockDriverState *bs, Error **errp)
> @@ -5717,9 +5699,15 @@ BlockDriverState *bdrv_insert_node(BlockDriverState *bs, QDict *options,
>          goto fail;
>      }
>  
> +    bdrv_ref(bs);

...but now it is gone.  Intentional?

>      bdrv_drained_begin(bs);
> +    bdrv_drained_begin(new_node_bs);
> +    bdrv_graph_wrlock(new_node_bs);
>      ret = bdrv_replace_node(bs, new_node_bs, errp);
> +    bdrv_graph_wrunlock();
> +    bdrv_drained_end(new_node_bs);
>      bdrv_drained_end(bs);
> +    bdrv_unref(bs);
>  
>      if (ret < 0) {
>          error_prepend(errp, "Could not replace node: ");
> diff --git a/block/commit.c b/block/commit.c
> index d92af02ead..2fecdce86f 100644
> --- a/block/commit.c
> +++ b/block/commit.c
> @@ -68,6 +68,7 @@ static void commit_abort(Job *job)
>  {
>      CommitBlockJob *s = container_of(job, CommitBlockJob, common.job);
>      BlockDriverState *top_bs = blk_bs(s->top);
> +    BlockDriverState *commit_top_backing_bs;
>  
>      if (s->chain_frozen) {
>          bdrv_graph_rdlock_main_loop();
> @@ -94,8 +95,12 @@ static void commit_abort(Job *job)
>       * XXX Can (or should) we somehow keep 'consistent read' blocked even
>       * after the failed/cancelled commit job is gone? If we already wrote
>       * something to base, the intermediate images aren't valid any more. */
> -    bdrv_replace_node(s->commit_top_bs, s->commit_top_bs->backing->bs,
> -                      &error_abort);
> +    commit_top_backing_bs = s->commit_top_bs->backing->bs;
> +    bdrv_drained_begin(commit_top_backing_bs);
> +    bdrv_graph_wrlock(commit_top_backing_bs);

Here, and elsewhere in the patch, drained_begin/end is outside
wr(un)lock...

> +    bdrv_replace_node(s->commit_top_bs, commit_top_backing_bs, &error_abort);
> +    bdrv_graph_wrunlock();
> +    bdrv_drained_end(commit_top_backing_bs);
>  
>      bdrv_unref(s->commit_top_bs);
>      bdrv_unref(top_bs);
> @@ -425,7 +430,11 @@ fail:
>      /* commit_top_bs has to be replaced after deleting the block job,
>       * otherwise this would fail because of lack of permissions. */
>      if (commit_top_bs) {
> +        bdrv_graph_wrlock(top);
> +        bdrv_drained_begin(top);
>          bdrv_replace_node(commit_top_bs, top, &error_abort);
> +        bdrv_drained_end(top);
> +        bdrv_graph_wrunlock();

...but here you do it in the opposite order.  Intentional?

> +++ b/tests/unit/test-bdrv-drain.c
> @@ -2000,7 +2000,13 @@ static void do_test_replace_child_mid_drain(int old_drain_count,
>      parent_s->was_undrained = false;
>  
>      g_assert(parent_bs->quiesce_counter == old_drain_count);
> +    bdrv_drained_begin(old_child_bs);
> +    bdrv_drained_begin(new_child_bs);
> +    bdrv_graph_wrlock(NULL);

Why is this locking on NULL instead of new_child_bs?

>      bdrv_replace_node(old_child_bs, new_child_bs, &error_abort);
> +    bdrv_graph_wrunlock();
> +    bdrv_drained_end(new_child_bs);
> +    bdrv_drained_end(old_child_bs);
>      g_assert(parent_bs->quiesce_counter == new_drain_count);
>  
>      if (!old_drain_count && !new_drain_count) {

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


