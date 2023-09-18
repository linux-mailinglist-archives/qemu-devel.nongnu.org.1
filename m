Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 730F97A4607
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 11:34:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiAcz-0002A4-OR; Mon, 18 Sep 2023 05:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qiAcw-00029s-EP
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 05:33:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qiAcu-0007Dw-8K
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 05:33:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695029586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1snege78b3nw/XSwYTI9OEIb9u3vnnDTsCVErpGrcG4=;
 b=dRzSRMQBRiCtyoCs0q74XIKL61yBUCq5lZsO+kEHIQbBHR7onieqq3hUazK9T+Xoi1bEmo
 vODtVq/Akys+jEe9WUheIv4eEj4metJZW5j5tyOeiUv0u7Co7dDy2CEZ603N9CO237wbJj
 BMGzn+TWMlPU82Z6Bv0whpv0+dYpjf0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-tgK5dNSRP7u3soFOO9a3HA-1; Mon, 18 Sep 2023 05:33:04 -0400
X-MC-Unique: tgK5dNSRP7u3soFOO9a3HA-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-502aafb8ae7so4822316e87.1
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 02:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695029582; x=1695634382;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1snege78b3nw/XSwYTI9OEIb9u3vnnDTsCVErpGrcG4=;
 b=NP6Q0LpypSP0Ccw81+voryVkRWdvCMxXawTqmL0Aupmpqr5oeqq6H3iH4DJhQQPOSt
 TRIz8kdtyGhkvLyknFFfKCnuF/YVEjk85wDwNPdRmeAficjSrfGG+LT4DrStA3lXDGlh
 /lxuGUmgdpLTMWMNENCSv4s9CZdk281qlXFWSZgwrCDKp0qTrLLAoQuLDN61mKLfcm2A
 WLPID349sV40hHrFW8kuaIKOYDiFtyh14ow859hkZVHvOJ/V4woDnezgk94SHi/RnZej
 Z8M0Dtg3cuthAhtnMoq2jPUIE1B934tnkgI18kQvw/B4GXOTSefmhFOuAt3wk/JLmjWk
 MtSA==
X-Gm-Message-State: AOJu0Yzgh3aH8UE0HnxoVumNihIlTu6hJwWsfmMSGq8bPzvqFb4yjtRd
 rOCrkmaJnNLLH38npVsT0PvAXhGmApKIZCTupNPqyWz0+6JOjR7njpQVXoo8n+txoKM++goSHZl
 x4ql1zEYNEExTvU8=
X-Received: by 2002:a05:6512:2118:b0:4fe:551:3d3c with SMTP id
 q24-20020a056512211800b004fe05513d3cmr6583993lfr.36.1695029582392; 
 Mon, 18 Sep 2023 02:33:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlZIUpISF/qLiqsWL11Gz79YyG7SgvMUd/qib/XRAzNZx8qHwyHuIKcUShrNM219TudT5GOw==
X-Received: by 2002:a05:6512:2118:b0:4fe:551:3d3c with SMTP id
 q24-20020a056512211800b004fe05513d3cmr6583976lfr.36.1695029581950; 
 Mon, 18 Sep 2023 02:33:01 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:3400:ec51:7a3a:274e:cbee?
 (p200300cbc74b3400ec517a3a274ecbee.dip0.t-ipconnect.de.
 [2003:cb:c74b:3400:ec51:7a3a:274e:cbee])
 by smtp.gmail.com with ESMTPSA id
 g13-20020a7bc4cd000000b003fc02e8ea68sm14760581wmk.13.2023.09.18.02.33.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Sep 2023 02:33:01 -0700 (PDT)
Message-ID: <143a437c-be99-d6d8-732f-e9544e2d9b35@redhat.com>
Date: Mon, 18 Sep 2023 11:33:00 +0200
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
 <e052a3c4-33e9-1d75-dc9b-3c64f8ae777b@redhat.com>
 <41A3B19D-87B7-4FD6-A5C7-17D758B2DB37@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <41A3B19D-87B7-4FD6-A5C7-17D758B2DB37@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

>>
>>>> /*
>>>> * The 64bit pci hole starts after "above 4G RAM" and
>>>> * potentially the space reserved for memory hotplug.
>>>> */
>>>>
>>>> There is the
>>>> 	ROUND_UP(hole64_start, 1 * GiB);
>>>> in there that is not really required for the !hole64 case. It
>>>> shouldn't matter much in practice I think (besides an aligned value
>>>> showing up in the error message).
>>>>
>>>> We could factor out most of that calculation into a
>>>> separate function, skipping that alignment to make that
>>>> clearer.
>>> Yeah this whole memory segmentation is quite complicated and might benefit from a qemu doc or a refactoring.
>>
>> Absolutely. Do you have time to work on that (including the updated fix?).
> 
> Other than the fix you proposed I am not sure if we need to fix anything else atm. Seems physical address space bound checks are already in place.
> Re: doc, maybe. I will add it to my TODO list.

Will you send a proper patch, ideally not using pc_pci_hole64_start() 
but instead the same logic without the final alignment to 1 GiB?

I can also do it, but might take a bit longer.

-- 
Cheers,

David / dhildenb


