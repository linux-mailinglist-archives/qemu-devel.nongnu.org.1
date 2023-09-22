Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5047AA605
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 02:23:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjTwb-0000rE-Gf; Thu, 21 Sep 2023 20:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qjTwZ-0000r6-Tp
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 20:22:51 -0400
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qjTwY-0004sL-Ai
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 20:22:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695342170; x=1726878170;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ewiBLJ54nNGKRJj+GjF255twIywKxcnwQngXvj35lcQ=;
 b=N2JJPZiML78VOn3gl6xi9whwuMkvc9c9hySSBc9xHXqKQd4YxpucFKLL
 oDVb1VoTIc8lmcmQneRuC+rcsTWoelLdlRxhfj6fIAyhlCpXVx1a83Ffc
 VnwWmYWbhEsk5QnqmEQq3vgnuEdwsmzM10+GCJSIDeNsVNPIa7Rp0KXkl
 qTjCYIygf/NsgefFqneIsY+w7+8ASck8zHhs+PPN3rUGIN7AXIaswPHYV
 0c9UCbPIfvcJiZboo6DQiB2Wq5xUP0xVzjdrJf0ovG6Av7Ru8vgNe64WE
 IZx0WVGt8bfa1rkG/tXLnMYTOMAuXZvifvfJWtWyDDe7u8K4TD2cC72ll Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="360088297"
X-IronPort-AV: E=Sophos;i="6.03,166,1694761200"; d="scan'208";a="360088297"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2023 17:22:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="747341198"
X-IronPort-AV: E=Sophos;i="6.03,166,1694761200"; d="scan'208";a="747341198"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.11.250])
 ([10.93.11.250])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2023 17:22:42 -0700
Message-ID: <183684ec-8ee5-df22-ca5b-5ca3a0886ca1@intel.com>
Date: Fri, 22 Sep 2023 08:22:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v2 04/21] memory: Introduce memory_region_has_gmem_fd()
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
 <20230914035117.3285885-5-xiaoyao.li@intel.com>
 <f525d4da-0878-b4bc-f9cf-7b824abfef0a@redhat.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <f525d4da-0878-b4bc-f9cf-7b824abfef0a@redhat.com>
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

On 9/21/2023 4:46 PM, David Hildenbrand wrote:
> On 14.09.23 05:51, Xiaoyao Li wrote:
>> Introduce memory_region_has_gmem_fd() to query if the MemoryRegion has
>> KVM gmem fd allocated.
> 
> *probably* best to just squash that into patch #2.

Sure, I will do it.

