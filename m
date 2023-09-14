Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4F97A058F
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 15:27:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgmMu-0000jg-Mz; Thu, 14 Sep 2023 09:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qgmMm-0000ii-GT
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 09:26:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qgmMk-0002Ml-ML
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 09:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694698001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z8sdgAWO/TNc29sLG7+b1GfNQJO7VLFCsAR98kIxrPY=;
 b=DuGykrI9881j27z1aHxmnm97LBZq3mBOaA7n9rjZ073ItIFAPMj9lwkq/KwdAc7Y+nCHJT
 N95LjAjD++57aAi6RQfluUf0yRe8Btregs4pt6ZDsABj5otNyywOllNKoiTBOY6jAjamAX
 71Cf1uwOf7XbSh0u58f/tx+lCpfFVDY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-aGdmgN5HPJOUBBH-vg2M0g-1; Thu, 14 Sep 2023 09:26:40 -0400
X-MC-Unique: aGdmgN5HPJOUBBH-vg2M0g-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f42bcef2acso7311635e9.2
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 06:26:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694697999; x=1695302799;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z8sdgAWO/TNc29sLG7+b1GfNQJO7VLFCsAR98kIxrPY=;
 b=rpxUiDY9eocF/m5BIFyXUzM1nhBkyKJvylQyzbsungwe3IBtHBvLHHNXm4vqG6jx7H
 j6PQC2odyvXvB+m0HTC3ZOlIUySrinWun8lim6OaFqLRe6QUmPxuuxXfP8tcUTS+oJKP
 9a9UpDgd4SA1F2DoWo3nYCAe1sOczkM51RPVlI5jBhxclswkNaiIdLD24A6OCkt1odWp
 aIoIeCN2A1N2ZZAzsTUjfJEwIuHMMQef4dgRr4cCax4cAEsTw74w7dp8xJNprjiIxETP
 mwXy7ei2Sgk7wQ+bKMqMqOcwHg6PRiSJDGoTun6NS4L6ppl03VWWdlm0rIAqXCy6514A
 F3HA==
X-Gm-Message-State: AOJu0YztAWuHv+g5P+R5X8kqf6FcitktYpW6rv+F7A9j70W3qifzwU76
 m6zb3xbO8g/aO/xz5kMJD8Qjfb8aca2QPqWZJMd9sdj7MHRLbb+HsF+DdkZFvK8DzrdIEe/UHiR
 4iFRFsq7tD7AlOIc=
X-Received: by 2002:a7b:c414:0:b0:3fe:22a9:907 with SMTP id
 k20-20020a7bc414000000b003fe22a90907mr5051915wmi.20.1694697999295; 
 Thu, 14 Sep 2023 06:26:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbh0T0X+yrqq4FcaY2pX7xzKrQcqe15Z+3IOBSp7j789JloxBnDig7VyzsO86HSIVYEoSR1g==
X-Received: by 2002:a7b:c414:0:b0:3fe:22a9:907 with SMTP id
 k20-20020a7bc414000000b003fe22a90907mr5051891wmi.20.1694697998914; 
 Thu, 14 Sep 2023 06:26:38 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7?
 ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
 by smtp.gmail.com with ESMTPSA id
 x7-20020a05600c2d0700b00404719b05b5sm1535055wmf.27.2023.09.14.06.26.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Sep 2023 06:26:38 -0700 (PDT)
Message-ID: <dd2b9190-c748-0ae2-b9de-8842e6e758e2@redhat.com>
Date: Thu, 14 Sep 2023 15:26:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: lixianglai <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Cc: Salil Mehta <salil.mehta@opnsrc.net>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Peter Xu <peterx@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>
References: <cover.1694433326.git.lixianglai@loongson.cn>
 <3a4fc2a3df4b767c3c296a7da3bc15ca9c251316.1694433326.git.lixianglai@loongson.cn>
 <43f04ba4-3e16-ea5c-a212-66dda73a76c4@redhat.com>
 <20eb8316-22a2-c812-7172-6bd9016877cc@loongson.cn>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 04/10] Introduce the CPU address space destruction
 function
In-Reply-To: <20eb8316-22a2-c812-7172-6bd9016877cc@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 14.09.23 15:00, lixianglai wrote:
> Hi David:

Hi!

> 
>> On 12.09.23 04:11, xianglai li wrote:
>>> Introduce new function to destroy CPU address space resources
>>> for cpu hot-(un)plug.
>>>
>> How do other archs handle that? Or how are they able to get away
>> without destroying?
>>
> They do not remove the cpu address space, taking the X86 architecture as
> an example:
> 
> 1.Start the x86 VM:
> 
> ./qemu-system-x86_64 \
> -machine q35  \
> -cpu Broadwell-IBRS \
> -smp 1,maxcpus=100,sockets=100,cores=1,threads=1 \
> -m 4G \
> -drive file=~/anolis-8.8.qcow2  \
> -serial stdio   \
> -monitor telnet:localhost:4498,server,nowait   \
> -nographic
> 
> 2.Connect the qemu monitor
> 
> telnet 127.0.0.1 4498
> 
> info mtree
> 
> address-space: cpu-memory-0
> address-space: memory
>     0000000000000000-ffffffffffffffff (prio 0, i/o): system
>       0000000000000000-000000007fffffff (prio 0, ram): alias ram-below-4g
> @pc.ram 0000000000000000-000000007fffffff
>       0000000000000000-ffffffffffffffff (prio -1, i/o): pci
>         00000000000a0000-00000000000bffff (prio 1, i/o): vga-lowmem
> 
> 3.Perform cpu hot swap int qemu monitor
> 
> device_add
> Broadwell-IBRS-x86_64-cpu,socket-id=1,core-id=0,thread-id=0,id=cpu1
> device_del cpu1
> 

Hm, doesn't seem to work for me on upstream QEMU for some reason: 
"Error: acpi: device unplug request for not supported device type: 
Broadwell-IBRS-x86_64-cpu"

What happens if you re-add that CPU? Will we reuse the previous address 
space?

> info mtree
> 
> address-space: cpu-memory-0
> address-space: cpu-memory-1
> address-space: memory
>     0000000000000000-ffffffffffffffff (prio 0, i/o): system
>       0000000000000000-000000007fffffff (prio 0, ram): alias ram-below-4g
> @pc.ram 0000000000000000-000000007fffffff
>       0000000000000000-ffffffffffffffff (prio -1, i/o): pci
>         00000000000a0000-00000000000bffff (prio 1, i/o): vga-lowmem
> 
> 
>   From the above test, you can see whether the address space of cpu1 is
> residual after a cpu hot swap, and whether it is reasonable?


Probably we should teach other archs to destroy that address space as well.

Can we do that from the core, instead of having to do that in each CPU 
unrealize function?

-- 
Cheers,

David / dhildenb


