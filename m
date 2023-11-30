Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 688BF7FE9C2
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 08:33:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8bX8-0003qd-Oz; Thu, 30 Nov 2023 02:32:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r8bX6-0003qT-G9
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 02:32:24 -0500
Received: from mgamail.intel.com ([192.55.52.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r8bX4-0004Ti-Gm
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 02:32:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1701329542; x=1732865542;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=MhyNAN59jGiFlQny5EFhPJfUBE5/214AnRgM0gfUD0o=;
 b=fbOEDjAntV2dUFI3ShbkYJnVefPOfqkotPioF/dYXvPrM6M9zTKGiRaF
 CzlYQTwarZTO3C8Nbu7jrYLAX2yzezv/R/MyIzeyhRQtyp9BWDlscApA3
 nFJqDXV1KA7cT9IMFRrvoX8Q12SUOrpuFB6AmAo6QETyxOaeyL7up1Wyn
 Pwvq8hzggGSnZk+KJfyTR7UX1mMX9IPvYaQnL5yU9r9yFcfMEtXspjHAI
 dENrZS92lWmTuYAXLWKSMb59rC3zEI9n4xgfejB9AC3QmuokOOHSnNdNR
 SPzI38gboeYhWaHCyb0IzyKAEp8nxsvDUKnKLfSbSOUMH/b4BAZTw55iY Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="479484335"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; d="scan'208";a="479484335"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2023 23:32:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="769202097"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; d="scan'208";a="769202097"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.29.154])
 ([10.93.29.154])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2023 23:32:10 -0800
Message-ID: <4708c33a-bb8d-484e-ac7b-b7e8d3ed445a@intel.com>
Date: Thu, 30 Nov 2023 15:32:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/70] RAMBlock/guest_memfd: Enable
 KVM_GUEST_MEMFD_ALLOW_HUGEPAGE
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
 <20231115071519.2864957-4-xiaoyao.li@intel.com>
 <bc84fa4f-4866-4321-8f30-1388eed7e64f@redhat.com>
 <05f0e440-36a2-4d3a-8caa-842b34e50dce@intel.com>
 <0fbfc413-7c74-4b2a-bade-6f3f04ca82c2@redhat.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <0fbfc413-7c74-4b2a-bade-6f3f04ca82c2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.55.52.43; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11/20/2023 5:26 PM, David Hildenbrand wrote:
> 
>>> ... did you shamelessly copy that from hw/virtio/virtio-mem.c ? ;)
>>
>> Get caught.
>>
>>> This should be factored out into a common helper.
>>
>> Sure, will do it in next version.
> 
> Factor it out in a separate patch. Then, this patch is get small that 
> you can just squash it into #2.
> 
> And my comment regarding "flags = 0" to patch #2 does no longer apply :)
> 

I see.

But it depends on if KVM_GUEST_MEMFD_ALLOW_HUGEPAGE will appear together 
with initial guest memfd in linux (hopefully 6.8)
https://lore.kernel.org/all/CABgObfa=DH7FySBviF63OS9sVog_wt-AqYgtUAGKqnY5Bizivw@mail.gmail.com/

If like Paolo committed, no KVM_GUEST_MEMFD_ALLOW_HUGEPAGE in initial 
merge, I will go simplify Patch #2. Otherwise factor out a common 
function to get hugepage size as you suggested.

Thanks!

