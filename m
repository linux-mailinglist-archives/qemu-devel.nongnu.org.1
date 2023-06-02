Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 157F871FAE4
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 09:23:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4z6U-0002dD-Es; Fri, 02 Jun 2023 03:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=WIde=BW=kaod.org=clg@ozlabs.org>)
 id 1q4z6L-0002Us-Pv; Fri, 02 Jun 2023 03:21:36 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=WIde=BW=kaod.org=clg@ozlabs.org>)
 id 1q4z6J-000614-2d; Fri, 02 Jun 2023 03:21:33 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QXZDg72W2z4x4H;
 Fri,  2 Jun 2023 17:21:23 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QXZDf2dtfz4x41;
 Fri,  2 Jun 2023 17:21:22 +1000 (AEST)
Message-ID: <d828bb88-4a8d-3f89-0ca9-2db2b5e6f24c@kaod.org>
Date: Fri, 2 Jun 2023 09:21:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 0/5] target/ppc: initial SMT support in TCG
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20230531012313.19891-1-npiggin@gmail.com>
 <bad4b347-e129-ff7d-3b9b-23d964c68350@kaod.org>
 <CT1YZ02RYMRT.1LL84FLYLC3DO@wheely>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <CT1YZ02RYMRT.1LL84FLYLC3DO@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=WIde=BW=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.1, RCVD_IN_DNSWL_MED=-2.3,
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

On 6/2/23 09:01, Nicholas Piggin wrote:
> On Thu Jun 1, 2023 at 5:56 PM AEST, Cédric Le Goater wrote:
>> Hello Nick,
>>
>> On 5/31/23 03:23, Nicholas Piggin wrote:
>>> Hi,
>>>
>>> I'm posting this now just to get some first thoughts. I wouldn't say
>>> it's ready but it does actually work with some basic tests including
>>> pseries booting a Linux distro. I have powernv booting too, it just
>>> requires some more SPRs converted, nothing fundamentally different so
>>> for the purpose of this RFC I leave it out.
>>>
>>> A couple of things, I don't know the object model well enough to do
>>> something nice with topology. Iterating siblings I would have thought
>>> should be going to parent core then iterating its children CPUs. Should
>>> that be done with the object model, or is it better to add direct
>>> pointers in CPUs to core and core to CPUs? It is (semi) important for> performance so maybe that is better than object iterators. If we go that
>>> way, the PnvCore and SpaprCore have pointers to the SMT threads already,
>>> should those be abstracted go in the CPUCore?
>>
>> You should be able to move the thread array into the CPUCore. If you do
>> that, please check that migration compat is not impacted by the state
>> change. However, I am not sure you can use the CPUCore model under the
>> insn modeling. Something to check.
> 
> Okay.
> 
>> Anyhow, the way you implemented the loop on the siblings is sufficiently
>> fast for a small numbers of CPU and safe, w.r.t to CPU hotplug. So
>> I would leave that part for now, if it runs decently with 4*4 vCPUs in
>> TCG it should be fine.
> 
> Yeah you're right I'm overly paranoid about it but we don't do hundreds
> of CPUs in TCG so it should be fine. 

The PowerNV did run with 64 CPUs at some point. Boot was slow bc of
contention in some areas when starting the secondaries. When stabilized,
perf was decent.

I think that a realistic goal for book3s is to support 2 sockets * 2 cores
* 4 threads on PowerNV and 16 vCPUs on pseries, this to exercise the various
ways to IPI on the different HV implementations.

> Maybe I will defer it for now then and just do the CPU iteration.

May be there is some value to store a CPU siblings under the PowerPC
CPU descriptor. IT could be useful for instructions that apply to the
current CPU but for others requiring a PIR value, you will have to
find a starting point in the CPU list, so it won't make much difference
I think.

Thanks,

C.



> 
> Thanks,
> Nick


