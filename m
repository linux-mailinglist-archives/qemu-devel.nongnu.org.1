Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4227D6677
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 11:15:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvZyv-0005WQ-D8; Wed, 25 Oct 2023 05:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=4l40=GH=kaod.org=clg@ozlabs.org>)
 id 1qvZyn-0005SK-4D
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:15:09 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=4l40=GH=kaod.org=clg@ozlabs.org>)
 id 1qvZyf-0007QO-GS
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:15:08 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SFjtl0zYlz4x5G;
 Wed, 25 Oct 2023 20:14:55 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SFjtg5QWYz4x3D;
 Wed, 25 Oct 2023 20:14:51 +1100 (AEDT)
Message-ID: <f5e6727c-887c-4533-a5df-db1a57318870@kaod.org>
Date: Wed, 25 Oct 2023 11:14:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] eeprom_at24c: Model 8-bit data addressing for 16-bit
 devices
Content-Language: en-US
To: Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-devel@nongnu.org
Cc: peter@pjd.dev, joel@jms.id.au, cminyard@mvista.com,
 Klaus Jensen <its@irrelevant.dk>
References: <20230921034816.320655-1-andrew@codeconstruct.com.au>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230921034816.320655-1-andrew@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=4l40=GH=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Cc: Klaus

On 9/21/23 05:48, Andrew Jeffery wrote:
> It appears some (many?) EEPROMs that implement 16-bit data addressing
> will accept an 8-bit address and clock out non-uniform data for the
> read. This behaviour is exploited by an EEPROM detection routine in part
> of OpenBMC userspace with a reasonably broad user base:
> 
> https://github.com/openbmc/entity-manager/blob/0422a24bb6033605ce75479f675fedc76abb1167/src/fru_device.cpp#L197-L229
> 
> The diversity of the set of EEPROMs that it operates against is unclear,
> but this code has been around for a while now.
> 
> Separately, The NVM Express Management Interface Specification dictates
> the provided behaviour in section 8.2 Vital Product Data:
> 
>> If only one byte of the Command Offset is provided by the Management
>> Controller, then the least significant byte of the internal offset
>> shall be set to that value and the most-significant byte of the
>> internal offset shall be cleared to 0h
> 
> https://nvmexpress.org/wp-content/uploads/NVM-Express-Management-Interface-Specification-1.2c-2022.10.06-Ratified.pdf
> 
> This change makes it possible to expose NVMe VPD in a manner that can be
> dynamically detected by OpenBMC.
> 
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>

It seems that the "at24c-eeprom" model doesn't have a maintainer. Until
this is sorted out, may be this change could go through the NVMe queue
since it is related.

Thanks,

C.

> ---
>   hw/nvram/eeprom_at24c.c | 18 +++++++++++++-----
>   1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
> index 613c4929e327..64a61cc0e468 100644
> --- a/hw/nvram/eeprom_at24c.c
> +++ b/hw/nvram/eeprom_at24c.c
> @@ -98,12 +98,20 @@ uint8_t at24c_eeprom_recv(I2CSlave *s)
>       EEPROMState *ee = AT24C_EE(s);
>       uint8_t ret;
>   
> -    /*
> -     * If got the byte address but not completely with address size
> -     * will return the invalid value
> -     */
>       if (ee->haveaddr > 0 && ee->haveaddr < ee->asize) {
> -        return 0xff;
> +        /*
> +         * Provide behaviour that aligns with NVMe MI 1.2c, section 8.2.
> +         *
> +         * https://nvmexpress.org/wp-content/uploads/NVM-Express-Management-Interface-Specification-1.2c-2022.10.06-Ratified.pdf
> +         *
> +         * Otherwise, the clocked-out data is meaningless anyway, and so reading
> +         * off memory is as good a behaviour as anything. This also happens to
> +         * help the address-width detection heuristic in OpenBMC's userspace.
> +         *
> +         * https://github.com/openbmc/entity-manager/blob/0422a24bb6033605ce75479f675fedc76abb1167/src/fru_device.cpp#L197-L229
> +         */
> +        ee->haveaddr = ee->asize;
> +        ee->cur %= ee->rsize;
>       }
>   
>       ret = ee->mem[ee->cur];


