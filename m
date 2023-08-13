Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B91A77AEF9
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 01:49:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVKpE-0006aS-44; Sun, 13 Aug 2023 19:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1qVKpB-0006aG-Gq
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 19:48:45 -0400
Received: from mgamail.intel.com ([192.55.52.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1qVKp8-0000RD-BJ
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 19:48:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691970522; x=1723506522;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=x+9NiVqCNSgHBifXxq3zeYAQc+a6TAIhWJ1if0Ru1M4=;
 b=EyPbNzY2EF7Jt7TepbLGpWtwSw3Rr0LttFNUu4ukYxfslYSfRv02uYWr
 wYpHeoP3pRWC07j19tFVDGaCVlPHtyUvDc8WZD9ZsbyS3A5q9NJX+Bd/O
 Amh3hbn61m0VIFyisV9ouSQiwQBhrRfNoMKDrTabs8eDSPX2OnwrDYsRF
 hyv8oVqUF/JBAvmOuoFvW7yY4MbUytgaZUC3tUfTNKZKdBnZNADpFnVwr
 Ok6mNmzQZ03h+TBRNCqIUexfvEhS884r1OPhrQV+WWq3A2utHVPOuIs+h
 +3L/DIoAhWBvYIKRTI41iPM5g69HzzZTcFXsTUi/zsMOO2zuyRJAX2gbs Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="458296100"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; d="scan'208";a="458296100"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2023 16:48:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="856886490"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; d="scan'208";a="856886490"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.28])
 by orsmga004.jf.intel.com with ESMTP; 13 Aug 2023 16:48:35 -0700
Date: Mon, 14 Aug 2023 07:59:07 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: "Wen, Qian" <qian.wen@intel.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 xiaoyao.li@intel.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, babu.moger@amd.com, zhao1.liu@intel.com
Subject: Re: [PATCH v2] target/i386: Avoid cpu number overflow in legacy
 topology
Message-ID: <ZNluSyIAyOxYFomL@liuzhao-OptiPlex-7080>
References: <20230809102732.3124908-1-qian.wen@intel.com>
 <20230809131426.1d9f5821@imammedo.users.ipa.redhat.com>
 <f1710cde-a3ce-6125-2608-c1ebcf4be581@intel.com>
 <20230809154742.494c3697@imammedo.users.ipa.redhat.com>
 <6aa7915c-c39d-ad5f-0171-8516868c9632@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6aa7915c-c39d-ad5f-0171-8516868c9632@intel.com>
Received-SPF: pass client-ip=192.55.52.43; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Hi Qian,

On Sun, Aug 13, 2023 at 06:49:40PM +0800, Wen, Qian wrote:

[snip]

> 
> > also perhaps double check if we could do induce similar overflow
> > tweaking other -smp properties (todo for another patch[es] if there are such places).
> 
> I have a check, the CPUID.0x4:EAX[31:26] indicates the Maximum number of addressable IDs for processor cores in the physical package.
> If we launch over 64 cores VM, the 6-bits field will also overflow. I will add the following fix to patch2 in v2.

Good catch!

Just discussion, I find if we use APIC ID offset to encode 0x4, then it
seems no need for an explicit check [1], right?

[1]: https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg00027.html

Thanks,
Zhao

> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 52a2a1a1c7..9c1ae3d83d 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -243,6 +243,7 @@ static void encode_cache_cpuid4(CPUCacheInfo *cache,
>                            cache->partitions * cache->sets);
> 
>      assert(num_apic_ids > 0);
> +    num_cores = num_cores > 64 ? 64 : num_cores;
>      *eax = CACHE_TYPE(cache->type) |
>             CACHE_LEVEL(cache->level) |
>             (cache->self_init ? CACHE_SELF_INIT_LEVEL : 0) |
> 
> 
> Thanks,
> Qian
> >>>>              *edx |= CPUID_HT;
> >>>>          }
> >>>>          if (!cpu->enable_pmu) {  

