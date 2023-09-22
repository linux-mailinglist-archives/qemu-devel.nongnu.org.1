Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA517AA607
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 02:23:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjTwI-0000pz-Ts; Thu, 21 Sep 2023 20:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qjTwH-0000pr-1U
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 20:22:33 -0400
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qjTwD-0004qx-To
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 20:22:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695342149; x=1726878149;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=FogeaomQX2VVcu9AEHsQgloDflBQsHSa+RD1u+C6qTc=;
 b=T2A0q2RQMG+jkjFAVqQKuO/V2sQXIA8wApOg/oQpXPPy/owmlpPZ8S7Q
 Qi+/8spqyTasA/vbQ3ixr4wjgFgRp3wDT/2aICu62UMyjoW0wnBFFiddt
 B+hewXIT5lgA+p6vW5cPqhL2el/xKGKo6ShgGjRkaqv2C5A+YMIQJkVuP
 gW/XFjUWpyLpA98Omv006bFAZ5hzpViRq48a1O4dSrYOm/VIcOiSrDOQ6
 s+IxAomztu5oej+2iz7rWgeo5dnIIyxArZ5Lw+VxdxVr5jpYBfjC9ecXi
 6AAMWjZl2MkG3Ocu4wiBouSH6fZ0I7jzf/qq3iBsTdkr2gGVuH/hqcw+7 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="360088259"
X-IronPort-AV: E=Sophos;i="6.03,166,1694761200"; d="scan'208";a="360088259"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2023 17:22:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="747341164"
X-IronPort-AV: E=Sophos;i="6.03,166,1694761200"; d="scan'208";a="747341164"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.11.250])
 ([10.93.11.250])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2023 17:22:20 -0700
Message-ID: <6eeb5568-2faa-85c3-8f42-ed6317ea376c@intel.com>
Date: Fri, 22 Sep 2023 08:22:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v2 02/21] RAMBlock: Add support of KVM private gmem
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Michael Roth <michael.roth@amd.com>, isaku.yamahata@gmail.com,
 Sean Christopherson <seanjc@google.com>, Claudio Fontana <cfontana@suse.de>
References: <20230914035117.3285885-1-xiaoyao.li@intel.com>
 <20230914035117.3285885-3-xiaoyao.li@intel.com>
 <678bf0bf-57e7-a596-1ddf-6d0b47cd8677@redhat.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <678bf0bf-57e7-a596-1ddf-6d0b47cd8677@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.55.52.136; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, NICE_REPLY_A=-1.473,
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

On 9/21/2023 4:55 PM, David Hildenbrand wrote:
> On 14.09.23 05:50, Xiaoyao Li wrote:
>> From: Chao Peng <chao.p.peng@linux.intel.com>
>>
>> Add KVM gmem support to RAMBlock so both normal hva based memory
>> and kvm gmem fd based private memory can be associated in one RAMBlock.
>>
>> Introduce new flag RAM_KVM_GMEM. It calls KVM ioctl to create private
>> gmem for the RAMBlock when it's set.
> 
> 
> But who sets RAM_KVM_GMEM and when? 

The answer is in the next patch. When `private` property of memory 
backend is set to true, it will pass RAM_KVM_GMEM flag to 
memory_region_init_ram_*()

> Don't we simply allocate it for all 
> RAMBlocks under such special VMs? 

yes, this is the direction after your comments.

I'll try to figure out how to achieve it.

> What's the downside of doing that?

As far as I see, for TDX, no downside.


