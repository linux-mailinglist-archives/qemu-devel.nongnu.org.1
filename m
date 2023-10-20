Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC8E7D0C28
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 11:41:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtm0I-0007VK-NZ; Fri, 20 Oct 2023 05:41:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qtm0C-0007Pz-UH
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 05:41:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qtm0B-000789-1R
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 05:41:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697794865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KO20cYPImi98gRA4QIIH8lCNaP6ocvnsVSI7wp3e4cg=;
 b=frzmYV+KYy/m/zfHGbXsaSrwxeHA6uMYN1PfapfQ2obIQ601+s9FPUT3ZJzitd+bHDs1da
 LJ2sWqAbqQfFLatmRso7dUIxRLYOZ3TztsYwnXeIrPlMoBmGpNeAVaHo0VxQC1SCIXTVwz
 7G3PoYZw7rn8pZqw1n0fgibIsjzmvi8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-LVUqQEX-OmCsXI_1pVkvLg-1; Fri, 20 Oct 2023 05:41:04 -0400
X-MC-Unique: LVUqQEX-OmCsXI_1pVkvLg-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-66d75988385so6114496d6.2
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 02:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697794864; x=1698399664;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KO20cYPImi98gRA4QIIH8lCNaP6ocvnsVSI7wp3e4cg=;
 b=G5RcVLP8UuqDM5Fxcd5/HE2V3e2icbJhuaz7KaalEbeMPMnGP4cQFuZ3zEyrb4+uTe
 9h5ARvLDyDNtTLIU/WqnBgFJxv+iBYc7VpdwXzaVblkZutA3pSAwOzxsp3C5AmQwwbOl
 vuIdmn++mAD6BS1xxsw3AYRVTbY1qvR/S1Vy6G+IPZxp0GdOhxQYPxIVE7BLLk2mllqd
 NPln9mgR54NKRoOdBm5swl1rOyEsFD3W4k3QESntIpNFRl2COVsUzCPTsTbB8hL9jSCJ
 uKbyWDREforKQzXZfIAKFkQHl0xCItmt/X6+lk21YM32Sficp9c/qXfBzqhQaV1bO3h2
 1arw==
X-Gm-Message-State: AOJu0YyJrc7Nkwe0qtQymCsADZGfryLUKzN/DVUCfZXQMTVXXpnIkVMW
 9yMihsJqScx8vx1vsaTNJM2vWRFjyaghL1N05s1TZW4rHnsWtlrsxsMtwXsYhY88+HZvBiFmA4W
 AfHinCCPMoQjf4v4=
X-Received: by 2002:a0c:aa5c:0:b0:66d:55da:191d with SMTP id
 e28-20020a0caa5c000000b0066d55da191dmr1217961qvb.37.1697794863866; 
 Fri, 20 Oct 2023 02:41:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUYq/qbDtTWgid5vNiO1uCrV1Oj22wPcQMepfvvZB5MRP5GBF6TJP2ygnNJ67zLP9Z+RMvfQ==
X-Received: by 2002:a0c:aa5c:0:b0:66d:55da:191d with SMTP id
 e28-20020a0caa5c000000b0066d55da191dmr1217953qvb.37.1697794863543; 
 Fri, 20 Oct 2023 02:41:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ec19-20020ad44e73000000b0065b151d5d12sm535852qvb.126.2023.10.20.02.41.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Oct 2023 02:41:03 -0700 (PDT)
Message-ID: <b744bd42-0b46-44ce-8d60-28d4d31427e0@redhat.com>
Date: Fri, 20 Oct 2023 11:41:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] igb: Add Function Level Reset to PF and VF
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>
References: <20230829090529.184438-1-clg@kaod.org>
 <20230829090529.184438-3-clg@kaod.org>
 <CACGkMEu6nznVGTyk8gjrZ3jE=bEAd2bDDi9PPwjDKNFkXnVhSQ@mail.gmail.com>
 <d9df1c95-f681-4962-be74-671cef90e908@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <d9df1c95-f681-4962-be74-671cef90e908@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/20/23 09:40, Cédric Le Goater wrote:
> On 10/20/23 06:24, Jason Wang wrote:
>> On Tue, Aug 29, 2023 at 5:06 PM Cédric Le Goater <clg@kaod.org> wrote:
>>>
>>> From: Cédric Le Goater <clg@redhat.com>
>>>
>>> The Intel 82576EB GbE Controller say that the Physical and Virtual
>>> Functions support Function Level Reset. Add the capability to each
>>> device model.
>>>
>>
>> Do we need to do migration compatibility for this?
> 
> Yes. it does. the config space is now different.

Jason,

To avoid an extra compat property, would it be ok to let the VF peek into
the PF capabilities to set FLR or not ? Something like below.

Thanks,

C.


@@ -238,6 +238,12 @@ static const MemoryRegionOps mmio_ops =
      },
  };
  
+static bool igbvf_check_pf_flr(PCIDevice *dev)
+{
+    return !!(pci_get_long(dev->config + dev->exp.exp_cap + PCI_EXP_DEVCAP)
+              & PCI_EXP_DEVCAP_FLR);
+}
+
  static void igbvf_pci_realize(PCIDevice *dev, Error **errp)
  {
      IgbVfState *s = IGBVF(dev);
@@ -267,7 +273,9 @@ static void igbvf_pci_realize(PCIDevice
          hw_error("Failed to initialize PCIe capability");
      }
  
-    pcie_cap_flr_init(dev);
+    if (igbvf_check_pf_flr(pcie_sriov_get_pf(dev))) {
+        pcie_cap_flr_init(dev);
+    }
  
      if (pcie_aer_init(dev, 1, 0x100, 0x40, errp) < 0) {
          hw_error("Failed to initialize AER capability");


> 
> Thanks,
> 
> C.
> 
> 
>>
>> Thanks
>>
>>> Cc:  Sriram Yagnaraman <sriram.yagnaraman@est.tech>
>>> Fixes: 3a977deebe6b ("Intrdocue igb device emulation")
>>> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>> ---
>>>   hw/net/igb.c   | 3 +++
>>>   hw/net/igbvf.c | 3 +++
>>>   2 files changed, 6 insertions(+)
>>>
>>> diff --git a/hw/net/igb.c b/hw/net/igb.c
>>> index e70a66ee038e..b8c170ad9b1a 100644
>>> --- a/hw/net/igb.c
>>> +++ b/hw/net/igb.c
>>> @@ -101,6 +101,7 @@ static void igb_write_config(PCIDevice *dev, uint32_t addr,
>>>
>>>       trace_igb_write_config(addr, val, len);
>>>       pci_default_write_config(dev, addr, val, len);
>>> +    pcie_cap_flr_write_config(dev, addr, val, len);
>>>
>>>       if (range_covers_byte(addr, len, PCI_COMMAND) &&
>>>           (dev->config[PCI_COMMAND] & PCI_COMMAND_MASTER)) {
>>> @@ -433,6 +434,8 @@ static void igb_pci_realize(PCIDevice *pci_dev, Error **errp)
>>>       }
>>>
>>>       /* PCIe extended capabilities (in order) */
>>> +    pcie_cap_flr_init(pci_dev);
>>> +
>>>       if (pcie_aer_init(pci_dev, 1, 0x100, 0x40, errp) < 0) {
>>>           hw_error("Failed to initialize AER capability");
>>>       }
>>> diff --git a/hw/net/igbvf.c b/hw/net/igbvf.c
>>> index 07343fa14a89..55e321e4ec20 100644
>>> --- a/hw/net/igbvf.c
>>> +++ b/hw/net/igbvf.c
>>> @@ -204,6 +204,7 @@ static void igbvf_write_config(PCIDevice *dev, uint32_t addr, uint32_t val,
>>>   {
>>>       trace_igbvf_write_config(addr, val, len);
>>>       pci_default_write_config(dev, addr, val, len);
>>> +    pcie_cap_flr_write_config(dev, addr, val, len);
>>>   }
>>>
>>>   static uint64_t igbvf_mmio_read(void *opaque, hwaddr addr, unsigned size)
>>> @@ -266,6 +267,8 @@ static void igbvf_pci_realize(PCIDevice *dev, Error **errp)
>>>           hw_error("Failed to initialize PCIe capability");
>>>       }
>>>
>>> +    pcie_cap_flr_init(dev);
>>> +
>>>       if (pcie_aer_init(dev, 1, 0x100, 0x40, errp) < 0) {
>>>           hw_error("Failed to initialize AER capability");
>>>       }
>>> -- 
>>> 2.41.0
>>>
>>>
>>
> 


