Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 145EFAABB96
	for <lists+qemu-devel@lfdr.de>; Tue,  6 May 2025 09:44:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCCxu-0000U9-9f; Tue, 06 May 2025 03:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCCxs-0000Tv-DH; Tue, 06 May 2025 03:43:44 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCCxq-0007T0-N7; Tue, 06 May 2025 03:43:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746517423; x=1778053423;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=jpjnSiPmjZ/LCNkcolpzLGv0GSb4SYL6LR8xnEQEcXM=;
 b=ZIkUOiRT1toiF2uTJ2hD1gtE75k2wT8GX/TbnwKaSwDd4OrEW42DD4cP
 POQLvdRqcXoljhyVLaIgTZQAPH+2Jpr8xhRWkXvPxiLCG8A5nnvyiOynY
 hU+WRHhMiBoWYHBuqQBaQkFV0oMdi0Q5nGBlo9k5EWMDmp5hFxyLn20TR
 0RBYjNry1hcbqQUwGiu2xdSed2axKGeGEuUHITYnBK6Atss0manWUI4rP
 1W09Tj/j4h+G77+UH9lL4Ng37tBsVQPVXG7o+/HvU6go8FUr7fl5DVcHp
 pFQaiZSc23cqVJ+qemMR99hujDyClmsTXo/bbrMvcgRQvHA3G+xRvJ+9a Q==;
X-CSE-ConnectionGUID: +FcQqjpQTk6lEawRaGsVlQ==
X-CSE-MsgGUID: yOYNtGB8TzSh6byekea5NA==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="58795710"
X-IronPort-AV: E=Sophos;i="6.15,265,1739865600"; d="scan'208";a="58795710"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 00:43:40 -0700
X-CSE-ConnectionGUID: fGu+FcXLTnCt5iINkuxm7Q==
X-CSE-MsgGUID: NLPjb+mYT+ScKWUxdlCCPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,265,1739865600"; d="scan'208";a="135916824"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 06 May 2025 00:43:39 -0700
Date: Tue, 6 May 2025 16:04:40 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, manos.pitsidianakis@linaro.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 08/11] rust: enable clippy::ptr_cast_constness
Message-ID: <aBnCmJpnf6xzm4/I@intel.com>
References: <20250505090438.24992-1-pbonzini@redhat.com>
 <20250505090438.24992-9-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505090438.24992-9-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, May 05, 2025 at 11:04:33AM +0200, Paolo Bonzini wrote:
> Date: Mon,  5 May 2025 11:04:33 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 08/11] rust: enable clippy::ptr_cast_constness
> X-Mailer: git-send-email 2.49.0
> 
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/devel/rust.rst            | 2 --
>  rust/Cargo.toml                | 2 +-
>  rust/hw/timer/hpet/src/hpet.rs | 2 +-
>  rust/qemu-api/src/cell.rs      | 2 +-
>  rust/qemu-api/src/chardev.rs   | 2 +-
>  rust/qemu-api/src/qom.rs       | 4 ++--
>  rust/qemu-api/src/timer.rs     | 2 +-
>  7 files changed, 7 insertions(+), 9 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


