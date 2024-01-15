Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CF282DB53
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 15:33:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPO18-0001KV-Sh; Mon, 15 Jan 2024 09:32:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rPO15-0001KC-Mg
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 09:32:43 -0500
Received: from mgamail.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rPO13-000376-3h
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 09:32:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705329161; x=1736865161;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=bYYqI2aXAZfKbPcN0scSeyxn2KopnOFSXBx9vsW92Do=;
 b=N6Dj7tLiz2hDjTBegP/s0FtA7xiPdLDUdSnN6unWkMPb4p9aONFfxwik
 h+pprpT4LmCYN4qZe2VYAEar80mpkhDTiUrduWIPL/A4c+KuK/JIIGYsr
 qTsVUPD9+L/YmEIrRUfIlSEyjXcldcj9PkUW7zi028w4OauzdfHlk4XSc
 Nen7tKSkg6ioBRb9hxukk2iNAH43hb0nNcwi/Isnwm6uX/Y93vkAKcMrj
 KnYprCNqAdrzb+m1Ki9JDnAJp103+Pw2b50cjoMXlCbTROHKKLKnhMWtc
 eA2pGq9JQAUaSZ8xaJWCx22hosTxpUbFOHR4euAXpUFXrq8AJw9BZMH0w w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="390079349"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="390079349"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 06:32:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="787092658"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="787092658"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmsmga007.fm.intel.com with ESMTP; 15 Jan 2024 06:32:36 -0800
Date: Mon, 15 Jan 2024 22:45:34 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 02/11] hw/core: Cleanup unused included headers in
 cpu-common.c
Message-ID: <ZaVFDhNiptuyzhjX@intel.com>
References: <20240115094852.3597165-1-zhao1.liu@linux.intel.com>
 <20240115094852.3597165-3-zhao1.liu@linux.intel.com>
 <CAFEAcA91+EV7_iHvp2Kd8zgXAx2zg3odepQgg=vPpPLv8ETRKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA91+EV7_iHvp2Kd8zgXAx2zg3odepQgg=vPpPLv8ETRKw@mail.gmail.com>
Received-SPF: none client-ip=134.134.136.20;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hi Peter,

On Mon, Jan 15, 2024 at 10:41:48AM +0000, Peter Maydell wrote:
> Date: Mon, 15 Jan 2024 10:41:48 +0000
> From: Peter Maydell <peter.maydell@linaro.org>
> Subject: Re: [PATCH 02/11] hw/core: Cleanup unused included headers in
>  cpu-common.c
> 
> On Mon, 15 Jan 2024 at 09:37, Zhao Liu <zhao1.liu@linux.intel.com> wrote:
> >
> > From: Zhao Liu <zhao1.liu@intel.com>
> >
> > Remove unused headers in cpu-common.c:
> > * qemu/notify.h
> > * qemu/log.h
> > * qemu/main-loop.h
> > * exec/cpu-common.h
> > * qemu/error-report.h
> > * qemu/qemu-print.h
> >
> > Though hw/core/cpu.h has been included by sysemu/hw_accel.h, to keep
> > the dependency clear, still directly include hw/core/cpu.h in this file.
> >
> > Tested by "./configure" and then "make".
> >
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> >  hw/core/cpu-common.c | 7 +------
> >  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> Something seems to be wrong with your analysis of what
> includes it is OK to drop. For instance, this file uses
> the function qemu_log(), which is why it includes
> qemu/log.h.
>

I'm not sure about this, since qemu/log.h has been included by exec/log.h,
so could we just include exec/log.h and omit qemu/log.h in this file?

It seems enough for the compilation to omit qemu/log.h and only include
exec/log.h.

Regards,
Zhao


