Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6607A6561
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 15:38:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiav0-0008JO-1p; Tue, 19 Sep 2023 09:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qiaux-0008J7-5K
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 09:37:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qiauv-0007CJ-GN
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 09:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695130647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qo//kAj3IR+nRzqbDZTY4DWAUDokvhncGAu2xbHYDKk=;
 b=X0DF644REILtDy6hRU/RS7iY1TJ3S4JYtwpgdcBxy5ElbQ+TtzR4jN2spvq73DUgYEufa9
 qoV5HIG9umoVfNffMBJn224qQt79CLUydyRtM91354pPiNYDjuMtCStEa3ejLwTa/4+Wbn
 AtukFZ3xcaV1wXacecvnWenjBZFu++o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-330-r9v4NQqPMaS4UAElCePwqg-1; Tue, 19 Sep 2023 09:37:23 -0400
X-MC-Unique: r9v4NQqPMaS4UAElCePwqg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 34FBE3C0DF61;
 Tue, 19 Sep 2023 13:37:23 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E4752401408;
 Tue, 19 Sep 2023 13:37:21 +0000 (UTC)
Date: Tue, 19 Sep 2023 15:37:20 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>, John Snow <jsnow@redhat.com>,
 levon@movementarian.org
Subject: Re: [PATCH v2] block-backend: Add new bds_io_in_flight counter
Message-ID: <ZQmkEAbcVrOPHL6i@redhat.com>
References: <20230331162335.27518-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331162335.27518-1-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 31.03.2023 um 18:23 hat Hanna Czenczek geschrieben:
> IDE TRIM is a BB user that wants to elevate its BB's in-flight counter
> for a "macro" operation that consists of several actual I/O operations.
> Each of those operations is individually started and awaited.  It does
> this so that blk_drain() will drain the whole TRIM, and not just a
> single one of the many discard operations it may encompass.
> 
> When request queuing is enabled, this leads to a deadlock: The currently
> ongoing discard is drained, and the next one is queued, waiting for the
> drain to stop.  Meanwhile, TRIM still keeps the in-flight counter
> elevated, waiting for all discards to stop -- which will never happen,
> because with the in-flight counter elevated, the BB is never considered
> drained, so the drained section does not begin and cannot end.

Alright, let's have another look at this now that another similar
deadlock was reported:
https://lists.gnu.org/archive/html/qemu-block/2023-09/msg00536.html

> There are two separate cases to look at here, namely bdrv_drain*() and
> blk_drain*().  As said above, we do want blk_drain*() to settle the
> whole operation: The only way to do so is to disable request queuing,
> then.  So, we do that: Have blk_drain() and blk_drain_all() temporarily
> disable request queuing, which prevents the deadlock.

Two separate cases with two separate fixes suggests that it could be
two separate patches. I feel the blk_*() case is uncontroversial and it
would fix John's case, so splitting wouldn't only make this easier to
understand, but could mean that we can fix a useful subset earlier.

> (The devil's in the details, though: blk_drain_all() runs
> bdrv_drain_all_begin() first, so when we get to the individual BB, there
> may already be queued requests.  Therefore, we have to not only disable
> request queuing then, but resume all already-queued requests, too.)

Why can't we just disable request queuing before calling bdrv_drain_*()?

Is it possible that the same problem occurs because someone else already
called bdrv_drain_*()? That is, blk_drain_*() would be called from a
callback in the nested event loop in bdrv_drain_*()? If so, we can't
avoid that there are already queued requests.

Restarting them seems correct anyway.

> For bdrv_drain*(), we want request queuing -- and macro requests such as
> IDE's TRIM request do not matter.  bdrv_drain*() wants to keep I/O
> requests from BDS nodes, and the TRIM does not issue such requests; it
> instead does so through blk_*() functions, which themselves elevate the
> BB's in-flight counter.  So the idea is to drain (and potentially queue)
> those blk_*() requests, but completely ignore the TRIM.
> 
> We can do that by splitting a new counter off of the existing BB
> counter: The new bds_io_in_flight counter counts all those blk_*()
> requests that can issue I/O to a BDS (so must be drained by
> bdrv_drain*()), but will never block waiting on another request on the
> BB.

You end up changing all of the existing blk_inc_in_flight() callers
except those in IDE and virtio-blk.

That makes me wonder if it shouldn't be approached the other way around:
BlockBackend users that want to be included in drain should use a
special function blk_inc_in_flight_external() or something that wouldn't
increase blk->in_flight, but only a new separate counter. And then only
blk_drain*() wait for it (by extending the AIO_WAIT_WHILE() condition),
but not the child_root callbacks.

This would give us more directly the semantics that we actually need:
The root BDS doesn't care if the operation on the device level has
completed as long as nothing new arrives, only external callers which
use blk_drain*() do. I believe internal/external is easier to reason
about than "requests that can issue I/O to a BDS [directly]", it keeps
the external callers the special ones that need extra care while the
normal I/O path is unaffected, and it would make the patch much smaller.

> In blk_drain*(), we disable request queuing and settle all requests (the
> full in_flight count).  In bdrv_drain*() (i.e. blk_root_drained_poll()),
> we only settle bds_io_in_flight_count, ignoring all requests that will
> not directly issue I/O requests to BDS nodes.
> 
> Reported-by: Fiona Ebner <f.ebner@proxmox.com>
> Fixes: 7e5cdb345f77d76cb4877fe6230c4e17a7d0d0ca
>        ("ide: Increment BB in-flight counter for TRIM BH")
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>

Kevin


