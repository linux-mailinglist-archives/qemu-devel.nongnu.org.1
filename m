Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F107E030F
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 13:38:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qytQh-0002Qc-5O; Fri, 03 Nov 2023 08:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qytQc-0002QA-Vc
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 08:37:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qytQa-000418-W2
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 08:37:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699015051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jBzojreZv9lYAEvbo/wIk//pz8tYY0jG875CdIilT4g=;
 b=T92ugxh++zdg6+2kTNgRQUZ2DUrKelJnridLCHhjO+24DmklFTv4T+Nn6bttmZ6Kuhnlc1
 cxF4Xxkoh3exDHtumk8U0cka8K7xvODn9sCDaGb3khC3oDXUmzUSc+vL4RORPcx1W9Hf8Y
 zhaREg/KnUWVcEr2MJsjuTzZ902wK00=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-3_f79LA5MKOpjrXmkcDxsw-1; Fri, 03 Nov 2023 08:37:30 -0400
X-MC-Unique: 3_f79LA5MKOpjrXmkcDxsw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C4C882A660;
 Fri,  3 Nov 2023 12:37:30 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C794C1121308;
 Fri,  3 Nov 2023 12:37:28 +0000 (UTC)
Date: Fri, 3 Nov 2023 07:37:27 -0500
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, eesposit@redhat.com, 
 pbonzini@redhat.com, vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: Re: [PATCH 16/24] block: Mark bdrv_replace_node() GRAPH_WRLOCK
Message-ID: <qv27qnwfdeqpbimbj463kgfztmtmdpm4ptxlqptikpjw4chu4o@5r6wvf2avfy4>
References: <20231027155333.420094-1-kwolf@redhat.com>
 <20231027155333.420094-17-kwolf@redhat.com>
 <3dndhoo6fq2pes3dldplykyg7svuwyfntix5txvotr3zpklnly@gf6yi37ijtmm>
 <ZUTMRxsxLbw4OePX@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUTMRxsxLbw4OePX@redhat.com>
User-Agent: NeoMutt/20231023
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.47,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Nov 03, 2023 at 11:32:39AM +0100, Kevin Wolf wrote:
...
> > > -    GLOBAL_STATE_CODE();
> > > -
> > > -    /* Make sure that @from doesn't go away until we have successfully attached
> > > -     * all of its parents to @to. */
> > 
> > Useful comment that you just moved here in the previous patch...
> > 
> > > -    bdrv_ref(from);
...
> > > @@ -5717,9 +5699,15 @@ BlockDriverState *bdrv_insert_node(BlockDriverState *bs, QDict *options,
> > >          goto fail;
> > >      }
> > >  
> > > +    bdrv_ref(bs);
> > 
> > ...but now it is gone.  Intentional?
> 
> I figured it was obvious enough that bdrv_ref() is always called to make
> sure that the node doesn't go away too early, but I can add it back.

Your call.

> > > @@ -94,8 +95,12 @@ static void commit_abort(Job *job)
> > >       * XXX Can (or should) we somehow keep 'consistent read' blocked even
> > >       * after the failed/cancelled commit job is gone? If we already wrote
> > >       * something to base, the intermediate images aren't valid any more. */
> > > -    bdrv_replace_node(s->commit_top_bs, s->commit_top_bs->backing->bs,
> > > -                      &error_abort);
> > > +    commit_top_backing_bs = s->commit_top_bs->backing->bs;
> > > +    bdrv_drained_begin(commit_top_backing_bs);
> > > +    bdrv_graph_wrlock(commit_top_backing_bs);
> > 
> > Here, and elsewhere in the patch, drained_begin/end is outside
> > wr(un)lock...
> > 
> > > +    bdrv_replace_node(s->commit_top_bs, commit_top_backing_bs, &error_abort);
> > > +    bdrv_graph_wrunlock();
> > > +    bdrv_drained_end(commit_top_backing_bs);
> > >  
> > >      bdrv_unref(s->commit_top_bs);
> > >      bdrv_unref(top_bs);
> > > @@ -425,7 +430,11 @@ fail:
> > >      /* commit_top_bs has to be replaced after deleting the block job,
> > >       * otherwise this would fail because of lack of permissions. */
> > >      if (commit_top_bs) {
> > > +        bdrv_graph_wrlock(top);
> > > +        bdrv_drained_begin(top);
> > >          bdrv_replace_node(commit_top_bs, top, &error_abort);
> > > +        bdrv_drained_end(top);
> > > +        bdrv_graph_wrunlock();
> > 
> > ...but here you do it in the opposite order.  Intentional?
> 
> No, this is actually wrong. bdrv_drained_begin() has a nested event
> loop, and running a nested event loop while holding the graph lock can
> cause deadlocks, so it's forbidden. Thanks for catching this!

That's what review is for!

> 
> Since the two comments above are the only thing you found in the review,
> I'll just directly fix them while applying the series.

Sounds good to me. With the deadlock fixed by swapping order,

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


