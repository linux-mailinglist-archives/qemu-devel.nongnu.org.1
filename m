Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A36FD7EBE73
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 09:17:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3B4P-0007sc-FY; Wed, 15 Nov 2023 03:16:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r3B49-0007ra-GU
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 03:16:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r3B44-0000v1-Cj
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 03:16:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700036159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jaRsXLRag+fe4zgR/64IjuNI8BsXXoxbxq7ANwzicfY=;
 b=MEgsGcV79fYM8ocXo4AH2p0yFCbhAZsL8RGoRJUchunLCnFjZpTOinDEP8nZW1IyPgknCy
 lbH+EIwtJgJTle6VxS+rXWS+1FK499OBTfkdVe6Mka1rRKysPiEo9z6/SrNRc/2UQ5o+41
 jaNVrBa+/7ZYhZMBpQt0lEGp8P7QBJg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-H1trts9iO-e9TTZMYoHtTw-1; Wed, 15 Nov 2023 03:15:57 -0500
X-MC-Unique: H1trts9iO-e9TTZMYoHtTw-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7788ce62d50so776110485a.3
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 00:15:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700036157; x=1700640957;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jaRsXLRag+fe4zgR/64IjuNI8BsXXoxbxq7ANwzicfY=;
 b=nXe/77pWsxYZcF+HqwCI2T/PRoSC2JR/YO41Ae6OpINSEvqpuEVvzfiBcwrBv8+XlI
 AQBIvH5Ku3wrt8Q3uZA/kIZWH/H5/YSxT8SQ7vZA42CCE3Gqpd1JPZVOpPGvPZ+vjGQe
 RyFHeGFbBpkUql8qm2noPoWKhdRZZccOfGpFlhrYLm0IDJnVFiaZE4YCiLAsXIcj8x4n
 zO2FEgE+xHIhnqp0EKNnVP61ziUqx51B6gNb8JM/bgZHCJBvkhSg4mdZwixTS6pgekX5
 N9KdXmazl1nb9x/iBuyrLwBgx8i+Bjp8RBV+ynTZbWt5oNdiuo50G2XdS/ZbjB08CXjy
 8KeQ==
X-Gm-Message-State: AOJu0YwuXWq3faTqkml5e27JC6qS/pSQfO/RKVvORe3L5eaclrIup0Qg
 QOdPjmG01Qf0irKOCnGSQFJ5BPzx+QNOLRHbB5uCFeDHF4FugHSrBnDIuzZ2T59zGxtfVvroCzJ
 y7dS/Lae803k1OyY=
X-Received: by 2002:a05:620a:6003:b0:77a:1cc0:6e5f with SMTP id
 dw3-20020a05620a600300b0077a1cc06e5fmr5104024qkb.18.1700036156883; 
 Wed, 15 Nov 2023 00:15:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVCwatjJfPZhS4iqipaVBOr/HSNg8beb3+jHTiPvtww76bB+Ci3H2FWEe29Acbc6gDaYnnUg==
X-Received: by 2002:a05:620a:6003:b0:77a:1cc0:6e5f with SMTP id
 dw3-20020a05620a600300b0077a1cc06e5fmr5104008qkb.18.1700036156603; 
 Wed, 15 Nov 2023 00:15:56 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 bp8-20020a05620a458800b0076c701c3e71sm3276583qkb.121.2023.11.15.00.15.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 00:15:56 -0800 (PST)
Message-ID: <8d0397e2-582a-423d-8d91-e2931a7bcb86@redhat.com>
Date: Wed, 15 Nov 2023 09:15:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/21] backends/iommufd: Introduce the iommufd object
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
 <20231114100955.1961974-2-zhenzhong.duan@intel.com>
 <434f36ad-d29e-459b-afa5-530f086cd88b@redhat.com>
 <SJ0PR11MB67442A9FF4E33DF686A1020F92B1A@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB67442A9FF4E33DF686A1020F92B1A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 11/15/23 05:06, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Sent: Tuesday, November 14, 2023 9:29 PM
>> Subject: Re: [PATCH v6 01/21] backends/iommufd: Introduce the iommufd object
>>
>> On 11/14/23 11:09, Zhenzhong Duan wrote:
>>> From: Eric Auger <eric.auger@redhat.com>
>>>
>>> Introduce an iommufd object which allows the interaction
>>> with the host /dev/iommu device.
>>>
>>> The /dev/iommu can have been already pre-opened outside of qemu,
>>> in which case the fd can be passed directly along with the
>>> iommufd object:
>>>
>>> This allows the iommufd object to be shared accross several
>>> subsystems (VFIO, VDPA, ...). For example, libvirt would open
>>> the /dev/iommu once.
>>>
>>> If no fd is passed along with the iommufd object, the /dev/iommu
>>> is opened by the qemu code.
>>>
>>> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>
>> I simplified the object declaration in include/sysemu/iommufd.h and
>> formatted /dev/iommu in qemu-options.hx. No need to resend.
> 
> Good catch, thanks! Maybe further simplified with below? This is minor.
> 
> OBJECT_DECLARE_TYPE(IOMMUFDBackend, IOMMUFDBackendClass, IOMMUFD_BACKEND)

Indeed. Done.



Thanks,

C.



