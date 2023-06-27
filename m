Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E4D73FB16
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 13:26:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE6pK-0000lg-2W; Tue, 27 Jun 2023 07:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qE6p9-0000fi-6O
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 07:25:31 -0400
Received: from mga17.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qE6p6-0007Kh-Ay
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 07:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687865128; x=1719401128;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=o2+qqEZJX5icorGzwbPOm6KPIFNqqxM/0DuYaY2VOow=;
 b=BIZFyHHwZ4nrEJjSrgIBwfRtkvLpALEEwCMLtDMxGNGes16IB53at4Iz
 vMtv94PwTHEtIDWDNjxXlv3TtvYzDc6DXIXCEDjwNgfe/e+8sjZxHp+cZ
 IwbLR2WKtyD0g1A2C1S3rjb4/5USUiwDQqrip4XIdeyi8QBJMKBDRaIPh
 wuMNhhwEgS5QFYc7DyARxenWQq//74Sg03vgBmNLT4VQu5dzZjfkjh+sz
 v5UzUcSxasgk/KqwT88iJHb50BXh5lW6iFGsT2pNJ9Iqt+ncscR1FiRQ9
 QJRVkhG0nl0Www/HoTUIBOpcpvrEgw0shaWkBg+/c2yDnuwKkj49F6A4v w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="341886103"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; d="scan'208";a="341886103"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2023 04:25:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="746156635"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; d="scan'208";a="746156635"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.255.29.206])
 ([10.255.29.206])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2023 04:25:23 -0700
Message-ID: <cdbf2132-ef13-1f36-2845-2783bb515309@intel.com>
Date: Tue, 27 Jun 2023 19:25:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCH 6/7] target/i386: Add new CPU model EmeraldRapids
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>
Cc: Tao Su <tao1.su@linux.intel.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, lei4.wang@intel.com, qian.wen@intel.com
References: <20230616032311.19137-1-tao1.su@linux.intel.com>
 <20230616032311.19137-7-tao1.su@linux.intel.com>
 <20230626145610.64405831@imammedo.users.ipa.redhat.com>
 <c18ebbaf-0ea8-3cd5-9fb8-6e63add59fba@intel.com>
 <20230627104918.1a2152c6@imammedo.users.ipa.redhat.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20230627104918.1a2152c6@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.151; envelope-from=xiaoyao.li@intel.com;
 helo=mga17.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, NICE_REPLY_A=-0.103,
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

On 6/27/2023 4:49 PM, Igor Mammedov wrote:
> On Tue, 27 Jun 2023 13:54:23 +0800
> Xiaoyao Li <xiaoyao.li@intel.com> wrote:
> 
>> On 6/26/2023 8:56 PM, Igor Mammedov wrote:
>>> On Fri, 16 Jun 2023 11:23:10 +0800
>>> Tao Su<tao1.su@linux.intel.com>  wrote:
>>>    
>>>> From: Qian Wen<qian.wen@intel.com>
>>>>
>>>> Emerald Rapids (EMR) is the next generation of Xeon server processor
>>>> after Sapphire Rapids (SPR).
>>>>
>>>> Currently, regarding the feature set that can be exposed to guest, there
>>>> isn't any one new comparing with SPR cpu model, except that EMR has a
>>>> different model number.
>>>>
>>>> Though it's practicable to define EMR as an alias of a new version of
>>>> SPR by only updating the model number and model name, it loses the
>>>> flexibility when new version of EMR cpu model are needed for adding new
>>>> features (that hasn't virtalized/supported by KVM yet).
>>> Which begs a question, why do we need EMR model (or alias) at all
>>> if it's the same as SPR at the moment.
>>>
>>> Make new features supported 1st and only then introduce a new CPU model.
>>>    
>>
>> Even if no new feature (that can be virtualized and exposed to guest) in
>> EMR compared to SPR in the end, I think it still makes sense to provide
>> a dedicated EMR CPU model in QEMU. Because
>> 1) User will know EMR, Intel's next generation of Xeon after SRP, is
>> supported by QEMU, via -cpu ?/ -cpu help;
> 
> I don't see any benefits in misleading user by showing EMR model which is
> nothing else but SPR one.
> On negative side you would increase maintenance burden by introducing
> extra versions of CPU model later. Which by itself is abusing versioning,
> mainly used for fixing CPU bugs, by using it for adding new features.
> 
>> 2) It's convenient for user to create an EMR VM. People may not care
>> that much what the difference between "-cpu SapphireRapids" with "-cpu
>> EmeraldRapids", while they do want to create an VM which shows the CPU
>> is EmeraldRapids.
>>
> My guess would be is that you need guest to show EMR for developing EMR
> features/guest bringup, in that case do it in your fork, and once
> support is actually ready publish completed patches for it.

No. I meant for CSPs who want to provide an EMR virtual machine to their 
customers, or lab admin provides an EMR (virtual) machine to its user.

Without a dedicated EmeraldRapids cpu model provided by QEMU, they need 
to use something like

   -cpu SapphireRapids,model=207,model-id="Intel Xeon Processor 
(EmeraldRapids)"

It's likely that no difference in supported features between SPR cpu 
model and EMR cpu model in the end. If so, will QEMU choose to provide a 
dedicated CPU model for EMR? or just document somewhere to QEMU users 
that "if you want to create an virtual machine with EMR cpu model, 
please go with SPR cpu model while changing it's model number to EMR's 
207 and changing model-id to tell EmeraldRapids" ?

> To exaggerate you reasoning further, we should create CPU models for
> all future planned Intel/AMD CPU as a one of currently existing in
> QEMU right now and then sometime in future implement features that
> actually make those models what they should be.

No, it's not the purpose. In fact, we're not adding an temporary EMR cpu 
model while planing to complement it in the future. Instead, we are 
adding an official EMR cpu model. The fact is, in terms of the features 
that are virtualizable and can be exposed to guest, there is no 
difference between SPR and EMR.

This comes to a basic question：Will QEMU provide a EMR cpu model even if 
no difference to SPR cpu model except the model number?

> It's downright confusing for user, so I'd object to this approach.
> 


