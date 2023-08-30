Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D4478D318
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 07:59:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbEDi-0000TD-UQ; Wed, 30 Aug 2023 01:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qbEDa-0000Sz-IC
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 01:58:19 -0400
Received: from mgamail.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qbEDT-00070z-6m
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 01:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1693375091; x=1724911091;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=uGapUU3kSnpsOGxYFMOgS4w9P+K676dTDGC/iRu+fgI=;
 b=MCeBLy2tFJd3uYxcrUedKVUvzodeDDMRtQvy3QRYT++XSAzpnmMKEMl+
 axclzuhl+48LMtWIa69lLw/c5TMsxksCdMiznVNDmItx6oZVhsThK3Y6N
 M7SsD39MzsKwiRMzNNm9iyRJ4SH787l4srCRv5l9kACo1doCIUJ2MWam6
 +2IJLPgFQJYmxW9TCouSb78hJ3mNUp1kN81yOT/Po2X2ZXE22j5mxYSBs
 n/TBqBLJQyZatfplpF4gnNJhjG73q/PGzfu4dapbdtmgWCzMPNBvQTELH
 D84T2aApljAGpMOmk1BQgLUbDBjknUxdIIwv6dmxV6cj98SyPjB7FVIO5 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="441917882"
X-IronPort-AV: E=Sophos;i="6.02,212,1688454000"; d="scan'208";a="441917882"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Aug 2023 22:58:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="768311757"
X-IronPort-AV: E=Sophos;i="6.02,212,1688454000"; d="scan'208";a="768311757"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.16.81])
 ([10.93.16.81])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Aug 2023 22:58:02 -0700
Message-ID: <11130e51-72fe-a07a-767b-f768611cf0d9@intel.com>
Date: Wed, 30 Aug 2023 13:57:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v2 41/58] i386/tdx: handle TDG.VP.VMCALL<GetQuote>
Content-Language: en-US
To: Chenyi Qiang <chenyi.qiang@intel.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Eduardo Habkost <eduardo@habkost.net>, Laszlo Ersek <lersek@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>, erdemaktas@google.com
References: <20230818095041.1973309-1-xiaoyao.li@intel.com>
 <20230818095041.1973309-42-xiaoyao.li@intel.com>
 <87wmxn6029.fsf@pond.sub.org> <ZORws2GWRwIGAaJE@redhat.com>
 <d6fbacab-d7e4-9992-438d-a8cb58e179ae@intel.com>
 <ZO3HjRp1pk5Qd51j@redhat.com>
 <c74e7e2e-a986-240c-6300-0d3fbc22dfc4@intel.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <c74e7e2e-a986-240c-6300-0d3fbc22dfc4@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=xiaoyao.li@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, NICE_REPLY_A=-1.242,
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

On 8/30/2023 1:18 PM, Chenyi Qiang wrote:
> 
> 
> On 8/29/2023 6:25 PM, Daniel P. Berrangé wrote:
>> On Tue, Aug 29, 2023 at 01:31:37PM +0800, Chenyi Qiang wrote:
>>>
>>>
>>> On 8/22/2023 4:24 PM, Daniel P. Berrangé wrote:
>>>> On Tue, Aug 22, 2023 at 08:52:30AM +0200, Markus Armbruster wrote:
>>>>> Xiaoyao Li <xiaoyao.li@intel.com> writes:
>>>>>
>>>>>> From: Isaku Yamahata <isaku.yamahata@intel.com>
>>>>>>
>>>>>> For GetQuote, delegate a request to Quote Generation Service.  Add property
>>>>>> of address of quote generation server and On request, connect to the
>>>>>> server, read request buffer from shared guest memory, send the request
>>>>>> buffer to the server and store the response into shared guest memory and
>>>>>> notify TD guest by interrupt.
>>>>>>
>>>>>> "quote-generation-service" is a property to specify Quote Generation
>>>>>> Service(QGS) in qemu socket address format.  The examples of the supported
>>>>>> format are "vsock:2:1234", "unix:/run/qgs", "localhost:1234".
>>>>>>
>>>>>> command line example:
>>>>>>    qemu-system-x86_64 \
>>>>>>      -object 'tdx-guest,id=tdx0,quote-generation-service=localhost:1234' \
>>>>>>      -machine confidential-guest-support=tdx0
>>>>>>
>>>>>> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
>>>>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>>>>> ---
>>>>>>   qapi/qom.json         |   5 +-
>>>>>>   target/i386/kvm/tdx.c | 380 ++++++++++++++++++++++++++++++++++++++++++
>>>>>>   target/i386/kvm/tdx.h |   7 +
>>>>>>   3 files changed, 391 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/qapi/qom.json b/qapi/qom.json
>>>>>> index 87c1d440f331..37139949d761 100644
>>>>>> --- a/qapi/qom.json
>>>>>> +++ b/qapi/qom.json
>>>>>> @@ -879,13 +879,16 @@
>>>>>>   #
>>>>>>   # @mrownerconfig: MROWNERCONFIG SHA384 hex string of 48 * 2 length (default: 0)
>>>>>>   #
>>>>>> +# @quote-generation-service: socket address for Quote Generation Service(QGS)
>>>>>> +#
>>>>>>   # Since: 8.2
>>>>>>   ##
>>>>>>   { 'struct': 'TdxGuestProperties',
>>>>>>     'data': { '*sept-ve-disable': 'bool',
>>>>>>               '*mrconfigid': 'str',
>>>>>>               '*mrowner': 'str',
>>>>>> -            '*mrownerconfig': 'str' } }
>>>>>> +            '*mrownerconfig': 'str',
>>>>>> +            '*quote-generation-service': 'str' } }
>>>>>
>>>>> Why not type SocketAddress?
>>>>
>>>> Yes, the code uses SocketAddress internally when it eventually
>>>> calls qio_channel_socket_connect_async(), so we should directly
>>>> use SocketAddress in the QAPI from the start.
>>>
>>> Any benefit to directly use SocketAddress?
>>
>> We don't want whatever code consumes the configuration to
>> do a second level of parsing to convert the 'str' value
>> into the 'SocketAddress' object it actually needs.
>>
>> QEMU has a long history of having a second round of ad-hoc
>> parsing of configuration and we've found it to be a serious
>> maintenence burden. Thus we strive to have everything
>> represented in QAPI using the desired final type, and avoid
>> the second round of parsing.
> 
> Thanks for your explanation.
> 
>>
>>> "quote-generation-service" here is optional, it seems not trivial to add
>>> and parse the SocketAddress type in QEMU command. After I change 'str'
>>> to 'SocketAddress' and specify the command like "-object
>>> tdx-guest,type=vsock,cid=2,port=1234...", it will report "invalid
>>> parameter cid".
>>
>> The -object parameter supports JSON syntax for this reason
>>
>>     -object '{"qom-type":"tdx-guest","quote-generation-service":{"type": "vsock", "cid":"2","port":"1234"}}'
>>
>> libvirt will always use the JSON syntax for -object with a new enough
>> QEMU.
> 
> The JSON syntax works for me. Then, we need to add some doc about using
> JSON syntax when quote-generation-service is required.

This limitation doesn't look reasonable to me.

@Daniel,

Is it acceptable by QEMU community?

>>
>> With regards,
>> Daniel


