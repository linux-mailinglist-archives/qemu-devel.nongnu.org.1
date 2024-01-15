Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7363C82D39F
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 05:26:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPEXV-0008LW-Av; Sun, 14 Jan 2024 23:25:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rPEXT-0008LM-G8
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 23:25:31 -0500
Received: from mgamail.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rPEXR-0007It-Su
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 23:25:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705292729; x=1736828729;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=jQBlAV4p5/ywuHqFD+3l8FNasA0j7GohoEA/vJyB/q4=;
 b=mfYhiikdP1zIGbON7ikk9eaEzU8gYZjIRwOk+4iOv/Rvs/TPxp3Jwone
 SMd/bUyif1i56/UiTel/cLeb37LTyaV6uQbHleMtVFPkxYLOXs/rncT/1
 NvKz342w8Z48BAba7aId2FBOkQBNPa3G8Hm65AMGiPAdcPoXYLhelFfxC
 vqTyETNfvBFunS7qjDnRxwZ1Ud7chJV2xZI1Kd61vIpWclc1cIH65N1Ez
 pQnAfBX5agpy33ZERdk0ZIYESmp+S5PEzRcMDpamkuFzRgrF1pRuUdVwX
 kD5AClL/hVnD2NIs55nvBkH2YA8rKXH6rFazLqYp/ftwR+w1nHSg+pJJu g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="389978590"
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; d="scan'208";a="389978590"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2024 20:25:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="906945453"
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; d="scan'208";a="906945453"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.22.149])
 ([10.93.22.149])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2024 20:25:23 -0800
Message-ID: <5a004819-b9bf-4a2e-b8b3-ed238a66245a@intel.com>
Date: Mon, 15 Jan 2024 12:25:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 14/16] i386: Use CPUCacheInfo.share_level to encode
 CPUID[4]
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Babu Moger <babu.moger@amd.com>, Yongwei Ma <yongwei.ma@intel.com>
References: <20240108082727.420817-1-zhao1.liu@linux.intel.com>
 <20240108082727.420817-15-zhao1.liu@linux.intel.com>
 <a0cd67f2-94f2-4c4b-9212-6b7344163660@intel.com> <ZaSpQuQxU5UrbIf4@intel.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ZaSpQuQxU5UrbIf4@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=134.134.136.20; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.998, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 1/15/2024 11:40 AM, Zhao Liu wrote:
>>> +{
>>> +    uint32_t num_ids = 0;
>>> +
>>> +    switch (share_level) {
>>> +    case CPU_TOPO_LEVEL_CORE:
>>> +        num_ids = 1 << apicid_core_offset(topo_info);
>>> +        break;
>>> +    case CPU_TOPO_LEVEL_DIE:
>>> +        num_ids = 1 << apicid_die_offset(topo_info);
>>> +        break;
>>> +    case CPU_TOPO_LEVEL_PACKAGE:
>>> +        num_ids = 1 << apicid_pkg_offset(topo_info);
>>> +        break;
>>> +    default:
>>> +        /*
>>> +         * Currently there is no use case for SMT and MODULE, so use
>>> +         * assert directly to facilitate debugging.
>>> +         */
>>> +        g_assert_not_reached();
>>> +    }
>>> +
>>> +    return num_ids - 1;
>> suggest to just return num_ids, and let the caller to do the -1 work.
> Emm, SDM calls the whole "num_ids - 1" (CPUID.0x4.EAX[bits 14-25]) as
> "maximum number of addressable IDs for logical processors sharing this
> cache"...
> 
> So if this helper just names "num_ids" as max_lp_ids_share_the_cache,
> I'm not sure there would be ambiguity here?

I don't think it will.

if this function is going to used anywhere else, people will need to 
keep in mind to do +1 stuff to get the actual number.

leaving the -1 trick to where CPUID value gets encoded. let's make this 
function generic.

