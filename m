Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 604EF7188A1
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 19:41:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4PoG-00071z-4F; Wed, 31 May 2023 13:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q4PoD-0006yg-Da
 for qemu-devel@nongnu.org; Wed, 31 May 2023 13:40:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q4Po8-0003b0-Nh
 for qemu-devel@nongnu.org; Wed, 31 May 2023 13:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685554822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ASJ3l8kkn5u94s/+n1pwFGQBHPiGskgaRYKxSqN2uJ8=;
 b=gGp6LKKRzAM+mzpd7B8QsUa/yMKvVHt96nGVNErASzcR+2434Az3uRrXa9cGTUxSx+lsYv
 Z+rlK1VuroWprnyOETnQ99JbSCJ3EgfmWmjFdxGeQYXgAvRgIxjlfVNAwjvRe7A+MO08pd
 ma0Lqt6bEb/5TOH8FcOsb4jVPtp7Prw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-580-_IEm7rCxOrWfv2Tn0L-oXQ-1; Wed, 31 May 2023 13:40:15 -0400
X-MC-Unique: _IEm7rCxOrWfv2Tn0L-oXQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0B796802E58;
 Wed, 31 May 2023 17:40:15 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E577492B00;
 Wed, 31 May 2023 17:40:13 +0000 (UTC)
Date: Wed, 31 May 2023 12:40:08 -0500
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, libguestfs@redhat.com, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
Subject: Re: [PATCH v3 11/14] nbd/client: Accept 64-bit block status chunks
Message-ID: <vwat2jjjdojzbo6ip4gy33bivhfkq5k3mjsj6bj54k5axegy6y@gcanen54pjwg>
References: <20230515195343.1915857-1-eblake@redhat.com>
 <20230515195343.1915857-12-eblake@redhat.com>
 <f2f89a4e-816e-165e-2d6a-7076f1ced823@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2f89a4e-816e-165e-2d6a-7076f1ced823@yandex-team.ru>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

On Wed, May 31, 2023 at 08:00:43PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 15.05.23 22:53, Eric Blake wrote:
> > Because we use NBD_CMD_FLAG_REQ_ONE with NBD_CMD_BLOCK_STATUS, a
> > client in narrow mode should not be able to provoke a server into
> > sending a block status result larger than the client's 32-bit request.
> > But in extended mode, a 64-bit status request must be able to handle a
> > 64-bit status result, once a future patch enables the client
> > requesting extended mode.  We can also tolerate a non-compliant server
> > sending the new chunk even when it should not.
> > 
> > @@ -672,7 +681,8 @@ static int nbd_parse_blockstatus_payload(BDRVNBDState *s,
> >        * connection; just ignore trailing extents, and clamp things to
> >        * the length of our request.
> >        */
> > -    if (chunk->length > sizeof(context_id) + sizeof(*extent)) {
> > +    if (count != wide ||
> 
> hard to read for me. Could it be simply "count > 1 ||" ?

For existing commands (compact), count is initialized to 0 as it is
not transferred over the wire.  For extended commands, count is
transferred over the wire, but we expect it to be 1 (and not 0).
Comparing count != wide is more precise than checking count > 0 (which
should never happen for compact, but would be a bug for extended).

> 
> > +        chunk->length > sizeof(context_id) + wide * sizeof(count) + len) {
> >           trace_nbd_parse_blockstatus_compliance("more than one extent");
> >       }
> >       if (extent->length > orig_length) {
> > @@ -1117,7 +1127,7 @@ static int coroutine_fn nbd_co_receive_cmdread_reply(BDRVNBDState *s, uint64_t h
> > 
> >   static int coroutine_fn nbd_co_receive_blockstatus_reply(BDRVNBDState *s,
> >                                                            uint64_t handle, uint64_t length,
> > -                                                         NBDExtent *extent,
> > +                                                         NBDExtentExt *extent,
> >                                                            int *request_ret, Error **errp)
> >   {
> >       NBDReplyChunkIter iter;
> > @@ -1125,6 +1135,7 @@ static int coroutine_fn nbd_co_receive_blockstatus_reply(BDRVNBDState *s,
> >       void *payload = NULL;
> >       Error *local_err = NULL;
> >       bool received = false;
> > +    bool wide = false;
> > 
> >       assert(!extent->length);
> >       NBD_FOREACH_REPLY_CHUNK(s, iter, handle, false, NULL, &reply, &payload) {
> > @@ -1134,7 +1145,13 @@ static int coroutine_fn nbd_co_receive_blockstatus_reply(BDRVNBDState *s,
> >           assert(nbd_reply_is_structured(&reply));
> > 
> >           switch (chunk->type) {
> > +        case NBD_REPLY_TYPE_BLOCK_STATUS_EXT:
> > +            wide = true;
> > +            /* fallthrough */
> >           case NBD_REPLY_TYPE_BLOCK_STATUS:
> > +            if (s->info.extended_headers != wide) {
> > +                trace_nbd_extended_headers_compliance("block_status");
> 
> You set wide to true once, on first "NBD_REPLY_TYPE_BLOCK_STATUS_EXT", and then parse following "NBD_REPLY_TYPE_BLOCK_STATUS" if the come with wide=true.
> 
> Should it be:
> 
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -1135,7 +1135,7 @@ static int coroutine_fn nbd_co_receive_blockstatus_reply(BDRVNBDState *s,
>      void *payload = NULL;
>      Error *local_err = NULL;
>      bool received = false;
> -    bool wide = false;
> +    bool wide;
>      assert(!extent->length);
>      NBD_FOREACH_REPLY_CHUNK(s, iter, handle, false, NULL, &reply, &payload) {
> @@ -1146,9 +1146,8 @@ static int coroutine_fn nbd_co_receive_blockstatus_reply(BDRVNBDState *s,
>          switch (chunk->type) {
>          case NBD_REPLY_TYPE_BLOCK_STATUS_EXT:
> -            wide = true;
> -            /* fallthrough */
>          case NBD_REPLY_TYPE_BLOCK_STATUS:
> +            wide = chunk->type == NBD_REPLY_TYPE_BLOCK_STATUS_EXT;
>              if (s->info.extended_headers != wide) {

Good observation, since we reach this multiple times in a loop.  I'm
squashing that in.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


