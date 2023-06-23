Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 769B073B39F
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 11:31:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCd8k-0005s9-Cl; Fri, 23 Jun 2023 05:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Kxto=CL=kaod.org=clg@ozlabs.org>)
 id 1qCd8f-0005jF-5x; Fri, 23 Jun 2023 05:31:34 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Kxto=CL=kaod.org=clg@ozlabs.org>)
 id 1qCd8b-0007J6-VD; Fri, 23 Jun 2023 05:31:31 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QnX73259Bz4x3j;
 Fri, 23 Jun 2023 19:31:27 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QnX710ycmz4wgj;
 Fri, 23 Jun 2023 19:31:24 +1000 (AEST)
Message-ID: <3792b9a3-7cce-1057-049b-139305fbca26@kaod.org>
Date: Fri, 23 Jun 2023 11:31:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/4] target/ppc: Fixes for instruction-related
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
References: <20230620131044.169110-1-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230620131044.169110-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=Kxto=CL=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 6/20/23 15:10, Nicholas Piggin wrote:
> Because they got more complexities than I first thought, these patches
> are broken out from the bigger series here:
> 
> https://lists.gnu.org/archive/html/qemu-ppc/2023-05/msg00425.html
> 
> Since then I fixed the --disable-tcg compile bug reported by Anushree
> hopefully. Also added a workaround for KVM so injected interrupts
> wouldn't attempt to find the prefix bit setting. I don't know how much
> that is really needed, but injection callers would have to set it one
> way or anohter if we need to add it.
> 
> Thanks,
> Nick
> 
> Nicholas Piggin (4):
>    target/ppc: Fix instruction loading endianness in alignment interrupt
>    target/ppc: Change partition-scope translate interface
>    target/ppc: Add SRR1 prefix indication to interrupt handlers
>    target/ppc: Implement HEIR SPR
> 
>   target/ppc/cpu.h         |   1 +
>   target/ppc/cpu_init.c    |  23 ++++++++
>   target/ppc/excp_helper.c | 110 ++++++++++++++++++++++++++++++++++++++-
>   target/ppc/mmu-radix64.c |  38 ++++++++++----
>   4 files changed, 159 insertions(+), 13 deletions(-)
> 

Applied to ppc-next.

Thanks,

C.



