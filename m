Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92290835D63
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 09:56:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRq5b-0003zx-Tp; Mon, 22 Jan 2024 03:55:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <binbin.wu@linux.intel.com>)
 id 1rRq5X-0003yq-Qj
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 03:55:27 -0500
Received: from mgamail.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <binbin.wu@linux.intel.com>)
 id 1rRq5V-0000Ue-CR
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 03:55:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705913725; x=1737449725;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=wUdT4fRB5Nf5lr+Hx1LVC2U0RFqx5arh4ZtYweAoHYI=;
 b=D9QfVWwvYmNFf0nT7G3Trr4q4Lic7ArzA9x+UZIspijLZ2L6/SIO017r
 sHtl4buRVVazyh+sWPmcfFzvv9e1v6qNAZDwJ95ynRIBD6jPn55FNiIUP
 uGAjuKjdeUelMLLNzfzbieZc03h+r2THfjLthh9bdMZBMqw02cmobItK5
 jzNkwRoP6gtkSvGh9gNv0/KTNtRklAlAuGTqtyG9UnirT9KppzeSNpOJx
 zlg3Mnj0YnGTG134isVl/vLyVh9p2iiO3goI4Vhh0nsHk6M9BYdhVpAzE
 aBUrjPDwWI9jAFP0muA8HzUItyK/qY1d8YpiFrN332kNv18acBs2bKmPM w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="398301309"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; d="scan'208";a="398301309"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2024 00:55:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="928932124"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; d="scan'208";a="928932124"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.238.10.49])
 ([10.238.10.49])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2024 00:55:20 -0800
Message-ID: <d424a315-1b20-47bf-a88e-394f576c3cc1@linux.intel.com>
Date: Mon, 22 Jan 2024 16:55:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] Add support for LAM in QEMU
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com
Cc: xiaoyao.li@intel.com, chao.gao@intel.com, robert.hu@linux.intel.com,
 binbin.wu@linux.intel.com
References: <20240112060042.19925-1-binbin.wu@linux.intel.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20240112060042.19925-1-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=192.55.52.93;
 envelope-from=binbin.wu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

Gentle ping...
Please help to review and consider applying the patch series. (The KVM
part has been merged).


On 1/12/2024 2:00 PM, Binbin Wu wrote:
> Linear-address masking (LAM) [1], modifies the checking that is applied to
> *64-bit* linear addresses, allowing software to use of the untranslated
> address bits for metadata and masks the metadata bits before using them as
> linear addresses to access memory.
>
> When the feature is virtualized and exposed to guest, it can be used for
> efficient
> address sanitizers (ASAN) implementation and for optimizations in JITs and
> virtual machines.
>
> The KVM patch series can be found in [2].
>
> [1] Intel ISE https://cdrdv2.intel.com/v1/dl/getContent/671368
>      Chapter Linear Address Masking (LAM)
> [2] https://lore.kernel.org/kvm/20230913124227.12574-1-binbin.wu@linux.intel.com
>
> ---
> Changelog
> v4:
> - Add a reviewed-by from Xiaoyao for patch 1.
> - Mask out LAM bit on CR4 if vcpu doesn't support LAM in cpu_x86_update_cr4() (Xiaoyao)
>
> v3:
> - https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg04160.html
>
> Binbin Wu (1):
>    target/i386: add control bits support for LAM
>
> Robert Hoo (1):
>    target/i386: add support for LAM in CPUID enumeration
>
>   target/i386/cpu.c    | 2 +-
>   target/i386/cpu.h    | 9 ++++++++-
>   target/i386/helper.c | 4 ++++
>   3 files changed, 13 insertions(+), 2 deletions(-)
>
>
> base-commit: f614acb7450282a119d85d759f27eae190476058


