Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2567A030E
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 13:51:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgkqe-0003Bk-8U; Thu, 14 Sep 2023 07:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qgkqa-0003Bb-6L
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 07:49:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qgkqV-0004D3-8X
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 07:49:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694692155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Em9vUVlDf7KRuyJfDG6Q3zuOz/xSSwzvhgScMRd7naE=;
 b=DXtusM9R7DStmDyks0ayijd+FB2KYKGEn7CyYuvbKmZP7M5vfEvby9nXfhD1qYQBWUGAcm
 MLRwtwcA/2Mefli/vpAC87rkCsyoZCHSwx0YOJMIuuVdo69PPqE1jfkczBmcVSOYN6Le3g
 UyZr5gvoyXxQNIRkBEIPr65nVft1imk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-6BSeVSeVPLO-Ssd4qPDCig-1; Thu, 14 Sep 2023 07:49:14 -0400
X-MC-Unique: 6BSeVSeVPLO-Ssd4qPDCig-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-31c6c275c83so529674f8f.2
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 04:49:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694692153; x=1695296953;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Em9vUVlDf7KRuyJfDG6Q3zuOz/xSSwzvhgScMRd7naE=;
 b=K6xUp+QRO9Ncj1ZxmR+pXHxbDYka/6yR31NOypd7bzu46wycODNJhwloep0PicBnUG
 U2RtGHUSRcyNJD5wp+ufb5OS6WghmCwtDWRi/+Fkrd22/BDHfTwwVo0TXZIpUQrnjPnA
 H95aefTDL7ESrYNGWFYC9BcfTODl2ROAR1ZEqeOZl6rqA9/TqLya+xKJb8qCR66BQLf4
 M8nR2fe1jY/RGAK+gVSGvXHm9ah966T0El7agmbe5BoF6g0rNVsitz32XEG3ZOJK/4mp
 DWsnAuCw9kGHajAj7btb2bliHrA/JNVnfwxJkMadJJYRfh6ALzfKkL2HFbA++7M+4bnH
 ZurQ==
X-Gm-Message-State: AOJu0YyPZPDcJY27wnHOTTUIPIxLE81+fYV4RccPEPlVjnYoghZOkN9w
 rLsEMJKNhMDPk3xq6Y+bPVgFBQUyQAWsI+gpWpSZ5/kQIgxrvb1BUkiI+HFwDD/ukLR55Stujqv
 Af3b2Hn2eSWPlbtA=
X-Received: by 2002:adf:f08c:0:b0:31d:c3d2:4300 with SMTP id
 n12-20020adff08c000000b0031dc3d24300mr4050450wro.71.1694692153249; 
 Thu, 14 Sep 2023 04:49:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEECD5ZrupXWqlVcmyoMSB8Ro3cTG7lW+2jwINFTjhSMtPEYhgLA1X61zZ2kq3oCK+oV2OG0A==
X-Received: by 2002:adf:f08c:0:b0:31d:c3d2:4300 with SMTP id
 n12-20020adff08c000000b0031dc3d24300mr4050424wro.71.1694692152739; 
 Thu, 14 Sep 2023 04:49:12 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7?
 ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a5d4112000000b0031c6581d55esm1569784wrp.91.2023.09.14.04.49.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Sep 2023 04:49:12 -0700 (PDT)
Message-ID: <e052a3c4-33e9-1d75-dc9b-3c64f8ae777b@redhat.com>
Date: Thu, 14 Sep 2023 13:49:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] mem/x86: add processor address space check for VM memory
Content-Language: en-US
To: Ani Sinha <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-devel <qemu-devel@nongnu.org>
References: <20230908095024.270946-1-anisinha@redhat.com>
 <77284898-c540-31ac-d438-ebff52f6d75d@redhat.com>
 <1911B17C-24F2-406B-9ED4-DCF98E794A09@redhat.com>
 <730648ed-55ac-aa2c-58d2-d79224aeb586@redhat.com>
 <1574DF3A-7E1F-4C4F-9087-6E8DEE456906@redhat.com>
 <6cbca7b9-381b-6268-27f0-d7ea1c5ed1bd@redhat.com>
 <3A287C52-F547-4494-B803-8CFC50CBA175@redhat.com>
 <30f0ddfb-6eb7-84a5-04a0-e11905451733@redhat.com>
 <A354B36D-A86E-48D9-B8B6-DC35D8976410@redhat.com>
 <34403090-b4b3-990f-7723-1d56d8053bd5@redhat.com>
 <08530A80-90F3-4E33-9B1A-E71A66726123@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <08530A80-90F3-4E33-9B1A-E71A66726123@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

>>>> We requested a to hotplug a maximum of "8 GiB", and sized the area slightly larger to allow for some flexibility
>>>> when it comes to placing DIMMs in that "device-memory" area.
>>> Right but here in this example you do not hot plug memory while the VM is running. We can hot plug 8G yes, but the memory may not physically exist yet (and may never exist). How can we use this math to provision device-memory when the memory may not exist physically?
>>
>> We simply reserve a region in GPA space where we can coldplug and hotplug a
>> predefined maximum amount of memory we can hotplug.
>>
>> What do you think is wrong with that?
> 
> The only issue I have is that even though we are accounting for it, the memory actually might not be physically present.

Not sure if "accounting" is the right word; the memory is not present 
and nowhere indicated as present. It's just a reservation of GPA space, 
like the PCI hole is as well.

[...]

>>
>> Yes. In this case ms->ram_size == ms->maxram_size and you cannot cold/hotplug any memory devices.
>>
>> See how pc_memory_init() doesn't call machine_memory_devices_init() in that case.
>>
>> That's what the QEMU user asked for when *not* specifying maxmem (e.g., -m 4g).
>>
>> In order to cold/hotplug any memory devices, you have to tell QEMU ahead of time how much memory
>> you are intending to provide using memory devices (DIMM, NVDIMM, virtio-pmem, virtio-mem).
> 
> So that means that when we are actually hot plugging the memory, there is no need to actually perform additional checks. It can be done statically when -mem and -maxmem etc are provided in the command line.

What memory device code does, is find a free location inside the 
reserved GPA space for memory devices. Then, it maps that device at
that location.

[...]

>> /*
>> * The 64bit pci hole starts after "above 4G RAM" and
>> * potentially the space reserved for memory hotplug.
>> */
>>
>> There is the
>> 	ROUND_UP(hole64_start, 1 * GiB);
>> in there that is not really required for the !hole64 case. It
>> shouldn't matter much in practice I think (besides an aligned value
>> showing up in the error message).
>>
>> We could factor out most of that calculation into a
>> separate function, skipping that alignment to make that
>> clearer.
> 
> Yeah this whole memory segmentation is quite complicated and might benefit from a qemu doc or a refactoring.

Absolutely. Do you have time to work on that (including the updated fix?).

-- 
Cheers,

David / dhildenb


