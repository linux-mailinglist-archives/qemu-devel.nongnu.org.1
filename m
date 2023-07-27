Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C440766048
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 01:44:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPAMQ-0007sc-LT; Thu, 27 Jul 2023 19:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qPAMM-0007qQ-QV
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 19:25:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qPAMK-0006uj-9d
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 19:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690500327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vjnj49djnMQDit2/xhnHJJE5LQWbvAOnsEQPoX8jvak=;
 b=WRCEOWswShR8I86UsY/jXMHJIGb/yCZZU/rajaaUY/PpxNK03Pi/m8gzTa4BmlAyZ3zI5q
 RZgzZ/vJfzzco9kh/0rQ6ZVR1lycLy9FqNqiqV87j/5FDl2z5NBdKooYFOqa5TzaxUxJxX
 0UoR8eU1ghgfkyP2okXWmfYeoMMNBoU=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-shvEoMh_MKGtF5pxm_1PBA-1; Thu, 27 Jul 2023 19:25:23 -0400
X-MC-Unique: shvEoMh_MKGtF5pxm_1PBA-1
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-7867b689079so98133939f.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 16:25:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690500322; x=1691105122;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vjnj49djnMQDit2/xhnHJJE5LQWbvAOnsEQPoX8jvak=;
 b=bVFwGzbTDwYcQJj5WdRpljfq4MdbveJMBgEptoENnFzwbenLEMa8eFHULLXP2PkAnE
 jPbo/HbAf/HUfDLxu5hgH81ZJgR6YmkfBBN1q02Q+xBmSqApp22OEXDO4tamQJYYY47l
 VBp4MOZc2ku+6KAjWUUbUv+YfREf4WxjLtNAc9c2bSnCUgJ2Y3a9/2cT7M3lMfiI8msL
 vwo56ChftVk3rlKY1T8KXTHLL1Bb7Hi2+VucfPHgeqPjCfWMGLymhMx5AR/3kjT/eOb9
 IgIEkKCadM9o+x/Fgi3DLuv2Md6dfLzw65uv0tst7WCrlW5Lq6dWiJkyZwy6IOXVFXgN
 FceA==
X-Gm-Message-State: ABy/qLa105rMNi3/WVSH12jYVDplSa9GqDmB0oyNHGjSXizqt+022Chc
 7kEhgYRQ5NA544FHBcQvvOHyZmWIAvJX/7dqzXs1IS1CE1+EJkfFjdKQjRLHK0gKszvtVd9QN5W
 uImlisjLpOhn5HGo=
X-Received: by 2002:a05:6e02:20cb:b0:348:e180:831d with SMTP id
 11-20020a056e0220cb00b00348e180831dmr922686ilq.20.1690500322584; 
 Thu, 27 Jul 2023 16:25:22 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH+o06feT/TIh4JmnfMKTutxDha9n3JyTiuZIsxOcrikYrphCvf9Gg+nh9GgxG9IY7cJRypVg==
X-Received: by 2002:a05:6e02:20cb:b0:348:e180:831d with SMTP id
 11-20020a056e0220cb00b00348e180831dmr922676ilq.20.1690500322312; 
 Thu, 27 Jul 2023 16:25:22 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 12-20020a170902c14c00b001b86dd825e7sm2175977plj.108.2023.07.27.16.25.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jul 2023 16:25:21 -0700 (PDT)
Message-ID: <ea2db075-266f-fa6d-d322-1767dc118a33@redhat.com>
Date: Fri, 28 Jul 2023 09:25:17 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/8] Adds CPU hot-plug support to Loongarch
Content-Language: en-US
To: Salil Mehta <salil.mehta@huawei.com>, xianglai li
 <lixianglai@loongson.cn>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 zhukeqian <zhukeqian1@huawei.com>
Cc: Salil Mehta <salil.mehta@opnsrc.net>
References: <cover.1689837093.git.lixianglai@loongson.cn>
 <83d5c2b6-20a2-0637-8373-c1935d97dc68@redhat.com>
 <f0be74b6104f49be943f5266be40cdd6@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <f0be74b6104f49be943f5266be40cdd6@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Salil,

On 7/28/23 00:58, Salil Mehta wrote:
>> From: Gavin Shan <gshan@redhat.com>
>> Sent: Thursday, July 27, 2023 1:57 AM
>> On 7/20/23 17:15, xianglai li wrote:
>>> Hello everyone, We refer to the implementation of ARM CPU
>>> Hot-Plug to add GED-based CPU Hot-Plug support to Loongarch.
>>>
>>> The first 4 patches are changes to the QEMU common code,
>>> including adding GED support for CPU Hot-Plug, updating
>>> the ACPI table creation process, and adding qdev_disconnect_gpio_out_named
>>> and cpu_address_space_destroy interfaces to release resources
>>> when CPU un-plug.
>>>
>>> The last four patches are Loongarch architecture-related,
>>> and the modifications include the definition of the hook
>>> function related to the CPU Hot-(UN)Plug, the allocation
>>> and release of CPU resources when CPU Hot-(UN)Plug,
>>> the creation process of updating the ACPI table,
>>> and finally the custom switch for the CPU Hot-Plug.
> 
> [...]
> 
>> It seems the design for ARM64 hotplug has been greatly referred, but the authors
>> are missed to be copied if you were referring to the following repository.
>> There will be conflicts between those two patchsets as I can see and I'm not sure
>> how it can be resolved. In theory, one patchset needs to be rebased on another
>> one since they're sharing large amount of codes.
>>
>>     https://github.com/salil-mehta/qemu.git
>>     (branch: virt-cpuhp-armv8/rfc-v1-port11052023.dev-1)
>>
>> I took a quick scan on this series. Loongarch doesn't have ARM64's constraint due
>> to vGIC3 where all vCPUs's file descriptor needs to be in place. It means the possible
>> and not yet present vCPU needs to be visible to KVM. Without this constraint, the
>> implementation is simplified a lot.
>>
>> Besides, we found the vCPU hotplug isn't working for TCG when Salil's series was
>> tested. I'm not sure if we have same issue with this series, or TCG isn't a concern
>> to us at all?
> 
> 
> Sorry, I should have replied this in the other mail but have been on/off in last
> few days due to some medical reasons. But jotting it here:
> 
> Yes, you are correct. And there are some trivial fixes we already have to make
> it work. In case it is useful to you, we are planning to add them for the sake
> of completion. Maybe you can try that in the RFC V2 or I'll share with you the
> repository once I push the fixes.
> 
> Many thanks!
> 

No worries, thanks a lot for your followup and clarify. I think it'd better to
make TCG working so that we have consistent vCPU hotplug capability for all
accelerators eventually. However, I didn't test with HVF and not sure about it.
I just checked your repository again and it seems these TCG fixes aren't there
yet.

   https://github.com/salil-mehta/qemu.git
   (virt-cpuhp-armv8/rfc-v1-port11052023.dev-1)

   /home/gshan/sandbox/src/qemu/main/build/qemu-system-aarch64           \
   -accel tcg -machine virt,gic-version=3,nvdimm=on -icount 1            \
   -cpu max -smp maxcpus=2,cpus=1,sockets=1,clusters=1,cores=1,threads=2
    :
   (qemu) device_add driver=max-arm-cpu,id=cpu1,thread-id=1
   Error: cpu(id1=0:0:0:1) with arch-id 1 exists

As to the cause, the CPU object isn't detached from the CPU slot as said
before.

Thanks,
Gavin


