Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D12B47B96B3
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 23:57:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo9qA-0002JI-Di; Wed, 04 Oct 2023 17:55:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qo9po-0002HN-89
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 17:55:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qo9pm-00024U-Cs
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 17:55:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696456508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d+DquCXTPWlYUk2P/pj/St/G/OoQZR+MGr1Hs6ccMTk=;
 b=TDOe7oM96Hk1FD/99rFjlHXHDbb8zK+C3jM+h1jWuuawLr3IqW/qY8ow8msdhsjlve1xz4
 oY1w/pCCda0WzzfN+sECc4Nrro5Fv9xlGw+lt4S3t/AXOAUpvOzsSMpfu0VfG2xESyKaDw
 mtFaazxyBkXgjNyKyWClJEIQviaAXSw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-XIW2Cv5PPdmUyc_yOA-NOw-1; Wed, 04 Oct 2023 17:55:05 -0400
X-MC-Unique: XIW2Cv5PPdmUyc_yOA-NOw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 15B3F382134F;
 Wed,  4 Oct 2023 21:55:05 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 63FD447AD4A;
 Wed,  4 Oct 2023 21:55:04 +0000 (UTC)
Date: Wed, 4 Oct 2023 16:55:02 -0500
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, libguestfs@redhat.com, qemu-block@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v7 12/12] nbd/server: Add FLAG_PAYLOAD support to
 CMD_BLOCK_STATUS
Message-ID: <bhi75jjd4pv2va73e2h6ypkfuo4wdzpl4s7dqesalsqkrda5ec@js77c4frs25o>
References: <20230925192229.3186470-14-eblake@redhat.com>
 <20230925192229.3186470-26-eblake@redhat.com>
 <6b380866-b707-89d5-7478-476582cdd255@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b380866-b707-89d5-7478-476582cdd255@yandex-team.ru>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
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

On Sat, Sep 30, 2023 at 04:24:02PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 25.09.23 22:22, Eric Blake wrote:
> > Allow a client to request a subset of negotiated meta contexts.  For
> > example, a client may ask to use a single connection to learn about
> > both block status and dirty bitmaps, but where the dirty bitmap
> > queries only need to be performed on a subset of the disk; forcing the
> > server to compute that information on block status queries in the rest
> > of the disk is wasted effort (both at the server, and on the amount of
> > traffic sent over the wire to be parsed and ignored by the client).
> > 
> > Qemu as an NBD client never requests to use more than one meta
> > context, so it has no need to use block status payloads.  Testing this
> > instead requires support from libnbd, which CAN access multiple meta
> > contexts in parallel from a single NBD connection; an interop test
> > submitted to the libnbd project at the same time as this patch
> > demonstrates the feature working, as well as testing some corner cases
> > (for example, when the payload length is longer than the export
> > length), although other corner cases (like passing the same id
> > duplicated) requires a protocol fuzzer because libnbd is not wired up
> > to break the protocol that badly.
> > 
> > This also includes tweaks to 'qemu-nbd --list' to show when a server
> > is advertising the capability, and to the testsuite to reflect the
> > addition to that output.
> > 
> > Of note: qemu will always advertise the new feature bit during
> > NBD_OPT_INFO if extended headers have alreay been negotiated
> > (regardless of whether any NBD_OPT_SET_META_CONTEXT negotiation has
> > occurred); but for NBD_OPT_GO, qemu only advertises the feature if
> > block status is also enabled (that is, if the client does not
> > negotiate any contexts, then NBD_CMD_BLOCK_STATUS cannot be used, so
> > the feature is not advertised).
> > 
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> > ---
> > 
> 
> [..]
> 
> > 
> > +/*
> > + * nbd_co_block_status_payload_read
> > + * Called when a client wants a subset of negotiated contexts via a
> > + * BLOCK_STATUS payload.  Check the payload for valid length and
> > + * contents.  On success, return 0 with request updated to effective
> > + * length.  If request was invalid but all payload consumed, return 0
> > + * with request->len and request->contexts->count set to 0 (which will
> > + * trigger an appropriate NBD_EINVAL response later on).  Return
> > + * negative errno if the payload was not fully consumed.
> > + */
> > +static int
> > +nbd_co_block_status_payload_read(NBDClient *client, NBDRequest *request,
> > +                                 Error **errp)
> 
> [..]
> 
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
> > +    trace_nbd_co_receive_request_payload_received(request->cookie,
> > +                                                  payload_len);
> > +    request->contexts->bitmaps = g_new0(bool, nr_bitmaps);
> > +    count = (payload_len - sizeof(NBDBlockStatusPayload)) / sizeof(id);
> > +    payload_len = 0;
> > +
> > +    for (i = 0; i < count; i++) {
> > +        id = ldl_be_p(buf + sizeof(NBDBlockStatusPayload) + sizeof(id) * i);
> > +        if (id == NBD_META_ID_BASE_ALLOCATION) {
> > +            if (request->contexts->base_allocation) {
> > +                goto skip;
> > +            }
> 
> should we also check that base_allocation is negotiated?

Oh, good point.  Without that check, the client can pass in random id
numbers that it never negotiated.  I've queued 1-11 and will probably
send a pull request for those this week, while respinning this patch
to fix the remaining issues you pointed out.

> 
> > +            request->contexts->base_allocation = true;
> > +        } else if (id == NBD_META_ID_ALLOCATION_DEPTH) {
> > +            if (request->contexts->allocation_depth) {
> > +                goto skip;
> > +            }
> 
> same here
> 
> > +            request->contexts->allocation_depth = true;
> > +        } else {
> > +            int idx = id - NBD_META_ID_DIRTY_BITMAP;
> > +
> 
> I think, we also should check that idx >=0 after this operation.
> 
> > +            if (idx > nr_bitmaps || request->contexts->bitmaps[idx]) {

Or else make idx an unsigned value, instead of signed.  Also a good catch.

> > +                goto skip;
> > +            }
> > +            request->contexts->bitmaps[idx] = true;
> > +        }
> > +    }
> > +
> > +    request->len = ldq_be_p(buf);
> > +    request->contexts->count = count;
> > +    return 0;
> > +
> > + skip:
> > +    trace_nbd_co_receive_block_status_payload_compliance(request->from,
> > +                                                         request->len);
> > +    request->len = request->contexts->count = 0;
> > +    return nbd_drop(client->ioc, payload_len, errp);
> > +}
> > +
> 
> [..]
> 
> > diff --git a/nbd/trace-events b/nbd/trace-events
> > index 8f4e20ee9f2..ac186c19ec0 100644
> > --- a/nbd/trace-events
> > +++ b/nbd/trace-events
> > @@ -70,6 +70,7 @@ nbd_co_send_chunk_read(uint64_t cookie, uint64_t offset, void *data, uint64_t si
> >   nbd_co_send_chunk_read_hole(uint64_t cookie, uint64_t offset, uint64_t size) "Send structured read hole reply: cookie = %" PRIu64 ", offset = %" PRIu64 ", len = %" PRIu64
> >   nbd_co_send_extents(uint64_t cookie, unsigned int extents, uint32_t id, uint64_t length, int last) "Send block status reply: cookie = %" PRIu64 ", extents = %u, context = %d (extents cover %" PRIu64 " bytes, last chunk = %d)"
> >   nbd_co_send_chunk_error(uint64_t cookie, int err, const char *errname, const char *msg) "Send structured error reply: cookie = %" PRIu64 ", error = %d (%s), msg = '%s'"
> > +nbd_co_receive_block_status_payload_compliance(uint64_t from, int len) "client sent unusable block status payload: from=0x%" PRIx64 ", len=0x%x"
> 
> both passed parameters request->from and request->len are uint64_t actually

Also a good catch.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


