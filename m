Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FD378C9D5
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 18:44:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb1od-00054D-SY; Tue, 29 Aug 2023 12:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=bkLz=EO=kaod.org=clg@ozlabs.org>)
 id 1qb1oX-0004va-Kh; Tue, 29 Aug 2023 12:43:37 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=bkLz=EO=kaod.org=clg@ozlabs.org>)
 id 1qb1oT-0000xr-1k; Tue, 29 Aug 2023 12:43:37 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RZtXc51Gpz4wxn;
 Wed, 30 Aug 2023 02:43:28 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RZtXZ1CmDz4wb0;
 Wed, 30 Aug 2023 02:43:25 +1000 (AEST)
Message-ID: <9b7e4490-bfa9-7efb-5092-8e0eb801727f@kaod.org>
Date: Tue, 29 Aug 2023 18:43:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.2 0/6] ppc: debug facility improvements
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20230808031116.398205-1-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230808031116.398205-1-npiggin@gmail.com>
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

On 8/8/23 05:11, Nicholas Piggin wrote:
> I started out looking at this to reduce divergence of TCG and KVM
> machines with 2nd DAWR. The divergence already exists with first
> DAWR, so I don't want to tie the KVM 2nd DAWR enablement to this,
> but it would be nice to ensure the caps and such for the 2nd DAWR
> will also work for TCG.
> 
> I don't know that we have great test cases for this, it does work
> with some of the Linux selftests ptrace debug tests (although those
> tests seem to have a few issues in upstream kernels), some basic
> Linux xmon and gdb tests by hand, and I've started working on some
> kvm unit tests.
> 
> Thanks,
> Nick
> 
> Nicholas Piggin (6):
>    target/ppc: Remove single-step suppression inside 0x100-0xf00
>    target/ppc: Improve book3s branch trace interrupt for v2.07S
>    target/ppc: Suppress single step interrupts on rfi-type instructions
>    target/ppc: Implement breakpoint debug facility for v2.07S
>    target/ppc: Implement watchpoint debug facility for v2.07S
>    spapr: implement H_SET_MODE debug facilities
> 
>   hw/ppc/spapr_hcall.c     |  57 +++++++++++++++++++++
>   target/ppc/cpu.c         |  86 +++++++++++++++++++++++++++++++
>   target/ppc/cpu.h         |   7 +++
>   target/ppc/cpu_init.c    |  11 ++--
>   target/ppc/excp_helper.c | 108 ++++++++++++++++++++++++++++++++++++++-
>   target/ppc/helper.h      |   4 ++
>   target/ppc/internal.h    |   3 ++
>   target/ppc/machine.c     |   5 ++
>   target/ppc/misc_helper.c |  15 ++++++
>   target/ppc/spr_common.h  |   3 ++
>   target/ppc/translate.c   |  60 +++++++++++++++++-----
>   11 files changed, 341 insertions(+), 18 deletions(-)
> 

I am preparing a PR with this series. It is time to take a look at it if you
haven't already !


Thanks,

C.


