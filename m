Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D45D773050
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 22:25:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT6li-0005oA-Sq; Mon, 07 Aug 2023 16:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qT6lh-0005ny-91
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 16:23:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qT6lf-0000B2-Ni
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 16:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691439834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e0Slf+iQrc+jUCQ1xWNyHlBCLrlqJJeueFvcUB+XtZ4=;
 b=bRuYHTAYLbOQQuyHTXtFKWBMBiIE98wbCbPj19v6wEarMPRXpBk6yAU7liuzelqW0IvwYn
 ci3NpO8lE1lk7McmvihhXiDIgxTOzQDci9KRcLHJHVS0JNS6cQFIFL0FYszghBr312SKpR
 XzjcDtnzzCvZLnX5I8DZyxpSAI8JWbc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-627-ViV1KgBVMwCYdbEqzaJoSA-1; Mon, 07 Aug 2023 16:23:51 -0400
X-MC-Unique: ViV1KgBVMwCYdbEqzaJoSA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B360D185A78B;
 Mon,  7 Aug 2023 20:23:50 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.35])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 15A8D2026D4B;
 Mon,  7 Aug 2023 20:23:49 +0000 (UTC)
Date: Mon, 7 Aug 2023 15:23:46 -0500
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, libguestfs@redhat.com, qemu-block@nongnu.org
Subject: Re: [Libguestfs] [PATCH v4 24/24] nbd/server: Add FLAG_PAYLOAD
 support to CMD_BLOCK_STATUS
Message-ID: <v2jlbxtlcyw3h7dwvzlij7fe6pa4as6vzedy3ipbs7xhiprurd@fyorfm3u6gjn>
References: <20230608135653.2918540-1-eblake@redhat.com>
 <20230608135653.2918540-25-eblake@redhat.com>
 <e09fb0df-ddc2-d731-f735-6f5ccca69846@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e09fb0df-ddc2-d731-f735-6f5ccca69846@yandex-team.ru>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jun 27, 2023 at 10:42:20PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 08.06.23 16:56, Eric Blake wrote:
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
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> > ---
> 
> [..]
> 
> > +static int
> > +nbd_co_block_status_payload_read(NBDClient *client, NBDRequest *request,
> > +                                 Error **errp)
> > +{
> > +    int payload_len = request->len;
> > +    g_autofree char *buf = NULL;
> > +    size_t count, i, nr_bitmaps;
> > +    uint32_t id;
> > +
> > +    assert(request->len <= NBD_MAX_BUFFER_SIZE);
> > +    assert(client->contexts.exp == client->exp);
> > +    nr_bitmaps = client->exp->nr_export_bitmaps;
> > +    request->contexts = g_new0(NBDMetaContexts, 1);
> > +    request->contexts->exp = client->exp;
> > +
> > +    if (payload_len % sizeof(uint32_t) ||
> > +        payload_len < sizeof(NBDBlockStatusPayload) ||
> > +        payload_len > (sizeof(NBDBlockStatusPayload) +
> > +                       sizeof(id) * client->contexts.count)) {
> > +        goto skip;
> > +    }
> > @@ -2470,7 +2552,13 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req, NBDRequest *
> 
> [..]
> 
> > @@ -2712,7 +2804,8 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
> >                                         "discard failed", errp);
> > 
> >       case NBD_CMD_BLOCK_STATUS:
> > -        if (!request->len) {
> > +        assert(request->contexts);
> > +        if (!request->len && !(request->flags & NBD_CMD_FLAG_PAYLOAD_LEN)) {
> 
> why not error-out for len=0 in case of payload?

Because nbd_co_block_status_payload_read() already rejected that case.
But an assertion would not hurt to make it obvious.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


