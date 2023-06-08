Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B45E372819A
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:43:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7FuS-0004Tb-1b; Thu, 08 Jun 2023 09:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q7FuP-0004TJ-EI
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:42:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q7FuM-0000rf-8T
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686231752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t0DsA7/iZBfEuwPUUBpnhmEOCxAV6sGADipRpkxUWtA=;
 b=Q3CfTDPSAT5K3w2lwaanzt7yRpRDL8bQ4ehe0ZtE371ErI9Oia+nR5iO1od3F/c9RRCSxn
 z/DHyNniFGp8loAN6eL93c8oXeW4BhLw2BLWBurHc7XTrxHJ68x2Fqn5/0LfsgunAFfet6
 9e5ltld19I3NuISyN0A+/OQmtkpB8QE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-_Bihtc9aMom9fisDjY5KuQ-1; Thu, 08 Jun 2023 09:42:31 -0400
X-MC-Unique: _Bihtc9aMom9fisDjY5KuQ-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-75e681229c5so14277285a.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 06:42:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686231750; x=1688823750;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t0DsA7/iZBfEuwPUUBpnhmEOCxAV6sGADipRpkxUWtA=;
 b=jhEIfAFE3MSXWKHdZ4KIUgrhQqdAlyXo5hc66DcAzBHD9++PzXz0p4V6LJ2IysCvph
 hCD69bd1TD9/XTL5qNd8x+Z4eoJJ8gy8/42SoWvIAwkok3MFC0w6jvaTYX0teAitVOTf
 Od6hCiYJCJ2YMBxIq9HZV551HMuajF4NMEvVL4+89XM42iaYzD+IMoHBEGO5Gk3YKnJ+
 L6zkmlz6pOMRQ/0b6mZsBzuiX/b7IOvq8Z2n52IOV1ZFYPmsijnaviO1TOGyBegzx2Eb
 4bTFdPhBh7M806ChlSdgsBkBN3CnDxBkN0eLJs3FtNUfSDachToo1arMwlaT7Gk/m1WC
 Jg0g==
X-Gm-Message-State: AC+VfDyk22WXUP9UF5n8ftP+g0elsGPheW3RkhJzCD6jUIA2ilQ/2NnL
 awdvHO9WNrII+UlaubE7iDjzOM6/NDFFz3Gug97YZcd5NMK6po2x+4p9ymM3O+cQx52ZgPyXVQf
 a9SGR2z2He8vSTgg=
X-Received: by 2002:a05:620a:2993:b0:75b:23a1:69e9 with SMTP id
 r19-20020a05620a299300b0075b23a169e9mr6499459qkp.0.1686231750689; 
 Thu, 08 Jun 2023 06:42:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5RkF0Bh+deDKoMcAkr8Yph81MAHqnlzjF5jqgfi5I7B2JEqVmlGvANfi1Wzc9/QLY0NgMhZQ==
X-Received: by 2002:a05:620a:2993:b0:75b:23a1:69e9 with SMTP id
 r19-20020a05620a299300b0075b23a169e9mr6499431qkp.0.1686231750369; 
 Thu, 08 Jun 2023 06:42:30 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 e17-20020a05620a12d100b0075cc95eb30asm340491qkl.8.2023.06.08.06.42.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 06:42:29 -0700 (PDT)
Date: Thu, 8 Jun 2023 09:42:27 -0400
From: Peter Xu <peterx@redhat.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 pbonzini@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 alex.williamson@redhat.com, clg@redhat.com, david@redhat.com,
 philmd@linaro.org, kwankhede@nvidia.com, cjia@nvidia.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com
Subject: Re: [PATCH v3 2/5] intel_iommu: Fix a potential issue in VFIO dirty
 page sync
Message-ID: <ZIHaw/GvVgD8C5qp@x1n>
References: <20230608095231.225450-1-zhenzhong.duan@intel.com>
 <20230608095231.225450-3-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230608095231.225450-3-zhenzhong.duan@intel.com>
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

On Thu, Jun 08, 2023 at 05:52:28PM +0800, Zhenzhong Duan wrote:
> Peter Xu found a potential issue:
> 
> "The other thing is when I am looking at the new code I found that we
> actually extended the replay() to be used also in dirty tracking of vfio,
> in vfio_sync_dirty_bitmap().  For that maybe it's already broken if
> unmap_all() because afaiu log_sync() can be called in migration thread
> anytime during DMA so I think it means the device is prone to DMA with the
> IOMMU pgtable quickly erased and rebuilt here, which means the DMA could
> fail unexpectedly.  Copy Alex, Kirti and Neo."
> 
> Fix it by replacing the unmap_all() to only evacuate the iova tree
> (keeping all host mappings untouched, IOW, don't notify UNMAP), and
> do a full resync in page walk which will notify all existing mappings
> as MAP. This way we don't interrupt with any existing mapping if there
> is (e.g. for the dirty sync case), meanwhile we keep sync too to latest
> (for moving a vfio device into an existing iommu group).
> 
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


