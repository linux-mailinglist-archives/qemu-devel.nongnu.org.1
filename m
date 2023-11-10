Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1867E7AFB
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 10:38:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1Nxu-00024V-Av; Fri, 10 Nov 2023 04:38:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r1Nxp-00023T-4L
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 04:38:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r1Nxn-0006TR-Kv
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 04:38:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699609085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dy1EZ3wIgemrHxSFBqC8xYNQAJxXdvajqIriaAhOpUk=;
 b=RZEzWeQNiHIQYz+vqkViAil/IkqSrCwkZKfGZF/VmC8GuNw39nmoqOrFRVtXSELLMQxbkf
 uFENQGc6OPDWF6LUtBsJ57cnyA08kbOLI0lodA4sWbtnHVqYlyBr6so+xurqu343CqEBYm
 u0Yhk3TCojC4P8a/7RmjCjm49BlKMQA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-J_WPs5fPPVmAXJ--QqsL3Q-1; Fri, 10 Nov 2023 04:38:04 -0500
X-MC-Unique: J_WPs5fPPVmAXJ--QqsL3Q-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-66fa17e145aso21079806d6.0
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 01:38:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699609084; x=1700213884;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dy1EZ3wIgemrHxSFBqC8xYNQAJxXdvajqIriaAhOpUk=;
 b=QBpZkM0qqdvNLJ893EzezZ/aqmXp7wDEpsu6W4zhsOoagObC4q0py1/hX8tFVwSsnU
 ffEMUPQvQMKpHDyEzzSb0Re096fw+2AUxbYAP+bYXeNn1z62I7o8fDjSqj6MIbycNueu
 jC1lQJQ2dU/i++BGwOkWmcW1ZmoWr+46V3jMc5XPQSVMICjEE3aI18ZFpBL5wmnzwRzN
 uJHC19GDFqL27cimTFrMAfKJc2/hg3Un+WbiddeTROk+RKv+qPuh9zKM/qtTGkFtAdZU
 gWgSCiQ+S2zX1LMq5qPlFyR5AienGtcv9Y8d+ZE8L4Y9Muq9UDDEnn6J8ZyZ0u3hLxOj
 fx/A==
X-Gm-Message-State: AOJu0Yx/UGEdhT6lscbGtO0JwVdjDN7vPO6hg7GA+IEiQdKxUx1y9Far
 OuiyazHhpKyiu19TbaLRM7tDVWvbNaDVlO7hn+V+FjiwA7RGsse0AYOekdFHmctsM66Y9F6Q7gb
 ZW+7dzKwTNxN/NVc=
X-Received: by 2002:a05:6214:490:b0:66d:182a:c083 with SMTP id
 pt16-20020a056214049000b0066d182ac083mr9630435qvb.9.1699609083938; 
 Fri, 10 Nov 2023 01:38:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHF4aUbxIfcp/OZVpNQxpMTQghrG2WBPiwAe4LA0ChB8QTr0jDzEzeVmnnKDF/+B4QlRHVnjw==
X-Received: by 2002:a05:6214:490:b0:66d:182a:c083 with SMTP id
 pt16-20020a056214049000b0066d182ac083mr9630414qvb.9.1699609083722; 
 Fri, 10 Nov 2023 01:38:03 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 x14-20020a0ce78e000000b0065afbb39b2dsm2784013qvn.47.2023.11.10.01.38.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Nov 2023 01:38:03 -0800 (PST)
Message-ID: <51adff69-aa14-4d73-8922-2e47ef3878c4@redhat.com>
Date: Fri, 10 Nov 2023 10:38:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 19/20] kconfig: Activate IOMMUFD for s390x machines
Content-Language: en-US
To: Matthew Rosato <mjrosato@linux.ibm.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>
References: <20231109114529.1904193-1-zhenzhong.duan@intel.com>
 <20231109114529.1904193-20-zhenzhong.duan@intel.com>
 <2acb76b0-00cd-a448-f615-0cb1825e81a0@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <2acb76b0-00cd-a448-f615-0cb1825e81a0@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 11/10/23 00:00, Matthew Rosato wrote:
> On 11/9/23 6:45 AM, Zhenzhong Duan wrote:
>> From: Cédric Le Goater <clg@redhat.com>
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>   hw/s390x/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/s390x/Kconfig b/hw/s390x/Kconfig
>> index 4c068d7960..26ad104485 100644
>> --- a/hw/s390x/Kconfig
>> +++ b/hw/s390x/Kconfig
>> @@ -6,6 +6,7 @@ config S390_CCW_VIRTIO
>>       imply VFIO_CCW
>>       imply WDT_DIAG288
>>       imply PCIE_DEVICES
>> +    imply IOMMUFD
>>       select PCI_EXPRESS
>>       select S390_FLIC
>>       select S390_FLIC_KVM if KVM
> 
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> 
> I also ran tests against vfio-pci (mlx, ism, nvme), vfio-ap and vfio-ccw on s390x with an iommufd-enabled host kernel + this series.  Testing included having qemu open both fds, passing in one fd and letting qemu open the other, and passing in both fds.

Thanks !

C.

  


