Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 818BA772E96
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 21:21:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT5mF-0000Xf-A2; Mon, 07 Aug 2023 15:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qT5mC-0000X9-Io
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 15:20:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qT5mB-0000Am-3d
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 15:20:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691436021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qsB/ZcXCaJCCpKfB/YC0/EvcCFQ8u+8N1HGaym/MN7w=;
 b=c8wG0aL1ZJoXZfEKAti6kmtA7re/07mpbOr4u1R7iD/0ot6PReUumxemXYKfOgNuMIlUnD
 W1fFB/GVM/Km1JhEBM5CMrQ7eFUgJktQXJ4ENi0V4JYtymv8/yi+pz2HgaPQsLe3Ebd34e
 fj5NeZKVCUnMohxkMOgtuRmq5njoMYg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-QsaJBRpOO7aMI_VMDt5Zug-1; Mon, 07 Aug 2023 15:20:18 -0400
X-MC-Unique: QsaJBRpOO7aMI_VMDt5Zug-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B792F101A528;
 Mon,  7 Aug 2023 19:20:17 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.35])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 22C061121314;
 Mon,  7 Aug 2023 19:20:16 +0000 (UTC)
Date: Mon, 7 Aug 2023 14:20:15 -0500
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, libguestfs@redhat.com, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v4 19/24] nbd/client: Initial support for extended headers
Message-ID: <p7zstmvjs5p5rslpz3434pbxrxtbllz3okhdqu36gl4n4zlync@urc6dwy3yh37>
References: <20230608135653.2918540-1-eblake@redhat.com>
 <20230608135653.2918540-20-eblake@redhat.com>
 <22e76783-92bb-50ca-798e-a849a337ee4d@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22e76783-92bb-50ca-798e-a849a337ee4d@yandex-team.ru>
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

On Tue, Jun 27, 2023 at 05:22:09PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 08.06.23 16:56, Eric Blake wrote:
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
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> > ---
> > @@ -1508,23 +1537,28 @@ int coroutine_fn nbd_receive_reply(BlockDriverState *bs, QIOChannel *ioc,
> >                                          reply->cookie);
        case NBD_SIMPLE_REPLY_MAGIC:
            if (mode >= NBD_MODE_EXTENDED) {
                trace_nbd_receive_wrong_header(reply->magic,
                                               nbd_mode_lookup(mode));
            }
            ret = nbd_receive_simple_reply(ioc, &reply->simple, errp);
            if (ret < 0) {
                break;
            }
            trace_nbd_receive_simple_reply(reply->simple.error,
                                           nbd_err_lookup(reply->simple.error),
                                           reply->cookie);
> >           break;
> >       case NBD_STRUCTURED_REPLY_MAGIC:
> > -        ret = nbd_receive_structured_reply_chunk(ioc, &reply->structured, errp);
> > +    case NBD_EXTENDED_REPLY_MAGIC:
> > +        expected = mode >= NBD_MODE_EXTENDED ? NBD_EXTENDED_REPLY_MAGIC
> > +            : NBD_STRUCTURED_REPLY_MAGIC;
> > +        if (reply->magic != expected) {
> > +            trace_nbd_receive_wrong_header(reply->magic,
> > +                                           nbd_mode_lookup(mode));
> > +        }
> > +        ret = nbd_receive_reply_chunk_header(ioc, reply, errp);
> >           if (ret < 0) {
> >               break;
> >           }
> 
> maybe
> 
> assert(reply->magic == NBD_STRUCTURED_REPLY_MAGIC)

No, not even as a temporary assertion.  You are correct that as of
this patch, a compliant server will only be sending structured
replies, not extended (because we haven't turned on a request for
extended headers yet); but we should never assert something that a
non-compliant server can send over the wire.  So the best we can do is
trace the server's unusual response.

> 
> >           type = nbd_reply_type_lookup(reply->structured.type);
> > -        trace_nbd_receive_structured_reply_chunk(reply->structured.flags,
> > -                                                 reply->structured.type, type,
> > -                                                 reply->structured.cookie,
> > -                                                 reply->structured.length);
> > +        trace_nbd_receive_reply_chunk_header(reply->structured.flags,
> > +                                             reply->structured.type, type,
> > +                                             reply->structured.cookie,
> > +                                             reply->structured.length);
> >           break;
> >       default:
> > +        trace_nbd_receive_wrong_header(reply->magic, nbd_mode_lookup(mode));
> >           error_setg(errp, "invalid magic (got 0x%" PRIx32 ")", reply->magic);
> >           return -EINVAL;
> >       }
> > -    if (ret < 0) {
> > -        return ret;
> > -    }
> 
> hmm, mistake? Seems, we'll return 1 on error with set errp this way
> 
> > 
> >       return 1;

Indeed, I botched that logic (either keep the 'ret < 0' filter after
the switch, or change 'break' to 'return ret' within the switch).
Will fix in v5.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


