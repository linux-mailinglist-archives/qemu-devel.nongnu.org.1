Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 529A992CC8D
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jul 2024 10:11:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRSP6-0006SA-8K; Wed, 10 Jul 2024 04:10:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=VgH8=OK=kaod.org=clg@ozlabs.org>)
 id 1sRSP3-0006PI-KX; Wed, 10 Jul 2024 04:10:17 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=VgH8=OK=kaod.org=clg@ozlabs.org>)
 id 1sRSP1-0002EQ-NI; Wed, 10 Jul 2024 04:10:17 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WJrBR1lVGz4wym;
 Wed, 10 Jul 2024 18:10:07 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WJr9z3Q9vz4wcl;
 Wed, 10 Jul 2024 18:09:42 +1000 (AEST)
Message-ID: <eec0090f-1a0f-44d1-86b8-956411037f34@kaod.org>
Date: Wed, 10 Jul 2024 10:09:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v47 00/19] hw/sd/sdcard: Add eMMC support
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, Joel Stanley <joel@jms.id.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>
References: <20240709152556.52896-1-philmd@linaro.org>
 <e9c273ff-32bd-40fc-8f50-cb47784cf741@kaod.org>
 <fc8b71b9-e946-4161-8750-fffe37d3c925@linaro.org>
 <b48bec6b-707a-4434-aba6-6b7416400480@kaod.org>
Content-Language: en-US, fr
In-Reply-To: <b48bec6b-707a-4434-aba6-6b7416400480@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=VgH8=OK=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
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

On 7/10/24 6:58 AM, Cédric Le Goater wrote:
> On 7/9/24 11:39 PM, Philippe Mathieu-Daudé wrote:
>> On 9/7/24 17:58, Cédric Le Goater wrote:
>>> On 7/9/24 5:25 PM, Philippe Mathieu-Daudé wrote:
>>>> Since v42:
>>>> - Stick to spec v4.3 (re-simplified EXT_CSD register & migrate)
>>>> - Fill CID register
>>>> - Few changes to CSD register
>>>> - Implement 'boot-mode' reset timing
>>>> - Add 'boot-size' property
>>>>
>>>> Change required for aspeed branch:
>>>> -- >8 --
>>>> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
>>>> index 8c0e36badd..563816b710 100644
>>>> --- a/hw/arm/aspeed.c
>>>> +++ b/hw/arm/aspeed.c
>>>> @@ -344,3 +344,3 @@ static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo *dinfo, bool emmc,
>>>>           if (emmc) {
>>>> -            qdev_prop_set_uint8(card, "boot-config", boot_emmc ? 0x48 : 0x0);
>>>> +            qdev_prop_set_uint64(card, "boot-size", 1 * MiB);
>>>>           }
>>>> (I'm still reluctant to merge patches 16-18)...
>>>
>>> Then, please drop all changes related to the boot partitions. I will keep
>>> the original patches in my tree and address the feature when I have time.
>>> TYPE_EMMC is already great to have.
>>
>> As you mentioned on today's community call, eMMC is a chipset soldered
>> on a board, so our boards exactly knows what size to expect on the card,
>> and whether boot partitions are present or not. 
> 
> My remark was on the use of 3 blockdevs to represent the eMMC contents.
> 1 should be enough.
> 
> Having a "boot-size" property to set the BOOT_SIZE_MULT register is fine.
> The Aspeed model does some assumption today when installing the first
> boot area as a boot ROM :
> 
>      aspeed_install_boot_rom(bmc, blk_by_legacy_dinfo(emmc0), 64 * KiB);
> 
> The "boot-size" property will clarify the settings. Please keep it.

64 * KiB is not related to the eMMC partition size. It is a SRAM
limit in which the SoC loads the boot data.

Thanks,

C.
  

