Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34650BC51D5
	for <lists+qemu-devel@lfdr.de>; Wed, 08 Oct 2025 15:04:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6To1-0000nJ-Sf; Wed, 08 Oct 2025 09:02:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v6Tnu-0000n5-Cz
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 09:02:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v6Tnm-0001ra-BL
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 09:02:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759928504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kOpkBzIvtEM9bNYBG28sJbm1wAKG2e7MnfI+0uaL1Oo=;
 b=cNqoXbVVp3rrO4qD8t1Zc9astmeyYnG2ShAolFM5pnUCrBREjTA09C424EL4KjyhOLA7gY
 ZtH6UifEsyxLNNiMKvcQeDwM5P5+vX5QRnlg2+PdOZySuFIzq+eAY7Jv/SSLqkya/mt+DX
 IdE/bKFMeAvyNBr7yvxc6W6fwz7SEmc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-MgbUXIvMOD6OLh1fqjJaWA-1; Wed, 08 Oct 2025 09:01:41 -0400
X-MC-Unique: MgbUXIvMOD6OLh1fqjJaWA-1
X-Mimecast-MFC-AGG-ID: MgbUXIvMOD6OLh1fqjJaWA_1759928500
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e3d43bbc7so29223945e9.2
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 06:01:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759928500; x=1760533300;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kOpkBzIvtEM9bNYBG28sJbm1wAKG2e7MnfI+0uaL1Oo=;
 b=NGQGHEbmsjEyuXQ5RmwQHyaUX1hRw9vQ1mXY8vSMuBHgjziIOvTe23S3vUNL3ATEP8
 9PgdbMHEbklKDmIF0slMKslRBZ772y06xIxkNQHLD4TztJ43uJZWND7C6Y/4b+TiCl8p
 m8O2z6sXwH4irZPRYVDqB5BIwG0fbKncox15SPH5qrqZBJQmJA4bZyan9Khtfy5D5WPE
 YuFsCXgGmHrEidZgNW67LQwuY8L7rFSMV58fs42Kcf4yob1ExFJ5Rotrknv2ozhDYKfy
 7+pOR2k9UYpVrf7f26EeIOEDn1S7VHvFueGRlAqtRbmT1z+d+aGDXNnT2Vf//yQGUYCx
 BMGA==
X-Gm-Message-State: AOJu0YzA/JBNh5UKXot5zdDQjA1uhWQTqB+NpMLNBu5jc3hJlk3toqAw
 muwLtLsx5zSL74DKWL2XzwvVHJSbdp88Os6pUQxDuy+Ndx7/CDMeGtJd9sZr/OxaXJEjMtn7Svi
 Pb8++5CwW6SVPZhxy5UvdQwPaZWcEZcQi9csricSYDDe71Bkse4lk618Y
X-Gm-Gg: ASbGnct7pc+fwkQONqaA/V7T0TB8CDdIm+9bdJlm6HpzAUjUJrKEuuc+O37J/4tV5p/
 gDzP4ddQdHQs/HN2Q+bSGq6BetFmBNEmECeYXhuwZFNBh3AaFmnZ+mEMjO4Yj4PV37/BD7yEZ+y
 4HYBvg5IW64HIRMhWGiYTEvoSW4lEMW4KXDTWBk88IfQBn2arW6rVTrC69GkEUBxShua5VRQSPv
 PlqPqi8ysDtwx+n2fstwsGQWsSnKEobHMUup/HjWABTxXOcNd+OaCspBnzJMQl2uKvq245TaM9G
 NHIScpjzbVT/z/SellrM4WPhnTFZ9ZqAb8m90przv2wDJSPzbpfHSnqfvgFUeGQe1xx/ZNTc+4R
 tNfdIwmEN
X-Received: by 2002:a05:6000:40de:b0:3ea:e0fd:290a with SMTP id
 ffacd0b85a97d-42666ab2843mr1880261f8f.12.1759928498813; 
 Wed, 08 Oct 2025 06:01:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYVZiS2oHt94YQ2Ce2q/KaOpKWv0ktuxTiOiLMqPP4cmRc/okePPO8k5je+oMi8x8lWLkXAA==
X-Received: by 2002:a05:6000:40de:b0:3ea:e0fd:290a with SMTP id
 ffacd0b85a97d-42666ab2843mr1880211f8f.12.1759928498158; 
 Wed, 08 Oct 2025 06:01:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8abf0bsm29843919f8f.17.2025.10.08.06.01.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Oct 2025 06:01:37 -0700 (PDT)
Message-ID: <7256274c-ac20-4ef8-9841-48be7bfa2b91@redhat.com>
Date: Wed, 8 Oct 2025 15:01:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vfio/container: Support unmap all in one ioctl()
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 John Levon <levon@movementarian.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>
References: <20250924070254.1550014-1-zhenzhong.duan@intel.com>
 <20250924070254.1550014-2-zhenzhong.duan@intel.com>
 <01f0b0eb-b036-4823-8020-fd6962b26d9d@redhat.com>
 <aNxT1w0BbMH6pJ0J@movementarian.org>
 <d715d9dd-a613-4406-93c1-507d1470619f@redhat.com>
 <IA3PR11MB91364A76C06D76B0E6ADBEBD92E1A@IA3PR11MB9136.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <IA3PR11MB91364A76C06D76B0E6ADBEBD92E1A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/8/25 12:18, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Subject: Re: [PATCH 1/2] vfio/container: Support unmap all in one ioctl()
>>
>> On 10/1/25 00:04, John Levon wrote:
>>> On Tue, Sep 30, 2025 at 05:26:59PM +0200, Cédric Le Goater wrote:
>>>
>>>>> -        }
>>>>> +        ret = ioctl(container->fd, VFIO_CHECK_EXTENSION,
>> VFIO_UNMAP_ALL);
>>>>
>>>> Could we introduce an helper to test 'unmap_all' support in the host
>>>> kernel ? The result would be something like :
>>>>
>>>>     if (unmap_all) {
>>>>           if
>> (vfio_legacy_has_unmap_all(VFIO_IOMMU_LEGACY(bcontainer))) {
>>>>               flags = VFIO_DMA_UNMAP_FLAG_ALL;
>>>>           } else {
>>>>               /* The unmap ioctl doesn't accept a full 64-bit span. */
>>>>               Int128 llsize = int128_rshift(int128_2_64(), 1);
>>>>               ...
>>>>           }
>>>>     }
>>>
>>> For reference/consideration, the previous approach taken in the vfio-user
>>> series:
>>>
>>>
>> https://lore.kernel.org/qemu-devel/20250219144858.266455-4-john.levon@
>> nutanix.com/
>>>
>>> @@ -533,6 +562,11 @@ static bool vfio_legacy_setup(VFIOContainerBase
>> *bcontainer, Error **errp)
>>>        vfio_get_info_iova_range(info, bcontainer);
>>>
>>>        vfio_get_iommu_info_migration(container, info);
>>> +
>>> +    ret = ioctl(container->fd, VFIO_CHECK_EXTENSION,
>> VFIO_UNMAP_ALL);
>>> +
>>> +    container->unmap_all_supported = (ret != 0);
> 
> Good suggestion, thanks John.
> 
>>>
>>> (I dropped this particular change as part of getting merged.)
>> Yes. I'm reconsidering now.
>>
>> Should we introduce a VFIOContainerBase attribute/flag
>> 'unmap_all_supported',
>> set in the vioc->setup handler ?
> 
> Do you mean to check bcontainer->unmap_all_supported and do the split in vfio_listener_region_del()?
> 
> If only checking it in legacy container, putting it in VFIOLegacyContainer sounds better?

It depends if vfio-user needs it too.

C.



