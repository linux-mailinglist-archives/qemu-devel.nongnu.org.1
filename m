Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D609744D6F
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 13:21:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFv8h-0002CD-7R; Sun, 02 Jul 2023 07:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qFv8e-0002BO-UA
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 07:21:08 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qFv8c-0002TN-D0
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 07:21:08 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-99342a599e9so96839366b.3
 for <qemu-devel@nongnu.org>; Sun, 02 Jul 2023 04:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688296864; x=1690888864;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uqMt7emt2j92g4UboH0a9SBXGIUT24T2EFs2eoTTxwU=;
 b=nbVWuITsbpQHS4m+EqnqK/fTlNi55U6whjdyEHsLLhH/7Rn1cpfUFPg0pDm7wD5ows
 uPcdHScM3pFfNNtTYAu/yipet9HTtBm2s1BXAJ5Edlnv/6ElYz6JeBh0Fy3jMJ1+fMa3
 i/FEHZNFEeCRml4Ppn2yRGnBmV67U5iXOKOewIAGi8wQCKMvfvf1bXUpHAfRLQbDxK7m
 +ArOBAMZC2uK2K8dUY8Mr/Wr1qgCNBFg0a9OEI6lxJMdwt++dcd5txjOTCgM77svEX/k
 aq9vCmMiDrnDtPeLzUy8DvMwReZUrVmS1ddSCbfDz7CCR7O7/4pNv3o9reo8JSFtONGG
 hwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688296864; x=1690888864;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uqMt7emt2j92g4UboH0a9SBXGIUT24T2EFs2eoTTxwU=;
 b=ia6BKfO39SQgl1wykCNsnoJD+lh9FCKFmWFsCT9yZCdpJTu4OB1L3dQ5uhr+n6eM2J
 YuMI7W3UJevCkb8l0bZtGG3tdgU4MpJU7ZDOxT6g09HvmZA6OR9+GS+t9aDyeaos0L0R
 CTRId8Ge6kCld0CyrZw1Ih+JO5b5xe5l/br6bJfTqXwjzo3S039lTDUlgQFVjSBTNhS7
 eXSiCZkZfZRMckhJ5u9Kd1ra1nM6eQkt1aXKQ1EnM6e237AvEPC4C7X2yxP6luIZvRPt
 iq71sTQyOiFSQjSp2ckF4GuRgk71Pydl1PicqxYknSj/texLqygLZyAi2kOBbYC+lYhB
 /Reg==
X-Gm-Message-State: ABy/qLaD7mtBbtJsh26IASDJQCVKeYY74VYp0sbr62tKc3rt4BGCMAOY
 +ri3ze+Y0NonH4p4baOQtdFhOw==
X-Google-Smtp-Source: APBJJlFkU7nfWm3bE26bAN8uIfu5x4oQU4dWDoJV5a/68GEeBLbgyNpuyVElc7aRGx6PehdW3MrL9g==
X-Received: by 2002:a17:906:bce8:b0:98e:933:2909 with SMTP id
 op8-20020a170906bce800b0098e09332909mr5315625ejb.22.1688296864188; 
 Sun, 02 Jul 2023 04:21:04 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.133.225])
 by smtp.gmail.com with ESMTPSA id
 v24-20020a1709064e9800b00992ca779f42sm3648176eju.97.2023.07.02.04.21.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Jul 2023 04:21:03 -0700 (PDT)
Message-ID: <8d05c389-c4f6-b806-dfb7-b336c337bcef@linaro.org>
Date: Sun, 2 Jul 2023 13:21:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] pcie: Release references of virtual functions
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20230411090408.48366-1-akihiko.odaki@daynix.com>
 <44853d32-38cc-eec0-c96f-31c898104e7d@linaro.org>
 <20230421040908-mutt-send-email-mst@kernel.org>
 <3c544bc4-0257-8973-e2d6-7be8d686a08c@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <3c544bc4-0257-8973-e2d6-7be8d686a08c@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 1/7/23 08:19, Akihiko Odaki wrote:
> On 2023/04/21 17:09, Michael S. Tsirkin wrote:
>> On Tue, Apr 11, 2023 at 12:11:30PM +0200, Philippe Mathieu-Daudé wrote:
>>> On 11/4/23 11:04, Akihiko Odaki wrote:
>>>> pci_new() automatically retains a reference to a virtual function when
>>>> registering it so we need to release the reference when unregistering.
>>>>
>>>> Fixes: 7c0fa8dff8 ("pcie: Add support for Single Root I/O 
>>>> Virtualization (SR/IOV)")
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>> ---
>>>>    hw/pci/pcie_sriov.c | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
>>>> index aa5a757b11..76a3b6917e 100644
>>>> --- a/hw/pci/pcie_sriov.c
>>>> +++ b/hw/pci/pcie_sriov.c
>>>> @@ -211,6 +211,7 @@ static void unregister_vfs(PCIDevice *dev)
>>>>                error_free(local_err);
>>>>            }
>>>>            object_unparent(OBJECT(vf));
>>>> +        object_unref(OBJECT(vf));
>>>>        }
>>>>        g_free(dev->exp.sriov_pf.vf);
>>>>        dev->exp.sriov_pf.vf = NULL;
>>>
>>> It feels the issue is at the device creation.
>>>
>>> [/me looking at the code]
>>>
>>> What about:
>>>
>>> -- >8 --
>>> diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
>>> index aa5a757b11..fca3bf6e72 100644
>>> --- a/hw/pci/pcie_sriov.c
>>> +++ b/hw/pci/pcie_sriov.c
>>> @@ -150,7 +150,7 @@ static PCIDevice *register_vf(PCIDevice *pf, int 
>>> devfn,
>>> const char *name,
>>>       PCIBus *bus = pci_get_bus(pf);
>>>       Error *local_err = NULL;
>>>
>>> -    qdev_realize(&dev->qdev, &bus->qbus, &local_err);
>>> +    pci_realize_and_unref(dev, bus, &local_err);
>>>       if (local_err) {
>>>           error_report_err(local_err);
>>>           return NULL;
>>
>> ok you want to repost this or Akihiko convinced you?
>>
>>
>>> ---
>>
> 
> Can you reply to this?

Sorry I didn't noticed MST question.

PCIDevice should use their class realize() handler, not the qdev
parent. Code smell somewhere, but can be cleaned later.
I'm fine with Akihiko's patch.

Regards,

Phil.

