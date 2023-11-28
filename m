Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FC27FC815
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 22:39:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r85mg-0003eU-Dn; Tue, 28 Nov 2023 16:38:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=PHl3=HJ=kaod.org=clg@ozlabs.org>)
 id 1r85mT-0003do-0t; Tue, 28 Nov 2023 16:38:10 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=PHl3=HJ=kaod.org=clg@ozlabs.org>)
 id 1r85mP-0001oM-82; Tue, 28 Nov 2023 16:38:08 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SfwmQ2sXCz4xQS;
 Wed, 29 Nov 2023 08:37:58 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SfwmL42NFz4wdD;
 Wed, 29 Nov 2023 08:37:53 +1100 (AEDT)
Message-ID: <771bdf1c-e688-4885-9e6b-100897141c51@kaod.org>
Date: Tue, 28 Nov 2023 22:37:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] pnv nest1 chiplet model
Content-Language: en-US
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
To: Chalapathi V <chalapathi.v@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 calebs@us.ibm.com, chalapathi.v@ibm.com, saif.abrar@linux.vnet.ibm.com
References: <20231127171307.5237-1-chalapathi.v@linux.ibm.com>
 <ed3e5f71-620c-48e7-a8c7-d083be78c192@kaod.org>
In-Reply-To: <ed3e5f71-620c-48e7-a8c7-d083be78c192@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=PHl3=HJ=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
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

On 11/28/23 18:38, Cédric Le Goater wrote:
> On 11/27/23 18:13, Chalapathi V wrote:
>> Hello,
>>
>> Thank you for the review and suggestions on V5.
>>
>> The suggestions and changes requested from V5 are addressed in V6.
>>
>> Updates in Version 6 of this series are:
>> 1. adding a device-tree node in QEMU is removed as skiboot defines the
>>     device-tree and QEMU should just follow it.
>> 2. Renamed PnvPerv to PnvNestChipletPervasive in PATCH1 as the model provides
>>     the common pervasive registers of all nest chiplets.
>> 3. Nest1_chiplet model in PATCH2 is renamed to N1_chiplet to avoid the
>>     confussions that may comeup later.
>>
>> Hence the new qom-tree looks like below.
>> (qemu) info qom-tree
>> /machine (powernv10-machine)
>>    /chip[0] (power10_v2.0-pnv-chip)
>>      /n1_chiplet (pnv-N1-chiplet)
>>        /nest_pervasive_common (pnv-nest-chiplet-pervasive)
>>          /xscom-n1_chiplet-control-regs[0] (memory-region)
>>        /xscom-n1_chiplet-pb-scom-eq-regs[0] (memory-region)
>>        /xscom-n1_chiplet-pb-scom-es-regs[0] (memory-region)
>>
>> Patches overview in V6.
>> PATCH1: Create a common nest pervasive chiplet model with control chiplet scom
>>          registers.
>> PATCH2: Create a N1 chiplet model and implement powerbus scom registers.
>>          Connect common nest pervasive model to N1 chiplet model to define
>>          chiplet control scoms for N1 chiplet.
>> PATCH3: Connect N1 chiplet model to p10 chip.
>>
>> Test covered:
>> These changes are tested on a single socket and 2 socket P10 machine.
> 
> 
> It would be nice to add in tests/avocado/ppc_powernv.py a simple test case
> for a 2 socket machine :
> 
>          self.vm.add_args('-smp', '8,sockets=2,cores=1,threads=4')
>      ...
>      console_pattern = 'smp: Brought up 2 nodes, 8 CPUs'

and test_linux_big_boot already exists ! :) Please run "make check
&& make check-avocado" before sending a patchset. This is a good way
to catch issues.

Thanks,

C.




