Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC2A79237E
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 16:26:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdWz8-000356-Dh; Tue, 05 Sep 2023 10:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qdWz5-00031N-W4
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 10:24:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qdWz3-0008ES-Hv
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 10:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693923888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VI7pwGuac7i6G68mhyuN+JzX2tT8evEIk2spaZ49J4w=;
 b=TUK+0uVJXDcpno4CNha3VtsqQp55lIWjL7ZL4gvvFgkusNmE0WUDSBP7JtJ9vvKJawNMdE
 4TrbU7ybAJF2Du8AuNviKBpvP6MUYplcq9K2ZybmuZe17NoOIb+bMBSw7m/9O2a7KGwF2a
 e61ek/Jicw1VRdhwuWTFUlATSBCDFb0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511-niqZ14BSN0CtIc6DqZnpTw-1; Tue, 05 Sep 2023 10:24:42 -0400
X-MC-Unique: niqZ14BSN0CtIc6DqZnpTw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A76CD3C1014C;
 Tue,  5 Sep 2023 14:24:38 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 98C136B5AA;
 Tue,  5 Sep 2023 14:24:37 +0000 (UTC)
Date: Tue, 5 Sep 2023 09:24:35 -0500
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 peter.maydell@linaro.com
Subject: Re: [PATCH v6 04/17] nbd: Prepare for 64-bit request effect lengths
Message-ID: <54b6a72ltz7uvb2lyhlyi4aptz2oaxyb7d5egsj24t7ueibqjb@tds7ps6lfvis>
References: <20230829175826.377251-19-eblake@redhat.com>
 <20230829175826.377251-23-eblake@redhat.com>
 <3a136ddb-2ea7-ef26-d9b8-7f55f068996c@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a136ddb-2ea7-ef26-d9b8-7f55f068996c@yandex-team.ru>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

On Mon, Sep 04, 2023 at 07:15:04PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 29.08.23 20:58, Eric Blake wrote:
> > Widen the length field of NBDRequest to 64-bits, although we can
> > assert that all current uses are still under 32 bits: either because
> > of NBD_MAX_BUFFER_SIZE which is even smaller (and where size_t can
> > still be appropriate, even on 32-bit platforms), or because nothing
> > ever puts us into NBD_MODE_EXTENDED yet (and while future patches will
> > allow larger transactions, the lengths in play here are still capped
> > at 32-bit).  There are no semantic changes, other than a typo fix in a
> > couple of error messages.
> > 
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> > ---
> > 
> > v6: fix sign extension bug
> > 
> > v5: tweak commit message, adjust a few more spots [Vladimir]
> > 
> > v4: split off enum changes to earlier patches [Vladimir]
> 
> [..]
> 
> > --- a/nbd/server.c
> > +++ b/nbd/server.c
> > @@ -1165,7 +1165,7 @@ static int nbd_negotiate_options(NBDClient *client, Error **errp)
> >           client->optlen = length;
> > 
> >           if (length > NBD_MAX_BUFFER_SIZE) {
> > -            error_setg(errp, "len (%" PRIu32" ) is larger than max len (%u)",
> > +            error_setg(errp, "len (%" PRIu32 ") is larger than max len (%u)",
> >                          length, NBD_MAX_BUFFER_SIZE);
> >               return -EINVAL;
> >           }
> > @@ -1441,7 +1441,7 @@ static int coroutine_fn nbd_receive_request(NBDClient *client, NBDRequest *reque
> >       request->type   = lduw_be_p(buf + 6);
> >       request->cookie = ldq_be_p(buf + 8);
> >       request->from   = ldq_be_p(buf + 16);
> > -    request->len    = ldl_be_p(buf + 24);
> > +    request->len    = (uint32_t)ldl_be_p(buf + 24); /* widen 32 to 64 bits */
> 
> should it be "(uint64_t)" ?

No. ldl_be_p() returns an int.  Widening int to 64 bits sign-extends;
we have to first make it unsigned (by casting to uint32_t) so that we
then have an unsigned value that widens by zero-extension.

Maybe we should fix ldl_bd_p() and friends to favor unsigned values.
'git grep ldul_be' has zero hits; even though Peter just touched the
docs patch claiming it exists:

https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg00645.html


> 
> > 
> >       trace_nbd_receive_request(magic, request->flags, request->type,
> >                                 request->from, request->len);
> > @@ -1899,7 +1899,7 @@ static int coroutine_fn nbd_co_send_simple_reply(NBDClient *client,
> >                                                    NBDRequest *request,
> >                                                    uint32_t error,
> >                                                    void *data,
> > -                                                 size_t len,
> > +                                                 uint64_t len,
> >                                                    Error **errp)
> >   {
> >       NBDSimpleReply reply;
> > @@ -1910,6 +1910,7 @@ static int coroutine_fn nbd_co_send_simple_reply(NBDClient *client,
> >       };
> > 
> >       assert(!len || !nbd_err);
> > +    assert(len <= NBD_MAX_STRING_SIZE);
> 
> NBD_MAX_BUFFER_SIZE ?

No. MAX_STRING_SIZE is 4k, MAX_BUFFER_SIZE is 32M.  The smaller size
is the correct bound here (an error message has to be transmitted as a
single string, and the recipient does not expect more than a 4k error
message).

> 
> with that fixed:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


