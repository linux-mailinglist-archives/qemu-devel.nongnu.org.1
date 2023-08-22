Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5726783BF0
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 10:40:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYMvy-0003Wg-4r; Tue, 22 Aug 2023 04:40:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qYMvv-0003WK-O1
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 04:40:15 -0400
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qYMvr-0006NB-2q
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 04:40:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692693611; x=1724229611;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ltuVfD5B/jcuWstVoucBhzIjKV7eNN6MJ29Zqp3U/m8=;
 b=Zn32xdjfuC4jAxpAg87j79apGDStyZtPiQ39FU6eBHI3Npv1FO/0xW6l
 8xHFFtaqBTuQtRvrilOjDFQKk9x487BlpOi9lJl9i7a0S3qfeKQ59BJi0
 IaWzKocZdSzyu6zmJGGcLiyLBKKmrRelHFpifnLnD6uLlkJcmhc8O5tmY
 uYcm39D/WWWrk4PhwOy/y6xHieX9YYsz1Lh8LKXiOAKKqNEB9K3hnG+ZB
 7itV3r/akqWeuJY0G+5WguYeIZ5R6f3UbYrBswvGDpolSe6d5YSF/3Wqe
 N7tWie5E9GrQr2h40Avx34ZLQUnKZmPauoaATY2Hcw/TsaznRAuSZE/DO Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="354157023"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; d="scan'208";a="354157023"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Aug 2023 01:40:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="826246817"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; d="scan'208";a="826246817"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.6.77])
 ([10.93.6.77])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Aug 2023 01:40:00 -0700
Message-ID: <8a44f4fc-edd7-c547-c451-917a964027d5@intel.com>
Date: Tue, 22 Aug 2023 16:39:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v2 15/58] i386/tdx: Add property sept-ve-disable for
 tdx-guest object
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Eduardo Habkost <eduardo@habkost.net>, Laszlo Ersek <lersek@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>, erdemaktas@google.com,
 Chenyi Qiang <chenyi.qiang@intel.com>
References: <20230818095041.1973309-1-xiaoyao.li@intel.com>
 <20230818095041.1973309-16-xiaoyao.li@intel.com>
 <ZOMnf8n8BksktlGg@redhat.com> <877cpn7ft7.fsf@pond.sub.org>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <877cpn7ft7.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.151; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -77
X-Spam_score: -7.8
X-Spam_bar: -------
X-Spam_report: (-7.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, NICE_REPLY_A=-3.374,
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

On 8/22/2023 2:27 PM, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
>> On Fri, Aug 18, 2023 at 05:49:58AM -0400, Xiaoyao Li wrote:
>>> Bit 28 of TD attribute, named SEPT_VE_DISABLE. When set to 1, it disables
>>> EPT violation conversion to #VE on guest TD access of PENDING pages.
>>>
>>> Some guest OS (e.g., Linux TD guest) may require this bit as 1.
>>> Otherwise refuse to boot.
>>>
>>> Add sept-ve-disable property for tdx-guest object, for user to configure
>>> this bit.
>>>
>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
>>> ---
>>>   qapi/qom.json         |  4 +++-
>>>   target/i386/kvm/tdx.c | 24 ++++++++++++++++++++++++
>>>   2 files changed, 27 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/qapi/qom.json b/qapi/qom.json
>>> index 2ca7ce7c0da5..cc08b9a98df9 100644
>>> --- a/qapi/qom.json
>>> +++ b/qapi/qom.json
>>> @@ -871,10 +871,12 @@
>>>   #
>>>   # Properties for tdx-guest objects.
>>>   #
>>> +# @sept-ve-disable: bit 28 of TD attributes (default: 0)
>>
>> This description isn't very useful as it forces the user to go off and
>> read the TDX specification to find out what bit 28 means. You've got a
> 
> Seconded.
> 
>> more useful description in the commit message, so please use that
>> in the docs too. eg something like this
>>
>>    @sept-ve-disable: toggle bit 28 of TD attributes to control disabling
>>                      of EPT violation conversion to #VE on guest
>>                      TD access of PENDING pages. Some guest OS (e.g.
>>                      Linux TD guest) may require this set, otherwise
>>                      they refuse to boot.
> 
> But please format like
> 
> # @sept-ve-disable: toggle bit 28 of TD attributes to control disabling
> #     of EPT violation conversion to #VE on guest TD access of PENDING
> #     pages.  Some guest OS (e.g. Linux TD guest) may require this to
> #     be set, otherwise they refuse to boot.
>

Thank you, Daniel and Markus.

Will use above in the next version.

> to blend in with recent commit a937b6aa739 (qapi: Reformat doc comments
> to conform to current conventions).
>
>>> +#
>>>   # Since: 8.2
>>>   ##
>>>   { 'struct': 'TdxGuestProperties',
>>> -  'data': { }}
>>> +  'data': { '*sept-ve-disable': 'bool' } }
>>>   
>>>   ##
>>>   # @ThreadContextProperties:
> 
> [...]
> 


