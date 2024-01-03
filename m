Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 177AE822F1B
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 15:02:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL1ns-0004aU-3D; Wed, 03 Jan 2024 09:01:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rL1nW-0004UO-8j
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 09:00:49 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rL1nS-0005ZE-Ta
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 09:00:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1704290439; x=1735826439;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=KXY2frgsCgMxPjEjWPIRpxOky61C0gI7uIaZ1AWjyQ0=;
 b=M4wbIKtHc7gcR0R2ZKqh14RP2jSSWH0QRfskHUliy11/bQr5pB8gUgsR
 WheiTj2moSwAOL2fosos0V+35acy59Avbq7ASTn7h3qsjbh3wd4lMiOhR
 DYDvM+V8XykRmzt3Ho0T7Af5u6Sm9he2/CHCjh4VS4UMlIf4jtxRI4ekv
 o/UYgWvi2oKNsyMND1e8q98slIu9kHSosg+fQPNUd1Q2iTvyVho1axQMT
 XhvEBbgTjh5YBt9YtqmbBNCg3dDg9ZhFUUWGE0KvywaNuOzc9ft9vJb0L
 1bf/Ez8zJpW8e6qUDd+3++pmaYk7MeuQVHokT6K1W7P3m+Q6TfobWWD1q A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="3831916"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="3831916"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jan 2024 06:00:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; d="scan'208";a="21789989"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa002.jf.intel.com with ESMTP; 03 Jan 2024 06:00:27 -0800
Date: Wed, 3 Jan 2024 22:13:19 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 2/2] hw/cpu/cluster: Cleanup unused included header in
 cluster.c
Message-ID: <ZZVrfyl9OgGRw6/O@intel.com>
References: <20231127145611.925817-1-zhao1.liu@linux.intel.com>
 <20231127145611.925817-3-zhao1.liu@linux.intel.com>
 <605a850b-ebdd-4744-a772-5b20ec171ec7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <605a850b-ebdd-4744-a772-5b20ec171ec7@linaro.org>
Received-SPF: none client-ip=192.198.163.9;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.601,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Nov 28, 2023 at 11:02:00AM +0100, Philippe Mathieu-Daudé wrote:
> Date: Tue, 28 Nov 2023 11:02:00 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: Re: [PATCH 2/2] hw/cpu/cluster: Cleanup unused included header in
>  cluster.c
> 
> On 27/11/23 15:56, Zhao Liu wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > Remove unused header (qemu/module.h and qemu/cutils.h) in cluster.c,
> > and reorder the remaining header files (except qemu/osdep.h) in
> > alphabetical order.
> > 
> > Tested by "./configure" and then "make".
> > 
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> >   hw/cpu/cluster.c | 5 ++---
> >   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>

Thanks Philippe!

BTW, could these two patches be merged into your next tree?

I also find these 2 headers are included in many cases, maybe I can go
further and do a more thorough cleaning.

Regards,
Zhao


