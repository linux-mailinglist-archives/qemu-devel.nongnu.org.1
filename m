Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9427A6411
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 14:58:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiaI6-0001le-Pq; Tue, 19 Sep 2023 08:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1qiaI3-0001l8-BF; Tue, 19 Sep 2023 08:57:19 -0400
Received: from ssh.movementarian.org ([139.162.205.133] helo=movementarian.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1qiaHz-0006dl-ML; Tue, 19 Sep 2023 08:57:19 -0400
Received: from movement by movementarian.org with local (Exim 4.95)
 (envelope-from <movement@movementarian.org>) id 1qiaHy-00BYYt-3b;
 Tue, 19 Sep 2023 13:57:14 +0100
Date: Tue, 19 Sep 2023 13:57:14 +0100
From: John Levon <levon@movementarian.org>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Hanna Czenczek <hreitz@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Deadlock with SATA CD I/O and eject
Message-ID: <ZQmaqorH9YqNG1+g@movementarian.org>
References: <ZQiIxERjYmZb0v4l@movementarian.org> <ZQl+A0nys2v7UzeN@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQl+A0nys2v7UzeN@redhat.com>
X-Url: http://www.movementarian.org/
Received-SPF: pass client-ip=139.162.205.133;
 envelope-from=movement@movementarian.org; helo=movementarian.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 19, 2023 at 12:54:59PM +0200, Kevin Wolf wrote:

> > In the meantime, we start processing the blk_drain() code, so by the time this
> > blk_pread() actually gets handled, quiesce is set, and we get stuck in the
> > blk_wait_while_drained().
> > 
> > I don't know the qemu block stack well enough to propose an actual fix.
> > 
> > Experimentally, waiting for ->in_flight to drop to zero *before* we quiesce in
> > blk_remove_bs() via an AIO_WAIT_WHILE() avoids the symptom, but I'm pretty sure
> > that's just a band-aid instead of fixing the deadlock.
> 
> Related discussion: https://lists.gnu.org/archive/html/qemu-block/2023-03/msg00284.html
> 
> Actually, it seems we never fixed that problem either?
> 
> Back then I suggested that blk_drain*() should disable request queuing
> because its callers don't want to quiesce the BlockBackend, but rather
> get their own requests completed. I think this approach would solve this
> one as well.

In this case though, it's not their own requests right? We have incoming I/O
from the guest and the eject is a separate operation.

So why it would be OK to disable queuing and have ongoing I/Os (i.e.
blk->in_flight > 0) racing against the block remove?

> Your experiment with moving the queuing later is basically what Paolo

I think it's much more flaky than that, isn't it? It's just clearing out the
*current* pending queue, but nothing would stop new I/Os from being started
before we dropped into the poll for blk->in_flight to be zero again. In my case,
this just happens to work because the prior tray open notification has stopped
new I/O being filed, right?

thanks
john

