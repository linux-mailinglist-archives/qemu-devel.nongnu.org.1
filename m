Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E2F77090F
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 21:29:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS0TR-00069Y-8f; Fri, 04 Aug 2023 15:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qS0TJ-00067y-BR
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 15:28:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qS0TH-00020X-Ef
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 15:28:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691177302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mVzSAslNpyKHZV6te6N0KKjdVcq8oQTiBHnnYxR4diA=;
 b=UmqIIjKushPoVNrDZ8kMgPdVQW2l+XVZ+DB01YprW7CY6DJiW9BRzRTk3MU7nY3HkXBkQC
 NRCWDu9taC7R/izQdla66DeHhQR4oA0rq3l/oPLYR1zt8Ghm3A92SNEbfRzBF4DEcIvVi6
 j5o/1YpRdf+PaKqWspJD8Kz//TOu5bE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-696-TFp390avNGCKYqnmZUc9qQ-1; Fri, 04 Aug 2023 15:28:19 -0400
X-MC-Unique: TFp390avNGCKYqnmZUc9qQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C13DB185A78F;
 Fri,  4 Aug 2023 19:28:18 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B872D1121325;
 Fri,  4 Aug 2023 19:28:17 +0000 (UTC)
Date: Fri, 4 Aug 2023 14:28:15 -0500
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, libguestfs@redhat.com
Subject: Re: [PATCH v4 15/24] nbd/server: Prepare to send extended header
 replies
Message-ID: <ihi2p477ztmxttpcr4u5kajb3xbc777yqjzwumlzvrhiuub62m@bhtdkgqftdcg>
References: <20230608135653.2918540-1-eblake@redhat.com>
 <20230608135653.2918540-16-eblake@redhat.com>
 <90f29beb-c032-b057-733e-b272ccb8deb0@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90f29beb-c032-b057-733e-b272ccb8deb0@yandex-team.ru>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jun 16, 2023 at 09:48:18PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 08.06.23 16:56, Eric Blake wrote:
> > Although extended mode is not yet enabled, once we do turn it on, we
> > need to reply with extended headers to all messages.  Update the low
> > level entry points necessary so that all other callers automatically
> > get the right header based on the current mode.
> > 
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> > ---
> > 
> > v4: new patch, split out from v3 9/14
> > ---
> >   nbd/server.c | 30 ++++++++++++++++++++++--------
> >   1 file changed, 22 insertions(+), 8 deletions(-)
> > 
> > diff --git a/nbd/server.c b/nbd/server.c
> > index 119ac765f09..84c848a31d3 100644
> > --- a/nbd/server.c
> > +++ b/nbd/server.c
> > @@ -1947,8 +1947,6 @@ static inline void set_be_chunk(NBDClient *client, struct iovec *iov,
> >                                   size_t niov, uint16_t flags, uint16_t type,
> >                                   NBDRequest *request)
> >   {
> > -    /* TODO - handle structured vs. extended replies */
> > -    NBDStructuredReplyChunk *chunk = iov->iov_base;
> >       size_t i, length = 0;
> > 
> >       for (i = 1; i < niov; i++) {
> > @@ -1956,12 +1954,26 @@ static inline void set_be_chunk(NBDClient *client, struct iovec *iov,
> >       }
> >       assert(length <= NBD_MAX_BUFFER_SIZE + sizeof(NBDStructuredReadData));
> > 
> > -    iov[0].iov_len = sizeof(*chunk);
> > -    stl_be_p(&chunk->magic, NBD_STRUCTURED_REPLY_MAGIC);
> > -    stw_be_p(&chunk->flags, flags);
> > -    stw_be_p(&chunk->type, type);
> > -    stq_be_p(&chunk->cookie, request->cookie);
> > -    stl_be_p(&chunk->length, length);
> > +    if (client->mode >= NBD_MODE_EXTENDED) {
> > +        NBDExtendedReplyChunk *chunk = iov->iov_base;
> > +
> > +        iov->iov_len = sizeof(*chunk);
> 
> I'd prefer to keep iov[0].iov_len notation, to stress that iov is an array
> 
> anyway:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

I can make that change, and keep your R-b.

> 
> > +        stl_be_p(&chunk->magic, NBD_EXTENDED_REPLY_MAGIC);
> > +        stw_be_p(&chunk->flags, flags);
> > +        stw_be_p(&chunk->type, type);
> > +        stq_be_p(&chunk->cookie, request->cookie);
> 
> Hm. Not about this patch:
> 
> we now moved to simple cookies. And it seems that actually, 64bit is too much for number of request.

You're right that it's more than qemu cared about.  But there may be
other implementations that really do store a 64-bit pointer as their
opaque cookie, for ease of reverse-lookup on which command the
server's reply corresponds to, so I don't see it changing any time
soon in the NBD protocol.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


