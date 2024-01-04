Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6593B8245F4
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 17:15:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLQMT-0004hL-2H; Thu, 04 Jan 2024 11:14:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rLQMM-0004gw-NF
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:14:18 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rLQMJ-0002ws-TL
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:14:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1704384856; x=1735920856;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=GyG58qjtlD6A9ubA7JmpOD9H93YdHIfHPaTbFgmjR14=;
 b=LNWhMZccsD0PJ1oIu7K6el8K0/zjskcXdJS8yMQyVuUSYR7Mh+B0BXFK
 ghVw89Rj6woBw3ExA60EwhtCi6t3wPMwo2jBhrvbPaDRrDRYU91qxKrLI
 OEfGkW04KJgLOsAmHE56RljUzJ5Vpn8NhsYrcU5BVOzjUQ9yCzV6e8ItQ
 mGSFhEOFV5e7o7ul1KrAWHU+jVBiYRTcDNGLziIDw7eHf0K96jQnv0nUA
 chkDmnoMbucK2rJIZMN26ShLdbSyEYtibuACDT0go/TS86jnPuci/t5+a
 6+d+pYUAG6wj4FWGaGqvw8ydZXNQeJf7HVqzxJny7p7kJzOlYsI9AqaSb Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="4384834"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="4384834"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jan 2024 08:14:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="773562200"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; d="scan'208";a="773562200"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orsmga007.jf.intel.com with ESMTP; 04 Jan 2024 08:14:10 -0800
Date: Fri, 5 Jan 2024 00:27:03 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Srikanth Aithal <srikanth.aithal@amd.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com,
 nikunj@amd.com
Subject: Re: [PATCH] target/i386/sev: Fix a segfault in sev_kvm_init
Message-ID: <ZZbcVwOxISsgr4gW@intel.com>
References: <20240104104820.14422-1-srikanth.aithal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104104820.14422-1-srikanth.aithal@amd.com>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.691,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, Jan 04, 2024 at 04:18:20PM +0530, Srikanth Aithal wrote:
> Date: Thu, 4 Jan 2024 16:18:20 +0530
> From: Srikanth Aithal <srikanth.aithal@amd.com>
> Subject: [PATCH] target/i386/sev: Fix a segfault in sev_kvm_init
> X-Mailer: git-send-email 2.34.1
> 
> Propogate error code using errp in sev_kvm_init.
> 
> Before fix:
> qemu-system-x86_64: sev_kvm_init: guest policy requires SEV-ES,
> but host SEV-ES support unavailable
> 27747 Segmentation fault      (core dumped)
> 
> After fix:
> qemu-system-x86_64: sev_kvm_init: guest policy requires SEV-ES,
> but host SEV-ES support unavailable
> qemu-system-x86_64: failed to initialize kvm: Operation not permitted
> 
> While at it, also fix two more locations.
> 
> Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
> Signed-off-by: Srikanth Aithal <srikanth.aithal@amd.com>
> ---
>  target/i386/sev.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> 
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 9a71246682..c0a4d5e535 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -922,7 +922,8 @@ int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
>  
>      ret = ram_block_discard_disable(true);
>      if (ret) {
> -        error_report("%s: cannot disable RAM discard", __func__);
> +        error_setg(errp, "%s: cannot disable "
> +                     "RAM discard", __func__);
>          return -1;
>      }
>  
> @@ -979,13 +980,13 @@ int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
>  
>      if (sev_es_enabled()) {
>          if (!kvm_kernel_irqchip_allowed()) {
> -            error_report("%s: SEV-ES guests require in-kernel irqchip support",
> -                         __func__);
> +            error_setg(errp, "%s: SEV-ES guests require in-kernel "
> +                         "irqchip support", __func__);
>              goto err;
>          }
>  
>          if (!(status.flags & SEV_STATUS_FLAGS_CONFIG_ES)) {
> -            error_report("%s: guest policy requires SEV-ES, but "
> +            error_setg(errp, "%s: guest policy requires SEV-ES, but "
>                           "host SEV-ES support unavailable",
>                           __func__);
>              goto err;
> -- 
> 2.34.1
> 
> 

