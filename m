Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29418747FB4
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 10:30:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGxsu-0008T8-BQ; Wed, 05 Jul 2023 04:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qGxsp-0008Rk-Fe
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 04:29:07 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qGxsn-0001f0-L0
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 04:29:07 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fbc5d5742eso65620435e9.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 01:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688545743; x=1691137743;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JZ/7Au/EgLOeJf9nTzpj6FxhVf5fm25gIjxIqFgfeW8=;
 b=ueAtvBo0WHs7bZG2ztxSEPZPpmsgFAZOgoeFDOR61211+JBUoxqh6cf4j0VS3MYdRf
 gZiXGvDj2o4QDAIhd0OAaa4MrhfQ2TeddWKCRBJxEg47hD1DZURpXyYjj74VQwFmQqM8
 qluTSbXFphpsh4U3MGDzCWb19PGt4yn5GTzk+zporG4FeP1Rmug6wU4oXZZ0vIe+Q/FY
 NJAP+n3ESlpdZB+swxOD4hDFUVW2254dFv0xvEKt5nHDG8b7o6tc5Rpt1DQ+wOn6K5H2
 nmRg44HkUj1vgwFAlL0U/B0kV+RitAjErtRHWcgqQdDtYdKTTOtSUT32vTErZhUJzsX4
 +cXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688545743; x=1691137743;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JZ/7Au/EgLOeJf9nTzpj6FxhVf5fm25gIjxIqFgfeW8=;
 b=Xwrwc0oG0JZtHEssBiL+/gOfkLoympOcEugg2bsWluLL6n6cm5znFfjk2sT5n/MAX8
 oGpDQivzVVRtxe9ggZMSMsb2hAn3ketyKtB5NhmHvGIq1ocxiQz2iEkFfW4FRj4gZH5n
 q7j6u8Qeb5OUY0fngbJ7m9ybg5mp3FERcJXq68rCd1J7jW4pjbQ/m3Lh1+7f8OA/iWQE
 NyPgKwuKXqMK4jJ/m5OemH1EXEqug24MYVL929EXLNFRRu1jP5dSIl69yBUMWkQMNRu8
 HBXGqsjsIpGVS/u/fA7KLbJWb+1QfVu/yxd5F5PBJc4Z7VwFXlsZDiiKh97bOofWv67i
 Zc1w==
X-Gm-Message-State: AC+VfDxtkhSpT/J29fOCvcOiG7PM+CFw4bIpBLK9KPLmprxM2eNg4Oo6
 AhC8n0SCA0rr0L6CC0g1hb490w==
X-Google-Smtp-Source: ACHHUZ5i9vVsB40JWKmZrT5V1HZcy+WvJ3btz7HGpgbTgYS2kBaCeLaA+xKUTIBVyZwC/aWh0xG0DA==
X-Received: by 2002:a05:600c:b59:b0:3f8:f4f3:82ec with SMTP id
 k25-20020a05600c0b5900b003f8f4f382ecmr14044262wmr.8.1688545743212; 
 Wed, 05 Jul 2023 01:29:03 -0700 (PDT)
Received: from myrica ([2.219.138.198]) by smtp.gmail.com with ESMTPSA id
 10-20020a05600c024a00b003fa98908014sm1441411wmj.8.2023.07.05.01.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 01:29:02 -0700 (PDT)
Date: Wed, 5 Jul 2023 09:29:02 +0100
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
Message-ID: <20230705082902.GA2234638@myrica>
References: <20230704111527.3424992-1-eric.auger@redhat.com>
 <20230704111527.3424992-2-eric.auger@redhat.com>
 <SJ0PR11MB674435F2BA42A8925ABA336F922FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR11MB674435F2BA42A8925ABA336F922FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Jul 05, 2023 at 04:52:09AM +0000, Duan, Zhenzhong wrote:
> Hi Eric,
> 
> >-----Original Message-----
> >From: Eric Auger <eric.auger@redhat.com>
> >Sent: Tuesday, July 4, 2023 7:15 PM
> >Subject: [PATCH 1/2] virtio-iommu: Fix 64kB host page size VFIO device
> >assignment
> >
> >When running on a 64kB page size host and protecting a VFIO device
> >with the virtio-iommu, qemu crashes with this kind of message:
> >
> >qemu-kvm: virtio-iommu page mask 0xfffffffffffff000 is incompatible
> >with mask 0x20010000
> 
> Does 0x20010000 mean only  512MB and 64KB super page mapping is
> supported for host iommu hw? 4KB mapping not supported?

It's not a restriction by the HW IOMMU, but the host kernel. An Arm SMMU
can implement 4KB, 16KB and/or 64KB granules, but the host kernel only
advertises through VFIO the granule corresponding to host PAGE_SIZE. This
restriction is done by arm_lpae_restrict_pgsizes() in order to choose a
page size when a device is driven by the host.

> 
> There is a check in guest kernel side hint only 4KB is supported, with
> this patch we force viommu->pgsize_bitmap to 0x20010000
> and fail below check? Does this device work in guest?
> Please correct me if I understand wrong.

Right, a guest using 4KB pages under a host that uses 64KB is not
supported, because if the guest attempts to dma_map a 4K page, the IOMMU
cannot create a mapping small enough, the mapping would have to spill over
neighbouring guest memory.

One possible solution would be supporting multiple page granules. If we
added a page granule negotiation through VFIO and virtio-iommu then the
guest could pick the page size it wants. But this requires changes to
Linux UAPI so isn't a priority at the moment, because we're trying to
enable nesting which would support 64K-host/4K-guest as well.

See also the discussion on the patch that introduced the guest check
https://lore.kernel.org/linux-iommu/20200318114047.1518048-1-jean-philippe@linaro.org/

Thanks,
Jean


