Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A924738637
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 16:08:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qByU4-0005nC-Rh; Wed, 21 Jun 2023 10:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qByU3-0005n3-2Z
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 10:06:55 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qByU1-0008Rd-Fq
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 10:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uy3wN0OVpinYOUGBzKFIh5N9PdiMqPY7pFxUI1QZLsg=; b=ZGxG7Jn/CsFLAACw5tamYKaVqV
 0ZSfYIkVCsTgrYoKRZ19XUn9gBDcTy4MPz4CMdZyfniavBWPzUrSFRr3v/SPn7AVuWkOWiLnxdx2j
 ycnc/H8+hf9ePnwFim/83yPfD40tAZjt1G8MXoXtDWQTxXnrPfQuzg2+Xgrlr9N2iQMpSvACOjgLG
 FAv9/w47TTzg8GM5OJ8yxNwLxI9dSiZU0BAzzwHcCztc586m5znZZD1DxCrWO2xH66o1prKzNiZFn
 OetAS25I0FRiEJqEjMxRUKCedfo71FSg2yjTVU6TUdcUFYqV7IJyumPOQ3JpRxTYql+TdITAxR+M7
 odc1Oou5TKJY/9jlJlfuQgVJ6bVhcInIdQ/KFvdC374mhD4FlC7Xoh6jlmtV2se8fQNdcHGV5pOZX
 6Ldl47xBDIYkShV/MuVBfgGvjNUJCMFsZuSxgkfwboHQdjRaEuIWYFRmrR7p+I7e6Y6KVi/VCo1HX
 BTqQQPX3OlF83uLNFbayFCpRqmnPV6Ua3kcaaROXfQmEXRPjZaNvBxQ+4ntdcvyCaRVw/On/KwCKJ
 ROylM9L/sL1q0dq5WH9Yqw/wIiGV227/9p5VdeWi8PH7nA8WMerIs9IEVb6o3Oz8lBcN4VDY5vPSw
 YOVsG+F1BbZ2yOwCCezx8G0U3SFhorwm3rn4hizsQ=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=[10.8.0.6])
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qByTn-0003EX-GB; Wed, 21 Jun 2023 15:06:43 +0100
Message-ID: <0da13e10-27d4-ff12-656d-291bff2e1b70@ilande.co.uk>
Date: Wed, 21 Jun 2023 15:06:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 laurent@vivier.eu, qemu-devel@nongnu.org
References: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
 <0e8c4da9-2b33-dc24-77b0-cea5bdd905a3@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <0e8c4da9-2b33-dc24-77b0-cea5bdd905a3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v4 00/24] q800: add support for booting MacOS Classic -
 part 1
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 21/06/2023 10:42, Philippe Mathieu-Daudé wrote:

> On 21/6/23 10:53, Mark Cave-Ayland wrote:
>> [MCA: the original series has now been split into 2 separate parts based upon
>> Phil's comments re: QOM parenting for objects in Q800MachineState. Part 1
>> consists of the Q800MachineState patches along with QOM parenting fixes and
>> the 2 mac_via RTC patches.]
>>
>> This series contains the remaining patches needed to allow QEMU's q800
>> machine to boot MacOS Classic when used in conjunction with a real
>> Quadra 800 ROM image. In fact with this series applied it is possible
>> to boot all of the following OSs:
>>
>>    - MacOS 7.1 - 8.1, with or without virtual memory enabled
>>    - A/UX 3.0.1
>>    - NetBSD 9.3
>>    - Linux (via EMILE)
>>
>> If you are ready to experience some 90s nostalgia then all you need is
>> to grab yourself a copy of the Quadra 800 ROM (checksum 0xf1acad13) and a
>> suitable install ISO as follows:
>>
>>    # Prepare a PRAM image
>>    $ qemu-img create -f raw pram.img 256b
>>
>>    # Launch QEMU with blank disk and install CDROM
>>    $ ./qemu-system-m68k \
>>        -M q800 \
>>        -m 128 \
>>        -bios Quadra800.rom \
>>        -drive file=pram.img,format=raw,if=mtd \
>>        -drive file=disk.img,media=disk,format=raw,if=none,id=hd \
>>        -device scsi-hd,scsi-id=0,drive=hd \
>>        -drive file=cdrom.iso,media=cdrom,if=none,id=cd \
>>        -device scsi-cd,scsi-id=3,drive=cd
>>
>> And off you go! For more in-depth information about the installation process
>> I highly recommend the installation guide over at emaculation.com [1].
>> Compatibility is generally very good, and I'm pleased to report it is possible
>> to run one of the most popular productivity apps from the 90s [2].
> 
> Could you add an Avocado test for this machine? See how the
> MipsFuloong2e test (tests/avocado/machine_mips_fuloong2e.py)
> handles the firmware (RESCUE_YL_PATH).

In theory it is possible to do this, but how do we handle booting proprietary OS ISOs 
that are still within copyright? Also this is only part 1 of the required changes, 
you'll need part 2 applied in order to achieve a successful boot :)


ATB,

Mark.


