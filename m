Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7E4AF8E97
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Jul 2025 11:30:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXcjX-0005tM-TB; Fri, 04 Jul 2025 05:29:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXcjQ-0005rn-8j
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 05:29:20 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXcjL-0000jA-TP
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 05:29:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751621356; x=1783157356;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=3twurOIc+oXkLzauqMG6PP5G0Mz1k3ieUgyR0C4VzvU=;
 b=Vu1S/G96dP1nVUhzVjVDNdbQ7nG+XUK2xGZ3+QUZHb1u1C4Es8pI5dqg
 Fx8ol3xPu6K+jQ5+ZzLjXQMGtXR9wq/eoon3Ncei5Qx9U1QL9V+kb8p4f
 uZbFRCKMtFs4NxX+aOUlHVfxTy6E5LB8o8Mf/Ie3oCxuW7Eb6UUjlm3nI
 yqNgl+hi2Xd9Hl5sfFoV8Ee6dKytCYsOMN8UzpgwYbdCPOIluRci/ZXdB
 1i1v8UOu9xy+ZkvFaNuqY9EX8aC1lO52xTI81qTnEZDpDxWKXem2WoiO3
 jUpvm1D/aa7H1t8A5rhu0OGkwrDNZQkvsfJLLntssikfxe4KBghAQg8WO A==;
X-CSE-ConnectionGUID: ykPH+a9IRVCFePCTGw7XoA==
X-CSE-MsgGUID: 8v6ewBipTf6FEHU4ix/p5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="71392508"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="71392508"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2025 02:29:12 -0700
X-CSE-ConnectionGUID: AoB2id5DSLStLwVCUL+bRw==
X-CSE-MsgGUID: KWdw8JMqTnKxHZVOY1XJMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="191774109"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 04 Jul 2025 02:29:12 -0700
Date: Fri, 4 Jul 2025 17:50:37 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v6 16/39] accel/hvf: Move generic method declarations to
 hvf-all.c
Message-ID: <aGej7bQyg5qBkpbV@intel.com>
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-17-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250703173248.44995-17-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
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

On Thu, Jul 03, 2025 at 07:32:22PM +0200, Philippe Mathieu-Daud� wrote:
> Date: Thu,  3 Jul 2025 19:32:22 +0200
> From: Philippe Mathieu-Daud� <philmd@linaro.org>
> Subject: [PATCH v6 16/39] accel/hvf: Move generic method declarations to
>  hvf-all.c
> X-Mailer: git-send-email 2.49.0
> 
> hvf-all.c aims to contain the generic accel methods (TYPE_ACCEL),
> while hvf-accel-ops.c the per-vcpu methods (TYPE_ACCEL_OPS).
> 
> Signed-off-by: Philippe Mathieu-Daud� <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/hvf/hvf-accel-ops.c | 274 +-------------------------------------
>  accel/hvf/hvf-all.c       | 268 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 272 insertions(+), 270 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


