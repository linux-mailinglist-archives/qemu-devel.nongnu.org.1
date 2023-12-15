Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 109BB814035
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 03:48:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDyDw-0000UY-PB; Thu, 14 Dec 2023 21:46:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rDyDu-0000U1-9Y; Thu, 14 Dec 2023 21:46:46 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rDyDs-0001sA-El; Thu, 14 Dec 2023 21:46:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1702608404; x=1734144404;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=PQ4sktM+2+IAI/nSNMnL24ZHpp2LJ6Mxb2DMBxZImFc=;
 b=lmDorjrIgNeirH3ieb0TFP26q7xdBTEZbBEMFfGibeTLKS4WCoBSQmj8
 c7D9eidb0047ktDBzFh69JjZavX/srxyNI0M+ORcbdx95PdaJH1R0rbpV
 q9JnV5nodRu1zt5qgD3OF7PmSxMR4UZfKN/ovKPzowugKZwa7iqZuqxIk
 cN+O7reQozy6XZFIKk9tFvLpULeCjBpQuLcc+7aI5Ifig+FvMqNjNnddl
 kQRxdB90jeYLCA8dy2evzwvU8umawcGC9lWbdlbcljzLvqFpt+jMK9GcY
 bBlufO6v0lZOnzIgsS+0wl8CtW6zr991oR3OouDIap17RYLOGW6GfHfVH g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="2310546"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="2310546"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2023 18:46:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="918277476"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; d="scan'208";a="918277476"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmsmga001.fm.intel.com with ESMTP; 14 Dec 2023 18:46:36 -0800
Date: Fri, 15 Dec 2023 10:59:00 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Samuel Tardieu <sam@rfc1149.net>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-trivial@nongnu.org
Subject: Re: [PATCH] docs: fix typo
Message-ID: <ZXvA9IlOEZfVNzuO@intel.com>
References: <20231214225318.2391800-1-sam@rfc1149.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214225318.2391800-1-sam@rfc1149.net>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Dec 14, 2023 at 11:53:18PM +0100, Samuel Tardieu wrote:
> Date: Thu, 14 Dec 2023 23:53:18 +0100
> From: Samuel Tardieu <sam@rfc1149.net>
> Subject: [PATCH] docs: fix typo
> X-Mailer: git-send-email 2.42.0
> 
> Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
> ---

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

>  docs/tools/qemu-img.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
> index 4459c065f1..3653adb963 100644
> --- a/docs/tools/qemu-img.rst
> +++ b/docs/tools/qemu-img.rst
> @@ -406,7 +406,7 @@ Command description:
>    Compare exits with ``0`` in case the images are equal and with ``1``
>    in case the images differ. Other exit codes mean an error occurred during
>    execution and standard error output should contain an error message.
> -  The following table sumarizes all exit codes of the compare subcommand:
> +  The following table summarizes all exit codes of the compare subcommand:
>  
>    0
>      Images are identical (or requested help was printed)
> -- 
> 2.42.0
> 
> 

