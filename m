Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D513F82F1BC
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 16:44:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPlb5-0006Bx-QV; Tue, 16 Jan 2024 10:43:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rPlb4-0006Bb-7r
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 10:43:26 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rPlb2-00037s-3y
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 10:43:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705419804; x=1736955804;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=jMHWbHTrwUixlj72lMGsg0Kp9i8eoQYhSby7brDgyws=;
 b=dE7W0RWk61g2YtuLrNa3Y+FB0Jwwaz6ldJnfLD6BlcDI69ey3DLVMVqe
 FczD+hVbY31pPOZL2xQ/XMW+xfpbL7vKG1nja/lU7AcY/ticbQ/Prbjmk
 dyp9pbg+vPXSJfhXVzgQIDi/HG7aCCueWbsbfhjw+XeQooRhOdtiJZaWN
 kknq0qTv885K+EmJb+6pdAeYvVBOLU6py4H9x48yg/r29M//LcWigJaIP
 uN4W5p2JHCm4tCTLHjgGz2dEOusoLdx+g19NZNNKH1ypGpghVpAH6NMmh
 03Cem6T/YxwHbXs/ORYg28OoE4AYC+S6tlCBs7D/BLE8vyuEeLkJ5h1qQ A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="13398685"
X-IronPort-AV: E=Sophos;i="6.05,199,1701158400"; d="scan'208";a="13398685"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2024 07:42:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="784164474"
X-IronPort-AV: E=Sophos;i="6.05,199,1701158400"; d="scan'208";a="784164474"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.22.149])
 ([10.93.22.149])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2024 07:42:57 -0800
Message-ID: <32d295bf-33d0-48d4-9af1-1119413689d0@intel.com>
Date: Tue, 16 Jan 2024 23:42:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] i386/cpu: Two minor fixes for
 x86_cpu_enable_xsave_components()
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Yang Weijiang <weijiang.yang@intel.com>
References: <20240115091325.1904229-1-xiaoyao.li@intel.com>
 <ZaaQc8kMkLBN+t/g@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ZaaQc8kMkLBN+t/g@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.8; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.998, HK_RANDOM_FROM=0.998, SPF_HELO_NONE=0.001,
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

On 1/16/2024 10:19 PM, Zhao Liu wrote:
> Hi Xiaoyao,
> 
> On Mon, Jan 15, 2024 at 04:13:23AM -0500, Xiaoyao Li wrote:
>> Date: Mon, 15 Jan 2024 04:13:23 -0500
>> From: Xiaoyao Li <xiaoyao.li@intel.com>
>> Subject: [PATCH 0/2] i386/cpu: Two minor fixes for
>>   x86_cpu_enable_xsave_components()
>> X-Mailer: git-send-email 2.34.1
>>
>> The two bugs were introduced when xsaves feature was added by commit
>> 301e90675c3f ("target/i386: Enable support for XSAVES based features").
> 
> Could you please provide more details about reproducing these two bugs?
> If I'm able, I'd be glad to help you to test and verify them.

There are potential bugs and currently we don't have test step to 
trigger it. Because for patch 1, KVM doesn't support arch-lbr 
virtualization yet, which is the first user in QEMU of xss. Once KVM 
merges the arch-lbr series, using "-cpu xxx,+arch-lbr,-xsave" can expose 
arch-lbr to guest, which violates the architectural behavior of xfeatures.

For patch2, current code just happens to work correctly because there is 
not xfeature in upper 32-bit get defined yet. But I think make the code 
logically correct is important and we shouldn't depend on the 
happened-to-work code.


> Regards,
> Zhao
> 
>>
>> Xiaoyao Li (2):
>>    i386/cpu: Clear FEAT_XSAVE_XSS_LO/HI leafs when CPUID_EXT_XSAVE is not
>>      available
>>    i386/cpu: Mask with XCR0/XSS mask for FEAT_XSAVE_XCR0_HI and
>>      FEAT_XSAVE_XSS_HI leafs
>>
>>   target/i386/cpu.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> -- 
>> 2.34.1
>>
>>


