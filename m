Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D72770921
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 21:37:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS0ay-0001v9-P9; Fri, 04 Aug 2023 15:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qS0av-0001uL-3N
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 15:36:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qS0at-0004Wz-Aq
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 15:36:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691177773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wp+Yx/rF5YAgGgpkdhESOh9AON3CIDMcyQTnzDcRVxI=;
 b=UbqhhIL+RPofWATLRh4kD7mM0F57i2cncPYsTt9uAEI5tna8DTkrRJT3VY+myM2w7m8FhQ
 8k2YL9vhAAcYyp1klpyrDuRVlF2g1QhrXMFfIr0Zi1dMobco5M0CbKxhw77F2Xscv0k+6u
 PulaSNbtq2KjtOyUotpl5MZgRR0JB4w=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-r5YXNpafPJeQ76W-DBZvAQ-1; Fri, 04 Aug 2023 15:36:11 -0400
X-MC-Unique: r5YXNpafPJeQ76W-DBZvAQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 036B62808B23;
 Fri,  4 Aug 2023 19:36:10 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F275A492CA6;
 Fri,  4 Aug 2023 19:36:08 +0000 (UTC)
Date: Fri, 4 Aug 2023 14:36:07 -0500
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, libguestfs@redhat.com
Subject: Re: [PATCH v4 16/24] nbd/server: Support 64-bit block status
Message-ID: <g2kaumiey7rwho4p6awywn4aikyjmdelmiyexqmqfa3634se54@34nc5ekwvtki>
References: <20230608135653.2918540-1-eblake@redhat.com>
 <20230608135653.2918540-17-eblake@redhat.com>
 <26b732b9-c1e5-a032-6139-a01ac1fbd2bd@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26b732b9-c1e5-a032-6139-a01ac1fbd2bd@yandex-team.ru>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

On Tue, Jun 27, 2023 at 04:23:49PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 08.06.23 16:56, Eric Blake wrote:
> > The NBD spec states that if the client negotiates extended headers,
> > the server must avoid NBD_REPLY_TYPE_BLOCK_STATUS and instead use
> > NBD_REPLY_TYPE_BLOCK_STATUS_EXT which supports 64-bit lengths, even if
> > the reply does not need more than 32 bits.  As of this patch,
> > client->mode is still never NBD_MODE_EXTENDED, so the code added here
> > does not take effect until the next patch enables negotiation.
> > 
> > For now, all metacontexts that we know how to export never populate
> > more than 32 bits of information, so we don't have to worry about
> > NBD_REP_ERR_EXT_HEADER_REQD or filtering during handshake, and we
> > always send all zeroes for the upper 32 bits of status during
> > NBD_CMD_BLOCK_STATUS.
> > 
> > Note that we previously had some interesting size-juggling on call
> > chains, such as:
> > 
> > nbd_co_send_block_status(uint32_t length)
> > -> blockstatus_to_extents(uint32_t bytes)
> >    -> bdrv_block_status_above(bytes, &uint64_t num)
> >    -> nbd_extent_array_add(uint64_t num)
> >      -> store num in 32-bit length
> > 
> > But we were lucky that it never overflowed: bdrv_block_status_above
> > never sets num larger than bytes, and we had previously been capping
> > 'bytes' at 32 bits (since the protocol does not allow sending a larger
> > request without extended headers).  This patch adds some assertions
> > that ensure we continue to avoid overflowing 32 bits for a narrow
> 
> 
> [..]
> 
> > @@ -2162,19 +2187,23 @@ static void nbd_extent_array_convert_to_be(NBDExtentArray *ea)
> >    * would result in an incorrect range reported to the client)
> >    */
> >   static int nbd_extent_array_add(NBDExtentArray *ea,
> > -                                uint32_t length, uint32_t flags)
> > +                                uint64_t length, uint32_t flags)
> >   {
> >       assert(ea->can_add);
> > 
> >       if (!length) {
> >           return 0;
> >       }
> > +    if (!ea->extended) {
> > +        assert(length <= UINT32_MAX);
> > +    }
> > 
> >       /* Extend previous extent if flags are the same */
> >       if (ea->count > 0 && flags == ea->extents[ea->count - 1].flags) {
> > -        uint64_t sum = (uint64_t)length + ea->extents[ea->count - 1].length;
> > +        uint64_t sum = length + ea->extents[ea->count - 1].length;
> > 
> > -        if (sum <= UINT32_MAX) {
> > +        assert(sum >= length);
> > +        if (sum <= UINT32_MAX || ea->extended) {
> 
> that "if" and uint64_t sum was to avoid overflow. I think, we can't just assert, instead include the check into if:
> 
> if (sum >= length && (sum <= UINT32_MAX || ea->extended) {

Why?  The assertion is stating that there was no overflow, because we
are in control of ea->extents[ea->count - 1].length (it came from
local code performing block status, and our block layer guarantees
that no block status returns more than 2^63 bytes because we don't
support images larger than off_t).  At best, all I need is a comment
why the assertion is valid.

> 
>  ...
> 
> }
> 
> with this:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
> -- 
> Best regards,
> Vladimir
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


