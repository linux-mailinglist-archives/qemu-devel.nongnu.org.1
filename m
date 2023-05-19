Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABACA709FCF
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 21:20:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q05dH-0002cj-Dc; Fri, 19 May 2023 15:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q05dF-0002c0-3T
 for qemu-devel@nongnu.org; Fri, 19 May 2023 15:19:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q05dC-00047R-RB
 for qemu-devel@nongnu.org; Fri, 19 May 2023 15:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684523953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lEI1DaTSWKm/RQc4y4r8qrMyUEbZJciFhovKKvIZnQU=;
 b=Qa60LCY04WEyq1rWyvnuYsKP+Zt6SjqAgw49ITZsE3cZWtK+Ov296hzquRpt8iq1hsLMR3
 HMNqpzfvwbKiIkT990vvaj85m5XLu0gVVL8TizqmOdtDdzbDBG1yTpEpPKhUHp4HOXcMQ1
 BJREb/JmLCMmOnnILvnUg0O7lJI94UI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-19-IE2m3dNhOGC0NoXqeldtZw-1; Fri, 19 May 2023 15:19:12 -0400
X-MC-Unique: IE2m3dNhOGC0NoXqeldtZw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 68C7F185A78E;
 Fri, 19 May 2023 19:19:10 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.158])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ADE2FC54184;
 Fri, 19 May 2023 19:19:09 +0000 (UTC)
Date: Fri, 19 May 2023 21:19:08 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, quintela@redhat.com
Subject: Re: [PULL v3 00/21] Block layer patches
Message-ID: <ZGfLrJ5H+H6dnJjA@redhat.com>
References: <20230519171806.435109-1-kwolf@redhat.com>
 <c74f18d7-47a4-5251-85c2-a9981e9603bf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c74f18d7-47a4-5251-85c2-a9981e9603bf@linaro.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Am 19.05.2023 um 20:48 hat Richard Henderson geschrieben:
> On 5/19/23 10:18, Kevin Wolf wrote:
> > The following changes since commit d009607d08d22f91ca399b72828c6693855e7325:
> > 
> >    Revert "arm/kvm: add support for MTE" (2023-05-19 08:01:15 -0700)
> > 
> > are available in the Git repository at:
> > 
> >    https://repo.or.cz/qemu/kevin.git tags/for-upstream
> > 
> > for you to fetch changes up to 95fdd8db61848d31fde1d9b32da7f3f76babfa25:
> > 
> >    iotests: Test commit with iothreads and ongoing I/O (2023-05-19 19:16:53 +0200)
> > 
> > ----------------------------------------------------------------
> > Block layer patches
> > 
> > - qcow2 spec: Rename "zlib" compression to "deflate"
> > - Honour graph read lock even in the main thread + prerequisite fixes
> > - aio-posix: do not nest poll handlers (fixes infinite recursion)
> > - Refactor QMP blockdev transactions
> > - graph-lock: Disable locking for now
> > - iotests/245: Check if 'compress' driver is available
> > 
> > ----------------------------------------------------------------
> > Akihiro Suda (1):
> >        docs/interop/qcow2.txt: fix description about "zlib" clusters
> > 
> > Kevin Wolf (12):
> >        block: Call .bdrv_co_create(_opts) unlocked
> >        block/export: Fix null pointer dereference in error path
> >        qcow2: Unlock the graph in qcow2_do_open() where necessary
> >        qemu-img: Take graph lock more selectively
> >        test-bdrv-drain: Take graph lock more selectively
> >        test-bdrv-drain: Call bdrv_co_unref() in coroutine context
> >        blockjob: Adhere to rate limit even when reentered early
> >        graph-lock: Honour read locks even in the main thread
> >        iotests/245: Check if 'compress' driver is available
> >        graph-lock: Disable locking for now
> >        nbd/server: Fix drained_poll to wake coroutine in right AioContext
> >        iotests: Test commit with iothreads and ongoing I/O
> > 
> > Stefan Hajnoczi (2):
> >        aio-posix: do not nest poll handlers
> >        tested: add test for nested aio_poll() in poll handlers
> > 
> > Vladimir Sementsov-Ogievskiy (6):
> >        blockdev: refactor transaction to use Transaction API
> >        blockdev: transactions: rename some things
> >        blockdev: qmp_transaction: refactor loop to classic for
> >        blockdev: transaction: refactor handling transaction properties
> >        blockdev: use state.bitmap in block-dirty-bitmap-add action
> >        blockdev: qmp_transaction: drop extra generic layer
> 
> Test failure:
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/4317480370#L3347
> 
> 194              fail       [18:42:03] [18:42:05]   1.2s
> output mismatch (see /builds/qemu-project/qemu/build/tests/qemu-iotests/scratch/raw-file-194/194.out.bad)
> --- /builds/qemu-project/qemu/tests/qemu-iotests/194.out
> +++ /builds/qemu-project/qemu/build/tests/qemu-iotests/scratch/raw-file-194/194.out.bad
> @@ -14,7 +14,6 @@
>  {"return": {}}
>  {"data": {"status": "setup"}, "event": "MIGRATION", "timestamp":
> {"microseconds": "USECS", "seconds": "SECS"}}
>  {"data": {"status": "active"}, "event": "MIGRATION", "timestamp":
> {"microseconds": "USECS", "seconds": "SECS"}}
> -{"data": {"status": "postcopy-active"}, "event": "MIGRATION", "timestamp":
> {"microseconds": "USECS", "seconds": "SECS"}}
>  {"data": {"status": "completed"}, "event": "MIGRATION", "timestamp":
> {"microseconds": "USECS", "seconds": "SECS"}}
>  Gracefully ending the `drive-mirror` job on source...

You got the same failure on mst's pull request, so this seems to be
unrelated to the pull request at least.

Maybe it is related to us using different test runners now and the test
isn't working right there?

I tried to reproduce locally with the same options as the disable-tcg CI
job uses, but it always passes. Juan, do you have an idea what it could
mean if on some CI system the "postcopy-active" event is missing?

Kevin


