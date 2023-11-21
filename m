Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4D27F26F0
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 09:06:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Llb-0001Aw-Dz; Tue, 21 Nov 2023 03:05:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r5LlX-0001AN-QK
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 03:05:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r5LlW-0007yG-C7
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 03:05:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700553948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U6ze7I4Vbb6fn6iPD0E4ZDClY368x6kMXWWapM1RteY=;
 b=FuyHamMMt3cYJR/NPaXQ7kSzwz+lK1/2I1TS8hzifTuFddczHK2zUJmspTGVoMvPWKWB3Z
 SCVQb84UwRS168stKD5TDrQHfFGPYhpnV4DAX7nUdNjlbsUaApDdGP6Kg3x9CSoZ09IQ5c
 HByqSzgmMbosXj85EMltAempLiNDpjI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-rWUfWaV9N_uGnIk7EaqV6Q-1; Tue, 21 Nov 2023 03:05:46 -0500
X-MC-Unique: rWUfWaV9N_uGnIk7EaqV6Q-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-778915a0c73so558164885a.1
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 00:05:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700553946; x=1701158746;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U6ze7I4Vbb6fn6iPD0E4ZDClY368x6kMXWWapM1RteY=;
 b=LfluqKHh1LetZCvlMIJ0y0ouuowhSFPXgV0RhLkfxEMOtadHlrq7l5nDkbzuac2MPW
 JSeaB3czFHA1PPW4Y8wq7mKc6mI7Q/y7zON/R/apX+csBYbZKYoCB0Winnis3gP95/pu
 xitkfbW4j+DnXVR+3RJIVUXbJ8ElXXZWu8Je5hmVMeiviU+hQzV8/a1WranrsODcydEA
 pyOyZAAU4svYy/G5PWRy9UN+51KbaAFpQphXatrFess/0nsGC25RwhaLaEsZVbk4HWR7
 1hoxxMnWNUwwPG0wVHoF5lbCBIIvKjRdy0U3DOdAQdiLdIqWY/fZkRHrRw3SKwWgiRgU
 zQag==
X-Gm-Message-State: AOJu0Yy2Y6k9wmoJHY/znVunWY6NEWXdLHG79RVdWfUXS1CsPBQs+vyB
 mNC3CdEn8FiHIwq+XDyMc/QX2MysedrKlT6pct7Q4VduynG4KJ4uRa8NrNdGwyFU7w0L4VCgOqU
 InCOqA3J74ZnWTto=
X-Received: by 2002:a05:620a:f87:b0:777:457:34be with SMTP id
 b7-20020a05620a0f8700b00777045734bemr7369344qkn.24.1700553945988; 
 Tue, 21 Nov 2023 00:05:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnDHj4vDdf7+uABY7bS0iNox06htQnKnPOy7XLl7l+N+V1LZPcc58JUoafjUfS8XffAwTJLw==
X-Received: by 2002:a05:620a:f87:b0:777:457:34be with SMTP id
 b7-20020a05620a0f8700b00777045734bemr7369316qkn.24.1700553945705; 
 Tue, 21 Nov 2023 00:05:45 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 w19-20020a05620a445300b0077891d2d12dsm3414675qkp.43.2023.11.21.00.05.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Nov 2023 00:05:45 -0800 (PST)
Message-ID: <405fbb52-df05-4511-bec6-66caab2b4c93@redhat.com>
Date: Tue, 21 Nov 2023 09:05:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/21] backends/iommufd: Introduce the iommufd object
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Gerd Hoffmann <kraxel@redhat.com>,
 "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "lersek@redhat.com" <lersek@redhat.com>
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
 <20231114100955.1961974-2-zhenzhong.duan@intel.com>
 <c964fdf3-d6ef-40cd-b4c0-32f1fb8501ae@redhat.com>
 <SJ0PR11MB6744B1B91C890A9A1B81E89792B7A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <248389a7-3f89-42ae-98e7-34d6612cf186@redhat.com>
 <c0c265d6-aaea-4071-b280-b93df459165e@redhat.com>
 <SJ0PR11MB67444672699A62007207FB3492B4A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <ebc65641-4597-4679-8214-0f4555f9bd21@redhat.com>
 <SJ0PR11MB674445FEAD689AF8B5A8A42B92B4A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <395120c5-06d0-4421-a9b8-20bd79bf3f5c@redhat.com>
 <SJ0PR11MB67441701C3CD12A968092CB192BBA@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB67441701C3CD12A968092CB192BBA@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hello Zhenzhong,

>>> Below are other gaps I can think of for now:
>>>
>>> Gaps:
>>> 1. dirty page sync, WIP (Joao)
>>> 2. p2p dma not supported yet.
>>> 3. fd passing with mdev not support ram discard(vfio-pci) as no way to know it's
>> a mdev from a fd.
>>
>> Call the section Caveats maybe?
> 
> Got it.

It looks like v7 should be ready by rc2 (next week). I would then merge
in vfio-next and wait a week before sending a QEMU-9.0 PR.

Thanks,

C.




