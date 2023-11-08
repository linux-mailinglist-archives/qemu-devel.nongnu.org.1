Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FA47E52C1
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 10:42:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0f3J-0007Lk-In; Wed, 08 Nov 2023 04:40:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r0f3H-0007LM-M6
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 04:40:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r0f3G-00007d-4A
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 04:40:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699436444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lbolcVwlFcOlezruaHLOr6rLLo/IugGTsXYBBXGoD9c=;
 b=N+GfMBSCpWbln9OFrc/KsJPv+0vL4VF/Ud0u973g52948ypx+oW5TcrLIRPPiHUnHKEQPU
 I0CJ2q4158T53pLpqEuzda2WcnybgbKavgC7nXG8Iz4GmwfAiQvYiPSWRvTItcA9g+Pwrv
 pI0u0etrGxhZpzgphPIDHSnqKqrqw/Q=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-brlNwxzoPaulnPVAf27ceQ-1; Wed, 08 Nov 2023 04:40:42 -0500
X-MC-Unique: brlNwxzoPaulnPVAf27ceQ-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-779ffb552eeso773855685a.3
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 01:40:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699436442; x=1700041242;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lbolcVwlFcOlezruaHLOr6rLLo/IugGTsXYBBXGoD9c=;
 b=G+nqhJg7QQpwME8P5bQ0yq6MXfs4N9jCo3AIMI5ObLppLOFxUT/WAAUq6w8kP3XKZN
 cA3dMtAQ8xJGSCeD0eBhURF2sVm6pVRFiC9Sw+TILXhzJ2FMTAMVASr7p6nw2l84DVxg
 EMTMs3JTrpjOX6mLfDjkLZddH5nC60BjuGU+wQB0+ea5C5HSN3DgEjWEptbleKhpEI3K
 0De5ecz8MBlsD2sxrRlCoB7g4VU7gXQkdtWJP/MmZfqiqeYWpd2k7ggRCDJmiOi0SHyn
 Xske5dLZBJ5uxBoGNRUMYeFkFNlgIAwCVvHlJh03NYWLG/UsMXxOSh0m38V8ZKbdE+IV
 WPng==
X-Gm-Message-State: AOJu0YzUcOxIa8eh7kJUqpYhetexgzdKGOqQaXl9x/T/bSnfX3q/ogM4
 nCp05aUL2IRLxxvG1AHMjibCJ3GKCKSpt0dbTkMRfW3ePVkt1UlIeL9cgGfEOv5cZP7E1eItHa7
 XknaVqKoajSViOsA=
X-Received: by 2002:a05:620a:4092:b0:774:30b7:ed93 with SMTP id
 f18-20020a05620a409200b0077430b7ed93mr1196495qko.29.1699436442411; 
 Wed, 08 Nov 2023 01:40:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6j15rHkN6O9e1SHolIg+97xpwXoURMUjESyKG1Yb/hg1geKWw4i11asOSd8aM3YrkC74JpQ==
X-Received: by 2002:a05:620a:4092:b0:774:30b7:ed93 with SMTP id
 f18-20020a05620a409200b0077430b7ed93mr1196486qko.29.1699436442183; 
 Wed, 08 Nov 2023 01:40:42 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 g11-20020a05620a218b00b0076ef3e6e6a4sm847316qka.42.2023.11.08.01.40.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 01:40:41 -0800 (PST)
Message-ID: <505b6c74-6404-490b-93b9-9c7449d9eaaf@redhat.com>
Date: Wed, 8 Nov 2023 10:40:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 26/41] backends/iommufd: Introduce the iommufd object
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-27-zhenzhong.duan@intel.com>
 <da7de379-bd8c-47d1-b7bf-412be92a2756@redhat.com>
 <SJ0PR11MB67442D810F397F1CAAC3710A92A8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB67442D810F397F1CAAC3710A92A8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

>>> +                              hwaddr iova, ram_addr_t size)
>>> +{
>>> +    int ret;
>>> +    struct iommu_ioas_unmap unmap = {
>>> +        .size = sizeof(unmap),
>>> +        .ioas_id = ioas_id,
>>> +        .iova = iova,
>>> +        .length = size,
>>> +    };
>>> +
>>> +    ret = ioctl(be->fd, IOMMU_IOAS_UNMAP, &unmap);
>>> +    trace_iommufd_backend_unmap_dma(be->fd, ioas_id, iova, size, ret);
>>> +    /*
>>> +     * TODO: IOMMUFD doesn't support mapping PCI BARs for now.
>>> +     * It's not a problem if there is no p2p dma, relax it here
>>> +     * and avoid many noisy trigger from vIOMMU side.
>>
>> Should we add a warn_report() ?
> 
> The purpose of checking "ret && errno == ENOENT" is to avoid many
> error_report() for PCI BARs, If we add warn_report(), there will still be
> many print for PCI BARs.

a trace event then ?

Thanks,

C.


