Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6717B0991
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 18:04:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlWxN-00081r-I2; Wed, 27 Sep 2023 12:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qlWxK-00081K-QU
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 12:00:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qlWx7-0006DG-VM
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 11:59:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695830392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BuTPt2ahprZ1jmvINf3S2J6aygPMuEU42DcVZC/OYe8=;
 b=GmPv3hktpkLgWObcz15IRatG12z3sjvzkF17P7fB/CUfz60XYJdQ5/ny0cu5x59rJ/kAdG
 p8jZ7BCG/8vTc16vi+XTqMDjgqQrwF8qaPpxBDpChoR+Ek4kk9twfym8J1VPJPRbpEasqQ
 HFvQF4G8sfDcksF57kuhH6aaGe5v9xc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-470-2ZboPPR_NJ-GTrq5ZSJhIQ-1; Wed, 27 Sep 2023 11:59:49 -0400
X-MC-Unique: 2ZboPPR_NJ-GTrq5ZSJhIQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6FA9E280A9CC;
 Wed, 27 Sep 2023 15:59:49 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E25C40C2070;
 Wed, 27 Sep 2023 15:59:43 +0000 (UTC)
Date: Wed, 27 Sep 2023 10:59:41 -0500
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, libguestfs@redhat.com, qemu-block@nongnu.org
Subject: Re: [PATCH v7 01/12] nbd/server: Support a request payload
Message-ID: <yi725wlzhqhumdyv7wswuubpprae5py5nuhl2fepdgx5ojo5np@d366mhjatqxc>
References: <20230925192229.3186470-14-eblake@redhat.com>
 <20230925192229.3186470-15-eblake@redhat.com>
 <523f5553-b62d-3e24-6fc7-8a350f2b6606@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <523f5553-b62d-3e24-6fc7-8a350f2b6606@yandex-team.ru>
User-Agent: NeoMutt/20230517-449-a10573
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Sep 27, 2023 at 11:55:41AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 25.09.23 22:22, Eric Blake wrote:
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
> > hard-coding the decision based on the command.
> > 
> > According to the spec, a client should never send a command with a
> > payload without the negotiation phase proving such extension is
> > available.  So in the unlikely event the bit is set or cleared
> > incorrectly, the client is already at fault; if the client then
> > provides the payload, we can gracefully consume it off the wire and
> > fail the command with NBD_EINVAL (subsequent checks for magic numbers
> > ensure we are still in sync), while if the client fails to send
> > payload we block waiting for it (basically deadlocking our connection
> > to the bad client, but not negatively impacting our ability to service
> > other clients, so not a security risk).  Note that we do not support
> > the payload version of BLOCK_STATUS yet.
> > 
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> > ---
> > 
> > v7: another try at better logic [Vladimir]
> > 
> > v5: retitled from v4 13/24, rewrite on top of previous patch's switch
> > statement [Vladimir]
> > 
> > v4: less indentation on several 'if's [Vladimir]
> > ---
> >   nbd/server.c     | 37 +++++++++++++++++++++++++++++++++----
> >   nbd/trace-events |  1 +
> >   2 files changed, 34 insertions(+), 4 deletions(-)
> > 
> > diff --git a/nbd/server.c b/nbd/server.c
> > index 7a6f95071f8..1eabcfc908d 100644
> > --- a/nbd/server.c
> > +++ b/nbd/server.c
> > @@ -2322,9 +2322,11 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req,
> >                                                  Error **errp)
> >   {
> >       NBDClient *client = req->client;
> > +    bool extended_with_payload;
> >       bool check_length = false;
> >       bool check_rofs = false;
> >       bool allocate_buffer = false;
> > +    bool payload_okay = false;
> >       unsigned payload_len = 0;
> >       int valid_flags = NBD_CMD_FLAG_FUA;
> >       int ret;
> > @@ -2338,6 +2340,13 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req,
> > 
> >       trace_nbd_co_receive_request_decode_type(request->cookie, request->type,
> >                                                nbd_cmd_lookup(request->type));
> > +    extended_with_payload = client->mode >= NBD_MODE_EXTENDED &&
> > +        request->flags & NBD_CMD_FLAG_PAYLOAD_LEN;
> > +    if (extended_with_payload) {
> > +        payload_len = request->len;
> > +        check_length = true;
> > +    }
> > +
> >       switch (request->type) {
> >       case NBD_CMD_DISC:
> >           /* Special case: we're going to disconnect without a reply,
> > @@ -2354,6 +2363,15 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req,
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
> > +        payload_okay = true;
> >           payload_len = request->len;
> >           check_length = true;
> >           allocate_buffer = true;
> > @@ -2395,6 +2413,14 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req,
> >                      request->len, NBD_MAX_BUFFER_SIZE);
> >           return -EINVAL;
> >       }
> > +    if (payload_len && !payload_okay) {
> > +        /*
> > +         * For now, we don't support payloads on other commands; but
> > +         * we can keep the connection alive by ignoring the payload.
> > +         */
> > +        assert(request->type != NBD_CMD_WRITE);
> > +        request->len = 0;
> 
> So, actually we handle a syntactic request with len=0 and return success... I'm afraid, that in the most scenarios that would not be what client want, but client will be confused by success return.

If request->len == 0, then payload_len is also 0 and we do not enter
this block, even when !payload_okay.  A 0-byte NBD_CMD_READ is already
unspecified by the NBD spec (although I think we do permit it as a
no-op where we return success).  But that is not the whole picture -
even if the client passes a payload length 0f 0, it is important to
remember that NBD_CMD_READ did not add NBD_CMD_FLAG_PAYLOAD_LEN to
valid_flags, so later in this function, whether or not we have payload
bytes to slurp off, we will still fail the command with EINVAL for
passing an unexpected flag when doing the comparison against
valid_flags.

But I agree that adding a comment to that effect would help.

> 
> So, for example, if client pass READ with positive length and accidentlly set NBD_CMD_FLAG_PAYLOAD_LEN bit, it will get successful result with wrong length=0.

In that particular case, you argue the client did NOT pass in payload
bytes; so our attempt to read payload bytes will block until the
client issues enough subsequent commands to actually satisfy the
payload_len (or we see early EOF when the client hangs up after
noticing we have not responded to commands in a while).  We are
effectively ignoring all such subsequent commands (having treated them
as NBD_CMD_READ payload instead of independent commands), and if we
finally do get enough bytes to satisfy the full payload, it is highly
likely that we will not land on a clean command boundary and
disconnect when we see a magic number mismatch.  Less likely is the
payload_len ending exactly on a command boundary; but hopefully our
return of NBD_EINVAL will explain to the client why we have ignored
its subsequent commands.  At any rate, the bug is in the client for
sending an unsupported flag; anything we do beyond that point is best
effort, and the most important part is that if we attempted to keep
the connection alive, we are at least not letting the client cause us
to do unintended actions.

> Or, for WRITE_ZEROES (with accidental NBD_CMD_FLAG_PAYLOAD_LEN) it will just get successful result, when actually nothing is done.

Again, once we consume payload_len bytes (if we did not outright close
the connection because the count was larger than 32M and we were
unwilling to wade through that many payload bytes, thanks to
check_length), we are most likely to hit a magic number mismatch after
having ignored all intermediate commands that came in; but the
NBD_COMMAND_WRITE_ZEROES will receive an NBD_EINVAL failure, not
success, for not satisfying valid_flags.

Which do we think is more likely: a client accidentally setting the
flag but not passing payload, or a client purposefully setting the
flag and including payload?  If the former, then it may be nicer to
just disconnect any time we see the flag set unexpectedly; trying to
keep the connection alive will ignore subsequent client commands, and
likely (but not always) eventually result in a magic number mismatch
once payload_len bytes are ignored.  If the latter, then skipping
payload bytes keeps us in sync, so that we can read the next command.

> 
> > +    }
> >       if (allocate_buffer) {
> >           /* READ, WRITE */
> >           req->data = blk_try_blockalign(client->exp->common.blk,
> > @@ -2405,10 +2431,13 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req,
> >           }
> >       }
> >       if (payload_len) {
> > -        /* WRITE */
> > -        assert(req->data);
> > -        ret = nbd_read(client->ioc, req->data, payload_len,
> > -                       "CMD_WRITE data", errp);
> > +        if (payload_okay) {
> > +            assert(req->data);
> > +            ret = nbd_read(client->ioc, req->data, payload_len,
> > +                           "CMD_WRITE data", errp);
> > +        } else {
> > +            ret = nbd_drop(client->ioc, payload_len, errp);

We could also try to be a bit more complicated by peeking at the next
few bytes: if they look like a magic number of the next request,
assume the client set the bit accidentally but didn't send a payload
after all; for anything else, assume the client did pass a payload.
But adding in machinery to peek at a prefix is more complex than
either assuming a payload is always present (as done in this patch) or
assuming the bit was in error (and dropping the connection
unconditionally).  Preferences?

At any rate, deciding what to do when dealing with a non-compliant
client should NOT hold up reviews of the rest of the series, which
only worry about compliant clients that never trigger this issue.
Worded differently, the important aspect of the review of this patch
is whether we see any scenario where a non-compliant client could
cause the server to misbehave, at which point declaring that we would
prefer to disconnect immediately rather than attempt to resync may be
safer, even though it is more abrupt.  But if we are satisfied that
the ill-behaved client cannot crash the server, trying to keep the
connection alive (at least, until we later hit a magic number
mismatch) is probably nicer.

> > +        }
> >           if (ret < 0) {
> >               return -EIO;
> >           }

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


