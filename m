Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4236A814372
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 09:20:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rE3Pd-0002v0-AF; Fri, 15 Dec 2023 03:19:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rE3Pb-0002uk-OZ; Fri, 15 Dec 2023 03:19:11 -0500
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rE3PZ-00072d-RK; Fri, 15 Dec 2023 03:19:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1702628349; x=1734164349;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=C+2+GtrS8RUMQktaBRqf5O68yI801370624j2VGpIZI=;
 b=DTH2PeKmCL9ejbVsjRKKrDG9gGdI0OJMGFckwV1Kl32dWQTTluvvsL3S
 R2FRJ7oNkHABR1wx1Bzoj9X8QVkZVRbFsbG5SNiRe9bu/3ocqLFt7+NXs
 m9r96XKOFlUxnsiNQDr5fxQxVXRD1WNyGMq2EhSNagAKgE2fPRW5WP6Uy
 AelxQ+ALIcXsYK6OZJadtHtaFPPg3F4xTZbhlrU842ZKTJNbkwGhcouTS
 SXWXx/uc1gfQNBdrF+P6n3Juw9RAsUdg9+7DbH26ILLkasNRupmer6M7C
 pQX2m7UTV0OpRj0rLglqZCWAT6ktjp/Cjx0zuI25/Dickw/Df1Q7EtbB/ Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="399084149"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; d="scan'208";a="399084149"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2023 00:19:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="892800614"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; d="scan'208";a="892800614"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmsmga002.fm.intel.com with ESMTP; 15 Dec 2023 00:19:02 -0800
Date: Fri, 15 Dec 2023 16:31:26 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 4/4] target: Restrict 'sysemu/reset.h' to system emulation
Message-ID: <ZXwO3igZsJBXOkZl@intel.com>
References: <20231212113640.30287-1-philmd@linaro.org>
 <20231212113640.30287-5-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231212113640.30287-5-philmd@linaro.org>
Received-SPF: pass client-ip=134.134.136.65; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Dec 12, 2023 at 12:36:40PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Tue, 12 Dec 2023 12:36:40 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH 4/4] target: Restrict 'sysemu/reset.h' to system emulation
> X-Mailer: git-send-email 2.41.0
> 
> vCPU "reset" is only possible with system emulation.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Warner Losh <imp@bsdimp.com>
> Reviewed-by: Song Gao <gaosong@loongson.cn>
> ---

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

>  target/i386/cpu.c      | 2 +-
>  target/loongarch/cpu.c | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index dfb96217ad..17b6962d43 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -24,7 +24,6 @@
>  #include "qemu/hw-version.h"
>  #include "cpu.h"
>  #include "tcg/helper-tcg.h"
> -#include "sysemu/reset.h"
>  #include "sysemu/hvf.h"
>  #include "hvf/hvf-i386.h"
>  #include "kvm/kvm_i386.h"
> @@ -37,6 +36,7 @@
>  #include "hw/qdev-properties.h"
>  #include "hw/i386/topology.h"
>  #ifndef CONFIG_USER_ONLY
> +#include "sysemu/reset.h"
>  #include "qapi/qapi-commands-machine-target.h"
>  #include "exec/address-spaces.h"
>  #include "hw/boards.h"
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index fc075952e6..b26187dfde 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -17,7 +17,9 @@
>  #include "internals.h"
>  #include "fpu/softfloat-helpers.h"
>  #include "cpu-csr.h"
> +#ifndef CONFIG_USER_ONLY
>  #include "sysemu/reset.h"
> +#endif
>  #include "tcg/tcg.h"
>  #include "vec.h"
>  
> -- 
> 2.41.0
> 
> 

