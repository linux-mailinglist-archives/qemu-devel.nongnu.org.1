Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E58C7ED9C8
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 03:54:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3SVn-000433-Bo; Wed, 15 Nov 2023 21:53:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r3SVk-00042t-G1
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 21:53:45 -0500
Received: from mgamail.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r3SVi-00051R-LI
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 21:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700103222; x=1731639222;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=7YQsp0BB0MmC5NMWVPrWH3O7XPeWtRCU9nNABC8pwXk=;
 b=n/zMjdCFJioxcJlQkmppv4R+FoCuzMcDfaGKou3c2KK7vh4gCnq6ct+U
 uKyIYBBfozxEd4uZG8u6IaR4oIFGYC8ba3J1PFrgpzRXB+3oHsvW8PPyp
 kcbgdonYA87pbQZYmggnJy+bHKnaQzZXrD/lrZKiLOT4+76tLSLp1Gi7B
 hlR4CCP7Du/qUzGUaiB05T/rxuWQ8V/hqQrExV3TVgvBBr1WIrUiecaE9
 +kF/WFAhK6sfrhUzGtdcDnG2qfVnVspDytxrNpeToEeOJtihbzWFkkBro
 iLuxUUqfrU//Tb3ceFJB3tc0dB3M+kqveKxk8JJPMZ188ECmtciJ4o6SI g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="422092966"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; d="scan'208";a="422092966"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2023 18:53:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="6603847"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.6.77])
 ([10.93.6.77])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2023 18:53:35 -0800
Message-ID: <6674dc2c-f1ed-496e-bc17-256869bdeae9@intel.com>
Date: Thu, 16 Nov 2023 10:53:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/70] HostMem: Add mechanism to opt in kvm guest memfd
 via MachineState
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Michael Roth <michael.roth@amd.com>, Sean Christopherson
 <seanjc@google.com>, Claudio Fontana <cfontana@suse.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Isaku Yamahata
 <isaku.yamahata@gmail.com>, Chenyi Qiang <chenyi.qiang@intel.com>
References: <20231115071519.2864957-1-xiaoyao.li@intel.com>
 <20231115071519.2864957-5-xiaoyao.li@intel.com>
 <af2a5b80-f259-45b1-9d92-812e3c4bc06c@redhat.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <af2a5b80-f259-45b1-9d92-812e3c4bc06c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.55.52.88; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 11/16/2023 2:14 AM, David Hildenbrand wrote:
> On 15.11.23 08:14, Xiaoyao Li wrote:
>> Add a new member "require_guest_memfd" to memory backends. When it's set
>> to true, it enables RAM_GUEST_MEMFD in ram_flags, thus private kvm
>> guest_memfd will be allocated during RAMBlock allocation.
>>
>> Memory backend's @require_guest_memfd is wired with @require_guest_memfd
>> field of MachineState. MachineState::require_guest_memfd is supposed to
>> be set by any VMs that requires KVM guest memfd as private memory, e.g.,
>> TDX VM.
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> 
> I'm confused, why do we need this if it's going to be the same for all 
> memory backends right now?
> 

I want to provide a elegant (in my sense) way to configure "the need of 
guest memfd" instead of checking x86machinestate->vm_type in physmem.c

