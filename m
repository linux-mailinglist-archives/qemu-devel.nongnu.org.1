Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0414176436B
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 03:33:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOplc-0002RU-62; Wed, 26 Jul 2023 21:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qOplW-0002RI-Km
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 21:26:06 -0400
Received: from mga02.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qOplR-0004kD-OH
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 21:26:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690421161; x=1721957161;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=E54NwtK23mdQagUZXei117N6f0+dXLWdQNgZl3BUoPA=;
 b=Yd+QHYKjxpb7LnZrWoGwC2+kwhpsB/EmKA65fGUDKBVrTDd+LSL4+Yk9
 BF7y95sFBxdxI/S+1rZcNHGXhQi/OBUPucHh2PTYTzm0EkcwibxMPHb2b
 QDN+yN1+8E3z6d6r0j3Yh2NOw7RiMaxrrSTcGoRkrs2oSgawa3XFWJQA4
 VoMjhR1J2opQ8C13IWyeqF04X03NX1uP7RBub61D7k/rb6dv30llUFx1j
 1dYWmDPytuoIvtWYyezHi+BxvxrWM/R0e67WWfTJ67udtxuTFqUBDYTp9
 1RIZZeau7f4U7o73TwkxBYkNUvNsz+N3eqLvLpGHCtIxAZeuyzlABje7O w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="358175071"
X-IronPort-AV: E=Sophos;i="6.01,233,1684825200"; d="scan'208";a="358175071"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jul 2023 18:25:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="973365268"
X-IronPort-AV: E=Sophos;i="6.01,233,1684825200"; d="scan'208";a="973365268"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.6.77])
 ([10.93.6.77])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jul 2023 18:25:53 -0700
Message-ID: <80dc2f6b-6cc7-c8fc-44c6-e6529c35d445@intel.com>
Date: Thu, 27 Jul 2023 09:25:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH] target/i386: Fix reporting of CPU dies when
 nr_cores=nr_threads=1
Content-Language: en-US
To: =?UTF-8?B?5bCP5aSq?= <nospam@kota.moe>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, babu.moger@amd.com
References: <20230723185909.441455-1-nospam@kota.moe>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20230723185909.441455-1-nospam@kota.moe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.20; envelope-from=xiaoyao.li@intel.com;
 helo=mga02.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/24/2023 2:59 AM, 小太 wrote:
> When QEMU is started with `-smp D,sockets=1,dies=D,cores=1,threads=1` (that
> is, 1 socket with D dies but each die contains just a single thread), both
> Linux and Windows guests incorrectly interprets the system as having D
> sockets with 1 die each
> 
> Ultimately this is caused by various CPUID leaves not being die-aware in
> their "threads per socket" calculations, so this patch fixes that
> 
> These changes are referenced to the AMD PPR for Family 19h Model 01h (Milan)
> and Family 17h Model 01h (Naples) manuals:
>   - CPUID_Fn00000001_EBX[23:16]: Number of threads in the processor
>                                  (Core::X86::Cpuid::SizeId[NC] + 1)
>   - CPUID_Fn0000000B_EBX_x01[15:0]: Number of logical cores in processor
>                                     socket (not present until Rome)
>   - CPUID_Fn80000001_ECX[1]: Multi core product
>                              (Core::X86::Cpuid::SizeId[NC] != 0)
>   - CPUID_Fn80000008_ECX[7:0]: The number of threads in the package - 1
>                                (Core::X86::Cpuid::SizeId[NC])
> 
> Note there are two remaining occurences that I didn't touch:
>   - CPUID_Fn8000001E_ECX[10:8]: Always 0 (1 node per processor) for Milan.
>                                 But for Naples, it can also be 2 or 4 nodes
>                                 where each node is defined as one or two
>                                 CCXes (CCD?). But Milan also has multiple
>                                 CCXes, so clearly the definition of a node is
>                                 different from model to model, so I've left
>                                 it untouched. (QEMU seems to use the Naples
>                                 definition)
>   - MSR_CORE_THREAD_COUNT: This MSR doesn't exist on Milan or Naples

Is this patch specific to AMD CPU type? what's situation for Intel CPU?


