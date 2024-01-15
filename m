Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4483182DB80
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 15:42:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPO9S-0004WU-5V; Mon, 15 Jan 2024 09:41:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rPO9O-0004W2-Td
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 09:41:19 -0500
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rPO9J-000509-PO
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 09:41:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705329673; x=1736865673;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=dYq5hCN/W92Lv1KF8iPcuma+25eA944dTTBO5eMCGgo=;
 b=EAZVRNkxGa4Tbe67GQQgeWpHEmGTWA/XFrbSGJX/8WcUbtttY2TskoU0
 VXfxwlzOMkP3dIoP/J9ixJ1+3wYwt6huo9ASX5R1zY8SRrc0sC/s/Y7jw
 jMgU7ENL5ML7SQ+REHDTDEJAgNtGsgQJi0j/c96lvSllkcpfAIHhPRC8r
 06Y6OBshVsSHEtQMdzNyiVsVU3roHj9RvEHt1M09oaEVRWyuOeoKV8Hqw
 gOqdebAe7BScAQStZR/HYqmx1K1N0ZjfIAdpscymBI/+V68s9WS1RgTSz
 wz2eJCD78znvZn+eLxi3m4ix/x+IwJyfIOclTYR2tb+2DCJynDWQ2eMeQ g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="403389822"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="403389822"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 06:41:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="907072525"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="907072525"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orsmga004.jf.intel.com with ESMTP; 15 Jan 2024 06:41:05 -0800
Date: Mon, 15 Jan 2024 22:54:03 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, Babu Moger <babu.moger@amd.com>,
 Yongwei Ma <yongwei.ma@intel.com>
Subject: Re: [PATCH v7 15/16] i386: Use offsets get NumSharingCache for
 CPUID[0x8000001D].EAX[bits 25:14]
Message-ID: <ZaVHC4WwWQAB8pRu@intel.com>
References: <20240108082727.420817-1-zhao1.liu@linux.intel.com>
 <20240108082727.420817-16-zhao1.liu@linux.intel.com>
 <599ddf2d-dc2e-4684-b2c2-ba6dfd886f32@intel.com>
 <ZaSrKB3y9TEJZG5T@intel.com>
 <23c5eb57-d086-4e51-bfdf-a3019aad1c29@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23c5eb57-d086-4e51-bfdf-a3019aad1c29@intel.com>
Received-SPF: none client-ip=134.134.136.65;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
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

Hi Xiaoyao,

On Mon, Jan 15, 2024 at 12:27:43PM +0800, Xiaoyao Li wrote:
> Date: Mon, 15 Jan 2024 12:27:43 +0800
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: Re: [PATCH v7 15/16] i386: Use offsets get NumSharingCache for
>  CPUID[0x8000001D].EAX[bits 25:14]
> 
> On 1/15/2024 11:48 AM, Zhao Liu wrote:
> > Hi Xiaoyao,
> > 
> > On Sun, Jan 14, 2024 at 10:42:41PM +0800, Xiaoyao Li wrote:
> > > Date: Sun, 14 Jan 2024 22:42:41 +0800
> > > From: Xiaoyao Li <xiaoyao.li@intel.com>
> > > Subject: Re: [PATCH v7 15/16] i386: Use offsets get NumSharingCache for
> > >   CPUID[0x8000001D].EAX[bits 25:14]
> > > 
> > > On 1/8/2024 4:27 PM, Zhao Liu wrote:
> > > > From: Zhao Liu <zhao1.liu@intel.com>
> > > > 
> > > > The commit 8f4202fb1080 ("i386: Populate AMD Processor Cache Information
> > > > for cpuid 0x8000001D") adds the cache topology for AMD CPU by encoding
> > > > the number of sharing threads directly.
> > > > 
> > > >   From AMD's APM, NumSharingCache (CPUID[0x8000001D].EAX[bits 25:14])
> > > > means [1]:
> > > > 
> > > > The number of logical processors sharing this cache is the value of
> > > > this field incremented by 1. To determine which logical processors are
> > > > sharing a cache, determine a Share Id for each processor as follows:
> > > > 
> > > > ShareId = LocalApicId >> log2(NumSharingCache+1)
> > > > 
> > > > Logical processors with the same ShareId then share a cache. If
> > > > NumSharingCache+1 is not a power of two, round it up to the next power
> > > > of two.
> > > > 
> > > >   From the description above, the calculation of this field should be same
> > > > as CPUID[4].EAX[bits 25:14] for Intel CPUs. So also use the offsets of
> > > > APIC ID to calculate this field.
> > > > 
> > > > [1]: APM, vol.3, appendix.E.4.15 Function 8000_001Dh--Cache Topology
> > > >        Information
> > > 
> > > this patch can be dropped because we have next patch.
> > 
> > This patch is mainly used to explicitly emphasize the change in encoding
> > way and compliance with AMD spec... I didn't tested on AMD machine, so
> > the more granular patch would make it easier for the community to review
> > and test.
> 
> then please move this patch ahead, e.g., after patch 2.
>

OK. Thanks!
-Zhao


