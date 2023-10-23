Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A45AC7D3361
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 13:29:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qut6m-0006Pd-6f; Mon, 23 Oct 2023 07:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qut6i-0006PS-3K
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 07:28:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qut6f-000310-9U
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 07:28:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698060503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UWYRoKQpeVkRqjA3jjgCSWqlqo+W3Js+e+XRJdIdjpA=;
 b=QOqvcK+8/0P7zxtU13YLvddi9TxbLZ2RuGgY83K/i8K4wbqxIFKQfoDp29N6LKmeqIdOF/
 DKKCg+q4cVZQdIF7SQylr+rksrWhnaZCKctEcpVI8rgKH1XUSZmrxU5krNfeNsyxsRasds
 WcmE5Jw0C/LCrDF6pnv2ycoBx6TOip4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-qfjroTaWPeeglhkxH2l6LA-1; Mon, 23 Oct 2023 07:28:22 -0400
X-MC-Unique: qfjroTaWPeeglhkxH2l6LA-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-66d12cd3591so38053806d6.3
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 04:28:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698060501; x=1698665301;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UWYRoKQpeVkRqjA3jjgCSWqlqo+W3Js+e+XRJdIdjpA=;
 b=Tcp/OV0ITlX1AgkSRIUCPEOb69oH25x+1gLxdgMBY5D2ZssC8R9ziR2UJtYC3vuyen
 Y2lRuv6lTaEru4/WMdeCnTdZsl6jcrEG0/0P8lo0n00JXR0xvd4sUI7y49FtkUEUOisq
 qUzxrU8yZkTPfoJXds56Q1YQLJ+j+95rHakaAr10bEjk25qDRDGPRTc6H73hKukAK1WU
 23lE0TU2kCRrrra6Q3KT6eOrc77HxcmzNdSKoQsH+zvP9QHB+7loRCBczhjptTV3sozp
 dSq+MbCk0Jcd0tfR8qEQeNDBLAPSkc3G1D3LEkAytzpxC/xrEA7Ll4yA9RArbMn0dxY0
 C7kg==
X-Gm-Message-State: AOJu0Yysygq8pBq+0Wfou7JFqyxtaJQQHN4I8iYeA3kLPv5DwTglDa0u
 j1Z9xZSibrFW0rYEOfw6WdDwcSVT75CmMkZ3JOaWkv5KkSVE0ARRMETaxR/7Y2rSRzVDAebKn1i
 jwT9+yg8nrKGFv6E=
X-Received: by 2002:a05:6214:3008:b0:66d:bbfb:839b with SMTP id
 ke8-20020a056214300800b0066dbbfb839bmr1302547qvb.41.1698060501403; 
 Mon, 23 Oct 2023 04:28:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEi6Krd2qjm9xb7OKzlJhLBaBc/5XLjOsc2Dnk4zguQmj/xj/b5Y7d9cod4++WH45za+n3myA==
X-Received: by 2002:a05:6214:3008:b0:66d:bbfb:839b with SMTP id
 ke8-20020a056214300800b0066dbbfb839bmr1302529qvb.41.1698060500988; 
 Mon, 23 Oct 2023 04:28:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:b215:e40:e078:4b27?
 ([2a01:e0a:9e2:9000:b215:e40:e078:4b27])
 by smtp.gmail.com with ESMTPSA id
 u8-20020a0562140b0800b0066d11e63ba1sm2811773qvj.5.2023.10.23.04.28.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Oct 2023 04:28:20 -0700 (PDT)
Message-ID: <6225270f-0925-4148-900e-31d6595a5849@redhat.com>
Date: Mon, 23 Oct 2023 13:28:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] igb: Add Function Level Reset to PF and VF
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>
References: <20230829090529.184438-1-clg@kaod.org>
 <20230829090529.184438-3-clg@kaod.org>
 <CACGkMEu6nznVGTyk8gjrZ3jE=bEAd2bDDi9PPwjDKNFkXnVhSQ@mail.gmail.com>
 <d9df1c95-f681-4962-be74-671cef90e908@redhat.com>
 <b744bd42-0b46-44ce-8d60-28d4d31427e0@redhat.com>
 <CACGkMEtbsVCAUFe6AomYe3EO=iBOXze6vJ20c8p0AbsXogocCw@mail.gmail.com>
 <0ba67ce3-ce96-4ac0-9941-9f3cb6321145@daynix.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <0ba67ce3-ce96-4ac0-9941-9f3cb6321145@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/23/23 12:57, Akihiko Odaki wrote:
> On 2023/10/23 12:11, Jason Wang wrote:
>> On Fri, Oct 20, 2023 at 5:41 PM Cédric Le Goater <clg@redhat.com> wrote:
>>>
>>> On 10/20/23 09:40, Cédric Le Goater wrote:
>>>> On 10/20/23 06:24, Jason Wang wrote:
>>>>> On Tue, Aug 29, 2023 at 5:06 PM Cédric Le Goater <clg@kaod.org> wrote:
>>>>>>
>>>>>> From: Cédric Le Goater <clg@redhat.com>
>>>>>>
>>>>>> The Intel 82576EB GbE Controller say that the Physical and Virtual
>>>>>> Functions support Function Level Reset. Add the capability to each
>>>>>> device model.
>>>>>>
>>>>>
>>>>> Do we need to do migration compatibility for this?
>>>>
>>>> Yes. it does. the config space is now different.
>>>
>>> Jason,
>>>
>>> To avoid an extra compat property, would it be ok to let the VF peek into
>>> the PF capabilities to set FLR or not ? Something like below.
>>
>> I might be wrong, but it looks to me it's still a behaviour change?
> 
> I think it's fine as long as the FLR capability of the PF is initialized with a compat property; there is no need of another property for the VFs.

Yes. I wasn't clear enough in the statement above. I am trying to
avoid *2* compat properties, one in each model.

We could also check the PF property in the VF. I think this better.
I will send a v2.

Thanks,

C.



