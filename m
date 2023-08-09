Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F14F775B48
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 13:16:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTh9A-00051R-9f; Wed, 09 Aug 2023 07:14:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qTh98-00051D-Ea
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 07:14:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qTh96-0000BQ-Ak
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 07:14:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691579670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IjUNeBONuhH1OoRQREkcLTbBvQRJgaEdnLzQOAx1WWQ=;
 b=dMzaW9Z2/EmMD1s6l+VikMcQeWcnrrKM74VtG25D32bUa4pqbMLxUZO4Xh4u46t/eg+2UA
 0+nAkOowADBs3nhSJZjDll8GP0ihyNrDHOf+8ZYfiamN2j/3UV2wrLdJus/uBonViIorXs
 qKN98V4IS9E0vjbxiVVQqsLJJ+jzG+Y=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-rnrILni2PDiUTWRE5PnqjQ-1; Wed, 09 Aug 2023 07:14:29 -0400
X-MC-Unique: rnrILni2PDiUTWRE5PnqjQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-99cc5d18f78so286768566b.3
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 04:14:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691579668; x=1692184468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IjUNeBONuhH1OoRQREkcLTbBvQRJgaEdnLzQOAx1WWQ=;
 b=IZ+ib3vhEgIJ5WudAwzQVYnA6gGayuhImpBLHcE+tcvO45ZO3Oh0g97PEiuWqGq4iu
 +8+IJIVhycQfKuEk/hQbSfPuhn6UMNYM62qo1umyfMN9m0nkUdyV/dxcEimMsPvolR6Q
 mvDSIrSXVOwzK8n77TI5ET9uRUnG0HTPjL6Fftr4M1v9UTu8flEr3C5bv7qNAGzMpsyq
 sY3SZvJ1abfbqXpgS6/m1WJ4IZSkQe6qtbfKK/y25tCk9HZ8QD2Kn+2mFNu37a8pgIhv
 NQTSkLgMtTtYFTbJOgcu6RyQu6668tNagnaP8pEZ+76LdsTZAJRUQC8zEYsOeqoQJqSr
 2mtA==
X-Gm-Message-State: AOJu0YyOynpskGC86mAhjRVktPJBR1oS3xOl+8+f300L0kWkvpdO1+qE
 36pL2I77hE7vjzgOAU/JC2tnRC2MZb9psex5G1r6Oikg/SgftYtluH/swaEZib6FFMdM+VMsqIq
 61nxous3rV7UBgfE=
X-Received: by 2002:a17:906:5daa:b0:97d:ee82:920a with SMTP id
 n10-20020a1709065daa00b0097dee82920amr1599489ejv.74.1691579667939; 
 Wed, 09 Aug 2023 04:14:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHm9LTO701paDB9rfPYsvS6PHt3khl1sUHeNvkpWJjRMEPtzZAl7WHVLiJiRwN2q3p9hPlfEQ==
X-Received: by 2002:a17:906:5daa:b0:97d:ee82:920a with SMTP id
 n10-20020a1709065daa00b0097dee82920amr1599479ejv.74.1691579667694; 
 Wed, 09 Aug 2023 04:14:27 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 qo2-20020a170907212200b0099364d9f0e2sm7862910ejb.98.2023.08.09.04.14.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Aug 2023 04:14:27 -0700 (PDT)
Date: Wed, 9 Aug 2023 13:14:26 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Qian Wen <qian.wen@intel.com>
Cc: qemu-devel@nongnu.org, xiaoyao.li@intel.com, zhao1.liu@intel.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, babu.moger@amd.com
Subject: Re: [PATCH v2] target/i386: Avoid cpu number overflow in legacy
 topology
Message-ID: <20230809131426.1d9f5821@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230809102732.3124908-1-qian.wen@intel.com>
References: <20230809102732.3124908-1-qian.wen@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed,  9 Aug 2023 18:27:32 +0800
Qian Wen <qian.wen@intel.com> wrote:

> The legacy topology enumerated by CPUID.1.EBX[23:16] is defined in SDM
> Vol2:
> 
> Bits 23-16: Maximum number of addressable IDs for logical processors in
> this physical package.
> 
> When launching the VM with -smp 256, the value written to EBX[23:16] is
> 0 because of data overflow. If the guest only supports legacy topology,
> without V2 Extended Topology enumerated by CPUID.0x1f or Extended
> Topology enumerated by CPUID.0x0b to support over 255 CPUs, the return
> of the kernel invoking cpu_smt_allowed() is false and AP's bring-up will
> fail. Then only CPU 0 is online, and others are offline.
> 
> To avoid this issue caused by overflow, limit the max value written to
> EBX[23:16] to 255.

what happens on real hw or in lack of thereof what SDM says about this
value when there is more than 255 threads?.


> Signed-off-by: Qian Wen <qian.wen@intel.com>
> ---
> Changes v1 -> v2:
>  - Revise the commit message and comment to more clearer.
>  - Rebased to v8.1.0-rc2.
> ---
>  target/i386/cpu.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 97ad229d8b..6e1d88fbd7 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6008,6 +6008,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>      uint32_t die_offset;
>      uint32_t limit;
>      uint32_t signature[3];
> +    uint32_t threads_per_socket;
>      X86CPUTopoInfo topo_info;
>  
>      topo_info.dies_per_pkg = env->nr_dies;
> @@ -6049,8 +6050,19 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>              *ecx |= CPUID_EXT_OSXSAVE;
>          }
>          *edx = env->features[FEAT_1_EDX];
> -        if (cs->nr_cores * cs->nr_threads > 1) {
> -            *ebx |= (cs->nr_cores * cs->nr_threads) << 16;
> +        /*
> +         * Only bits [23:16] represent the maximum number of addressable
> +         * IDs for logical processors in this physical package.
> +         * When thread_per_socket > 255, it will 1) overwrite bits[31:24]
> +         * which is apic_id, 2) bits [23:16] get truncated.
> +         */
> +        threads_per_socket = cs->nr_cores * cs->nr_threads;
> +        if (threads_per_socket > 255) {
> +            threads_per_socket = 255;
> +        }
> +
> +        if (threads_per_socket > 1) {
> +            *ebx |= threads_per_socket << 16;
>              *edx |= CPUID_HT;
>          }
>          if (!cpu->enable_pmu) {


