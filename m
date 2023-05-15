Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4617032C1
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 18:20:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyavi-0005zK-6V; Mon, 15 May 2023 12:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1pyavQ-0005s2-0A
 for qemu-devel@nongnu.org; Mon, 15 May 2023 12:19:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1pyavM-0004hF-2r
 for qemu-devel@nongnu.org; Mon, 15 May 2023 12:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684167586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xPZNPj4AyCA1hM7M+NVfaEduqlBHg0AEIfUdO0tDcBE=;
 b=D6/t0THENYWfFD45r4ZSaDu3ed3MLAzbXy1KfKhO45RYKfv2m1U59xE27SIbbMdzvRA0ab
 ASmhQgJtM3FRH3XtMM/Zwja8FOCig9zwW+QGcFfRy3ZyvuOBVKrAP/V7EQHNNn4Z37bOF7
 lbVpozIXbhtT9HJKBGZLhiThqircAFk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-124-YwTrdHZiMg68BCkli8r1GQ-1; Mon, 15 May 2023 12:19:44 -0400
X-MC-Unique: YwTrdHZiMg68BCkli8r1GQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C4E61C04184;
 Mon, 15 May 2023 16:19:44 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.135])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F5F41121314;
 Mon, 15 May 2023 16:19:43 +0000 (UTC)
Date: Mon, 15 May 2023 18:19:41 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, stefanha@redhat.com,
 f.ebner@proxmox.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/8] block: Call .bdrv_co_create(_opts) unlocked
Message-ID: <ZGJbnbx9vjXVEUuv@redhat.com>
References: <20230510203601.418015-1-kwolf@redhat.com>
 <20230510203601.418015-2-kwolf@redhat.com>
 <lqumtxeofbejjvf5f45zf5ywdrae2wckhgwrud5ggly4jganfz@sbb23gf53wbg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lqumtxeofbejjvf5f45zf5ywdrae2wckhgwrud5ggly4jganfz@sbb23gf53wbg>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Am 12.05.2023 um 18:12 hat Eric Blake geschrieben:
> 
> On Wed, May 10, 2023 at 10:35:54PM +0200, Kevin Wolf wrote:
> > 
> > These are functions that modify the graph, so they must be able to take
> > a writer lock. This is impossible if they already hold the reader lock.
> > If they need a reader lock for some of their operations, they should
> > take it internally.
> > 
> > Many of them go through blk_*(), which will always take the lock itself.
> > Direct calls of bdrv_*() need to take the reader lock. Note that while
> > locking for bdrv_co_*() calls is checked by TSA, this is not the case
> > for the mixed_coroutine_fns bdrv_*(). Holding the lock is still required
> > when they are called from coroutine context like here!
> > 
> > This effectively reverts 4ec8df0183, but adds some internal locking
> > instead.
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> 
> > +++ b/block/qcow2.c
> 
> > -static int coroutine_fn
> > +static int coroutine_fn GRAPH_UNLOCKED
> >  qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
> >  {
> >      BlockdevCreateOptionsQcow2 *qcow2_opts;
> > @@ -3724,8 +3726,10 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
> >          goto out;
> >      }
> >  
> > +    bdrv_graph_co_rdlock();
> >      ret = qcow2_alloc_clusters(blk_bs(blk), 3 * cluster_size);
> >      if (ret < 0) {
> > +        bdrv_graph_co_rdunlock();
> >          error_setg_errno(errp, -ret, "Could not allocate clusters for qcow2 "
> >                           "header and refcount table");
> >          goto out;
> > @@ -3743,6 +3747,8 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
> >  
> >      /* Create a full header (including things like feature table) */
> >      ret = qcow2_update_header(blk_bs(blk));
> > +    bdrv_graph_co_rdunlock();
> > +
> 
> If we ever inject any 'goto out' in the elided lines, we're in
> trouble.  Would this be any safer by wrapping the intervening
> statements in a scope-guarded lock?

TSA doesn't understand these guards, which is why they are only
annotated as assertions (I think we talked about this in my previous
series), at the cost of leaving unlocking unchecked. So in cases where
the scope isn't the full function, individual calls are better at the
moment. Once clang implements support for __attribute__((cleanup)), we
can maybe change this.

Of course, TSA solves the very maintenance problem you're concerned
about: With a 'goto out' added, compilation on clang fails because it
sees that there is a code path that doesn't unlock. So at least it makes
the compromise not terrible.

For example, if I comment out the unlock in the error case in the first,
this is what I get:

../block/qcow2.c:3825:5: error: mutex 'graph_lock' is not held on every path through here [-Werror,-Wthread-safety-analysis]
    blk_co_unref(blk);
    ^
../block/qcow2.c:3735:5: note: mutex acquired here
    bdrv_graph_co_rdlock();
    ^
1 error generated.

Kevin


