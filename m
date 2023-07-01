Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE98744821
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 11:07:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFWWQ-0000yj-DP; Sat, 01 Jul 2023 05:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=A2x2=CT=kaod.org=clg@ozlabs.org>)
 id 1qFWW0-0000id-9X; Sat, 01 Jul 2023 05:03:38 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=A2x2=CT=kaod.org=clg@ozlabs.org>)
 id 1qFWVy-0001MV-CM; Sat, 01 Jul 2023 05:03:36 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QtR6y38Zgz4wxN;
 Sat,  1 Jul 2023 19:03:22 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QtR6w1wwDz4wb5;
 Sat,  1 Jul 2023 19:03:19 +1000 (AEST)
Message-ID: <1b9c4cb9-7bbb-cf2a-6fa7-5867d9c4031a@kaod.org>
Date: Sat, 1 Jul 2023 11:03:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/2] target/ppc: Easy parts of the POWER chiptod series
To: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Frederic Barrat <fbarrat@linux.ibm.com>
References: <20230625120317.13877-1-npiggin@gmail.com>
 <3f70738c-f30a-99a6-6e06-e53b8f93f830@kaod.org>
 <9989efc7-5ad9-0c31-e0af-b8a735dce353@gmail.com>
 <CTQP7BKWD8W3.MP8NCILJUWDQ@wheely>
Content-Language: en-US
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <CTQP7BKWD8W3.MP8NCILJUWDQ@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=A2x2=CT=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.095,
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

>>> When you start building the next PPC PR, I think you can also take
>>> this patch :
>>>
>>>     [4/4] target/ppc: Implement core timebase state machine and TFMR
>>>     https://patchwork.ozlabs.org/project/qemu-ppc/patch/20230603233612.125879-5-npiggin@gmail.com/
>>>
>>> It belongs to the same series.
>>
>> That doesn't apply cleanly with these 2 patches and it didn't look trivial to
>> me. As if there were some code missing.
> 
> Yeah, it actually uses some signals from the nest chiptod patch.
> 
>> If Nick re-send it rebased on top of ppc-next I can queue it. Since it's a
>> rebase you can keep the r-b. Thanks,
> 
> I'll see how it goes, it may have to wait for next merge. SMT for
> powernv is a little more important since it's more user-facing and it
> would be nice to introduce SMT for both pseries and powernv together.

Yes. Please resend.

I gave the series a good try with an install of 23.04 on a powernv9
machine with 2*2*4 CPUs and running KVM SMP guests with libvirt.
It was performing quite well with MTTCG on a 32 CPU ryzen box. No
hangs, no crash. This is a great addition. Thanks for it.

I'll try VFIO after merge.

Cheers,

C.



  
> Chiptod for doesn't really do much except step through skiboot init
> code, and getting more useful things wired up like TB fault / HMI
> injection won't be ready before freeze.
> 
> Thanks,
> Nick


