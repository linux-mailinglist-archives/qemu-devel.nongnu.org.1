Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D49097A47B1
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 12:58:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiBxV-0008M4-CI; Mon, 18 Sep 2023 06:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qiBxL-0008LV-WD
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:58:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qiBxK-00017s-CV
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:58:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695034697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C2P3H/IMntUh1Fl5waVX1IosOhFs5bNVhqpvbxMY870=;
 b=J0lQUoLil71gqUluG+50A3pJAT7MnNAiW1q7cAGYR2Dp75H+E3lPETfGs+PjSiwKKm7fi4
 opYEVTvWRQRzsKGWu1gISwqlB8Q/AWq1HedsV5InNVJUX90Wj4mWDdsfT8o7Uq6qTFZCrn
 NkWgRm9ZLxMWVVOnaHNv+DIAp1XmCm0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-fKQS_W-4Nkm4X0cMvY-qyA-1; Mon, 18 Sep 2023 06:58:16 -0400
X-MC-Unique: fKQS_W-4Nkm4X0cMvY-qyA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40474e7323dso29085815e9.2
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 03:58:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695034695; x=1695639495;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C2P3H/IMntUh1Fl5waVX1IosOhFs5bNVhqpvbxMY870=;
 b=LHSf6VJgsmPSiFeVvip9L/qgMy7DZ4gys7rJqZIX8rM13hd+moROZfZ8Jna0dFhmtE
 pCTZ66YoWXtGaiPg+10D+pxI7q4xcmT4scCwjM945lztk/lnYTMQCdampNdalFrqqKhC
 wVb9+AVNIo7DXKvqgRfKeBHOHj4qKQvmMMmaBG+E51kyBCK6/cZ65qzZIgVae0YFVF1T
 Vbb/mm+0bMawXL+wD2iqqwD2Ok9hshPdcrfyDLXlrgiXhalQPq8JNr1BUcnwBWgQz5jg
 I7/XcOZ92zcvpjHvTt4S+U/MbTUOG1aiRVOXVWIzGAjCE07eD/Z7aDB4xvv4EuCKedDN
 yUAA==
X-Gm-Message-State: AOJu0YxmhX/cVNOMP6wimL4n1SA2a1m3Mq8JZMLyGO5Tzz9xXLR9t+Tr
 vvzsnwosFY2V963e8K0/pZbJxot5zE83cshNnf0caLEK0r4VDphtpRivnlJtQZL2rvWe/xoyAmV
 LvM66TKjDhaHRmgI=
X-Received: by 2002:a7b:ca48:0:b0:401:38dc:8917 with SMTP id
 m8-20020a7bca48000000b0040138dc8917mr7401098wml.6.1695034695165; 
 Mon, 18 Sep 2023 03:58:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGL8eoRiTOvMHub/jLs5wslGQd5O92Jn5Y+uh0f9AJPySPttldff81vJ3LXdWL91dj76QjlDw==
X-Received: by 2002:a7b:ca48:0:b0:401:38dc:8917 with SMTP id
 m8-20020a7bca48000000b0040138dc8917mr7401085wml.6.1695034694758; 
 Mon, 18 Sep 2023 03:58:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:3400:ec51:7a3a:274e:cbee?
 (p200300cbc74b3400ec517a3a274ecbee.dip0.t-ipconnect.de.
 [2003:cb:c74b:3400:ec51:7a3a:274e:cbee])
 by smtp.gmail.com with ESMTPSA id
 i9-20020a05600c290900b00401b242e2e6sm15030764wmd.47.2023.09.18.03.58.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Sep 2023 03:58:14 -0700 (PDT)
Message-ID: <cce0cebd-952f-9ed9-f2fd-d84dd666d322@redhat.com>
Date: Mon, 18 Sep 2023 12:58:13 +0200
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
 <1911B17C-24F2-406B-9ED4-DCF98E794A09@redhat.com>
 <730648ed-55ac-aa2c-58d2-d79224aeb586@redhat.com>
 <1574DF3A-7E1F-4C4F-9087-6E8DEE456906@redhat.com>
 <6cbca7b9-381b-6268-27f0-d7ea1c5ed1bd@redhat.com>
 <3A287C52-F547-4494-B803-8CFC50CBA175@redhat.com>
 <30f0ddfb-6eb7-84a5-04a0-e11905451733@redhat.com>
 <A354B36D-A86E-48D9-B8B6-DC35D8976410@redhat.com>
 <34403090-b4b3-990f-7723-1d56d8053bd5@redhat.com>
 <08530A80-90F3-4E33-9B1A-E71A66726123@redhat.com>
 <e052a3c4-33e9-1d75-dc9b-3c64f8ae777b@redhat.com>
 <41A3B19D-87B7-4FD6-A5C7-17D758B2DB37@redhat.com>
 <143a437c-be99-d6d8-732f-e9544e2d9b35@redhat.com>
 <CAK3XEhOQCudb0VsBHFfubbcRredLMuSQCTA6fhbg99f7W9y5PA@mail.gmail.com>
 <8af5fb9f-83dc-f997-e761-f8e69f9515ac@redhat.com>
 <CAK3XEhMTSP7TkJgKX1_VxUVxaoU1jX8d_i-0H4t=bNktY5wo5g@mail.gmail.com>
 <5b22fff5-270f-0ab5-1ee5-2e54f491aefd@redhat.com>
 <CAK3XEhMf88si5NcQbAODRC+7760ymgFOx83a_ih4jOqoaDDcyg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAK3XEhMf88si5NcQbAODRC+7760ymgFOx83a_ih4jOqoaDDcyg@mail.gmail.com>
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

On 18.09.23 12:54, Ani Sinha wrote:
> On Mon, Sep 18, 2023 at 3:49 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 18.09.23 12:11, Ani Sinha wrote:
>>
>>>
>>>      Ok hopefully my last question. I am still confused on something.
>>>      Does the above mean that the hole64 will actually start from an
>>>      address that is beyond maxram? Like basically if you added all of
>>>      ram_below_4G, ram_above_4G, hot plug_mem and pci_hole64 then can it
>>>      exceed maxram? I think it will. Does this not an issue?
>>
>> If you'd have a 2 GiB VM, the device memory region and hole64 would
>> always be placed >= 4 GiB address, yes.
>>
>> As maxram is just a size, and not a PFN, I don't think there is any
>> issue with that.
> 
> So this is all just a scheme to decide what to place where with maxram
> amount of memory available. When the processor needs to access the

Yes. ram_size and maxram_size are only used to create the memory layout.

> memory mapped PCI device, its simply dynamically mapped to the
> available physical ram. Is my understanding correct here?

I'm no expert on that, but from my understanding that's what the 
pci/pci64 hole is for -- mapping PCI BARs into these areas, such that 
they don't conflict with actual guest RAM. That's why we still account 
these "holes" as valid GFN that could be used+accessed by the VM once a 
PCI BAR gets mapped in there.

-- 
Cheers,

David / dhildenb


