Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA52B402D8
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Sep 2025 15:25:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utQzE-0000ca-Uw; Tue, 02 Sep 2025 09:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Sj0j=3N=kaod.org=clg@ozlabs.org>)
 id 1utQzB-0000bN-Kx; Tue, 02 Sep 2025 09:23:45 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Sj0j=3N=kaod.org=clg@ozlabs.org>)
 id 1utQz3-0006Mg-F0; Tue, 02 Sep 2025 09:23:45 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4cGRJf0JQVz4w9k;
 Tue,  2 Sep 2025 23:23:30 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4cGRJZ249mz4w9g;
 Tue,  2 Sep 2025 23:23:25 +1000 (AEST)
Message-ID: <f17784ea-80dc-4ca5-ae46-b73752e40905@kaod.org>
Date: Tue, 2 Sep 2025 15:23:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v1 01/21] hw/arm/aspeed_ast27x0-fc: Support VBootRom
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20250717034054.1903991-1-jamin_lin@aspeedtech.com>
 <20250717034054.1903991-2-jamin_lin@aspeedtech.com>
 <9e7ec38d-7bb9-4f1e-b75b-96c3eec97024@kaod.org>
 <SI2PR06MB5041202A90343458D2BE7724FC06A@SI2PR06MB5041.apcprd06.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <SI2PR06MB5041202A90343458D2BE7724FC06A@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=Sj0j=3N=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 9/2/25 10:28, Jamin Lin wrote:
> Hi Cédric
> 
>> Subject: Re: [SPAM] [PATCH v1 01/21] hw/arm/aspeed_ast27x0-fc: Support
>> VBootRom
>>
>> On 7/17/25 05:40, Jamin Lin wrote:
>>> Introduces support for loading a vbootrom image into the dedicated
>>> vbootrom memory region in the AST2700 Full Core machine.
>>>
>>> Additionally, it implements a mechanism to extract the content of
>>> fmc_cs0 flash data(backend file) and copy it into the memory-mapped
>>> region corresponding to ASPEED_DEV_SPI_BOOT.
>>>
>>> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
>>> ---
>>>    hw/arm/aspeed_ast27x0-fc.c | 75
>> ++++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 75 insertions(+)
>>>
>>> diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
>>> index 7087be4288..e2eee6183f 100644
>>> --- a/hw/arm/aspeed_ast27x0-fc.c
>>> +++ b/hw/arm/aspeed_ast27x0-fc.c
>>> @@ -11,6 +11,7 @@
>>>
>>>    #include "qemu/osdep.h"
>>>    #include "qemu/units.h"
>>> +#include "qemu/datadir.h"
>>>    #include "qapi/error.h"
>>>    #include "system/block-backend.h"
>>>    #include "system/system.h"
>>> @@ -35,6 +36,7 @@ struct Ast2700FCState {
>>>
>>>        MemoryRegion ca35_memory;
>>>        MemoryRegion ca35_dram;
>>> +    MemoryRegion ca35_boot_rom;
>>>        MemoryRegion ssp_memory;
>>>        MemoryRegion tsp_memory;
>>>
>>> @@ -55,12 +57,65 @@ struct Ast2700FCState {
>>>    #define AST2700FC_HW_STRAP2 0x00000003
>>>    #define AST2700FC_FMC_MODEL "w25q01jvq"
>>>    #define AST2700FC_SPI_MODEL "w25q512jv"
>>> +#define VBOOTROM_FILE_NAME  "ast27x0_bootrom.bin"
>>> +
>>> +static void ast2700fc_ca35_load_vbootrom(AspeedSoCState *soc,
>>> +                                         const char *bios_name,
>> Error
>>> +**errp) {
>>> +    g_autofree char *filename = NULL;
>>> +    int ret;
>>> +
>>> +    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
>>> +    if (!filename) {
>>> +        error_setg(errp, "Could not find vbootrom image '%s'",
>> bios_name);
>>> +        return;
>>> +    }
>>> +
>>> +    ret = load_image_mr(filename, &soc->vbootrom);
>>> +    if (ret < 0) {
>>> +        error_setg(errp, "Failed to load vbootrom image '%s'",
>> bios_name);
>>> +        return;
>>> +    }
>>> +}
>>> +
>>> +static void ast2700fc_ca35_write_boot_rom(DriveInfo *dinfo, hwaddr addr,
>>> +                                         size_t rom_size, Error
>>> +**errp) {
>>> +    BlockBackend *blk = blk_by_legacy_dinfo(dinfo);
>>> +    g_autofree void *storage = NULL;
>>> +    int64_t size;
>>> +
>>> +    /*
>>> +     * The block backend size should have already been 'validated' by
>>> +     * the creation of the m25p80 object.
>>> +     */
>>> +    size = blk_getlength(blk);
>>> +    if (size <= 0) {
>>> +        error_setg(errp, "failed to get flash size");
>>> +        return;
>>> +    }
>>> +
>>> +    if (rom_size > size) {
>>> +        rom_size = size;
>>> +    }
>>> +
>>> +    storage = g_malloc0(rom_size);
>>> +    if (blk_pread(blk, 0, rom_size, storage, 0) < 0) {
>>> +        error_setg(errp, "failed to read the initial flash content");
>>> +        return;
>>> +    }
>>> +
>>> +    rom_add_blob_fixed("aspeed.boot_rom", storage, rom_size, addr); }
>>
>> The above is duplicated code. Could we try to have common routines instead ?
> 
> Thanks for your review and suggestion.
> 
> Per our earlier discussion, we plan to refactor hw/arm/aspeed.c. As a first
> step, I can move the vbootrom helpers into a common source file so they can be
> reused by other boards.
> 
> Do you have a preference for the filename?
> hw/arm/aspeed_utils.c (with a small header in include/hw/arm/aspeed_utils.h),


There is a aspeed_soc_common.c file for such helpers.


Thanks,

C.

