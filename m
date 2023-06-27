Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B9773F421
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 07:56:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE1ew-0008OI-Ql; Tue, 27 Jun 2023 01:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qE1eu-0008Nu-Et
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 01:54:36 -0400
Received: from mga17.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qE1es-0007Y9-GA
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 01:54:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687845274; x=1719381274;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=JSF71seKDeA9bs5dSy1qTmZB63n+TDG4sfcfVWxfYeg=;
 b=gWoaV4BlUCUq56BVfXXuBXv63+xqOOyMddhnv690/0Bn64pLjhMq28mW
 yOt4aWRqnu83zNXZUq0r/DvjHZJ7DH+G1ka7af7rpeBR8zlPzDUe1g927
 aBiGQa2HNFWT0DzFiH4kilGBuo8R7645bdJ63og9/GeH9EDNbhgpm6b2A
 y3lEed58Vd18OKfV610cFGQjdGN0GcHt+6SGUpi1+WvGJXmXvx1BE+wy+
 sJtwlGBICLc4L6hiMH1wgciCT5QUiaHavVv6f9gOzEyMzYhfwZSUa6tyR
 iZmG3q3sDku5Wa22SBVoerzvD54pqHiRMTvRxX8bvylAPvWNRmUwWkRoG Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="341823395"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; d="scan'208";a="341823395"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2023 22:54:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="666571631"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; d="scan'208";a="666571631"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.255.29.206])
 ([10.255.29.206])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2023 22:54:26 -0700
Message-ID: <c18ebbaf-0ea8-3cd5-9fb8-6e63add59fba@intel.com>
Date: Tue, 27 Jun 2023 13:54:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCH 6/7] target/i386: Add new CPU model EmeraldRapids
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>, Tao Su <tao1.su@linux.intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, lei4.wang@intel.com,
 qian.wen@intel.com
References: <20230616032311.19137-1-tao1.su@linux.intel.com>
 <20230616032311.19137-7-tao1.su@linux.intel.com>
 <20230626145610.64405831@imammedo.users.ipa.redhat.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20230626145610.64405831@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.55.52.151; envelope-from=xiaoyao.li@intel.com;
 helo=mga17.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/26/2023 8:56 PM, Igor Mammedov wrote:
> On Fri, 16 Jun 2023 11:23:10 +0800
> Tao Su<tao1.su@linux.intel.com>  wrote:
> 
>> From: Qian Wen<qian.wen@intel.com>
>>
>> Emerald Rapids (EMR) is the next generation of Xeon server processor
>> after Sapphire Rapids (SPR).
>>
>> Currently, regarding the feature set that can be exposed to guest, there
>> isn't any one new comparing with SPR cpu model, except that EMR has a
>> different model number.
>>
>> Though it's practicable to define EMR as an alias of a new version of
>> SPR by only updating the model number and model name, it loses the
>> flexibility when new version of EMR cpu model are needed for adding new
>> features (that hasn't virtalized/supported by KVM yet).
> Which begs a question, why do we need EMR model (or alias) at all
> if it's the same as SPR at the moment.
> 
> Make new features supported 1st and only then introduce a new CPU model.
> 

Even if no new feature (that can be virtualized and exposed to guest) in 
EMR compared to SPR in the end, I think it still makes sense to provide 
a dedicated EMR CPU model in QEMU. Because
1) User will know EMR, Intel's next generation of Xeon after SRP, is 
supported by QEMU, via -cpu ?/ -cpu help;
2) It's convenient for user to create an EMR VM. People may not care 
that much what the difference between "-cpu SapphireRapids" with "-cpu 
EmeraldRapids", while they do want to create an VM which shows the CPU 
is EmeraldRapids.


