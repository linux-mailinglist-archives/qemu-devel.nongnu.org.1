Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAA1822F25
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 15:04:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL1qj-0006Ph-QS; Wed, 03 Jan 2024 09:04:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rL1qi-0006PH-3D; Wed, 03 Jan 2024 09:04:00 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rL1qf-00089x-QT; Wed, 03 Jan 2024 09:03:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1704290638; x=1735826638;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=d+ImrcDJqLQslhu3APzH++8RCVdCrKFJ6XROL6rjdU4=;
 b=lvk0tHCVtQroQiamTdxKFK+hH9q+ZURAE5xeF0aSJo61sbJA8sqs0f2j
 hIU94+ppZmdc7VoeU19zTLEC7lXDu410GElKKjx72FbY6M77KSPMox5BM
 4/uULg7MBDgeAGf0Z8MCL98OiMurqlpRzaOy6pJPzmJFU5G13kh2Ok+KU
 CThci9eJ+N8Ya3El7B9upcDi5bcxA9q0/G/55cgts48X5IxlKuG5cSX66
 HJwNN46MMIqgXa44l8vLJ2rK07oelychxqrUMQergH/SiAY0uxisLjV39
 9aeXBmSFeJJocF1zIFBr+Nv6i+XfnDvi8iiCHvHVs+LF5GFKp+pPrqi9L A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="10611044"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; d="scan'208";a="10611044"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jan 2024 06:03:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="903446706"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; d="scan'208";a="903446706"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orsmga004.jf.intel.com with ESMTP; 03 Jan 2024 06:03:47 -0800
Date: Wed, 3 Jan 2024 22:16:40 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH trivial] chardev/char.c: fix "abstract device type" error
 message
Message-ID: <ZZVsSGz5YsEfUBBc@intel.com>
References: <20240103114221.325221-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103114221.325221-1-mjt@tls.msk.ru>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.601,
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

On Wed, Jan 03, 2024 at 02:42:21PM +0300, Michael Tokarev wrote:
> Date: Wed,  3 Jan 2024 14:42:21 +0300
> From: Michael Tokarev <mjt@tls.msk.ru>
> Subject: [PATCH trivial] chardev/char.c: fix "abstract device type" error
>  message
> X-Mailer: git-send-email 2.39.2
> 
> Current error message:
> 
>  qemu-system-x86_64: -chardev spice,id=foo: Parameter 'driver' expects an abstract device type
> 
> while in fact the meaning is in reverse, -chardev expects
> a non-abstract device type.
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> Fixes: 777357d758d9 "chardev: qom-ify" (2016-12-07)
> ---

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

>  chardev/char.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/chardev/char.c b/chardev/char.c
> index 996a024c7a..119b548784 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -518,7 +518,7 @@ static const ChardevClass *char_get_class(const char *driver, Error **errp)
>  
>      if (object_class_is_abstract(oc)) {
>          error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "driver",
> -                   "an abstract device type");
> +                   "a non-abstract device type");
>          return NULL;
>      }
>  
> -- 
> 2.39.2
> 
> 

