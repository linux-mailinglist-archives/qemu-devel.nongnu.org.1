Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACAC77C72F
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 07:45:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVmr7-000880-Q4; Tue, 15 Aug 2023 01:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qVmqv-00087W-Uv
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 01:44:26 -0400
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qVmqt-0000pN-OO
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 01:44:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692078263; x=1723614263;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=QVyv+21BfhzBMFaQHtU/N/KfAsD7qNwSEhy4mRlMjQQ=;
 b=BF8eTGnJIlENS/s8rDaZ8jIT+i7rC7PD5GknL01hJ7L/xEPuU2A291pF
 TkW27l4FD03NSYFC7Jz9QkedE/dtRLzqaHXxf5k3ZfJEk3pCOMJ2er5Ln
 6n/ij0pdxlL96sMYcUqD6Q5fCCh7fU1hgKbAVoraAzLj1UtSJaCcfIBjy
 FYrwihJxDAi/tRNGN5iSJyhY4Gj5FOGwDTS5a8O8pQ5SKhrJdpdSKM1ld
 yaQQG4oLY9FMfAn3uJUwnBmbuCSXTZFpjb56k7UWnKZaBrHvJjDHhTm1n
 lXOvh7FXXMFpuQvOdsP+ti0DkpqqUSxy+37p4e3bG29yKGsYOmNr/TL/6 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="352532221"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; d="scan'208";a="352532221"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2023 22:44:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="823725277"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; d="scan'208";a="823725277"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.6.77])
 ([10.93.6.77])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2023 22:44:16 -0700
Message-ID: <89e97deb-65ca-e1a2-da53-7ae29f13ea26@intel.com>
Date: Tue, 15 Aug 2023 13:44:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v2] target/i386: Export GDS_NO bit to guests
Content-Language: en-US
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, tao1.su@linux.intel.com,
 Yu Zhang <yu.zhang@ionos.com>, Jinpu Wang <jinpu.wang@ionos.com>
References: <fde42d81ce454477ca8e27d5429a190b7366fe86.1692074650.git.pawan.kumar.gupta@linux.intel.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <fde42d81ce454477ca8e27d5429a190b7366fe86.1692074650.git.pawan.kumar.gupta@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.55.52.151; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -66
X-Spam_score: -6.7
X-Spam_bar: ------
X-Spam_report: (-6.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, NICE_REPLY_A=-2.265,
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

On 8/15/2023 12:54 PM, Pawan Gupta wrote:
> Gather Data Sampling (GDS) is a side-channel attack using Gather
> instructions. Some Intel processors will set ARCH_CAP_GDS_NO bit in
> MSR IA32_ARCH_CAPABILITIES to report that they are not vulnerable to
> GDS.
> 
> Make this bit available to guests.
> 
> Closes: https://lore.kernel.org/qemu-devel/CAMGffEmG6TNq0n3+4OJAgXc8J0OevY60KHZekXCBs3LoK9vehA@mail.gmail.com/
> Reported-by: Jack Wang <jinpu.wang@ionos.com>
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Tested-by: Jack Wang <jinpu.wang@ionos.com>
> Tested-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
> v2: Added commit tags
> 
> v1: https://lore.kernel.org/qemu-devel/c373f3f92b542b738f296d44bb6a916a1cded7bd.1691774049.git.pawan.kumar.gupta@linux.intel.com/
> 
>   target/i386/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 97ad229d8ba3..48709b77689f 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1155,7 +1155,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>               NULL, "sbdr-ssdp-no", "fbsdp-no", "psdp-no",
>               NULL, "fb-clear", NULL, NULL,
>               NULL, NULL, NULL, NULL,
> -            "pbrsb-no", NULL, NULL, NULL,
> +            "pbrsb-no", NULL, "gds-no", NULL,
>               NULL, NULL, NULL, NULL,
>           },
>           .msr = {


