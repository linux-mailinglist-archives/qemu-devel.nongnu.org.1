Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 229C0703F64
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 23:09:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyfQq-0003vq-IE; Mon, 15 May 2023 17:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pyfQn-0003vD-QZ
 for qemu-devel@nongnu.org; Mon, 15 May 2023 17:08:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pyfQm-0003D6-7D
 for qemu-devel@nongnu.org; Mon, 15 May 2023 17:08:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684184911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kXgTAdweOMK6lCMrcls9n/rwH7LSgsW8Sy6wJmkatc4=;
 b=NBMeUjyVQw+vfidCDcHDu01cv5gLEfzEFPTT4LUe1c7EUDv4t1rRGgm6zCtGTh1/yY6u+N
 4m/jR+BE4MPAjMttU/y3KgWCMmQq0Urs3swFUugSiXJqxo65sHR35ify1wtz+COoYlytxx
 BZdTAlroaVQaWkoydSusVccNqPAyRpE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-vRBXbp4MP3OA1uFFSZ6Wxg-1; Mon, 15 May 2023 17:08:28 -0400
X-MC-Unique: vRBXbp4MP3OA1uFFSZ6Wxg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 032FF87DC00;
 Mon, 15 May 2023 21:08:28 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 091D4492B00;
 Mon, 15 May 2023 21:08:26 +0000 (UTC)
Date: Mon, 15 May 2023 16:08:25 -0500
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, stefanha@redhat.com, 
 f.ebner@proxmox.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/8] block: Call .bdrv_co_create(_opts) unlocked
Message-ID: <ontdxyk424kxb7ax7ca2jcwjphzodefzrr6rbe46irvirkfa6h@shlcwuhtfsur>
References: <20230510203601.418015-1-kwolf@redhat.com>
 <20230510203601.418015-2-kwolf@redhat.com>
 <lqumtxeofbejjvf5f45zf5ywdrae2wckhgwrud5ggly4jganfz@sbb23gf53wbg>
 <ZGJbnbx9vjXVEUuv@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGJbnbx9vjXVEUuv@redhat.com>
User-Agent: NeoMutt/20230512
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
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


On Mon, May 15, 2023 at 06:19:41PM +0200, Kevin Wolf wrote:
> > > @@ -3724,8 +3726,10 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
> > >          goto out;
> > >      }
> > >  
> > > +    bdrv_graph_co_rdlock();
> > >      ret = qcow2_alloc_clusters(blk_bs(blk), 3 * cluster_size);
> > >      if (ret < 0) {
> > > +        bdrv_graph_co_rdunlock();
> > >          error_setg_errno(errp, -ret, "Could not allocate clusters for qcow2 "
> > >                           "header and refcount table");
> > >          goto out;
> > > @@ -3743,6 +3747,8 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
> > >  
> > >      /* Create a full header (including things like feature table) */
> > >      ret = qcow2_update_header(blk_bs(blk));
> > > +    bdrv_graph_co_rdunlock();
> > > +
> > 
> > If we ever inject any 'goto out' in the elided lines, we're in
> > trouble.  Would this be any safer by wrapping the intervening
> > statements in a scope-guarded lock?
> 
> TSA doesn't understand these guards, which is why they are only
> annotated as assertions (I think we talked about this in my previous
> series), at the cost of leaving unlocking unchecked. So in cases where
> the scope isn't the full function, individual calls are better at the
> moment. Once clang implements support for __attribute__((cleanup)), we
> can maybe change this.

Yeah, LOTS of people are waiting on clang __attribute__((cleanup))
analysis sanity ;)

> 
> Of course, TSA solves the very maintenance problem you're concerned
> about: With a 'goto out' added, compilation on clang fails because it
> sees that there is a code path that doesn't unlock. So at least it makes
> the compromise not terrible.
> 
> For example, if I comment out the unlock in the error case in the first,
> this is what I get:
> 
> ../block/qcow2.c:3825:5: error: mutex 'graph_lock' is not held on every path through here [-Werror,-Wthread-safety-analysis]
>     blk_co_unref(blk);
>     ^
> ../block/qcow2.c:3735:5: note: mutex acquired here
>     bdrv_graph_co_rdlock();
>     ^
> 1 error generated.

I'm sold!  The very reason you can't use a cleanup scope-guard
(because clang can't see through the annotation) is also the reason
why clang is able to flag your error if you don't properly clean up by
hand.  So while it is more tedious to maintain, we've finally got
compiler assistance to something that used to be human-only, which is
a step forwards even if it is more to type in the short term.

Thanks for testing that.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


