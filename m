Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D166B7446E4
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 08:21:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFTxn-00011R-OO; Sat, 01 Jul 2023 02:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFTxl-000118-A7
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 02:20:05 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFTxj-0002Ol-K3
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 02:20:05 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-39eab4bbe8aso1885726b6e.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 23:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1688192401; x=1690784401;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ctc0nmsg6FHkQzZjhBAEQ1qBflBk2llm39BliDq1a8w=;
 b=xKLq9D+vwUmg3LpTOCVs1ttuPhNyWpL5t5rqcyw1oVZgPlhoFM3P/2a/jufCeSCKuk
 xX8s0x7C72Klvh07/zOEge8sFGPKZ19WaKIopSNgrA1LJzRTB//ykt+7maSzbd78BEkg
 Q89YY5kJtHGkdXfs+INtuhgJubhJuO7vvAZRTutBXTiTQGBFbwyVbsbTO+cra+Qob6qB
 IUmHkKKnHYKdgU+FNtqZINP+0LJ4fO4BxE5uIqsNslxG2f0Rj5Xb99QkGD4HAOJqCWYV
 4PpuiPRIhAUA90DhhyBWOuFtX1XqwWcdunjYXgzTFTRyWWyYZRPPPOKAPdAiEYfY68NF
 kGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688192401; x=1690784401;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ctc0nmsg6FHkQzZjhBAEQ1qBflBk2llm39BliDq1a8w=;
 b=WgmVPdUsEZhwkQXlnm0daHbBCCgtvcBRvmKLDaAyx8tpJXVnvN1UrECAZaBd1l22ai
 ZjZPp/fnkecuBXuB0rv0hfV2Xng0J0aLvHkZnr0vn5n2/ZpsXhcZEAzEriuyR2A9ywCd
 KVgSLdxzc9Zh/COUKCVkWKZsAQJnayuGKdyu13PqCphSR5dheJj14nLX/32oXzoCK3WR
 /OEQVLchFGoxKLet2rs9eUpGlhCa9gmbmfPiDowU35asDgHVBP+m+FupxKZakrJ2+ple
 u3PEkgpx2hXjcBKfsb/6NL+nIfA4vyZwoGRNDsP+lY/YsuCKwqCrOkZfvtDVjNPlTSHE
 E2/Q==
X-Gm-Message-State: ABy/qLbqVBcDFgY0bvBgb+0S2bf9wnvVXlzX0xfUIL7/S5YtSML71w6W
 hXRwVPLl/2oBJPFeZ2QzmPIFxQ==
X-Google-Smtp-Source: APBJJlGik8YipesTKImruKUJSYZCwigsjAbqq3Z9ZCuUpJtSYgHiAoMUdISD+zZ3Gdf1LdrPBLPuxw==
X-Received: by 2002:a05:6358:e99:b0:134:d19a:b89e with SMTP id
 25-20020a0563580e9900b00134d19ab89emr4444172rwg.1.1688192400960; 
 Fri, 30 Jun 2023 23:20:00 -0700 (PDT)
Received: from [157.82.204.253] ([157.82.204.253])
 by smtp.gmail.com with ESMTPSA id
 jl16-20020a170903135000b001b87d3e845bsm723330plb.149.2023.06.30.23.19.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 23:20:00 -0700 (PDT)
Message-ID: <3c544bc4-0257-8973-e2d6-7be8d686a08c@daynix.com>
Date: Sat, 1 Jul 2023 15:19:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] pcie: Release references of virtual functions
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
References: <20230411090408.48366-1-akihiko.odaki@daynix.com>
 <44853d32-38cc-eec0-c96f-31c898104e7d@linaro.org>
 <20230421040908-mutt-send-email-mst@kernel.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230421040908-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::236;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x236.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-0.095, RCVD_IN_DNSWL_NONE=-0.0001,
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

On 2023/04/21 17:09, Michael S. Tsirkin wrote:
> On Tue, Apr 11, 2023 at 12:11:30PM +0200, Philippe Mathieu-Daudé wrote:
>> On 11/4/23 11:04, Akihiko Odaki wrote:
>>> pci_new() automatically retains a reference to a virtual function when
>>> registering it so we need to release the reference when unregistering.
>>>
>>> Fixes: 7c0fa8dff8 ("pcie: Add support for Single Root I/O Virtualization (SR/IOV)")
>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> ---
>>>    hw/pci/pcie_sriov.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
>>> index aa5a757b11..76a3b6917e 100644
>>> --- a/hw/pci/pcie_sriov.c
>>> +++ b/hw/pci/pcie_sriov.c
>>> @@ -211,6 +211,7 @@ static void unregister_vfs(PCIDevice *dev)
>>>                error_free(local_err);
>>>            }
>>>            object_unparent(OBJECT(vf));
>>> +        object_unref(OBJECT(vf));
>>>        }
>>>        g_free(dev->exp.sriov_pf.vf);
>>>        dev->exp.sriov_pf.vf = NULL;
>>
>> It feels the issue is at the device creation.
>>
>> [/me looking at the code]
>>
>> What about:
>>
>> -- >8 --
>> diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
>> index aa5a757b11..fca3bf6e72 100644
>> --- a/hw/pci/pcie_sriov.c
>> +++ b/hw/pci/pcie_sriov.c
>> @@ -150,7 +150,7 @@ static PCIDevice *register_vf(PCIDevice *pf, int devfn,
>> const char *name,
>>       PCIBus *bus = pci_get_bus(pf);
>>       Error *local_err = NULL;
>>
>> -    qdev_realize(&dev->qdev, &bus->qbus, &local_err);
>> +    pci_realize_and_unref(dev, bus, &local_err);
>>       if (local_err) {
>>           error_report_err(local_err);
>>           return NULL;
> 
> ok you want to repost this or Akihiko convinced you?
> 
> 
>> ---
> 

Can you reply to this?

Regards,
Akihiko Odaki

