Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A54E282DC6B
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 16:35:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPOyW-0007hw-JN; Mon, 15 Jan 2024 10:34:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rPOyT-0007hk-9A
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 10:34:05 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rPOyQ-00053o-VU
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 10:34:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705332843; x=1736868843;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=BvYElqNF/TZDG81UsNsX+qTj9zX0O6BlJNOmxzy7iN8=;
 b=PJhso6O0s/KDl6a3wn8ykmBJmaSR46l9Wf85Qp+MKZHs5azjxP9r6t5Q
 wQdcD4gDWqsZnzzQHtae2igtbh+yvitB4HjXAXPKZcYiNz2WSZDaMQoRH
 TRSZRM+9XHEK6y/Ye/kSWAQ3Bmb1YSAOCBeR38UXxvpb5igl1l6fMGo/P
 IvpsELZFXgG6eKtSPYQ3gg/7hEQ2NF+FJm7EU69NjupUeg8JNsm68A6V2
 c1FGiA/Ntlxv7/Lcbt6gPzRwAaLgdfvI7/0Tw/6fc/Q6rwgheqiHEiaca
 rLyQzVu08vCEt2Qai2B4QP5xJwgdKvgA/LvPJap2QPqeug+cpcHoqTfb2 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="7010169"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; 
   d="scan'208";a="7010169"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 07:33:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="25823786"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 15 Jan 2024 07:33:55 -0800
Date: Mon, 15 Jan 2024 23:46:53 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Yuan Yao <yuan.yao@linux.intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, Babu Moger <babu.moger@amd.com>,
 Yongwei Ma <yongwei.ma@intel.com>
Subject: Re: [PATCH v7 08/16] i386: Expose module level in CPUID[0x1F]
Message-ID: <ZaVTbY6m0/qUyeKK@intel.com>
References: <20240108082727.420817-1-zhao1.liu@linux.intel.com>
 <20240108082727.420817-9-zhao1.liu@linux.intel.com>
 <20240115032524.44q5ygb25ieut44c@yy-desk-7060>
 <ZaSv51/5Eokkv5Rr@intel.com>
 <336a4816-966d-42b0-b34b-47be3e41446d@intel.com>
 <ZaTM5njcfIgfsjqt@intel.com>
 <78168ef8-2354-483a-aa3b-9e184de65a72@intel.com>
 <ZaTSM8IAzQ1onX05@intel.com>
 <00873298-06b5-4286-9c92-54376ed2d09d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00873298-06b5-4286-9c92-54376ed2d09d@intel.com>
Received-SPF: none client-ip=192.198.163.10;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Xiaoyao,

On Mon, Jan 15, 2024 at 03:16:43PM +0800, Xiaoyao Li wrote:
> Date: Mon, 15 Jan 2024 15:16:43 +0800
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: Re: [PATCH v7 08/16] i386: Expose module level in CPUID[0x1F]
> 
> On 1/15/2024 2:35 PM, Zhao Liu wrote:
> > On Mon, Jan 15, 2024 at 02:11:17PM +0800, Xiaoyao Li wrote:
> > > Date: Mon, 15 Jan 2024 14:11:17 +0800
> > > From: Xiaoyao Li <xiaoyao.li@intel.com>
> > > Subject: Re: [PATCH v7 08/16] i386: Expose module level in CPUID[0x1F]
> > > 
> > > On 1/15/2024 2:12 PM, Zhao Liu wrote:
> > > > Hi Xiaoyao,
> > > > 
> > > > On Mon, Jan 15, 2024 at 12:34:12PM +0800, Xiaoyao Li wrote:
> > > > > Date: Mon, 15 Jan 2024 12:34:12 +0800
> > > > > From: Xiaoyao Li <xiaoyao.li@intel.com>
> > > > > Subject: Re: [PATCH v7 08/16] i386: Expose module level in CPUID[0x1F]
> > > > > 
> > > > > > Yes, I think it's time to move to default 0x1f.
> > > > > 
> > > > > we don't need to do so until it's necessary.
> > > > 
> > > > Recent and future machines all support 0x1f, and at least SDM has
> > > > emphasized the preferred use of 0x1f.
> > > 
> > > The preference is the guideline for software e.g., OS. QEMU doesn't need to
> > > emulate cpuid leaf 0x1f to guest if there is only smt and core level.
> > 
> > Please, QEMU is emulating hardware not writing software.
> 
> what I want to conveyed was that, SDM is teaching software how to probe the
> cpu topology, not suggesting VMM how to advertise cpu topology to guest.
> 

This reflects the hardware's behavioral tendency. Additionally, due to SDM
related suggestion about 0x1f preference, lots of new software may rely on
0x1f, making 0x1f as the default enabling leaf helps to enhance Guest
compatibility.

> 
> > Is there any
> > reason why we shouldn't emulate new and generic hardware behaviors and
> > stick with the old ones?
> 
> I didn't say we shouldn't, but we don't need to do it if it's unnecessary.

Probably never going to deprecate 0x0b, and 0x1f is in fact replacing 0x0b,
kind of like a timing issue, when should 0x1f be enabled by default?

Maybe for some new CPU models or -host, we can start making it as default.
This eliminates the difference in the CPU topology enumeration interface
between Host and Guest. What do you think?

> 
> if cpuid 0x1f is advertised to guest by default, it will also introduce the
> inconsistence. Old product doesn't have cpuid 0x1f, but using QEMU to
> emualte an old product, it has.

Yes, this is the similar case as 0x0b. Old machine doens't has 0x0b. And
QEMU uses cpuid-0xb option to resolve compatibility issue.

> 
> sure we can have code to fix it, that only expose 0x1f to new enough cpu
> model. But it just make thing complicated.
> 
> > > because in this case, they are exactly the same in leaf 0xb and 0x1f. we don't
> > > need to bother advertising the duplicate data.
> > 
> > You can't "define" the same 0x0b and 0x1f as duplicates. SDM doesn't
> > have such the definition.
> 
> for QEMU, they are duplicate data that need to be maintained and need to be
> passed to KVM by KVM_SET_CPUID. For guest, it's also unnecessary, because it
> doesn't provide any additional information with cpuid leaf 1f.

I understand your concerns. The benefit is to follow the behavior of the
new hardware and spec recommendations, on new machines people are going
to be more accustomed to using 0x1f to get topology, and VMs on new
machines that don't have 0x1f will tend to get confused.

I could start by having a look at if we could synchronize Host in -host
to enable 0x1f. If there isn't too much block, -host is an acceptable
starting point, after all, there are no additional compatibility issues
for this case. ;-)

Thanks,
Zhao

> 
> SDM keeps cpuid 0xb is for backwards compatibility.
> 

