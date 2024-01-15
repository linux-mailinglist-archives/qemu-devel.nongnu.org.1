Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA8F82DD87
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 17:24:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPPkB-00055b-Jv; Mon, 15 Jan 2024 11:23:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rPPk8-00055S-Rv
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 11:23:21 -0500
Received: from mgamail.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rPPk6-0004Yg-P6
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 11:23:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705335798; x=1736871798;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=zZ3g+F6pc4nv9gCIaeiSfyGciz2EtD2SlmeU1n+Poxc=;
 b=E+JWs+QAExfgH4VUGkGwMsFbYueYqxI0eDgO0pnYLqwyUFEEciK6MsUm
 HJ/AH6ZzIilHt4zaHffQGTLrk4UMYTM6OY4Y9xL7AUN8LcN50rvtXE2K2
 2YSf5a1XcqgCBBPXQ2/cRWbw1vSe2v+dlUoHgRlnmdKWjuPPJc32h8vJi
 DB0SnSqldJtdNE0P2sHkXT2bVUa3vu6qNX94yh5YKfAezQgGJyhUTAiXJ
 hTJ+Vhv1KbMjCcmzP/IUMsVs0f2j+loc+JqYxNxq+LwJ97m1RBreoyVKB
 M5IE9ErBDE2jwMLspYumHmbNJorjNT5f0yCqSZljIEL4i2TAEZOU7yhZH A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="396805717"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="396805717"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 08:23:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="907094132"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="907094132"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orsmga004.jf.intel.com with ESMTP; 15 Jan 2024 08:23:13 -0800
Date: Tue, 16 Jan 2024 00:36:11 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 02/11] hw/core: Cleanup unused included headers in
 cpu-common.c
Message-ID: <ZaVe++YmoG4Pmy18@intel.com>
References: <20240115094852.3597165-1-zhao1.liu@linux.intel.com>
 <20240115094852.3597165-3-zhao1.liu@linux.intel.com>
 <CAFEAcA91+EV7_iHvp2Kd8zgXAx2zg3odepQgg=vPpPLv8ETRKw@mail.gmail.com>
 <ZaVFDhNiptuyzhjX@intel.com>
 <06d4179f-76b8-42f0-b147-f4bc2d1f06bd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06d4179f-76b8-42f0-b147-f4bc2d1f06bd@linaro.org>
Received-SPF: none client-ip=192.55.52.93;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
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

On Mon, Jan 15, 2024 at 05:07:52PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Mon, 15 Jan 2024 17:07:52 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: Re: [PATCH 02/11] hw/core: Cleanup unused included headers in
>  cpu-common.c
> 
> On 15/1/24 15:45, Zhao Liu wrote:
> > Hi Peter,
> > 
> > On Mon, Jan 15, 2024 at 10:41:48AM +0000, Peter Maydell wrote:
> > > Date: Mon, 15 Jan 2024 10:41:48 +0000
> > > From: Peter Maydell <peter.maydell@linaro.org>
> > > Subject: Re: [PATCH 02/11] hw/core: Cleanup unused included headers in
> > >   cpu-common.c
> > > 
> > > On Mon, 15 Jan 2024 at 09:37, Zhao Liu <zhao1.liu@linux.intel.com> wrote:
> > > > 
> > > > From: Zhao Liu <zhao1.liu@intel.com>
> > > > 
> > > > Remove unused headers in cpu-common.c:
> > > > * qemu/notify.h
> > > > * qemu/log.h
> > > > * qemu/main-loop.h
> > > > * exec/cpu-common.h
> > > > * qemu/error-report.h
> > > > * qemu/qemu-print.h
> > > > 
> > > > Though hw/core/cpu.h has been included by sysemu/hw_accel.h, to keep
> > > > the dependency clear, still directly include hw/core/cpu.h in this file.
> > > > 
> > > > Tested by "./configure" and then "make".
> > > > 
> > > > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > > > ---
> > > >   hw/core/cpu-common.c | 7 +------
> > > >   1 file changed, 1 insertion(+), 6 deletions(-)
> > > 
> > > Something seems to be wrong with your analysis of what
> > > includes it is OK to drop. For instance, this file uses
> > > the function qemu_log(), which is why it includes
> > > qemu/log.h.
> > > 
> > 
> > I'm not sure about this, since qemu/log.h has been included by exec/log.h,
> > so could we just include exec/log.h and omit qemu/log.h in this file?
> 
> We try to avoid implicit header inclusions, because if "exec/log.h" is
> reworked and "qemu/log.h" removed, then files using declarations
> implicitly declared start to fail building, and we need to clean
> unrelated files.

Thanks! I see. Let me rework this series.

Regards,
Zhao


