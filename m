Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B5382D415
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 07:08:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPG8C-0002tP-FI; Mon, 15 Jan 2024 01:07:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rPG8A-0002tH-H3
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 01:07:30 -0500
Received: from mgamail.intel.com ([192.55.52.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rPG88-0000oY-KT
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 01:07:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705298848; x=1736834848;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=yO6y4061mOMOBuAjTQimWEv3SWvQ0lvROuG9u3xeD1w=;
 b=AWrYrYZSdzUedVwIX+NZ0JLC1RJFzDYcRDe+QccPAFQnSAx11GzqnB0+
 RiFzeK5uV7V26/3d4fYPtneqWSF68LSr+BQQb9p9s/wksicgvung27KF1
 mt+KqqOngbHYPdRuhK2hRzqtTwik36/ubzKHs54RZg8gdy0DX8/wj6TPh
 IWR0D02+1Ce0CK3c47HZRhiZnAeEjPCDI/BXSorClQQ1/0NaXe4dt/HcH
 XNajrrJkcHBXT1MY1euUqZQgP/LUQjkn5gqVYiWzkN4pymXUzoRTewDCq
 p27X2uyWrbEix7z7iisesc+gh0JOF9nRWCY8fLPweuAOUc03QnUa4SeEA w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="485701525"
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; d="scan'208";a="485701525"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2024 22:07:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="853898393"
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; d="scan'208";a="853898393"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmsmga004.fm.intel.com with ESMTP; 14 Jan 2024 22:07:22 -0800
Date: Mon, 15 Jan 2024 14:20:20 +0800
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
Message-ID: <ZaTOpCFZRu6/py/J@intel.com>
References: <20240108082727.420817-1-zhao1.liu@linux.intel.com>
 <20240108082727.420817-9-zhao1.liu@linux.intel.com>
 <20240115032524.44q5ygb25ieut44c@yy-desk-7060>
 <ZaSv51/5Eokkv5Rr@intel.com>
 <336a4816-966d-42b0-b34b-47be3e41446d@intel.com>
 <20240115052022.xbv6exhm4af7kai7@yy-desk-7060>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115052022.xbv6exhm4af7kai7@yy-desk-7060>
Received-SPF: none client-ip=192.55.52.43;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
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

On Mon, Jan 15, 2024 at 01:20:22PM +0800, Yuan Yao wrote:
> Date: Mon, 15 Jan 2024 13:20:22 +0800
> From: Yuan Yao <yuan.yao@linux.intel.com>
> Subject: Re: [PATCH v7 08/16] i386: Expose module level in CPUID[0x1F]
> 
> Ah, so my understanding is incorrect on this.
> 
> I tried on one raptor lake i5-i335U, which also hybrid soc but doesn't have
> module level, in this case 0x1f and 0xb have same values in core/lp level.

Some socs have modules/dies but they don't expose them in 0x1f.

If the soc only expose thread/core levels in 0x1f, then its 0x1f is same
as 0x0b. Otherwise, it will have more subleaves and different
values.

Thanks,
Zhao


