Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EB073A175
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 15:06:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCK0Y-0003DW-F1; Thu, 22 Jun 2023 09:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qCK0Q-0003Cz-CN
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 09:05:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qCK0M-0002CB-OI
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 09:05:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687439140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R+V+dQMBw5ZgRyeVtB8kz1HzIkjhnPBDtVjrMhwt4/s=;
 b=Hp+DRvRH4v0eHi619XGxcbezZoXB4qfXdiWmCPsfxyG82xHLVcjUpkV3Ffo0AXrpGhNn36
 8D2MUnmXGsBGNqPuqynCHuxPqDfN/T66LAtIntUCeP0wYwZ4F5Ugtk+EpcO+GjK1NQZM2L
 n2M1iaa0IA+sJw7OkCcpmbjh/wFSmUw=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-qlVTi6TxO2ClLwgH8v4k5A-1; Thu, 22 Jun 2023 09:05:37 -0400
X-MC-Unique: qlVTi6TxO2ClLwgH8v4k5A-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4f01644f62eso4998248e87.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 06:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687439135; x=1690031135;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R+V+dQMBw5ZgRyeVtB8kz1HzIkjhnPBDtVjrMhwt4/s=;
 b=EFMaSFKShwW3IHggHQxjrmu4zwuIlcEQEy6TdTm0Syj4/7baX1zLTQYSXCxMrvI/Cw
 e6DrOhnnCUQfCF3Ahvj/V2BwwBDzjyg3QuLdJZAzCm5SODCeEhMJZXOgaeaqxQN1J7/N
 dFb0deHXH2vuzOB3duBYnmzHZ7woHvH4cZCIdvOdEjAklYENZ63s0kd7Ll0jHLQMvMYA
 GEh89IMb70ah06IFF/lYuTjCjEyIg/JMUp/RduzAFTM84MiBTIh2k45LkUH11+PR6f/+
 hlP/9GX/HHZmdgrm3LgT0vzqZdi17B4WGfXV/j8T4oWown2TOXt1nppzzyyIwaMi+t0g
 yA8Q==
X-Gm-Message-State: AC+VfDxVH9bg5dqv0PCaCXDjBOf4zq2Mrn0jX1JufyD1x+2ThfuRe314
 pJx/UHwMXXsfB81k0MA2+0+k2Oe/E3FJXJy5TsXzgjTUZX+V4oetNv8smMZy2WU1EVHxSEKG0uD
 ywN4xp3HXMzA1tak=
X-Received: by 2002:ac2:5058:0:b0:4f8:67f0:724e with SMTP id
 a24-20020ac25058000000b004f867f0724emr9136636lfm.33.1687439135647; 
 Thu, 22 Jun 2023 06:05:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Cp8icUqPWLVwB8ktr3AwzHWkp6rwCAVQd/GioCA3dCnVFCGcq33M3N14V/KV5bVR/SZh03w==
X-Received: by 2002:ac2:5058:0:b0:4f8:67f0:724e with SMTP id
 a24-20020ac25058000000b004f867f0724emr9136593lfm.33.1687439135205; 
 Thu, 22 Jun 2023 06:05:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71a:c00:a3d3:85e8:742c:2e9?
 (p200300cbc71a0c00a3d385e8742c02e9.dip0.t-ipconnect.de.
 [2003:cb:c71a:c00:a3d3:85e8:742c:2e9])
 by smtp.gmail.com with ESMTPSA id
 p7-20020adff207000000b00307acec258esm7108563wro.3.2023.06.22.06.05.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jun 2023 06:05:34 -0700 (PDT)
Message-ID: <3f65e040-9ff8-2d40-299a-2d9d30ada58e@redhat.com>
Date: Thu, 22 Jun 2023 15:05:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] tpm_crb: mark memory as protected
Content-Language: en-US
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 jasowang@redhat.com, mst@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 marcandre.lureau@redhat.com, eric.auger@redhat.com,
 Peter Xu <peterx@redhat.com>
References: <20230620195054.23929-1-lvivier@redhat.com>
 <20230620195054.23929-3-lvivier@redhat.com>
 <13593b65-7df3-7ebc-0759-82c6731eb04b@redhat.com>
 <06d07da8-68a7-c7da-1a78-f45750971ede@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <06d07da8-68a7-c7da-1a78-f45750971ede@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 22.06.23 14:59, Laurent Vivier wrote:
> On 6/21/23 11:13, David Hildenbrand wrote:
>> On 20.06.23 21:50, Laurent Vivier wrote:
>>> This memory is not correctly aligned and cannot be registered
>>> by vDPA and VFIO.
>>>
>>> An error is reported for vhost-vdpa case:
>>> qemu-kvm: vhost_vdpa_listener_region_add received unaligned region
>>>
>>> To make it ignored by VFIO and vDPA devices, mark it as RAM_PROTECTED.
>>
>> So, VFIO will simply skip these sections via vfio_listener_valid_section() I guess.
>>
>> Yes, it will report an error but it will happily continue.
>>
>> So regarding vDPA, we're also only concerned about removing the reported error, everything
>> else works as expected?
>>
> 
> Yes, it has been tested and vDPA works as expected.

Okay, so no Fixes: tags required

-- 
Cheers,

David / dhildenb


