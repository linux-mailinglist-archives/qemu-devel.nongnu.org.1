Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D97918C24B1
	for <lists+qemu-devel@lfdr.de>; Fri, 10 May 2024 14:20:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5PCm-0000nF-7p; Fri, 10 May 2024 08:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s5PCi-0000hO-9X
 for qemu-devel@nongnu.org; Fri, 10 May 2024 08:18:24 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s5PCf-000808-NY
 for qemu-devel@nongnu.org; Fri, 10 May 2024 08:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715343502; x=1746879502;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=cwBbVTGbQXkBiVV1tFNO0TXYokSW/aYJSApUt62s9Rg=;
 b=C4FBRrdjMUI4OS1gQR7HFz+tlsNpYvKhY90l1RLnC1etSPl+/dwYxqT2
 A0vWN8F2L9SzZA+e6SS1kk978E1BEuRf68v7oshafFzIs+LYxI544j8Eq
 mueGbVZWCyDTktg2vR3Q7fWnzREVufcPAPemrBjXOer15inLYA02jvLkW
 +ls3Vn41ZMJc3bb5xb76zdWVSsvLy1dzyB6pL/oO0jWGVeGf0jZi9NZgB
 Z6MtqyYu0PdAJdLfMmkLasKg0O2m0V1abfbwzC1cYTFnULn2nO+owK5k7
 YuEwgtVtB/CCXUrym/gQ++d9C1yrnDGs/F7FWmzIlxXAZByxSusiYkRbU g==;
X-CSE-ConnectionGUID: 6G7mxidJQCyaT4l6/F/66A==
X-CSE-MsgGUID: q5lLrwD9QquIm9ZkcgPLmA==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11170879"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; d="scan'208";a="11170879"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2024 05:18:18 -0700
X-CSE-ConnectionGUID: ZDKp8Du4RcqPWVIc4iOgaw==
X-CSE-MsgGUID: JUJnYMsaTuCKPU479uJgKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; d="scan'208";a="29458777"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa010.jf.intel.com with ESMTP; 10 May 2024 05:18:16 -0700
Date: Fri, 10 May 2024 20:32:30 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com
Subject: Re: [PATCH 10/13] hw/i386: split x86.c in multiple parts
Message-ID: <Zj4T3vE4g1Pf8Sjd@intel.com>
References: <20240509170044.190795-1-pbonzini@redhat.com>
 <20240509170044.190795-11-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509170044.190795-11-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.586,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

On Thu, May 09, 2024 at 07:00:41PM +0200, Paolo Bonzini wrote:
> Date: Thu,  9 May 2024 19:00:41 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 10/13] hw/i386: split x86.c in multiple parts
> X-Mailer: git-send-email 2.45.0
> 
> Keep the basic X86MachineState definition in x86.c.  Move out functions that
> are only needed by other files: x86-common.c for the pc and microvm machines,
> x86-cpu.c for those used by accelerator code.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/hw/i386/x86.h |    6 +-
>  hw/i386/x86-common.c  | 1007 +++++++++++++++++++++++++++++++++++++++
>  hw/i386/x86-cpu.c     |   97 ++++
>  hw/i386/x86.c         | 1052 +----------------------------------------
>  hw/i386/meson.build   |    4 +-
>  5 files changed, 1113 insertions(+), 1053 deletions(-)
>  create mode 100644 hw/i386/x86-common.c
>  create mode 100644 hw/i386/x86-cpu.c
 
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Once this change is merged, I'll rebase my module topology series.


