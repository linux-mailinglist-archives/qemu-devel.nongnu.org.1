Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B07F278B9D1
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 22:57:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qajHa-0001c0-K6; Mon, 28 Aug 2023 16:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qajHY-0001aL-5Y
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:56:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qajHW-0007iY-1m
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:56:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693256177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lI8dDoggjXbC7IKgRKzqAMt4wH14jYhHsLMZ4EFzAJs=;
 b=F5xJYy+FrhoOFNxZ21aBtiGXRtRG+NWzz5QCqpZtmlkXb9CxHlk4/GN4ClzU/LoQbJow5+
 YBPJcFsQYQUubqzZ9NGALxlCV0xvbOZ3a+3SUCJa4sBCKe4TevSf7uN84OtNsi8z6w0E9B
 CSfgLUHcu1nnidJW9kvV2NgjDUG01QM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-532-l9OnZGpAOmmA_UIhw03dTA-1; Mon, 28 Aug 2023 16:56:13 -0400
X-MC-Unique: l9OnZGpAOmmA_UIhw03dTA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C0295185A791;
 Mon, 28 Aug 2023 20:56:12 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2CDA7401051;
 Mon, 28 Aug 2023 20:56:12 +0000 (UTC)
Date: Mon, 28 Aug 2023 15:56:10 -0500
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@yandex-team.ru, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v5 04/17] nbd: Prepare for 64-bit request effect lengths
Message-ID: <sykbzzvezliuxph6zi4oopirs2dwqpuo673ij3quldynd6fzsz@7rac7xngkwre>
References: <20230810173646.17695-19-eblake@redhat.com>
 <20230810173646.17695-23-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810173646.17695-23-eblake@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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

On Thu, Aug 10, 2023 at 12:36:51PM -0500, Eric Blake wrote:
> Widen the length field of NBDRequest to 64-bits, although we can
> assert that all current uses are still under 32 bits: either because
> of NBD_MAX_BUFFER_SIZE which is even smaller (and where size_t can
> still be appropriate, even on 32-bit platforms), or because nothing
> ever puts us into NBD_MODE_EXTENDED yet (and while future patches will
> allow larger transactions, the lengths in play here are still capped
> at 32-bit).  Thus no semantic change.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 
> v5: tweak commit message, adjust a few more spots [Vladimir].
> 
> v4: split off enum changes to earlier patches [Vladimir]
> ---

> +++ b/include/block/nbd.h
> @@ -71,8 +71,8 @@ typedef enum NBDMode {
>   */
>  typedef struct NBDRequest {
>      uint64_t cookie;
> -    uint64_t from;
> -    uint32_t len;
> +    uint64_t from;  /* Offset touched by the command */
> +    uint64_t len;   /* Effect length; 32 bit limit without extended headers */

Despite using unsigned types here...

> +++ b/nbd/server.c
> @@ -1441,7 +1441,7 @@ static int coroutine_fn nbd_receive_request(NBDClient *client, NBDRequest *reque
>      request->type   = lduw_be_p(buf + 6);
>      request->cookie = ldq_be_p(buf + 8);
>      request->from   = ldq_be_p(buf + 16);
> -    request->len    = ldl_be_p(buf + 24);
> +    request->len    = ldl_be_p(buf + 24); /* widen 32 to 64 bits */

...this code has a nasty bug in that ldl_be_p() returns int instead of
an unsigned type, so it sign extends, breaking any client that
requests a value larger than 2G but still less than 4G.  As there are
still a few patches needing review, I'll go ahead and post a v6 with
the obvious fix folded in.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


