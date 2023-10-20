Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0C07D09A7
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 09:41:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtk7W-0008An-Rd; Fri, 20 Oct 2023 03:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qtk7U-00083n-0w
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 03:40:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qtk7O-0001ty-Ve
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 03:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697787625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mOKUQ2eGWqBnsabEIYhOlwbYaFXW6rUjkW+ZuwRzQpk=;
 b=YbGUt5GZSt/0vH6E2NEVe7fO3d8dAcfh7I4aJlt6DGoEVNFb9rN+wrB1xGoPnklJLVDfw2
 xBxIYZkv4RrHmgJmAyhIZG3ETAOLMkxqKAkG3J7s6A1p86xZCW6D+TPO06YadJDMJ7Ztv6
 6ghtiBwATplOyY+vb4wTcirGCzevv78=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-IerhZZ5GNYeMUu5jaOadCw-1; Fri, 20 Oct 2023 03:40:23 -0400
X-MC-Unique: IerhZZ5GNYeMUu5jaOadCw-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-66d7b90c8ecso7107486d6.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 00:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697787623; x=1698392423;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mOKUQ2eGWqBnsabEIYhOlwbYaFXW6rUjkW+ZuwRzQpk=;
 b=YyBO7cMV8ghg6zJJSflZzYJt/Wh7RLoVycdDN8p+nmF76iBV0xe7XLaKmHQINqhS0N
 Yo/B7Eb1GRFWa6E+XhaUgr2Qg5JWJwOX7ZWS5bA57mjrOscZZjQA95UDvyPCxf/6cf/A
 AVo8LVjGsirxel8qyAaVz4m+b0+NAv//O64CQ1yX/87yGhNo/b6ObP5C7YTSV1uwY5y0
 VU+lgq/qtM8XcXKU2rx5CyRv6kwXF+e2GFWtXezBNRV4sk+ljzgosjofL04BThSH8iBF
 IMVMm58V5v5R03aDga80LcBMs3nEZh3fNPbK9X7+kYulaKLES3rP1UGWFqzyi1xNAGVD
 XcoQ==
X-Gm-Message-State: AOJu0YytcdwvA9xX9qN2W+DJ91gTuvH7OK7R5q26K7o7tZ8fxNAK0Ojp
 7H/KAP4HYVAYZgkbSlgflvW6YMuNQtUifrK5fIfNpfdOXJiXx5muomXNSnkcpbZUuBa3VgNsU5c
 1xfE3dOoK2CgIzF4=
X-Received: by 2002:a05:6214:212b:b0:66d:33d2:4ff5 with SMTP id
 r11-20020a056214212b00b0066d33d24ff5mr1271059qvc.41.1697787623227; 
 Fri, 20 Oct 2023 00:40:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqru8cH/StfvHGq/u1buFw3+slBLnsIqjth07W8CJDvmUm6vunLHh7ABq1E70arY3wetrayQ==
X-Received: by 2002:a05:6214:212b:b0:66d:33d2:4ff5 with SMTP id
 r11-20020a056214212b00b0066d33d24ff5mr1271047qvc.41.1697787622924; 
 Fri, 20 Oct 2023 00:40:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 oj2-20020a056214440200b006577e289d37sm491354qvb.2.2023.10.20.00.40.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Oct 2023 00:40:22 -0700 (PDT)
Message-ID: <d9df1c95-f681-4962-be74-671cef90e908@redhat.com>
Date: Fri, 20 Oct 2023 09:40:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] igb: Add Function Level Reset to PF and VF
To: Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>
References: <20230829090529.184438-1-clg@kaod.org>
 <20230829090529.184438-3-clg@kaod.org>
 <CACGkMEu6nznVGTyk8gjrZ3jE=bEAd2bDDi9PPwjDKNFkXnVhSQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <CACGkMEu6nznVGTyk8gjrZ3jE=bEAd2bDDi9PPwjDKNFkXnVhSQ@mail.gmail.com>
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

On 10/20/23 06:24, Jason Wang wrote:
> On Tue, Aug 29, 2023 at 5:06 PM Cédric Le Goater <clg@kaod.org> wrote:
>>
>> From: Cédric Le Goater <clg@redhat.com>
>>
>> The Intel 82576EB GbE Controller say that the Physical and Virtual
>> Functions support Function Level Reset. Add the capability to each
>> device model.
>>
> 
> Do we need to do migration compatibility for this?

Yes. it does. the config space is now different.

Thanks,

C.


> 
> Thanks
> 
>> Cc:  Sriram Yagnaraman <sriram.yagnaraman@est.tech>
>> Fixes: 3a977deebe6b ("Intrdocue igb device emulation")
>> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   hw/net/igb.c   | 3 +++
>>   hw/net/igbvf.c | 3 +++
>>   2 files changed, 6 insertions(+)
>>
>> diff --git a/hw/net/igb.c b/hw/net/igb.c
>> index e70a66ee038e..b8c170ad9b1a 100644
>> --- a/hw/net/igb.c
>> +++ b/hw/net/igb.c
>> @@ -101,6 +101,7 @@ static void igb_write_config(PCIDevice *dev, uint32_t addr,
>>
>>       trace_igb_write_config(addr, val, len);
>>       pci_default_write_config(dev, addr, val, len);
>> +    pcie_cap_flr_write_config(dev, addr, val, len);
>>
>>       if (range_covers_byte(addr, len, PCI_COMMAND) &&
>>           (dev->config[PCI_COMMAND] & PCI_COMMAND_MASTER)) {
>> @@ -433,6 +434,8 @@ static void igb_pci_realize(PCIDevice *pci_dev, Error **errp)
>>       }
>>
>>       /* PCIe extended capabilities (in order) */
>> +    pcie_cap_flr_init(pci_dev);
>> +
>>       if (pcie_aer_init(pci_dev, 1, 0x100, 0x40, errp) < 0) {
>>           hw_error("Failed to initialize AER capability");
>>       }
>> diff --git a/hw/net/igbvf.c b/hw/net/igbvf.c
>> index 07343fa14a89..55e321e4ec20 100644
>> --- a/hw/net/igbvf.c
>> +++ b/hw/net/igbvf.c
>> @@ -204,6 +204,7 @@ static void igbvf_write_config(PCIDevice *dev, uint32_t addr, uint32_t val,
>>   {
>>       trace_igbvf_write_config(addr, val, len);
>>       pci_default_write_config(dev, addr, val, len);
>> +    pcie_cap_flr_write_config(dev, addr, val, len);
>>   }
>>
>>   static uint64_t igbvf_mmio_read(void *opaque, hwaddr addr, unsigned size)
>> @@ -266,6 +267,8 @@ static void igbvf_pci_realize(PCIDevice *dev, Error **errp)
>>           hw_error("Failed to initialize PCIe capability");
>>       }
>>
>> +    pcie_cap_flr_init(dev);
>> +
>>       if (pcie_aer_init(dev, 1, 0x100, 0x40, errp) < 0) {
>>           hw_error("Failed to initialize AER capability");
>>       }
>> --
>> 2.41.0
>>
>>
> 


