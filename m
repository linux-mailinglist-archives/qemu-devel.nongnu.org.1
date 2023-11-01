Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF887DE907
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 00:32:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyKgB-0008VB-1v; Wed, 01 Nov 2023 19:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1qyKg4-0008Ua-0y; Wed, 01 Nov 2023 19:31:12 -0400
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1qyKg0-0006OQ-CS; Wed, 01 Nov 2023 19:31:11 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 3E66FB81AD4;
 Wed,  1 Nov 2023 23:30:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA2FC433C9;
 Wed,  1 Nov 2023 23:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1698881457;
 bh=JxUtRxESUN+aCwM4FjmhZNb0/hDgfR/VIt2KMA7rS1E=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=DP88gazjYIU5slexLf+BCn5Bm2j3gpXZFNWA0FG2TIxgYnb4g7AImjTvjCKL2HdWc
 4y4xb+xlbuYKl+pA+K73cFmjbr9HZBYUy1E2UoHsB/dqu1gzvjEsLfS/oDmmzRzmbY
 vuzMnkv2rJYXp0wqw3nHH+jicyHGtjFEIYMWGXUTUWPecZCl/k2GSXybMML7icJNMn
 TH1fTmzm+D/lYDUYN0js7x89Bj0TLeIdoTpwvFOAlOl4WI6DRItNguJ36NJSGoNEa2
 7LLJxAEHfqowxCdLuQA7C2r4bnWVR0fhMqXhHtzUhRVxBFJtreLAIkyLFCLr1htw0+
 IJDrKD2lEKTSw==
Date: Wed, 1 Nov 2023 16:30:55 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Vikram Garhwal <vikram.garhwal@amd.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, 
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
Subject: Re: [QEMU][PATCH v1] Xen: Fix xen_set_irq() and
 xendevicemodel_set_irq_level()
In-Reply-To: <20231101210724.27263-1-vikram.garhwal@amd.com>
Message-ID: <alpine.DEB.2.22.394.2311011630390.2125691@ubuntu-linux-20-04-desktop>
References: <20231101210724.27263-1-vikram.garhwal@amd.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=2604:1380:4601:e00::1;
 envelope-from=sstabellini@kernel.org; helo=ams.source.kernel.org
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, 1 Nov 2023, Vikram Garhwal wrote:
> Remove '=' from 'if CONFIG_XEN_CTRL_INTERFACE_VERSION <= 41500'.
> Because xendevicemodel_set_irq_level() was introduced in 4.15 version.
> 
> Also, update xendevicemodel_set_irq_level() to return -1 for older versions.
> 
> Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  hw/arm/xen_arm.c            | 4 +++-
>  include/hw/xen/xen_native.h | 4 ++--
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
> index f83b983ec5..a5631529d0 100644
> --- a/hw/arm/xen_arm.c
> +++ b/hw/arm/xen_arm.c
> @@ -75,7 +75,9 @@ static MemoryRegion ram_lo, ram_hi;
>  
>  static void xen_set_irq(void *opaque, int irq, int level)
>  {
> -    xendevicemodel_set_irq_level(xen_dmod, xen_domid, irq, level);
> +    if (xendevicemodel_set_irq_level(xen_dmod, xen_domid, irq, level)) {
> +        error_report("xendevicemodel_set_irq_level failed");
> +    }
>  }
>  
>  static void xen_create_virtio_mmio_devices(XenArmState *xam)
> diff --git a/include/hw/xen/xen_native.h b/include/hw/xen/xen_native.h
> index 5d2718261f..6f09c48823 100644
> --- a/include/hw/xen/xen_native.h
> +++ b/include/hw/xen/xen_native.h
> @@ -523,12 +523,12 @@ static inline int xen_set_ioreq_server_state(domid_t dom,
>                                                   enable);
>  }
>  
> -#if CONFIG_XEN_CTRL_INTERFACE_VERSION <= 41500
> +#if CONFIG_XEN_CTRL_INTERFACE_VERSION < 41500
>  static inline int xendevicemodel_set_irq_level(xendevicemodel_handle *dmod,
>                                                 domid_t domid, uint32_t irq,
>                                                 unsigned int level)
>  {
> -    return 0;
> +    return -1;
>  }
>  #endif
>  
> -- 
> 2.17.1
> 

