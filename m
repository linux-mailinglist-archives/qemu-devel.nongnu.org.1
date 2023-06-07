Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B71725D63
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 13:40:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6rVe-0005KG-Cx; Wed, 07 Jun 2023 07:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q6rVX-0005Je-Tz
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 07:39:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q6rVU-00044H-Nk
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 07:39:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686137954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XZQtFyEG9YkuENtAcGzmeM/EPJKGb+uSFWduzM5bBYA=;
 b=P90L71CT646itg+HFl7s3q+yN/6oe3VVA7UXnmQuV7OC/xsyp3SXRJCmT0URoJ8OILNuDX
 He6HO8ysecSepR5eb4Iw2nO3Y6BqlmC6Yn4h1Jfe5GJGKXefebJLPO6toVVfwNK+mq27Rf
 zwXvVzP/Mi1NiEhbVIuiFW67XkXut4A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-EGCqsmnmMZ6655Aea4wA5Q-1; Wed, 07 Jun 2023 07:39:11 -0400
X-MC-Unique: EGCqsmnmMZ6655Aea4wA5Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F08A6185A797;
 Wed,  7 Jun 2023 11:39:10 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7593E9E93;
 Wed,  7 Jun 2023 11:39:10 +0000 (UTC)
Date: Wed, 7 Jun 2023 06:39:08 -0500
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, libguestfs@redhat.com, 
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
Subject: Re: [PATCH v3 09/14] nbd/server: Initial support for extended headers
Message-ID: <kwqe53dss3szkaq37p3f2fgebqmygjsjadr7fxibhussepuwnj@uxt2zohd2qun>
References: <20230515195343.1915857-1-eblake@redhat.com>
 <20230515195343.1915857-10-eblake@redhat.com>
 <21c33b7e-d2b2-e40b-9388-1caffe9ed5c2@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21c33b7e-d2b2-e40b-9388-1caffe9ed5c2@yandex-team.ru>
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

On Wed, May 31, 2023 at 05:46:55PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 15.05.23 22:53, Eric Blake wrote:
> > Time to support clients that request extended headers.  Now we can
> > finally reach the code added across several previous patches.
> > 
> > Even though the NBD spec has been altered to allow us to accept
> > NBD_CMD_READ larger than the max payload size (provided our response
> > is a hole or broken up over more than one data chunk), we are not
> > planning to take advantage of that, and continue to cap NBD_CMD_READ
> > to 32M regardless of header size.
> > 
> > For NBD_CMD_WRITE_ZEROES and NBD_CMD_TRIM, the block layer already
> > supports 64-bit operations without any effort on our part.  For
> > NBD_CMD_BLOCK_STATUS, the client's length is a hint, and the previous
> > patch took care of implementing the required
> > NBD_REPLY_TYPE_BLOCK_STATUS_EXT.
> > 
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> > ---
> >   nbd/nbd-internal.h |   5 +-
> 
> [..]
> 
> > 
> >   static inline void set_be_simple_reply(NBDClient *client, struct iovec *iov,
> > -                                       uint64_t error, NBDRequest *request)
> > +                                       uint32_t error, NBDStructuredError *err,
> > +                                       NBDRequest *request)
> >   {
> > -    NBDSimpleReply *reply = iov->iov_base;
> > +    if (client->header_style >= NBD_HEADER_EXTENDED) {
> > +        NBDExtendedReplyChunk *chunk = iov->iov_base;
> > 
> > -    iov->iov_len = sizeof(*reply);
> > -    stl_be_p(&reply->magic, NBD_SIMPLE_REPLY_MAGIC);
> > -    stl_be_p(&reply->error, error);
> > -    stq_be_p(&reply->handle, request->handle);
> > +        iov->iov_len = sizeof(*chunk);
> > +        stl_be_p(&chunk->magic, NBD_EXTENDED_REPLY_MAGIC);
> > +        stw_be_p(&chunk->flags, NBD_REPLY_FLAG_DONE);
> > +        stq_be_p(&chunk->handle, request->handle);
> > +        stq_be_p(&chunk->offset, request->from);
> > +        if (error) {
> > +            assert(!iov[1].iov_base);
> > +            iov[1].iov_base = err;
> > +            iov[1].iov_len = sizeof(*err);
> > +            stw_be_p(&chunk->type, NBD_REPLY_TYPE_ERROR);
> > +            stq_be_p(&chunk->length, sizeof(*err));
> > +            stl_be_p(&err->error, error);
> > +            stw_be_p(&err->message_length, 0);
> > +        } else {
> > +            stw_be_p(&chunk->type, NBD_REPLY_TYPE_NONE);
> > +            stq_be_p(&chunk->length, 0);
> > +        }
> > +    } else {
> > +        NBDSimpleReply *reply = iov->iov_base;
> > +
> > +        iov->iov_len = sizeof(*reply);
> > +        stl_be_p(&reply->magic, NBD_SIMPLE_REPLY_MAGIC);
> > +        stl_be_p(&reply->error, error);
> > +        stq_be_p(&reply->handle, request->handle);
> > +    }
> >   }
> > 
> >   static int coroutine_fn nbd_co_send_simple_reply(NBDClient *client,
> > @@ -1906,30 +1966,44 @@ static int coroutine_fn nbd_co_send_simple_reply(NBDClient *client,
> 
> So, that's not _simple_ now.. The function should be renamed. As well as set_be_simple_reply(). _simple_or_extended_ ? a bit too long. But continuing to use "simple" is in bad relation with use of "simple" word in specification.

In fact, I added an assertion that set_be_simple_reply() can only be
reached when extended replies are not in use, so none of this
complexity here was needed after all.

> 
> Probably better to update callers? The only caller isi nbd_send_generic_reply(). So, could we just add nbd_co_send_single_extended_reply() to call from nbd_send_generic_reply() in case of EXTENDED?
> 
> Also, transformation of set_be_simple_reply() do look like it should be two separate functions.
> 
> >   {
> >       NBDReply hdr;
> >       int nbd_err = system_errno_to_nbd_errno(error);
> > +    NBDStructuredError err;
> >       struct iovec iov[] = {
> >           {.iov_base = &hdr},
> >           {.iov_base = data, .iov_len = len}
> >       };
> > 
> > +    assert(!len || !nbd_err);
> >       trace_nbd_co_send_simple_reply(request->handle, nbd_err,
> >                                      nbd_err_lookup(nbd_err), len);
> > -    set_be_simple_reply(client, &iov[0], nbd_err, request);
> > +    set_be_simple_reply(client, &iov[0], nbd_err, &err, request);
> > 
> > -    return nbd_co_send_iov(client, iov, len ? 2 : 1, errp);
> > +    return nbd_co_send_iov(client, iov, iov[1].iov_len ? 2 : 1, errp);

Not introduced in this patch, but it turns out that when
iov[1].iov_len == 0, blindly passing niov==2 to nbd_co_send_iov()
still does the right thing, so I can lose the conditional here.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


