Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C24BB82D42D
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 07:24:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPGN0-0006PC-1D; Mon, 15 Jan 2024 01:22:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rPGMt-0006Nl-Mg
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 01:22:43 -0500
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rPGMr-0003qK-6X
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 01:22:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705299761; x=1736835761;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=GQIsLNn6hJVJTPHXRkaEq4wnPTcPIuPsr+uAqE0okVs=;
 b=Cgn/TO+Ppi8gVdBeQRRQdKwPpAi3c77KuKmAK+zRxvbHUvTdT0FtQ8gm
 gXC8M0xYb84mOtXc1WvSohYOALmddJkL1X8D+sfY5EtnNEsoAhQTqz/yE
 xTNxypJrO/liTrGuwDaXTYmx2ZVRlwIO2chKaEMK7rumWl3BqUYG/f5gQ
 Z9KZPkyiC/KSNfT+Sdo164s/6daUiZUVkKU52123P38LCu0Ibu4KKaW8h
 N8QLkV/Ot4d3afq14ihT90EZB6HCg1f0mVrfAsDFig49TP/l8dIvzy23k
 +P7oDdBZSS0hUYCUvdYOabOGRC4hOEd/CRB0Nuw8co2VaiRZ3wtZEx+Pl A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="399220956"
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; d="scan'208";a="399220956"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2024 22:22:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="733215325"
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; d="scan'208";a="733215325"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orsmga003.jf.intel.com with ESMTP; 14 Jan 2024 22:22:33 -0800
Date: Mon, 15 Jan 2024 14:35:31 +0800
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
Message-ID: <ZaTSM8IAzQ1onX05@intel.com>
References: <20240108082727.420817-1-zhao1.liu@linux.intel.com>
 <20240108082727.420817-9-zhao1.liu@linux.intel.com>
 <20240115032524.44q5ygb25ieut44c@yy-desk-7060>
 <ZaSv51/5Eokkv5Rr@intel.com>
 <336a4816-966d-42b0-b34b-47be3e41446d@intel.com>
 <ZaTM5njcfIgfsjqt@intel.com>
 <78168ef8-2354-483a-aa3b-9e184de65a72@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78168ef8-2354-483a-aa3b-9e184de65a72@intel.com>
Received-SPF: none client-ip=192.55.52.115;
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

On Mon, Jan 15, 2024 at 02:11:17PM +0800, Xiaoyao Li wrote:
> Date: Mon, 15 Jan 2024 14:11:17 +0800
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: Re: [PATCH v7 08/16] i386: Expose module level in CPUID[0x1F]
> 
> On 1/15/2024 2:12 PM, Zhao Liu wrote:
> > Hi Xiaoyao,
> > 
> > On Mon, Jan 15, 2024 at 12:34:12PM +0800, Xiaoyao Li wrote:
> > > Date: Mon, 15 Jan 2024 12:34:12 +0800
> > > From: Xiaoyao Li <xiaoyao.li@intel.com>
> > > Subject: Re: [PATCH v7 08/16] i386: Expose module level in CPUID[0x1F]
> > > 
> > > > Yes, I think it's time to move to default 0x1f.
> > > 
> > > we don't need to do so until it's necessary.
> > 
> > Recent and future machines all support 0x1f, and at least SDM has
> > emphasized the preferred use of 0x1f.
> 
> The preference is the guideline for software e.g., OS. QEMU doesn't need to
> emulate cpuid leaf 0x1f to guest if there is only smt and core level.

Please, QEMU is emulating hardware not writing software. Is there any
reason why we shouldn't emulate new and generic hardware behaviors and
stick with the old ones?

> because in this case, they are exactly the same in leaf 0xb and 0x1f. we don't
> need to bother advertising the duplicate data.

You can't "define" the same 0x0b and 0x1f as duplicates. SDM doesn't
have such the definition.

Regards,
Zhao


