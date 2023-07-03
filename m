Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF3F7453BC
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 04:05:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qG8uc-0004Xr-Aj; Sun, 02 Jul 2023 22:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qG8ub-0004Xj-0N
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 22:03:33 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qG8uY-0003sb-7k
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 22:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688349810; x=1719885810;
 h=message-id:date:mime-version:subject:from:to:cc:
 references:in-reply-to:content-transfer-encoding;
 bh=fBvyhvmtXOZ4Tqf7BaX5W0+CCj+IK/xjZXI+1zrI2YA=;
 b=VrYznYTehWmEZjD2czwe97q2KglqSyFFTFhm4iGWrISjIec0XJBnrRQ2
 /5EhhNflv+TpRowIABqqGy8KfWkBiqXDavkoTm6q2WBltKfO9PlEnVgxg
 tDOLwP+KxbS+l4XzsmnHs+GBrZgX0IcrSqSGe6B5hDYWe0ldvzq+1ZmfY
 gq2cBbL3CByrfxHQ0c2AaRJTOWpaMLHaVLFC9WH/yL5sj8JHfrkrSk0CN
 5i+2V5P/1BMHg21TEZes8DJtFmwnxTkLEv5/C+6yekjTJXQYTGgWUVKdH
 DmiJZ8xWqrdeT+Kge2u2XdUaqhWjkKPWAs6oiMAYm372UsL+CUr7SFlUH w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="428811950"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; d="scan'208";a="428811950"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2023 19:03:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="831629111"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; d="scan'208";a="831629111"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.249.168.99])
 ([10.249.168.99])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2023 19:03:08 -0700
Message-ID: <c953ab83-13f4-88a6-5dea-980707016119@intel.com>
Date: Mon, 3 Jul 2023 10:03:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCH v4 0/8] i386: Make Intel PT configurable
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Chenyi Qiang <chenyi.qiang@intel.com>, lei4.wang@intel.com
References: <20230531084311.3807277-1-xiaoyao.li@intel.com>
In-Reply-To: <20230531084311.3807277-1-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=xiaoyao.li@intel.com; helo=mga07.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 5/31/2023 4:43 PM, Xiaoyao Li wrote:
> Initial virtualization of Intel PT was added by making it as fixed
> feature set of ICX's capabilities. However, it breaks the Intel PT exposure
> on SPR machine because SPR has less PT capabilities of
> CPUID(0x14,1):EBX[15:0].
> 
> This series aims to make Intel PT configurable that named CPU model can
> define its own PT feature set and "-cpu host/max" can use host pass-through
> feature set of Intel PT.
> 
> At the same time, it also ensures existing named CPU model to generate
> the same PT CPUID set as before to not break live migration.

ping for comments.

QEMU maintainers,

It has been nearly two years since the first version. It's very 
appreciated if any of you can express any thought on it. E.g., the basic 
question, whether this is an useful fix? or just a vain work?

> Changes in v4:
> - rebase to 51bdb0b57a2d "Merge tag 'pull-tcg-20230530' of https://gitlab.com/rth7680/qemu into staging"
> - cleanup Patch 6 by updating the commit message and remove unnecessary
>    handlng;
> 
> v3: https://lore.kernel.org/qemu-devel/20221208062513.2589476-1-xiaoyao.li@intel.com/
> - rebase to v7.2.0-rc4
> - Add bit 7 and 8 of FEAT_14_0_EBX in Patch 3
> 
> v2: https://lore.kernel.org/qemu-devel/20220808085834.3227541-1-xiaoyao.li@intel.com/
> Changes in v2:
> - split out 3 patches (per Eduardo's comment)
> - determine if the named cpu model uses default Intel PT capabilities (to
>    be compatible with the old behavior) by condition that all PT feature
>    leaves are all zero.
> 
> v1: https://lore.kernel.org/qemu-devel/20210909144150.1728418-1-xiaoyao.li@intel.com/
> 
> 
> Xiaoyao Li (8):
>    target/i386: Print CPUID subleaf info for unsupported feature
>    target/i386/intel-pt: Fix INTEL_PT_ADDR_RANGES_NUM_MASK
>    target/i386/intel-pt: Introduce FeatureWordInfo for Intel PT CPUID
>      leaf 0x14
>    target/i386/intel-pt: print special message for
>      INTEL_PT_ADDR_RANGES_NUM
>    target/i386/intel-pt: Rework/rename the default INTEL-PT feature set
>    target/i386/intel-pt: Enable host pass through of Intel PT
>    target/i386/intel-pt: Define specific PT feature set for
>      IceLake-server, Snowridge and SapphireRapids
>    target/i386/intel-pt: Access MSR_IA32_RTIT_ADDRn based on guest CPUID
>      configuration
> 
>   target/i386/cpu.c     | 293 +++++++++++++++++++++++++++++++-----------
>   target/i386/cpu.h     |  39 +++++-
>   target/i386/kvm/kvm.c |   8 +-
>   3 files changed, 261 insertions(+), 79 deletions(-)
> 


