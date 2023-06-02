Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F34547202E5
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 15:15:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q54bm-0008Cg-L0; Fri, 02 Jun 2023 09:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q54bl-0008CX-7b
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 09:14:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q54bj-0006iN-0i
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 09:14:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685711657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jxs1ZphyWuCDlx+hhWSWStEMKEfOm2Hse2M2PjI3fqk=;
 b=do+eueNNImS1jEw/q09+P6X/L5a8crblUvy4oicoQ+exwzIBkxsleoENCO8IxWoF5z5Id5
 0nKDoU3ZrKwk5GcuxxAkn6vFQBSHN29D0HnVLfbJnNk7fF/us/BBJz+N6dLbTOV3bIMhob
 6YoAmvGo81XLgtg0bR3V0OIefUUAtV8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-290-IrBnVG8COXGL7iQYzlf7lQ-1; Fri, 02 Jun 2023 09:14:16 -0400
X-MC-Unique: IrBnVG8COXGL7iQYzlf7lQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E0D27101B041;
 Fri,  2 Jun 2023 13:14:15 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 20ABEC154D7;
 Fri,  2 Jun 2023 13:14:14 +0000 (UTC)
Date: Fri, 2 Jun 2023 08:14:13 -0500
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>, 
 libguestfs@redhat.com
Subject: Re: [Libguestfs] [PATCH v3 14/14] nbd/server: Add FLAG_PAYLOAD
 support to CMD_BLOCK_STATUS
Message-ID: <7gitbsbbtwd66yy2v3t7ie5yxrvib7tytroge7eptkg3szi7gq@b2bzlyuse2rx>
References: <20230515195343.1915857-1-eblake@redhat.com>
 <20230515195343.1915857-15-eblake@redhat.com>
 <085e5837-4e5c-4972-a5d8-bbe2d3d27658@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <085e5837-4e5c-4972-a5d8-bbe2d3d27658@yandex-team.ru>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.171,
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

On Fri, Jun 02, 2023 at 12:13:25PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 15.05.23 22:53, Eric Blake wrote:
> > Allow a client to request a subset of negotiated meta contexts.  For
> > example, a client may ask to use a single connection to learn about
> > both block status and dirty bitmaps, but where the dirty bitmap
> > queries only need to be performed on a subset of the disk; forcing the
> > server to compute that information on block status queries in the rest
> > of the disk is wasted effort (both at the server, and on the amount of
> > traffic sent over the wire to be parsed and ignored by the client).
> > 
...
> > 
> > +/*
> > + * nbd_co_block_status_payload_read
> > + * Called when a client wants a subset of negotiated contexts via a
> > + * BLOCK_STATUS payload.  Check the payload for valid length and
> > + * contents.  On success, return 0 with request updated to effective
> > + * length.  If request was invalid but payload consumed, return 0 with
> > + * request->len and request->contexts.count set to 0 (which will
> > + * trigger an appropriate NBD_EINVAL response later on).
> 
> Hmm. So, it leads to
> 
>     case NBD_CMD_BLOCK_STATUS:
>         if (!request->len) {
>             return nbd_send_generic_reply(client, request, -EINVAL,
>                                           "need non-zero length", errp);
>         }
> 
> EINVAL is OK, but "need non-zero length" message is not appropriate.. I think we need separate reply for the case of invalid payload.

Or maybe just reword the error to "unexpected length", which covers a
broader swath of errors (none of which are likely from compliant
clients).

> 
> > On I/O
> > + * error, return -EIO.
> > + */
> > +static int
> > +nbd_co_block_status_payload_read(NBDClient *client, NBDRequest *request,
> > +                                 Error **errp)
> > +{
> > +    int payload_len = request->len;
> > +    g_autofree char *buf = NULL;
> > +    g_autofree bool *bitmaps = NULL;
> > +    size_t count, i;
> > +    uint32_t id;
> > +
> > +    assert(request->len <= NBD_MAX_BUFFER_SIZE);
> > +    if (payload_len % sizeof(uint32_t) ||
> > +        payload_len < sizeof(NBDBlockStatusPayload) ||
> > +        payload_len > (sizeof(NBDBlockStatusPayload) +
> > +                       sizeof(id) * client->contexts.count)) {
> > +        goto skip;
> > +    }
> > +
> > +    buf = g_malloc(payload_len);
> > +    if (nbd_read(client->ioc, buf, payload_len,
> > +                 "CMD_BLOCK_STATUS data", errp) < 0) {
> > +        return -EIO;
> > +    }
> > +    trace_nbd_co_receive_request_payload_received(request->handle,
> > +                                                  payload_len);
> > +    memset(&request->contexts, 0, sizeof(request->contexts));
> > +    request->contexts.nr_bitmaps = client->context_exp->nr_export_bitmaps;
> > +    bitmaps = g_new0(bool, request->contexts.nr_bitmaps);
> > +    count = (payload_len - sizeof(NBDBlockStatusPayload)) / sizeof(id);
> 
> In doc we have MUST: "The payload form MUST occupy 8 + n*4 bytes", do we really want to forgive and ignore unaligned tail? May be better to "goto skip" in this case, to avoid ambiguity.

That's what happened above, when checking that payload_len %
sizeof(uint32_t) was 0.  Or am I misunderstanding your question about
another condition where goto skip would be appropriate?

> 
> > +    payload_len = 0;
> > +
> > +    for (i = 0; i < count; i++) {
> > +
> > +        id = ldl_be_p(buf + sizeof(NBDBlockStatusPayload) + sizeof(id) * i);
> > +        if (id == NBD_META_ID_BASE_ALLOCATION) {
> > +            if (request->contexts.base_allocation) {
> > +                goto skip;
> > +            }
> > +            request->contexts.base_allocation = true;
> > +        } else if (id == NBD_META_ID_ALLOCATION_DEPTH) {
> > +            if (request->contexts.allocation_depth) {
> > +                goto skip;
> > +            }
> > +            request->contexts.allocation_depth = true;
> > +        } else {
> > +            if (id - NBD_META_ID_DIRTY_BITMAP >
> > +                request->contexts.nr_bitmaps ||
> > +                bitmaps[id - NBD_META_ID_DIRTY_BITMAP]) {
> > +                goto skip;
> > +            }
> > +            bitmaps[id - NBD_META_ID_DIRTY_BITMAP] = true;
> > +        }
> > +    }
> > +
> > +    request->len = ldq_be_p(buf);
> > +    request->contexts.count = count;
> > +    request->contexts.bitmaps = bitmaps;
> > +    bitmaps = NULL;
> 
> better I think:
> 
> request->context.bitmaps = g_steal_pointer(bitmaps);
> 
>  - as a pair to g_autofree.

Yes, that is shorter.

> 
> > +    return 0;
> > +
> > + skip:
> > +    trace_nbd_co_receive_block_status_payload_compliance(request->from,
> > +                                                         request->len);
> > +    request->len = request->contexts.count = 0;
> > +    return nbd_drop(client->ioc, payload_len, errp);
> > +}
> > +
> >   /* nbd_co_receive_request
> >    * Collect a client request. Return 0 if request looks valid, -EIO to drop
> >    * connection right away, -EAGAIN to indicate we were interrupted and the
> > @@ -2461,7 +2547,14 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req, NBDRequest *
> > 
> >           if (request->type == NBD_CMD_WRITE || extended_with_payload) {
> >               payload_len = request->len;
> > -            if (request->type != NBD_CMD_WRITE) {
> > +            if (request->type == NBD_CMD_BLOCK_STATUS) {
> > +                payload_len = nbd_co_block_status_payload_read(client,
> > +                                                               request,
> > +                                                               errp);
> > +                if (payload_len < 0) {
> > +                    return -EIO;
> > +                }
> 
> Seems we can handle all payload in one "switch" block, instead of handling BLOCK_STATUS here and postponing WRITE payload (and dropping) up to the end of the block with help of payload_len variable.

I can experiment with other ways of respresenting the logic; there's
enough complexity that I'm trying to balance between repeating
conditionals vs. avoiding added nesting.

> 
> > +            } else if (request->type != NBD_CMD_WRITE) {
> >                   /*
> >                    * For now, we don't support payloads on other
> >                    * commands; but we can keep the connection alive.
> > @@ -2540,6 +2633,9 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req, NBDRequest *
> >           valid_flags |= NBD_CMD_FLAG_NO_HOLE | NBD_CMD_FLAG_FAST_ZERO;
> >       } else if (request->type == NBD_CMD_BLOCK_STATUS) {
> >           valid_flags |= NBD_CMD_FLAG_REQ_ONE;
> > +        if (client->extended_headers && client->contexts.count) {
> > +            valid_flags |= NBD_CMD_FLAG_PAYLOAD_LEN;
> > +        }
> >       }
> >       if (request->flags & ~valid_flags) {
> >           error_setg(errp, "unsupported flags for command %s (got 0x%x)",

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


