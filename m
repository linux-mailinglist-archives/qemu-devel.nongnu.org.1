Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA586802C95
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 09:00:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA3rl-0005Wq-Kf; Mon, 04 Dec 2023 02:59:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rA3rg-0005We-Rj
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 02:59:40 -0500
Received: from mgamail.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rA3re-0001B1-Qt
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 02:59:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1701676778; x=1733212778;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Csrf5U+K+c8wvUwhmYqLhxcScMdtlKgKl4nvBXVNsSk=;
 b=MDavvjM/9zth5dYeu4NUvOnYekk/MlOWophK8yPyhqDSqjJqu+C2VCcw
 yXfDHEgLpKwPx/ang8iTa7vV0EIbV2rfqtUC07qGYnK6M++k5zCviPlO6
 nS6naQgf3WS/2tu1bb3j9eniedVm0G9+WwIKqhhK1rnS6X32zIZLSxe2p
 mi+pzvFj1iUCpmdIb2YuiDX6JY6NMkrW0h1nar4U+II1KUe1n6TD3xED2
 p80TtYfq0QEOQTDM3yvFrK1SgoAvzd/2l/QMB3vgvLXkQUJ8WPhQE1Gk7
 FIHQFCJMSNAoS4N+84F4uwQRk9BEv8yyTqADCYnf0cc4do4OOcO9osnZD g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="384100614"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; d="scan'208";a="384100614"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Dec 2023 23:59:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; d="scan'208";a="17307334"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.29.154])
 ([10.93.29.154])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Dec 2023 23:59:29 -0800
Message-ID: <25b14f27-e970-46b3-a635-edc6f2926938@intel.com>
Date: Mon, 4 Dec 2023 15:59:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/70] i386: Introduce tdx-guest object
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand
 <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P=2EBerrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Michael Roth <michael.roth@amd.com>, Sean Christopherson
 <seanjc@google.com>, Claudio Fontana <cfontana@suse.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Isaku Yamahata
 <isaku.yamahata@gmail.com>, Chenyi Qiang <chenyi.qiang@intel.com>
References: <20231115071519.2864957-1-xiaoyao.li@intel.com>
 <20231115071519.2864957-14-xiaoyao.li@intel.com>
 <87ttp2w5xj.fsf@pond.sub.org>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <87ttp2w5xj.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=134.134.136.20; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On 12/1/2023 6:52 PM, Markus Armbruster wrote:
> Xiaoyao Li <xiaoyao.li@intel.com> writes:
> 
>> Introduce tdx-guest object which implements the interface of
>> CONFIDENTIAL_GUEST_SUPPORT, and will be used to create TDX VMs (TDs) by
>>
>>    qemu -machine ...,confidential-guest-support=tdx0	\
>>         -object tdx-guest,id=tdx0
>>
>> It has only one member 'attributes' with fixed value 0 and not
>> configurable so far.
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
>> Acked-by: Markus Armbruster <armbru@redhat.com>
> 
> [...]
> 
>> diff --git a/qapi/qom.json b/qapi/qom.json
>> index c53ef978ff7e..8e08257dac2f 100644
>> --- a/qapi/qom.json
>> +++ b/qapi/qom.json
>> @@ -878,6 +878,16 @@
>>               'reduced-phys-bits': 'uint32',
>>               '*kernel-hashes': 'bool' } }
>>   
>> +##
>> +# @TdxGuestProperties:
>> +#
>> +# Properties for tdx-guest objects.
>> +#
>> +# Since: 8.2
> 
> Going to be 9.0.

will update it and all others.

(I left it as 8.2 because I was not sure next version is 8.3 or 9.0)

>> +##
>> +{ 'struct': 'TdxGuestProperties',
>> +  'data': { }}
>> +
>>   ##
>>   # @ThreadContextProperties:
>>   #
>> @@ -956,6 +966,7 @@
>>       'sev-guest',
>>       'thread-context',
>>       's390-pv-guest',
>> +    'tdx-guest',
>>       'throttle-group',
>>       'tls-creds-anon',
>>       'tls-creds-psk',
>> @@ -1022,6 +1033,7 @@
>>         'secret_keyring':             { 'type': 'SecretKeyringProperties',
>>                                         'if': 'CONFIG_SECRET_KEYRING' },
>>         'sev-guest':                  'SevGuestProperties',
>> +      'tdx-guest':                  'TdxGuestProperties',
>>         'thread-context':             'ThreadContextProperties',
>>         'throttle-group':             'ThrottleGroupProperties',
>>         'tls-creds-anon':             'TlsCredsAnonProperties',
> 
> [...]
> 
> 


