Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E509794258
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 19:54:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdwhg-00062h-GM; Wed, 06 Sep 2023 13:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qdwhd-00062I-Kh
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 13:52:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qdwha-0001Li-Gt
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 13:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694022749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NZWupYXTGPqzGi1xguyFWErjhhScWVThOX53mmFdPy4=;
 b=IPU8kDmWYykZDXTuL2Z3rgarwVl8vRQNvkkguft4VOy2rSxk4daMO7sgy5SDA1kFLT/9lL
 BAPHM6VwLEQjTXIXJoZAVzNdXfz6Ico3wnwFqD8ByTiwU04oROxBV232pAL6ct7dCKxN3H
 FRANquFudHOz882flw8afI+pIYh/9Zo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-VsNMLkZJNg6H8YOhmwV_OA-1; Wed, 06 Sep 2023 13:52:26 -0400
X-MC-Unique: VsNMLkZJNg6H8YOhmwV_OA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A78F29AA383;
 Wed,  6 Sep 2023 17:52:26 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9589040C2070;
 Wed,  6 Sep 2023 17:52:25 +0000 (UTC)
Date: Wed, 6 Sep 2023 12:52:22 -0500
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH v6 06/17] nbd/server: Support a request payload
Message-ID: <yyoofxrmbw4g3w7ypyba3afwy6sck6d4gbv57g7wagrv75xuoj@hso5ii2sm2gg>
References: <20230829175826.377251-19-eblake@redhat.com>
 <20230829175826.377251-25-eblake@redhat.com>
 <09aa5a8f-3600-890b-4cab-eeb5897a5719@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09aa5a8f-3600-890b-4cab-eeb5897a5719@yandex-team.ru>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

On Tue, Sep 05, 2023 at 05:36:15PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 29.08.23 20:58, Eric Blake wrote:
> > Upcoming additions to support NBD 64-bit effect lengths allow for the
> > possibility to distinguish between payload length (capped at 32M) and
> > effect length (64 bits, although we generally assume 63 bits because
> > of off_t limitations).  Without that extension, only the NBD_CMD_WRITE
> > request has a payload; but with the extension, it makes sense to allow
> > at least NBD_CMD_BLOCK_STATUS to have both a payload and effect length
> > in a future patch (where the payload is a limited-size struct that in
> > turn gives the real effect length as well as a subset of known ids for
> > which status is requested).  Other future NBD commands may also have a
> > request payload, so the 64-bit extension introduces a new
> > NBD_CMD_FLAG_PAYLOAD_LEN that distinguishes between whether the header
> > length is a payload length or an effect length, rather than
> > hard-coding the decision based on the command; although a client
> > should never send a command with a payload without the negotiation
> > phase proving such extension is available, we are now able to
> > gracefully fail unexpected client payloads while keeping the
> > connection alive.  Note that we do not support the payload version of
> > BLOCK_STATUS yet.
> > 
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> > ---
> > 
> > v5: retitled from v4 13/24, rewrite on top of previous patch's switch
> > statement [Vladimir]
> > 
> > v4: less indentation on several 'if's [Vladimir]
> > ---
> >   nbd/server.c     | 33 ++++++++++++++++++++++++++++-----
> >   nbd/trace-events |  1 +
> >   2 files changed, 29 insertions(+), 5 deletions(-)
> > 
> > diff --git a/nbd/server.c b/nbd/server.c
> > index dd3ab59224c..adcfcdeacb7 100644
> > --- a/nbd/server.c
> > +++ b/nbd/server.c
> > @@ -2334,7 +2334,8 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req,
> >                                                  Error **errp)
> >   {
> >       NBDClient *client = req->client;
> > -    bool check_length = false;
> > +    bool extended_with_payload;
> > +    bool check_length;
> >       bool check_rofs = false;
> >       bool allocate_buffer = false;
> >       unsigned payload_len = 0;
> > @@ -2350,6 +2351,9 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req,
> > 
> >       trace_nbd_co_receive_request_decode_type(request->cookie, request->type,
> >                                                nbd_cmd_lookup(request->type));
> > +    check_length = extended_with_payload = client->mode >= NBD_MODE_EXTENDED &&
> > +        request->flags & NBD_CMD_FLAG_PAYLOAD_LEN;
> > +
> >       switch (request->type) {
> >       case NBD_CMD_DISC:
> >           /* Special case: we're going to disconnect without a reply,
> > @@ -2366,6 +2370,14 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req,
> >           break;
> > 
> >       case NBD_CMD_WRITE:
> > +        if (client->mode >= NBD_MODE_EXTENDED) {
> > +            if (!extended_with_payload) {
> > +                /* The client is noncompliant. Trace it, but proceed. */
> > +                trace_nbd_co_receive_ext_payload_compliance(request->from,
> > +                                                            request->len);
> > +            }
> > +            valid_flags |= NBD_CMD_FLAG_PAYLOAD_LEN;
> > +        }
> >           payload_len = request->len;
> >           check_length = true;
> >           allocate_buffer = true;
> > @@ -2407,6 +2419,15 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req,
> 
> more context:
> 
>     /* Payload and buffer handling. */
>     if (!payload_len) {
>         req->complete = true;

At this point, payload_len is equal to 0 for all but NBD_CMD_WRITE.  [1]

>     }
>     if (check_length && request->len > NBD_MAX_BUFFER_SIZE) {
>         /* READ, WRITE, CACHE */
>         error_setg(errp, "len (%" PRIu64 ") is larger than max len (%u)",
>                    request->len, NBD_MAX_BUFFER_SIZE);
>         return -EINVAL;
>     }
> 
> 
> > +    if (extended_with_payload && !allocate_buffer) {
> 
> it's correct but strange, as allocate_buffer is (READ or WRITE), and READ is totally unrelated here.

Oh, you do have a point.  If a client mistakenly passes the
extended_with_payload flag on NBD_CMD_READ, we end up skipping this
code which tries to parse off that payload, meaning we could be out of
sync for reacting to the next command; if the client is particularly
malicious, they could send payload that resembles another valid
command.  Checking specifically for !WRITE rather than for
!allocate_buffer is more accurate, although I was trying to avoid
duplicating checks that were covered in the switch statement above.

I'll have to think about this a bit.

> 
> > +        /*
> > +         * For now, we don't support payloads on other commands; but
> > +         * we can keep the connection alive by ignoring the payload.
> 
> Was it in specification, that we can safely ignore unknown payload for known commands?

Well, at this point, the client is already non-compliant, so anything
we do is best effort only (the client may have set the bit but not
sent any payload, at which case we block until the client does send
another command but we consume that command as payload; or it sent
more payload than the size it advertises and so we see a magic number
mismatch when trying to interpret those extra bytes as the next
command).

But yes, the current spec wording mentions consuming payload bytes and
then failing with NBD_EINVAL.  Is there a potential that we need to
change the spec wording, if we think a malicious client can abuse the
flag to force the server into a deadlock scenario which can be abused
as a denial-of-service attack against other clients, compared to the
more conservative approach of just disconnecting because the client
sent a bad flag?  Generally, I look at disconnecting in response to
client behavior as the least favorable response to take; attempting to
return an error message is nicer.  And being blocked on I/O is not
necessarily a denial of service (it isn't actively consuming CPU
cycles, and we don't stop servicing parallel clients).

> 
> > +         */
> > +        assert(request->type != NBD_CMD_WRITE);
> > +        payload_len = request->len;
> 
> what I don't like here, is that we already set req->complete to true for this request, when payload_len was zero.
> 
> Probably, for extended_with_payload requests we should initialize payload_len at top of the function?

Well, we DO initialize it to 0, and then assign it under NBD_CMD_READ.
But the code that sets req->complete should probably NOT be setting it
if we are about to attempt reading payload bytes; that is, back at
[1], the code there probably needs to be conditional on
extended_with_payload.

> 
> > +        request->len = 0;
> > +    }
> >       if (allocate_buffer) {>           /* READ, WRITE */
> >           req->data = blk_try_blockalign(client->exp->common.blk,
> > @@ -2417,10 +2438,12 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req,
> >           }
> >       }
> >       if (payload_len) {
> > -        /* WRITE */
> > -        assert(req->data);
> > -        ret = nbd_read(client->ioc, req->data, payload_len,
> > -                       "CMD_WRITE data", errp);
> > +        if (req->data) {
> 
> and req->data is actually (READ or WRITE) ( == allocated_buffer) as well.
> 
> I'd prefer here "if (request->type == NBD_CMD_WRITE)" here

Looks like I'll be respinning this patch slightly.

> 
> > +            ret = nbd_read(client->ioc, req->data, payload_len,
> > +                           "CMD_WRITE data", errp);
> > +        } else {
> > +            ret = nbd_drop(client->ioc, payload_len, errp);
> > +        }
> >           if (ret < 0) {
> >               return -EIO;
> >           }
> > diff --git a/nbd/trace-events b/nbd/trace-events
> > index f9dccfcfb44..c1a3227613f 100644
> > --- a/nbd/trace-events
> > +++ b/nbd/trace-events
> > @@ -71,6 +71,7 @@ nbd_co_send_extents(uint64_t cookie, unsigned int extents, uint32_t id, uint64_t
> >   nbd_co_send_chunk_error(uint64_t cookie, int err, const char *errname, const char *msg) "Send structured error reply: cookie = %" PRIu64 ", error = %d (%s), msg = '%s'"
> >   nbd_co_receive_request_decode_type(uint64_t cookie, uint16_t type, const char *name) "Decoding type: cookie = %" PRIu64 ", type = %" PRIu16 " (%s)"
> >   nbd_co_receive_request_payload_received(uint64_t cookie, uint64_t len) "Payload received: cookie = %" PRIu64 ", len = %" PRIu64
> > +nbd_co_receive_ext_payload_compliance(uint64_t from, uint64_t len) "client sent non-compliant write without payload flag: from=0x%" PRIx64 ", len=0x%" PRIx64
> >   nbd_co_receive_align_compliance(const char *op, uint64_t from, uint64_t len, uint32_t align) "client sent non-compliant unaligned %s request: from=0x%" PRIx64 ", len=0x%" PRIx64 ", align=0x%" PRIx32
> >   nbd_trip(void) "Reading request"
> > 
> 
> -- 
> Best regards,
> Vladimir
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


