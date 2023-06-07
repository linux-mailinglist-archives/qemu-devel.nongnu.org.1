Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3E772634E
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 16:51:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6uVI-0001vi-4p; Wed, 07 Jun 2023 10:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q6uVF-0001vK-M9
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:51:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q6uVD-0000Zp-S8
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686149471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U2I0jeMBOrgT0zMr71O8iP3OSpJ186q6wRc+U8r0BfE=;
 b=JaPH/NDZ0MZNljjLHd2pEvteatfMg0dUCkAm8zoGJvy/Wa1S01/RdDkLq9QVXB13aDd3N/
 Tous8mmDUzAt2cB+3zO7IJt6p5rlub+pI3/cMcpyxeQPhLOnG8Cwou9wbmEne8aXo2asYb
 EY16/9EFEkVTUPqyfZNZA0vw/1m8Jps=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-wu0v_cQKPQimrXqXn3D5Hw-1; Wed, 07 Jun 2023 10:51:09 -0400
X-MC-Unique: wu0v_cQKPQimrXqXn3D5Hw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-94a35b0d4ceso573516666b.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 07:51:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686149468; x=1688741468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U2I0jeMBOrgT0zMr71O8iP3OSpJ186q6wRc+U8r0BfE=;
 b=dLmw9hcIlaBdYQYrEkKC/GnwmPFmjXzS4C8FJgpOkAkF0fl+M6HY1Bq5ziJlCa0gR1
 DnzWCKawi088A/PlCFjdqu5fECv44oZkiz9hZaXHdR9EG1Vr2V9N1hW9OH+9N8yM3460
 z64DGrJ6tlbfgF8z892HJ3VJHLCRWpjUg3bLBJp5bGRdDDFPDBThFcsJ47+CeXROQANI
 aC7XcaypmISAwI2cPyn4E7O/35VIPH0vqQCa0X+y+dlHyW2xazdTq9Ybr6b2hmCZa8xr
 x/2XqmB12MkuHNM79HMS2BgXdA7AprPZSazsrxaKopMoj5ma6aNJlBKFjZXnl0bD5h2I
 vIhA==
X-Gm-Message-State: AC+VfDxIz8/3Yt2DEeGM9MOROOa2MgUdVTXRtj0B9ckZKGuMZDauEmZ3
 Pjic/ASR+fr2CKDE1Jdctaclqkn3aA2LrwStt48n4bZlcwEaFsT/6EueMH9ssvoSIccHZYV2l8X
 Dd6TTE5TBpqK6T+Y=
X-Received: by 2002:a17:906:58d4:b0:969:f433:9b54 with SMTP id
 e20-20020a17090658d400b00969f4339b54mr6302871ejs.39.1686149468690; 
 Wed, 07 Jun 2023 07:51:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4OyAMDMbLm71wtjqZey3xENAs29wnbT2ZKk3BqALY0vYR/kpKDisHak3sDOD0QNP8augPR+g==
X-Received: by 2002:a17:906:58d4:b0:969:f433:9b54 with SMTP id
 e20-20020a17090658d400b00969f4339b54mr6302848ejs.39.1686149468335; 
 Wed, 07 Jun 2023 07:51:08 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 b13-20020a17090636cd00b00977eec5bb2csm3112545ejc.156.2023.06.07.07.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 07:51:07 -0700 (PDT)
Date: Wed, 7 Jun 2023 16:51:07 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>, Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [PATCH v2 3/3] hw/smbios: Fix core count in type4
Message-ID: <20230607165107.76b18fe0@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230601092952.1114727-4-zhao1.liu@linux.intel.com>
References: <20230601092952.1114727-1-zhao1.liu@linux.intel.com>
 <20230601092952.1114727-4-zhao1.liu@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu,  1 Jun 2023 17:29:52 +0800
Zhao Liu <zhao1.liu@linux.intel.com> wrote:

> From: Zhao Liu <zhao1.liu@intel.com>
> 
> From SMBIOS 3.0 specification, core count field means:
> 
> Core Count is the number of cores detected by the BIOS for this
> processor socket. [1]
> 
> Before 003f230e37d7 ("machine: Tweak the order of topology members in
> struct CpuTopology"), MachineState.smp.cores means "the number of cores
> in one package", and it's correct to use smp.cores for core count.
> 
> But 003f230e37d7 changes the smp.cores' meaning to "the number of cores
> in one die" and doesn't change the original smp.cores' use in smbios as
> well, which makes core count in type4 go wrong.
> 
> Fix this issue with the correct "cores per socket" caculation.

see comment on 2/3 patch and do the same for cores.

> 
> [1] SMBIOS 3.0.0, section 7.5.6, Processor Information - Core Count
> 
> Fixes: 003f230e37d7 ("machine: Tweak the order of topology members in struct CpuTopology")
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> Changes since v1:
>  * Calculate cores_per_socket in a different way from
>    threads_per_socket.
>  * Add the sanity check to ensure consistency of results between these 2
>    ways. This can help not miss any future change of cpu topology.
> ---
>  hw/smbios/smbios.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index faf82d4ae646..2b46a51dfcad 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -714,6 +714,7 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
>      char sock_str[128];
>      size_t tbl_len = SMBIOS_TYPE_4_LEN_V28;
>      unsigned threads_per_socket;
> +    unsigned cores_per_socket;
>  
>      if (smbios_ep_type == SMBIOS_ENTRY_POINT_TYPE_64) {
>          tbl_len = SMBIOS_TYPE_4_LEN_V30;
> @@ -750,8 +751,16 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
>  
>      /* smp.max_cpus is the total number of threads for the system. */
>      threads_per_socket = ms->smp.max_cpus / ms->smp.sockets;
> +    cores_per_socket = ms->smp.cores * ms->smp.clusters * ms->smp.dies;
>  
> -    t->core_count = (ms->smp.cores > 255) ? 0xFF : ms->smp.cores;
> +    /*
> +     * Currently, max_cpus = threads * cores * clusters * dies * sockets.
> +     * threads_per_socket and cores_per_socket are calculated in 2 ways so
> +     * that this sanity check ensures we won't miss any topology level.
> +     */
> +    g_assert(cores_per_socket == (threads_per_socket / ms->smp.threads));
> +
> +    t->core_count = (cores_per_socket > 255) ? 0xFF : cores_per_socket;
>      t->core_enabled = t->core_count;
>  
>      t->thread_count = (threads_per_socket > 255) ? 0xFF : threads_per_socket;
> @@ -760,7 +769,7 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
>      t->processor_family2 = cpu_to_le16(0x01); /* Other */
>  
>      if (tbl_len == SMBIOS_TYPE_4_LEN_V30) {
> -        t->core_count2 = t->core_enabled2 = cpu_to_le16(ms->smp.cores);
> +        t->core_count2 = t->core_enabled2 = cpu_to_le16(cores_per_socket);
>          t->thread_count2 = cpu_to_le16(threads_per_socket);
>      }
>  


