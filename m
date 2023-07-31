Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EA6769BDE
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 18:08:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQVQG-0003nr-Ud; Mon, 31 Jul 2023 12:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1qQVQ6-0003nS-Gu
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 12:06:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1qQVQ4-0004I6-5E
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 12:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690819609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PuDvHKNOgvbcjM5Lqj4/aGh4slVXc7S4FvoWCt3WwJE=;
 b=Ns5QeQ+agt8VyoYXbueYi2Ozt1oRqSZO0xyBLwyhzxNQRToPhfloickZgq3f83abXzMjP7
 O0kMXfmh5kRCnJ5jjbzWjUyH7TvRCDh/VHDuY1ShLZM2AZo2FdNPSbRPoBWaAp7Wifqd4r
 gJt/w14+wsMl4IL29/clyFe/JRNB/lk=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-125-6cm__fc-P1e0Twsu1bWUmw-1; Mon, 31 Jul 2023 12:06:47 -0400
X-MC-Unique: 6cm__fc-P1e0Twsu1bWUmw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 21F7B3C108C1
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 16:06:47 +0000 (UTC)
Received: from localhost (unknown [10.42.28.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E2355492B03;
 Mon, 31 Jul 2023 16:06:46 +0000 (UTC)
Date: Mon, 31 Jul 2023 17:06:46 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Alex Kalenyuk <akalenyu@redhat.com>, Adam Litke <alitke@redhat.com>,
 qemu-devel@nongnu.org, kwolf@redhat.com, nsoffer@redhat.com
Subject: Re: qemu-img cache modes with Linux cgroup v1
Message-ID: <20230731160636.GO7636@redhat.com>
References: <20230731154036.GA1258836@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731154036.GA1258836@fedora>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 URI_DOTEDU=1.999 autolearn=no autolearn_force=no
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

On Mon, Jul 31, 2023 at 11:40:36AM -0400, Stefan Hajnoczi wrote:
> 3. Using buffered I/O because O_DIRECT is not universally supported?
> 
> If you can't use O_DIRECT, then qemu-img could be extended to manage its
> dirty page cache set carefully. This consists of picking a budget and
> writing back to disk when the budget is exhausted. Richard Jones has
> shared links covering posix_fadvise(2) and sync_file_range(2):
> https://lkml.iu.edu/hypermail/linux/kernel/1005.2/01845.html
> https://lkml.iu.edu/hypermail/linux/kernel/1005.2/01953.html
> 
> We can discuss qemu-img code changes and performance analysis more if
> you decide to take that direction.

There's a bit more detail in these two commits:

  https://gitlab.com/nbdkit/libnbd/-/commit/64d50d994dd7062d5cce21f26f0e8eba0e88c87e
  https://gitlab.com/nbdkit/nbdkit/-/commit/a956e2e75d6c88eeefecd967505667c9f176e3af

In my experience this method is much better than using O_DIRECT,
it has much fewer sharp edges.

By the way, this is a super-useful tool for measuring how much of the
page cache is being used to cache a file:

  https://github.com/Feh/nocache

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html


