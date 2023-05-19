Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE46E708CCF
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 02:19:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pznpx-0000YO-0V; Thu, 18 May 2023 20:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pznpr-0000Xg-03
 for qemu-devel@nongnu.org; Thu, 18 May 2023 20:19:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pznpp-0001pi-Cv
 for qemu-devel@nongnu.org; Thu, 18 May 2023 20:19:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684455544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oaXrwy83qppglQqMsQxjXsygcQ3kYt7b1pYV3/XPqVE=;
 b=UXXHo3+s4LDUD1FmQVmKk5xfCaY9PwXb+6oaDOStazyGmjMYr3jO7TtVz3l9mbXoh6LvT8
 DhSn3MOeAtaY3NfPrtASYwAHHPDFEuqbShlOQN64iUINN78dKJBNwAHlIbhm11S93M4JSw
 szpnM4lmxnRIC2wk8mtaRRjjAUnVdTM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-286-uzkgamGeMV2u9rf44o44xQ-1; Thu, 18 May 2023 20:19:01 -0400
X-MC-Unique: uzkgamGeMV2u9rf44o44xQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7BA94101A551;
 Fri, 19 May 2023 00:19:00 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2016640C2063;
 Fri, 19 May 2023 00:18:43 +0000 (UTC)
Date: Thu, 18 May 2023 19:18:42 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, 
 Julia Suvorova <jusual@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Stefano Garzarella <sgarzare@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, 
 Paul Durrant <paul@xen.org>, Anthony Perard <anthony.perard@citrix.com>, 
 Aarushi Mehta <mehta.aaru20@gmail.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 4/6] block/io_uring: convert to blk_io_plug_call() API
Message-ID: <7xerljqzrhzvl73beu7dboq3d6jbxbkrxbhs25xzcw5ozopgbn@3olwj3w5fil5>
References: <20230517221022.325091-1-stefanha@redhat.com>
 <20230517221022.325091-5-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517221022.325091-5-stefanha@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, May 17, 2023 at 06:10:20PM -0400, Stefan Hajnoczi wrote:
> Stop using the .bdrv_co_io_plug() API because it is not multi-queue
> block layer friendly. Use the new blk_io_plug_call() API to batch I/O
> submission instead.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/block/raw-aio.h |  7 -------
>  block/file-posix.c      | 10 ---------
>  block/io_uring.c        | 45 ++++++++++++++++-------------------------
>  block/trace-events      |  5 ++---
>  4 files changed, 19 insertions(+), 48 deletions(-)
> 

> @@ -337,7 +325,6 @@ void luring_io_unplug(void)
>   * @type: type of request
>   *
>   * Fetches sqes from ring, adds to pending queue and preps them
> - *
>   */
>  static int luring_do_submit(int fd, LuringAIOCB *luringcb, LuringState *s,
>                              uint64_t offset, int type)
> @@ -370,14 +357,16 @@ static int luring_do_submit(int fd, LuringAIOCB *luringcb, LuringState *s,

Looks a bit like a stray hunk, but you are touching the function, so
it's okay.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


