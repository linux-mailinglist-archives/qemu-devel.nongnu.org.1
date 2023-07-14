Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D81E753F0D
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 17:35:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKKoq-0000gl-2P; Fri, 14 Jul 2023 11:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5525cada8=anthony.perard@citrix.com>)
 id 1qKKon-0000gM-MI
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 11:34:53 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5525cada8=anthony.perard@citrix.com>)
 id 1qKKol-0003rx-Sv
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 11:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1689348891;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=Rrn18Px0Jy/Mwd4sqh2vtawJA0bH2EjjTmHrhss+9vA=;
 b=HwOTqwWSq13x4I/1t0w2R6iPnfzMzrhGuUbZkBFl/Xi7rEsuEQYh6+Fy
 7qSvyds9h4lKgUG0JTBGBRa2kh8bd2t6DEI16fwWu1CJH/1xcdpkIlEE2
 pelTZnEqe8ZzUgU2W/YPq4OMjgy70Rv11tVMO2j1II2j5p8CrOBCGgtq8 0=;
Authentication-Results: esa4.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 118837742
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.123
X-Policy: $RELAYED
IronPort-Data: A9a23:StIIc60BRf6ne2drvfbD5fVxkn2cJEfYwER7XKvMYLTBsI5bpzdRn
 2ceDW/XOK7YZWP3eNx+PI7j9RxU65aHnYBlSlZlpC1hF35El5HIVI+TRqvS04F+DeWYFR46s
 J9OAjXkBJppJpMJjk71atANlVEliefTAOK6ULWeUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tq3qMDEULOf82cc3lk8teTb8XuDgNyo4GlD5gNnOagS1LPjvyJ94Kw3dPnZw0TQGuG4LsbiL
 87fwbew+H/u/htFIrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRrukoPD9IOaF8/ttm8t4sZJ
 OOhF3CHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqFvnrSFL/hGVSkL0YMkFulfL1x03
 98hIWE0RB2YmsmxnpGlVfJ2v5F2RCXrFNt3VnBIyDjYCbAtQIzZQrWM7thdtNsyrpkQR7CEP
 ZNfMGcxKk2aOHWjOX9OYH46tO6umnn4dSwesF+PrLA7y2PS0BZwwP7mN9+9ltmiHJwFzh3H+
 T6cl4j/KhoHNpuU6mWmy1P2jNTLvCbLf8EPFqLto5aGh3XMnzdOWXX6T2CTo/O0l0q/UNJ3M
 FEP92wlqq1a3FWmS8S4UxCmrXqsuBkaVNxNVeog52ml2qfSpgqUGGUAZjpAc8A98t87QyQw0
 V2ElM+vAiZg2JWcUX+H/62YhS+zMyMSa2QFYEc5oRAtuoe55ttp11SWE4glSfTu5jHoJd3u6
 x63lgIdvrxCtOQGzLiQ+g7knS23vKGcG2bZ+T7rsnKZAhJRPdD1NtfysQiDsp6sP67CEADf4
 SFsd9y2qblXUMrTzHHlrPAlRunB2hqTDNHLbbeD9bEF/i/lxXOsdJs4DNpWdBYwaZZsldMEj
 SbuVeJtCHx7ZiHCgVdfOd7ZNijT5fGI+S7Zfv7VdMFSRZN6aRWK+ipjDWbJgTC8yhd3yf5jZ
 8rLGSpJMZr8If48pNZRb75NuYLHOwhknT+DLXwF50nPPUWiiI69Fu5ebQrmghER56KYugTFm
 +uzxOPToyizpNbWO3GNmaZKdABiEJTOLcyuwyChXrLZc1UO9aBII6O5/I7NjKQ8wf8Kyb+Wo
 S7hMqKaoXKm7UD6xcyxQigLQNvSsVxX9xrX4QRE0Y6U5kUe
IronPort-HdrOrdr: A9a23:JN6vLaoJYz1jrJi0acr68KQaV5oReYIsimQD101hICG9JPbo8P
 xG+85rtiMc6QxwZJhOo7u90cW7K080lqQV3WByB9iftVLdyQ+VxehZhOPfKlvbdhEWndQy6U
 4PScRD4HKbNykdsS5XijPIcerJYbO8gcWVuds=
X-Talos-CUID: =?us-ascii?q?9a23=3AKm+p7mtWdU0CoztEZfuK2bD36IsLT0f3707Zcna?=
 =?us-ascii?q?SBH10Y7rLakGP47ldxp8=3D?=
X-Talos-MUID: 9a23:BY3Zngp6Xy7dj2U4/MYezzp/NoBjwPuNMWFXm64Cmsy0Em9tOSjI2Q==
X-IronPort-AV: E=Sophos;i="6.01,205,1684814400"; d="scan'208";a="118837742"
Date: Fri, 14 Jul 2023 16:34:29 +0100
To: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
CC: Jan Beulich <jbeulich@suse.com>, <qemu-devel@nongnu.org>,
 <xen-devel@lists.xenproject.org>
Subject: Re: QEMU assert (was: [xen-unstable test] 181558: regressions - FAIL)
Message-ID: <a58f5bef-0543-4913-9a70-edb77c269a29@perard>
References: <osstest-181558-mainreport@xen.org>
 <ZJwoK50FcnTSfFZ8@MacBook-Air-de-Roger.local>
 <947da45d-f336-4034-bf51-fb190420506b@perard>
 <ZKPs5r3wen4PymqX@MacBook-Air-de-Roger.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZKPs5r3wen4PymqX@MacBook-Air-de-Roger.local>
Received-SPF: pass client-ip=216.71.155.144;
 envelope-from=prvs=5525cada8=anthony.perard@citrix.com;
 helo=esa4.hc3370-68.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-to:  Anthony PERARD <anthony.perard@citrix.com>
From:  Anthony PERARD via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Jul 04, 2023 at 11:56:54AM +0200, Roger Pau Monné wrote:
> On Tue, Jul 04, 2023 at 10:37:38AM +0100, Anthony PERARD wrote:
> > On Wed, Jun 28, 2023 at 02:31:39PM +0200, Roger Pau Monné wrote:
> > > On Fri, Jun 23, 2023 at 03:04:21PM +0000, osstest service owner wrote:
> > > > flight 181558 xen-unstable real [real]
> > > > http://logs.test-lab.xenproject.org/osstest/logs/181558/
> > > > 
> > > > Regressions :-(
> > > > 
> > > > Tests which did not succeed and are blocking,
> > > > including tests which could not be run:
> > > >  test-amd64-amd64-xl-qcow2   21 guest-start/debian.repeat fail REGR. vs. 181545
> > > 
> > > The test failing here is hitting the assert in qemu_cond_signal() as
> > > called by worker_thread():
> > > 
> > > #0  __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:50
> > > #1  0x00007ffff740b535 in __GI_abort () at abort.c:79
> > > #2  0x00007ffff740b40f in __assert_fail_base (fmt=0x7ffff756cef0 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", assertion=0x55555614abcb "cond->initialized",
> > >     file=0x55555614ab88 "../qemu-xen-dir-remote/util/qemu-thread-posix.c", line=198, function=<optimized out>) at assert.c:92
> > > #3  0x00007ffff74191a2 in __GI___assert_fail (assertion=0x55555614abcb "cond->initialized", file=0x55555614ab88 "../qemu-xen-dir-remote/util/qemu-thread-posix.c", line=198,
> > >     function=0x55555614ad80 <__PRETTY_FUNCTION__.17104> "qemu_cond_signal") at assert.c:101
> > > #4  0x0000555555f1c8d2 in qemu_cond_signal (cond=0x7fffb800db30) at ../qemu-xen-dir-remote/util/qemu-thread-posix.c:198
> > > #5  0x0000555555f36973 in worker_thread (opaque=0x7fffb800dab0) at ../qemu-xen-dir-remote/util/thread-pool.c:129
> > > #6  0x0000555555f1d1d2 in qemu_thread_start (args=0x7fffb8000b20) at ../qemu-xen-dir-remote/util/qemu-thread-posix.c:505
> > > #7  0x00007ffff75b0fa3 in start_thread (arg=<optimized out>) at pthread_create.c:486
> > > #8  0x00007ffff74e206f in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
> > > 
> > > I've been trying to figure out how it can get in such state, but so
> > > far I had no luck.  I'm not a QEMU expert, so it's probably better if
> > > someone else could handle this.
> > > 
> > > In the failures I've seen, and the reproduction I have, the assert
> > > triggers in the QEMU dom0 instance responsible for locally-attaching
> > > the disk to dom0 in order to run pygrub.
> > > 
> > > This is also with QEMU 7.2, as testing with upstream QEMU is blocked
> > > ATM, so there's a chance it has already been fixed upstream.
> > > 
> > > Thanks, Roger.
> > 
> > So, I've run a test with the latest QEMU and I can still reproduce the
> > issue. The test also fails with QEMU 7.1.0.
> > 
> > But, QEMU 7.0 seems to pass the test, even with a start-stop loop of 200
> > iteration. So I'll try to find out if something change in that range.
> > Or try to find out why would the thread pool be not initialised
> > properly.
> 
> Thanks for looking into this.
> 
> There are a set of changes from Paolo Bonzini:
> 
> 232e9255478f thread-pool: remove stopping variable
> 900fa208f506 thread-pool: replace semaphore with condition variable
> 3c7b72ddca9c thread-pool: optimize scheduling of completion bottom half
> 
> That landed in 7.1 that seem like possible candidates.

I think I've figured out the issue. I've sent a patch:
https://lore.kernel.org/qemu-devel/20230714152720.5077-1-anthony.perard@citrix.com/

I did run osstest with this patch, and 200 iteration of stop/start, no
more issue of qemu for dom0 disapearing. The issue I've found is osstest
not able to ssh to the guest, which seems to be started. And qemu for
dom0 is still running.

While the report exist:
    http://logs.test-lab.xenproject.org/osstest/logs/181785/

Cheers,

-- 
Anthony PERARD

