Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 399FDAF862E
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Jul 2025 06:09:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXXiF-000442-M8; Fri, 04 Jul 2025 00:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uXXhu-000433-0I
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 00:07:26 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uXXhi-0007bo-5s
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 00:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751602034; x=1783138034;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=voE+aw6WOFwpnwlh/tV6warexGQq21fGKp3PtPPCuP8=;
 b=IF3w22ilXQv8bg0B4+zR9c3hJribVkLtQf91CXoMZI8XNq3XvMzQvURe
 oOUEdaUmbT4t0pQ0XR59uYML3uXafJ+FoL2DwnA0EPI+ZIDfia0jv7MNy
 DxmToJX506yLC8z407IMXXrpBdueX7hzAP4/VK2vNSJYm2h6WC4KGuaw4
 O1pb/bgCTxTzX9NcqdRHlJfDa1VnPDjy6vQgX4qvfND5Pwh3edzeHOKoi
 OyKcJZnAjce0LGsmO6Ny+uXwmB/ZCmar0KjAStpwxfBP1JDIzSDtMWd7m
 ZoY4VzWJmLtgVYFvnYxns2YRGbcErG1kl1CIN0OaETD0UHfbdQEPB+dOv w==;
X-CSE-ConnectionGUID: Rt2m/NIZTYekIfGMfPg4QQ==
X-CSE-MsgGUID: Td5vFIwHTcOHDO995uIqfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="54055301"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="54055301"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 21:07:11 -0700
X-CSE-ConnectionGUID: /E4w941ZQ12tQY00j9sh5A==
X-CSE-MsgGUID: W/NBIiwpQViHwljx/dqA4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="160227317"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 21:07:10 -0700
Message-ID: <adb9d667-9204-412a-9a86-a977f4d992a4@intel.com>
Date: Fri, 4 Jul 2025 12:07:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/39] system/cpus: Assert interrupt handling is done
 with BQL locked
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-5-philmd@linaro.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250703173248.44995-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 7/4/2025 1:32 AM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/tcg-accel-ops.c | 2 --
>   system/cpus.c             | 2 ++
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
> index b24d6a75625..6116644d1c0 100644
> --- a/accel/tcg/tcg-accel-ops.c
> +++ b/accel/tcg/tcg-accel-ops.c
> @@ -93,8 +93,6 @@ static void tcg_cpu_reset_hold(CPUState *cpu)
>   /* mask must never be zero, except for A20 change call */
>   void tcg_handle_interrupt(CPUState *cpu, int mask)
>   {
> -    g_assert(bql_locked());
> -
>       cpu->interrupt_request |= mask;
>   
>       /*
> diff --git a/system/cpus.c b/system/cpus.c
> index d16b0dff989..a43e0e4e796 100644
> --- a/system/cpus.c
> +++ b/system/cpus.c
> @@ -265,6 +265,8 @@ static void generic_handle_interrupt(CPUState *cpu, int mask)
>   
>   void cpu_interrupt(CPUState *cpu, int mask)
>   {
> +    g_assert(bql_locked());

The best result is it doesn't break any thing. But it can surely help 
catch the case without bql locked and get the case fixed them.

So

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

>       if (cpus_accel->handle_interrupt) {
>           cpus_accel->handle_interrupt(cpu, mask);
>       } else {


