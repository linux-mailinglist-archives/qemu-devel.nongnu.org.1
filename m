Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F38857E6E15
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 16:55:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r17MJ-00010G-TL; Thu, 09 Nov 2023 10:54:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=uA+F=GW=kaod.org=clg@ozlabs.org>)
 id 1r17MI-0000zl-L4; Thu, 09 Nov 2023 10:54:18 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=uA+F=GW=kaod.org=clg@ozlabs.org>)
 id 1r17MG-0007p8-I2; Thu, 09 Nov 2023 10:54:18 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SR62X0bB1z4xjV;
 Fri, 10 Nov 2023 02:54:12 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SR62T62Pxz4xjG;
 Fri, 10 Nov 2023 02:54:09 +1100 (AEDT)
Message-ID: <de9177ea-c444-4710-8eda-7cecaef06eb7@kaod.org>
Date: Thu, 9 Nov 2023 16:54:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc/pnv: Fix potential overflow in I2C model
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles
 <milesg@linux.vnet.ibm.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20231109080536.1005500-1-clg@kaod.org>
 <CAFEAcA_vs==UgZGkuW96wY=tdHXxk8cu1O7HRGKAoAj=Ltyv1A@mail.gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <CAFEAcA_vs==UgZGkuW96wY=tdHXxk8cu1O7HRGKAoAj=Ltyv1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=uA+F=GW=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 11/9/23 16:02, Peter Maydell wrote:
> On Thu, 9 Nov 2023 at 08:06, Cédric Le Goater <clg@kaod.org> wrote:
>>
>> Coverity warns that "i2c_bus_busy(i2c->busses[i]) << i" might overflow
>> because the expression is evaluated using 32-bit arithmetic and then
>> used in a context expecting a uint64_t.
>>
>> Fixes: Coverity CID 1523918
>> Cc: Glenn Miles <milesg@linux.vnet.ibm.com>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>   hw/ppc/pnv_i2c.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/ppc/pnv_i2c.c b/hw/ppc/pnv_i2c.c
>> index f75e59e70977..ab73c59f7704 100644
>> --- a/hw/ppc/pnv_i2c.c
>> +++ b/hw/ppc/pnv_i2c.c
>> @@ -437,7 +437,7 @@ static uint64_t pnv_i2c_xscom_read(void *opaque, hwaddr addr,
>>       case I2C_PORT_BUSY_REG: /* compute busy bit for each port  */
>>           val = 0;
>>           for (i = 0; i < i2c->num_busses; i++) {
>> -            val |= i2c_bus_busy(i2c->busses[i]) << i;
>> +            val |= (uint64_t) i2c_bus_busy(i2c->busses[i]) << i;
>>           }
>>           break;
> 
> Should the device's realize function also impose a max
> limit on the num-busses property? There doesn't seem to be
> anything preventing a caller from setting it to a big
> number like 128, which would then be UB here.

yes. I will add an assert(i2c->num_busses < 64). The current max
is 16 for POWER10.

> Style nit: casts shouldn't have a space after them before
> the thing they're casting.

yep.

I prefer the cast method than the deposit call. Philippe, I hope you
don't mind ?

Thanks,

C.



