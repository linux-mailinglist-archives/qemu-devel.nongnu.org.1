Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB2272819B
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:43:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Fv9-0004np-Mk; Thu, 08 Jun 2023 09:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q7Fv7-0004nQ-Ev
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:43:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q7Fv6-00014V-2x
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:43:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686231799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LauZvXyBM+3RLFUAeTc/NVl6D6L8sP2JOSyZ0/gfv3s=;
 b=Ug/WaY3SojglBJQAXiqktbUWdfE3SaMUT4xHfftaUgTZjq059YwghWAUllg1EVgE3gLwOL
 ur8YrG+YISUVHYLxchzk/jpyp8HrTf+8pJyuNCvhPHOJjE7gbyh/GJOsd+Vtu05enHJ6if
 zb4X1CSdYfntxaskJI24AaraFkH9yAc=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-GG91U3hcMV-DzMAGWKMSXg-1; Thu, 08 Jun 2023 09:43:17 -0400
X-MC-Unique: GG91U3hcMV-DzMAGWKMSXg-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-39c12f44252so56282b6e.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 06:43:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686231797; x=1688823797;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LauZvXyBM+3RLFUAeTc/NVl6D6L8sP2JOSyZ0/gfv3s=;
 b=GrVRSjJyEKgLIMpNAQYl6EyhfffB77ahtAkJjh3Bwv3xe65LQ8t/uw2FZnvtCpepIv
 iF/bWmp7jguhaGrV2m+lyzDD001NWJvIQNYRiS3NXkDKpe/xxI6JCtF/Ydh6jeNcPnU3
 BQPOgXc476IsbC2rDvMqv2KYrcbcf3ERXfK6rvQ36WR/GYubISRllQzgwl6wIbX1/lSN
 6NJ30a82e9RjPC+zGrmNIEYvJrkv2W+kSPox7WBsBQAjfWLv9QalzEXbMtGDBFVq0mox
 afVD149FELpmLXhnTD3rebXjzXgxMSr1J3RBhlZGMBaGtMf/RYaLJfQoqxf/ALQkHx5I
 cBjg==
X-Gm-Message-State: AC+VfDzbD7UHjiXgkS9Nw/jFzpr0GYB3k0w2ux7lBPugzltHu3B/YXlf
 K1h+C6QwgjdUlfwwdubFbL5uYUMBpdAe7X/3Y+/92FMT2V6h7UdsH9heiqapRtwdjqR41y/1JX4
 FkVmIlRbZ9DE8aTI=
X-Received: by 2002:aca:de8b:0:b0:39a:aa9d:916 with SMTP id
 v133-20020acade8b000000b0039aaa9d0916mr3139074oig.4.1686231797197; 
 Thu, 08 Jun 2023 06:43:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5lIBItdeulxVxJJIcU3LmgIptH9j1zE+6YWtz22fILuQyz8coms/EClktDRnPkzw4QfpKENw==
X-Received: by 2002:aca:de8b:0:b0:39a:aa9d:916 with SMTP id
 v133-20020acade8b000000b0039aaa9d0916mr3139048oig.4.1686231796984; 
 Thu, 08 Jun 2023 06:43:16 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 g29-20020a0caadd000000b0062168714c8fsm395687qvb.120.2023.06.08.06.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 06:43:16 -0700 (PDT)
Date: Thu, 8 Jun 2023 09:43:14 -0400
From: Peter Xu <peterx@redhat.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 pbonzini@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 alex.williamson@redhat.com, clg@redhat.com, david@redhat.com,
 philmd@linaro.org, kwankhede@nvidia.com, cjia@nvidia.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com
Subject: Re: [PATCH v3 3/5] intel_iommu: Fix flag check in replay
Message-ID: <ZIHa8tjgL+Wbl2Xa@x1n>
References: <20230608095231.225450-1-zhenzhong.duan@intel.com>
 <20230608095231.225450-4-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230608095231.225450-4-zhenzhong.duan@intel.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Jun 08, 2023 at 05:52:29PM +0800, Zhenzhong Duan wrote:
> Replay doesn't notify registered notifiers but the one passed
> to it. So it's meaningless to check the registered notifier's
> synthetic flag.
> 
> There is no issue currently as all replay use cases have MAP
> flag set, but let's be robust.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


