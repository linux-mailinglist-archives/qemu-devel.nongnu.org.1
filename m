Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3497B7C61A3
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 02:20:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqjPP-0001v1-Sg; Wed, 11 Oct 2023 20:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qqjPN-0001ul-Vh
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 20:18:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qqjPM-0003b2-8v
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 20:18:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697069910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sDlZjU/yvB4WX2Ore1U3k6oEDJit8P3VKDQDTSId1Z8=;
 b=WhIfsFsIG04eDprlOnMarFSCwT5wBTQAxulPCGeqOrB1Cy+giCH2ZqozsFXcqjF5l7oMf0
 elTQqV7+dXiLl/lUt1zF6ekhxzZV2qkY1P6zBzdq7XUwhWpBr6xJslq6JX7oR6BTZbWUxs
 6frFKUp17CoF0mwvxQIqfjtjrsPD4HE=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-7j6fIBDjNYObJzVj19_O5Q-1; Wed, 11 Oct 2023 20:18:28 -0400
X-MC-Unique: 7j6fIBDjNYObJzVj19_O5Q-1
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-6c6370774e8so588987a34.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 17:18:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697069908; x=1697674708;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sDlZjU/yvB4WX2Ore1U3k6oEDJit8P3VKDQDTSId1Z8=;
 b=sY4FecYmjMpgsoMle1sTQVNvjoYmaugZVcqFW5WCL1DaPUeKKBrO3SeMbJQiHo1bpY
 2Y41woNenjW+XCdbwCcEPQpZ4ItQEm/9zPy5NDPNvpZF7LnY+1SxSyu42KBljuM2nl0m
 2xHnEAg+eOSmiJFKpOUHLw/i8Nqh3oinljxzs0L1E6gbxKMi9aFpThdod3tQ3dtvlQ5B
 VszfrwgzJolvDalnFgdspsaLmg2Z8B1e+2tYhku/1tBMjeVnz0MXNRES/wh8bTCaOYm3
 iOaiGtxXyjN7CYnlWGBb6nSLu9HytD9pAXg3VObCE3POx0d30mD89UYMyFsz9uynmsg3
 fVqA==
X-Gm-Message-State: AOJu0Yz34IH3R5D3AhPhq3Xnj5qZUQeYfbJiTuckxDBswvA0NcWfSyHf
 tun94HiRtDojsmOlzNfzo1OHYyft7X5KPM6ZbFCdPKFPxuKN+h0xf/84Rdmt1vrFui0Y7eNvCWr
 pyAvvGyoAOzgpVUY=
X-Received: by 2002:a05:6358:7e46:b0:13c:c84b:88b9 with SMTP id
 p6-20020a0563587e4600b0013cc84b88b9mr16857684rwm.15.1697069908006; 
 Wed, 11 Oct 2023 17:18:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESTumiUDuodl3SAG3Z1GyP2ZntMWJmPaUi9+0yGYDHenKoHsw8cJeJ0LGgpri7Y73z9GZcvA==
X-Received: by 2002:a05:6358:7e46:b0:13c:c84b:88b9 with SMTP id
 p6-20020a0563587e4600b0013cc84b88b9mr16857656rwm.15.1697069907655; 
 Wed, 11 Oct 2023 17:18:27 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:b890:3e54:96bb:2a15?
 ([2001:8003:e5b0:9f00:b890:3e54:96bb:2a15])
 by smtp.gmail.com with ESMTPSA id
 v5-20020aa78505000000b00696ca62d5f5sm10668777pfn.8.2023.10.11.17.18.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 17:18:27 -0700 (PDT)
Message-ID: <b8c13adb-ce1e-41fc-daa0-4aa31bf5f7a0@redhat.com>
Date: Thu, 12 Oct 2023 10:18:14 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V5 8/9] physmem: Add helper function to destroy CPU
 AddressSpace
Content-Language: en-US
To: Salil Mehta <salil.mehta@opnsrc.net>, Salil Mehta
 <salil.mehta@huawei.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com,
 oliver.upton@linux.dev, pbonzini@redhat.com, mst@redhat.com,
 will@kernel.org, rafael@kernel.org, alex.bennee@linaro.org,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 karl.heubaum@oracle.com, miguel.luis@oracle.com, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, jiakernel2@gmail.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, linuxarm@huawei.com
References: <20231011194355.15628-1-salil.mehta@huawei.com>
 <20231011194355.15628-9-salil.mehta@huawei.com>
 <69098d56-8b68-2734-ef40-7338386d7fa9@redhat.com>
 <e73217f7-e6c2-81e7-0174-54ef575ebbce@opnsrc.net>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <e73217f7-e6c2-81e7-0174-54ef575ebbce@opnsrc.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hi Salil,

On 10/12/23 10:04, Salil Mehta wrote:
> On 12/10/2023 00:31, Gavin Shan wrote:
>> On 10/12/23 05:43, Salil Mehta wrote:

[...]

>>> +void cpu_address_space_destroy(CPUState *cpu, int asidx)
>>> +{
>>> +    CPUAddressSpace *cpuas;
>>> +
>>> +    assert(asidx < cpu->num_ases);
>>> +    assert(asidx == 0 || !kvm_enabled());
>>> +    assert(cpu->cpu_ases);
>>> +
>>
>> The two asserts on @asidx and @cpu->cpu_ases can be combined
>> to one so that these 3 asserts can be combined to two.
>>
>>         /* Only one address space is supported by KVM */
>>         assert(asidx == 0 || !kvm_enabled());
>>         assert(asidx >= 0 && asidx < cpu->cpu_ases_count)
> 
> We can do that.
> 
> I am not in favor to remove  'assert(cpu->cpu_ases);' as this can save lot of debugging.
> 

Ok, It's fine to keep 'assert(cpu->cpu_ases)', but 'assert(asidx >= 0)' is
still needed? For example, the wrong chunk of memory will be release when
@asidx is smaller than zero, which is out-of-bound to @cpu->cpu_ases[]

Thanks,
Gavin


