Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EEDAF6CD7
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Jul 2025 10:28:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXFIZ-00066O-8o; Thu, 03 Jul 2025 04:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXFIS-00064x-VF
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 04:27:57 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXFII-0005Ws-Nv
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 04:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751531267; x=1783067267;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=kk77vUBEkSjmsCyANUUqBAMo+dxlEAVvzPvouifbixc=;
 b=n3KXJVUlLdqxorAdPOPQpbGpor2PpQH98Ki6xF2uiy7J+eJeY+JUSypJ
 ytRbt7NGUML9YjNPh1Ue1YW3RjE0E+1kO7YiNaagIjRyXa3e6fNBf0vpn
 L5r4dyKOpdh5YM798040v+DICTaXF1+1ZaYJrq7FRklHtWIyGnLmaG3Wf
 YPcKPTPijB6DU9v09YxT8xMfOdVty+0hLor0rn1CUYTkyvoRn9Zm3X0Sc
 Wt8MJqVWKtKc6SGTj1GJ8VmEaaj/Gi05Ynfvd6vNGvvV5jzMlEMpalyiH
 VHIlp3yU/8dXROEc8rSficPUBQB+AovTJoRV5oGXpKZCKz1Msz4DLLZmP Q==;
X-CSE-ConnectionGUID: UQe283LnQvavGdvSqLeDbw==
X-CSE-MsgGUID: uQGBYB+UTa6WP2eM+WHB2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="53816283"
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="53816283"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 01:27:44 -0700
X-CSE-ConnectionGUID: Hyj8XmZIREGYlp0Fp6jlOQ==
X-CSE-MsgGUID: oA/EviQmTmWFP/GcZLUptQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="153737688"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 03 Jul 2025 01:27:39 -0700
Date: Thu, 3 Jul 2025 16:49:03 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Reinoud Zandijk <reinoud@netbsd.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v4 59/65] accel: Always register
 AccelOpsClass::get_virtual_clock() handler
Message-ID: <aGZD/1EXudZKwJXB@intel.com>
References: <20250702185332.43650-1-philmd@linaro.org>
 <20250702185332.43650-60-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250702185332.43650-60-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Jul 02, 2025 at 08:53:21PM +0200, Philippe Mathieu-Daud� wrote:
> Date: Wed,  2 Jul 2025 20:53:21 +0200
> From: Philippe Mathieu-Daud� <philmd@linaro.org>
> Subject: [PATCH v4 59/65] accel: Always register
>  AccelOpsClass::get_virtual_clock() handler
> X-Mailer: git-send-email 2.49.0
> 
> In order to dispatch over AccelOpsClass::get_virtual_clock(),
> we need it always defined, not calling a hidden handler under
> the hood. Make AccelOpsClass::get_virtual_clock() mandatory.
> Register the default cpus_kick_thread() for each accelerator.
> 
> Signed-off-by: Philippe Mathieu-Daud� <philmd@linaro.org>
> ---
>  include/system/accel-ops.h        | 2 ++
>  accel/hvf/hvf-accel-ops.c         | 1 +
>  accel/kvm/kvm-accel-ops.c         | 1 +
>  accel/tcg/tcg-accel-ops.c         | 2 ++
>  accel/xen/xen-all.c               | 1 +
>  system/cpus.c                     | 7 ++++---
>  target/i386/nvmm/nvmm-accel-ops.c | 1 +
>  target/i386/whpx/whpx-accel-ops.c | 1 +
>  8 files changed, 13 insertions(+), 3 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


