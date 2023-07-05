Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 200917482EF
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 13:34:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH0l2-0005qW-R9; Wed, 05 Jul 2023 07:33:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qH0l0-0005pL-KR
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 07:33:14 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qH0ky-0000wR-3q
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 07:33:14 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fbc54cab6fso59274345e9.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 04:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688556786; x=1691148786;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=d9OeV4Azz5FNN4zDVHuiAiDcX7+Unc+PeJIK+IFYXfI=;
 b=aw7QOlkwo9IIPYXRIjhjkLhU6ktiv0/Q5ydkkhLMCM+IBzSZXAyM2AsPvAOzLLL6X/
 fTGBgck6ykk1HyimJSxeuioEjTuVdU//F8+5xlMPueVSQIWQBJjgmxoe7nCdUdLNAAst
 +dK0TisJR4U9C3gKExC/lApCNpZqskaKAPY1Mt3KnBAJQ43C2MOGSXOuLnyoTHLRIJmA
 8KE0CR7ecoNyOAB3nUg3ylkCHZa3Gbi7LlLRaDX7LGRz9sWGfrc/F0aJ16/fq+Ay8Ctk
 9XCEe+GKgjPIbiSZUv1Qmlv6B/SRVDdtrvcH/3fGATAz4qQ4mkvtADSzdSWmcQbXkYbt
 B3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688556786; x=1691148786;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d9OeV4Azz5FNN4zDVHuiAiDcX7+Unc+PeJIK+IFYXfI=;
 b=Ng0DOLYHJSNdAb/hb248b5ftHmCHOCmFrUQifaJC1DPc+fnb0hAF0doh7razYsMXF/
 GjGIgJW+wgmw+/lPKQ846RyI+vC58R6UDrSDaiNxYuRfnXsfxOLteQfrkYj25+D9CIqh
 ULRnCB1i8fOTWXI7bhJ8PISL6n00OoKLPKrGux2AxYbxV+nL+KTyk4SWdwLhk4QvYv91
 T3Pim5nmV0YzsF0QLLarl84qRtHwdjBAdq4zHw2P3hk5NNAQJxYDiB//x5w9ZKaS2tqp
 Q5DyKWoy2mlbswR50y+viL7lXsdNVJLGdQL4dysOcBbkVDL5ZRRpLghCBr6ezPZT7Jvy
 TOaQ==
X-Gm-Message-State: AC+VfDxrQ1OVDcUH9qjXMW1kLgnFJl1iG255PTNvcqkxSSHv1TjgSUu3
 wqECXl1My7SQxAJeIYPhe0upGw==
X-Google-Smtp-Source: ACHHUZ6P2TW2qJrhI1uPXdq37D74NUpdUs4lI9Avxn5fRPL+ZyCUgMLOWS9u+MGvkXhYwIyKkXlC9w==
X-Received: by 2002:a1c:720f:0:b0:3f7:a552:2ec7 with SMTP id
 n15-20020a1c720f000000b003f7a5522ec7mr12790316wmc.33.1688556786579; 
 Wed, 05 Jul 2023 04:33:06 -0700 (PDT)
Received: from myrica ([2.219.138.198]) by smtp.gmail.com with ESMTPSA id
 u4-20020a5d5144000000b0031444673643sm2568202wrt.57.2023.07.05.04.33.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 04:33:06 -0700 (PDT)
Date: Wed, 5 Jul 2023 12:33:05 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: Eric Auger <eric.auger@redhat.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhap.com" <clg@redhap.com>,
 "bharat.bhushan@nxp.com" <bharat.bhushan@nxp.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/2] virtio-iommu: Fix 64kB host page size VFIO device
 assignment
Message-ID: <20230705113305.GA2267040@myrica>
References: <20230704111527.3424992-1-eric.auger@redhat.com>
 <20230704111527.3424992-2-eric.auger@redhat.com>
 <SJ0PR11MB674435F2BA42A8925ABA336F922FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <20230705082902.GA2234638@myrica>
 <SJ0PR11MB674426C1F9AB893C82E371A4922FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR11MB674426C1F9AB893C82E371A4922FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Jul 05, 2023 at 10:13:11AM +0000, Duan, Zhenzhong wrote:
> >-----Original Message-----
> >From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> >Sent: Wednesday, July 5, 2023 4:29 PM
> >Subject: Re: [PATCH 1/2] virtio-iommu: Fix 64kB host page size VFIO device
> >assignment
> >
> >On Wed, Jul 05, 2023 at 04:52:09AM +0000, Duan, Zhenzhong wrote:
> >> Hi Eric,
> >>
> >> >-----Original Message-----
> >> >From: Eric Auger <eric.auger@redhat.com>
> >> >Sent: Tuesday, July 4, 2023 7:15 PM
> >> >Subject: [PATCH 1/2] virtio-iommu: Fix 64kB host page size VFIO
> >> >device assignment
> >> >
> >> >When running on a 64kB page size host and protecting a VFIO device
> >> >with the virtio-iommu, qemu crashes with this kind of message:
> >> >
> >> >qemu-kvm: virtio-iommu page mask 0xfffffffffffff000 is incompatible
> >> >with mask 0x20010000
> >>
> >> Does 0x20010000 mean only  512MB and 64KB super page mapping is
> >> supported for host iommu hw? 4KB mapping not supported?
> >
> >It's not a restriction by the HW IOMMU, but the host kernel. An Arm SMMU
> >can implement 4KB, 16KB and/or 64KB granules, but the host kernel only
> >advertises through VFIO the granule corresponding to host PAGE_SIZE. This
> >restriction is done by arm_lpae_restrict_pgsizes() in order to choose a page
> >size when a device is driven by the host.
> 
> Just curious why not advertises the Arm SMMU implemented granules to VFIO
> Eg:4KB, 16KB or 64KB granules?

That's possible, but the difficulty is setting up the page table
configuration afterwards. At the moment the host installs the HW page
tables early, when QEMU sets up the VFIO container. That initializes the
page size bitmap because configuring the HW page tables requires picking
one of the supported granules (setting TG0 in the SMMU Context
Descriptor).

If the guest could pick a granule via an ATTACH request, then QEMU would
need to tell the host kernel to install page tables with the desired
granule at that point. That would require a new interface in VFIO to
reconfigure a live container and replace the existing HW page tables
configuration (before ATTACH, the container must already be configured
with working page tables in order to implement boot-bypass, I think).

> But arm_lpae_restrict_pgsizes() restricted ones,
> Eg: for SZ_4K, (SZ_4K | SZ_2M | SZ_1G).
> (SZ_4K | SZ_2M | SZ_1G) looks not real hardware granules of Arm SMMU.

Yes, the granule here is 4K, and other bits only indicate huge page sizes,
so the user can try to optimize large mappings to use fewer TLB entries
where possible.

Thanks,
Jean

