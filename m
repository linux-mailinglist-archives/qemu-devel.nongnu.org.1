Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DC27A2137
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 16:40:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh9zA-0005sf-Hm; Fri, 15 Sep 2023 10:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qh9z6-0005sC-5v
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:39:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qh9z4-0004Ed-2u
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:39:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694788787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3DNR3ZQ3wcVQvARTlN7k+gPnbkwq3H7UpA6pm2JHAFQ=;
 b=Mjiyfi5I0yvip7Qp9Qol6rJqMHRi8qyNEqTxf0GXLYPka18SvS8yrrcaFcjIGI673iALbN
 kkpbqrEOprASIHwcDdDnl2qeshDR+6qFfrCMamYxa7KFC0b1Uzu8qZ19X51BrPIQ3FNvys
 +9gqLifzOa1n/mc64eglf2h5oh6OOJQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-exCpgDc0Paatbzd_UB7fYQ-1; Fri, 15 Sep 2023 10:39:43 -0400
X-MC-Unique: exCpgDc0Paatbzd_UB7fYQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52CF4811E7E;
 Fri, 15 Sep 2023 14:39:43 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.146])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 44963170E4;
 Fri, 15 Sep 2023 14:39:40 +0000 (UTC)
Date: Fri, 15 Sep 2023 16:39:38 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Klaus Jensen <its@irrelevant.dk>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 qemu-block@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 David Hildenbrand <david@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH v3 0/5] block-backend: process I/O in the current
 AioContext
Message-ID: <ZQRsqiO0PSPrx4dx@redhat.com>
References: <20230912231037.826804-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912231037.826804-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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

Am 13.09.2023 um 01:10 hat Stefan Hajnoczi geschrieben:
> v3
> - Add Patch 2 to fix a race condition in test-bdrv-drain. This was the CI
>   failure that bumped this patch series from Kevin's pull request.
> - Add missing 051.pc.out file. I tried qemu-system-aarch64 to see of 051.out
>   also needs to be updated, but no changes were necessary. [Kevin]
> v2
> - Add patch to remove AIOCBInfo->get_aio_context() [Kevin]
> - Add patch to use qemu_get_current_aio_context() in block-coroutine-wrapper so
>   that the wrappers use the current AioContext instead of
>   bdrv_get_aio_context().
> 
> Switch blk_aio_*() APIs over to multi-queue by using
> qemu_get_current_aio_context() instead of blk_get_aio_context(). This change
> will allow devices to process I/O in multiple IOThreads in the future.
> 
> The final patch requires my QIOChannel AioContext series to pass
> tests/qemu-iotests/check -qcow2 281 because the nbd block driver is now
> accessed from the main loop thread in addition to the IOThread:
> https://lore.kernel.org/qemu-devel/20230823234504.1387239-1-stefanha@redhat.com/T/#t
> 
> Based-on: 20230823234504.1387239-1-stefanha@redhat.com

Thanks, applied to the block branch.

Kevin


