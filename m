Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FF178E7AE
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 10:12:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbclT-00029c-Cx; Thu, 31 Aug 2023 04:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbclR-00028u-CP
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 04:10:53 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbclP-0005bb-0u
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 04:10:53 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9a2185bd83cso57550366b.0
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 01:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693469449; x=1694074249; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZBn4qGU93pywR8nFxzsC0BsJWlS1sr/wx4SQxHYh8PI=;
 b=mQMasy27iLXHTCUrjdQUrf44ULiIqnLTGgrCMH9ZsgpiwXGWn/7/EHKF9W/4qkHWVr
 RrEXKGDRaZfgiYMRNwRejK5Kn10EABghCdFV6XE15v0YThqChsyCU9ouWpKtiNLR3OvX
 +7gdJfJx9RoN0wlaUJDwzz548ul6EP2DSxEPJ7eq9bEk+IlxYTPuoUJ65whoHzKpy3Cd
 ghtqHfiMnla/7e1FSe+Flv3Xm+41/wcq9YBcvO9lUk6EGfT51e+XU+mnTIkV0COcuF2r
 bmhnb5tLNXdKigBUp8wKWm//AVCZiEb5n30EDBdGpujKK63IRQdbQV9zhOPym0nMkPax
 ZhBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693469449; x=1694074249;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZBn4qGU93pywR8nFxzsC0BsJWlS1sr/wx4SQxHYh8PI=;
 b=K57xHmwGPUwi4Urjjr5Wf4lVJTeNnGOPv+zdAhRLxP9TedfTWs9axHaAKJtCnAr7ZC
 PLQ4d1gcyw8iIKCDtT8JgJAR58Ad4Bq5ZtHgSjK8Zg8huLmWFUUwye6qblhEu6rVXw8W
 mFzEwJTqQEI5YtdR4Y3JBgJJ0qgTmyuaQ9DA4exHs8FmceFkCJlBKgNWswXp8Eg2M84T
 KoopHd83aeM9UAp/9vZgexql7LPP05I6iVopdjgkZGDIhRwWWos+ciAry/8rPuzP7dFM
 a1gSlQAI7V8KPQNzFosMvhdn1y3Nq1P4Yr4N/hS2GqXynR4GdQOgR/CtxcLfGuCOR1uS
 gHzQ==
X-Gm-Message-State: AOJu0YxlEmZYBMJwnHF7Afj3D7GsB8a35G7yegsiYEQFZauVZH4VukUL
 9wHeh7VvasvJ9ZkBp4l/M6bLWw==
X-Google-Smtp-Source: AGHT+IEj8+UHM31ahwE8rDUokNeydp6QV0Irxh4D3NpwI7dmwtIPuy8GVfB0O0Mlc1GXq2EDZKN4iA==
X-Received: by 2002:a17:907:2c4b:b0:99d:6b3c:3d40 with SMTP id
 hf11-20020a1709072c4b00b0099d6b3c3d40mr3305123ejc.6.1693469449348; 
 Thu, 31 Aug 2023 01:10:49 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 e19-20020a1709067e1300b009a198078c53sm466906ejr.214.2023.08.31.01.10.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Aug 2023 01:10:49 -0700 (PDT)
Message-ID: <972bf6a0-f879-dc94-e0c3-c9d5e107da0d@linaro.org>
Date: Thu, 31 Aug 2023 10:10:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] pci: SLT must be RO
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Marcin Juszkiewicz
 <marcin.juszkiewicz@linaro.org>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
References: <de9d05366a70172e1789d10591dbe59e39c3849c.1693432039.git.mst@redhat.com>
 <084d2e90-86d4-eabc-3270-d3ef680c9631@linaro.org>
 <20230831024011-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230831024011-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 31/8/23 08:45, Michael S. Tsirkin wrote:
> On Thu, Aug 31, 2023 at 08:22:34AM +0200, Philippe Mathieu-Daudé wrote:
>> Hi Michael,
>>
>> On 30/8/23 23:48, Michael S. Tsirkin wrote:
>>> current code sets PCI_SEC_LATENCY_TIMER to WO, but for
>>> pcie to pcie bridges it must be RO 0 according to
>>> pci express spec which says:
>>>       This register does not apply to PCI Express. It must be read-only
>>>       and hardwired to 00h. For PCI Express to PCI/PCI-X Bridges, refer to the
>>>       [PCIe-to-PCI-PCI-X-Bridge] for requirements for this register.
>>>
>>> also, fix typo in comment where it's make writeable - this typo
>>> is likely what prevented us noticing we violate this requirement
>>> in the 1st place.
>>>
>>> Reported-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>> ---
>>>
>>> Marcin, could you pls test this patch with virt-8.1 and latest?
>>> Thanks a lot!
>>>
>>>
>>>    include/hw/pci/pci_bridge.h |  3 +++
>>>    hw/core/machine.c           |  5 ++++-
>>>    hw/pci/pci.c                |  2 +-
>>>    hw/pci/pci_bridge.c         | 14 ++++++++++++++
>>>    4 files changed, 22 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
>>> index ea54a81a15..5cd452115a 100644
>>> --- a/include/hw/pci/pci_bridge.h
>>> +++ b/include/hw/pci/pci_bridge.h
>>> @@ -77,6 +77,9 @@ struct PCIBridge {
>>>        pci_map_irq_fn map_irq;
>>>        const char *bus_name;
>>> +
>>> +    /* SLT is RO for PCIE to PCIE bridges, but old QEMU versions had it RW */
>>> +    bool pcie_writeable_slt_bug;
>>>    };
>>
>> Patch LGTM, so:
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
>>> -GlobalProperty hw_compat_8_1[] = {};
>>> +GlobalProperty hw_compat_8_1[] = {
>>> +    { TYPE_PCI_BRIDGE, "x-pci-express-writeable-slt-bug", "true" },
>>
>> However I don't understand why we can't clear the config register and
>> must use a compat flag, since per the spec it is hardwired to 0.
> 
> Because historically we didn't. If we make it RO and migrate from
> VM where guest wrote into this register, migration will fail
> as we check that RO fields are unchanged.
> Another trick would be to pretend it's hardware driven
> and set cmask. Compat machinery is more straight-forward though.

I see.

> 
>> Do we need the "x-" compat prefix? This is not an experimental property.
> 
> It's an internal one, we don't want users to tweak it.

OK, thanks!


