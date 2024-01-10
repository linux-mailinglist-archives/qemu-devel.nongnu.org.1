Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6137C829EF8
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 18:22:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNcGh-0001wo-Tw; Wed, 10 Jan 2024 12:21:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rNcGS-0001w5-Od
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 12:21:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rNcGP-0005te-Fs
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 12:21:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704907271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KKeKkWuzDFVxiJMO7aivYooWFEiLVcwYTuziueiWyU8=;
 b=DXzSSUtQP2qfivVZnVQ0//yqGL3jKVAzUqPaC75FSkEr0mdIQSfmnUBzF/S6xB9AR3Cr9h
 ytZN3dd2mJyNQuGp1k37rR1gv25BwOKOCuOncW9B5eI0UnEPIx6cuxlj/R3qyaWht1KUvH
 v5Itoe0pucQFo/VLjzn/JzZtas/BhP4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-wk5CGAA-N9-eSwLP_dHFuw-1; Wed, 10 Jan 2024 12:21:10 -0500
X-MC-Unique: wk5CGAA-N9-eSwLP_dHFuw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C17AC868A05;
 Wed, 10 Jan 2024 17:21:09 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.222])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CE2F451E3;
 Wed, 10 Jan 2024 17:21:08 +0000 (UTC)
Date: Wed, 10 Jan 2024 18:21:07 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Ari Sundholm <ari@tuxera.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, qemu-stable@nongnu.org, stefanha@redhat.com
Subject: Re: [PATCH] block/blklogwrites: Fix a bug when logging "write
 zeroes" operations.
Message-ID: <ZZ7SA-wJ2KxzyBIQ@redhat.com>
References: <20240109184646.1128475-1-megari@gmx.com>
 <ZZ6eB32kR-Np1BQR@redhat.com>
 <f1960d8d-352e-4e1b-4d28-7a110e272356@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1960d8d-352e-4e1b-4d28-7a110e272356@tuxera.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Am 10.01.2024 um 16:21 hat Ari Sundholm geschrieben:
> On 1/10/24 15:39, Kevin Wolf wrote:
> > Am 09.01.2024 um 19:46 hat megari@gmx.com geschrieben:
> > > From: Ari Sundholm <ari@tuxera.com>
> > > 
> > > There is a bug in the blklogwrites driver pertaining to logging "write
> > > zeroes" operations, causing log corruption. This can be easily observed
> > > by setting detect-zeroes to something other than "off" for the driver.
> > > 
> > > The issue is caused by a concurrency bug pertaining to the fact that
> > > "write zeroes" operations have to be logged in two parts: first the log
> > > entry metadata, then the zeroed-out region. While the log entry
> > > metadata is being written by bdrv_co_pwritev(), another operation may
> > > begin in the meanwhile and modify the state of the blklogwrites driver.
> > > This is as intended by the coroutine-driven I/O model in QEMU, of
> > > course.
> > > 
> > > Unfortunately, this specific scenario is mishandled. A short example:
> > >      1. Initially, in the current operation (#1), the current log sector
> > > number in the driver state is only incremented by the number of sectors
> > > taken by the log entry metadata, after which the log entry metadata is
> > > written. The current operation yields.
> > >      2. Another operation (#2) may start while the log entry metadata is
> > > being written. It uses the current log position as the start offset for
> > > its log entry. This is in the sector right after the operation #1 log
> > > entry metadata, which is bad!
> > >      3. After bdrv_co_pwritev() returns (#1), the current log sector
> > > number is reread from the driver state in order to find out the start
> > > offset for bdrv_co_pwrite_zeroes(). This is an obvious blunder, as the
> > > offset will be the sector right after the (misplaced) operation #2 log
> > > entry, which means that the zeroed-out region begins at the wrong
> > > offset.
> > >      4. As a result of the above, the log is corrupt.
> > > 
> > > Fix this by only reading the driver metadata once, computing the
> > > offsets and sizes in one go (including the optional zeroed-out region)
> > > and setting the log sector number to the appropriate value for the next
> > > operation in line.
> > > 
> > > Signed-off-by: Ari Sundholm <ari@tuxera.com>
> > > Cc: qemu-stable@nongnu.org
> > 
> > Thanks, applied to the block branch.
> > 
> 
> Thank you.
> 
> > Note that while this fixes the single threaded case, it is not thread
> > safe and will still break with multiqueue enabled (see the new
> > iothread-vq-mapping option added to virtio-blk very recently). Most
> > block drivers already take a lock when modifying their global state, and
> > it looks like we missed blklogwrites when checking what needs to be
> > prepared for the block layer to be thread safe.
> > 
> 
> I see. Thanks for the heads up. I had missed this new development.
> 
> > So I think we'll want another patch to add a QemuMutex that can be taken
> > while you do the calculations on s->cur_log_sector. But this patch is
> > a good first step because it means that we don't need to keep a lock
> > across an I/O request (just for the sake of completeness, this would
> > have had to be a CoMutex rather than a QemuMutex).
> 
> OK. I guess I have a bit of additional work to do, then.

Yes, a bit, but I honestly don't expect the locking to be a big effort
for a small driver like blklogwrites.

> What release would these fixes realistically make it to? Just trying
> to gauge the urgency for the fix for the multi-threaded case for
> prioritization purposes.

Well, this one is queued for 9.0. If we can make sure to get the thread
safety fix into 9.0, too (I expect the soft freeze to be somewhere
around beginning of March and the release in April), that would be good,
because that would also be the first release to be affected.

I'm not sure if and when a 8.2.* stable release is planned before that.

> And yes, holding a CoMutex while doing I/O would have fixed this
> issue, with the tiny drawback of killing any concurrency in the
> driver. ;)

Ah, that's not true, only any concurrency in the log writes. ;)

Kevin


