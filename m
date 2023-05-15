Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51960703F57
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 23:06:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyfNd-0002wh-NI; Mon, 15 May 2023 17:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pyfNX-0002wJ-Gq
 for qemu-devel@nongnu.org; Mon, 15 May 2023 17:05:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pyfNV-0002mC-8k
 for qemu-devel@nongnu.org; Mon, 15 May 2023 17:05:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684184708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1TJYVGVJEjIIq4FpOlDD2A+7M/5GSm5fRKqIa81p+1o=;
 b=Tr0xvtwvt6F7nF0LrS4nSPrrz0O2NKEr2Y+qjBXotp8gMcC9+FAQW5wFlI9HQ0gmmZKJbD
 OlSGLYm2uwRDtyYJfO08YUF0EfU80UB28xqFcbDYq9bFhtjxu8R82ljFI5F8k4Qw/p5T/L
 N6fqqEE4sZxRZEJ5AE3wDL7JJ753YK0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-368-WzmrsDO-Pv6SUOpWh2oKfg-1; Mon, 15 May 2023 17:05:04 -0400
X-MC-Unique: WzmrsDO-Pv6SUOpWh2oKfg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4FE03380673F;
 Mon, 15 May 2023 21:05:04 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AA37F2166B26;
 Mon, 15 May 2023 21:05:03 +0000 (UTC)
Date: Mon, 15 May 2023 16:05:01 -0500
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: libguestfs@redhat.com, vsementsov@yandex-team.ru
Subject: Re: [Libguestfs] [PATCH v3 00/14] qemu patches for 64-bit NBD
 extensions
Message-ID: <kt4izbtzgddwv6ud6i7qldaq2nj22trnglfylvaqhbaexdhn2q@vq6uob27ipno>
References: <20230515195343.1915857-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515195343.1915857-1-eblake@redhat.com>
User-Agent: NeoMutt/20230512
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


Adding qemu-block for the cover letter (not sure how I missed that the
first time).

On Mon, May 15, 2023 at 02:53:29PM -0500, Eric Blake wrote:
> 
> v2 was here:
> https://lists.gnu.org/archive/html/qemu-devel/2022-11/msg02340.html
> 
> Since then:
>  - upstream NBD has accepted the extension on a branch; once multiple
>    implementations interoperate based on that spec, it will be promoted
>    to mainline (my plan: qemu with this series, libnbd nearly ready to
>    go, nbdkit a bit further out)
>  - rebase to block changes in meantime
>  - drop RFC patches for 64-bit NBD_CMD_READ (NBD spec did not take them)
>  - per upstream spec decision, extended headers now mandates use of
>    NBD_REPLY_TYPE_BLOCK_STATUS_EXT rather than server choice based on
>    reply size, which in turn required rearranging server patches a bit
>  - other changes that I noticed while testing with parallel changes
>    being added to libnbd (link to those patches to follow in the next
>    week or so)

If it helps review, I compared to my v2 posting as follows:

001/14:[0007] [FC] 'nbd/client: Use smarter assert'
002/14:[----] [--] 'nbd/client: Add safety check on chunk payload length'
003/14:[----] [-C] 'nbd/server: Prepare for alternate-size headers'
004/14:[0099] [FC] 'nbd: Prepare for 64-bit request effect lengths'
005/14:[0002] [FC] 'nbd: Add types for extended headers'
006/14:[0012] [FC] 'nbd/server: Refactor handling of request payload'
007/14:[0026] [FC] 'nbd/server: Refactor to pass full request around'
008/14:[0052] [FC] 'nbd/server: Support 64-bit block status'
009/14:[0032] [FC] 'nbd/server: Initial support for extended headers'
010/14:[0020] [FC] 'nbd/client: Initial support for extended headers'
011/14:[0015] [FC] 'nbd/client: Accept 64-bit block status chunks'
012/14:[0042] [FC] 'nbd/client: Request extended headers during negotiation'
013/14:[0005] [FC] 'nbd/server: Prepare for per-request filtering of BLOCK_STATUS'
014/14:[0004] [FC] 'nbd/server: Add FLAG_PAYLOAD support to CMD_BLOCK_STATUS'

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


