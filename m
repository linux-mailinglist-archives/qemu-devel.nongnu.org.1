Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 420EA791448
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 11:06:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd5Wx-0008Jc-7E; Mon, 04 Sep 2023 05:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qd5Wp-0008FP-EJ
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 05:05:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qd5Wn-0003VF-68
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 05:05:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693818346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iQlEBQamD8acT3U8iBEiZodHSUgWhO+RdYMJmu+dzIo=;
 b=OjUTae1cp36PYOA59FiJDoLnWdTvK78eM8+13V8NS90+1TmiCa6pFfTtvK8OTEnDiednPB
 E4PHjwoi2SES0IX8sBfny3SO2A38rU2EgJBayxJ5vRbZwe74ogbfQwwrGdYGxreSA1OkMT
 b3VJtJbRAV8nOlyHJfrGYPrOvoRPkx4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-144-9dRyuMNONIu9tRwu0EtxcA-1; Mon, 04 Sep 2023 05:05:33 -0400
X-MC-Unique: 9dRyuMNONIu9tRwu0EtxcA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A05873C02B88;
 Mon,  4 Sep 2023 09:05:32 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.211])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B4F6CC02996;
 Mon,  4 Sep 2023 09:05:29 +0000 (UTC)
Date: Mon, 4 Sep 2023 11:05:28 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Klaus Jensen <its@irrelevant.dk>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH v2 0/4] block-backend: process I/O in the current
 AioContext
Message-ID: <ZPWd2Ig0bsSvfNKj@redhat.com>
References: <20230823235938.1398382-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823235938.1398382-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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

Am 24.08.2023 um 01:59 hat Stefan Hajnoczi geschrieben:
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

While the dependency isn't in yet, I'm already applying patches 1-3.
Patch 4 needs a respin anyway to update the failing test case.

Kevin


