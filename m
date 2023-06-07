Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A60272545A
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 08:34:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6mjp-0006Hn-GM; Wed, 07 Jun 2023 02:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1q6mjm-0006Hd-DB
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 02:33:42 -0400
Received: from mga12.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1q6mjh-0005YS-0x
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 02:33:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686119617; x=1717655617;
 h=message-id:date:mime-version:subject:from:to:cc:
 references:in-reply-to:content-transfer-encoding;
 bh=JElvffa7PGmlIMHWwvJ1GURu+z8IpHKRzcz6w4grVbM=;
 b=gWsdJG61YZpqG6AI+XNtQW45tnhbd1YDpe5As79jXYqYVvTu5qawcMBr
 w35lKAGOApkONPLurIK93vG9yaobFBG35r5zt6seeaxDaQGupvsS2RAIj
 iLpZqsdpdjTZNlwyBOWfYsW0ZsVbg6c2fmh4UjTNlMCAWa85JWkYYmC9a
 M3FU+NSUSGszkLurimrE4Hx+xak9mJ8rgAbqB8KutVcDDAhrO8P3Jg7m7
 zzwW2pG7+HKfc+PlxWGP2+HaRSGALMSeqXfi6kc96WLEbEvS71yfi0zq5
 I/AWgMKR0+qgxcyYwd4SEwe+SGr85rqlAHDbqQQi7XX78IbFwl6VHISsk Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="336525692"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; d="scan'208";a="336525692"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2023 23:33:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="712473415"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; d="scan'208";a="712473415"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.254.210.66])
 ([10.254.210.66])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2023 23:33:21 -0700
Message-ID: <5bdcedb8-4661-a176-7f5b-90130029c6b2@intel.com>
Date: Wed, 7 Jun 2023 14:33:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.2
Subject: Re: [PATCH 0/2] i386/cpuid: Minor fixes for CPUID leaf 1f setup
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20220712021249.3227256-1-xiaoyao.li@intel.com>
 <75afc4bd-75fc-78da-9c97-035f7f87d7c5@intel.com>
Content-Language: en-US
In-Reply-To: <75afc4bd-75fc-78da-9c97-035f7f87d7c5@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.136; envelope-from=xiaoyao.li@intel.com;
 helo=mga12.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, NICE_REPLY_A=-0.094,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 11/2/2022 8:49 AM, Xiaoyao Li wrote:
> On 7/12/2022 10:12 AM, Xiaoyao Li wrote:
>> The issue that fixed by Patch 1 looks fatal though it doesn't appear on
>> KVM because KVM always searches with assending order and hit with the
>> correct cpuid leaf 0.
>>
>> Patch 2 removes the wrong constraint on CPUID leaf 1f
> 
> Kindly ping.

ping it one more time.

Does it need a rebase and resend?

>> Xiaoyao Li (2):
>>    i386/cpuid: Decrease cpuid_i when skipping CPUID leaf 1F
>>    i386/cpuid: Remove subleaf constraint on CPUID leaf 1F
>>
>>   target/i386/kvm/kvm.c | 5 +----
>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>
> 
> 


