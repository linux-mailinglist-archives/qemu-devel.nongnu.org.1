Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66660AE04E6
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Jun 2025 14:04:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSDzl-0003tP-5b; Thu, 19 Jun 2025 08:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uSDzh-0003sF-P9
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 08:03:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uSDzf-0007Ay-FL
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 08:03:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750334623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hxJ7c6rfjk7ckMx6mIO5aYSeHAS+lHiSa3VjTj6hi/A=;
 b=CrI/NY7LIjY8E3L1Fm5u0RQHGS3ERTLVIgmWbaFPKWEe+dlICmTwY13L8Tmh5L2zJj2BBs
 RHa38tntdXFMioK2/Z8vaZQqHS7e7bt4RjxA0zt8vrZGHzBM2HORrDG4v8wsNbodzS/8i2
 RLBv0dFYXbyZg0oN5/yc+pirIuCkBkI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-25k2DgpDPjerD457k-e3-w-1; Thu, 19 Jun 2025 08:03:41 -0400
X-MC-Unique: 25k2DgpDPjerD457k-e3-w-1
X-Mimecast-MFC-AGG-ID: 25k2DgpDPjerD457k-e3-w_1750334621
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4f8192e2cso396697f8f.3
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 05:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750334620; x=1750939420;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hxJ7c6rfjk7ckMx6mIO5aYSeHAS+lHiSa3VjTj6hi/A=;
 b=lChuhOzV5H9RGDAPQ3Hh27OPUuAqKtR3fon6vYdmct58dCGNLHBZo75F1Gbip3sr7s
 dzyAboOsiEo6acyuGqOc5I1/qD78zVvsrNajdvpXpwbWSux3L73rL6793+w2S88uX8r7
 0ltYEdhSckZp6uk0x38/52897LZkhdnAb7rLFVCENAwqlmL8fheCL+nPn0RdN1w6oi9B
 bgDx/U6+oMnaAVJAzXuA05I3Zy7+/l2mBLR4KosOReBLBd+HI/TCJL1smJPa+KGkdME6
 9LkO4u3B0kjA/1/3xeFJeZhJCS50+FcSZEmrwpOWlFKKw9QqHlhUFmXB/efu37oJqBNa
 itRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoA+EVSr1e3jgnru3oCQBz9UPMYrEgSt3kK0dOvfqPvhP4Vc1dSvuOuA0MHfGB8JieCvLecnTFqZI2@nongnu.org
X-Gm-Message-State: AOJu0YxAJCF4AezBNJujSugQXZcadMyIv2Upsi4Ytb9ZHdCCqOKsHupA
 /EK31L6Gsfce0a90KDBIGmxg3jREZmTcrJJHmmV4PNCawC3PCHkuFArp0wTENa5H3XmQXfWowrb
 Pfz3vZQz4W3XCXvRe+WNawYtdI7SLECn7lWKulNAsuX2ZHzmWWpsvErj2
X-Gm-Gg: ASbGncsFLiSmPIe8kyzDrgrMq0ahRwAcUm48SjrRemfG3eVU/lfUZBBdM6MK1UxVGxL
 te4H9uoF510IKkf6HfSfXWRxN5FSkfHxFi9ynUuN0Q+xbKYxCaxYDqGDgJiLIN1mxmdFAbtx0yG
 oHFqTNzblh8N5ewm8d4aiGJmxEVj5ft8GvXY4HfIRTt4MtrlaKhM49xH/Lu+pQNZvh71W+aSfIR
 QT+kFRLAtjVlYpSYdx8tIDGdP9z20tEI8Oqiv2DV5MI8VHJdWaNEbnj7lb/4j2xT5U0yv5PQds6
 FKG8eEj3lBnQcPXG/JxtGrvo46YXQ4GzQngvjwv/UaHu5UtFPOo+1jJ7iguu
X-Received: by 2002:a05:6000:26c3:b0:3a4:d6ed:8e2e with SMTP id
 ffacd0b85a97d-3a5723af885mr15762224f8f.41.1750334620554; 
 Thu, 19 Jun 2025 05:03:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESQ4wP3xf/Eyi+oRekqFhiHj4NsAL1/v+TSoizJuSwO4dbFYsBToVu9PP77VzZCGRFT/zozA==
X-Received: by 2002:a05:6000:26c3:b0:3a4:d6ed:8e2e with SMTP id
 ffacd0b85a97d-3a5723af885mr15762186f8f.41.1750334620083; 
 Thu, 19 Jun 2025 05:03:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535ebcecdcsm26207985e9.36.2025.06.19.05.03.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Jun 2025 05:03:39 -0700 (PDT)
Message-ID: <d2cd7680-ff63-4baa-bda4-05d58bd263db@redhat.com>
Date: Thu, 19 Jun 2025 14:03:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 00/38] Live update: vfio and iommufd
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <0330df5e-8a9d-4fdf-bee8-a864eedac24d@redhat.com>
 <effe22b4-c6e4-41c2-b3e2-d03160560f86@redhat.com>
 <b6e11593-cd1b-4d51-9c17-37ccefccd094@redhat.com>
 <573aa339-1c40-43b4-997d-c3e4996caaec@oracle.com>
 <c95a3209-7517-4d70-b7a1-2aab1202f601@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <c95a3209-7517-4d70-b7a1-2aab1202f601@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Zhenzhong, Eric,

On 6/12/25 09:23, Cédric Le Goater wrote:
> On 6/11/25 16:39, Steven Sistare wrote:
>> On 6/11/2025 10:25 AM, Cédric Le Goater wrote:
>>> On 6/10/25 19:39, Cédric Le Goater wrote:
>>>>> Steve,
>>>>>
>>>>> For the next vfio PR, I plan to take patches 1-17 when patch 10 is
>>>>> updated. The rest is for later in this cycle
>>>>
>>>> Applied 1-17 to vfio-next. Waiting for an Ack from Michael.
>>>
>>> I am planing to send a PR with this first part to get more visibility.
>>> There is a slight risk of merging useless changes since CPR is not
>>> fully reviewed. My optimistic nature tells me it should reach QEMU 10.1
>>> and we have time to adjust.
>>>
>>> Please feel free to intervene if you prefer the series to be fully
>>> approved/reviewed before merging.
>>
>> A partial merge is fine with me.
> 
> 
> Now merged. I am waiting for some feedback on the IOMMUFD part.

Would you have some time in June to take a look ?

Thanks,

C.



