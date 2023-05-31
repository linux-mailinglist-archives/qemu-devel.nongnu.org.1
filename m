Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF4C7186AA
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 17:48:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4O2N-0007jl-Th; Wed, 31 May 2023 11:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q4O2L-0007iq-2s
 for qemu-devel@nongnu.org; Wed, 31 May 2023 11:46:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q4O2I-0003bI-S6
 for qemu-devel@nongnu.org; Wed, 31 May 2023 11:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685548013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zq6Pix1TqInszYAXqZ6/JoAYdKUJG35SCaXU6rF01cg=;
 b=KqNx57/5dXlzSQW4U/lqpvcAIn3JCiYQdUFB07HKBbj87qg9R9Y8tJqYp75J3i0TjzWZp2
 Qd7QkDZ0cahljeqZtEjXDWptscx295zXFua6tS2C/3UzHx3UDMWWOlFJ6nD4UsjnbSv2By
 F8IKYrSnWhDl/MyVyFyky5soWsdGcQ8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-hQRDPwTPMJ6TKrdBQm2Ylg-1; Wed, 31 May 2023 11:46:52 -0400
X-MC-Unique: hQRDPwTPMJ6TKrdBQm2Ylg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-970e0152da7so617617766b.2
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 08:46:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685548009; x=1688140009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zq6Pix1TqInszYAXqZ6/JoAYdKUJG35SCaXU6rF01cg=;
 b=S7RPoYO7/rQqjqvhJeHTP2zcoyumdQuVkPL8T+JzYcO6kn6joLvkyNsCK2iz5oH0Py
 VXEtgCYd+PU77hbcOHMAZmcewXZgrVJtWxFRwfcql6/P4DtIkXd7/BHPtW/cJVtnPSzj
 My87Zn08qPvm338UoiGV4kO2Tp0f/FoS6T+yqYfpymxc8gDVUifv6h8fFxek4HvrR+Z5
 PAnwPTZykLB++09lZUusHKP06iDPXCJbg9Wg+9uy+sVQAOrEQodgVkel4DhrjZvVUgUI
 K+QvplPW7o+qW/IxCQuaYA6pGDj6ksqoWuB/kOV9QKn7MzJHMJstjA83qiDWszpYUtl2
 4Kxw==
X-Gm-Message-State: AC+VfDy7c6YnZ0YGoauuilontoxUWIxZ7dwpKqZk1pgLj94qfLBuHXV5
 EYbbitWnHmA1fhbacZlvmJ/tCEo8VRwVOygnIFWr3u/7YO1K4QcWUXgDdq+uInii4TZQF3tCvqN
 FEHPP18ap5TMBGavKwePE68w=
X-Received: by 2002:a17:907:8a11:b0:96f:9cea:a351 with SMTP id
 sc17-20020a1709078a1100b0096f9ceaa351mr6648542ejc.37.1685548009675; 
 Wed, 31 May 2023 08:46:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7LF4yFp2xnJ2Z5HN1GvX2Y1B3s+1YWQhEDi9+pPBYspib43hgBi8m46I1GVAeKq+jtnRdZSQ==
X-Received: by 2002:a17:907:8a11:b0:96f:9cea:a351 with SMTP id
 sc17-20020a1709078a1100b0096f9ceaa351mr6648532ejc.37.1685548009407; 
 Wed, 31 May 2023 08:46:49 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 a8-20020a1709062b0800b00970f0e2dab2sm9081226ejg.112.2023.05.31.08.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 May 2023 08:46:48 -0700 (PDT)
Date: Wed, 31 May 2023 17:46:48 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>, Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [PATCH 3/3] hw/smbios: Fix core count in type4
Message-ID: <20230531174648.46adda5b@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230529164343.467793-4-zhao1.liu@linux.intel.com>
References: <20230529164343.467793-1-zhao1.liu@linux.intel.com>
 <20230529164343.467793-4-zhao1.liu@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
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

On Tue, 30 May 2023 00:43:43 +0800
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
> 
> [1] SMBIOS 3.0.0, section 7.5.6, Processor Information - Core Count
> 
> Fixes: 003f230e37d7 ("machine: Tweak the order of topology members in struct CpuTopology")
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  hw/smbios/smbios.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index f80a701cdfc1..32e26bffa2df 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -714,6 +714,7 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
>      char sock_str[128];
>      size_t tbl_len = SMBIOS_TYPE_4_LEN_V28;
>      unsigned cpus_per_socket = ms->smp.max_cpus / ms->smp.sockets;
> +    unsigned cores_per_socket = cpus_per_socket / ms->smp.threads;
wouldn't be
   smp.dies * smp.clusters * smp.cores
cleaner and more self-describing

and then you can add sanity check 
      g_assert(cores_per_socket != (cpus_per_socket / ms->smp.threads))
so we won't miss change to CpuTopology in the future?
 
>  
>      if (smbios_ep_type == SMBIOS_ENTRY_POINT_TYPE_64) {
>          tbl_len = SMBIOS_TYPE_4_LEN_V30;
> @@ -748,7 +749,7 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
>      SMBIOS_TABLE_SET_STR(4, asset_tag_number_str, type4.asset);
>      SMBIOS_TABLE_SET_STR(4, part_number_str, type4.part);
>  
> -    t->core_count = (ms->smp.cores > 255) ? 0xFF : ms->smp.cores;
> +    t->core_count = (cores_per_socket > 255) ? 0xFF : cores_per_socket;
>      t->core_enabled = t->core_count;
>  
>      t->thread_count = (cpus_per_socket > 255) ? 0xFF : cpus_per_socket;
> @@ -757,7 +758,7 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
>      t->processor_family2 = cpu_to_le16(0x01); /* Other */
>  
>      if (tbl_len == SMBIOS_TYPE_4_LEN_V30) {
> -        t->core_count2 = t->core_enabled2 = cpu_to_le16(ms->smp.cores);
> +        t->core_count2 = t->core_enabled2 = cpu_to_le16(cores_per_socket);
>          t->thread_count2 = cpu_to_le16(cpus_per_socket);
>      }
>  


