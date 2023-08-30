Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5190178D1F8
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 04:17:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbAjw-0003lR-W1; Tue, 29 Aug 2023 22:15:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qbAju-0003lI-Fz
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 22:15:26 -0400
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qbAjq-00006m-C0
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 22:15:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1693361722; x=1724897722;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=OyDffJZtx/8oj0rHDa++JBuKCV1OAXuJkt8RbaQcbtQ=;
 b=nCi3gSASWhA4GWgJZFvNM9JZq1Gip4LGCPzbk/zHuxD5pRwwFMDLtmVi
 lG9GTvu+RArLbllmGHHt4VcprKSUJQ2rrDI+N/2OFqKhzSVJLpwmGvMOl
 NmuGHHYqLZgH7nox0vsFlcEt7KH585HHxsODiOBalfgw9KWb64LSa55C8
 Raj1GgHAzm4tmb3NJr6lmB10ctmdIGO412ytt1Zbg7QBxFgsQHiczKCZj
 31LcoQ8Sbwr8xTwBpYR8ug8GXiKry4Bs1cLGb9K/1Nc/Bc3D0J8HBNuAU
 4o/pN7flnKSW6aMB3CvEbW/G7FoocjlSTfxNPlmXnqiCozxRzQla03mDK g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="355038866"
X-IronPort-AV: E=Sophos;i="6.02,212,1688454000"; d="scan'208";a="355038866"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Aug 2023 19:15:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="715732436"
X-IronPort-AV: E=Sophos;i="6.02,212,1688454000"; d="scan'208";a="715732436"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.16.81])
 ([10.93.16.81])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Aug 2023 19:15:11 -0700
Message-ID: <a58cdd12-a83a-9e06-1df4-64267f6cbd9f@intel.com>
Date: Wed, 30 Aug 2023 10:15:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v2 47/58] i386/tdx: Wire REPORT_FATAL_ERROR with
 GuestPanic facility
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Eduardo Habkost <eduardo@habkost.net>, Laszlo Ersek <lersek@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>, erdemaktas@google.com,
 Chenyi Qiang <chenyi.qiang@intel.com>
References: <20230818095041.1973309-1-xiaoyao.li@intel.com>
 <20230818095041.1973309-48-xiaoyao.li@intel.com>
 <ZOM1Qk4wjNczWEf2@redhat.com>
 <00b88ec1-675c-9384-3a93-16b15e666126@intel.com>
 <ZO3IOax8bF0NpgnU@redhat.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ZO3IOax8bF0NpgnU@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.136; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, NICE_REPLY_A=-1.242,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

On 8/29/2023 6:28 PM, Daniel P. Berrangé wrote:
> On Mon, Aug 28, 2023 at 09:14:41PM +0800, Xiaoyao Li wrote:
>> On 8/21/2023 5:58 PM, Daniel P. Berrangé wrote:
>>> On Fri, Aug 18, 2023 at 05:50:30AM -0400, Xiaoyao Li wrote:
>>>> Originated-from: Isaku Yamahata <isaku.yamahata@intel.com>
>>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>>> ---
>>>>    qapi/run-state.json   | 17 +++++++++++++--
>>>>    softmmu/runstate.c    | 49 +++++++++++++++++++++++++++++++++++++++++++
>>>>    target/i386/kvm/tdx.c | 24 ++++++++++++++++++++-
>>>>    3 files changed, 87 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/qapi/run-state.json b/qapi/run-state.json
>>>> index f216ba54ec4c..506bbe31541f 100644
>>>> --- a/qapi/run-state.json
>>>> +++ b/qapi/run-state.json
>>>> @@ -499,7 +499,7 @@
>>>>    # Since: 2.9
>>>>    ##
>>>>    { 'enum': 'GuestPanicInformationType',
>>>> -  'data': [ 'hyper-v', 's390' ] }
>>>> +  'data': [ 'hyper-v', 's390', 'tdx' ] }
> 
>>
>>>> +#
>>>> +# Since: 8.2
>>>> +##
>>>> +{'struct': 'GuestPanicInformationTdx',
>>>> + 'data': {'error-code': 'uint64',
>>>> +          'gpa': 'uint64',
>>>> +          'message': 'str'}}
>>>> +
>>>>    ##
>>>>    # @MEMORY_FAILURE:
>>>>    #
>>>> diff --git a/softmmu/runstate.c b/softmmu/runstate.c
>>>> index f3bd86281813..cab11484ed7e 100644
>>>> --- a/softmmu/runstate.c
>>>> +++ b/softmmu/runstate.c
>>>> @@ -518,7 +518,56 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
>>>>                              S390CrashReason_str(info->u.s390.reason),
>>>>                              info->u.s390.psw_mask,
>>>>                              info->u.s390.psw_addr);
>>>> +        } else if (info->type == GUEST_PANIC_INFORMATION_TYPE_TDX) {
>>>> +            char *buf = NULL;
>>>> +            bool printable = false;
>>>> +
>>>> +            /*
>>>> +             * Although message is defined as a json string, we shouldn't
>>>> +             * unconditionally treat it as is because the guest generated it and
>>>> +             * it's not necessarily trustable.
>>>> +             */
>>>> +            if (info->u.tdx.message) {
>>>> +                /* The caller guarantees the NUL-terminated string. */
>>>> +                int len = strlen(info->u.tdx.message);
>>>> +                int i;
>>>> +
>>>> +                printable = len > 0;
>>>> +                for (i = 0; i < len; i++) {
>>>> +                    if (!(0x20 <= info->u.tdx.message[i] &&
>>>> +                          info->u.tdx.message[i] <= 0x7e)) {
>>>> +                        printable = false;
>>>> +                        break;
>>>> +                    }
>>>> +                }
>>>> +
>>>> +                /* 3 = length of "%02x " */
>>>> +                buf = g_malloc(len * 3);
>>>> +                for (i = 0; i < len; i++) {
>>>> +                    if (info->u.tdx.message[i] == '\0') {
>>>> +                        break;
>>>> +                    } else {
>>>> +                        sprintf(buf + 3 * i, "%02x ", info->u.tdx.message[i]);
>>>> +                    }
>>>> +                }
>>>> +                if (i > 0)
>>>> +                    /* replace the last ' '(space) to NUL */
>>>> +                    buf[i * 3 - 1] = '\0';
>>>> +                else
>>>> +                    buf[0] = '\0';
>>>
>>> You're building this escaped buffer but...
>>>
>>>> +            }
>>>> +
>>>> +            qemu_log_mask(LOG_GUEST_ERROR,
>>>> +                          //" TDX report fatal error:\"%s\" %s",
>>>> +                          " TDX report fatal error:\"%s\""
>>>> +                          "error: 0x%016" PRIx64 " gpa page: 0x%016" PRIx64 "\n",
>>>> +                          printable ? info->u.tdx.message : "",
>>>> +                          //buf ? buf : "",
>>>
>>> ...then not actually using it
>>>
>>> Either delete the 'buf' code, or use it.
>>
>> Sorry for posting some internal testing version.
>> Does below look good to you?
>>
>> @@ -518,7 +518,56 @@ void qemu_system_guest_panicked(GuestPanicInformation
>> *info)
>>                             S390CrashReason_str(info->u.s390.reason),
>>                             info->u.s390.psw_mask,
>>                             info->u.s390.psw_addr);
>> +        } else if (info->type == GUEST_PANIC_INFORMATION_TYPE_TDX) {
>> +            bool printable = false;
>> +            char *buf = NULL;
>> +            int len = 0, i;
>> +
>> +            /*
>> +             * Although message is defined as a json string, we shouldn't
>> +             * unconditionally treat it as is because the guest generated
>> it and
>> +             * it's not necessarily trustable.
>> +             */
>> +            if (info->u.tdx.message) {
>> +                /* The caller guarantees the NUL-terminated string. */
>> +                len = strlen(info->u.tdx.message);
>> +
>> +                printable = len > 0;
>> +                for (i = 0; i < len; i++) {
>> +                    if (!(0x20 <= info->u.tdx.message[i] &&
>> +                          info->u.tdx.message[i] <= 0x7e)) {
>> +                        printable = false;
>> +                        break;
>> +                    }
>> +                }
>> +            }
>> +
>> +            if (!printable && len) {
>> +                /* 3 = length of "%02x " */
>> +                buf = g_malloc(len * 3);
>> +                for (i = 0; i < len; i++) {
>> +                    if (info->u.tdx.message[i] == '\0') {
>> +                        break;
>> +                    } else {
>> +                        sprintf(buf + 3 * i, "%02x ",
>> info->u.tdx.message[i]);
>> +                    }
>> +                }
>> +                if (i > 0)
>> +                    /* replace the last ' '(space) to NUL */
>> +                    buf[i * 3 - 1] = '\0';
>> +                else
>> +                    buf[0] = '\0';
>> +            }
>> +
>> +            qemu_log_mask(LOG_GUEST_ERROR,
>> +                          " TDX guest reports fatal error:\"%s\""
>> +                          " error code: 0x%016" PRIx64 " gpa page: 0x%016"
>> PRIx64 "\n",
>> +                          printable ? info->u.tdx.message : buf,
>> +                          info->u.tdx.error_code,
>> +                          info->u.tdx.gpa);
>> +            g_free(buf);
>>           }
> 
> 
> Ok that makes more sense now. BTW, probably a nice idea to create a
> separate helper method that santizes the guest provided JSON into
> the safe 'buf' string.
> 

OK. Thanks for the suggestion.

Will do it in next version.

> With regards,
> Daniel


