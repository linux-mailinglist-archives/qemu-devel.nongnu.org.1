Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2AC7083D3
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 16:18:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzeQq-0000gp-Ro; Thu, 18 May 2023 10:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1pzeQo-0000fL-Hj
 for qemu-devel@nongnu.org; Thu, 18 May 2023 10:16:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1pzeQh-0006Lv-Ls
 for qemu-devel@nongnu.org; Thu, 18 May 2023 10:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684419390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LrPS4Jcq2k7c1X7Z4RkhbBE75ptSnxYSyIL+Gdeh1QQ=;
 b=Qd2XpAllCRcyjiQ2mCr72wYdZm6uSRMdLfI90lzAH2zPaQfhJqGyvwb8DGAAg7KDpJiAXQ
 4iRjwd9o7rFxEMprkkvIjVrtvpbcz3ZfU1jhAoeN8l3f/VoV27Eemy8gEZqSGOpRfj0Mf1
 NDUZZGAR8qJZEDqdhXFm+cVVyYKRTHc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-eZ0lrcaIMzydCBMMB_MXyg-1; Thu, 18 May 2023 10:16:28 -0400
X-MC-Unique: eZ0lrcaIMzydCBMMB_MXyg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-5ea572ef499so1929906d6.1
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 07:16:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684419388; x=1687011388;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LrPS4Jcq2k7c1X7Z4RkhbBE75ptSnxYSyIL+Gdeh1QQ=;
 b=I08kjefKzjU4pyIYMuN7DIMW7icVU13hUPKYkEgcZcd7HYpm3RlZgxSDUTl9dVo4yM
 VfmtKLSqkhyDCZqXNQjUvLh0diYXB2bjatuuVL/wqNgBPBtY58gv3RkvTk8xIeectLFV
 ncO1TdJ3W3faqyruJXA61I6fCRX6B4+VyWS/+D3lbcfiQ/6mAKA1Ozm9GmR7EAbTBpdz
 HXhnBW1y7qy7GijHuKVVg0jb4qr2YAI587qEnJxqR7/0MndPs903OiF3iaE83ig+qpcI
 27LyGWzpxKa1O/Yj0yZutJXuFx6gCQ9dLlJJq20nGRLPXTVb+YW5Xaz9Ek4aFMBbZSl9
 OjFA==
X-Gm-Message-State: AC+VfDz5Op2s3Nwh6YJRxy4J38rpa6ZZ9j1coK6bAfObeyPaSTQfNynL
 GRPAR3SVsF84grB+aqQ317XTBaqpcbLc1o8uTbg1dP9c/WmoKPIemnqBo+FZ5i9hQTrA0oWGzs0
 A3SacLsNg918HSvA=
X-Received: by 2002:a05:6214:2126:b0:5ed:c96e:ca4a with SMTP id
 r6-20020a056214212600b005edc96eca4amr11483501qvc.1.1684419388084; 
 Thu, 18 May 2023 07:16:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ69m1b6q3zfeIvEThsr+//el91NwHM/XezRQDcCPXHYKvynk1wxpwyFCVuW7TmD2axYDolHDA==
X-Received: by 2002:a05:6214:2126:b0:5ed:c96e:ca4a with SMTP id
 r6-20020a056214212600b005edc96eca4amr11483469qvc.1.1684419387764; 
 Thu, 18 May 2023 07:16:27 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 r15-20020a0cf60f000000b006166b169573sm542330qvm.66.2023.05.18.07.16.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 07:16:25 -0700 (PDT)
Date: Thu, 18 May 2023 10:16:24 -0400
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, jgg@nvidia.com,
 yi.l.liu@intel.com, kevin.tian@intel.com
Subject: Re: Multiple vIOMMU instance support in QEMU?
Message-ID: <ZGYzOEhdTA6sWKjP@x1n>
References: <ZEcT/7erkhHDaNvD@Asurada-Nvidia> <ZGWaCKQqK5hVqbvM@Asurada-Nvidia>
 <0defbf3f-a8be-7f1b-3683-e3e3ece295fc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0defbf3f-a8be-7f1b-3683-e3e3ece295fc@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, May 18, 2023 at 11:06:50AM +0200, Eric Auger wrote:
> Hi Nicolin,
> 
> On 5/18/23 05:22, Nicolin Chen wrote:
> > Hi Peter,
> >
> > Eric previously mentioned that you might not like the idea.
> > Before we start this big effort, would it possible for you
> > to comment a word or two on this topic?
> >
> > Thanks!
> >
> > On Mon, Apr 24, 2023 at 04:42:57PM -0700, Nicolin Chen wrote:
> >> Hi all,
> >>
> >> (Please feel free to include related folks into this thread.)
> >>
> >> In light of an ongoing nested-IOMMU support effort via IOMMUFD, we
> >> would likely have a need of a multi-vIOMMU support in QEMU, or more
> >> specificly a multi-vSMMU support for an underlying HW that has multi
> >> physical SMMUs. This would be used in the following use cases.
> >>  1) Multiple physical SMMUs with different feature bits so that one
> >>     vSMMU enabling a nesting configuration cannot reflect properly.
> >>  2) NVIDIA Grace CPU has a VCMDQ HW extension for SMMU CMDQ. Every
> >>     VCMDQ HW has an MMIO region (CONS and PROD indexes) that should
> >>     be exposed to a VM, so that a hypervisor can avoid trappings by
> >>     using this HW accelerator for performance. However, one single
> >>     vSMMU cannot mmap multiple MMIO regions from multiple pSMMUs.
> >>  3) With the latest iommufd design, a single vIOMMU model shares the
> >>     same stage-2 HW pagetable across all physical SMMUs with a shared
> >>     VMID. Then a stage-1 pagetable invalidation (for one device) at
> >>     the vSMMU would have to be broadcasted to all the SMMU instances,
> >>     which would hurt the overall performance.
> Well if there is a real production use case behind the requirement of
> having mutliple vSMMUs (and more generally vIOMMUs) sure you can go
> ahead. I just wanted to warn you that as far as I know multiple vIOMMUS
> are not supported even on Intel iommu and virtio-iommu. Let's add Peter
> Xu in CC. I foresee added complexicity with regard to how you define the
> RID scope of each vIOMMU, ACPI table generation, impact on arm-virt
> machine options, how you pass the feature associated to each instance,
> notifier propagation impact? And I don't evoke the VCMDQ feat addition.
> We are still far from having a singleton QEMU nested stage SMMU
> implementation at the moment but I understand you may want to feed the
> pipeline to pave the way for enhanced use cases.

I agree with Eric that we're still lacking quite a few things for >1
vIOMMUs support, afaik.

What you mentioned above makes sense to me from the POV that 1 vIOMMU may
not suffice, but that's at least totally new area to me because I never
used >1 IOMMUs even bare metal (excluding the case where I'm aware that
e.g. a GPU could have its own IOMMU-like dma translator).

What's the system layout of your multi-vIOMMU world?  Is there still a
centric vIOMMU, or multi-vIOMMUs can run fully in parallel, so that e.g. we
can have DEV1,DEV2 under vIOMMU1 and DEV3,DEV4 under vIOMMU2?  Can vIOMMU
get involved in any plug/unplug dynamically in any form?  What else can be
different from that regard?

Is it a common hardware layout or nVidia specific?

Thanks,

> 
> Thanks
> 
> Eric
> >>
> >> I previously discussed with Eric this topic in a private email. Eric
> >> felt the difficulty of implementing this in the current QEMU system,
> >> as it would touch different subsystems like IORT and platform device,
> >> since the passthrough devices would be attached to different vIOMMUs.
> >>
> >> Yet, given the situations above, it's likely the best by duplicating
> >> the vIOMMU instance corresponding to the number of the physical SMMU
> >> instances.
> >>
> >> So, I am sending this email to collect opinions on this and see what
> >> would be a potential TODO list if we decide to go on this path.

-- 
Peter Xu


