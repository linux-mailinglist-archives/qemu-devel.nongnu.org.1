Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3728F7868E9
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 09:52:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ57A-0004tA-J4; Thu, 24 Aug 2023 03:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qZ56m-0004pz-9a
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 03:50:24 -0400
Received: from mgamail.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qZ56h-0006BK-UR
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 03:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692863419; x=1724399419;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=tCIikIPhcQYCsRzjrCmHh/ppXNZOuvNBYjiHui7HL80=;
 b=TUUBh8BGwwtOIqfVjvH3PgRYvmBnI3TDCR7widqeJnF4OoAiDae3be/T
 3ugU0+F9nPC4nAgz/Xw0VKeusjUIpOrKrmSOaNBNxOTyCGwuuUWBlGcx9
 LAeGR120q8UHXWZ8NooSLLf02VnqKf/4hhCQ1E05Z7y6vqNBcqbrEtCLt
 5EiATH/YueP6/kKYYxrjRqWL9OK02snNvaiJhTBze7QGfNNGga35W9c5k
 7x8owSPrAavPNXU5ZypwLzJaEGRJVhKbjSuHkDRQTK2jK9auo3qxKnmqy
 8Vp2rQ+lG0RR7oJxl+lQYZAbHVxVC4zVox44W2cUfLaVoRv14nqoY/+uJ Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="377100563"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; d="scan'208";a="377100563"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2023 00:50:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="736953081"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; d="scan'208";a="736953081"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.16.81])
 ([10.93.16.81])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2023 00:50:06 -0700
Message-ID: <48444107-d240-059b-a231-cddb085e4adf@intel.com>
Date: Thu, 24 Aug 2023 15:50:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v2 33/58] headers: Add definitions from UEFI spec for
 volumes, resources, etc...
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
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20230823194114.GE3642077@ls.amr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=134.134.136.24; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, NICE_REPLY_A=-2.684,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 8/24/2023 3:41 AM, Isaku Yamahata wrote:
> On Fri, Aug 18, 2023 at 05:50:16AM -0400,
> Xiaoyao Li <xiaoyao.li@intel.com> wrote:
> 
>> Add UEFI definitions for literals, enums, structs, GUIDs, etc... that
>> will be used by TDX to build the UEFI Hand-Off Block (HOB) that is passed
>> to the Trusted Domain Virtual Firmware (TDVF).
>>
>> All values come from the UEFI specification and TDVF design guide. [1]
>>
>> Note, EFI_RESOURCE_MEMORY_UNACCEPTED will be added in future UEFI spec.
>>
>> [1] https://software.intel.com/content/dam/develop/external/us/en/documents/tdx-virtual-firmware-design-guide-rev-1.pdf
> 
> Nitpick: The specs [1] [2] include unaccepted memory.

EfiUnacceptedMemoryType shows in UEFI spec while 
EFI_RESOURCE_MEMORY_UNACCEPTED is still missing in PI spec.

https://github.com/tianocore/edk2/commit/00bbb1e584ec05547159f405cca383e8ba5e4ddb

> [1] UEFI Specification Version 2.10 (released August 2022)
> [2] UEFI Platform Initialization Distribution Packaging Specification Version 1.1)


