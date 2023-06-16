Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF95732619
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 06:03:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qA0f8-0001L6-Sa; Fri, 16 Jun 2023 00:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1qA0f6-0001Kk-IZ
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 00:02:12 -0400
Received: from mga03.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1qA0f3-0002qq-MU
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 00:02:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686888129; x=1718424129;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=mg6uEkuVKWgDqk8dDeXPxV15S6vTSuM8FpgMTh3D+xI=;
 b=F9PIMcVtnyZAAKWB6Bnx0sr+NThWthltKsLmySMPTIy4/NS8ncnyuKRX
 A/A0u9rDCftqzpi6NOHyqHbPLhFQw6v9q4KrBdn95Hsh9HACzooy9HhrD
 +TeM+rh52VxgyAbv/aAP44ocbIuWsOdBLbNrk4yL3tx9N7Jg8/4BJ27eP
 s5eBGEcEvnMdeETgx3iKezSBYuR/Hh2uT2JNP6scfWxtz8R88PEhG2lck
 VzsCbe2zqNd45LiRii+aDrH5d1JtJyAHuiSFq0Qz2h+g6kNywin48sQSY
 ilmCe60QAnoloEvOZ4tzcRJhFQWA3D5RoWlRJKn3VHK2txUsoI8yZUc7h A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="362526973"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; d="scan'208";a="362526973"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2023 21:01:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="857233862"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; d="scan'208";a="857233862"
Received: from leiwang7-mobl.ccr.corp.intel.com (HELO [10.255.28.136])
 ([10.255.28.136])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2023 21:01:55 -0700
Message-ID: <728037d4-9f36-5bf2-5e2e-4f6ca76b79cd@intel.com>
Date: Fri, 16 Jun 2023 12:01:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCH 0/7] Add new CPU model EmeraldRapids and GraniteRapids
Content-Language: en-US
To: Tao Su <tao1.su@linux.intel.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, xiaoyao.li@intel.com, qian.wen@intel.com,
 imammedo@redhat.com
References: <20230616032311.19137-1-tao1.su@linux.intel.com>
From: "Wang, Lei" <lei4.wang@intel.com>
In-Reply-To: <20230616032311.19137-1-tao1.su@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=134.134.136.65; envelope-from=lei4.wang@intel.com;
 helo=mga03.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.098, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/16/2023 11:23, Tao Su wrote:
> This patch series mainly updates SapphireRapids CPU model and adds
> new CPU model EmeraldRapids and GraniteRapids.
> 
> Bit 13 (ARCH_CAP_FBSDP_NO), bit 14 (ARCH_CAP_FBSDP_NO) and bit 15

Bit 13 should be MSR_ARCH_CAP_SBDR_SSDP_NO, right?

> (ARCH_CAP_PSDP_NO) of MSR_IA32_ARCH_CAPABILITIES are enumerated starting
> from latest SapphireRapids, which are missed in current SapphireRapids
> CPU model, so add a new version for SapphireRapids CPU model to expose
> these bits.
> 
> Add EmeraldRapids CPU model to this series, since EmeraldRapids also
> enumerates these bits. The original patch of EmeraldRapids CPU model is
> in [1].
> 
> GraniteRapids is Intel's successor to EmeraldRapids, an Intel 3 process
> microarchitecture for enthusiasts and servers, which adds new features
> based on SapphireRapids and EmeraldRapids.
> 
> [1]
> https://lore.kernel.org/qemu-devel/20230515025308.1050277-1-qian.wen@intel.com/
> 
> Lei Wang (1):
>   target/i386: Add few security fix bits in ARCH_CAPABILITIES into
>     SapphireRapids CPU model
> 
> Qian Wen (1):
>   target/i386: Add new CPU model EmeraldRapids
> 
> Tao Su (5):
>   target/i386: Add FEAT_7_1_EDX to adjust feature level
>   target/i386: Add support for MCDT_NO in CPUID enumeration
>   target/i386: Allow MCDT_NO if host supports
>   target/i386: Add new bit definitions of MSR_IA32_ARCH_CAPABILITIES
>   target/i386: Add new CPU model GraniteRapids
> 
>  target/i386/cpu.c     | 303 +++++++++++++++++++++++++++++++++++++++++-
>  target/i386/cpu.h     |   8 ++
>  target/i386/kvm/kvm.c |   5 +
>  3 files changed, 314 insertions(+), 2 deletions(-)
> 
> 
> base-commit: 7efd65423ab22e6f5890ca08ae40c84d6660242f

