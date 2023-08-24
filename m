Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C5F78690E
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 09:56:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ5C5-0000FX-UD; Thu, 24 Aug 2023 03:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qZ5C2-0000FC-2s
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 03:55:50 -0400
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qZ5Bx-000823-9i
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 03:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692863745; x=1724399745;
 h=message-id:date:mime-version:subject:from:to:cc:
 references:in-reply-to:content-transfer-encoding;
 bh=zfT/KhKzo3z/OH6/SXYYDpwCJ6frnf7e+NMK432cYQw=;
 b=BJkCuOLgFqs4d6c1Q4Go4xW8Afp7qgly76FnWzopArg6W8DeAbhSjw3a
 RpAiLK9vJ/We97Iua4QYFCMcZd3v0JVZA4ngsxikBEFgq2E1KB92Cg9SC
 8TvyJGNyZlSdNpAHCr/DjxbNzG8bl1HLTorodqZK3Hmrphp3Nj0IrS6lO
 1osbmsJF7TjkDtfXpuGtp/1S/Y5cyO9/fzjjlXoId7Q4rzsZ+puIpRo2M
 uA3x9bmGV8YUBCpd6Erw9lMAHwBbJkleqd1wMxKBVs+mJi2UjsMBEZqE1
 VMmRwgo6AZrnskudF7bT66sSTE9yfIK8fHd/yOV0/Pg9Qur+chDEYy+91 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="373255949"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; d="scan'208";a="373255949"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2023 00:55:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="740074273"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; d="scan'208";a="740074273"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.16.81])
 ([10.93.16.81])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2023 00:55:35 -0700
Message-ID: <bc2eba9a-7467-3a27-9d72-f7cc4745f338@intel.com>
Date: Thu, 24 Aug 2023 15:55:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v2 33/58] headers: Add definitions from UEFI spec for
 volumes, resources, etc...
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Isaku Yamahata <isaku.yamahata@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Eduardo Habkost <eduardo@habkost.net>, Laszlo Ersek <lersek@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>, erdemaktas@google.com,
 Chenyi Qiang <chenyi.qiang@intel.com>, isaku.yamahata@intel.com
References: <20230818095041.1973309-1-xiaoyao.li@intel.com>
 <20230818095041.1973309-34-xiaoyao.li@intel.com>
 <20230823194114.GE3642077@ls.amr.corp.intel.com>
 <48444107-d240-059b-a231-cddb085e4adf@intel.com>
In-Reply-To: <48444107-d240-059b-a231-cddb085e4adf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.55.52.120; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, NICE_REPLY_A=-2.684,
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

On 8/24/2023 3:50 PM, Xiaoyao Li wrote:
> On 8/24/2023 3:41 AM, Isaku Yamahata wrote:
>> On Fri, Aug 18, 2023 at 05:50:16AM -0400,
>> Xiaoyao Li <xiaoyao.li@intel.com> wrote:
>>
>>> Add UEFI definitions for literals, enums, structs, GUIDs, etc... that
>>> will be used by TDX to build the UEFI Hand-Off Block (HOB) that is 
>>> passed
>>> to the Trusted Domain Virtual Firmware (TDVF).
>>>
>>> All values come from the UEFI specification and TDVF design guide. [1]
>>>
>>> Note, EFI_RESOURCE_MEMORY_UNACCEPTED will be added in future UEFI spec.
>>>
>>> [1] 
>>> https://software.intel.com/content/dam/develop/external/us/en/documents/tdx-virtual-firmware-design-guide-rev-1.pdf
>>
>> Nitpick: The specs [1] [2] include unaccepted memory.
> 
> EfiUnacceptedMemoryType shows in UEFI spec while 
> EFI_RESOURCE_MEMORY_UNACCEPTED is still missing in PI spec.
> 
> https://github.com/tianocore/edk2/commit/00bbb1e584ec05547159f405cca383e8ba5e4ddb

Sorry, I just find it shows in latest PI spec.

https://uefi.org/sites/default/files/resources/UEFI_PI_Spec_1_8_March3.pdf

>> [1] UEFI Specification Version 2.10 (released August 2022)
>> [2] UEFI Platform Initialization Distribution Packaging Specification 
>> Version 1.1)
> 
> 


