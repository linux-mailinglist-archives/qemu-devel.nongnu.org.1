Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2B37411CE
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 14:55:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEUgw-00011A-FU; Wed, 28 Jun 2023 08:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qEUgt-00010d-9H
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 08:54:35 -0400
Received: from mga05.intel.com ([192.55.52.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qEUgq-0001El-KY
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 08:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687956872; x=1719492872;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=dJs3xZv9X69YwKkCoR7HTZY16sKT6xVllxuCAUDWTJU=;
 b=YIN7lVt/KA16efLCWk2AywO7e5qcPTE5tFKBz5L7OTjzm2rmw8WbqHG2
 eTY1FDO4mXnVlcn1mSl6rlDotepGva+SoKUcFtltukDItKcd+YbhxjHtm
 z+u3+Ku4NtD/1u5Y7+o8KCqrgYt26EMqCh/eeLcnTmnwfCs7rBzPTxzT/
 pfnEfFaC4vBw+YgQRcRa1uMEEmPZOXXC5uKmoU5GOJtzxzZiIt9wLwgnd
 YankM055wqNEcI1WsTKjrE1ksYP3KXhraq3fSuhaGTKMldW5RKsgpfW08
 PFB5+3+Efs93a/nCQ9DUGWUes+oj7Y4Jb9HbhPyqbter0dhos9A4rfszB w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="448217857"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; d="scan'208";a="448217857"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2023 05:54:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="711041098"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; d="scan'208";a="711041098"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.28])
 by orsmga007.jf.intel.com with ESMTP; 28 Jun 2023 05:54:27 -0700
Date: Wed, 28 Jun 2023 21:04:26 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Sunil Muthuswamy <sunilmut@microsoft.com>, qemu-devel@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH] i386/WHPX: Fix error message when fail to set
 ProcessorCount
Message-ID: <ZJwv2monGov2GQEJ@liuzhao-OptiPlex-7080>
References: <20230529124331.412822-1-zhao1.liu@linux.intel.com>
 <1f4b504e-43f2-5adb-8d93-de20bd577e37@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f4b504e-43f2-5adb-8d93-de20bd577e37@linaro.org>
Received-SPF: none client-ip=192.55.52.43;
 envelope-from=zhao1.liu@linux.intel.com; helo=mga05.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On Wed, Jun 28, 2023 at 01:59:56PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Wed, 28 Jun 2023 13:59:56 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: Re: [PATCH] i386/WHPX: Fix error message when fail to set
>  ProcessorCount
> 
> On 29/5/23 14:43, Zhao Liu wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > 003f230e37d7 ("machine: Tweak the order of topology members in struct
> > CpuTopology") changes the meaning of MachineState.smp.cores from "the
> > number of cores in one package" to "the number of cores in one die"
> > and doesn't fix other uses of MachineState.smp.cores. And because of
> > the introduction of cluster, now smp.cores just means "the number of
> > cores in one cluster". This clearly does not fit the semantics here.
> > 
> > And before this error message, WHvSetPartitionProperty() is called to
> > set prop.ProcessorCount.
> > 
> > So the error message should show the prop.ProcessorCount other than
> > "cores per cluster" or "cores per package".
> > 
> > Cc: Sunil Muthuswamy <sunilmut@microsoft.com>
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> >   target/i386/whpx/whpx-all.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Patch queued (fixing the unsigned format), thanks.
>

Many thanks!

-Zhao

