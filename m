Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E03F7A1489
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 05:47:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgzlw-0002Wd-PC; Thu, 14 Sep 2023 23:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qgzlq-0002Ux-IW
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 23:45:34 -0400
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qgzlm-0005Lt-QB
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 23:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1694749526; x=1726285526;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Y5O8yBf2hm2V5a0KPQnIgJP46w9iulxKXoLXHLGRFlM=;
 b=RubEw65Rfyoifm86SJsGDOYOeD9rJIyUhBLmt4kSyVq/Hj3b6OgdrdYc
 n68Kf/ItFJkwgUioT85nOAK4ROs8Us+8PKIaib/Z6CIqVhgLCXbrtIPtT
 SU5KPLB202UEEGbW/4edonsGlErl9bw6lEtUpSShvB1Mdd5MM+QO6sEsL
 KkxlWi5VpyXGeeCEj6uW7tAu9YgpEhKfoIr4Inub/S66RS9ON/JtcT7tO
 l501OXmlG1Mybu1nKW+LDnBDN3q+MfiKt5z6N8V03a7+tZuCsYN22MCPx
 bfpkaHuVEgSUVVT91ciMdyGAiJyOdQy8RKMxOSo2yIuAlabp2wQOWIImB w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="379067619"
X-IronPort-AV: E=Sophos;i="6.02,147,1688454000"; d="scan'208";a="379067619"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2023 20:45:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="815026475"
X-IronPort-AV: E=Sophos;i="6.02,147,1688454000"; d="scan'208";a="815026475"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.29.154])
 ([10.93.29.154])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2023 20:45:16 -0700
Message-ID: <a47ca6f9-6c2f-8212-151c-44f5ec117dbf@intel.com>
Date: Fri, 15 Sep 2023 11:45:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v2 02/21] RAMBlock: Add support of KVM private gmem
Content-Language: en-US
To: "Wang, Lei" <lei4.wang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
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
 <bd1eca88-98f4-718f-4d40-c2ea40f65d95@intel.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <bd1eca88-98f4-718f-4d40-c2ea40f65d95@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.55.52.115; envelope-from=xiaoyao.li@intel.com;
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

On 9/15/2023 10:04 AM, Wang, Lei wrote:
> On 9/14/2023 11:50, Xiaoyao Li wrote:
>> From: Chao Peng<chao.p.peng@linux.intel.com>
>>
>> Add KVM gmem support to RAMBlock so both normal hva based memory
>> and kvm gmem fd based private memory can be associated in one RAMBlock.
>>
>> Introduce new flag RAM_KVM_GMEM. It calls KVM ioctl to create private
>> gmem for the RAMBlock when it's set.
>>
>> Signed-off-by: Xiaoyao Li<xiaoyao.li@intel.com>
> Kindly reminding the author's Signed-off-by is missing.

I will fix it.
Thanks!



