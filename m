Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4169F82C302
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 16:47:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOJkC-0006a3-K3; Fri, 12 Jan 2024 10:46:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rOJk9-0006Zc-JF
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 10:46:49 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rOJk5-0006hF-Mu
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 10:46:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705074406; x=1736610406;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=cD+PXJHcYZEUhNxu6kIQMPQx1nPDJibcD/rAE6JP5G0=;
 b=CrtaRyyDTN/aftHzQazwLcDRukYsQW0Npl/F05LvpG8DBu12hjXKHIKa
 OZ4G32eTS4x8hH9YFnb5zAfZl4KPkASP6A7tMs9IowgcbBeHTt+0BGreW
 CEzrXwoxbGaeGHH2hNHlg+TVervaynrD09uf665hlrqm/lNDna+aWxE9o
 Dp5YJc1FhfTFM1SnymmZGL0Ko+sfQkFb8gfHRPUdaU3BsPIAxNwuim03I
 MWgbD4eMpLYF4BR2b0PEscLKmHUHyzH917wwJep+1OePrghlJiMtIjIXK
 kFBDrp8uLLnzFyeEO5MZ8hTCeStxZvdymyV/bMgG5Q+RNuMZmucKgMB3O Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="5929785"
X-IronPort-AV: E=Sophos;i="6.04,190,1695711600"; 
   d="scan'208";a="5929785"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jan 2024 07:46:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,190,1695711600"; d="scan'208";a="24736457"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.22.149])
 ([10.93.22.149])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jan 2024 07:46:31 -0800
Message-ID: <91919a5d-780c-4242-9485-7cc8c9329151@intel.com>
Date: Fri, 12 Jan 2024 23:46:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] target/i386: add control bits support for LAM
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, chao.gao@intel.com,
 robert.hu@linux.intel.com
References: <20230721080800.2329-1-binbin.wu@linux.intel.com>
 <20230721080800.2329-3-binbin.wu@linux.intel.com>
 <634d2f1e-f7b0-491d-979e-99609b79a955@intel.com>
 <a6505d3b-5850-45ac-9439-14b6fd9b8138@linux.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <a6505d3b-5850-45ac-9439-14b6fd9b8138@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.09,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.998, HK_RANDOM_FROM=0.999, SPF_HELO_NONE=0.001,
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

On 1/3/2024 5:25 PM, Binbin Wu wrote:
> 
> 
> On 12/28/2023 4:51 PM, Xiaoyao Li wrote:
>> On 7/21/2023 4:08 PM, Binbin Wu wrote:
>>> LAM uses CR3[61] and CR3[62] to configure/enable LAM on user pointers.
>>> LAM uses CR4[28] to configure/enable LAM on supervisor pointers.
>>>
>>> For CR3 LAM bits, no additional handling needed:
>>> - TCG
>>>    LAM is not supported for TCG of target-i386. helper_write_crN() 
>>> and helper_vmrun()
>>>    check max physical address bits before calling 
>>> cpu_x86_update_cr3(), no change needed,
>>>    i.e. CR3 LAM bits are not allowed to be set in TCG.
>>> - gdbstub
>>>    x86_cpu_gdb_write_register() will call cpu_x86_update_cr3() to 
>>> update cr3. Allow gdb
>>>    to set the LAM bit(s) to CR3, if vcpu doesn't support LAM, 
>>> KVM_SET_SREGS will fail as
>>>    other CR3 reserved bits.
>>>
>>> For CR4 LAM bit, its reservation depends on vcpu supporting LAM 
>>> feature or not.
>>> - TCG
>>>    LAM is not supported for TCG of target-i386. helper_write_crN() 
>>> and helper_vmrun()
>>>    check CR4 reserved bit before calling cpu_x86_update_cr4(), i.e. 
>>> CR4 LAM bit is not
>>>    allowed to be set in TCG.
>>> - gdbstub
>>>    x86_cpu_gdb_write_register() will call cpu_x86_update_cr4() to 
>>> update cr4. Allow gdb
>>>    to set the LAM bit to CR4, if vcpu doesn't support LAM, 
>>> KVM_SET_SREGS will fail.
>>
>> I would go follow the current code, to mask out LAM bit if no CPUID.
> 
> I can do it in the next version.
> 
> But I am curious what's the rule of masking out a CR4 bit if no CPUID
> in cpu_x86_update_cr4()?
> e.g. current code checks SMAP but not SMEP.
> 

Frankly, I don't know. As you explained in commit message, missing the 
check doesn't cause any functional issue because the function is only 
called for tcg code and LAM is not enabled for tcg.

But personally, I think adding the check does no harm and the logic is 
straightforward, while not adding the check looks not intuitive and begs 
a comment to explain.

So my preference is to add the check.


