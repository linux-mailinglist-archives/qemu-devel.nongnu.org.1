Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6A27281B0
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:48:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Fzm-0008KN-2E; Thu, 08 Jun 2023 09:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q7Fzj-0008K1-UM
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:48:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q7Fzi-0002Fj-GK
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686232085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qJe6s6wudXu9sv06j8efj+S2vR8CVODsEIJQCLyCFkc=;
 b=d6uwb4E3jgF7r/r0/dFC2lVPjn6WN2dp+nLqtpWHGcXs82z37eEEGcDxwlufOHSxvCEMVG
 AmGp2ee9sFDwLd1L6z6Wy0V0+Mr+s2LRFaL20NZOzceopsW5EbZTGQmjsUrMCOu20Vz0sx
 UJxR+xr8mvntzRu2fESO4o0M9nNP1BM=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-D1n7vTieOuaK-6vBvxCo0A-1; Thu, 08 Jun 2023 09:48:04 -0400
X-MC-Unique: D1n7vTieOuaK-6vBvxCo0A-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-19f96870cbfso119994fac.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 06:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686232083; x=1688824083;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qJe6s6wudXu9sv06j8efj+S2vR8CVODsEIJQCLyCFkc=;
 b=JBfOOzEM4qbOhm/GCiRqxwpDjrNic/Lh5vZr36LIKCUyBAjfuU0a5AKiVaLA6YviVr
 A60nUXi9yXMsl3xburcLNBzcZtB52+6TMghiKxc+OTS497mxa4lg5m0q+Y7f2MhkpDHK
 6fe7ktk+EsJWf2v6S1RF0jRHA6ZrpQMMpshk++bQcVfzW0O+9E4xfHWNlBZyonaTSJKh
 LIr1wCjH2w1CtMcObfq0zYRoGpA9el2SjccfxHR3eDqfUDv0fnNoU9apztQRMRWPhECA
 svB2ftzv19Z9sVOF10MYrz0k3C3aq1fh+gQtkGyyA/KUGONBgI2iZ5bPkOaL38GsBhma
 i9FQ==
X-Gm-Message-State: AC+VfDxOjCdoxoCoPEtWr/uIGy8GTQ32rLKqZA3umLCxWC4oXK4MGJ1S
 CENcy+BSx6oAFhgCxfSfM80YzDb+0a/g3Dmvkx7BGB8bure2yisWGyVOFo4p6aNHqwC0aDY+HIL
 xnNRUGb8eVvdBDc0=
X-Received: by 2002:a05:6870:7388:b0:187:7a49:d227 with SMTP id
 z8-20020a056870738800b001877a49d227mr4082458oam.5.1686232083394; 
 Thu, 08 Jun 2023 06:48:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7tAY8U88oejwArrziuKNafXH1rQB7JrnfVgIijKyulsa8bRRhBclu+pXxwQ5gibZ2B8XLWFw==
X-Received: by 2002:a05:6870:7388:b0:187:7a49:d227 with SMTP id
 z8-20020a056870738800b001877a49d227mr4082431oam.5.1686232083142; 
 Thu, 08 Jun 2023 06:48:03 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 ey14-20020a05622a4c0e00b003f98ccee846sm344947qtb.75.2023.06.08.06.48.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 06:48:02 -0700 (PDT)
Date: Thu, 8 Jun 2023 09:48:00 -0400
From: Peter Xu <peterx@redhat.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 pbonzini@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 alex.williamson@redhat.com, clg@redhat.com, david@redhat.com,
 philmd@linaro.org, kwankhede@nvidia.com, cjia@nvidia.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com
Subject: Re: [PATCH v3 4/5] intel_iommu: Fix address space unmap
Message-ID: <ZIHcEMO2ZWp636t+@x1n>
References: <20230608095231.225450-1-zhenzhong.duan@intel.com>
 <20230608095231.225450-5-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230608095231.225450-5-zhenzhong.duan@intel.com>
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

On Thu, Jun 08, 2023 at 05:52:30PM +0800, Zhenzhong Duan wrote:
> During address space unmap, corresponding IOVA tree entries are
> also removed. But DMAMap is set beyond notifier's scope by 1, so
> in theory there is possibility to remove a continuous entry above
> the notifier's scope but falling in adjacent notifier's scope.

This function is only called in "loop over all notifiers" case (or replay()
that just got removed, but even so there'll be only 1 notifier normally
iiuc at least for vt-d), hopefully it means no bug exist (no Fixes needed,
no backport needed either), but still worth fixing it up.

> 
> There is no issue currently as no use cases allocate notifiers
> continuously, but let's be robust.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


