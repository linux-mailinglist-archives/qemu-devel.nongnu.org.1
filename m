Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 007E87BB39D
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 10:56:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qogdc-00019Z-Ii; Fri, 06 Oct 2023 04:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qogd6-0000z4-6f
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 04:56:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qogd3-0006G0-0C
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 04:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696582571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bWlnrm9OZ4dUejOfOJOlx1bzDpEV15TH+4J3Kzh/y4E=;
 b=cl47GuGeoReeys31PLokXyQtqbNChztyOwaHjN3bAuUGqd+tNoeEWgr9q52O6JG9/4HIyY
 oKju7VVuxzlRcnI4ayvus0JGq/wIXybBZRNzOB/CFf8JokEoTWy06rT7RJE9WPMgg9TBCA
 kGZA41wj/HFpPwfuZ5rNSDU2ponMt/g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-393-6fe4fGIfNGWGgqR6qOP70A-1; Fri, 06 Oct 2023 04:56:04 -0400
X-MC-Unique: 6fe4fGIfNGWGgqR6qOP70A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E1C7811E7E;
 Fri,  6 Oct 2023 08:56:04 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.151])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 15BE82027045;
 Fri,  6 Oct 2023 08:56:02 +0000 (UTC)
Date: Fri, 6 Oct 2023 10:56:01 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, eblake@redhat.com,
 eesposit@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 03/21] preallocate: Don't poll during permission updates
Message-ID: <ZR/LoVGIt3BQ45ek@redhat.com>
References: <20230911094620.45040-1-kwolf@redhat.com>
 <20230911094620.45040-4-kwolf@redhat.com>
 <969ae041-3c17-475c-919c-5b33cb6d21c5@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <969ae041-3c17-475c-919c-5b33cb6d21c5@yandex-team.ru>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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

Am 05.10.2023 um 21:55 hat Vladimir Sementsov-Ogievskiy geschrieben:
> On 11.09.23 12:46, Kevin Wolf wrote:
> > When the permission related BlockDriver callbacks are called, we are in
> > the middle of an operation traversing the block graph. Polling in such a
> > place is a very bad idea because the graph could change in unexpected
> > ways. In the future, callers will also hold the graph lock, which is
> > likely to turn polling into a deadlock.
> > 
> > So we need to get rid of calls to functions like bdrv_getlength() or
> > bdrv_truncate() there as these functions poll internally. They are
> > currently used so that when no parent has write/resize permissions on
> > the image any more, the preallocate filter drops the extra preallocated
> > area in the image file and gives up write/resize permissions itself.
> > 
> > In order to achieve this without polling in .bdrv_check_perm, don't
> > immediately truncate the image, but only schedule a BH to do so. The
> > filter keeps the write/resize permissions a bit longer now until the BH
> > has executed.
> > 
> > There is one case in which delaying doesn't work: Reopening the image
> > read-only. In this case, bs->file will likely be reopened read-only,
> > too, so keeping write permissions a bit longer on it doesn't work. But
> > we can already cover this case in preallocate_reopen_prepare() and not
> > rely on the permission updates for it.
> 
> Hmm, now I found one more "future" case.
> 
> I now try to rebase my "[PATCH v7 0/7] blockdev-replace"
> https://patchew.org/QEMU/20230421114102.884457-1-vsementsov@yandex-team.ru/
> 
> And it breaks after this commit.
> 
> By accident, blockdev-replace series uses exactly "preallocate" filter
> to test insertion/removing of filters. And removing is broken now.
> 
> Removing is done as follows:
> 
> 1. We have filter inserted: disk0 -file-> filter -file-> file0
> 
> 2. blockdev-replace, replaces file child of disk0, so we should get the picture*: disk0 -file-> file0 <-file- filter
> 
> 3. blockdev-del filter
> 
> 
> But step [2] fails, as now preallocate filter doesn't drop permissions
> during the operation (postponing this for a while) and the picture* is
> impossible. Permission check fails.
> 
> Hmmm... Any idea how blockdev-replace and preallocate filter should
> work :) ? Maybe, doing truncation in .drain_begin() will help? Will
> try

Hm... What preallocate tries to do is really tricky...

Of course, the error is correct, this is an invalid configuration if
preallocate can still resize the image. So it would have to truncate the
file earlier, but the first time that preallocate knows of the change is
already too late to run requests.

Truncating on drain_begin feels more like a hack, but as long as it does
the job... Of course, this will have the preallocation truncated away on
events that have nothing to do with removing the filter. It's not
necessarily a disaster because preallocation is only an optimisation,
but it doesn't feel great.

Maybe let's take a step back: Which scenario is the preallocate driver
meant for and why do we even need to truncate the image file after
removing the filter? I suppose the filter doesn't make sense with raw
images because these are fixed size anyway, and pretty much any other
image format should be able to tolerate a permanently rounded up file
size. As long as you don't write to the preallocated area, it shouldn't
take space either on any sane filesystem.

Hmm, actually both VHD and VMDK can have footers, better avoid it with
those... But if truncating the image file on close is critical, what do
you do on crashes? Maybe preallocate should just not be considered
compatible with these formats?

Kevin


