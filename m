Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B8482D470
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 08:08:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPH4h-0007dv-AH; Mon, 15 Jan 2024 02:08:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rPH4V-0007dn-Nu
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 02:07:47 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rPH4T-0004Y4-Ot
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 02:07:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705302466; x=1736838466;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=o7qZxhaRG6s2AdoDhlfCwW2RkcbUaQCrovplsa+bUjw=;
 b=Jm95pQsYelGp7xEl8nyC64PnVpnTxdXvJMQ5GFwA4tjfvYic7LpSA8s7
 WA0js1yed5t71Ntk7SL6/0LS6DDZ5rC6eheH9aptuXyw9zTkPnp5/Li4c
 ptRx5b2oQsUAqXg83xJb7SP1XUiShMeZBTstJ+oOfzMhoNcF9O2HPDZN8
 36ufKv9OfLlRj+15mmbsv20t4oWIW3SgvIffDgh3nEa9YAPOcFMCHLbYr
 awX6flvGhLSESFVdfbowVO2IaBFAkAHsQoyeB7Mjr8j5ieH/1jOvMLDpO
 18ajsuEkkATE6Yp+jZmUrFRMKpKNa9KAnWj+OA/UcSpPzHEewCAt9Mza/ Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="6918404"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; 
   d="scan'208";a="6918404"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2024 23:07:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="1114855357"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="1114855357"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmsmga005.fm.intel.com with ESMTP; 14 Jan 2024 23:07:39 -0800
Date: Mon, 15 Jan 2024 15:20:37 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Yuan Yao <yuan.yao@linux.intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, Babu Moger <babu.moger@amd.com>,
 Yongwei Ma <yongwei.ma@intel.com>
Subject: Re: [PATCH v7 08/16] i386: Expose module level in CPUID[0x1F]
Message-ID: <ZaTcxVGHhQtLC/Ki@intel.com>
References: <20240108082727.420817-1-zhao1.liu@linux.intel.com>
 <20240108082727.420817-9-zhao1.liu@linux.intel.com>
 <20240115032524.44q5ygb25ieut44c@yy-desk-7060>
 <ZaSv51/5Eokkv5Rr@intel.com>
 <336a4816-966d-42b0-b34b-47be3e41446d@intel.com>
 <20240115052022.xbv6exhm4af7kai7@yy-desk-7060>
 <ZaTOpCFZRu6/py/J@intel.com>
 <20240115065730.ezwpd3sjoycc57rm@yy-desk-7060>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115065730.ezwpd3sjoycc57rm@yy-desk-7060>
Received-SPF: none client-ip=198.175.65.12;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
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

On Mon, Jan 15, 2024 at 02:57:30PM +0800, Yuan Yao wrote:
> Date: Mon, 15 Jan 2024 14:57:30 +0800
> From: Yuan Yao <yuan.yao@linux.intel.com>
> Subject: Re: [PATCH v7 08/16] i386: Expose module level in CPUID[0x1F]
> 
> On Mon, Jan 15, 2024 at 02:20:20PM +0800, Zhao Liu wrote:
> > On Mon, Jan 15, 2024 at 01:20:22PM +0800, Yuan Yao wrote:
> > > Date: Mon, 15 Jan 2024 13:20:22 +0800
> > > From: Yuan Yao <yuan.yao@linux.intel.com>
> > > Subject: Re: [PATCH v7 08/16] i386: Expose module level in CPUID[0x1F]
> > >
> > > Ah, so my understanding is incorrect on this.
> > >
> > > I tried on one raptor lake i5-i335U, which also hybrid soc but doesn't have
> > > module level, in this case 0x1f and 0xb have same values in core/lp level.
> >
> > Some socs have modules/dies but they don't expose them in 0x1f.
> 
> Here they don't expose because from hardware level they can't or possible
> software level configuration (i.e. disable some cores in bios) ?
>

This leaf is decided at hardware level. Whether or not which levels are exposed
sometimes depends if there is the topology-related feature, but there is no clear
rule (just as in the ADL family neither ADL-S/P exposes modules, while ADL-N
exposes modules).

Regards,
Zhao


