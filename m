Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BB270819F
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 14:44:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzcz3-0006U4-3S; Thu, 18 May 2023 08:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pzcz1-0006Tf-Ss
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:43:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pzcyz-0006T6-OI
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684413829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=noTnnvx7hKT1ss0cfJY58pZ3y0ub1wqQkd/0n4naQSY=;
 b=hL6GsGFL387j7mCTePMXl1FseV9jthDzTCRRzthduxipufiBt+xZG49Dt5IjHua4hHN1X7
 Cq10L1tk5/+IOx43kHy0Duk/OhCqbLjcxhdgFTOqS1JZmQcxFzRfENY1DPU7JAWOewMXy5
 L2jZpMtpvFmZqpZRDN5RYakzx5H2PeE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-Tj6A0JwdMHOobZSUntBC_g-1; Thu, 18 May 2023 08:43:45 -0400
X-MC-Unique: Tj6A0JwdMHOobZSUntBC_g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C40385A588;
 Thu, 18 May 2023 12:43:45 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ADFED492B01;
 Thu, 18 May 2023 12:43:44 +0000 (UTC)
Date: Thu, 18 May 2023 07:43:43 -0500
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, stefanha@redhat.com, 
 mjt@tls.msk.ru, pbonzini@redhat.com, qemu-devel@nongnu.org, 
 qemu-stable@nongnu.org
Subject: Re: [PATCH 2/3] nbd/server: Fix drained_poll to wake coroutine in
 right AioContext
Message-ID: <2yc23l45pys5p4ebx43bka2bev25cgftg3pqmbdc7vlot2vrwx@emjxgdchhf2s>
References: <20230517152834.277483-1-kwolf@redhat.com>
 <20230517152834.277483-3-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517152834.277483-3-kwolf@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

On Wed, May 17, 2023 at 05:28:33PM +0200, Kevin Wolf wrote:
> nbd_drained_poll() generally runs in the main thread, not whatever
> iothread the NBD server coroutine is meant to run in, so it can't
> directly reenter the coroutines to wake them up.
> 
> The code seems to have the right intention, it specifies the correct
> AioContext when it calls qemu_aio_coroutine_enter(). However, this
> functions doesn't schedule the coroutine to run in that AioContext, but
> it assumes it is already called in the home thread of the AioContext.
> 
> To fix this, add a new thread-safe qio_channel_wake_read() that can be
> called in the main thread to wake up the coroutine in its AioContext,
> and use this in nbd_drained_poll().
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/io/channel.h | 10 ++++++++++
>  io/channel.c         | 33 +++++++++++++++++++++++++++------
>  nbd/server.c         |  3 +--
>  3 files changed, 38 insertions(+), 8 deletions(-)
>

Lots of support code...

> +++ b/nbd/server.c
> @@ -1599,8 +1599,7 @@ static bool nbd_drained_poll(void *opaque)
>               * enter it here so we don't depend on the client to wake it up.
>               */
>              if (client->recv_coroutine != NULL && client->read_yielding) {
> -                qemu_aio_coroutine_enter(exp->common.ctx,
> -                                         client->recv_coroutine);
> +                qio_channel_wake_read(client->ioc);
>              }

...for what boils down to a deceptively simple alternative call.  But
your reasoning made sense to me, and I can see how your new function
solves the issue.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


