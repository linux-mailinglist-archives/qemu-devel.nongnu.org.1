Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC637ED755
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 23:36:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3OTI-0006xc-3k; Wed, 15 Nov 2023 17:34:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=a0ac=G4=kaod.org=clg@ozlabs.org>)
 id 1r3OTF-0006x6-Mp; Wed, 15 Nov 2023 17:34:53 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=a0ac=G4=kaod.org=clg@ozlabs.org>)
 id 1r3OTD-0003yS-Fl; Wed, 15 Nov 2023 17:34:53 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SVydx2Kjsz4xGQ;
 Thu, 16 Nov 2023 09:34:45 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SVydv4X03z4x5p;
 Thu, 16 Nov 2023 09:34:43 +1100 (AEDT)
Message-ID: <bd0875a1-4258-457d-8a9b-cfa12f0d84ef@kaod.org>
Date: Wed, 15 Nov 2023 23:34:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] ppc/pnv: Add pca9552 to powernv10 for PCIe hotplug
 power control
Content-Language: en-US
To: Miles Glenn <milesg@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>
References: <20231114195659.1219821-1-milesg@linux.vnet.ibm.com>
 <20231114195659.1219821-2-milesg@linux.vnet.ibm.com>
 <54fad54f-a52e-41c6-90ba-7bc0b637cd59@kaod.org>
 <d5c90e92aa4cf313925de81872e95d0b62c36cce.camel@linux.vnet.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <d5c90e92aa4cf313925de81872e95d0b62c36cce.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=a0ac=G4=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 11/15/23 17:37, Miles Glenn wrote:
> On Wed, 2023-11-15 at 08:28 +0100, Cédric Le Goater wrote:
>> On 11/14/23 20:56, Glenn Miles wrote:
>>> The Power Hypervisor code expects to see a pca9552 device connected
>>> to the 3rd PNV I2C engine on port 1 at I2C address 0x63 (or left-
>>> justified address of 0xC6).  This is used by hypervisor code to
>>> control PCIe slot power during hotplug events.
>>>
>>> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
>>> ---
>>> Based-on: <20231024181144.4045056-3-milesg@linux.vnet.ibm.com>
>>> [PATCH v3 2/2] misc/pca9552: Let external devices set pca9552
>>> inputs
>>>
>>> No changes from v2
>>>
>>>    hw/ppc/Kconfig | 1 +
>>>    hw/ppc/pnv.c   | 7 +++++++
>>>    2 files changed, 8 insertions(+)
>>>
>>> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
>>> index 56f0475a8e..f77ca773cf 100644
>>> --- a/hw/ppc/Kconfig
>>> +++ b/hw/ppc/Kconfig
>>> @@ -32,6 +32,7 @@ config POWERNV
>>>        select XIVE
>>>        select FDT_PPC
>>>        select PCI_POWERNV
>>> +    select PCA9552
>>>    
>>>    config PPC405
>>>        bool
>>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>>> index 9c29727337..7afaf1008f 100644
>>> --- a/hw/ppc/pnv.c
>>> +++ b/hw/ppc/pnv.c
>>> @@ -1877,6 +1877,13 @@ static void
>>> pnv_chip_power10_realize(DeviceState *dev, Error **errp)
>>>                                  qdev_get_gpio_in(DEVICE(&chip10-
>>>> psi),
>>>                                                   PSIHB9_IRQ_SBE_I2C
>>> ));
>>>        }
>>> +
>>> +    /*
>>> +     * Add a PCA9552 I2C device for PCIe hotplug control
>>> +     * to engine 2, bus 1, address 0x63
>>> +     */
>>> +    i2c_slave_create_simple(chip10->i2c[2].busses[1], "pca9552",
>>> 0x63);
>>
>> You didn't answer my question in v2. Is this a P10 chip device or a
>> board/machine device ?
>>
>> Thanks,
>>
>> C.
>>
>>
> 
> Sorry, you're right, I did miss that one, and after looking at the
> Denali spec, I see that the topology is indeed different from Rainier
> (which is what I have been modeling).  For the Denali, the PCA9552
> has a different I2C address (0x62 instead of 0x63) and the GPIO
> connections are also different.  Also, there is no PCA9554 chip because
> it looks like they were able to cover all of the functionality with
> just the  GPIO's of the PCA9552.  So, good catch!
> 
> I'll look at what they did on the Aspeed machines like you suggested.

It should be a machine class extension with an i2c_setup handler and
a new "powernv10-rainier" machine modeling the board layout. The rest
looks good.

Please include the pca9552 series in the respin. The pca9554 model will
need a MAINTAINER (you?) I would be happy to let you take over pca9552
if you agree.

First, let's get patch 3 and 4 in QEMU 8.2.

Thanks,

C.




> 
> Thanks,
> 
> Glenn
> 
>>
>>>    }
>>>    
>>>    static uint32_t pnv_chip_power10_xscom_pcba(PnvChip *chip,
>>> uint64_t addr)
> 


