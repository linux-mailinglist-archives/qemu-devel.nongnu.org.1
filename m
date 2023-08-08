Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88578774493
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 20:23:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTRM2-0001bZ-2Z; Tue, 08 Aug 2023 14:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qTRM0-0001b7-39
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 14:22:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qTRLy-0007CU-DJ
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 14:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691518965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QHit0S0PhhvRox7Lb71Ry+hOMA/x1L/JfmotQT3Rctg=;
 b=cq2f3aNtVPQSekiz9sU/6VFC7sP1wQZ3Apuz6aHe014D9W/TJ3ph8bBr+XoRD2dlBnvpwj
 tn/jm2nuHSsS6yaeUsh/7+BXNkV+yTet5Fz7lP0h5eJ8RfwqrwNakAkuw8qkgcQ8Xc9Zw3
 3V5GO9HZ2jl8LCGwUTkymVhISM41RTQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-168-hlGbWSqzME2l18jP-YkeEw-1; Tue, 08 Aug 2023 14:22:42 -0400
X-MC-Unique: hlGbWSqzME2l18jP-YkeEw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 97672101A528;
 Tue,  8 Aug 2023 18:22:41 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.35])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A1A37492C3A;
 Tue,  8 Aug 2023 18:22:40 +0000 (UTC)
Date: Tue, 8 Aug 2023 13:22:38 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 2/2] block: change reqs_lock to QemuMutex
Message-ID: <s674pkvwn3as5r3aitrnvddtsofxo2gtfv26npz5y54uk34yew@oplkvzdeqkut>
References: <20230808155852.2745350-1-stefanha@redhat.com>
 <20230808155852.2745350-3-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808155852.2745350-3-stefanha@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
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

On Tue, Aug 08, 2023 at 11:58:52AM -0400, Stefan Hajnoczi wrote:
> CoMutex has poor performance when lock contention is high. The tracked
> requests list is accessed frequently and performance suffers in QEMU
> multi-queue block layer scenarios.
> 
> It is not necessary to use CoMutex for the requests lock. The lock is
> always released across coroutine yield operations. It is held for
> relatively short periods of time and it is not beneficial to yield when
> the lock is held by another coroutine.
> 
> Change the lock type from CoMutex to QemuMutex to improve multi-queue
> block layer performance. fio randread bs=4k iodepth=64 with 4 IOThreads
> handling a virtio-blk device with 8 virtqueues improves from 254k to
> 517k IOPS (+203%). Full benchmark results and configuration details are
> available here:
> https://gitlab.com/stefanha/virt-playbooks/-/commit/980c40845d540e3669add1528739503c2e817b57

Nice!

> 
> In the future we may wish to introduce thread-local tracked requests
> lists to avoid lock contention completely. That would be much more
> involved though.

Indeed.

> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/block/block_int-common.h |  2 +-
>  block.c                          |  4 +++-
>  block/io.c                       | 24 ++++++++++++------------
>  3 files changed, 16 insertions(+), 14 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


