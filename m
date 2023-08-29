Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D1878C9D3
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 18:44:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb1of-00059Z-IA; Tue, 29 Aug 2023 12:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=bkLz=EO=kaod.org=clg@ozlabs.org>)
 id 1qb1oX-0004w0-PV; Tue, 29 Aug 2023 12:43:37 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=bkLz=EO=kaod.org=clg@ozlabs.org>)
 id 1qb1oS-0000xL-U2; Tue, 29 Aug 2023 12:43:37 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RZtXW57RHz4wxQ;
 Wed, 30 Aug 2023 02:43:23 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RZtXS2qt6z4wb0;
 Wed, 30 Aug 2023 02:43:20 +1000 (AEST)
Message-ID: <feb8c7a6-21ea-fb89-efea-d70d353d2a3e@kaod.org>
Date: Tue, 29 Aug 2023 18:43:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 for-8.2 00/19] ppc: record-replay enablement and fixes
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20230808042001.411094-1-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230808042001.411094-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=bkLz=EO=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-1.242,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

Hello,

On 8/8/23 06:19, Nicholas Piggin wrote:
> The patches in this series has been seen a few times in various
> iterations.
> 
> There are two main pieces, some assorted small fixes and tests for
> record-replay, plus a large set of decrementer fixes. I merged these
> into one series rather than send decrementer fixes alone first, because
> record-replay has been very good at uncovering timer problems, so it's
> good to have those test cases in at the same time IMO.
> 
> Some of the fixes we might take to stable, but unclear which.
> Decrementer fixes were a bit of a tangle so maybe we just leave those
> alone since they work okay.
> 
> The decrementer is not emulated perfectly still. Underflow from -ve
> to +ve is not implemented, for one. I started doing that but it's not
> trivial so better stop here for now.
> 
> For record-replay, pseries is now quite solid with rr. Surely some
> issues to iron out but it is becoming usable.
> 
> powernv record-replay has some known problems migrating edge-triggered
> decrementer, and edge triggered msgsnd. Also it seems to get stuck in
> xive init somewhere when replaying from checkpoint, so there is probably
> some state in xive not being reset. But at least it runs the avocado
> test and seems close to working, so I've added that test case so we
> don't go backwards (ha!).
> 
> Other machine types might not be too far off if there is interest. I
> found it quite difficult to find these problems though, reverse
> debugging will sometimes just lock up, stop at wrong location, or abort
> with wrong event. Difficult understand what went wrong. Worst case I had
> to basically bisect the replay of the trace, and find the minimum length
> of replay that hit the problem -- that sometimes would land near a
> mtDEC or timer interrupt or similar.
> 
> Thanks,
> Nick
> 
> Nicholas Piggin (19):
>    ppc/vhyp: reset exception state when handling vhyp hcall
>    ppc/vof: Fix missed fields in VOF cleanup
>    hw/ppc/ppc.c: Tidy over-long lines
>    hw/ppc: Introduce functions for conversion between timebase and
>      nanoseconds
>    host-utils: Add muldiv64_round_up
>    hw/ppc: Round up the decrementer interval when converting to ns
>    hw/ppc: Avoid decrementer rounding errors
>    target/ppc: Sign-extend large decrementer to 64-bits
>    hw/ppc: Always store the decrementer value
>    target/ppc: Migrate DECR SPR
>    hw/ppc: Reset timebase facilities on machine reset
>    hw/ppc: Read time only once to perform decrementer write
>    target/ppc: Fix CPU reservation migration for record-replay
>    target/ppc: Fix timebase reset with record-replay
>    spapr: Fix machine reset deadlock from replay-record
>    spapr: Fix record-replay machine reset consuming too many events
>    tests/avocado: boot ppc64 pseries replay-record test to Linux VFS
>      mount
>    tests/avocado: reverse-debugging cope with re-executing breakpoints
>    tests/avocado: ppc64 reverse debugging tests for pseries and powernv
> 
>   hw/ppc/mac_oldworld.c              |   1 +
>   hw/ppc/pegasos2.c                  |   1 +
>   hw/ppc/pnv_core.c                  |   2 +
>   hw/ppc/ppc.c                       | 236 +++++++++++++++++++----------
>   hw/ppc/prep.c                      |   1 +
>   hw/ppc/spapr.c                     |  32 +++-
>   hw/ppc/spapr_cpu_core.c            |   2 +
>   hw/ppc/vof.c                       |   2 +
>   include/hw/ppc/ppc.h               |   3 +-
>   include/hw/ppc/spapr.h             |   2 +
>   include/qemu/host-utils.h          |  21 ++-
>   target/ppc/compat.c                |  19 +++
>   target/ppc/cpu.h                   |   3 +
>   target/ppc/excp_helper.c           |   3 +
>   target/ppc/machine.c               |  40 ++++-
>   target/ppc/translate.c             |   4 +
>   tests/avocado/replay_kernel.py     |   3 +-
>   tests/avocado/reverse_debugging.py |  54 ++++++-
>   18 files changed, 330 insertions(+), 99 deletions(-)
> 

I am preparing a PR with this series. It is time to take a look at it if you
haven't already !

Thanks,

C.

