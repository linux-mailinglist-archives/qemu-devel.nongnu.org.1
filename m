Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD17A71FE1F
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 11:43:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q51Id-00037G-Cm; Fri, 02 Jun 2023 05:42:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pmenzel@molgen.mpg.de>)
 id 1q51IZ-00036q-8N
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 05:42:19 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pmenzel@molgen.mpg.de>)
 id 1q51IU-0000Hs-DO
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 05:42:19 -0400
Received: from [192.168.0.2] (ip5f5aebf4.dynamic.kabel-deutschland.de
 [95.90.235.244])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5FFB461E4052B;
 Fri,  2 Jun 2023 11:41:46 +0200 (CEST)
Message-ID: <84950b01-b88e-fec5-fe5f-eb4eeddee3d1@molgen.mpg.de>
Date: Fri, 2 Jun 2023 11:41:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Intel-wired-lan] [PATCH] e1000e: Add ICR clearing by
 corresponding IMS bit
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Andrew Melnychenko <andrew@daynix.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang
 <jasowang@redhat.com>, qemu-devel@nongnu.org,
 intel-wired-lan@lists.osuosl.org, Benjamin Poirier <bpoirier@suse.com>
References: <20230602072516.42502-1-akihiko.odaki@daynix.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230602072516.42502-1-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=141.14.17.11; envelope-from=pmenzel@molgen.mpg.de;
 helo=mx3.molgen.mpg.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Dear Akihiko,


Thank you for your patch.

After looking at the diff, it looks like this is a QEMU patch, and not 
one for the Linux kernel. I leave my inline comments anyway.


Am 02.06.23 um 09:25 schrieb Akihiko Odaki:

It’d be nice if you started by summarizing the bug.

> The datasheet does not say what happens when interrupt was asserted
> (ICR.INT_ASSERT=1) and auto mask is *not* active.

Personal nit: For better legibility, I’d separate paragraphs by an empty 
line, or – in this case – I wouldn’t wrap the line, just because a 
sentence ends.

> However, section of 13.3.27 the PCIe* GbE Controllers Open Source
> Software Developer’s Manual, which were written for older devices,
> namely 631xESB/632xESB, 82563EB/82564EB, 82571EB/82572EI &
> 82573E/82573V/82573L, does say:
>> If IMS = 0b, then the ICR register is always clear-on-read. If IMS is
>> not 0b, but some ICR bit is set where the corresponding IMS bit is not
>> set, then a read does not clear the ICR register. For example, if
>> IMS = 10101010b and ICR = 01010101b, then a read to the ICR register
>> does not clear it. If IMS = 10101010b and ICR = 0101011b, then a read
>> to the ICR register clears it entirely (ICR.INT_ASSERTED = 1b).
> 
> Linux does no longer activate auto mask since commit
> 0a8047ac68e50e4ccbadcfc6b6b070805b976885 and the real hardware clears
> ICR even in such a case so we also should do so.

… since commit 0a8047ac68e5 (e1000e: Fix msi-x interrupt automask) …

> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1707441
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Supersedes: <20201203133236.222207-1-andrew@daynix.com>
> ("[PATCH v2] e1000e: Added ICR clearing by corresponding IMS bit.")
> 
>   hw/net/e1000e_core.c | 38 ++++++++++++++++++++++++++++++++------
>   hw/net/trace-events  |  1 +
>   2 files changed, 33 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> index 9785ef279c..338bbbf4f4 100644
> --- a/hw/net/e1000e_core.c
> +++ b/hw/net/e1000e_core.c
> @@ -2607,12 +2607,38 @@ e1000e_mac_icr_read(E1000ECore *core, int index)
>           e1000e_lower_interrupts(core, ICR, 0xffffffff);
>       }
>   
> -    if ((core->mac[ICR] & E1000_ICR_ASSERTED) &&
> -        (core->mac[CTRL_EXT] & E1000_CTRL_EXT_IAME)) {
> -        trace_e1000e_irq_icr_clear_iame();
> -        e1000e_lower_interrupts(core, ICR, 0xffffffff);
> -        trace_e1000e_irq_icr_process_iame();
> -        e1000e_lower_interrupts(core, IMS, core->mac[IAM]);
> +    if (core->mac[ICR] & E1000_ICR_ASSERTED) {
> +        if (core->mac[CTRL_EXT] & E1000_CTRL_EXT_IAME) {
> +            trace_e1000e_irq_icr_clear_iame();
> +            e1000e_lower_interrupts(core, ICR, 0xffffffff);
> +            trace_e1000e_irq_icr_process_iame();
> +            e1000e_lower_interrupts(core, IMS, core->mac[IAM]);
> +        }
> +
> +        /*
> +         * The datasheet does not say what happens when interrupt was asserted

I believe the network subsystem has a different commenting style than 
the rest of the Linux source code.

> +         * (ICR.INT_ASSERT=1) and auto mask is *not* active.
> +         * However, section of 13.3.27 the PCIe* GbE Controllers Open Source
> +         * Software Developer’s Manual, which were written for older devices,
> +         * namely 631xESB/632xESB, 82563EB/82564EB, 82571EB/82572EI &
> +         * 82573E/82573V/82573L, does say:

I’d add a blank line below.

> +         * > If IMS = 0b, then the ICR register is always clear-on-read. If IMS
> +         * > is not 0b, but some ICR bit is set where the corresponding IMS bit
> +         * > is not set, then a read does not clear the ICR register. For
> +         * > example, if IMS = 10101010b and ICR = 01010101b, then a read to the
> +         * > ICR register does not clear it. If IMS = 10101010b and
> +         * > ICR = 0101011b, then a read to the ICR register clears it entirely
> +         * > (ICR.INT_ASSERTED = 1b).
> +         *
> +         * Linux does no longer activate auto mask since commit
> +         * 0a8047ac68e50e4ccbadcfc6b6b070805b976885 and the real hardware
> +         * clears ICR even in such a case so we also should do so.
> +         */
> +        if (core->mac[ICR] & core->mac[IMS]) {
> +            trace_e1000e_irq_icr_clear_icr_bit_ims(core->mac[ICR],
> +                                                   core->mac[IMS]);
> +            e1000e_lower_interrupts(core, ICR, 0xffffffff);
> +        }
>       }
>   
>       return ret;
> diff --git a/hw/net/trace-events b/hw/net/trace-events
> index e97e9dc17b..9103488e17 100644
> --- a/hw/net/trace-events
> +++ b/hw/net/trace-events
> @@ -217,6 +217,7 @@ e1000e_irq_read_ims(uint32_t ims) "Current IMS: 0x%x"
>   e1000e_irq_icr_clear_nonmsix_icr_read(void) "Clearing ICR on read due to non MSI-X int"
>   e1000e_irq_icr_clear_zero_ims(void) "Clearing ICR on read due to zero IMS"
>   e1000e_irq_icr_clear_iame(void) "Clearing ICR on read due to IAME"
> +e1000e_irq_icr_clear_icr_bit_ims(uint32_t icr, uint32_t ims) "Clearing ICR on read due corresponding IMS bit: 0x%x & 0x%x"
>   e1000e_irq_iam_clear_eiame(uint32_t iam, uint32_t cause) "Clearing IMS due to EIAME, IAM: 0x%X, cause: 0x%X"
>   e1000e_irq_icr_clear_eiac(uint32_t icr, uint32_t eiac) "Clearing ICR bits due to EIAC, ICR: 0x%X, EIAC: 0x%X"
>   e1000e_irq_ims_clear_set_imc(uint32_t val) "Clearing IMS bits due to IMC write 0x%x"


Kind regards,

Paul

