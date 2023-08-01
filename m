Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EA576B62A
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 15:46:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQpgM-0002dD-KT; Tue, 01 Aug 2023 09:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qQpgK-0002cI-Qq
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 09:45:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qQpgI-0006mU-R7
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 09:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690897498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oR9dfhjvFij6cBEUrhg6rg/3iZt+GZhDHHGXAEzUU1Y=;
 b=e8DWMfmDeDub0k0oMyVSSWSXzP7qoPgWhErBROv1b7qxPW6dZ1o6F8RQjCsh/Z38uN8Nxd
 UXc3JeBBg90ofuzoj3ZJcczsWrDTNy+pCCC9ms6Pyi0fJ6BnQMo0vRWeLg6jwVU9366Eqp
 P3Z60p9lSO79LYl8KopTxwpYhhjwQio=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-425-vfsyGM8qNAOs7GGpUzmUlA-1; Tue, 01 Aug 2023 09:44:53 -0400
X-MC-Unique: vfsyGM8qNAOs7GGpUzmUlA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D80ED1C0759B;
 Tue,  1 Aug 2023 13:44:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 93ADC492B01;
 Tue,  1 Aug 2023 13:44:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8990D21E692A; Tue,  1 Aug 2023 15:44:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Dinah Baum <dinahbaum123@gmail.com>
Cc: qemu-devel@nongnu.org,  Eduardo Habkost <eduardo@habkost.net>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  Yanan Wang <wangyanan55@huawei.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Eric Blake <eblake@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  David Hildenbrand <david@redhat.com>,  Ilya
 Leoshkevich <iii@linux.ibm.com>,  Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs),  qemu-s390x@nongnu.org
 (open list:S390 TCG CPUs)
Subject: Re: [PATCH v3 2/3] qapi, target/: Enable
 'query-cpu-model-expansion' on all architectures
References: <20230730064057.357598-1-dinahbaum123@gmail.com>
 <20230730064057.357598-3-dinahbaum123@gmail.com>
Date: Tue, 01 Aug 2023 15:44:51 +0200
In-Reply-To: <20230730064057.357598-3-dinahbaum123@gmail.com> (Dinah Baum's
 message of "Sun, 30 Jul 2023 02:40:56 -0400")
Message-ID: <877cqezxkc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Dinah Baum <dinahbaum123@gmail.com> writes:

> Only architectures that implement the command will return
> results, others will return an error message as before.

A brief explanation why this is useful would be nice.

>
> Signed-off-by: Dinah Baum <dinahbaum123@gmail.com>
> ---
>  cpu.c                            | 20 +++++++++++
>  include/exec/cpu-common.h        |  7 ++++
>  qapi/machine-target.json         | 60 --------------------------------
>  qapi/machine.json                | 53 ++++++++++++++++++++++++++++
>  target/arm/arm-qmp-cmds.c        |  7 ++--
>  target/arm/cpu.h                 |  7 ++++
>  target/i386/cpu-sysemu.c         |  7 ++--
>  target/i386/cpu.h                |  6 ++++
>  target/s390x/cpu.h               |  7 ++++
>  target/s390x/cpu_models_sysemu.c |  6 ++--
>  10 files changed, 110 insertions(+), 70 deletions(-)
>
> diff --git a/cpu.c b/cpu.c
> index 1c948d1161..a99d09cd47 100644
> --- a/cpu.c
> +++ b/cpu.c
> @@ -292,6 +292,26 @@ void list_cpus(void)
>  #endif
>  }
>  
> +CpuModelExpansionInfo *get_cpu_model_expansion_info(CpuModelExpansionType type,
> +                                                    CpuModelInfo *model,
> +                                                    Error **errp)
> +{
> +    /* XXX: implement cpu_model_expansion for targets that still miss it */
> +#if defined(cpu_model_expansion)
> +    return cpu_model_expansion(type, model, errp);
> +#else
> +    error_setg(errp, "Could not query cpu model information");
> +    return NULL;
> +#endif
> +}

This is vague enough to leave the user wondering what could be done to
avoid this error and by whom.

Before the patch, it's clear enough: "The command
query-cpu-model-expansion has not been found".

You could go with something like "command not supported for this
target".

The error class changes from CommandNotFound to GenericError.  Please
verify libvirt is fine with that.

> +
> +CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
> +                                                     CpuModelInfo *model,
> +                                                     Error **errp)
> +{
> +    return get_cpu_model_expansion_info(type, model, errp);
> +}
> +

Why do you need qmp_query_cpu_model_expansion() to become a wrapper
around the real function?

>  #if defined(CONFIG_USER_ONLY)
>  void tb_invalidate_phys_addr(hwaddr addr)
>  {
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 87dc9a752c..653f8a9d2b 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -6,6 +6,7 @@
>  #ifndef CONFIG_USER_ONLY
>  #include "exec/hwaddr.h"
>  #endif
> +#include "qapi/qapi-commands-machine.h"
>  
>  /**
>   * vaddr:
> @@ -167,4 +168,10 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
>  /* vl.c */
>  void list_cpus(void);
>  
> +CpuModelExpansionInfo *get_cpu_model_expansion_info(CpuModelExpansionType type,
> +                                                    CpuModelInfo *model,
> +                                                    Error **errp);
> +void list_cpu_model_expansion(CpuModelExpansionType type,
> +                              CpuModelInfo *model, Error **errp);
> +

The declaration of list_cpu_model_expansion() belongs to the next patch.

>  #endif /* CPU_COMMON_H */
> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
> index 3ee2f7ca6b..a658b1754b 100644
> --- a/qapi/machine-target.json
> +++ b/qapi/machine-target.json
> @@ -139,66 +139,6 @@
>    'returns': 'CpuModelBaselineInfo',
>    'if': 'TARGET_S390X' }
>  
> -##
> -# @CpuModelExpansionInfo:
> -#
> -# The result of a cpu model expansion.
> -#
> -# @model: the expanded CpuModelInfo.
> -#
> -# Since: 2.8
> -##
> -{ 'struct': 'CpuModelExpansionInfo',
> -  'data': { 'model': 'CpuModelInfo' },
> -  'if': { 'any': [ 'TARGET_S390X',
> -                   'TARGET_I386',
> -                   'TARGET_ARM' ] } }
> -
> -##
> -# @query-cpu-model-expansion:
> -#
> -# Expands a given CPU model (or a combination of CPU model +
> -# additional options) to different granularities, allowing tooling to
> -# get an understanding what a specific CPU model looks like in QEMU
> -# under a certain configuration.
> -#
> -# This interface can be used to query the "host" CPU model.
> -#
> -# The data returned by this command may be affected by:
> -#
> -# * QEMU version: CPU models may look different depending on the QEMU
> -#   version.  (Except for CPU models reported as "static" in
> -#   query-cpu-definitions.)
> -# * machine-type: CPU model may look different depending on the
> -#   machine-type.  (Except for CPU models reported as "static" in
> -#   query-cpu-definitions.)
> -# * machine options (including accelerator): in some architectures,
> -#   CPU models may look different depending on machine and accelerator
> -#   options.  (Except for CPU models reported as "static" in
> -#   query-cpu-definitions.)
> -# * "-cpu" arguments and global properties: arguments to the -cpu
> -#   option and global properties may affect expansion of CPU models.
> -#   Using query-cpu-model-expansion while using these is not advised.
> -#
> -# Some architectures may not support all expansion types.  s390x
> -# supports "full" and "static". Arm only supports "full".
> -#
> -# Returns: a CpuModelExpansionInfo.  Returns an error if expanding CPU
> -#     models is not supported, if the model cannot be expanded, if the
> -#     model contains an unknown CPU definition name, unknown
> -#     properties or properties with a wrong type.  Also returns an
> -#     error if an expansion type is not supported.
> -#
> -# Since: 2.8
> -##
> -{ 'command': 'query-cpu-model-expansion',
> -  'data': { 'type': 'CpuModelExpansionType',
> -            'model': 'CpuModelInfo' },
> -  'returns': 'CpuModelExpansionInfo',
> -  'if': { 'any': [ 'TARGET_S390X',
> -                   'TARGET_I386',
> -                   'TARGET_ARM' ] } }
> -
>  ##
>  # @CpuDefinitionInfo:
>  #
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 192c781310..f24e19815e 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1768,3 +1768,56 @@
>  ##
>  { 'enum': 'CpuModelCompareResult',
>    'data': [ 'incompatible', 'identical', 'superset', 'subset' ] }
> +
> +##
> +# @CpuModelExpansionInfo:
> +#
> +# The result of a cpu model expansion.
> +#
> +# @model: the expanded CpuModelInfo.
> +#
> +# Since: 2.8
> +##
> +{ 'struct': 'CpuModelExpansionInfo',
> +  'data': { 'model': 'CpuModelInfo' }}
> +
> +##
> +# @query-cpu-model-expansion:
> +#
> +# Expands a given CPU model (or a combination of CPU model +
> +# additional options) to different granularities, allowing tooling to
> +# get an understanding what a specific CPU model looks like in QEMU
> +# under a certain configuration.
> +#
> +# This interface can be used to query the "host" CPU model.
> +#
> +# The data returned by this command may be affected by:
> +#
> +# * QEMU version: CPU models may look different depending on the QEMU
> +#   version.  (Except for CPU models reported as "static" in
> +#   query-cpu-definitions.)
> +# * machine-type: CPU model may look different depending on the
> +#   machine-type.  (Except for CPU models reported as "static" in
> +#   query-cpu-definitions.)
> +# * machine options (including accelerator): in some architectures,
> +#   CPU models may look different depending on machine and accelerator
> +#   options.  (Except for CPU models reported as "static" in
> +#   query-cpu-definitions.)
> +# * "-cpu" arguments and global properties: arguments to the -cpu
> +#   option and global properties may affect expansion of CPU models.
> +#   Using query-cpu-model-expansion while using these is not advised.
> +#
> +# Some architectures may not support all expansion types.  s390x
> +# supports "full" and "static". Arm only supports "full".
> +#
> +# Returns: a CpuModelExpansionInfo. Returns an error if expanding CPU

Accidental space change, line should remain

   # Returns: a CpuModelExpansionInfo.  Returns an error if expanding CPU

> +#     models is not supported, if the model cannot be expanded, if the
> +#     model contains an unknown CPU definition name, unknown
> +#     properties or properties with a wrong type.  Also returns an
> +#     error if an expansion type is not supported.
> +#
> +# Since: 2.8
> +##
> +{ 'command': 'query-cpu-model-expansion',
> +  'data': { 'type': 'CpuModelExpansionType', 'model': 'CpuModelInfo' },
> +  'returns': 'CpuModelExpansionInfo'}
> diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
> index c8fa524002..295d690e93 100644
> --- a/target/arm/arm-qmp-cmds.c
> +++ b/target/arm/arm-qmp-cmds.c
> @@ -22,6 +22,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "hw/boards.h"
> +#include "cpu.h"
>  #include "kvm_arm.h"
>  #include "qapi/error.h"
>  #include "qapi/visitor.h"
> @@ -99,9 +100,9 @@ static const char *cpu_model_advertised_features[] = {
>      NULL
>  };
>  
> -CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
> -                                                     CpuModelInfo *model,
> -                                                     Error **errp)
> +CpuModelExpansionInfo *get_cpu_model_expansion(CpuModelExpansionType type,
> +                                               CpuModelInfo *model,
> +                                               Error **errp)
>  {
>      CpuModelExpansionInfo *expansion_info;
>      const QDict *qdict_in = NULL;
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 88e5accda6..71b15d4884 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -2740,6 +2740,13 @@ bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync);
>  
>  #define cpu_list arm_cpu_list
>  
> +#ifdef CONFIG_SOFTMMU
> +CpuModelExpansionInfo *get_cpu_model_expansion(CpuModelExpansionType type,
> +                                               CpuModelInfo *model,
> +                                               Error **errp);
> +#define cpu_model_expansion get_cpu_model_expansion

What is this macro for?

> +#endif
> +
>  /* ARM has the following "translation regimes" (as the ARM ARM calls them):
>   *
>   * If EL3 is 64-bit:
> diff --git a/target/i386/cpu-sysemu.c b/target/i386/cpu-sysemu.c
> index 28115edf44..c01c85839c 100644
> --- a/target/i386/cpu-sysemu.c
> +++ b/target/i386/cpu-sysemu.c
> @@ -176,10 +176,9 @@ out:
>      return xc;
>  }
>  
> -CpuModelExpansionInfo *
> -qmp_query_cpu_model_expansion(CpuModelExpansionType type,
> -                                                      CpuModelInfo *model,
> -                                                      Error **errp)
> +CpuModelExpansionInfo *get_cpu_model_expansion(CpuModelExpansionType type,
> +                                               CpuModelInfo *model,
> +                                               Error **errp)
>  {
>      X86CPU *xc = NULL;
>      Error *err = NULL;
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index e0771a1043..699b987d12 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2249,6 +2249,12 @@ uint64_t cpu_get_tsc(CPUX86State *env);
>  #endif
>  
>  #define cpu_list x86_cpu_list
> +#ifdef CONFIG_SOFTMMU
> +CpuModelExpansionInfo *get_cpu_model_expansion(CpuModelExpansionType type,
> +                                               CpuModelInfo *model,
> +                                               Error **errp);
> +#define cpu_model_expansion get_cpu_model_expansion

Likewise.

> +#endif
>  
>  /* MMU modes definitions */
>  #define MMU_KSMAP_IDX   0
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index eb5b65b7d3..932f8b642a 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -804,6 +804,13 @@ static inline uint8_t s390_cpu_get_state(S390CPU *cpu)
>  /* cpu_models.c */
>  void s390_cpu_list(void);
>  #define cpu_list s390_cpu_list
> +#ifdef CONFIG_SOFTMMU
> +CpuModelExpansionInfo *get_cpu_model_expansion(CpuModelExpansionType type,
> +                                               CpuModelInfo *model,
> +                                               Error **errp);
> +#define cpu_model_expansion get_cpu_model_expansion

Likewise.

> +#endif
> +
>  void s390_set_qemu_cpu_model(uint16_t type, uint8_t gen, uint8_t ec_ga,
>                               const S390FeatInit feat_init);
>  
> diff --git a/target/s390x/cpu_models_sysemu.c b/target/s390x/cpu_models_sysemu.c
> index 63981bf36b..ef3845f11c 100644
> --- a/target/s390x/cpu_models_sysemu.c
> +++ b/target/s390x/cpu_models_sysemu.c
> @@ -213,9 +213,9 @@ static void cpu_info_from_model(CpuModelInfo *info, const S390CPUModel *model,
>      }
>  }
>  
> -CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
> -                                                      CpuModelInfo *model,
> -                                                      Error **errp)
> +CpuModelExpansionInfo *get_cpu_model_expansion(CpuModelExpansionType type,
> +                                               CpuModelInfo *model,
> +                                               Error **errp)
>  {
>      Error *err = NULL;
>      CpuModelExpansionInfo *expansion_info = NULL;


