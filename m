Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B1682D40B
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 07:00:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPG10-0000K5-U9; Mon, 15 Jan 2024 01:00:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rPG0y-0000GH-Dz
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 01:00:04 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rPG0w-0007Ax-OR
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 01:00:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705298403; x=1736834403;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=w64qKTKqo3JjtN7Wzl4g1zomYMWAQrjH+M5UN+xmLlU=;
 b=gfp4fG45mofGezhqSS8ZmvJwOmZHHDZ6243ChuTou5btPMmkk7HCty/9
 zHiP5Kwju2QD8ZE5/tjiIdEB4e0PHaC269iTlnms+Yia28u8TLr4VR2dd
 KQHldIahcLb9UeOZERk6dvDvz9vlUPg7A1EXxLs0IxoyXiHmBJAmcpvzT
 aVOfUfS+JtRRLkcY9pLJY5BV42SkW3CpkS/yzETxRha0ITJAdZYlZ1IZ2
 0CXPFBZZL9yaM9Royo1pL7FM84qBjYiIYh7iO/otnxswp5HqvVE1suV8F
 hex8nrXbte7tMs2RjiiuM9v0qqDRaQUt88OGNL3fU6xwTZIX1bxntHe2y A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="6634060"
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; 
   d="scan'208";a="6634060"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2024 22:00:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="733210976"
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; d="scan'208";a="733210976"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orsmga003.jf.intel.com with ESMTP; 14 Jan 2024 21:59:56 -0800
Date: Mon, 15 Jan 2024 14:12:54 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Yuan Yao <yuan.yao@linux.intel.com>, Eduardo Habkost <eduardo@habkost.net>,
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
Message-ID: <ZaTM5njcfIgfsjqt@intel.com>
References: <20240108082727.420817-1-zhao1.liu@linux.intel.com>
 <20240108082727.420817-9-zhao1.liu@linux.intel.com>
 <20240115032524.44q5ygb25ieut44c@yy-desk-7060>
 <ZaSv51/5Eokkv5Rr@intel.com>
 <336a4816-966d-42b0-b34b-47be3e41446d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <336a4816-966d-42b0-b34b-47be3e41446d@intel.com>
Received-SPF: none client-ip=198.175.65.13;
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

Hi Xiaoyao,

On Mon, Jan 15, 2024 at 12:34:12PM +0800, Xiaoyao Li wrote:
> Date: Mon, 15 Jan 2024 12:34:12 +0800
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: Re: [PATCH v7 08/16] i386: Expose module level in CPUID[0x1F]
> 
> > Yes, I think it's time to move to default 0x1f.
> 
> we don't need to do so until it's necessary.

Recent and future machines all support 0x1f, and at least SDM has
emphasized the preferred use of 0x1f.

Thanks,
Zhao


