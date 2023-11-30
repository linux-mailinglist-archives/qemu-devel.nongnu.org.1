Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 367027FEA19
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 09:01:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8byH-0002Eb-Oo; Thu, 30 Nov 2023 03:00:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r8byD-0002EC-JH
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 03:00:27 -0500
Received: from mgamail.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r8by9-0002LU-Nn
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 03:00:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1701331221; x=1732867221;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=2LW8QB9G5Er4U++8LP/dgZik54QXLQXU6iDynduDJ3I=;
 b=S1lNEq2e36qV+pSUmf9+yFQLA93LlWe2QXWMMZ9mRIWVJtqdhrgalwaV
 SdyTiT2tZgSl2ilKeCLFQsOJI9eni3S9loWRsQrEyFGdSQcYm5wV9pwaq
 f/82eA0Ztr43X5fPNVgKDxLtP+sCP+1Xrr9unAgmNxKXCmHuTynGLtvNf
 5F2VSp6sqs7YVzg9K6LHSEqM4jPvF8MU4OcHbvM0RwOooGO5+91FgjAa8
 EUKTBtrMT7ruaOR+AoLN7UESu9+K1peWVGjynuWde7480sHOZSL+6oXe2
 KRGykn5saPwyEK98ppstFx9KlMFa9yC1rzu4qE8u+oeR4aZY1WNRLqa1u g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="424435195"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; d="scan'208";a="424435195"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Nov 2023 00:00:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="798198582"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; d="scan'208";a="798198582"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.29.154])
 ([10.93.29.154])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Nov 2023 00:00:11 -0800
Message-ID: <ff60b794-3002-4204-bb8f-fe8436f35c28@intel.com>
Date: Thu, 30 Nov 2023 16:00:08 +0800
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
Received-SPF: pass client-ip=192.55.52.88; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

A silly question. What file should the factored function be put in?

> And my comment regarding "flags = 0" to patch #2 does no longer apply :)
> 


