Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C8BA28810
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Feb 2025 11:31:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfcgr-0002o4-I5; Wed, 05 Feb 2025 05:31:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tfcgp-0002nn-Qt
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 05:31:28 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tfcgn-0003Gg-L9
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 05:31:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738751486; x=1770287486;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=TNAzw3o/NIZLjRAHMrS5gP30UAJcmwOQbSBj0kcq68w=;
 b=aSDt9ex3aNTparmyB5kQtQmjk9DBZX6exmULOMwR0f26IEydW2aBcjKc
 3jjhMXvsDihQw5oho06ilsXfwfowMeW/XncgUClujxprg1qpre8UD2VXz
 Dcg3Xl7mjw1bNSC9H7hbR5URuWdiL7toNLVG5MmnNr9/TBPfETMb/QYkq
 2Uz45jJ6+K7xdrtmydaMGp4RirfSJZs+l1OAP7uHeTbe+ABg9hUhTfj2f
 /M3101edakpKgunIIgSG+B2ylimOp2bFNzugunuoZdP99qs3RtmBKAgi+
 RtssULu9PLVJfhD6TDR7c4CJqSyqq+aeYA39zVbx2SunXqwEp26n6MSxF g==;
X-CSE-ConnectionGUID: rMfzbkZtQhOcM/6rT11hHg==
X-CSE-MsgGUID: UcAazK+ARQ2jQdpqgFvcZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="39421119"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="39421119"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2025 02:31:22 -0800
X-CSE-ConnectionGUID: ErDfk7sLQgei1uW6dxXz3A==
X-CSE-MsgGUID: p8IvxN+rQd+lLaqYHnzkaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="141757522"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2025 02:31:18 -0800
Message-ID: <ebedb603-ee42-4db6-86b9-edb270970935@intel.com>
Date: Wed, 5 Feb 2025 18:31:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/52] i386/tdx: Validate TD attributes
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
References: <20250124132048.3229049-1-xiaoyao.li@intel.com>
 <20250124132048.3229049-13-xiaoyao.li@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250124132048.3229049-13-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 1/24/2025 9:20 PM, Xiaoyao Li wrote:
> Validate TD attributes with tdx_caps that only supported bits arer
> allowed by KVM.
> 
> Besides, sanity check the attribute bits that have not been supported by
> QEMU yet. e.g., debug bit, it will be allowed in the future when debug
> TD support lands in QEMU.

This patches got squashed with next one "i386/tdx: Support user 
configurable mrconfigid/mrowner/mrownerconfig" in v6 by accident.

I'll fix it in the next version.

> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
> Changes in v7:
> - Define TDX_SUPPORTED_TD_ATTRS as QEMU supported mask, to validates
>    user's request. (Rick)
> 
> Changes in v3:
> - using error_setg() for error report; (Daniel)
> ---
>   qapi/qom.json         |  16 +++++-
>   target/i386/kvm/tdx.c | 118 +++++++++++++++++++++++++++++++++++++++++-
>   target/i386/kvm/tdx.h |   3 ++
>   3 files changed, 134 insertions(+), 3 deletions(-)
> 
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 8740626c4ee6..a53000ca6fb4 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -1060,11 +1060,25 @@
>   #     pages.  Some guest OS (e.g., Linux TD guest) may require this to
>   #     be set, otherwise they refuse to boot.
>   #
> +# @mrconfigid: ID for non-owner-defined configuration of the guest TD,
> +#     e.g., run-time or OS configuration (base64 encoded SHA384 digest).
> +#     Defaults to all zeros.
> +#
> +# @mrowner: ID for the guest TD’s owner (base64 encoded SHA384 digest).
> +#     Defaults to all zeros.
> +#
> +# @mrownerconfig: ID for owner-defined configuration of the guest TD,
> +#     e.g., specific to the workload rather than the run-time or OS
> +#     (base64 encoded SHA384 digest).  Defaults to all zeros.
> +#
>   # Since: 10.0
>   ##
>   { 'struct': 'TdxGuestProperties',
>     'data': { '*attributes': 'uint64',
> -            '*sept-ve-disable': 'bool' } }
> +            '*sept-ve-disable': 'bool',
> +            '*mrconfigid': 'str',
> +            '*mrowner': 'str',
> +            '*mrownerconfig': 'str' } }
>   
>   ##
>   # @ThreadContextProperties:
> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
> index 653942d83bcb..ed843af1d0b6 100644
> --- a/target/i386/kvm/tdx.c
> +++ b/target/i386/kvm/tdx.c
> @@ -11,17 +11,24 @@
>   
>   #include "qemu/osdep.h"
>   #include "qemu/error-report.h"
> +#include "qemu/base64.h"
>   #include "qapi/error.h"
>   #include "qom/object_interfaces.h"
> +#include "crypto/hash.h"
>   
>   #include "hw/i386/x86.h"
>   #include "kvm_i386.h"
>   #include "tdx.h"
>   
> +#define TDX_TD_ATTRIBUTES_DEBUG             BIT_ULL(0)
>   #define TDX_TD_ATTRIBUTES_SEPT_VE_DISABLE   BIT_ULL(28)
>   #define TDX_TD_ATTRIBUTES_PKS               BIT_ULL(30)
>   #define TDX_TD_ATTRIBUTES_PERFMON           BIT_ULL(63)
>   
> +#define TDX_SUPPORTED_TD_ATTRS  (TDX_TD_ATTRIBUTES_SEPT_VE_DISABLE |\
> +                                 TDX_TD_ATTRIBUTES_PKS | \
> +                                 TDX_TD_ATTRIBUTES_PERFMON)
> +
>   static TdxGuest *tdx_guest;
>   
>   static struct kvm_tdx_capabilities *tdx_caps;
> @@ -153,13 +160,33 @@ static int tdx_kvm_type(X86ConfidentialGuest *cg)
>       return KVM_X86_TDX_VM;
>   }
>   
> -static void setup_td_guest_attributes(X86CPU *x86cpu)
> +static int tdx_validate_attributes(TdxGuest *tdx, Error **errp)
> +{
> +    if ((tdx->attributes & ~tdx_caps->supported_attrs)) {
> +        error_setg(errp, "Invalid attributes 0x%lx for TDX VM "
> +                   "(KVM supported: 0x%llx)", tdx->attributes,
> +                   tdx_caps->supported_attrs);
> +        return -1;
> +    }
> +
> +    if (tdx->attributes & ~TDX_SUPPORTED_TD_ATTRS) {
> +        warn_report("Some QEMU unsupported TD attribute bits being requested:"
> +                    "requested: 0x%lx QEMU supported: 0x%llx",
> +                    tdx->attributes, TDX_SUPPORTED_TD_ATTRS);
> +    }
> +
> +    return 0;
> +}
> +
> +static int setup_td_guest_attributes(X86CPU *x86cpu, Error **errp)
>   {
>       CPUX86State *env = &x86cpu->env;
>   
>       tdx_guest->attributes |= (env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_PKS) ?
>                                TDX_TD_ATTRIBUTES_PKS : 0;
>       tdx_guest->attributes |= x86cpu->enable_pmu ? TDX_TD_ATTRIBUTES_PERFMON : 0;
> +
> +    return tdx_validate_attributes(tdx_guest, errp);
>   }
>   
>   static int setup_td_xfam(X86CPU *x86cpu, Error **errp)
> @@ -214,6 +241,7 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
>       CPUX86State *env = &x86cpu->env;
>       g_autofree struct kvm_tdx_init_vm *init_vm = NULL;
>       Error *local_err = NULL;
> +    size_t data_len;
>       int retry = 10000;
>       int r = 0;
>   
> @@ -225,7 +253,40 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
>       init_vm = g_malloc0(sizeof(struct kvm_tdx_init_vm) +
>                           sizeof(struct kvm_cpuid_entry2) * KVM_MAX_CPUID_ENTRIES);
>   
> -    setup_td_guest_attributes(x86cpu);
> +    if (tdx_guest->mrconfigid) {
> +        g_autofree uint8_t *data = qbase64_decode(tdx_guest->mrconfigid,
> +                              strlen(tdx_guest->mrconfigid), &data_len, errp);
> +        if (!data || data_len != QCRYPTO_HASH_DIGEST_LEN_SHA384) {
> +            error_setg(errp, "TDX: failed to decode mrconfigid");
> +            return -1;
> +        }
> +        memcpy(init_vm->mrconfigid, data, data_len);
> +    }
> +
> +    if (tdx_guest->mrowner) {
> +        g_autofree uint8_t *data = qbase64_decode(tdx_guest->mrowner,
> +                              strlen(tdx_guest->mrowner), &data_len, errp);
> +        if (!data || data_len != QCRYPTO_HASH_DIGEST_LEN_SHA384) {
> +            error_setg(errp, "TDX: failed to decode mrowner");
> +            return -1;
> +        }
> +        memcpy(init_vm->mrowner, data, data_len);
> +    }
> +
> +    if (tdx_guest->mrownerconfig) {
> +        g_autofree uint8_t *data = qbase64_decode(tdx_guest->mrownerconfig,
> +                            strlen(tdx_guest->mrownerconfig), &data_len, errp);
> +        if (!data || data_len != QCRYPTO_HASH_DIGEST_LEN_SHA384) {
> +            error_setg(errp, "TDX: failed to decode mrownerconfig");
> +            return -1;
> +        }
> +        memcpy(init_vm->mrownerconfig, data, data_len);
> +    }
> +
> +    r = setup_td_guest_attributes(x86cpu, errp);
> +    if (r) {
> +        return r;
> +    }
>   
>       r = setup_td_xfam(x86cpu, errp);
>       if (r) {
> @@ -283,6 +344,51 @@ static void tdx_guest_set_sept_ve_disable(Object *obj, bool value, Error **errp)
>       }
>   }
>   
> +static char *tdx_guest_get_mrconfigid(Object *obj, Error **errp)
> +{
> +    TdxGuest *tdx = TDX_GUEST(obj);
> +
> +    return g_strdup(tdx->mrconfigid);
> +}
> +
> +static void tdx_guest_set_mrconfigid(Object *obj, const char *value, Error **errp)
> +{
> +    TdxGuest *tdx = TDX_GUEST(obj);
> +
> +    g_free(tdx->mrconfigid);
> +    tdx->mrconfigid = g_strdup(value);
> +}
> +
> +static char *tdx_guest_get_mrowner(Object *obj, Error **errp)
> +{
> +    TdxGuest *tdx = TDX_GUEST(obj);
> +
> +    return g_strdup(tdx->mrowner);
> +}
> +
> +static void tdx_guest_set_mrowner(Object *obj, const char *value, Error **errp)
> +{
> +    TdxGuest *tdx = TDX_GUEST(obj);
> +
> +    g_free(tdx->mrowner);
> +    tdx->mrowner = g_strdup(value);
> +}
> +
> +static char *tdx_guest_get_mrownerconfig(Object *obj, Error **errp)
> +{
> +    TdxGuest *tdx = TDX_GUEST(obj);
> +
> +    return g_strdup(tdx->mrownerconfig);
> +}
> +
> +static void tdx_guest_set_mrownerconfig(Object *obj, const char *value, Error **errp)
> +{
> +    TdxGuest *tdx = TDX_GUEST(obj);
> +
> +    g_free(tdx->mrownerconfig);
> +    tdx->mrownerconfig = g_strdup(value);
> +}
> +
>   /* tdx guest */
>   OBJECT_DEFINE_TYPE_WITH_INTERFACES(TdxGuest,
>                                      tdx_guest,
> @@ -306,6 +412,14 @@ static void tdx_guest_init(Object *obj)
>       object_property_add_bool(obj, "sept-ve-disable",
>                                tdx_guest_get_sept_ve_disable,
>                                tdx_guest_set_sept_ve_disable);
> +    object_property_add_str(obj, "mrconfigid",
> +                            tdx_guest_get_mrconfigid,
> +                            tdx_guest_set_mrconfigid);
> +    object_property_add_str(obj, "mrowner",
> +                            tdx_guest_get_mrowner, tdx_guest_set_mrowner);
> +    object_property_add_str(obj, "mrownerconfig",
> +                            tdx_guest_get_mrownerconfig,
> +                            tdx_guest_set_mrownerconfig);
>   }
>   
>   static void tdx_guest_finalize(Object *obj)
> diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
> index 4e2b5c61ff5b..e472b11fb0dd 100644
> --- a/target/i386/kvm/tdx.h
> +++ b/target/i386/kvm/tdx.h
> @@ -24,6 +24,9 @@ typedef struct TdxGuest {
>       bool initialized;
>       uint64_t attributes;    /* TD attributes */
>       uint64_t xfam;
> +    char *mrconfigid;       /* base64 encoded sha348 digest */
> +    char *mrowner;          /* base64 encoded sha348 digest */
> +    char *mrownerconfig;    /* base64 encoded sha348 digest */
>   } TdxGuest;
>   
>   #ifdef CONFIG_TDX


