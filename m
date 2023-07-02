Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAFB744CC6
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 10:39:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFsba-0002o1-Qa; Sun, 02 Jul 2023 04:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFsbZ-0002nN-62
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 04:38:49 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFsbX-0003q9-Hf
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 04:38:48 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1b7fdc66e30so16903735ad.2
 for <qemu-devel@nongnu.org>; Sun, 02 Jul 2023 01:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1688287126; x=1690879126;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O6i6DFBFJf3HMDHvn3ASdrBJy5LDp5vSWRY+CBduiJY=;
 b=sUcp1o0oNwXGqXDvNqhwPyAJg0aVsGPu4jJUhS2C/b1n2wvTireMQFjy4PEAT6OAKc
 dKYlTNWHDoHPWszPAWKdzEmIUXKws7TBmr/X5K94oWlW2D4LMNPu2KGLPKNFUPQqWiLQ
 gIXs/woQ6jH9dSOL96evv9jLtjerImw3y53x/UxhnMY7e0XIrSMTRsN0CNlz+F6LCSVl
 pjTYPmQ8mgemjHfhDYjwTP3DqgExoV8qC2iFgAgi15Fv7vPfCQyUUMj+bhlEuV09fOE2
 ySGfUrn4EPpdM/TMj5pkK3Scx7qdk+3pd5c0PlsuS4NbUH8AuN7h7TA5h+QcVIgN/r/W
 /CAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688287126; x=1690879126;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O6i6DFBFJf3HMDHvn3ASdrBJy5LDp5vSWRY+CBduiJY=;
 b=kSCFTD+DDUub+NE94+m6nxDR2V5MoxRnaFsOxEOV4ZxWJhbqH5OaWU3RnmvNdbiKzq
 lVoQYfQCyCvOYQIjGvuuxTpvkSByhHFIn0S9OdSzl07do3kkpB6/6Ey3WEwOOv5KlxOb
 PpyOP4TaMPdbn+4kKJ5wmgf7jMj8hiRwJ0/OsvYj/NKOtCG/jWLGNkfcEdAUaeagjyCO
 ivSDgm1zMzSJQ/QrjkP7CePhfKdP4Om7al4cuk9GxXjvzSlIlWvkp9VZBnu6MabidV1N
 PEc9S3tWIOw5vzmACyLyA79vhvMeaDqlph3jW8/ENEZVh98fxRV5QpLPV+uGmpcmEc5R
 mW3w==
X-Gm-Message-State: ABy/qLahGsAgpnU7jepPtDoCxHv9DeHPItZneUsgvtwHD47wL7IG0MW8
 gMD3LwLcmmo+ubzQZ/9iWO/CzQ==
X-Google-Smtp-Source: APBJJlH9GYgqCWn7/w+deCowCW3NjQhSn1hj04d7gW+bOogy0LD4CK2VH/8itayMPdxpjgBwuOWOXw==
X-Received: by 2002:a17:902:ec88:b0:1b8:1be2:3938 with SMTP id
 x8-20020a170902ec8800b001b81be23938mr6643748plg.5.1688287126088; 
 Sun, 02 Jul 2023 01:38:46 -0700 (PDT)
Received: from [157.82.204.253] ([157.82.204.253])
 by smtp.gmail.com with ESMTPSA id
 o8-20020a170902bcc800b001b04772d33esm1123083pls.165.2023.07.02.01.38.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Jul 2023 01:38:45 -0700 (PDT)
Message-ID: <ff06355e-bfd6-7574-e42c-ecfd6939e7aa@daynix.com>
Date: Sun, 2 Jul 2023 17:38:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/4] igb: Fix ARI next function numbers
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>
References: <20230701070133.24877-1-akihiko.odaki@daynix.com>
 <20230701070133.24877-4-akihiko.odaki@daynix.com>
 <20230702010041-mutt-send-email-mst@kernel.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230702010041-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::634;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 2023/07/02 14:05, Michael S. Tsirkin wrote:
> On Sat, Jul 01, 2023 at 04:01:21PM +0900, Akihiko Odaki wrote:
>> The next function numbers are expected to form a linked list ending with
>> 0.
>>
>> Fixes: 3a977deebe ("Intrdocue igb device emulation")
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   hw/net/igb_core.h | 3 +++
>>   hw/net/igb.c      | 4 +---
>>   hw/net/igbvf.c    | 5 ++++-
>>   3 files changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/net/igb_core.h b/hw/net/igb_core.h
>> index 9cbbfd516b..e1dab76995 100644
>> --- a/hw/net/igb_core.h
>> +++ b/hw/net/igb_core.h
>> @@ -49,6 +49,9 @@
>>   #define IGB_NUM_QUEUES          (16)
>>   #define IGB_NUM_VM_POOLS        (8)
>>   
>> +#define IGB_VF_OFFSET           (0x80)
>> +#define IGB_VF_STRIDE           (2)
>> +
>>   typedef struct IGBCore IGBCore;
>>   
>>   enum { PHY_R = BIT(0),
>> diff --git a/hw/net/igb.c b/hw/net/igb.c
>> index 1c989d7677..543ca0114a 100644
>> --- a/hw/net/igb.c
>> +++ b/hw/net/igb.c
>> @@ -81,8 +81,6 @@ struct IGBState {
>>   };
>>   
>>   #define IGB_CAP_SRIOV_OFFSET    (0x160)
>> -#define IGB_VF_OFFSET           (0x80)
>> -#define IGB_VF_STRIDE           (2)
>>   
>>   #define E1000E_MMIO_IDX     0
>>   #define E1000E_FLASH_IDX    1
>> @@ -431,7 +429,7 @@ static void igb_pci_realize(PCIDevice *pci_dev, Error **errp)
>>           hw_error("Failed to initialize AER capability");
>>       }
>>   
>> -    pcie_ari_init(pci_dev, 0x150, 1);
>> +    pcie_ari_init(pci_dev, 0x150, IGB_VF_OFFSET);
>>   
>>       pcie_sriov_pf_init(pci_dev, IGB_CAP_SRIOV_OFFSET, TYPE_IGBVF,
>>           IGB_82576_VF_DEV_ID, IGB_MAX_VF_FUNCTIONS, IGB_MAX_VF_FUNCTIONS,
> 
> 
> I think this change would break migrations from 8.0. No?

Well, I don't have a reason to concern more for this change than other 
bug fixes with behavioral changes observable from the guest.

> 
> 
> More importantly your commit log says linked list should end
> with 0, but you make it point at a VF instead.
> 
> 
>> diff --git a/hw/net/igbvf.c b/hw/net/igbvf.c
>> index 284ea61184..bf2f237ab5 100644
>> --- a/hw/net/igbvf.c
>> +++ b/hw/net/igbvf.c
>> @@ -240,6 +240,9 @@ static const MemoryRegionOps mmio_ops = {
>>   static void igbvf_pci_realize(PCIDevice *dev, Error **errp)
>>   {
>>       IgbVfState *s = IGBVF(dev);
>> +    uint16_t nextvfn = pcie_sriov_vf_number(dev) + 1;
>> +    uint16_t nextfn = nextvfn < IGB_MAX_VF_FUNCTIONS ?
>> +                      IGB_VF_OFFSET + nextvfn * IGB_VF_STRIDE : 0;
>>       int ret;
>>       int i;
>>   
>> @@ -270,7 +273,7 @@ static void igbvf_pci_realize(PCIDevice *dev, Error **errp)
>>           hw_error("Failed to initialize AER capability");
>>       }
>>   
>> -    pcie_ari_init(dev, 0x150, 1);
>> +    pcie_ari_init(dev, 0x150, nextfn);
> 
> 
> 
> For this one I don't see why it matters at all:
> 
> The presence of Shadow Functions does not affect this field.
> For VFs, this field is undefined since VFs are located using First VF Offset (see § Section 9.3.3.9 ) and VF
> Stride (see § Section 9.3.3.10 ).

I missed the statements saying the field is undefined for VFs. I posted 
an alternative series ("[PATCH 0/3] pci: Fix ARI next function numbers") 
so please review it.

> 
> 
> 
> 
>>   }
>>   
>>   static void igbvf_pci_uninit(PCIDevice *dev)
>> -- 
>> 2.41.0
> 

