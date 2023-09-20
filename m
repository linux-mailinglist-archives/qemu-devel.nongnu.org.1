Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDC67A86F3
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 16:37:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiyIq-0004Bn-NG; Wed, 20 Sep 2023 10:35:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qiyIo-0004BR-Eb
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 10:35:42 -0400
Received: from mgamail.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qiyIm-0001o4-6v
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 10:35:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695220540; x=1726756540;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=sH0b1baKbczKWombPJgtMInrODweXnPkKAuTu8OU4t0=;
 b=XLG9qMOl37BIGgGkIBm0ENpEn1P21F3J7CSNHP2xV9gDY/Ztn05aG1rZ
 5cSF9Eb59D9wO3GTLSGGM2LDcyC7BVkwHTY4Ct7zMaUrlyBxCm2JQOoOY
 6mgKSL9X0QwPbGDKq1TF1t/AYaJUKH/JsBnkR3ce1mciH2tjrcxm6vUre
 DPfzhFKEurag7C3lj64sRJEwMWr+bH+S4fcUV4Nng3uQK/UBwxKvjVLiM
 9cc/qmpFInZFks9o4vaBNq7St8zH9dQyX58UewPrR7f+cbLaM8AsDhI3O
 87SnC8h6gYn7AjGCyPwAytAPI7Jq1OLkrYZcsYDPZr5tVvn18ar+NdgDG A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="365292561"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; d="scan'208";a="365292561"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2023 07:35:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="696318566"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; d="scan'208";a="696318566"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.29.154])
 ([10.93.29.154])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2023 07:35:31 -0700
Message-ID: <da598ffc-fa47-3c25-64ea-27ea90d712aa@intel.com>
Date: Wed, 20 Sep 2023 22:35:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v2 03/21] HostMem: Add private property and associate
 it with RAM_KVM_GMEM
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand
 <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Michael Roth <michael.roth@amd.com>, isaku.yamahata@gmail.com,
 Sean Christopherson <seanjc@google.com>, Claudio Fontana <cfontana@suse.de>
References: <20230914035117.3285885-1-xiaoyao.li@intel.com>
 <20230914035117.3285885-4-xiaoyao.li@intel.com> <8734zazeag.fsf@pond.sub.org>
 <d0e7e2f8-581d-e708-5ddd-947f2fe9676a@intel.com>
 <878r91nvy4.fsf@pond.sub.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <878r91nvy4.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=xiaoyao.li@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, NICE_REPLY_A=-1.473,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/20/2023 3:30 PM, Markus Armbruster wrote:
> Xiaoyao Li <xiaoyao.li@intel.com> writes:
> 
>> On 9/19/2023 5:46 PM, Markus Armbruster wrote:
>>> Xiaoyao Li <xiaoyao.li@intel.com> writes:
>>>
>>>> From: Isaku Yamahata <isaku.yamahata@intel.com>
>>>>
>>>> Add a new property "private" to memory backends. When it's set to true,
>>>> it indicates the RAMblock of the backend also requires kvm gmem.
>>> Can you add a brief explanation why you need the property?
>>
>> It provides a mechanism for user to specify whether the memory can serve as private memory (need request kvm gmem).
> 
> Yes, but why would a user want such memory?
> 

Because KVM demands it for confidential guest, e.g., TDX guest. KVM 
demands that the mem slot needs to have KVM_MEM_PRIVATE set and has 
valid gmem associated if the guest accesses it as private memory.

