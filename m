Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5902A708CA3
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 02:05:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzncN-0004n2-Kf; Thu, 18 May 2023 20:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pzncF-0004l1-Vv
 for qemu-devel@nongnu.org; Thu, 18 May 2023 20:05:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pzncD-0007pu-Ra
 for qemu-devel@nongnu.org; Thu, 18 May 2023 20:05:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684454700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L1bW03zBeN+IDObTz00Q0SyhMk0VOr4i17hlQ4QvYdg=;
 b=XNsg5tjHCKtRzRepCzd339kPCJ3A5bJljLlFNarEf6rO53B6hMQYg6zjJIe3vZs4lFyY5V
 2kWHlf5ELqK2BRTzCCmjuicQD8HwbhnmDfPcsT4b85VFunGisAON1viNdrt/c4dg8cVPEl
 NSEYFPgw9aqNCH0xD6fN0R8YXqyVy3k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-43-Ql_NEbjYM2m2kNrCkzuzAg-1; Thu, 18 May 2023 20:04:57 -0400
X-MC-Unique: Ql_NEbjYM2m2kNrCkzuzAg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 75D80185A790;
 Fri, 19 May 2023 00:04:56 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 811342026D25;
 Fri, 19 May 2023 00:04:54 +0000 (UTC)
Date: Thu, 18 May 2023 19:04:52 -0500
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
Subject: Re: [PATCH 1/6] block: add blk_io_plug_call() API
Message-ID: <7bsmwvpfmf6kelaxv32p6nhqcx2f2um2vqhvhu6uw5cooztrhe@oijddrxc2ysx>
References: <20230517221022.325091-1-stefanha@redhat.com>
 <20230517221022.325091-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517221022.325091-2-stefanha@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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

On Wed, May 17, 2023 at 06:10:17PM -0400, Stefan Hajnoczi wrote:
> Introduce a new API for thread-local blk_io_plug() that does not
> traverse the block graph. The goal is to make blk_io_plug() multi-queue
> friendly.
> 
> Instead of having block drivers track whether or not we're in a plugged
> section, provide an API that allows them to defer a function call until
> we're unplugged: blk_io_plug_call(fn, opaque). If blk_io_plug_call() is
> called multiple times with the same fn/opaque pair, then fn() is only
> called once at the end of the function - resulting in batching.
> 
> This patch introduces the API and changes blk_io_plug()/blk_io_unplug().
> blk_io_plug()/blk_io_unplug() no longer require a BlockBackend argument
> because the plug state is now thread-local.
> 
> Later patches convert block drivers to blk_io_plug_call() and then we
> can finally remove .bdrv_co_io_plug() once all block drivers have been
> converted.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---

> +++ b/block/plug.c
> +
> +/**
> + * blk_io_plug_call:
> + * @fn: a function pointer to be invoked
> + * @opaque: a user-defined argument to @fn()
> + *
> + * Call @fn(@opaque) immediately if not within a blk_io_plug()/blk_io_unplug()
> + * section.
> + *
> + * Otherwise defer the call until the end of the outermost
> + * blk_io_plug()/blk_io_unplug() section in this thread. If the same
> + * @fn/@opaque pair has already been deferred, it will only be called once upon
> + * blk_io_unplug() so that accumulated calls are batched into a single call.
> + *
> + * The caller must ensure that @opaque is not be freed before @fn() is invoked.

s/be //

> + */
> +void blk_io_plug_call(void (*fn)(void *), void *opaque)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


