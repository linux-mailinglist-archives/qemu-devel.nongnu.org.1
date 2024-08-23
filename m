Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8A395C67A
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Aug 2024 09:24:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shOdy-0002Hy-KW; Fri, 23 Aug 2024 03:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <a.fatoum@pengutronix.de>)
 id 1shOdw-0002HV-8u
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 03:23:32 -0400
Received: from metis.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::104])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <a.fatoum@pengutronix.de>)
 id 1shOdu-0005z5-2l
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 03:23:32 -0400
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77]
 helo=[127.0.0.1])
 by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
 (envelope-from <a.fatoum@pengutronix.de>)
 id 1shOdp-0003RF-5o; Fri, 23 Aug 2024 09:23:25 +0200
Message-ID: <a90fe9aa-5835-4045-b719-8764cdb037cc@pengutronix.de>
Date: Fri, 23 Aug 2024 09:23:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] hw/openrisc/openrisc_sim: keep serial@90000000 as
 default
To: Stafford Horne <shorne@gmail.com>
Cc: qemu-devel@nongnu.org, "Jason A . Donenfeld" <Jason@zx2c4.com>,
 linux-openrisc@vger.kernel.org
References: <20240822163838.3722764-1-a.fatoum@pengutronix.de>
 <ZsgsG_WL7TNcM1_l@antec>
Content-Language: en-US
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <ZsgsG_WL7TNcM1_l@antec>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: qemu-devel@nongnu.org
Received-SPF: pass client-ip=2a0a:edc0:2:b01:1d::104;
 envelope-from=a.fatoum@pengutronix.de; helo=metis.whiteo.stw.pengutronix.de
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hello Stafford,

On 23.08.24 08:28, Stafford Horne wrote:
> Note the distribution list you use here: openrisc@lists.librecores.org
> Is old and we should use linux-openrisc@vger.kernel.org.  I will get the qemu
> maintainer file updated.

So this list is appropriate for all openrisc-related development and not only
for the kernel?

> On Thu, Aug 22, 2024 at 06:38:38PM +0200, Ahmad Fatoum wrote:
>> We used to only have a single UART on the platform and it was located at
>> address 0x90000000. When the number of UARTs was increased to 4, the
>> first UART remained at its location, but instead of being the first one
>> to be registered, it became the last.
>>
>> This caused QEMU to pick 0x90000300 as the default UART, which broke
>> software that hardcoded the address of 0x90000000 and expected its
>> output to be visible when the user configured only a single console.
> 
> This makes sense but what do you mean here by DEFAULT uart?  I guess you mean
> the one connected to qemu's stdout by default?

Yes. I am not keen on the QEMU terminology, but the first registered UART seems
to have a special place. Besides being connected to QEMU's stdio by default,
it's also used to populate /chosen/stdout-path as can be seen when dumping the dtb:

  qemu-system-or1k -kernel /dev/null -machine or1k-sim,dumpdtb=qemu.dtb -nographic


>> This caused regressions[1] in the barebox test suite when updating to a
>> newer QEMU. As there seems to be no good reason to register the UARTs in
>> inverse order, let's register them by ascending address, so existing
>> software can remain oblivious to the additional UART ports.
> 
> This sounds good to me.  I will test this out and queue to qemu after the small
> clarification above.
> 
> Also, I will wait to see if Jason has anything to say.

Sure.

By the way, I botched the RESEND and forgot following two lines:

  Fixes: 777784bda468 ("hw/openrisc: support 4 serial ports in or1ksim")
  Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

Let me know if I should resend (provided there's no code changes warranting a v2).

Thanks,
Ahmad

> 
> -Stafford
> 
>> [1]: https://lore.barebox.org/barebox/707e7c50-aad1-4459-8796-0cc54bab32e2@pengutronix.de/T/#m5da26e8a799033301489a938b5d5667b81cef6ad
>> ---
>> v1 -> RESEND:
>>   - expand addressees beyond apparently defunct openrisc@lists.librecores.org
>>
>> NOTE: I am not familiar with QEMU internals, so please let me know
>> if registration in inverse order served a particular purpose.
>> ---
>>  hw/openrisc/openrisc_sim.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
>> index bffd6f721f7b..d147b00e4817 100644
>> --- a/hw/openrisc/openrisc_sim.c
>> +++ b/hw/openrisc/openrisc_sim.c
>> @@ -265,7 +265,7 @@ static void openrisc_sim_serial_init(Or1ksimState *state, hwaddr base,
>>          serial_irq = get_cpu_irq(cpus, 0, irq_pin);
>>      }
>>      serial_mm_init(get_system_memory(), base, 0, serial_irq, 115200,
>> -                   serial_hd(OR1KSIM_UART_COUNT - uart_idx - 1),
>> +                   serial_hd(uart_idx),
>>                     DEVICE_NATIVE_ENDIAN);
>>  
>>      /* Add device tree node for serial. */
>> -- 
>> 2.39.2
>>
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

