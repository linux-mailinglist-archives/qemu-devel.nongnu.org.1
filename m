Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4672D80820D
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 08:40:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rB8yA-0003sh-97; Thu, 07 Dec 2023 02:38:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rB8y8-0003sX-Oo
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 02:38:48 -0500
Received: from mgamail.intel.com ([192.55.52.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rB8y6-0004dP-52
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 02:38:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1701934726; x=1733470726;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=BXBFcsZwYwTDGcbTnD2OQCUETr2fkYGend2keFm5JYo=;
 b=btCBlC+LlmAUqGmORgXaPrq4oL5G3MV64zmoyCvNk5RMZckaVdBj4jQD
 gzxauBTptgPtpmPz5Q2H1o8BDjm+GeJ/9kJx4BP9nJ3capd4OdQabPHIR
 8lsq8UdrdZUJBQRkJXH6BWNjGXeUpPH+Y+YlalG3Bx6KYxF/ZhcRhCjfd
 57naBLCqJlM9pQOtVOwmJWHeUsMGE7Lm6thVO35Bn4LkJNZkMnWBaXAME
 kqP3LTmg5yUPmkVusra7HSag0P7jDsd+C0QhvNLcqOxAV6h27nVB3vdG+
 aSRJr9ilXtz9rdt6k9bqfHWORgL5bIlAAAAmETjzptizGDVwhg47fEQgz Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="480381951"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; d="scan'208";a="480381951"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Dec 2023 23:38:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="895048144"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; d="scan'208";a="895048144"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.29.154])
 ([10.93.29.154])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Dec 2023 23:38:33 -0800
Message-ID: <a838be54-89cc-485b-897c-d069fc887d3d@intel.com>
Date: Thu, 7 Dec 2023 15:38:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 52/70] i386/tdx: handle TDG.VP.VMCALL<GetQuote>
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
 <20231115071519.2864957-53-xiaoyao.li@intel.com>
 <87jzpyw5hp.fsf@pond.sub.org>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <87jzpyw5hp.fsf@pond.sub.org>
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

On 12/1/2023 7:02 PM, Markus Armbruster wrote:
> Xiaoyao Li <xiaoyao.li@intel.com> writes:
> 
>> From: Isaku Yamahata <isaku.yamahata@intel.com>
>>
>> For GetQuote, delegate a request to Quote Generation Service.
>> Add property "quote-generation-socket" to tdx-guest, whihc is a property
>> of type SocketAddress to specify Quote Generation Service(QGS).
>>
>> On request, connect to the QGS, read request buffer from shared guest
>> memory, send the request buffer to the server and store the response
>> into shared guest memory and notify TD guest by interrupt.
>>
>> command line example:
>>    qemu-system-x86_64 \
>>      -object '{"qom-type":"tdx-guest","id":"tdx0","quote-generation-socket":{"type": "vsock", "cid":"2","port":"1234"}}' \
>>      -machine confidential-guest-support=tdx0
>>
>> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
>> Codeveloped-by: Chenyi Qiang <chenyi.qiang@intel.com>
>> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>> Changes in v3:
>> - rename property "quote-generation-service" to "quote-generation-socket";
>> - change the type of "quote-generation-socket" from str to
>>    SocketAddress;
>> - squash next patch into this one;
>> ---
>>   qapi/qom.json         |   5 +-
>>   target/i386/kvm/tdx.c | 430 ++++++++++++++++++++++++++++++++++++++++++
>>   target/i386/kvm/tdx.h |   6 +
>>   3 files changed, 440 insertions(+), 1 deletion(-)
>>
>> diff --git a/qapi/qom.json b/qapi/qom.json
>> index fd99aa1ff8cc..cf36a1832ddd 100644
>> --- a/qapi/qom.json
>> +++ b/qapi/qom.json
>> @@ -894,13 +894,16 @@
>>   #
>>   # @mrownerconfig: base64 MROWNERCONFIG SHA384 digest
>>   #
>> +# @quote-generation-socket: socket address for Quote Generation Service(QGS)
>> +#
> 
> Long line.  Better:
> 
>     # @quote-generation-socket: socket address for Quote Generation
>     #     Service(QGS)

May I ask what's the limitation for qom.json? if 80 columns limitation 
doesn't apply to it.

>>   # Since: 8.2
>>   ##
>>   { 'struct': 'TdxGuestProperties',
>>     'data': { '*sept-ve-disable': 'bool',
>>               '*mrconfigid': 'str',
>>               '*mrowner': 'str',
>> -            '*mrownerconfig': 'str' } }
>> +            '*mrownerconfig': 'str',
>> +            '*quote-generation-socket': 'SocketAddress' } }
>>   
>>   ##
>>   # @ThreadContextProperties:
> 


