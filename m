Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE39A9C3C8
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Apr 2025 11:35:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8FRp-0007ya-00; Fri, 25 Apr 2025 05:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u8FRi-0007xU-KG
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 05:34:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u8FRe-0008Na-Dx
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 05:34:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745573644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=heIK4dtLDWKuBOV9s/guG+3EGpvKAfEAdYxCwW1eUwM=;
 b=QP3qO0MmdTAws/r8IAlFLtIg5CrAcfqVKtq1yXOPypFKm3hUEC8csXqMQ9iQpiGDBEAfQL
 PRTKy8fB7FnMsLEAYILCWcwBp4fSMbZivwykO9eCWCtvxkB7QCIyZulAqhkpPwBUZRzPxI
 7eZt80r9k+9QkF69xt96Ed8g32Y6XTA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-3XThmz3yNEm8YvQ8Ryr_DQ-1; Fri,
 25 Apr 2025 05:34:01 -0400
X-MC-Unique: 3XThmz3yNEm8YvQ8Ryr_DQ-1
X-Mimecast-MFC-AGG-ID: 3XThmz3yNEm8YvQ8Ryr_DQ_1745573639
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 13B941956095; Fri, 25 Apr 2025 09:33:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D5F0180047F; Fri, 25 Apr 2025 09:33:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7BD0121E66C3; Fri, 25 Apr 2025 11:33:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  Eric Blake <eblake@redhat.com>,
 Michael Roth <michael.roth@amd.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,  Marcelo
 Tosatti <mtosatti@redhat.com>,  Shaoqin Huang <shahuang@redhat.com>,  Eric
 Auger <eauger@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,  Thomas Huth <thuth@redhat.com>,
 Sebastian Ott <sebott@redhat.com>,  Gavin Shan <gshan@redhat.com>,
 qemu-devel@nongnu.org,  kvm@vger.kernel.org,  qemu-arm@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>,  Yi Lai <yi1.lai@intel.com>
Subject: Re: [PATCH 3/5] i386/kvm: Support event with select & umask format
 in KVM PMU filter
In-Reply-To: <20250409082649.14733-4-zhao1.liu@intel.com> (Zhao Liu's message
 of "Wed, 9 Apr 2025 16:26:47 +0800")
References: <20250409082649.14733-1-zhao1.liu@intel.com>
 <20250409082649.14733-4-zhao1.liu@intel.com>
Date: Fri, 25 Apr 2025 11:33:54 +0200
Message-ID: <87frhwfuv1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Zhao Liu <zhao1.liu@intel.com> writes:

> The select&umask is the common way for x86 to identify the PMU event,
> so support this way as the "x86-default" format in kvm-pmu-filter
> object.
>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> Tested-by: Yi Lai <yi1.lai@intel.com>
> ---
> Changes since RFC v2:
>  * Drop hexadecimal variants and support numeric version in QAPI
>    directly. (Daniel)
>  * Rename "x86-default" format to "x86-select-umask". (Markus)
>  * Add Tested-by from Yi.
>  * Add documentation in qemu-options.hx.
>  * QAPI style fix:
>    - KVMPMU* stuff -> KvmPmu*.
>  * Bump up the supported QAPI version to v10.1.
>
> Changes since RFC v1:
>  * Bump up the supported QAPI version to v10.0.
> ---
>  accel/kvm/kvm-pmu.c      | 20 +++++++++++++++++++-
>  include/system/kvm-pmu.h | 13 +++++++++++++
>  qapi/kvm.json            | 21 +++++++++++++++++++--
>  qemu-options.hx          |  3 +++
>  target/i386/kvm/kvm.c    |  5 +++++
>  5 files changed, 59 insertions(+), 3 deletions(-)
>
> diff --git a/accel/kvm/kvm-pmu.c b/accel/kvm/kvm-pmu.c
> index 22f749bf9183..fa73ef428e59 100644
> --- a/accel/kvm/kvm-pmu.c
> +++ b/accel/kvm/kvm-pmu.c
> @@ -16,6 +16,8 @@
>  #include "qom/object_interfaces.h"
>  #include "system/kvm-pmu.h"
>  
> +#define UINT12_MAX (4095)
> +
>  static void kvm_pmu_filter_set_action(Object *obj, int value,
>                                        Error **errp G_GNUC_UNUSED)
>  {
> @@ -53,9 +55,22 @@ static void kvm_pmu_filter_set_event(Object *obj, Visitor *v, const char *name,
>      }
>  
>      for (node = head; node; node = node->next) {
> -        switch (node->value->format) {
> +        KvmPmuFilterEvent *event = node->value;
> +
> +        switch (event->format) {
>          case KVM_PMU_EVENT_FORMAT_RAW:
>              break;
> +        case KVM_PMU_EVENT_FORMAT_X86_SELECT_UMASK: {
> +            if (event->u.x86_select_umask.select > UINT12_MAX) {
> +                error_setg(errp,
> +                           "Parameter 'select' out of range (%d).",
> +                           UINT12_MAX);
> +                goto fail;
> +            }
> +
> +            /* No need to check the range of umask since it's uint8_t. */
> +            break;
> +        }

As we'll see below, the new x86-specific format is defined in the QAPI
schema regardless of target.

It is accepted here also regardless of target.  Doesn't matter much
right now, as the object is effectively useless for targets other than
x86, but I understand that will change.

Should we reject it unless the target is x86?

If not, I feel the behavior should be noted in the commit message.

>          default:
>              g_assert_not_reached();
>          }
> @@ -67,6 +82,9 @@ static void kvm_pmu_filter_set_event(Object *obj, Visitor *v, const char *name,
>      filter->events = head;
>      qapi_free_KvmPmuFilterEventList(old_head);
>      return;
> +
> +fail:
> +    qapi_free_KvmPmuFilterEventList(head);
>  }
>  
>  static void kvm_pmu_filter_class_init(ObjectClass *oc, void *data)
> diff --git a/include/system/kvm-pmu.h b/include/system/kvm-pmu.h
> index 818fa309c191..6abc0d037aee 100644
> --- a/include/system/kvm-pmu.h
> +++ b/include/system/kvm-pmu.h
> @@ -32,4 +32,17 @@ struct KVMPMUFilter {
>      KvmPmuFilterEventList *events;
>  };
>  
> +/*
> + * Stolen from Linux kernel (RAW_EVENT at tools/testing/selftests/kvm/include/
> + * x86_64/pmu.h).
> + *
> + * Encode an eventsel+umask pair into event-select MSR format.  Note, this is
> + * technically AMD's format, as Intel's format only supports 8 bits for the
> + * event selector, i.e. doesn't use bits 24:16 for the selector.  But, OR-ing
> + * in '0' is a nop and won't clobber the CMASK.
> + */
> +#define X86_PMU_RAW_EVENT(eventsel, umask) (((eventsel & 0xf00UL) << 24) | \
> +                                            ((eventsel) & 0xff) | \
> +                                            ((umask) & 0xff) << 8)
> +
>  #endif /* KVM_PMU_H */
> diff --git a/qapi/kvm.json b/qapi/kvm.json
> index 1861d86a9726..cb151ca82e5c 100644
> --- a/qapi/kvm.json
> +++ b/qapi/kvm.json
> @@ -36,10 +36,12 @@
>  #
>  # @raw: the encoded event code that KVM can directly consume.
>  #
> +# @x86-select-umask: standard x86 encoding format with select and umask.
> +#
>  # Since 10.1
>  ##
>  { 'enum': 'KvmPmuEventFormat',
> -  'data': ['raw'] }
> +  'data': ['raw', 'x86-select-umask'] }
>  
>  ##
>  # @KvmPmuRawEvent:
> @@ -54,6 +56,20 @@
>  { 'struct': 'KvmPmuRawEvent',
>    'data': { 'code': 'uint64' } }
>  
> +##
> +# @KvmPmuX86SelectUmaskEvent:
> +#
> +# @select: x86 PMU event select field, which is a 12-bit unsigned
> +#     number.
> +#
> +# @umask: x86 PMU event umask field.
> +#
> +# Since 10.1
> +##
> +{ 'struct': 'KvmPmuX86SelectUmaskEvent',
> +  'data': { 'select': 'uint16',
> +            'umask': 'uint8' } }
> +
>  ##
>  # @KvmPmuFilterEvent:
>  #
> @@ -66,7 +82,8 @@
>  { 'union': 'KvmPmuFilterEvent',
>    'base': { 'format': 'KvmPmuEventFormat' },
>    'discriminator': 'format',
> -  'data': { 'raw': 'KvmPmuRawEvent' } }
> +  'data': { 'raw': 'KvmPmuRawEvent',
> +            'x86-select-umask': 'KvmPmuX86SelectUmaskEvent' } }
>  
>  ##
>  # @KvmPmuFilterProperties:

Documentation could perhaps be more explicit about this making sense
only for x86.

> diff --git a/qemu-options.hx b/qemu-options.hx
> index 51a7c61ce0b0..5dcce067d8dd 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -6180,6 +6180,9 @@ SRST
>               ((select) & 0xff) | \
>               ((umask) & 0xff) << 8)
>  
> +        ``{"format":"x86-select-umask","select":event_select,"umask":event_umask}``
> +            Specify the single x86 PMU event with select and umask fields.
> +
>          An example KVM PMU filter object would look like:
>  
>          .. parsed-literal::
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index fa3a696654cb..0d36ccf250ed 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -5974,6 +5974,10 @@ static bool kvm_config_pmu_event(KVMPMUFilter *filter,
>          case KVM_PMU_EVENT_FORMAT_RAW:
>              code = event->u.raw.code;
>              break;
> +        case KVM_PMU_EVENT_FORMAT_X86_SELECT_UMASK:
> +            code = X86_PMU_RAW_EVENT(event->u.x86_select_umask.select,
> +                                     event->u.x86_select_umask.umask);
> +            break;
>          default:
>              g_assert_not_reached();
>          }
> @@ -6644,6 +6648,7 @@ static void kvm_arch_check_pmu_filter(const Object *obj, const char *name,
>  
>          switch (event->format) {
>          case KVM_PMU_EVENT_FORMAT_RAW:
> +        case KVM_PMU_EVENT_FORMAT_X86_SELECT_UMASK:
>              break;
>          default:
>              error_setg(errp,


