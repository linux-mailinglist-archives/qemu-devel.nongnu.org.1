Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AFE780F12
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 17:24:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX1Kx-0005vz-Rr; Fri, 18 Aug 2023 11:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qX1Kv-0005vG-GN
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:24:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qX1Kt-0002xF-CM
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:24:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692372266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GbAPyh1fMnlkSKZoCerNUTFiu60FRKPTbkNGlRZnHrg=;
 b=VTXJMJzb9RWHqytNk1+ZHwrAP4RwIKC3Ia2jI3eciPlsaqf8kDhTESfsWqfzjWM2OQYoxB
 jstbiUCYIVDj2FZLISRTMgZAg7rEv1/q6GGAriofLokyh8GEv4qeUelZvsdE1z42VF7Eem
 BaLnKazrZjoIX5d627Uwg2XIQwUCHBQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-pjvH6wciNH-2WuMCQWYw5w-1; Fri, 18 Aug 2023 11:24:24 -0400
X-MC-Unique: pjvH6wciNH-2WuMCQWYw5w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7EB43101A53C;
 Fri, 18 Aug 2023 15:24:24 +0000 (UTC)
Received: from redhat.com (unknown [10.39.192.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C4AF3492C13;
 Fri, 18 Aug 2023 15:24:23 +0000 (UTC)
Date: Fri, 18 Aug 2023 17:24:22 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH 0/2] block-backend: process I/O in the current AioContext
Message-ID: <ZN+NJvs0G4zvbOJB@redhat.com>
References: <20230815160521.3357063-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815160521.3357063-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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

Am 15.08.2023 um 18:05 hat Stefan Hajnoczi geschrieben:
> Switch blk_aio_*() APIs over to multi-queue by using
> qemu_get_current_aio_context() instead of blk_get_aio_context(). This change
> will allow devices to process I/O in multiple IOThreads in the future.

Both code paths still use blk_aio_em_aiocb_info, which is:

    static AioContext *blk_aio_em_aiocb_get_aio_context(BlockAIOCB *acb_)
    {
        BlkAioEmAIOCB *acb = container_of(acb_, BlkAioEmAIOCB, common);

        return blk_get_aio_context(acb->rwco.blk);
    }

    static const AIOCBInfo blk_aio_em_aiocb_info = {
        .aiocb_size         = sizeof(BlkAioEmAIOCB),
        .get_aio_context    = blk_aio_em_aiocb_get_aio_context,
    };

.get_aio_context() is called by bdrv_aio_cancel(), which already looks
wrong before this patch because in theory it can end up polling the
AioContext of a different thread. After this patch, .get_aio_context()
doesn't even necessarily return the AioContext that runs the request any
more.

The only thing that might save us is that I can't find any device that
both supports iothreads and calls bdrv_aio_cancel(). But we shouldn't
rely on that.

Maybe the solution is to just remove .get_aio_context altogether and use
AIO_WAIT_WHILE(NULL, ...) in bdrv_aio_cancel().

Kevin


