Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D030EBC5340
	for <lists+qemu-devel@lfdr.de>; Wed, 08 Oct 2025 15:29:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6UC3-0001A4-FB; Wed, 08 Oct 2025 09:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v6UBu-00018s-Jw
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 09:26:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v6UBl-00056Q-Ql
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 09:26:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759929993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aDLqXUOcMDBGAPh4sXR++HvZdS1uMNkJ5BjxsfNc1Jk=;
 b=gl0+ysfnQzTXYDI9DOLBA8OlsybQ62VxUaOODji81bXkbDo5zbUI93hu1XLWwF+q3l7Cqd
 7WxIxbGZtDR2KdSOB0niNzmxkZa7JcBmjX47V4Am91pQ3sp4I6+xDFee5aWagFiMfmx8QD
 HUyDmSJtDcZGh9efRDlBptxLdWVzenU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-D7BVJja2MlOy6ItlQnXLhw-1; Wed, 08 Oct 2025 09:26:32 -0400
X-MC-Unique: D7BVJja2MlOy6ItlQnXLhw-1
X-Mimecast-MFC-AGG-ID: D7BVJja2MlOy6ItlQnXLhw_1759929990
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46e407c600eso39378305e9.3
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 06:26:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759929990; x=1760534790;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aDLqXUOcMDBGAPh4sXR++HvZdS1uMNkJ5BjxsfNc1Jk=;
 b=IhVeoZJIfaPjqzwupBsaiEmSEilEMVBJaVkYqJVLijL8tsxU1ltdVgUAqTzYMTYC+7
 m3RKAtbvLF1TBF5nctLO3zkhUFsbAdypfUfyLIQPdXU505bhGsMwOsl1eP3yERML5c5G
 VshiKZ5hi1B8bOjvHGW6IIlh2eGKh9TF3aFnOOudLmM3RydjZe6FHyavg2hKxwXcTq5M
 8iEGm77DZoSqTJ5bwqKJ5WuxhS+BtrruhQQhk07kwWlVDCpAumTRujlQUkEoTe49cn7Q
 FmFnKIpOE0UxjrGp9J67Jz30UF0HOuhaoK1PNfcGH86mwDLIKOBQbxJqbpvmaRYrIFX1
 t3vQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVsLtXFb+7KWaCyksamyGlhyULgsYpL8uq88W/ePvDrfSq5guuUvKB/Vr+PPT/OR0NXoxk/VCOouSM@nongnu.org
X-Gm-Message-State: AOJu0YwyYnPX2XUXbkWdMRhzRQXVvxQYa42IaXVE9zooylwQm2FQ6kXn
 5oG+9UOD2+RWqxvI4gmaJkOr5VNLmuiuRo6n7m9lgV2mJM13ntRfjBWNJmCBbMiMmjexaSxkRV8
 O+P6KyhhVD6t4Fh0vxG+wOaF/qCudo/6ig5cyW2gl40RRkEf3TZgsS+ye
X-Gm-Gg: ASbGncsy3EET1U/Tv3BSO65gwhce/60+lct/mWGKQaRDfPf2vCmfTz2DUhHzI5bHmcq
 0mPc8h4VaTeROMIqUQ/QKkbzsUwp7Um1Pn8MkBkr7iqxvR4zKVBrkkZVAFAzUmzIA1+FFA0wTIs
 +WV9wyLrl7XS8le2bbI7Sh3UrI3G82GfaaYnSDoZEsZS8AZnZaJC3dnSKVYJZwY2CgAFJnbI9np
 WRjQGKNOJLdoK8pY3w52c7IWs44PIg+rLlDUbGOAl6G/yAbREIg33MLVCn5NJ5iJjK6zgGBqLBz
 e5SoMI15CsiUGjb9C3//ZB9XKaT8fvz+VqOYO+iGSB+0tLYLcnc/LCKU5ZGSFetNBOX6ZcnCc3r
 +jQIcLUaR
X-Received: by 2002:a05:600c:138a:b0:45f:2ed1:d1c5 with SMTP id
 5b1f17b1804b1-46fa9b171f2mr22340555e9.36.1759929990153; 
 Wed, 08 Oct 2025 06:26:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKqOaNLGTrFQal3t0kmjix8D9a7gTNLkZO7hxyaAHKm0kkZNLJZ3g2aqrus5synWNzZ4gNbA==
X-Received: by 2002:a05:600c:138a:b0:45f:2ed1:d1c5 with SMTP id
 5b1f17b1804b1-46fa9b171f2mr22340375e9.36.1759929989683; 
 Wed, 08 Oct 2025 06:26:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa9c204fesm37820595e9.13.2025.10.08.06.26.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Oct 2025 06:26:29 -0700 (PDT)
Message-ID: <97a100c7-501b-47c8-9c4e-201e1df6ba41@redhat.com>
Date: Wed, 8 Oct 2025 15:26:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vfio/container: Support unmap all in one ioctl()
To: John Levon <levon@movementarian.org>
Cc: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>
References: <20250924070254.1550014-1-zhenzhong.duan@intel.com>
 <20250924070254.1550014-2-zhenzhong.duan@intel.com>
 <01f0b0eb-b036-4823-8020-fd6962b26d9d@redhat.com>
 <aNxT1w0BbMH6pJ0J@movementarian.org>
 <d715d9dd-a613-4406-93c1-507d1470619f@redhat.com>
 <IA3PR11MB91364A76C06D76B0E6ADBEBD92E1A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <7256274c-ac20-4ef8-9841-48be7bfa2b91@redhat.com>
 <aOZi6zvqp-mAH9Ke@movementarian.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <aOZi6zvqp-mAH9Ke@movementarian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/8/25 15:11, John Levon wrote:
> On Wed, Oct 08, 2025 at 03:01:34PM +0200, Cédric Le Goater wrote:
> 
>>>> Should we introduce a VFIOContainerBase attribute/flag
>>>> 'unmap_all_supported',
>>>> set in the vioc->setup handler ?
>>>
>>> Do you mean to check bcontainer->unmap_all_supported and do the split in vfio_listener_region_del()?
>>>
>>> If only checking it in legacy container, putting it in VFIOLegacyContainer sounds better?
>>
>> It depends if vfio-user needs it too.
> 
> vfio-user always supports this flag.

In that case, putting it in VFIOLegacyContainer sounds better.

Thanks,

C.


