Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C00BAF6CC6
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Jul 2025 10:25:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXFFX-0004DI-JT; Thu, 03 Jul 2025 04:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXFFV-0004CE-DQ
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 04:24:53 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXFFT-0004hB-TX
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 04:24:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751531092; x=1783067092;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=OL7YB4QqrsOIrbmMdhLO6b5EBpFpjMPIWAfHz4kxYTk=;
 b=UOrk1O1BYTMSHTo6xuiNKauhLDNEulPE5n5Jq6Hl9o0N4wYouLBc8Knt
 Hrc2ciqGAljN2DTmvFeURh++QclvL8h7JI5D+NK1RKrhetznHEweohHr1
 sCkV7kyi+rdZNE2ONp7xYl+P5tsqJOYh3XtsLQo7k3g1Oh6VHQ7KbOu0w
 2zmXMIfLygqq6LzAZcXK1YYI4PDEWR2/s4D7MGUAwuFC3kXZZCnoDRK5L
 jFEy31G2whT8bAt+5AccufSb+HOVim14BoHwxKQB2PDCiAQAT21Rb5Xq3
 7SRaQugePAX1Mn9gLvHeSNKoENlUZmj0ehZsnF3nlb/iGxetyCNU2dqXT w==;
X-CSE-ConnectionGUID: fskSeSzHSKGFkH4j29EI/A==
X-CSE-MsgGUID: +gqWmG6tQRqC/Bt3N2Rsbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="64897790"
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="64897790"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 01:24:50 -0700
X-CSE-ConnectionGUID: K/Lh4bp/RTiD0Ygz1JEFag==
X-CSE-MsgGUID: enRRDQADQwmF7whpYfHbxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="158577105"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 03 Jul 2025 01:24:46 -0700
Date: Thu, 3 Jul 2025 16:46:12 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v4 57/65] accel: Always register
 AccelOpsClass::kick_vcpu_thread() handler
Message-ID: <aGZDVG3775oKYQmI@intel.com>
References: <20250702185332.43650-1-philmd@linaro.org>
 <20250702185332.43650-58-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250702185332.43650-58-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
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

On Wed, Jul 02, 2025 at 08:53:19PM +0200, Philippe Mathieu-Daud� wrote:
> Date: Wed,  2 Jul 2025 20:53:19 +0200
> From: Philippe Mathieu-Daud� <philmd@linaro.org>
> Subject: [PATCH v4 57/65] accel: Always register
>  AccelOpsClass::kick_vcpu_thread() handler
> X-Mailer: git-send-email 2.49.0
> 
> In order to dispatch over AccelOpsClass::kick_vcpu_thread(),
> we need it always defined, not calling a hidden handler under
> the hood. Make AccelOpsClass::kick_vcpu_thread() mandatory.
> Register the default cpus_kick_thread() for each accelerator.
> 
> Signed-off-by: Philippe Mathieu-Daud� <philmd@linaro.org>
> ---
>  include/system/accel-ops.h | 1 +
>  accel/kvm/kvm-accel-ops.c  | 1 +
>  accel/qtest/qtest.c        | 1 +
>  accel/xen/xen-all.c        | 1 +
>  system/cpus.c              | 7 ++-----
>  5 files changed, 6 insertions(+), 5 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


