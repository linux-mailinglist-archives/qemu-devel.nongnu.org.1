Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF95AF6B17
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Jul 2025 09:08:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXE3K-0002hC-8J; Thu, 03 Jul 2025 03:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXE3B-0002dO-HS
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 03:08:06 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXE39-0003gB-SZ
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 03:08:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751526484; x=1783062484;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=FXvc684D0sDOD6c+tBWddt+cxkjspLqtcaynFtLq82Q=;
 b=NceOEaxfOo57Srq4zuzide6gKuXgK28E9I/l++YSVJIoz6xX7TsmXGwT
 jeNfHT2A7tpGOSehqoifpZHg4Pr/UUrZv2NScWlvUSeHya9TfEMb2+YK+
 8vbqZ6uidZU2G1mE2yeafp2tb8T7Z5glrevccLduzREd36UIl4N+RTOc2
 b6akw/+TXE3gC2jpW7dH/RTzlt5JVj4b4C7Z9lGQks6J61ZBQSdCccmwg
 MLV8vl/8ai7mWiFyK9NzuMnaT7H/4b6kheW3nTz7VZIfiNFe2fQbSEICm
 00ub8kMxgCrU9mdMcBamol7xzlgswtic6R+wMsr2RAEZvhJB/sXifPpYp g==;
X-CSE-ConnectionGUID: NyK0iwo9Rl+KK1WHwV8H8Q==
X-CSE-MsgGUID: 1S+UE9UOTy+5y4H0sEdhQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="64085178"
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="64085178"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 00:08:03 -0700
X-CSE-ConnectionGUID: 2Zw6MBXXSzWMXukTINKIeg==
X-CSE-MsgGUID: PQTyxZamRuetOj5GqaoYXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="177956453"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 03 Jul 2025 00:08:00 -0700
Date: Thu, 3 Jul 2025 15:29:25 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [PATCH v4 32/65] cpus: Document CPUState::vcpu_dirty field
Message-ID: <aGYxVegUOZu/IHGP@intel.com>
References: <20250702185332.43650-1-philmd@linaro.org>
 <20250702185332.43650-33-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250702185332.43650-33-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
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

On Wed, Jul 02, 2025 at 08:52:54PM +0200, Philippe Mathieu-Daud� wrote:
> Date: Wed,  2 Jul 2025 20:52:54 +0200
> From: Philippe Mathieu-Daud� <philmd@linaro.org>
> Subject: [PATCH v4 32/65] cpus: Document CPUState::vcpu_dirty field
> X-Mailer: git-send-email 2.49.0
> 
> Signed-off-by: Philippe Mathieu-Daud� <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/hw/core/cpu.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


