Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B1D7A6621
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 16:05:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qibLE-0001t7-1R; Tue, 19 Sep 2023 10:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qibLB-0001s9-Ob
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 10:04:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qibL8-0006N2-9a
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 10:04:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695132273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q8rmvzHj8Lw0uXCBeLEqMDjG5qM/lc5pg8MjNMDfZng=;
 b=QKylFW3G3GVFaf5oo8ReEjgHJYLikHFu2ayxg6DLSdtoIy3tI6anxenq58iURX2GN/2m/Z
 R3MSvQMizcVYvSmn6jRnZRFtmC157MufgDAfQeL+g8mh1B9XoCdCXf6XHueGj52urPCDaD
 I5gRuR6/muvAAZoblZ7B54XWfwaRJyg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-8-2tunZRQaOeq31PfmoB6FVg-1; Tue, 19 Sep 2023 10:04:21 -0400
X-MC-Unique: 2tunZRQaOeq31PfmoB6FVg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C8455803522;
 Tue, 19 Sep 2023 14:03:59 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F32E40C2064;
 Tue, 19 Sep 2023 14:03:58 +0000 (UTC)
Date: Tue, 19 Sep 2023 16:03:57 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: John Levon <levon@movementarian.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Hanna Czenczek <hreitz@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Deadlock with SATA CD I/O and eject
Message-ID: <ZQmqTefqVHTBb3y+@redhat.com>
References: <ZQiIxERjYmZb0v4l@movementarian.org> <ZQl+A0nys2v7UzeN@redhat.com>
 <ZQmaqorH9YqNG1+g@movementarian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQmaqorH9YqNG1+g@movementarian.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

Am 19.09.2023 um 14:57 hat John Levon geschrieben:
> On Tue, Sep 19, 2023 at 12:54:59PM +0200, Kevin Wolf wrote:
> 
> > > In the meantime, we start processing the blk_drain() code, so by the time this
> > > blk_pread() actually gets handled, quiesce is set, and we get stuck in the
> > > blk_wait_while_drained().
> > > 
> > > I don't know the qemu block stack well enough to propose an actual fix.
> > > 
> > > Experimentally, waiting for ->in_flight to drop to zero *before* we quiesce in
> > > blk_remove_bs() via an AIO_WAIT_WHILE() avoids the symptom, but I'm pretty sure
> > > that's just a band-aid instead of fixing the deadlock.
> > 
> > Related discussion: https://lists.gnu.org/archive/html/qemu-block/2023-03/msg00284.html
> > 
> > Actually, it seems we never fixed that problem either?
> > 
> > Back then I suggested that blk_drain*() should disable request queuing
> > because its callers don't want to quiesce the BlockBackend, but rather
> > get their own requests completed. I think this approach would solve this
> > one as well.
> 
> In this case though, it's not their own requests right? We have incoming I/O
> from the guest and the eject is a separate operation.

It's not the same code path, but we're operating in the context of the
IDE device (or more specifically, its BlockBackend), so in that sense it
is "its own requests".

The main difference is anyway between just stopping activity (even if
it's in the middle of a higher level operation of the device) and
getting requests fully completed. We want the latter here.

> So why it would be OK to disable queuing and have ongoing I/Os (i.e.
> blk->in_flight > 0) racing against the block remove?

With eject, the case is simple for IDE: We hold the BQL, so the guest
won't be able to submit new requests anyway.

In more complicated cases like virtio-blk, bdrv_drained_begin() and
friends take care to stop new requests from coming in from the guest by
not running notifiers while the device is drained.

We just need to take care of the requests that have already started.

> > Your experiment with moving the queuing later is basically what Paolo
> 
> I think it's much more flaky than that, isn't it? It's just clearing out the
> *current* pending queue, but nothing would stop new I/Os from being started
> before we dropped into the poll for blk->in_flight to be zero again. In my case,
> this just happens to work because the prior tray open notification has stopped
> new I/O being filed, right?

I think it's the same as above, holding the BQL and calling drain would
already take care of that.

Kevin


