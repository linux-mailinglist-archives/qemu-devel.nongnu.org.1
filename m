Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5389A41CB
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Oct 2024 16:56:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1oOp-0005bp-QZ; Fri, 18 Oct 2024 10:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1oOf-0005bZ-Uv
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:56:09 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1oOb-0003rG-Uj
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:56:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729263366; x=1760799366;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=/ZEydX92YpVsaUMjK0xEUngdoIvuw1AeVsIXHvxvufs=;
 b=lVVGUIlJh13ID5prCfoyb1SNSDBAWKC+PmojLQIG7FheZX2yddIqlW6+
 TimovcLzx3qzkcK+m5PFOAAGDi48jVHDnEAbb2PYhdiOTzBCLRPCFuGlA
 YSJlkiwSM5ANY/rFxk6qpnMv0Gwdo0QwUVvMQRzUtQioNG1Umq84CgSMa
 pKehf8Cd8Txl8CBPMeNLPDSAZ6J4r+f/sPy4BzdLBAeG7Twa3Tfi+WAPp
 bSxLoBUq2LpEkQOmOAy7yQLdg3hXSrKTXmLLOUwY+J2oMQSaAI4JQezIP
 3yVyxxteh8z3D2jdIBSpaYfkT16pVliong0TFwXjWvODJDFWDa9rHNMDP Q==;
X-CSE-ConnectionGUID: nIRGoMn7S4aPgxCFslWEhQ==
X-CSE-MsgGUID: voUgl5smSpCw6pyoZYFqAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="39385686"
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; d="scan'208";a="39385686"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2024 07:56:03 -0700
X-CSE-ConnectionGUID: LAe/VQUDQ6epNB17ndNVhw==
X-CSE-MsgGUID: 5ytm8CflSCCkZMEc1qZL1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; d="scan'208";a="102199947"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa002.fm.intel.com with ESMTP; 18 Oct 2024 07:56:02 -0700
Date: Fri, 18 Oct 2024 23:12:17 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 01/16] meson: import rust module into a global variable
Message-ID: <ZxJ60TGSfxqZzvkO@intel.com>
References: <20241015131735.518771-1-pbonzini@redhat.com>
 <20241015131735.518771-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015131735.518771-2-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
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

On Tue, Oct 15, 2024 at 03:17:19PM +0200, Paolo Bonzini wrote:
> Date: Tue, 15 Oct 2024 15:17:19 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 01/16] meson: import rust module into a global variable
> X-Mailer: git-send-email 2.46.2
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  meson.build                      | 1 +
>  rust/qemu-api-macros/meson.build | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


