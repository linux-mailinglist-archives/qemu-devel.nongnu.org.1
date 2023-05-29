Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC40714222
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 04:46:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3Ssi-0003JL-Mb; Sun, 28 May 2023 22:45:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q3Ssg-0003J5-2i
 for qemu-devel@nongnu.org; Sun, 28 May 2023 22:45:10 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q3Ssc-0001rL-87
 for qemu-devel@nongnu.org; Sun, 28 May 2023 22:45:08 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1b00ecabdf2so26515875ad.2
 for <qemu-devel@nongnu.org>; Sun, 28 May 2023 19:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1685328303; x=1687920303;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Af8WxHvopZgunjtlKz3WqvWXUDAN5HOeeO8nRu6vx8Q=;
 b=fNKHu+q58RRy1UT0CNpoOx73VH1LeXTSyg80FcsLKXJAwbcVR2yM38ypXNo+41m7U5
 uQPAo7jIhRsE+jIqVPxvVvQXI8ino4jCiTui6DDT4M1vglunQQ1Z29NMYdvBoDFlcxQw
 iLZHfz+goDwv1o+DxWCP+H3INC20deVX9qA+StgW/byL64rteZ9UpAHe2EorlGvsfBjl
 ZV2H/ua++qU2cHgg0nmNCoWceBx8aDFbs42ymfl1b0cxZBpeRJ94tckh9d0RvzSazA/T
 fibQwUY+urIrXEV6NoBKhWuVG8OJ/RBYmFYB6hhNRCHKqi9z/eQ4TEU5G4lDZZ4Sekl9
 jUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685328303; x=1687920303;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Af8WxHvopZgunjtlKz3WqvWXUDAN5HOeeO8nRu6vx8Q=;
 b=SALo9htV04ehodDEgO+o3ooE3ZQ1egSUAuYlNYhuQSXh0rFYVPJruy099HTy6/7Cn6
 HxopGKEk4PRcCX/lxhl8Dn5Qrq4fuzyaUczBrwba/PdY4xd1L4XpXG6FoKhjgWiaF7o9
 7SxddFgrWB5TmZwIL4LB3GYpZi9qa2KAKjDCby3OurXNze35E0Z+nGUD8EVJoeKmSgCu
 0iSzZzzIDHP1drQSSARk1o9hEi5jgxXQ3os2+prNt5yPxKRcuEUgECXM+Rn0FrCn0ZH5
 3UdGOImTBXc14Ep8D62ngueG+qfk/UNet0TY1IXa9AGCPQu4mM1SldSFkur/d98VYIEY
 yLSA==
X-Gm-Message-State: AC+VfDyZjSeEWSD/mPHGEw+QvSUvshTFkELGQOsBo92KKoV0SG6mVTKe
 qB+4El6KdrHMchwlbY3eEOcxJA==
X-Google-Smtp-Source: ACHHUZ7vA1X/p2IOIQZ6kbBL7eflNrF3dABGjXQhB+06x+gN7tAQkIsE7YLF6h/xK6nY2rbP6k7pMw==
X-Received: by 2002:a17:903:2345:b0:1af:f4f5:6fae with SMTP id
 c5-20020a170903234500b001aff4f56faemr12544468plh.54.1685328303410; 
 Sun, 28 May 2023 19:45:03 -0700 (PDT)
Received: from [157.82.203.253] ([157.82.203.253])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a170902a3cc00b001a64851087bsm5053557plb.272.2023.05.28.19.45.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 May 2023 19:45:03 -0700 (PDT)
Message-ID: <e2bed67c-23ea-6364-bd5a-f7b330346302@daynix.com>
Date: Mon, 29 May 2023 11:45:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] igb: Add Function Level Reset to PF and VF
Content-Language: en-US
To: Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Jason Wang <jasowang@redhat.com>
References: <20230526173035.69055-1-clg@redhat.com>
 <DBBP189MB143330236AFF956285CD74F295459@DBBP189MB1433.EURP189.PROD.OUTLOOK.COM>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <DBBP189MB143330236AFF956285CD74F295459@DBBP189MB1433.EURP189.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::636;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On 2023/05/28 19:50, Sriram Yagnaraman wrote:
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Sent: Friday, 26 May 2023 19:31
>> To: qemu-devel@nongnu.org
>> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>; Sriram Yagnaraman
>> <sriram.yagnaraman@est.tech>; Jason Wang <jasowang@redhat.com>; Cédric
>> Le Goater <clg@redhat.com>
>> Subject: [PATCH] igb: Add Function Level Reset to PF and VF
>>
>> The Intel 82576EB GbE Controller say that the Physical and Virtual Functions
>> support Function Level Reset. Add the capability to each device model.
>>
>> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Fixes: 3a977deebe6b ("Intrdocue igb device emulation")
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   hw/net/igb.c   | 3 +++
>>   hw/net/igbvf.c | 3 +++
>>   2 files changed, 6 insertions(+)
>>
>> diff --git a/hw/net/igb.c b/hw/net/igb.c index 1c989d767725..08e389338dca
>> 100644
>> --- a/hw/net/igb.c
>> +++ b/hw/net/igb.c
>> @@ -101,6 +101,7 @@ static void igb_write_config(PCIDevice *dev, uint32_t
>> addr,
>>
>>       trace_igb_write_config(addr, val, len);
>>       pci_default_write_config(dev, addr, val, len);
>> +    pcie_cap_flr_write_config(dev, addr, val, len);
>>
>>       if (range_covers_byte(addr, len, PCI_COMMAND) &&
>>           (dev->config[PCI_COMMAND] & PCI_COMMAND_MASTER)) { @@ -427,6
>> +428,8 @@ static void igb_pci_realize(PCIDevice *pci_dev, Error **errp)
>>       }
>>
>>       /* PCIe extended capabilities (in order) */
>> +    pcie_cap_flr_init(pci_dev);
>> +
>>       if (pcie_aer_init(pci_dev, 1, 0x100, 0x40, errp) < 0) {
>>           hw_error("Failed to initialize AER capability");
>>       }
>> diff --git a/hw/net/igbvf.c b/hw/net/igbvf.c index
>> 284ea611848b..0a58dad06802 100644
>> --- a/hw/net/igbvf.c
>> +++ b/hw/net/igbvf.c
>> @@ -204,6 +204,7 @@ static void igbvf_write_config(PCIDevice *dev,
>> uint32_t addr, uint32_t val,  {
>>       trace_igbvf_write_config(addr, val, len);
>>       pci_default_write_config(dev, addr, val, len);
>> +    pcie_cap_flr_write_config(dev, addr, val, len);
>>   }
>>
>>   static uint64_t igbvf_mmio_read(void *opaque, hwaddr addr, unsigned size)
>> @@ -266,6 +267,8 @@ static void igbvf_pci_realize(PCIDevice *dev, Error
>> **errp)
>>           hw_error("Failed to initialize PCIe capability");
>>       }
>>
>> +    pcie_cap_flr_init(dev);
> 
> Sorry for my naive question, and perhaps not related to your patch, IGBVF device class doesn't seem to have any reset functions registered via igbvf_class_init(). So, I am guessing an FLR will not trigger igb_vf_reset(), which is probably what we want.

You're right. Advertising FLR capability without implementing it can 
confuse the guest though such probability is quite a low in practice. 
The reset should be implemented first.

> 
>> +
>>       if (pcie_aer_init(dev, 1, 0x100, 0x40, errp) < 0) {
>>           hw_error("Failed to initialize AER capability");
>>       }
>> --
>> 2.40.1
> 

