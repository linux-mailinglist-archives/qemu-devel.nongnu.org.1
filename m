Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5086979EE28
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 18:22:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgSbc-0003l5-CN; Wed, 13 Sep 2023 12:20:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qgSba-0003ko-4S
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 12:20:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qgSbX-0002pV-E1
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 12:20:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694622038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+c3Z788go9I3CZ2BxPa09LjPCkmsc59JES0gEaccKRk=;
 b=CmTvp+TSWtgteC9qbd1IFJW+ZeClRC2J8toVK5yluqNWQzf9Ee8EE/2LK8oED99FXX3Llg
 ltSJ7Xdb5zSiPURoVg+RtGkd6zJCmixkG/ny8K7lrxoOVCz4bUwh797qttzjHgViEXDsfN
 34d9unQtbuwZ+naB2Zj3fGVnp8t02F0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-O9yNaHAYPxm-0_ZhzISm2A-1; Wed, 13 Sep 2023 12:20:34 -0400
X-MC-Unique: O9yNaHAYPxm-0_ZhzISm2A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5FBA18011AD;
 Wed, 13 Sep 2023 16:20:34 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5CBD32026D4B;
 Wed, 13 Sep 2023 16:20:27 +0000 (UTC)
Date: Wed, 13 Sep 2023 11:20:25 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Klaus Jensen <its@irrelevant.dk>, 
 kwolf@redhat.com, Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Xu <peterx@redhat.com>, qemu-block@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 David Hildenbrand <david@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH v3 3/5] block-backend: process I/O in the current
 AioContext
Message-ID: <nleqfl55mac523dfqogkrgxonb4r5al5q66xa5436r6sw2jzor@3xb4cjjw6xdm>
References: <20230912231037.826804-1-stefanha@redhat.com>
 <20230912231037.826804-4-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912231037.826804-4-stefanha@redhat.com>
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

On Tue, Sep 12, 2023 at 07:10:35PM -0400, Stefan Hajnoczi wrote:
> Switch blk_aio_*() APIs over to multi-queue by using
> qemu_get_current_aio_context() instead of blk_get_aio_context(). This
> change will allow devices to process I/O in multiple IOThreads in the
> future.
> 
> I audited existing blk_aio_*() callers:
> - migration/block.c: blk_mig_lock() protects the data accessed by the
>   completion callback.
> - The remaining emulated devices and exports run with
>   qemu_get_aio_context() == blk_get_aio_context().
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/block-backend.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


