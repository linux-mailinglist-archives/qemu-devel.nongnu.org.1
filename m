Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FA782D41D
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 07:12:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPGC3-0003mQ-Nd; Mon, 15 Jan 2024 01:11:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rPGC1-0003mB-Bl
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 01:11:29 -0500
Received: from mgamail.intel.com ([192.55.52.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rPGBz-0001WF-Rz
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 01:11:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705299087; x=1736835087;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=lp6RHB/0UONK9P55OMMDkjSfi/yWfaQppIedH9O1BQ4=;
 b=lfqHEnHOziFPnZVQaTWvslhZuv1QaX2GUPHo4xB2bC7/EFQPfy7tofZo
 RZWvSl3u5RfYC1V9QlzADw657c6OTKs8iUfjqMM7KU3WAA/bgwPWZXoJ1
 DKm04ROvsheXj2BN3/wNipVzfZBk8pGRzOWtlcwJbLnpjcujW+2suPPwU
 SenQCrQBzj9F7OmQWxBSKGd2ilRemsQGr0uBt3Wx2258GkdZEoEXTiELx
 lAD2QjWTMoHIaxrQxnfNrlZHKdmm7pRvFDj8IqL3Xeen3Kkmu4xmx7JbM
 cGz80oYfqcibUi7jduv9vpmucZ+9tM1aInSBuAwwxXr6POaO0FJXL6Qb3 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="485701986"
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; d="scan'208";a="485701986"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2024 22:11:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="817719589"
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; d="scan'208";a="817719589"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.22.149])
 ([10.93.22.149])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2024 22:11:20 -0800
Message-ID: <78168ef8-2354-483a-aa3b-9e184de65a72@intel.com>
Date: Mon, 15 Jan 2024 14:11:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/16] i386: Expose module level in CPUID[0x1F]
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Yuan Yao <yuan.yao@linux.intel.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Babu Moger <babu.moger@amd.com>, Yongwei Ma <yongwei.ma@intel.com>
References: <20240108082727.420817-1-zhao1.liu@linux.intel.com>
 <20240108082727.420817-9-zhao1.liu@linux.intel.com>
 <20240115032524.44q5ygb25ieut44c@yy-desk-7060> <ZaSv51/5Eokkv5Rr@intel.com>
 <336a4816-966d-42b0-b34b-47be3e41446d@intel.com> <ZaTM5njcfIgfsjqt@intel.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ZaTM5njcfIgfsjqt@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.55.52.43; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.998, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 1/15/2024 2:12 PM, Zhao Liu wrote:
> Hi Xiaoyao,
> 
> On Mon, Jan 15, 2024 at 12:34:12PM +0800, Xiaoyao Li wrote:
>> Date: Mon, 15 Jan 2024 12:34:12 +0800
>> From: Xiaoyao Li <xiaoyao.li@intel.com>
>> Subject: Re: [PATCH v7 08/16] i386: Expose module level in CPUID[0x1F]
>>
>>> Yes, I think it's time to move to default 0x1f.
>>
>> we don't need to do so until it's necessary.
> 
> Recent and future machines all support 0x1f, and at least SDM has
> emphasized the preferred use of 0x1f.

The preference is the guideline for software e.g., OS. QEMU doesn't need 
to emulate cpuid leaf 0x1f to guest if there is only smt and core level. 
because in this case, they are exactly the same in leaf 0xb and 0x1f. we 
don't need to bother advertising the duplicate data.

> Thanks,
> Zhao
> 


