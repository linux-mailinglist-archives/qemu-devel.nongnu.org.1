Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BE3A5CC82
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Mar 2025 18:44:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts3eL-0006fc-Rv; Tue, 11 Mar 2025 13:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ts3eC-0006bD-HN
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 13:44:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ts3e8-0008PF-Nr
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 13:44:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741715040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UplhmdrpLnZ+LADBZAz6hussESX0qnoTiwru/JW6U5g=;
 b=ARhKp7wNIWh3WUgR79ueWFy+sqneAi01elWXPaf+e1If0GHIeZem4PSp9pU3vRyyGwOdkb
 a6Jj7Z/7PZV0BmF1HO2tKGX8KuJdt69w+syM3Uivrw4h6Zmp/tTFgO2btJfZ/jfB5jPEUc
 srZ0CLQtWday40cSaG698iwiSmmbyHA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-QMOeSIeoP82McZY-78YxSw-1; Tue, 11 Mar 2025 13:43:58 -0400
X-MC-Unique: QMOeSIeoP82McZY-78YxSw-1
X-Mimecast-MFC-AGG-ID: QMOeSIeoP82McZY-78YxSw_1741715037
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43bd8fd03a2so28637745e9.3
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 10:43:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741715037; x=1742319837;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UplhmdrpLnZ+LADBZAz6hussESX0qnoTiwru/JW6U5g=;
 b=iuhH++NvAXEJq0OPd/1voXNUw6TOyZgSlQI2wXKU96tYf+ntX4kDTVSaZLYAsPkv3/
 N4thifIjiiH1tlHr99bMQ7c0xBGzhRutRWJYXZxCqbH2bN76scBVndckWdXilL3eSUSI
 KfNn6K4UPa6MriwSEKTWlVaTQe2hIUuJCcORsEhd+vV3aNVOuTwXPrHSScmkwJZZ4rVI
 pwUUnYH8p7zKjTsq/onHoDCDs1jwibJS/etlaqt5fBHyNgSvQHfdLmTDU954nosU/+rX
 58qwQJdLtOHU7qsGz9ikDuQi+vaJajtpMhXNbWOT23wpbxqbJLeAsUbvqhGgh56U1gM7
 wBrg==
X-Gm-Message-State: AOJu0YwyKICDfXU02VN6pc6rNNU/7ipW253CqCfUD7PT9cdvmtKi5NHp
 A6wiynS84WPa/EWCXJ0q38+bjD4hWqU8b+/ABnu8uXzxULH3bzwEcUSX9vTpUDyiAO1junYrSt3
 mhrCZGo/uyMXdhJW0mBX8ja0G38mp9RHLdvCWWGo98oIKFTuwk29F
X-Gm-Gg: ASbGncvIcsBKQkEW4uf1bj8X6pHq+FSPvcMosCqO8ScPIGdOV3EsRwVBJnDDDa6xHdZ
 0pTAXQPJICwqtZhGjm9Spd34bYk3blbrsD0p7E3OIkMJb2siOCXaMN1vMWG9c6Eft0SlVhkQeup
 UA52fjNNbfO1HDIFMlEWiGWTjeqbtOELRjccthqgUeBnSohB8/FWsEhBuGPIxirNrcaaxeenbWY
 9Ba/lkPFJDqNBJo+A968NpKxrQea3E0jA+VmMpIKdB2Xw2nvchlWSksv7OmoL3FQem13mfcMoMz
 aX5xaiv6Wr7LxwkmET49zxkaG+c610sqiZ1pSLXcxqFVrci87JBbKA==
X-Received: by 2002:a05:600c:4c29:b0:43c:eea9:f438 with SMTP id
 5b1f17b1804b1-43ceea9f6a4mr109103285e9.15.1741715036779; 
 Tue, 11 Mar 2025 10:43:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG02VnGZqwgTj6xW6NZ8ougMcQInNdeAoXR1PwDBGl5hLDUFgFi1scPpZ6etSopRcWfv1m6Nw==
X-Received: by 2002:a05:600c:4c29:b0:43c:eea9:f438 with SMTP id
 5b1f17b1804b1-43ceea9f6a4mr109103095e9.15.1741715036367; 
 Tue, 11 Mar 2025 10:43:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cfd5082ccsm60894275e9.32.2025.03.11.10.43.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 10:43:55 -0700 (PDT)
Message-ID: <f2c2d64d-976a-414a-ae5d-8bd0f0ed9bca@redhat.com>
Date: Tue, 11 Mar 2025 18:43:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vfio: Add property documentation
To: Joao Martins <joao.m.martins@oracle.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>
Cc: qemu-devel@nongnu.org, Tony Krowiak <akrowiak@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Eric Auger <eric.auger@redhat.com>,
 tomitamoeko@gmail.com, corvin.koehne@gmail.com
References: <20250213135050.1426258-1-clg@redhat.com>
 <20250213144513.32b3241f.alex.williamson@redhat.com>
 <995ef2ed-a5e0-469e-b780-6800f26d7b22@redhat.com>
 <6985a62f-a091-4087-887c-361570170ef6@oracle.com>
 <8ac4f034-3e68-4c8a-9a63-9eeacc0de113@redhat.com>
 <0d6e9836-328f-463d-9db4-c7fa57196781@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <0d6e9836-328f-463d-9db4-c7fa57196781@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 3/11/25 17:44, Joao Martins wrote:
> On 05/03/2025 13:13, Cédric Le Goater wrote:
>> Joao,
>>
>> On 3/5/25 12:16, Joao Martins wrote:
>>> On 14/02/2025 13:05, Cédric Le Goater wrote:
>>>> +Kirti
>>>> +Joao
>>>>
>>>> On 2/13/25 22:45, Alex Williamson wrote:
>>>>>> +
>>>>>> +    /*
>>>>>> +     * Migration support
>>>>>> +     */
>>>>>> +    object_class_property_set_description(klass, /* 5.2 */
>>>>>> +                                          "x-pre-copy-dirty-page-tracking",
>>>>>> +                                          "Disable dirty pages tracking
>>>>>> during iterative phase");
>>>>>> +    object_class_property_set_description(klass, /* 9.1 */
>>>>>> +                                          "x-device-dirty-page-tracking",
>>>>>> +                                          "Disable device dirty page
>>>>>> tracking and use container-based dirty page tracking");
>>>>> These are really debug as well, right?  They just happen to be
>>>>> migration related debug.
>>>>
>>>> I suppose so. I would rather keep them under the migration topic
>>>> and add 'debug' in the comment.
>>>>
>>>> Changes :
>>>>
>>>>     commit bb0990d1740f ("vfio: Change default dirty pages tracking behavior
>>>> during migration")
>>>>     commit 30b916778517 ("vfio/common: Allow disabling device dirty page
>>>> tracking")
>>>>
>>>> do not explicitly explain why these properties are useful in any way.
>>>>
>>>> Kirti, Joao, could you ?
>>>
>>> Sorry for the extreme delay but I was out travelling for the past 3 weeks for
>>> vacation and work.
>>>
>>> The property is marked as x- but my intent was both debug/testing and to have
>>> something that allows me to select the dirty tracker between device vs platform
>>> dirty tracker if something is wrong with say VF dirty tracker or if there's some
>>> limitations around it. These days we actually use it a lot as my default to have
>>> IOMMU dirty tracker in use. I wouldn't label it exclusively as '(debug)' just
>>> yet.
>>>
>>> The precopy option might be to avoid dirty tracking at all and it's generally
>>> useful when you don't have dirty tracking at all or say snapshots or 'offline
>>> migration'. But I have never seen real use of it, or need for that matter,
>>> except the early days of VFIO migration during testing.
>>
>> Could you please send a patch on top of :
>>
>>    https://lore.kernel.org/qemu-devel/20250217173455.449983-1-clg@redhat.com/
>>
>> This would be great to keep the information in the git history.
> 
> I'll send a patch shortly.

I am about to send a last PR. I will check in the evening
for your update.

Thanks,

C.


