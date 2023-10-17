Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C321C7CBBCE
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:58:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qse1F-0005on-7d; Tue, 17 Oct 2023 02:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=acei=F7=kaod.org=clg@ozlabs.org>)
 id 1qse1D-0005oW-8f; Tue, 17 Oct 2023 02:57:31 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=acei=F7=kaod.org=clg@ozlabs.org>)
 id 1qse1A-0004uu-6A; Tue, 17 Oct 2023 02:57:31 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4S8lCl0Fqvz4xPX;
 Tue, 17 Oct 2023 17:57:23 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4S8lCj1LNTz4xM1;
 Tue, 17 Oct 2023 17:57:20 +1100 (AEDT)
Message-ID: <3b61ecf1-e673-4439-98d3-662910c5fa4d@kaod.org>
Date: Tue, 17 Oct 2023 08:57:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] ppc/pnv: Add an I2C controller model
Content-Language: en-US
To: Miles Glenn <milesg@linux.vnet.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, fbarrat@linux.ibm.com
References: <20231012200851.3020858-1-milesg@linux.vnet.ibm.com>
 <20231012200851.3020858-2-milesg@linux.vnet.ibm.com>
 <31467531-ed8c-507e-1a39-3271fa375e59@linaro.org>
 <24edab4dde9a02341378b49babce49dc56b74c1c.camel@linux.vnet.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <24edab4dde9a02341378b49babce49dc56b74c1c.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=acei=F7=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/16/23 22:55, Miles Glenn wrote:
> On Fri, 2023-10-13 at 10:58 +0200, Philippe Mathieu-Daudé wrote:
>> Hi Glenn, Cédric,
>>
>> On 12/10/23 22:08, Glenn Miles wrote:
>>> From: Cédric Le Goater <clg@kaod.org>
>>>
>>> The more recent IBM power processors have an embedded I2C
>>> controller that is accessible by software via the XSCOM
>>> address space.
>>>
>>> Each instance of the I2C controller is capable of controlling
>>> multiple I2C buses (one at a time).  Prior to beginning a
>>> transaction on an I2C bus, the bus must be selected by writing
>>> the port number associated with the bus into the PORT_NUM
>>> field of the MODE register.  Once an I2C bus is selected,
>>> the status of the bus can be determined by reading the
>>> Status and Extended Status registers.
>>>
>>> I2C bus transactions can be started by writing a command to
>>> the Command register and reading/writing data from/to the
>>> FIFO register.
>>>
>>> Not supported :
>>>
>>>    . 10 bit I2C addresses
>>>    . Multimaster
>>>    . Slave
>>>
>>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>>> [milesg: Split wiring to powernv9 into its own commit]
>>> [milesg: Added more detail to commit message]
>>> [milesg: Added SPDX Licensed Identifier to new files]
>>> [milesg: updated copyright dates]
>>> [milesg: Added use of g_autofree]
>>> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
>>> ---
>>>
>>> Changes in v2:
>>>       - Updated copyright dates
>>>       - Removed copyright paragraph (replaced by SPDX-License-
>>> Identifier)
>>>       - Added use of g_autofree
>>>
>>>    hw/ppc/meson.build         |   1 +
>>>    hw/ppc/pnv_i2c.c           | 673
>>> +++++++++++++++++++++++++++++++++++++
>>>    include/hw/ppc/pnv_i2c.h   |  38 +++
>>>    include/hw/ppc/pnv_xscom.h |   3 +
>>>    4 files changed, 715 insertions(+)
>>>    create mode 100644 hw/ppc/pnv_i2c.c
>>>    create mode 100644 include/hw/ppc/pnv_i2c.h
>>> +/* I2C mode register */
>>> +#define I2C_MODE_REG                    0x6
>>> +#define I2C_MODE_BIT_RATE_DIV           PPC_BITMASK(0, 15)
>>> +#define I2C_MODE_PORT_NUM               PPC_BITMASK(16, 21)
>>> +#define I2C_MODE_ENHANCED               PPC_BIT(28)
>>> +#define I2C_MODE_DIAGNOSTIC             PPC_BIT(29)
>>> +#define I2C_MODE_PACING_ALLOW           PPC_BIT(30)
>>> +#define I2C_MODE_WRAP                   PPC_BIT(31)
>>> +static I2CBus *pnv_i2c_get_bus(PnvI2C *i2c)
>>> +{
>>> +    uint8_t port = GETFIELD(I2C_MODE_PORT_NUM, i2c-
>>>> regs[I2C_MODE_REG]);
>>> +
>>> +    if (port >= i2c->num_busses) {
>>
>> Can we sanitize in pnv_i2c_xscom_write() instead ...?
> 
> Hi Phil,
> 
> Thanks for taking a look.  You have a good question!  I tried reading
> through the spec that I have in order to see how the hardware reacts to
> an invalid port number being written to the mode register and didn't
> find anything obvious.
> 
> If we did what you suggest, how do we prevent attempts from accessing
> an invalid bus?  The options I see are:
> 
> 1) Do an assert on the port value being valid so invalid port values
> result in the process dieing.  Uses the big hammer, but simple to
> implement and exposes problems early on.
> 
> 2) Fail the xscom write.  There doesn't seem to be an easy way to
> notify software of the xscom write failure, and xscom write failures
> probably shouldn't happen as long as we are writing to a correct xscom
> address.

HW would probably set FIR bits in the various impacted logics
to track/report the error and raise an HMI.

This is badly implemented in QEMU :

   static void xscom_complete(CPUState *cs, uint64_t hmer_bits)
   {
       /*
        * TODO: When the read/write comes from the monitor, NULL is
        * passed for the cpu, and no CPU completion is generated.
        */
       if (cs) {
           PowerPCCPU *cpu = POWERPC_CPU(cs);
           CPUPPCState *env = &cpu->env;

           /*
            * TODO: Need a CPU helper to set HMER, also handle generation
            * of HMIs
            */
           cpu_synchronize_state(cs);
           env->spr[SPR_HMER] |= hmer_bits;
       }
   }


> 
> 3) Allow the xscom write, but prevent writing an invalid port value.
> Simple, but hides the failure and will probably lead to less obvious
> failures down the road.
> 
> Do you have other suggestions?  Honestly, I don't like any of these
> options, but if I had to pick one, I'd probably choose option 1.  Even
> though it's the sledge hammer approach, it prevents access of an
> invalid bus, and exposes the error early on.
> 
> Cedric's approach allows for the invalid port values to be written to
> the register which is, IMHO, most likely what the hardware would do.
> However, it does look like there are some areas where we do not handle
> getting a NULL pointer from pnv_i2c_get_bus() correctly.  For example,
> i2c_bus_busy() doesn't check for NULL and yet we are passing the return
> value of pnv_i2c_get_bus into that function without checking it.
> 
> So, after looking into this a bit, I think I prefer Cedric's approach
> with the addition of auditing all of the places where pnv_i2c_get_bus()
> is called and handling the NULL case better.
> 
> Of course, I may have missed something and look forward to other
> suggestions as well.

It is difficult to be that precise in the models. Reporting in QEMU
is good enough unless you are interested in modeling failures.
  
The skiboot FW being close to HW it would be interesting. You would
need mechanisms to inject errors. Nick proposed an mce interface
some years ago on that topic.

Thanks,

C.



> Thanks,
> 
> Glenn
> 
>>
>>> +        qemu_log_mask(LOG_GUEST_ERROR, "I2C: invalid bus number
>>> %d/%d\n", port,
>>> +                      i2c->num_busses);
>>> +        return NULL;
>>> +    }
>>> +    return i2c->busses[port];
>>> +}
>>> +static void pnv_i2c_xscom_write(void *opaque, hwaddr addr,
>>> +                                uint64_t val, unsigned size)
>>> +{
>>> +    PnvI2C *i2c = PNV_I2C(opaque);
>>> +    uint32_t offset = addr >> 3;
>>> +
>>> +    switch (offset) {
>>> +    case I2C_MODE_REG:
>>
>> ... here?
>>
>>> +        i2c->regs[offset] = val;
>>> +        if (i2c_bus_busy(pnv_i2c_get_bus(i2c))) {
>>> +            i2c->regs[I2C_STAT_REG] |= I2C_STAT_INVALID_CMD;
>>> +            qemu_log_mask(LOG_GUEST_ERROR, "I2C: command in
>>> progress\n");
>>> +        }
>>> +        break;
>>
>> [...]
>>
>> Regards,
>>
>> Phil.
> 


