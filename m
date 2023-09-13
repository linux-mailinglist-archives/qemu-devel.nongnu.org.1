Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0365079EE32
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 18:24:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgSeo-0005ju-Ah; Wed, 13 Sep 2023 12:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qgSel-0005jf-CP
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 12:23:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qgSej-0003Jc-8q
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 12:23:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694622235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pHSUwKbXL0nIhPRTGjGjM3bnqbxgDMkinsqxg0mW8sU=;
 b=fmp/S9mNmpVSXekn3u06+jGz27nDalS8ssOttN+0kTstL5UI0z4qU8HqrIRtGSsZFs1VpS
 x1vydyqXAvGdxwsVvlacBwH7644xT8Wyryhm/PoAtoJAS6SWopfqle2KXont6WMJ7EXLxC
 YVXJyM0rWOd1F4sbu4lC3IjNkGT1lCc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-426-R_C15yIsOL-KR7qvur9z0w-1; Wed, 13 Sep 2023 12:23:52 -0400
X-MC-Unique: R_C15yIsOL-KR7qvur9z0w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 94ADC9350E3;
 Wed, 13 Sep 2023 16:23:51 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5DCC740C6EA8;
 Wed, 13 Sep 2023 16:23:50 +0000 (UTC)
Date: Wed, 13 Sep 2023 11:23:48 -0500
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
Subject: Re: [PATCH v3 5/5] block-coroutine-wrapper: use
 qemu_get_current_aio_context()
Message-ID: <hbyv6swimox5hq273zyyjqhuesqnm2ia44dcvmf3qtipzj3ida@um7s5z74ynnj>
References: <20230912231037.826804-1-stefanha@redhat.com>
 <20230912231037.826804-6-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912231037.826804-6-stefanha@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Sep 12, 2023 at 07:10:37PM -0400, Stefan Hajnoczi wrote:
> Use qemu_get_current_aio_context() in mixed wrappers and coroutine
> wrappers so that code runs in the caller's AioContext instead of moving
> to the BlockDriverState's AioContext. This change is necessary for the
> multi-queue block layer where any thread can call into the block layer.
> 
> Most wrappers are IO_CODE where it's safe to use the current AioContext
> nowadays. BlockDrivers and the core block layer use their own locks and
> no longer depend on the AioContext lock for thread-safety.
> 
> The bdrv_create() wrapper invokes GLOBAL_STATE code. Using the current
> AioContext is safe because this code is only called with the BQL held
> from the main loop thread.
> 
> The output of qemu-iotests 051 is sensitive to event loop activity.
> Update the output because the monitor BH runs at a different time,
> causing prompts to be printed differently in the output.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  scripts/block-coroutine-wrapper.py | 6 ++----
>  tests/qemu-iotests/051.pc.out      | 4 ++--
>  2 files changed, 4 insertions(+), 6 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


