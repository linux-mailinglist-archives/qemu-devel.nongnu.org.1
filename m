Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F327194D3
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 09:58:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4dBI-0006EU-OZ; Thu, 01 Jun 2023 03:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=vOrz=BV=kaod.org=clg@ozlabs.org>)
 id 1q4dBG-0006E6-15; Thu, 01 Jun 2023 03:57:10 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=vOrz=BV=kaod.org=clg@ozlabs.org>)
 id 1q4dBD-0004jI-JB; Thu, 01 Jun 2023 03:57:09 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QWz4D4cfMz4x4G;
 Thu,  1 Jun 2023 17:57:00 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QWz4C0Xrrz4whk;
 Thu,  1 Jun 2023 17:56:58 +1000 (AEST)
Message-ID: <bad4b347-e129-ff7d-3b9b-23d964c68350@kaod.org>
Date: Thu, 1 Jun 2023 09:56:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 0/5] target/ppc: initial SMT support in TCG
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20230531012313.19891-1-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230531012313.19891-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=vOrz=BV=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.091, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hello Nick,

On 5/31/23 03:23, Nicholas Piggin wrote:
> Hi,
> 
> I'm posting this now just to get some first thoughts. I wouldn't say
> it's ready but it does actually work with some basic tests including
> pseries booting a Linux distro. I have powernv booting too, it just
> requires some more SPRs converted, nothing fundamentally different so
> for the purpose of this RFC I leave it out.
> 
> A couple of things, I don't know the object model well enough to do
> something nice with topology. Iterating siblings I would have thought
> should be going to parent core then iterating its children CPUs. Should
> that be done with the object model, or is it better to add direct
> pointers in CPUs to core and core to CPUs? It is (semi) important for> performance so maybe that is better than object iterators. If we go that
> way, the PnvCore and SpaprCore have pointers to the SMT threads already,
> should those be abstracted go in the CPUCore?

You should be able to move the thread array into the CPUCore. If you do
that, please check that migration compat is not impacted by the state
change. However, I am not sure you can use the CPUCore model under the
insn modeling. Something to check.

Anyhow, the way you implemented the loop on the siblings is sufficiently
fast for a small numbers of CPU and safe, w.r.t to CPU hotplug. So
I would leave that part for now, if it runs decently with 4*4 vCPUs in
TCG it should be fine.

Thanks,

C.


  
> The other thing is the serialisation of access. It's using the atomic
> single stepping for this which... I guess should be sufficient? Is it
> the best way to do it though? Can a lock be used somehow instead?
> 
> Thanks,
> Nick
> 
> Nicholas Piggin (5):
>    target/ppc: gdbstub init spr gdb_id for all CPUs
>    target/ppc: Add initial flags and helpers for SMT support
>    target/ppc: Add support for SMT CTRL register
>    target/ppc: Add msgsnd/p and DPDES SMT support
>    spapr: Allow up to 8 threads SMT configuration
> 
>   hw/ppc/ppc.c                                  |  6 ++
>   hw/ppc/spapr.c                                |  4 +-
>   hw/ppc/spapr_cpu_core.c                       |  7 +-
>   include/hw/ppc/ppc.h                          |  1 +
>   target/ppc/cpu.h                              | 16 +++-
>   target/ppc/cpu_init.c                         |  5 +
>   target/ppc/excp_helper.c                      | 86 ++++++++++++-----
>   target/ppc/gdbstub.c                          | 32 ++++---
>   target/ppc/helper.h                           |  4 +-
>   target/ppc/misc_helper.c                      | 93 +++++++++++++++++--
>   target/ppc/translate.c                        | 46 ++++++++-
>   .../ppc/translate/processor-ctrl-impl.c.inc   |  2 +-
>   12 files changed, 252 insertions(+), 50 deletions(-)
> 


