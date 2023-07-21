Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DB175CF3B
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 18:28:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMsyi-00014X-Jp; Fri, 21 Jul 2023 12:27:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=m9Dp=DH=kaod.org=clg@ozlabs.org>)
 id 1qMsyg-000142-9h; Fri, 21 Jul 2023 12:27:38 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=m9Dp=DH=kaod.org=clg@ozlabs.org>)
 id 1qMsye-00037B-2C; Fri, 21 Jul 2023 12:27:38 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4R6w291Xn8z4wyd;
 Sat, 22 Jul 2023 02:27:29 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4R6w250y40z4wxT;
 Sat, 22 Jul 2023 02:27:24 +1000 (AEST)
Message-ID: <55eab9ca-0f55-626e-f02b-086c3b912902@kaod.org>
Date: Fri, 21 Jul 2023 18:27:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] target/ppc: Generate storage interrupts for radix RC
 changes
Content-Language: en-US
To: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Shawn Anastasio <sanastasio@raptorengineering.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Timothy Pearson <tpearson@raptorengineering.com>,
 Frederic Barrat <fbarrat@linux.ibm.com>
References: <20230712161322.2729950-1-sanastasio@raptorengineering.com>
 <c76c0d05-4c69-aa4f-5d20-3dfdb165a765@kaod.org>
 <1004ffbe-8855-75d1-45e7-65360bfd1807@raptorengineering.com>
 <CU7I2BT516P3.1NJPQWALJTVR@wheely>
 <53f9edf9-1796-340a-ceb7-4b6ed1963748@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <53f9edf9-1796-340a-ceb7-4b6ed1963748@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=m9Dp=DH=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.094,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 7/21/23 18:08, Daniel Henrique Barboza wrote:
> 
> 
> On 7/20/23 23:38, Nicholas Piggin wrote:
>> On Thu Jul 13, 2023 at 3:35 AM AEST, Shawn Anastasio wrote:
>>> On 7/12/23 11:56 AM, Cédric Le Goater wrote:
>>>> Hello Shawn,
>>>>
>>>> On 7/12/23 18:13, Shawn Anastasio wrote:
>>>>> Change radix model to always generate a storage interrupt when the R/C
>>>>> bits are not set appropriately in a PTE instead of setting the bits
>>>>> itself.  According to the ISA both behaviors are valid, but in practice
>>>>> this change more closely matches behavior observed on the POWER9 CPU.
>>>>
>>>> How did you spotted this dark corner case in emulation ? Do you have
>>>> MMU unit tests ?
>>>
>>> I'm currently porting Xen to Power and have been using QEMU's powernv
>>> model extensively for early bring up. I noticed the issue when my radix
>>> implementation worked in QEMU but failed on actual hardware since I
>>> didn't have a proper storage interrupt handler implemented.
>>
>> Cool. This was on my todo list because we rely on it for nested HV
>> KVM too.
>>
>> I actually didn't know about that odd effLIPD=0 exception, but it
>> looks right. How did you test that, by running with MSR[HV]=0 and
>> LPIDR=0 ?
>>
>> For the patch,
>>
>> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> 
> Cedric, do you think this is 8.1 material?

No. It is improving the MMU model but it is not fixing something that
was "broken" in QEMU. I would leave it for 8.2.

However, these are 8.1 material :

  https://patchwork.ozlabs.org/project/qemu-ppc/list/?series=364971
  https://patchwork.ozlabs.org/project/qemu-ppc/list/?series=364984

but they lack a Fixes tag. I asked Nick.

C.

