Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4CD7161B3
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:25:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zLp-0004aP-4Y; Tue, 30 May 2023 09:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q3zLM-0004WG-Gs
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:24:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q3zLH-0000bw-OP
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:24:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685453090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AsWvSWDFZhMk6DBVlQagesaEKcw2j5MUn28Zz407PQs=;
 b=QW3IDyjfdQ9oE0/JcJFYuJfkAia5Ahg0C4/09IpsG8biA1A2T9QFcwXKu8wuRSiqdF1CFq
 W+JwCi9GJCtngdLBLnmyTATUGJe+tDKJzvqS4RtfJ6asaJh/d3g44TxKrYQc+CgXOPNZBu
 t98Dee/VCndzWpenfeEAocLqMicpCC0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-vOSMxXGoMKSsOPeNRERkIA-1; Tue, 30 May 2023 09:24:19 -0400
X-MC-Unique: vOSMxXGoMKSsOPeNRERkIA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30932d15a30so2687847f8f.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 06:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685453058; x=1688045058;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AsWvSWDFZhMk6DBVlQagesaEKcw2j5MUn28Zz407PQs=;
 b=lQdI5mjz09BTKjgt8FxmgcFWn48pnTL2+3HNH9HkjSDk4RJ1etHDtVll/jdwtXfjt1
 9AS7/wLML7xZA5raK2n1k0IID4ZoO0/GjhHULThsl7swzdPBBImc/uN30G34tm7Hopb4
 H/YmCfJPfXPcTePwL/f1PnCq7OeYyV6YogkFR4lC+R4KpvNcqKUo8K58piZw2nD7pR3V
 xfZgRJ5pGqpQM2dtkTSM51A5y9CY3jZeHPnkd9dXyvw+ccU5MB4a/JVKj/Jq6Fozz+Mt
 tn4nIPEbOnmibnWty6Obx0Z2wghV4l6CmdYemsuBcoeUfIlstMiiSNM5PImqbl6MJbY1
 qMVQ==
X-Gm-Message-State: AC+VfDwa9nTQz4Hcqg3cj880hfTHkW4mKv87WGDD6gUGXT45Yfbcifjr
 dRHy+lIW4t+KFsENG4QKMmBEyMkzyxSSSbRT/QOQDMBcTBjTWrFAb15sgD8PWAe+pQ2iWlVfpOf
 Lms+vD7QCHACfHRc=
X-Received: by 2002:adf:dd92:0:b0:30a:b46a:a443 with SMTP id
 x18-20020adfdd92000000b0030ab46aa443mr1522355wrl.51.1685453058129; 
 Tue, 30 May 2023 06:24:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5EBa/rby5zNM8aBHYkcHgcV2QBVaEcvgu+2WxhtRHcBwxQVJ7q2rv5WF0b5bAoRbzhtOAkqw==
X-Received: by 2002:adf:dd92:0:b0:30a:b46a:a443 with SMTP id
 x18-20020adfdd92000000b0030ab46aa443mr1522339wrl.51.1685453057798; 
 Tue, 30 May 2023 06:24:17 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73c:d500:78e5:f448:8bef:a30?
 (p200300cbc73cd50078e5f4488bef0a30.dip0.t-ipconnect.de.
 [2003:cb:c73c:d500:78e5:f448:8bef:a30])
 by smtp.gmail.com with ESMTPSA id
 o11-20020a5d670b000000b0030ada01ca78sm3297976wru.10.2023.05.30.06.24.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 06:24:17 -0700 (PDT)
Message-ID: <ab0b1cf4-b4a7-8ebe-81f9-d85317d16c35@redhat.com>
Date: Tue, 30 May 2023 15:24:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 02/10] memory-device: Introduce memory_devices_init()
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <eduardo@habkost.net>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>
References: <20230530113838.257755-1-david@redhat.com>
 <20230530113838.257755-3-david@redhat.com>
 <7ff1f897-7244-258e-34a5-a4a781f679dc@linaro.org>
 <2e51c9e4-3716-5f55-b006-30a40b0ea0da@redhat.com>
Organization: Red Hat
In-Reply-To: <2e51c9e4-3716-5f55-b006-30a40b0ea0da@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 30.05.23 15:04, David Hildenbrand wrote:
> On 30.05.23 14:29, Philippe Mathieu-Daudé wrote:
>> Hi David,
>>
>> On 30/5/23 13:38, David Hildenbrand wrote:
>>> Let's intrduce a new helper that we will use to replace existing memory
>>> device setup code during machine initialization. We'll enforce that the
>>> size has to be > 0.
>>>
>>> Once all machines were converted, we'll only allocate ms->device_memory
>>> if the size > 0.
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>     hw/mem/memory-device.c         | 14 ++++++++++++++
>>>     include/hw/mem/memory-device.h |  2 ++
>>>     2 files changed, 16 insertions(+)
>>
>>
>>> diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
>>> index 48d2611fc5..6e8a10e2f5 100644
>>> --- a/include/hw/mem/memory-device.h
>>> +++ b/include/hw/mem/memory-device.h
>>> @@ -16,6 +16,7 @@
>>>     #include "hw/qdev-core.h"
>>>     #include "qapi/qapi-types-machine.h"
>>>     #include "qom/object.h"
>>> +#include "exec/hwaddr.h"
>>>     
>>>     #define TYPE_MEMORY_DEVICE "memory-device"
>>>     
>>> @@ -113,5 +114,6 @@ void memory_device_plug(MemoryDeviceState *md, MachineState *ms);
>>>     void memory_device_unplug(MemoryDeviceState *md, MachineState *ms);
>>>     uint64_t memory_device_get_region_size(const MemoryDeviceState *md,
>>>                                            Error **errp);
>>> +void memory_devices_init(MachineState *ms, hwaddr base, uint64_t size);
>>
>>
>> While hw/mem/memory-device.c contains the implementation, all callers
>> are expected to be around Machine object, right? Thus maybe this _init()
>> could be declared in "hw/boards.h", already included by machines
>> (eventually renaming as machine_init_memory_devices() ). Then machines
>> implementation don't have to all include "hw/mem/memory-device.h".
> 
> Some (arm, i386) want to call the hotplug handle functions either way,
> so they'll still have to include that header.
> 
> But sure, we can rename to machine_init_memory_devices() and declare it
> include/hw/boards.h!

FWIW, I went with "machine_memory_devices_init()", to mach the style of 
"machine_run_board_init()".

-- 
Thanks,

David / dhildenb


