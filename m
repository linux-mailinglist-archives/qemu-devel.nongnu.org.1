Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFE39BCB12
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Nov 2024 11:54:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8HCD-0001Sm-8t; Tue, 05 Nov 2024 05:54:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8HCB-0001SW-OE
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 05:53:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8HC9-0004K5-Kg
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 05:53:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730804036;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=DIJJbGCFmGjzScRcqhQhqxPwcgLRUbIGY02auMsPAsU=;
 b=S67JsyqhW72AP6Yk5JM4tICdynVrzpvHswVNFsE2NnTq3poUTbryO3qeKw13Z9VVVPybKw
 ihPttiPM0pNNrx4buSFw8R7s5/uaxJcO3ABo79AcGjl7uDeuc9PnxEBJt4SGLgrBHSRl60
 ZMHI40CqlalOiJKOeomSz0qRv9n8Zws=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-327-Iw1GF3hNP-2tKEyKBw7L2Q-1; Tue,
 05 Nov 2024 05:53:53 -0500
X-MC-Unique: Iw1GF3hNP-2tKEyKBw7L2Q-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC3F01956096; Tue,  5 Nov 2024 10:53:51 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 432F519560A2; Tue,  5 Nov 2024 10:53:44 +0000 (UTC)
Date: Tue, 5 Nov 2024 10:53:41 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, rick.p.edgecombe@intel.com,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v6 30/60] i386/tdx: Wire TDX_REPORT_FATAL_ERROR with
 GuestPanic facility
Message-ID: <Zyn5Nbz9XaBhtPoX@redhat.com>
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
 <20241105062408.3533704-31-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241105062408.3533704-31-xiaoyao.li@intel.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Nov 05, 2024 at 01:23:38AM -0500, Xiaoyao Li wrote:
> Integrate TDX's TDX_REPORT_FATAL_ERROR into QEMU GuestPanic facility
> 
> Originated-from: Isaku Yamahata <isaku.yamahata@intel.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
> Changes in v6:
> - change error_code of GuestPanicInformationTdx from uint64_t to
>   uint32_t, to only contains the bit 31:0 returned in r12.
> 
> Changes in v5:
> - mention additional error information in gpa when it presents;
> - refine the documentation; (Markus)
> 
> Changes in v4:
> - refine the documentation; (Markus)
> 
> Changes in v3:
> - Add docmentation of new type and struct; (Daniel)
> - refine the error message handling; (Daniel)
> ---
>  qapi/run-state.json   | 31 +++++++++++++++++++++--
>  system/runstate.c     | 58 +++++++++++++++++++++++++++++++++++++++++++
>  target/i386/kvm/tdx.c | 24 +++++++++++++++++-
>  3 files changed, 110 insertions(+), 3 deletions(-)
> 
> diff --git a/qapi/run-state.json b/qapi/run-state.json
> index ce95cfa46b73..c5b0b747b30d 100644
> --- a/qapi/run-state.json
> +++ b/qapi/run-state.json
> @@ -501,10 +501,12 @@
>  #
>  # @s390: s390 guest panic information type (Since: 2.12)
>  #
> +# @tdx: tdx guest panic information type (Since: 9.0)
> +#
>  # Since: 2.9
>  ##
>  { 'enum': 'GuestPanicInformationType',
> -  'data': [ 'hyper-v', 's390' ] }
> +  'data': [ 'hyper-v', 's390', 'tdx' ] }
>  
>  ##
>  # @GuestPanicInformation:
> @@ -519,7 +521,8 @@
>   'base': {'type': 'GuestPanicInformationType'},
>   'discriminator': 'type',
>   'data': {'hyper-v': 'GuestPanicInformationHyperV',
> -          's390': 'GuestPanicInformationS390'}}
> +          's390': 'GuestPanicInformationS390',
> +          'tdx' : 'GuestPanicInformationTdx'}}
>  
>  ##
>  # @GuestPanicInformationHyperV:
> @@ -598,6 +601,30 @@
>            'psw-addr': 'uint64',
>            'reason': 'S390CrashReason'}}
>  
> +##
> +# @GuestPanicInformationTdx:
> +#
> +# TDX Guest panic information specific to TDX, as specified in the
> +# "Guest-Hypervisor Communication Interface (GHCI) Specification",
> +# section TDG.VP.VMCALL<ReportFatalError>.
> +#
> +# @error-code: TD-specific error code
> +#
> +# @message: Human-readable error message provided by the guest. Not
> +#     to be trusted.
> +#
> +# @gpa: guest-physical address of a page that contains more verbose
> +#     error information, as zero-terminated string.  Present when the
> +#     "GPA valid" bit (bit 63) is set in @error-code.
> +#
> +#
> +# Since: 9.0

This is very outdated. Change to 10.0 as the next possible release
it could land it.

> +##
> +{'struct': 'GuestPanicInformationTdx',
> + 'data': {'error-code': 'uint32',
> +          'message': 'str',
> +          '*gpa': 'uint64'}}
> +
>  ##
>  # @MEMORY_FAILURE:
>  #
> diff --git a/system/runstate.c b/system/runstate.c
> index c2c9afa905a6..9bb8162eb28f 100644
> --- a/system/runstate.c
> +++ b/system/runstate.c
> @@ -565,6 +565,52 @@ static void qemu_system_wakeup(void)
>      }
>  }
>  
> +static char *tdx_parse_panic_message(char *message)
> +{
> +    bool printable = false;
> +    char *buf = NULL;
> +    int len = 0, i;
> +
> +    /*
> +     * Although message is defined as a json string, we shouldn't
> +     * unconditionally treat it as is because the guest generated it and
> +     * it's not necessarily trustable.
> +     */
> +    if (message) {
> +        /* The caller guarantees the NUL-terminated string. */
> +        len = strlen(message);
> +
> +        printable = len > 0;
> +        for (i = 0; i < len; i++) {
> +            if (!(0x20 <= message[i] && message[i] <= 0x7e)) {
> +                printable = false;
> +                break;
> +            }
> +        }
> +    }
> +
> +    if (!printable && len) {
> +        /* 3 = length of "%02x " */
> +        buf = g_malloc(len * 3);

....allocating memory

> +        for (i = 0; i < len; i++) {
> +            if (message[i] == '\0') {
> +                break;
> +            } else {
> +                sprintf(buf + 3 * i, "%02x ", message[i]);
> +            }
> +        }
> +        if (i > 0)
> +            /* replace the last ' '(space) to NUL */
> +            buf[i * 3 - 1] = '\0';
> +        else
> +            buf[0] = '\0';
> +
> +        return buf;

....returning alllocated memory

> +    }
> +
> +    return message;

....returning a pointer that came from a struct field

> +}

This is a bad design - we should require the caller to always
free memory, or never free memory - not a mix.

> +
>  void qemu_system_guest_panicked(GuestPanicInformation *info)
>  {
>      qemu_log_mask(LOG_GUEST_ERROR, "Guest crashed");
> @@ -606,7 +652,19 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
>                            S390CrashReason_str(info->u.s390.reason),
>                            info->u.s390.psw_mask,
>                            info->u.s390.psw_addr);
> +        } else if (info->type == GUEST_PANIC_INFORMATION_TYPE_TDX) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "\nTDX guest reports fatal error:"
> +                          " error code: 0x%" PRIx32 " error message:\"%s\"\n",
> +                          info->u.tdx.error_code,
> +                          tdx_parse_panic_message(info->u.tdx.message));

This is a leak in the case where tdx_parse_panic_message() returned
allocated memory.

> +            if (info->u.tdx.gpa != -1ull) {
> +                qemu_log_mask(LOG_GUEST_ERROR, "Additional error information "
> +                              "can be found at gpa page: 0x%" PRIx64 "\n",
> +                              info->u.tdx.gpa);
> +            }
>          }
> +
>          qapi_free_GuestPanicInformation(info);
>      }
>  }

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


