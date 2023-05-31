Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6000C7188E8
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 19:55:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Q1v-0002tF-17; Wed, 31 May 2023 13:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q4Q1t-0002oW-K6
 for qemu-devel@nongnu.org; Wed, 31 May 2023 13:54:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q4Q1r-0007FB-Pg
 for qemu-devel@nongnu.org; Wed, 31 May 2023 13:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685555673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tpNZgPAiHR59s9Xb68FgvtijIZnqsWPFo9Ft1IXKFaE=;
 b=dLkdWqLIEs/sfA+M05qM0H8wXWLyiDy7A1QOVc4ztYiOlb6fCS87QuHI47DSoBS33ezRI+
 OD/oBWImB1C+U1C3nprJ8WOoLtG0gkc2TIRHQLrbz+O+SJy5HZ9dsrJ8l3zJppnATLZGPH
 wPqUqVa8phQIY4LmBs1opvcWobx3Tfs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-270-tFEmQIVcP--jaUaNQ5_DeA-1; Wed, 31 May 2023 13:54:29 -0400
X-MC-Unique: tFEmQIVcP--jaUaNQ5_DeA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2FD398032E4;
 Wed, 31 May 2023 17:54:29 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F267540C6EC4;
 Wed, 31 May 2023 17:54:21 +0000 (UTC)
Date: Wed, 31 May 2023 12:54:20 -0500
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, libguestfs@redhat.com, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
Subject: Re: [PATCH v3 12/14] nbd/client: Request extended headers during
 negotiation
Message-ID: <cqb3yww5ceeinh2pb5nqaljrsllu3ejkjsdueuw32cwcocumsn@okgujto2lzmn>
References: <20230515195343.1915857-1-eblake@redhat.com>
 <20230515195343.1915857-13-eblake@redhat.com>
 <1af7f692-b5de-c767-2568-1fc024a57133@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1af7f692-b5de-c767-2568-1fc024a57133@yandex-team.ru>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, May 31, 2023 at 08:39:53PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 15.05.23 22:53, Eric Blake wrote:
> > All the pieces are in place for a client to finally request extended
> > headers.  Note that we must not request extended headers when qemu-nbd
> 
> why must not? It should gracefully report ENOTSUP? Or not?

The kernel code does not yet know how to send extended requests; once
extended mode is negotiated, sending a simple request requires the
server to disconnect the connection because the client sent unexpected
magic of a compact request (because otherwise the server would reply
with an extended reply, with a magic number equally unexpected by the
client).  Likewise, the kernel doesn't even support structured replies
yet.

(Extending nbd.ko to support these things is something that may
eventually surface on my todo list, but it is not high priority right
now)

> 
> > is used to connect to the kernel module (as nbd.ko does not expect
> > them), but there is no harm in all other clients requesting them.
> > 
> > Extended headers are not essential to the information collected during
> > 'qemu-nbd --list', but probing for it gives us one more piece of
> > information in that output.  Update the iotests affected by the new
> > line of output.
> > 
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> > ---
> >   block/nbd.c                                   |  5 +--
> >   nbd/client-connection.c                       |  2 +-
> >   nbd/client.c                                  | 38 ++++++++++++-------
> >   qemu-nbd.c                                    |  3 ++
> >   tests/qemu-iotests/223.out                    |  6 +++
> >   tests/qemu-iotests/233.out                    |  5 +++
> >   tests/qemu-iotests/241.out                    |  3 ++
> >   tests/qemu-iotests/307.out                    |  5 +++
> >   .../tests/nbd-qemu-allocation.out             |  1 +
> >   9 files changed, 51 insertions(+), 17 deletions(-)
> > 
> > diff --git a/block/nbd.c b/block/nbd.c
> > index 150dfe7170c..db107ff0806 100644
> > --- a/block/nbd.c
> > +++ b/block/nbd.c
> > @@ -1146,10 +1146,9 @@ static int coroutine_fn nbd_co_receive_blockstatus_reply(BDRVNBDState *s,
> > 
> >           switch (chunk->type) {
> >           case NBD_REPLY_TYPE_BLOCK_STATUS_EXT:
> > -            wide = true;
> > -            /* fallthrough */
> >           case NBD_REPLY_TYPE_BLOCK_STATUS:
> > -            if (s->info.extended_headers != wide) {
> > +            wide = chunk->type == NBD_REPLY_TYPE_BLOCK_STATUS_EXT;
> > +            if ((s->info.header_style == NBD_HEADER_EXTENDED) != wide) {
> 
> O, that's a part of previous commit. Also, initialization of wide to false becomes unneeded.

Looks like rebasing got me.  I'll clean it up to minimize churn.

> > @@ -1041,8 +1049,10 @@ int nbd_receive_negotiate(AioContext *aio_context, QIOChannel *ioc,
> >       }
> > 
> >       switch (result) {
> > +    case 4: /* newstyle, with extended headers */
> >       case 3: /* newstyle, with structured replies */
> > -        info->header_style = NBD_HEADER_STRUCTURED;
> > +        /* Relies on encoding of _STRUCTURED and _EXTENDED */
> > +        info->header_style = result - 2;
> 
> I'd prefer explicit
> 
> info->header_style = (result == 4 ? NBD_HEADER_EXTENDED : NBD_HEADER_STRUCTURED);
> 
> with no comment

Can do. I also toyed with the idea of having this function return an
enum instead of an int, but then NBD_HEADER_* also needs states added
to express oldstyle.

> > @@ -1180,8 +1191,9 @@ int nbd_receive_export_list(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
> >               memset(&array[count - 1], 0, sizeof(*array));
> >               array[count - 1].name = name;
> >               array[count - 1].description = desc;
> > -            array[count - 1].header_style = result == 3 ?
> > -                NBD_HEADER_STRUCTURED : NBD_HEADER_SIMPLE;
> > +
> > +            /* Depends on values of _SIMPLE, _STRUCTURED, and _EXTENDED */
> > +            array[count - 1].header_style = result - 2;
> 
> Personally, I don't like enum-based arithmetics.. It's something to be very careful with and check enum definition every time.
> 
> Maybe, add enum NBDConnectionStyle : NBD_STYLE_OLD, NBD_STYLE_EXPORT_NAME, NBD_STYLE_SIMPLE, NBD_STYLE_STRUCTURED, NBD_STYLE_EXTENDED,
> and a simple function nbd_con_style_to_hdr_style: NBDConnectionStyle -> NBDHeaderStyle
> 
> Or, better, nbd_start_negotiate() may return only 0/1/2 as success values, and additionally set OUT argument *header_style?
> 
> And anyway, 0/1/2/3/4 - sounds like too much magic numeric logic
> 
> 
> (I feel, that's all a kind of taste and don't want to insist anyway)

Aha - you had the same idea as me - too many integer return values
without a name.  I'll figure out something that improves this area for
v4.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


