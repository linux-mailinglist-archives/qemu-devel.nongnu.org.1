Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAF7A7F283
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Apr 2025 04:02:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1yGf-0002cT-B1; Mon, 07 Apr 2025 22:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1u1yGZ-0002bz-Q4
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 22:00:45 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1u1yGX-00038X-84
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 22:00:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744077641; x=1775613641;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=OCilHNMl6KOjdWUU2fEWt3Z/3p/1AspDT7e6OPB1xro=;
 b=n3QYnkACEWfQGYmgu7bLHI7ziRQEUoTxVhwGogtLZS7K3XgW29g6aPoH
 A+qZmkwGJWC0umjYwszYh10Ta6h0mxOp93xe9kW2hbOptrNO8EX+qKVFA
 TTueWke3y3IsD/DWNlR7ngTFIK7p2YyOF/es+KPdDtNRJf9FKX2cNfSf6
 1P73r2mQdMCy3laScbzGHZvRc9QKO3KPzSbRLU+eVrvcna8tZCLNGpg5e
 vW/TVPnVqhHAyXl8ahgMBZgCawtiDEXp8DAvwHVuA2uwtHEt+qvOyOIvp
 4SWPVXLnBHKgNq3zxrwIFdJQ/qgMOFNQPdVHLc9InIPLzteaf3GZhchaW A==;
X-CSE-ConnectionGUID: SNy12lcrSSyKQSmM3biXhg==
X-CSE-MsgGUID: Q26i2gdlTdaE3XgXl4hzgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45390909"
X-IronPort-AV: E=Sophos;i="6.15,196,1739865600"; d="scan'208";a="45390909"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 19:00:37 -0700
X-CSE-ConnectionGUID: W5SHVA7bTiCl3k268kurqw==
X-CSE-MsgGUID: Bv9tb3WlSt2LIuUOAZ6+9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,196,1739865600"; d="scan'208";a="128455440"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 19:00:31 -0700
Message-ID: <f1b0c905-3804-4c34-bc17-e437a8ae86d6@intel.com>
Date: Tue, 8 Apr 2025 10:00:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 49/65] i386/tdx: handle TDG.VP.VMCALL<GetQuote>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand
 <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Peter Xu <peterx@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 Michael Roth <michael.roth@amd.com>, Claudio Fontana <cfontana@suse.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Isaku Yamahata
 <isaku.yamahata@gmail.com>, Chenyi Qiang <chenyi.qiang@intel.com>
References: <20240229063726.610065-1-xiaoyao.li@intel.com>
 <20240229063726.610065-50-xiaoyao.li@intel.com> <Zv7dtghi20DZ9ozz@redhat.com>
 <0e15f14b-cd63-4ec4-8232-a5c0a96ba31d@intel.com>
 <Z-1cm6cEwNGs9NEu@redhat.com>
 <a3a8ed8d-9994-42c9-ba3b-ef59d6977ce6@intel.com>
 <Z-5Ces2kGrB67aPw@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <Z-5Ces2kGrB67aPw@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 4/3/2025 4:10 PM, Daniel P. Berrangé wrote:
> On Thu, Apr 03, 2025 at 03:28:43PM +0800, Xiaoyao Li wrote:
>> On 4/2/2025 11:49 PM, Daniel P. Berrangé wrote:
>>> On Wed, Apr 02, 2025 at 11:26:11PM +0800, Xiaoyao Li wrote:
>>>>
>>>> I guess the raw mode was introduced due to the design was changed to let
>>>> guest kernel to forward to TD report to host QGS via TDVMCALL instead of
>>>> guest application communicates with host QGS via vsock, and Linux TD guest
>>>> driver doesn't integrate any QGS protocol but just forward the raw TD report
>>>> data to KVM.
>>>>
>>>>> IMHO, QEMU should be made to pack & unpack the TDX report from
>>>>> the guest into the GET_QUOTE_REQ / GET_QUOTE_RESP messages, and
>>>>> this "raw" mode should be removed to QGS as it is inherantly
>>>>> dangerous to have this magic protocol overloading.
>>>>
>>>> There is no enforcement that the input data of TDVMCALL.GetQuote is the raw
>>>> data of TD report. It is just the current Linux tdx-guest driver of tsm
>>>> implementation send the raw data. For other TDX OS, or third-party driver,
>>>> they might encapsulate the raw TD report data with QGS message header. For
>>>> such cases, if QEMU adds another layer of package, it leads to the wrong
>>>> result.
>>>
>>> If I look at the GHCI spec
>>>
>>>     https://cdrdv2-public.intel.com/726790/TDX%20Guest-Hypervisor%20Communication%20Interface_1.0_344426_006%20-%2020230311.pdf
>>>
>>> In "3.3 TDG.VP.VMCALL<GetQuote>", it indicates the parameter is a
>>> "TDREPORT_STRUCT". IOW, it doesn't look valid to allow the guest to
>>> send arbitrary other data as QGS protocol messages.
>>
>> In table 3-7, the description of R12 is
>>
>>    Shared GPA as input - the memory contains a TDREPORT_STRUCT.
>>    The same buffer is used as output - the memory contains a TD Quote.
>>
>> table 3-10, describes the detailed format of the shared GPA:
>>
>> starting from offset 24 bytes, it is the "Data"
>>
>>    On input, the data filled by TD with input length. The data should
>>    include TDREPORT_STRUCT. TD should zeroize the remaining buffer to
>>    avoid information leak if size of shared GPA (R13) > Input Length.
>>
>> It uses the word "contains" and "include", but without "only". So it is not
>> clear to me.
>>
>> I will work with internal attestation folks to make it clearer that who (TD
>> guest or host VMM) is responsible to encapsulate the raw TDERPORT_STRCUT
>> with QGS MSG protocol, and update the spec accordingly.
> 
> To be clear, my strong preference is that the spec be updated to only
> permit the raw TDREPORT_STRUCT.
> 
> IMHO allowing arbitrary QGS MSGs would be a significant host security
> weakness, as it exposes a huge amount of the QGS codebase to direct
> attack from the guest.

If I remember correctly, the QGS instance keeps the vsock interface so 
that TD guest can communicate with QGS directly without going through 
host VMM. (I'm not sure if latest QGS implementation still keeps it.)
So QGS should know how to protect itself.

Regarding QEMU avoids from being exploited to forward arbitrary data 
from malicious TDX guest to QGS, QEMU can check the beginning of the 
data to be a valid QGS MSG header before handing it over to QGS socket.

> QEMU needs to be able to block that attack
> vector. Without that, the benefit/value of shuffling of TDREPORTs via
> the GetQuote hypercall is largely eliminated, and might as well have
> just exposed QGS over VSOCK.

If I remember correctly, one of the reason we changed from TD guest 
communicates with QGS directly with vsock to current TDVMCALL(GETQUOTE), 
is some of the TD guest environment might not have network stack for 
vsock to work.

Anyway, I don't have preference. Either is OK to me. Let's see what 
decision the attestation folks will make.

> With regards,
> Daniel


