Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23503AAF1A7
	for <lists+qemu-devel@lfdr.de>; Thu,  8 May 2025 05:28:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCrvM-0007Iv-Vq; Wed, 07 May 2025 23:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCrvC-0006wz-0L
 for qemu-devel@nongnu.org; Wed, 07 May 2025 23:27:45 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCrv7-0004mg-RC
 for qemu-devel@nongnu.org; Wed, 07 May 2025 23:27:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746674858; x=1778210858;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Do/Mt7cuGmmYyaMcVi9sk+DI6UceGJACMlQytDMh9O4=;
 b=CH2i99d9J+7Glg9qL3Abpp/bEWsAXZep/kby8l9cVYi8O5MjZMET37SF
 JktL1Khimbz59jqEE1SEM1qlSLWOuP5Zmjwg23kp2ius6esiNDDnsk5oS
 7CTO7CtqIhyqks00d4VzNFu7Jgtg+QNWGpRoLDLMP+u/tA5Ze9fV4aV2j
 fOLwNtArRchPRQwnXOA3Md4vISdw4XoHNB8ZCGC1R4lte2s5R6yxnQZcF
 /YrVMfnxb0ZWgnwUxdUJoRQWnEdU999Y0mUvI5t1MweD+d+/DpDJVlplm
 /qKBYDcpmL3hsKTxJprk3y1DvRZDtj1PaftVUAlz0WsgJBlZTCGNtMcfT Q==;
X-CSE-ConnectionGUID: gIpRB3JrT3ua+tWXv5aKnQ==
X-CSE-MsgGUID: BfBRddF9Q9mP4FFB4JqKjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="59427225"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; d="scan'208";a="59427225"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2025 20:27:36 -0700
X-CSE-ConnectionGUID: Dakj3ZeWTMym5AzwStf/ag==
X-CSE-MsgGUID: tzh504TeQMObvr8joi3PMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; d="scan'208";a="141113610"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 07 May 2025 20:27:34 -0700
Date: Thu, 8 May 2025 11:48:35 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH 4/4] tests/tcg/x86_64/fma: add test for exact-denormal
 output
Message-ID: <aBwpk5mwMbF7PSuA@intel.com>
References: <20250213142613.151308-1-peter.maydell@linaro.org>
 <20250213142613.151308-5-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213142613.151308-5-peter.maydell@linaro.org>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Thu, Feb 13, 2025 at 02:26:13PM +0000, Peter Maydell wrote:
> Date: Thu, 13 Feb 2025 14:26:13 +0000
> From: Peter Maydell <peter.maydell@linaro.org>
> Subject: [PATCH 4/4] tests/tcg/x86_64/fma: add test for exact-denormal
>  output
> X-Mailer: git-send-email 2.43.0
> 
> Add some fma test cases that check for correct handling of FTZ and
> for the flag that indicates that the input denormal was consumed.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tests/tcg/x86_64/fma.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


