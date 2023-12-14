Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B33D8125C3
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 04:09:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDc4o-0004mq-Gt; Wed, 13 Dec 2023 22:07:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rDc4m-0004mL-1T
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 22:07:52 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rDc4j-00062e-JO
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 22:07:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1702523270; x=1734059270;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=o+Xh5+ubvPl+H4+Pxt2mVXHzTgpGDMgBg6p1Y6WJUnI=;
 b=Hh13RW9SfNYWZOJT/VsWwjuUqSnbcv0QUgQQBbomqkfhYNqphsCMQ5tX
 pQ3PL4PG86H7vnfVqoXx1c7ztY8a80tqUCkOKIWXXoROMyRiiL/SPMrFe
 qzi2Kc0NQ7CEtOssXmlHwWDjm7Xh0jEqD3F3co/hSy6UoSTcO5U/ITg1L
 7aEzGB7H9ZoUbx/p/YrXgfLycXGJLh2KebH5n+narDl9Of2XW2y9NvPIo
 2bsBxKc28H12ImqzTq+8hbyGP5wdqlnxtuipJaHuCH62lf1w7gVMbN12z
 5f9tv42HJpkEdn8UTbhKG++a+gBtdmlF54Fq0ScekGljBsUnAd8NyqUcu w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="8421978"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="8421978"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Dec 2023 19:07:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="917899219"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; d="scan'208";a="917899219"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.29.154])
 ([10.93.29.154])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Dec 2023 19:07:24 -0800
Message-ID: <31d6dbc1-f453-4cef-ab08-4813f4e0ff92@intel.com>
Date: Thu, 14 Dec 2023 11:07:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 31/70] i386/tdx: Allows
 mrconfigid/mrowner/mrownerconfig for TDX_INIT_VM
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
 <20231115071519.2864957-32-xiaoyao.li@intel.com>
 <87o7faw5k1.fsf@pond.sub.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <87o7faw5k1.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 12/1/2023 7:00 PM, Markus Armbruster wrote:
> Xiaoyao Li <xiaoyao.li@intel.com> writes:
> 
>> From: Isaku Yamahata <isaku.yamahata@intel.com>
>>
>> Three sha384 hash values, mrconfigid, mrowner and mrownerconfig, of a TD
>> can be provided for TDX attestation.
>>
>> So far they were hard coded as 0. Now allow user to specify those values
>> via property mrconfigid, mrowner and mrownerconfig. They are all in
>> base64 format.
>>
>> example
>> -object tdx-guest, \
>>    mrconfigid=ASNFZ4mrze8BI0VniavN7wEjRWeJq83vASNFZ4mrze8BI0VniavN7wEjRWeJq83v,\
>>    mrowner=ASNFZ4mrze8BI0VniavN7wEjRWeJq83vASNFZ4mrze8BI0VniavN7wEjRWeJq83v,\
>>    mrownerconfig=ASNFZ4mrze8BI0VniavN7wEjRWeJq83vASNFZ4mrze8BI0VniavN7wEjRWeJq83v
>>
>> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
>> Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>> Changes in v3:
>>   - use base64 encoding instread of hex-string;
>> ---
>>   qapi/qom.json         | 11 +++++-
>>   target/i386/kvm/tdx.c | 85 +++++++++++++++++++++++++++++++++++++++++++
>>   target/i386/kvm/tdx.h |  3 ++
>>   3 files changed, 98 insertions(+), 1 deletion(-)
>>
>> diff --git a/qapi/qom.json b/qapi/qom.json
>> index 3a29659e0155..fd99aa1ff8cc 100644
>> --- a/qapi/qom.json
>> +++ b/qapi/qom.json
>> @@ -888,10 +888,19 @@
>>   #     pages.  Some guest OS (e.g., Linux TD guest) may require this to
>>   #     be set, otherwise they refuse to boot.
>>   #
>> +# @mrconfigid: base64 encoded MRCONFIGID SHA384 digest
>> +#
>> +# @mrowner: base64 encoded MROWNER SHA384 digest
>> +#
>> +# @mrownerconfig: base64 MROWNERCONFIG SHA384 digest
> 
> Can we come up with a description that tells the user a bit more clearly
> what we're talking about?  Perhaps starting with this question could
> lead us there: what's an MRCONFIGID, and why should I care?

Below are the definition from TDX spec:

MRCONFIGID: Software-defined ID for non-owner-defined configuration of 
the guest TD – e.g., run-time or OS configuration.

MROWNER: Software-defined ID for the guest TD’s owner

MROWNERCONFIG: Software-defined ID for owner-defined configuration of 
the guest TD – e.g., specific to the workload rather than the run-time or OS


They are all attestation related, and input by users who launches the TD 
. Software inside TD can retrieve them with TDREPORT and verify if it is 
the expected value.

MROWNER is to identify the owner of the TD, MROWNERCONFIG is to pass 
OWNER's configuration. And MRCONFIGID contains configuration specific to 
OS level instead of OWNER.

Below is the explanation from Intel inside, hope it can get you more clear:

"These are primarily intended for general purpose, configurable software 
in a minimal TD. So, not a legacy VM image cloud customer wanting to 
move their VM out into the cloud. Also it’s not necessarily the case 
that any workload will use them all.

MROWNER is for declaring the owner of the TD. An example use case would 
be an vHSM TD. HSMs need to know who their administrative contact is. 
You could customize the HSM image and measurements, but then people 
can’t recognize that this is the vHSM product from XYZ. So you put the 
unmodified vHSM stack in the TD, which will include MRTD/RTMRs that 
reflect the vHSM, and the owner’s public key in MROWNER. Now, when the 
vHSM starts up, to determine who is authorized to send commands, it does 
a TDREPORT, and looks at MROWNER.

Extending this model, there could be important configuration information 
from the owner. In that case, MROWNERCONFIG is set to the hash of the 
config file that the vHSM should accept.

This results in an attestable environment that explicitly indicates that 
it’s a well recognized vHSM TD, being administered by MROWNER and 
loading the configuration information that matches MROWNERCONFIG.

Extending this idea of configuration of generally recognized software, 
it could be that there is a shim OS under the vHSM that itself is 
configurable. So MRCONFIGID, which isn’t a great name, can include 
configuration information intended for the OS level. The ID is 
confusing, but MRCONFIGID was the name we used for this register for 
SGX, so we kept the name."

>> +#
>>   # Since: 8.2
>>   ##
>>   { 'struct': 'TdxGuestProperties',
>> -  'data': { '*sept-ve-disable': 'bool' } }
>> +  'data': { '*sept-ve-disable': 'bool',
>> +            '*mrconfigid': 'str',
>> +            '*mrowner': 'str',
>> +            '*mrownerconfig': 'str' } }
>>   
>>   ##
>>   # @ThreadContextProperties:
> 
> [...]
> 


