Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25777707C78
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 11:08:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzZbF-0008N9-0b; Thu, 18 May 2023 05:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1pzZb9-0008Mg-C3
 for qemu-devel@nongnu.org; Thu, 18 May 2023 05:06:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1pzZb7-0001Sa-TP
 for qemu-devel@nongnu.org; Thu, 18 May 2023 05:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684400816;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+1v54RPJVohLyNDMJROIT+RVq+dP8UCzs9qZmQDhvUQ=;
 b=PmwUiE31FZdjXAFuV9ZTKLT93lncNxs1wC4++atI2GQU+IUOWmQOEIwrDwbplQ1XIwlo9c
 I84LAbQb7g/EFKXb81JHeK1TBehH5LSDaxH5EXvnQFcNqhuwNVzmJS3thELwJpqNauWG6K
 tAWTfyqrj+lAdn7KW0N/TYQqU3Kw6bE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-WBTFIKXQPamSEK_f_q39LA-1; Thu, 18 May 2023 05:06:54 -0400
X-MC-Unique: WBTFIKXQPamSEK_f_q39LA-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-75780f99906so132387785a.2
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 02:06:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684400814; x=1686992814;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+1v54RPJVohLyNDMJROIT+RVq+dP8UCzs9qZmQDhvUQ=;
 b=bYKSnXDh0xEiqKewcdYcawkxAfF6rJUVfH6hRbETkTeFp/MeY+4yEvdPhw5FRYAyP6
 yxEpNnDChIztUadB9+Z0AX2WhsTTD2690SLTVGhnLfRJJFnSPUO+exkgM61tNcPkZVxv
 UeZZkgEXnJHj6FARdEfvNfr1rEppAtx9jbkbrMzdT+OmGgVd5Fg7wQhUVfJ1otcMmbxH
 X0hJuFUj3uiz8+WgopcdEaoBzR2Cl4ehd6nGzowzsQy1/+3BWQ7/RzIQlD1yAU1VOjIe
 MnKrVEv2EZWqJybtrC/8Hgt1nkYov1dY/WNYjx5NQS3/Vppkos8Kjt22wctAdmkvS/d0
 dLgQ==
X-Gm-Message-State: AC+VfDxWDWHXU0kHWtpNYo/0SSR1bU+NUqMx9whciVAeGzz+i48JjT14
 WUcIMvGrhdqz78t11kOXBviLKCL1fLTVnwuUw6U/sgMUAOUREYoxhaBkE1exnN9MduscuEf2gtj
 9lJHJropPIH/Chvw=
X-Received: by 2002:a05:6214:f0d:b0:621:1b73:52c9 with SMTP id
 gw13-20020a0562140f0d00b006211b7352c9mr4583107qvb.10.1684400813999; 
 Thu, 18 May 2023 02:06:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4wJwKskwD0MDRqHtuyYNiftSslUYOhSO0EK19NHOiajdNIuiXVBitNu10S+Axeigjj2CasHQ==
X-Received: by 2002:a05:6214:f0d:b0:621:1b73:52c9 with SMTP id
 gw13-20020a0562140f0d00b006211b7352c9mr4583081qvb.10.1684400813771; 
 Thu, 18 May 2023 02:06:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 i18-20020a0cf952000000b006238b6bd191sm365774qvo.145.2023.05.18.02.06.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 May 2023 02:06:52 -0700 (PDT)
Message-ID: <0defbf3f-a8be-7f1b-3683-e3e3ece295fc@redhat.com>
Date: Thu, 18 May 2023 11:06:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: Multiple vIOMMU instance support in QEMU?
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: jgg@nvidia.com, yi.l.liu@intel.com, kevin.tian@intel.com,
 Peter Xu <peterx@redhat.com>
References: <ZEcT/7erkhHDaNvD@Asurada-Nvidia> <ZGWaCKQqK5hVqbvM@Asurada-Nvidia>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <ZGWaCKQqK5hVqbvM@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.412, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Nicolin,

On 5/18/23 05:22, Nicolin Chen wrote:
> Hi Peter,
>
> Eric previously mentioned that you might not like the idea.
> Before we start this big effort, would it possible for you
> to comment a word or two on this topic?
>
> Thanks!
>
> On Mon, Apr 24, 2023 at 04:42:57PM -0700, Nicolin Chen wrote:
>> Hi all,
>>
>> (Please feel free to include related folks into this thread.)
>>
>> In light of an ongoing nested-IOMMU support effort via IOMMUFD, we
>> would likely have a need of a multi-vIOMMU support in QEMU, or more
>> specificly a multi-vSMMU support for an underlying HW that has multi
>> physical SMMUs. This would be used in the following use cases.
>>  1) Multiple physical SMMUs with different feature bits so that one
>>     vSMMU enabling a nesting configuration cannot reflect properly.
>>  2) NVIDIA Grace CPU has a VCMDQ HW extension for SMMU CMDQ. Every
>>     VCMDQ HW has an MMIO region (CONS and PROD indexes) that should
>>     be exposed to a VM, so that a hypervisor can avoid trappings by
>>     using this HW accelerator for performance. However, one single
>>     vSMMU cannot mmap multiple MMIO regions from multiple pSMMUs.
>>  3) With the latest iommufd design, a single vIOMMU model shares the
>>     same stage-2 HW pagetable across all physical SMMUs with a shared
>>     VMID. Then a stage-1 pagetable invalidation (for one device) at
>>     the vSMMU would have to be broadcasted to all the SMMU instances,
>>     which would hurt the overall performance.
Well if there is a real production use case behind the requirement of
having mutliple vSMMUs (and more generally vIOMMUs) sure you can go
ahead. I just wanted to warn you that as far as I know multiple vIOMMUS
are not supported even on Intel iommu and virtio-iommu. Let's add Peter
Xu in CC. I foresee added complexicity with regard to how you define the
RID scope of each vIOMMU, ACPI table generation, impact on arm-virt
machine options, how you pass the feature associated to each instance,
notifier propagation impact? And I don't evoke the VCMDQ feat addition.
We are still far from having a singleton QEMU nested stage SMMU
implementation at the moment but I understand you may want to feed the
pipeline to pave the way for enhanced use cases.

Thanks

Eric
>>
>> I previously discussed with Eric this topic in a private email. Eric
>> felt the difficulty of implementing this in the current QEMU system,
>> as it would touch different subsystems like IORT and platform device,
>> since the passthrough devices would be attached to different vIOMMUs.
>>
>> Yet, given the situations above, it's likely the best by duplicating
>> the vIOMMU instance corresponding to the number of the physical SMMU
>> instances.
>>
>> So, I am sending this email to collect opinions on this and see what
>> would be a potential TODO list if we decide to go on this path.
>>
>> Thanks
>> Nicolin


