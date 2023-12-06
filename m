Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 535B0807378
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 16:14:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAtZy-0007gv-CC; Wed, 06 Dec 2023 10:12:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rAtZw-0007gl-AR
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 10:12:48 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rAtZt-0005Lf-By
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 10:12:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1701875566; x=1733411566;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=EW+3iSRgcCAkL+OgjpjJk/bJjtNRiBrER+/sUtol6gw=;
 b=HzENtGz3HkExcG15d8HCyLEjeArqDu2pJaHHLuzvZIXjoQ6G9v0tSz99
 /lURAgjeU4bSsI9otNJJqIpj7Uz34tg4nYlpRbjG9B6riCaS74rw2Id+k
 TjTSdbkyOK+TLGcBv1+yQYyoTKGgRa1mILER33R6Ta2ndtuJvHPNg9ObW
 hLZkd1HHQuIiIA8VmMtry6ogVYns6GjVjSTtg0mnLKaF4KTNbLvvKm0r0
 h1SqOdcOGtfCVH/xgduQEpHc2BC4UUaa2SuF1e64InKQlgK00S0CcuCKi
 Ue8lG6CNcOspahDQnMCmgzTAKznNWzBGyBvgi3dG/ulI8B8AN+/10HEow A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="1144037"
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; 
   d="scan'208";a="1144037"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Dec 2023 07:12:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="800377341"
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; d="scan'208";a="800377341"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orsmga008.jf.intel.com with ESMTP; 06 Dec 2023 07:12:31 -0800
Date: Wed, 6 Dec 2023 23:24:51 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Tao Su <tao1.su@linux.intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, imammedo@redhat.com,
 xiaoyao.li@intel.com
Subject: Re: [PATCH] target/i386: Add new CPU model SierraForest
Message-ID: <ZXCSQy6g5kEBu52z@intel.com>
References: <20231206131923.1192066-1-tao1.su@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206131923.1192066-1-tao1.su@linux.intel.com>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, Dec 06, 2023 at 09:19:23PM +0800, Tao Su wrote:
> Date: Wed,  6 Dec 2023 21:19:23 +0800
> From: Tao Su <tao1.su@linux.intel.com>
> Subject: [PATCH] target/i386: Add new CPU model SierraForest
> X-Mailer: git-send-email 2.34.1
> 
> SierraForest is Intel's first generation E-core based Xeon server
> processor, which will be released in the first half of 2024.
> 
> SierraForest mainly adds the following new features based on
> GraniteRapids:
> 
> - CMPCCXADD CPUID.(EAX=7,ECX=1):EAX[bit 7]
> - AVX-IFMA CPUID.(EAX=7,ECX=1):EAX[bit 23]
> - AVX-VNNI-INT8 CPUID.(EAX=7,ECX=1):EDX[bit 4]
> - AVX-NE-CONVERT CPUID.(EAX=7,ECX=1):EDX[bit 5]
> - LAM CPUID.(EAX=7,ECX=1):EAX[bit 26]
> - LASS CPUID.(EAX=7,ECX=1):EAX[bit 6]
> 
> and removes the following features based on GraniteRapids:
> 
> - HLE CPUID.(EAX=7,ECX=0):EBX[bit 4]
> - RTM CPUID.(EAX=7,ECX=0):EBX[bit 11]
> - AVX512F CPUID.(EAX=7,ECX=0):EBX[bit 16]
> - AVX512DQ CPUID.(EAX=7,ECX=0):EBX[bit 17]
> - AVX512_IFMA CPUID.(EAX=7,ECX=0):EBX[bit 21]
> - AVX512CD CPUID.(EAX=7,ECX=0):EBX[bit 28]
> - AVX512BW CPUID.(EAX=7,ECX=0):EBX[bit 30]
> - AVX512VL CPUID.(EAX=7,ECX=0):EBX[bit 31]
> - AVX512_VBMI CPUID.(EAX=7,ECX=0):ECX[bit 1]
> - AVX512_VBMI2 CPUID.(EAX=7,ECX=0):ECX[bit 6]
> - AVX512_VNNI CPUID.(EAX=7,ECX=0):ECX[bit 11]
> - AVX512_BITALG CPUID.(EAX=7,ECX=0):ECX[bit 12]
> - AVX512_VPOPCNTDQ CPUID.(EAX=7,ECX=0):ECX[bit 14]
> - LA57 CPUID.(EAX=7,ECX=0):ECX[bit 16]
> - TSXLDTRK CPUID.(EAX=7,ECX=0):EDX[bit 16]
> - AMX-BF16 CPUID.(EAX=7,ECX=0):EDX[bit 22]
> - AVX512_FP16 CPUID.(EAX=7,ECX=0):EDX[bit 23]
> - AMX-TILE CPUID.(EAX=7,ECX=0):EDX[bit 24]
> - AMX-INT8 CPUID.(EAX=7,ECX=0):EDX[bit 25]
> - AVX512_BF16 CPUID.(EAX=7,ECX=1):EAX[bit 5]
> - fast zero-length MOVSB CPUID.(EAX=7,ECX=1):EAX[bit 10]
> - fast short CMPSB, SCASB CPUID.(EAX=7,ECX=1):EAX[bit 12]
> - AMX-FP16 CPUID.(EAX=7,ECX=1):EAX[bit 21]
> - PREFETCHI CPUID.(EAX=7,ECX=1):EDX[bit 14]
> - XFD CPUID.(EAX=0xD,ECX=1):EAX[bit 4]
> - EPT_PAGE_WALK_LENGTH_5 VMX_EPT_VPID_CAP(0x48c)[bit 7]
> 
> SierraForest doesn't support TSX, so TSX Async Abort(TAA) vulnerabilities
> don't exist on SierraForest. On KVM side, if host doesn't enumerate RTM
> or RTM gets disabled, ARCH_CAP_TAA_NO is reported as unsupported. To
> avoid the confusing warning:
> warning: host doesn't support requested feature: MSR(10AH).taa-no
>          [bit 8]
> 
> just don't include TAA_NO in SierraForest CPU model.
> 
> Currently LAM and LASS are not enabled in KVM mainline yet,  will add
> them after merged.
> 
> Signed-off-by: Tao Su <tao1.su@linux.intel.com>
> ---

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


