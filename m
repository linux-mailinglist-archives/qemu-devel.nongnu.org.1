Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 610B9728237
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 16:06:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7GGx-00066W-5t; Thu, 08 Jun 2023 10:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q7GGu-000665-VI
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 10:05:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q7GGo-0007UQ-6Q
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 10:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686233128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+GquqxJP/69lKChgbg6fJKm+QoOhoDvmyxV0ZRTmlHk=;
 b=fQXCtgYLCWCKQDdL9GDxh6gfokBOl23sGM1DP0tubGmTnQuM6DeH/9n5OyP+2HDGEW/5Tg
 LkS+J98M6FQhaSaUn+vu5adUb7sT3n/mx7PjiL/ZhjnHqcHkEdNew6lUVh70OEiV+EfObv
 FHxpQ9cRPdbV+ArOtX01EnhHKB48peE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-O4VHr7dHNbOdrseEQogZZw-1; Thu, 08 Jun 2023 10:05:11 -0400
X-MC-Unique: O4VHr7dHNbOdrseEQogZZw-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-62632620f00so1600966d6.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 07:05:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686233111; x=1688825111;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+GquqxJP/69lKChgbg6fJKm+QoOhoDvmyxV0ZRTmlHk=;
 b=GQJjmV452f/olg9fit8zmwWmxhFRoizW1HMdWbb0nd1kxfTM7vHpPUP80VeHeGqJhn
 recdHDwl8uryj0EHKEL4sv8RFz8tWZSVeVhRNX/HDMdLRzo00SE9fTn54Khp/B5BahwJ
 UgdbB0QJUZhaoAS6dF+jiHW2InihEQQkNhghfISoZ65HdvktFP14HpI2HofM46QbDUtv
 Veqg8R8I6+/WCmcj490FWRHdfPTVqlDvaEVpK1fazpwJK+LpEFcV6WpK6nwBKu0S52rK
 WAkjRcVgcDF+dtCiu30lSWnUeEn9Hr3r7vWcUkGu3A/bHiMWRZ5b+YH8yDjGg1B7E9if
 AOLw==
X-Gm-Message-State: AC+VfDw4cddQJwGcxpjf88QTWjPyKSXFUeyvm/c6q9xSpjxPrZLj25hz
 w4errTtXjVviUR8saOBhcEsEB96unvHFpI2uo8StuumzxH4raSFOE4a8XntKKQyRQAfyg2f7Vgu
 Z/xpOK5u3ytx19h4=
X-Received: by 2002:a05:6214:5086:b0:626:273e:c35c with SMTP id
 kk6-20020a056214508600b00626273ec35cmr5923485qvb.2.1686233110704; 
 Thu, 08 Jun 2023 07:05:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Wm86ouW9Fh5+uo80fRXJDMMhVIG5uDSBAfcyyeFiAwgcbT0Ae1GuReVxPt60hjSsizcv9FQ==
X-Received: by 2002:a05:6214:5086:b0:626:273e:c35c with SMTP id
 kk6-20020a056214508600b00626273ec35cmr5923437qvb.2.1686233110333; 
 Thu, 08 Jun 2023 07:05:10 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 m24-20020ae9e718000000b007578622c861sm331120qka.108.2023.06.08.07.05.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 07:05:09 -0700 (PDT)
Date: Thu, 8 Jun 2023 10:05:08 -0400
From: Peter Xu <peterx@redhat.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 pbonzini@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 alex.williamson@redhat.com, clg@redhat.com, david@redhat.com,
 philmd@linaro.org, kwankhede@nvidia.com, cjia@nvidia.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com
Subject: Re: [PATCH v3 5/5] intel_iommu: Optimize out some unnecessary UNMAP
 calls
Message-ID: <ZIHgFFSaBJWFUNd7@x1n>
References: <20230608095231.225450-1-zhenzhong.duan@intel.com>
 <20230608095231.225450-6-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230608095231.225450-6-zhenzhong.duan@intel.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, Jun 08, 2023 at 05:52:31PM +0800, Zhenzhong Duan wrote:
> Commit 63b88968f1 ("intel-iommu: rework the page walk logic") adds logic
> to record mapped IOVA ranges so we only need to send MAP or UNMAP when
> necessary. But there is still a corner case of unnecessary UNMAP.
> 
> During invalidation, either domain or device selective, we only need to
> unmap when there are recorded mapped IOVA ranges, presuming most of OSes
> allocating IOVA range continuously, e.g. on x86, linux sets up mapping
> from 0xffffffff downwards.
> 
> Strace shows UNMAP ioctl taking 0.000014us and we have 28 such ioctl()
> in one invalidation, as two notifiers in x86 are split into power of 2
> pieces.
> 
> ioctl(48, VFIO_IOMMU_UNMAP_DMA, 0x7ffffd5c42f0) = 0 <0.000014>

Thanks for the numbers, but for a fair comparison IMHO it needs to be a
comparison of before/after on the whole time used for unmap AS.  It'll be
great to have finer granule measurements like each ioctl, but the total
time used should be more important (especially to contain "after"). Side
note: I don't think the UNMAP ioctl will take the same time; it should
matter on whether there's mapping exist).

Actually it's hard to tell because this also depends on what's in the iova
tree.. but still at least we know how it works in some cases.

> 
> The other purpose of this patch is to eliminate noisy error log when we
> work with IOMMUFD. It looks the duplicate UNMAP call will fail with IOMMUFD
> while always succeed with legacy container. This behavior difference leads
> to below error log for IOMMUFD:
> 
> IOMMU_IOAS_UNMAP failed: No such file or directory
> vfio_container_dma_unmap(0x562012d6b6d0, 0x0, 0x80000000) = -2 (No such file or directory)
> IOMMU_IOAS_UNMAP failed: No such file or directory
> vfio_container_dma_unmap(0x562012d6b6d0, 0x80000000, 0x40000000) = -2 (No such file or directory)
> ...

My gut feeling is the major motivation is actually this (not the perf).
tens of some 14us ioctls is really nothing on a rare event..

Jason Wang raised a question in previous version and I think JasonG's reply
is here:

https://lore.kernel.org/r/ZHTaQXd3ZybmhCLb@nvidia.com

JasonG: sorry I know zero on iommufd api yet, but you said:

        The VFIO emulation functions should do whatever VFIO does, is there
        a mistake there?

IIUC what VFIO does here is it returns succeed if unmap over nothing rather
than failing like iommufd.  Curious (like JasonW) on why that retval?  I'd
assume for returning "how much unmapped" we can at least still return 0 for
nothing.

Are you probably suggesting that we can probably handle that in QEMU side
on -ENOENT here for iommufd only (a question to Yi?).

If that's already a kernel abi, not sure whether it's even discussable, but
just to raise this up.

-- 
Peter Xu


