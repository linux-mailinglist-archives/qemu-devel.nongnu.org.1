Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A49677BA23E
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 17:23:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoQBL-0006m5-P5; Thu, 05 Oct 2023 11:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qoQBJ-0006lO-MG
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 11:22:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qoQBG-00049i-68
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 11:22:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696519344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UOJekLKDhZT0NHiEOSvU74Z5S37pAqV339lZYsfIH/g=;
 b=e3sQvXy/x3GwddVM2qcfI1v4K/piUzWZW4Yr0T5ChAdeOCh+r9CFy/rLicoGzSFyFJbvPU
 omkzoAn5W1ag/DiXSTTkgs0uRTPMO1M445q55WGtXQ6mb3eQZyPoY8pHINXpNBW0khcm67
 NfUqU6wmdjlwKNQMeT2UY1YZMeaPPmk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-XM7ypzMNM2WHSQk-2VV9vA-1; Thu, 05 Oct 2023 11:22:15 -0400
X-MC-Unique: XM7ypzMNM2WHSQk-2VV9vA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7548E1C07837;
 Thu,  5 Oct 2023 15:22:15 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B1A53215671F;
 Thu,  5 Oct 2023 15:22:14 +0000 (UTC)
Date: Thu, 5 Oct 2023 10:22:12 -0500
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, libguestfs@redhat.com
Subject: Re: [Libguestfs] [PATCH v7 12/12] nbd/server: Add FLAG_PAYLOAD
 support to CMD_BLOCK_STATUS
Message-ID: <le5obfxckknzx4fbtzvczxtro74tjw3jmpggywsy6xymocxcza@ipm4pcgp6bdm>
References: <20230925192229.3186470-14-eblake@redhat.com>
 <20230925192229.3186470-26-eblake@redhat.com>
 <0ebcd70e-faf2-4a63-9fa6-6a2334151c22@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ebcd70e-faf2-4a63-9fa6-6a2334151c22@yandex-team.ru>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Oct 05, 2023 at 05:33:26PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > +static int
> > +nbd_co_block_status_payload_read(NBDClient *client, NBDRequest *request,
> > +                                 Error **errp)
> > +{
> > +    int payload_len = request->len;
> 
> payload_len should be uint64_t
> 
> > +    g_autofree char *buf = NULL;
> > +    size_t count, i, nr_bitmaps;
> > +    uint32_t id;
> > +
> 
> otherwise, we may do something unexpected here, when reqeuest->len is too big for int:
> 
> > +    if (payload_len > NBD_MAX_BUFFER_SIZE) {
> > +        error_setg(errp, "len (%" PRIu64 ") is larger than max len (%u)",
> > +                   request->len, NBD_MAX_BUFFER_SIZE);
> > +        return -EINVAL;
> > +    }

Oh, it looks like I introduced that same type mismatch in commit
8db7e2d6 as well, although it appears to have a latent effect until
this series enables the ability for request->length to actually exceed
32 bits.  I'll reply on 1/12 with another squash I'm making there.

> > +
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
> 
> [..]
> 
> >    * connection right away, -EAGAIN to indicate we were interrupted and the
> > @@ -2505,7 +2593,18 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req,
> >           break;
> > 
> >       case NBD_CMD_BLOCK_STATUS:
> > -        request->contexts = &client->contexts;
> > +        if (extended_with_payload) {
> > +            ret = nbd_co_block_status_payload_read(client, request, errp);
> > +            if (ret < 0) {
> > +                return ret;
> > +            }
> > +            /* payload now consumed */
> > +            check_length = extended_with_payload = false;
> 
> why set extended_with_payload to false? it's a bit misleading. And you don't do this for WRITE request.

Indeed; it doesn't make any different to later in the function.  Will drop.

> 
> > +            payload_len = 0;
> > +            valid_flags |= NBD_CMD_FLAG_PAYLOAD_LEN;
> > +        } else {
> > +            request->contexts = &client->contexts;
> > +        }
> >           valid_flags |= NBD_CMD_FLAG_REQ_ONE;
> >           break;
> > 
> 
> [..]
> 
> 
> with payload_len changed to uint64_t, your squash-in applied and s/>/>=/ fixed:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Thanks for the careful review.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


