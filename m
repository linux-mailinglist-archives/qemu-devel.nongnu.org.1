Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A303D7A6AB8
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 20:31:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qifTm-0003FL-By; Tue, 19 Sep 2023 14:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qifTk-0003FD-2i
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 14:29:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qifTi-0007ht-7Z
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 14:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695148180;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=GggkcVBCZ5+WzZpMaEE5t39NgkXbQxPAJgZSZuClyFI=;
 b=h7N45hYQ38Vqj5v7mF0zvmo7XyEUXmgfcxOWJFDRL0/LYzr06cDLeEBAB+k6f++wJC6j46
 Q3/xM6i53KrhFDyljhTSciBSGwib3X7v35CXD8r9HrIyljXwVVzcku1Qizdub2ynKxVgIM
 TiJB3hMDivLXD0giwiw6r/I/db30yB8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-102-pbzyg92zOMuba2wxXiC4Fw-1; Tue, 19 Sep 2023 14:29:39 -0400
X-MC-Unique: pbzyg92zOMuba2wxXiC4Fw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2079B1E441DB;
 Tue, 19 Sep 2023 18:29:39 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C209711282;
 Tue, 19 Sep 2023 18:29:36 +0000 (UTC)
Date: Tue, 19 Sep 2023 19:29:32 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 quintela@redhat.com, leobras@redhat.com, Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH 00/52] migration/rdma: Error handling fixes
Message-ID: <ZQnojJOqoFu73995@redhat.com>
References: <20230918144206.560120-1-armbru@redhat.com> <ZQnRKjo0M50BRbZh@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZQnRKjo0M50BRbZh@x1n>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Sep 19, 2023 at 12:49:46PM -0400, Peter Xu wrote:
> On Mon, Sep 18, 2023 at 04:41:14PM +0200, Markus Armbruster wrote:
> > Oh dear, where to start.  There's so much wrong, and in pretty obvious
> > ways.  This code should never have passed review.  I'm refraining from
> > saying more; see the commit messages instead.
> > 
> > Issues remaining after this series include:
> > 
> > * Terrible error messages
> > 
> > * Some error message cascades remain
> > 
> > * There is no written contract for QEMUFileHooks, and the
> >   responsibility for reporting errors is unclear
> 
> Even being removed.. because no one is really extending that..
> 
> https://lore.kernel.org/all/20230509120700.78359-1-quintela@redhat.com/#t

One day (in another 5-10 years) I still hope we'll get to
the point where QEMUFile itself is obsolete :-) Getting
rid of QEMUFileHooks is a great step in that direction.
Me finishing a old PoC to bring buffering to QIOChannel
would be another big step.

The data rate limiting would be the biggest missing piece
to enable migration/vmstate logic to directly consume
a QIOChannel.

Eliminating QEMUFile would help to bring Error **errp
to all the vmstate codepaths.

> > * There seem to be no tests whatsoever
> 
> I always see rdma as "odd fixes" stage.. for a long time.  But maybe I was
> wrong.

In the MAINTAINERS file RDMA still get classified as formally
supported under the migration maintainers.  I'm not convinced
that is an accurate description of its status.  I tend to agree
with you that it is 'odd fixes' at the very best.

Dave Gilbert had previously speculated about whether we should
even consider deprecating it on the basis that latest non-RDMA
migration is too much better than in the past, with multifd
and zerocopy, that RDMA might not even offer a significant
enough peformance win to justify.

> Copying Zhijian for status of rdma; Zhijian, I saw that you just replied to
> the hwpoison issue.  Maybe we should have one entry for rdma too, just like
> colo?

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


