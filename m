Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED68378B1B8
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 15:23:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qacBS-0007rP-JP; Mon, 28 Aug 2023 09:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qacBQ-0007rH-2k
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 09:21:32 -0400
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qacBM-0005MT-OJ
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 09:21:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1693228888; x=1724764888;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Xsc9si96vmlYnKL6l7YXmsAt/CgzpO1sCbtJQc8hXTk=;
 b=LRNjgYoEhzEjuMEgmCxvzVgbAbdTWJHKu0Tjv1TXVnVMM4IzZ0Mhfst7
 /G/+YJHJCxBhUhUaiSDvDlD2ZnqF5jgEGAtyHsymGv0PN6kYE+PgFXvVT
 ZlYx8ud6feFZuVFMhrIsHBkqrBWhQfeKKQnMFaFeZHNEl9br3z7KKxZfR
 wOrmGGiympuIbaadoVdMPggz0u4ELstXLqoc8upDF/7IiorcTwdEpSvn5
 VQO9deqyW2vQ5PTbAQxX0bfCMNUGUVRrOKcF6z4zUtw2go6S0LwoqBCSx
 F2NLyrqoAJLxzF3Hb/BrG0hm2YjWlZKzb1QIDNaXbEOeSlBoLs65w8v/P w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="354621620"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; d="scan'208";a="354621620"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2023 06:14:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="773261730"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; d="scan'208";a="773261730"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.16.81])
 ([10.93.16.81])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2023 06:14:44 -0700
Message-ID: <00b88ec1-675c-9384-3a93-16b15e666126@intel.com>
Date: Mon, 28 Aug 2023 21:14:41 +0800
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
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ZOM1Qk4wjNczWEf2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.136; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, NICE_REPLY_A=-2.169,
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

On 8/21/2023 5:58 PM, Daniel P. Berrangé wrote:
> On Fri, Aug 18, 2023 at 05:50:30AM -0400, Xiaoyao Li wrote:
>> Originated-from: Isaku Yamahata <isaku.yamahata@intel.com>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>>   qapi/run-state.json   | 17 +++++++++++++--
>>   softmmu/runstate.c    | 49 +++++++++++++++++++++++++++++++++++++++++++
>>   target/i386/kvm/tdx.c | 24 ++++++++++++++++++++-
>>   3 files changed, 87 insertions(+), 3 deletions(-)
>>
>> diff --git a/qapi/run-state.json b/qapi/run-state.json
>> index f216ba54ec4c..506bbe31541f 100644
>> --- a/qapi/run-state.json
>> +++ b/qapi/run-state.json
>> @@ -499,7 +499,7 @@
>>   # Since: 2.9
>>   ##
>>   { 'enum': 'GuestPanicInformationType',
>> -  'data': [ 'hyper-v', 's390' ] }
>> +  'data': [ 'hyper-v', 's390', 'tdx' ] }
> 
> Missing documentation for the 'tdx' value
> 
>>   
>>   ##
>>   # @GuestPanicInformation:
>> @@ -514,7 +514,8 @@
>>    'base': {'type': 'GuestPanicInformationType'},
>>    'discriminator': 'type',
>>    'data': {'hyper-v': 'GuestPanicInformationHyperV',
>> -          's390': 'GuestPanicInformationS390'}}
>> +          's390': 'GuestPanicInformationS390',
>> +          'tdx' : 'GuestPanicInformationTdx'}}
>>   
>>   ##
>>   # @GuestPanicInformationHyperV:
>> @@ -577,6 +578,18 @@
>>             'psw-addr': 'uint64',
>>             'reason': 'S390CrashReason'}}
>>   
>> +##
>> +# @GuestPanicInformationTdx:
>> +#
>> +# TDX GHCI TDG.VP.VMCALL<ReportFatalError> specific guest panic information
> 
> Not documented any of the struct members. Especially please include
> the warning that 'message' comes from the guest and so must not be
> trusted, not assumed to be well formed.

Will do it in next version.

thanks!


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
>> diff --git a/softmmu/runstate.c b/softmmu/runstate.c
>> index f3bd86281813..cab11484ed7e 100644
>> --- a/softmmu/runstate.c
>> +++ b/softmmu/runstate.c
>> @@ -518,7 +518,56 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
>>                             S390CrashReason_str(info->u.s390.reason),
>>                             info->u.s390.psw_mask,
>>                             info->u.s390.psw_addr);
>> +        } else if (info->type == GUEST_PANIC_INFORMATION_TYPE_TDX) {
>> +            char *buf = NULL;
>> +            bool printable = false;
>> +
>> +            /*
>> +             * Although message is defined as a json string, we shouldn't
>> +             * unconditionally treat it as is because the guest generated it and
>> +             * it's not necessarily trustable.
>> +             */
>> +            if (info->u.tdx.message) {
>> +                /* The caller guarantees the NUL-terminated string. */
>> +                int len = strlen(info->u.tdx.message);
>> +                int i;
>> +
>> +                printable = len > 0;
>> +                for (i = 0; i < len; i++) {
>> +                    if (!(0x20 <= info->u.tdx.message[i] &&
>> +                          info->u.tdx.message[i] <= 0x7e)) {
>> +                        printable = false;
>> +                        break;
>> +                    }
>> +                }
>> +
>> +                /* 3 = length of "%02x " */
>> +                buf = g_malloc(len * 3);
>> +                for (i = 0; i < len; i++) {
>> +                    if (info->u.tdx.message[i] == '\0') {
>> +                        break;
>> +                    } else {
>> +                        sprintf(buf + 3 * i, "%02x ", info->u.tdx.message[i]);
>> +                    }
>> +                }
>> +                if (i > 0)
>> +                    /* replace the last ' '(space) to NUL */
>> +                    buf[i * 3 - 1] = '\0';
>> +                else
>> +                    buf[0] = '\0';
> 
> You're building this escaped buffer but...
> 
>> +            }
>> +
>> +            qemu_log_mask(LOG_GUEST_ERROR,
>> +                          //" TDX report fatal error:\"%s\" %s",
>> +                          " TDX report fatal error:\"%s\""
>> +                          "error: 0x%016" PRIx64 " gpa page: 0x%016" PRIx64 "\n",
>> +                          printable ? info->u.tdx.message : "",
>> +                          //buf ? buf : "",
> 
> ...then not actually using it
> 
> Either delete the 'buf' code, or use it.

Sorry for posting some internal testing version.
Does below look good to you?

@@ -518,7 +518,56 @@ void 
qemu_system_guest_panicked(GuestPanicInformation *info)
                            S390CrashReason_str(info->u.s390.reason),
                            info->u.s390.psw_mask,
                            info->u.s390.psw_addr);
+        } else if (info->type == GUEST_PANIC_INFORMATION_TYPE_TDX) {
+            bool printable = false;
+            char *buf = NULL;
+            int len = 0, i;
+
+            /*
+             * Although message is defined as a json string, we shouldn't
+             * unconditionally treat it as is because the guest 
generated it and
+             * it's not necessarily trustable.
+             */
+            if (info->u.tdx.message) {
+                /* The caller guarantees the NUL-terminated string. */
+                len = strlen(info->u.tdx.message);
+
+                printable = len > 0;
+                for (i = 0; i < len; i++) {
+                    if (!(0x20 <= info->u.tdx.message[i] &&
+                          info->u.tdx.message[i] <= 0x7e)) {
+                        printable = false;
+                        break;
+                    }
+                }
+            }
+
+            if (!printable && len) {
+                /* 3 = length of "%02x " */
+                buf = g_malloc(len * 3);
+                for (i = 0; i < len; i++) {
+                    if (info->u.tdx.message[i] == '\0') {
+                        break;
+                    } else {
+                        sprintf(buf + 3 * i, "%02x ", 
info->u.tdx.message[i]);
+                    }
+                }
+                if (i > 0)
+                    /* replace the last ' '(space) to NUL */
+                    buf[i * 3 - 1] = '\0';
+                else
+                    buf[0] = '\0';
+            }
+
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          " TDX guest reports fatal error:\"%s\""
+                          " error code: 0x%016" PRIx64 " gpa page: 
0x%016" PRIx64 "\n",
+                          printable ? info->u.tdx.message : buf,
+                          info->u.tdx.error_code,
+                          info->u.tdx.gpa);
+            g_free(buf);
          }



>> +                          info->u.tdx.error_code,
>> +                          info->u.tdx.gpa);
>> +            g_free(buf);
>>           }
>> +
>>           qapi_free_GuestPanicInformation(info);
>>       }
>>   }
>> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
>> index f111b46dac92..7efaa13f59e2 100644
>> --- a/target/i386/kvm/tdx.c
>> +++ b/target/i386/kvm/tdx.c
>> @@ -18,6 +18,7 @@
>>   #include "qom/object_interfaces.h"
>>   #include "standard-headers/asm-x86/kvm_para.h"
>>   #include "sysemu/kvm.h"
>> +#include "sysemu/runstate.h"
>>   #include "sysemu/sysemu.h"
>>   #include "exec/address-spaces.h"
>>   #include "exec/ramblock.h"
>> @@ -1408,11 +1409,26 @@ static void tdx_handle_get_quote(X86CPU *cpu, struct kvm_tdx_vmcall *vmcall)
>>       vmcall->status_code = TDG_VP_VMCALL_SUCCESS;
>>   }
>>   
>> +static void tdx_panicked_on_fatal_error(X86CPU *cpu, uint64_t error_code,
>> +                                        uint64_t gpa, char *message)
>> +{
>> +    GuestPanicInformation *panic_info;
>> +
>> +    panic_info = g_new0(GuestPanicInformation, 1);
>> +    panic_info->type = GUEST_PANIC_INFORMATION_TYPE_TDX;
>> +    panic_info->u.tdx.error_code = error_code;
>> +    panic_info->u.tdx.gpa = gpa;
>> +    panic_info->u.tdx.message = (char *)message;
>> +
>> +    qemu_system_guest_panicked(panic_info);
>> +}
>> +
>>   static void tdx_handle_report_fatal_error(X86CPU *cpu,
>>                                             struct kvm_tdx_vmcall *vmcall)
>>   {
>>       uint64_t error_code = vmcall->in_r12;
>>       char *message = NULL;
>> +    uint64_t gpa = -1ull;
>>   
>>       if (error_code & 0xffff) {
>>           error_report("invalid error code of TDG.VP.VMCALL<REPORT_FATAL_ERROR>\n");
>> @@ -1441,7 +1457,13 @@ static void tdx_handle_report_fatal_error(X86CPU *cpu,
>>       }
>>   
>>       error_report("TD guest reports fatal error. %s\n", message ? : "");
> 
> In tdx_panicked_on_fatal_error you're avoiding printing 'message' if it
> contains non-printable characters, but here you're printing it regardless.

I guess you meant qemu_system_guest_panicked().

> Do we still need this error_report call at all ?

yes. It can and should be dropped before I sent to maillist. I keep it 
internally for testing purpose because qemu_log_mask() doesn't get 
printed by default.

>> -    exit(1);
>> +
>> +#define TDX_REPORT_FATAL_ERROR_GPA_VALID    BIT_ULL(63)
>> +    if (error_code & TDX_REPORT_FATAL_ERROR_GPA_VALID) {
>> +	gpa = vmcall->in_r13;
> 
> Bad indent

Fixed.

>> +    }
>> +
>> +    tdx_panicked_on_fatal_error(cpu, error_code, gpa, message);
>>   }
>>   
>>   static void tdx_handle_setup_event_notify_interrupt(X86CPU *cpu,
>> -- 
>> 2.34.1
>>
> 
> With regards,
> Daniel


