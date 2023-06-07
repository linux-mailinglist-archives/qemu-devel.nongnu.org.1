Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7795072687E
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 20:23:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6xnq-00008Q-F2; Wed, 07 Jun 2023 14:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q6xno-00007z-5S
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 14:22:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q6xnm-0004hd-HG
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 14:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686162153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gP2HpbS/j7HU7pIBhD8zOjAEXVj+BQabu5kvR33h0Ig=;
 b=GOH24PiK6IOLiHdSnWR1gn5CYqE9SbOQy/NjC4hlqaq06Waho3YsKL/94TFTykMjibbSe5
 gR7BhY31Fb63qNCn8iS4XDs5JlTFszXoCV58ojx22ck5cUjlM64fVLnDTFIHjBGA7oKj+F
 Lv1QXE6fx9PSVhsU39YOAp8jFeKrt7U=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-63-ogxyeNeqO4yjkoG25USkrA-1; Wed, 07 Jun 2023 14:22:30 -0400
X-MC-Unique: ogxyeNeqO4yjkoG25USkrA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 564271C00B9B;
 Wed,  7 Jun 2023 18:22:30 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A325B9E8B;
 Wed,  7 Jun 2023 18:22:29 +0000 (UTC)
Date: Wed, 7 Jun 2023 13:22:27 -0500
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, libguestfs@redhat.com, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
Subject: Re: [PATCH v3 10/14] nbd/client: Initial support for extended headers
Message-ID: <6acudhjle7jke537s7hxbit4t3wikk325ewnzjvb5poqm3ndlr@wibmfb7w6o2j>
References: <20230515195343.1915857-1-eblake@redhat.com>
 <20230515195343.1915857-11-eblake@redhat.com>
 <b9dba014-3df4-e87e-8341-3653895d9e9b@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9dba014-3df4-e87e-8341-3653895d9e9b@yandex-team.ru>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The subject lines are confusing: 9/14 enables extended headers in the
server, while this one does not yet enable the headers but is merely a
preliminary step.  I'll probably retitle one or the other in v4.

On Wed, May 31, 2023 at 06:26:17PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 15.05.23 22:53, Eric Blake wrote:
> > Update the client code to be able to send an extended request, and
> > parse an extended header from the server.  Note that since we reject
> > any structured reply with a too-large payload, we can always normalize
> > a valid header back into the compact form, so that the caller need not
> > deal with two branches of a union.  Still, until a later patch lets
> > the client negotiate extended headers, the code added here should not
> > be reached.  Note that because of the different magic numbers, it is
> > just as easy to trace and then tolerate a non-compliant server sending
> > the wrong header reply as it would be to insist that the server is
> > compliant.
> > 
> > The only caller to nbd_receive_reply() always passed NULL for errp;
> > since we are changing the signature anyways, I decided to sink the
> > decision to ignore errors one layer lower.
> 
> This way nbd_receive_simple_reply() and nbd_receive_structured_reply_chunk() are called now only with explicit NULL last argument.. And we start to drop all errors.
> 
> Also, actually, we'd better add errp parameter to the caller - nbd_receive_replies(), because its caller (nbd_co_do_receive_one_chunk()) will benefit of it, as it already has errp.

I can explore plumbing errp back through for v4.

> > @@ -1394,28 +1401,34 @@ static int nbd_receive_simple_reply(QIOChannel *ioc, NBDSimpleReply *reply,
> > 
> >   /* nbd_receive_structured_reply_chunk
> >    * Read structured reply chunk except magic field (which should be already
> > - * read).
> > + * read).  Normalize into the compact form.
> >    * Payload is not read.
> >    */
> > -static int nbd_receive_structured_reply_chunk(QIOChannel *ioc,
> > -                                              NBDStructuredReplyChunk *chunk,
> > +static int nbd_receive_structured_reply_chunk(QIOChannel *ioc, NBDReply *chunk,
> >                                                 Error **errp)
> 
> Hmm, _structured_or_extened_ ? Or at least in comment above the function we should mention this.

I'm going with 'nbd_receive_reply_chunk', since both structured and
extended modes receive chunks.

> 
> >   {
> >       int ret;
> > +    size_t len;
> > +    uint64_t payload_len;
> > 
> > -    assert(chunk->magic == NBD_STRUCTURED_REPLY_MAGIC);
> > +    if (chunk->magic == NBD_STRUCTURED_REPLY_MAGIC) {
> > +        len = sizeof(chunk->structured);
> > +    } else {
> > +        assert(chunk->magic == NBD_EXTENDED_REPLY_MAGIC);
> > +        len = sizeof(chunk->extended);
> > +    }
> > 
> >       ret = nbd_read(ioc, (uint8_t *)chunk + sizeof(chunk->magic),
> > -                   sizeof(*chunk) - sizeof(chunk->magic), "structured chunk",
> 
> Would be good to print "extended chunk" in error message for EXTENDED case.

Or even just "chunk header", which covers both modes.

> >   int coroutine_fn nbd_receive_reply(BlockDriverState *bs, QIOChannel *ioc,
> > -                                   NBDReply *reply, Error **errp)
> > +                                   NBDReply *reply, NBDHeaderStyle hdr)
> >   {
> >       int ret;
> >       const char *type;
> > 
> > -    ret = nbd_read_eof(bs, ioc, &reply->magic, sizeof(reply->magic), errp);
> > +    ret = nbd_read_eof(bs, ioc, &reply->magic, sizeof(reply->magic), NULL);
> >       if (ret <= 0) {
> >           return ret;
> >       }
> > 
> >       reply->magic = be32_to_cpu(reply->magic);
> > 
> > +    /* Diagnose but accept wrong-width header */
> >       switch (reply->magic) {
> >       case NBD_SIMPLE_REPLY_MAGIC:
> > -        ret = nbd_receive_simple_reply(ioc, &reply->simple, errp);
> > +        if (hdr >= NBD_HEADER_EXTENDED) {
> > +            trace_nbd_receive_wrong_header(reply->magic);
> 
> maybe, trace also expected style

Sure, I can give that a shot.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


