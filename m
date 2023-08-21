Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE14F7826AE
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 11:59:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY1gK-0003lt-Vs; Mon, 21 Aug 2023 05:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qY1gH-0003l9-6u
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 05:58:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qY1gE-0002Ju-Km
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 05:58:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692611917;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=MouTdXYvd8EMbVAJZG4yva2UaPiccDDkjRW/8Gte4a8=;
 b=HizfLlel+5szzVgnA6OUNF67A2GJYnSUtD0KC5kdZ9tCLoJdl7igavHeEAcfdbUgXp0s65
 7tjDtwRyrsxzkGbb7vJKxz0dWngaCczN5AK569DCShJ78CKf7ZqQexZ/kZHDdtwWR5gE2a
 jE0ZHwDPUNoWJex67VB4wwYEZbb0eZ4=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-nrWzbycdPR-JNkhvZRDMGA-1; Mon, 21 Aug 2023 05:58:32 -0400
X-MC-Unique: nrWzbycdPR-JNkhvZRDMGA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D566D38210AC;
 Mon, 21 Aug 2023 09:58:31 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.139])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 28E5D492C13;
 Mon, 21 Aug 2023 09:58:28 +0000 (UTC)
Date: Mon, 21 Aug 2023 10:58:26 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Eduardo Habkost <eduardo@habkost.net>,
 Laszlo Ersek <lersek@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>, erdemaktas@google.com,
 Chenyi Qiang <chenyi.qiang@intel.com>
Subject: Re: [PATCH v2 47/58] i386/tdx: Wire REPORT_FATAL_ERROR with
 GuestPanic facility
Message-ID: <ZOM1Qk4wjNczWEf2@redhat.com>
References: <20230818095041.1973309-1-xiaoyao.li@intel.com>
 <20230818095041.1973309-48-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230818095041.1973309-48-xiaoyao.li@intel.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, Aug 18, 2023 at 05:50:30AM -0400, Xiaoyao Li wrote:
> Originated-from: Isaku Yamahata <isaku.yamahata@intel.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  qapi/run-state.json   | 17 +++++++++++++--
>  softmmu/runstate.c    | 49 +++++++++++++++++++++++++++++++++++++++++++
>  target/i386/kvm/tdx.c | 24 ++++++++++++++++++++-
>  3 files changed, 87 insertions(+), 3 deletions(-)
> 
> diff --git a/qapi/run-state.json b/qapi/run-state.json
> index f216ba54ec4c..506bbe31541f 100644
> --- a/qapi/run-state.json
> +++ b/qapi/run-state.json
> @@ -499,7 +499,7 @@
>  # Since: 2.9
>  ##
>  { 'enum': 'GuestPanicInformationType',
> -  'data': [ 'hyper-v', 's390' ] }
> +  'data': [ 'hyper-v', 's390', 'tdx' ] }

Missing documentation for the 'tdx' value

>  
>  ##
>  # @GuestPanicInformation:
> @@ -514,7 +514,8 @@
>   'base': {'type': 'GuestPanicInformationType'},
>   'discriminator': 'type',
>   'data': {'hyper-v': 'GuestPanicInformationHyperV',
> -          's390': 'GuestPanicInformationS390'}}
> +          's390': 'GuestPanicInformationS390',
> +          'tdx' : 'GuestPanicInformationTdx'}}
>  
>  ##
>  # @GuestPanicInformationHyperV:
> @@ -577,6 +578,18 @@
>            'psw-addr': 'uint64',
>            'reason': 'S390CrashReason'}}
>  
> +##
> +# @GuestPanicInformationTdx:
> +#
> +# TDX GHCI TDG.VP.VMCALL<ReportFatalError> specific guest panic information

Not documented any of the struct members. Especially please include
the warning that 'message' comes from the guest and so must not be
trusted, not assumed to be well formed.

> +#
> +# Since: 8.2
> +##
> +{'struct': 'GuestPanicInformationTdx',
> + 'data': {'error-code': 'uint64',
> +          'gpa': 'uint64',
> +          'message': 'str'}}
> +
>  ##
>  # @MEMORY_FAILURE:
>  #
> diff --git a/softmmu/runstate.c b/softmmu/runstate.c
> index f3bd86281813..cab11484ed7e 100644
> --- a/softmmu/runstate.c
> +++ b/softmmu/runstate.c
> @@ -518,7 +518,56 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
>                            S390CrashReason_str(info->u.s390.reason),
>                            info->u.s390.psw_mask,
>                            info->u.s390.psw_addr);
> +        } else if (info->type == GUEST_PANIC_INFORMATION_TYPE_TDX) {
> +            char *buf = NULL;
> +            bool printable = false;
> +
> +            /*
> +             * Although message is defined as a json string, we shouldn't
> +             * unconditionally treat it as is because the guest generated it and
> +             * it's not necessarily trustable.
> +             */
> +            if (info->u.tdx.message) {
> +                /* The caller guarantees the NUL-terminated string. */
> +                int len = strlen(info->u.tdx.message);
> +                int i;
> +
> +                printable = len > 0;
> +                for (i = 0; i < len; i++) {
> +                    if (!(0x20 <= info->u.tdx.message[i] &&
> +                          info->u.tdx.message[i] <= 0x7e)) {
> +                        printable = false;
> +                        break;
> +                    }
> +                }
> +
> +                /* 3 = length of "%02x " */
> +                buf = g_malloc(len * 3);
> +                for (i = 0; i < len; i++) {
> +                    if (info->u.tdx.message[i] == '\0') {
> +                        break;
> +                    } else {
> +                        sprintf(buf + 3 * i, "%02x ", info->u.tdx.message[i]);
> +                    }
> +                }
> +                if (i > 0)
> +                    /* replace the last ' '(space) to NUL */
> +                    buf[i * 3 - 1] = '\0';
> +                else
> +                    buf[0] = '\0';

You're building this escaped buffer but...

> +            }
> +
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          //" TDX report fatal error:\"%s\" %s",
> +                          " TDX report fatal error:\"%s\""
> +                          "error: 0x%016" PRIx64 " gpa page: 0x%016" PRIx64 "\n",
> +                          printable ? info->u.tdx.message : "",
> +                          //buf ? buf : "",

...then not actually using it

Either delete the 'buf' code, or use it.

> +                          info->u.tdx.error_code,
> +                          info->u.tdx.gpa);
> +            g_free(buf);
>          }
> +
>          qapi_free_GuestPanicInformation(info);
>      }
>  }
> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
> index f111b46dac92..7efaa13f59e2 100644
> --- a/target/i386/kvm/tdx.c
> +++ b/target/i386/kvm/tdx.c
> @@ -18,6 +18,7 @@
>  #include "qom/object_interfaces.h"
>  #include "standard-headers/asm-x86/kvm_para.h"
>  #include "sysemu/kvm.h"
> +#include "sysemu/runstate.h"
>  #include "sysemu/sysemu.h"
>  #include "exec/address-spaces.h"
>  #include "exec/ramblock.h"
> @@ -1408,11 +1409,26 @@ static void tdx_handle_get_quote(X86CPU *cpu, struct kvm_tdx_vmcall *vmcall)
>      vmcall->status_code = TDG_VP_VMCALL_SUCCESS;
>  }
>  
> +static void tdx_panicked_on_fatal_error(X86CPU *cpu, uint64_t error_code,
> +                                        uint64_t gpa, char *message)
> +{
> +    GuestPanicInformation *panic_info;
> +
> +    panic_info = g_new0(GuestPanicInformation, 1);
> +    panic_info->type = GUEST_PANIC_INFORMATION_TYPE_TDX;
> +    panic_info->u.tdx.error_code = error_code;
> +    panic_info->u.tdx.gpa = gpa;
> +    panic_info->u.tdx.message = (char *)message;
> +
> +    qemu_system_guest_panicked(panic_info);
> +}
> +
>  static void tdx_handle_report_fatal_error(X86CPU *cpu,
>                                            struct kvm_tdx_vmcall *vmcall)
>  {
>      uint64_t error_code = vmcall->in_r12;
>      char *message = NULL;
> +    uint64_t gpa = -1ull;
>  
>      if (error_code & 0xffff) {
>          error_report("invalid error code of TDG.VP.VMCALL<REPORT_FATAL_ERROR>\n");
> @@ -1441,7 +1457,13 @@ static void tdx_handle_report_fatal_error(X86CPU *cpu,
>      }
>  
>      error_report("TD guest reports fatal error. %s\n", message ? : "");

In tdx_panicked_on_fatal_error you're avoiding printing 'message' if it
contains non-printable characters, but here you're printing it regardless.

Do we still need this error_report call at all ?

> -    exit(1);
> +
> +#define TDX_REPORT_FATAL_ERROR_GPA_VALID    BIT_ULL(63)
> +    if (error_code & TDX_REPORT_FATAL_ERROR_GPA_VALID) {
> +	gpa = vmcall->in_r13;

Bad indent

> +    }
> +
> +    tdx_panicked_on_fatal_error(cpu, error_code, gpa, message);
>  }
>  
>  static void tdx_handle_setup_event_notify_interrupt(X86CPU *cpu,
> -- 
> 2.34.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


