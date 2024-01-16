Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3927982F046
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 15:07:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPk5f-0003B3-B7; Tue, 16 Jan 2024 09:06:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rPk5R-00035Y-EJ
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 09:06:42 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rPk5N-0006Ct-MP
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 09:06:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705413998; x=1736949998;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=cOKapuMNF8YYvoqQUHwf7DhaL2utblqyE3nnXw/+ZCI=;
 b=iQNmU5mrmyyd5lnM9jgryfe8tt9cwgJBcSuF66JWsxQL+LQxvqlniwHO
 UbUo3KBReoIRM4W9YdHML2YeKElrH9wa85sjhaJEVNJUu14Dfz/g6urWZ
 juHmx0HfAPffDMGcWq2M8RLQ2Qm53r6ZOT9owyQPk3a/j3XE24laNTTGD
 M44gncQblHRPkFDmhpthpxdjdhuEczYRgfwcBDGPuTNHV3Cuj8uMDiV/Q
 P/Sjzzy7YixfMOoaJassvHeHOTr5jHJRQxc8W5uMKlfpXqUFC0FdnZAyE
 iXOb12qRXgMeU5+Wf8jK8Q/LmJH/t71XHAR12B5zPkhZB2WTscXYHglnk A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="18468224"
X-IronPort-AV: E=Sophos;i="6.05,199,1701158400"; d="scan'208";a="18468224"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2024 06:06:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="733620983"
X-IronPort-AV: E=Sophos;i="6.05,199,1701158400"; d="scan'208";a="733620983"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orsmga003.jf.intel.com with ESMTP; 16 Jan 2024 06:06:33 -0800
Date: Tue, 16 Jan 2024 22:19:31 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Yang Weijiang <weijiang.yang@intel.com>
Subject: Re: [PATCH 0/2] i386/cpu: Two minor fixes for
 x86_cpu_enable_xsave_components()
Message-ID: <ZaaQc8kMkLBN+t/g@intel.com>
References: <20240115091325.1904229-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115091325.1904229-1-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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

Hi Xiaoyao,

On Mon, Jan 15, 2024 at 04:13:23AM -0500, Xiaoyao Li wrote:
> Date: Mon, 15 Jan 2024 04:13:23 -0500
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH 0/2] i386/cpu: Two minor fixes for
>  x86_cpu_enable_xsave_components()
> X-Mailer: git-send-email 2.34.1
> 
> The two bugs were introduced when xsaves feature was added by commit
> 301e90675c3f ("target/i386: Enable support for XSAVES based features").

Could you please provide more details about reproducing these two bugs?
If I'm able, I'd be glad to help you to test and verify them.

Regards,
Zhao

> 
> Xiaoyao Li (2):
>   i386/cpu: Clear FEAT_XSAVE_XSS_LO/HI leafs when CPUID_EXT_XSAVE is not
>     available
>   i386/cpu: Mask with XCR0/XSS mask for FEAT_XSAVE_XCR0_HI and
>     FEAT_XSAVE_XSS_HI leafs
> 
>  target/i386/cpu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> -- 
> 2.34.1
> 
> 

