Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96327808295
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 09:12:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rB9Tr-0004U6-DJ; Thu, 07 Dec 2023 03:11:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rB9Tg-0004Th-EE
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 03:11:25 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rB9Tc-0002l8-BY
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 03:11:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1701936680; x=1733472680;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ozGjfFWenBxqgP2+d8rZ5ATy8rbjN8S1yBgJ5GIxczM=;
 b=MShJKkThIHR37MmnEIb/BuruIdLOM8TeEZn7JHnxE/bXlWMMdgfLQ1Rf
 9JeX5UwwTUDi3RhjL5WI7I65lO/AgMpnZpp2+R+is+q9yxhqMDhvuiuJI
 2zNPOFxsGeO2jHu1s+GVP6nk4+D27UKfid3MVi4r4NCZCTR3F8Tf56htL
 GtcFORfN2kGF1whHWSinodM5pBm1ibqlJEL5AxhzHlZ6z4SppKi8zEGmT
 hKTmHoibc8fDC3AyQbOMmf/uftSepiZGtIj05gyxMPgVRVF3kbc56Amvt
 jZGORgjQHT3482glBog8FouDw0OjEJQrEOcBbFor7EOtQ4KDlmvR8lVFd g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="7504367"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="7504367"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Dec 2023 00:11:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="862398054"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; d="scan'208";a="862398054"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.29.154])
 ([10.93.29.154])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Dec 2023 00:11:11 -0800
Message-ID: <4f60f482-0910-4a8f-a521-972630c08ad2@intel.com>
Date: Thu, 7 Dec 2023 16:11:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 57/70] i386/tdx: Wire TDX_REPORT_FATAL_ERROR with
 GuestPanic facility
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
 <20231115071519.2864957-58-xiaoyao.li@intel.com>
 <87bkbaw51z.fsf@pond.sub.org>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <87bkbaw51z.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.8; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, SPF_HELO_NONE=0.001,
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

On 12/1/2023 7:11 PM, Markus Armbruster wrote:
> Xiaoyao Li <xiaoyao.li@intel.com> writes:
> 
>> Integrate TDX's TDX_REPORT_FATAL_ERROR into QEMU GuestPanic facility
>>
>> Originated-from: Isaku Yamahata <isaku.yamahata@intel.com>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>> Changes from v2:
>> - Add docmentation of new type and struct (Daniel)
>> - refine the error message handling (Daniel)
>> ---
>>   qapi/run-state.json   | 27 ++++++++++++++++++++--
>>   system/runstate.c     | 54 +++++++++++++++++++++++++++++++++++++++++++
>>   target/i386/kvm/tdx.c | 24 +++++++++++++++++--
>>   3 files changed, 101 insertions(+), 4 deletions(-)
>>
>> diff --git a/qapi/run-state.json b/qapi/run-state.json
>> index f216ba54ec4c..e18f62eaef77 100644
>> --- a/qapi/run-state.json
>> +++ b/qapi/run-state.json
>> @@ -496,10 +496,12 @@
>>   #
>>   # @s390: s390 guest panic information type (Since: 2.12)
>>   #
>> +# @tdx: tdx guest panic information type (Since: 8.2)
>> +#
>>   # Since: 2.9
>>   ##
>>   { 'enum': 'GuestPanicInformationType',
>> -  'data': [ 'hyper-v', 's390' ] }
>> +  'data': [ 'hyper-v', 's390', 'tdx' ] }
>>   
>>   ##
>>   # @GuestPanicInformation:
>> @@ -514,7 +516,8 @@
>>    'base': {'type': 'GuestPanicInformationType'},
>>    'discriminator': 'type',
>>    'data': {'hyper-v': 'GuestPanicInformationHyperV',
>> -          's390': 'GuestPanicInformationS390'}}
>> +          's390': 'GuestPanicInformationS390',
>> +          'tdx' : 'GuestPanicInformationTdx'}}
>>   
>>   ##
>>   # @GuestPanicInformationHyperV:
>> @@ -577,6 +580,26 @@
>>             'psw-addr': 'uint64',
>>             'reason': 'S390CrashReason'}}
>>   
>> +##
>> +# @GuestPanicInformationTdx:
>> +#
>> +# TDX GHCI TDG.VP.VMCALL<ReportFatalError> specific guest panic information
> 
> Long line.  Suggest
> 
>     # Guest panic information specific to TDX GHCI
>     # TDG.VP.VMCALL<ReportFatalError>.

As I asked in patch #52, what's the limitation of one line?

>> +#
>> +# @error-code: TD-specific error code
>> +#
>> +# @gpa: 4KB-aligned guest physical address of the page that containing
>> +#     additional error data
> 
> "address of a page" implies the address is page-aligned.  4KB-aligned
> feels redundant.  What about
> 
>     # @qpa: guest-physical address of a page that contains additional
>     #     error data.
> 
> But in what format is the "additional error data"?

it's expected to hold a zero-terminated string.

>> +#
>> +# @message: TD guest provided message string.  (It's not so trustable
>> +#     and cannot be assumed to be well formed because it comes from guest)
> 
> guest-provided
> 
> For "well-formed" to make sense, we'd need an idea of the form / syntax.
> 
> If it's a human-readable error message, we could go with
> 
>     # @message: Human-readable error message provided by the guest.  Not
>     #     to be trusted.
>

looks good. I will your version.

>> +#
>> +# Since: 8.2
>> +##
>> +{'struct': 'GuestPanicInformationTdx',
>> + 'data': {'error-code': 'uint64',
>> +          'gpa': 'uint64',
>> +          'message': 'str'}}
>> +
>>   ##
>>   # @MEMORY_FAILURE:
>>   #
> 
> [...]
> 


