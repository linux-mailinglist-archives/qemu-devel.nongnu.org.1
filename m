Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE2A73E0F0
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 15:45:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDmWb-0000nt-Qo; Mon, 26 Jun 2023 09:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qDmWY-0000eX-O0
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:44:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qDmWU-00040w-KX
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:44:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687787094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uCgVvJUMW41t+j1uqyDhcHOCiMVKWRMvaEXaLAB2Z6A=;
 b=b/yTUwa0G617XTEhlc9bX+HrLWpDKQU4GPdIziba+Rtj9+VWFmg84Ic7H6bPUGQVnTsJkP
 jyjibelGuQLvgIBsTEbHgeQLl+XZkq+ERpag7SNmSYmA3xTWXiKoeGeBx7E4ySwaZMzMlU
 EzLtVqV9n+EZVOCgf4nlgds1ayfGuRw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-6OrBSZh1OXO1aBQs9Ms8_Q-1; Mon, 26 Jun 2023 09:44:52 -0400
X-MC-Unique: 6OrBSZh1OXO1aBQs9Ms8_Q-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-987e47d2e81so258344066b.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 06:44:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687787091; x=1690379091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uCgVvJUMW41t+j1uqyDhcHOCiMVKWRMvaEXaLAB2Z6A=;
 b=fDremb4f9W7EzZ7/qghQ/6M3XS/JjN0bv/OXYVV0fMWmpIRTxmDSJaQ6PPBlYmkZhY
 dxMVQcwbuV8UZIXp1Bg5I3E7yOQBCdWtYxKaAOz9/u+FerjXlSlMro+5ZYHRvb2LxFxE
 sZdEjf4RSJtpL1UDW3SltnaVKuPKT3zbeup33WT//xqW+9HCRlERGPmN8ZRWU8vmn6hv
 z/57He9YRhFFkz+XW6yc/P4BKEL/1SyhSlKez3Af7zcIuxmyJ20w/y9UJhemhtdHFQfz
 eAtm0YmSWNwBQSfUSx1sqy6tosRT+wiP1yGAHLMcryR6mU57jAbogKRoR3MbE4qvZKe0
 qF/Q==
X-Gm-Message-State: AC+VfDwJNBhau2VmxE1OB6IJfu1cRrrYS1wQyPqz+CwbS0IxpLnxKi6x
 PVVavorT4+aEGQ6zEBbRc3ZipHxn/sX1KA/rOhFxYlzUxYat5PcxbpUlBZ4dk1pXipaNy+3lVjB
 wOoNc0HmCF+DrId8=
X-Received: by 2002:a17:907:70d:b0:979:65f0:cced with SMTP id
 xb13-20020a170907070d00b0097965f0ccedmr24143252ejb.17.1687787091335; 
 Mon, 26 Jun 2023 06:44:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ56ZgTexylMj0IfLQKPJpuCXlrv/p/59vvclnswTcAqZZ+Cg/DWTqsg4kk9/bEpNoSG2vK0Lw==
X-Received: by 2002:a17:907:70d:b0:979:65f0:cced with SMTP id
 xb13-20020a170907070d00b0097965f0ccedmr24143246ejb.17.1687787091098; 
 Mon, 26 Jun 2023 06:44:51 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 q26-20020a1709060e5a00b00991fa596931sm95648eji.147.2023.06.26.06.44.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 06:44:50 -0700 (PDT)
Date: Mon, 26 Jun 2023 15:44:49 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Philippe =?UTF-8?B?TWF0?=
 =?UTF-8?B?aGlldS1EYXVkw6k=?= <philmd@linaro.org>, qemu-devel@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v3 3/4] hw/smbios: Fix thread count in type4
Message-ID: <20230626154449.72874e21@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230620103958.3907565-4-zhao1.liu@linux.intel.com>
References: <20230620103958.3907565-1-zhao1.liu@linux.intel.com>
 <20230620103958.3907565-4-zhao1.liu@linux.intel.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, 20 Jun 2023 18:39:57 +0800
Zhao Liu <zhao1.liu@linux.intel.com> wrote:

> From: Zhao Liu <zhao1.liu@intel.com>
> 
> From SMBIOS 3.0 specification, thread count field means:
> 
> Thread Count is the total number of threads detected by the BIOS for
> this processor socket. It is a processor-wide count, not a
> thread-per-core count. [1]
> 
> So here we should use threads per socket other than threads per core.
> 
> [1] SMBIOS 3.0.0, section 7.5.8, Processor Information - Thread Count
> 
> Fixes: c97294ec1b9e ("SMBIOS: Build aggregate smbios tables and entry point")
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> v3:
>  * Use the wrapped hepler to get threads per socket.
> 
> v2:
>  * Rename cpus_per_socket to threads_per_socket.
>  * Add the comment about smp.max_cpus. Thread count and core count will
>    be calculated in 2 ways and will add a sanity check to ensure we
>    don't miss any topology level.
> ---
>  hw/smbios/smbios.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index d67415d44dd8..3aae9328c014 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -713,6 +713,7 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
>  {
>      char sock_str[128];
>      size_t tbl_len = SMBIOS_TYPE_4_LEN_V28;
> +    unsigned threads_per_socket;
>  
>      if (smbios_ep_type == SMBIOS_ENTRY_POINT_TYPE_64) {
>          tbl_len = SMBIOS_TYPE_4_LEN_V30;
> @@ -747,17 +748,19 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
>      SMBIOS_TABLE_SET_STR(4, asset_tag_number_str, type4.asset);
>      SMBIOS_TABLE_SET_STR(4, part_number_str, type4.part);
>  
> +    threads_per_socket = machine_topo_get_threads_per_socket(ms);
                                ^^^^
Are there any other places we can clean up and reuse this wrapper?

> +
>      t->core_count = (ms->smp.cores > 255) ? 0xFF : ms->smp.cores;
>      t->core_enabled = t->core_count;
>  
> -    t->thread_count = (ms->smp.threads > 255) ? 0xFF : ms->smp.threads;
> +    t->thread_count = (threads_per_socket > 255) ? 0xFF : threads_per_socket;
>  
>      t->processor_characteristics = cpu_to_le16(0x02); /* Unknown */
>      t->processor_family2 = cpu_to_le16(0x01); /* Other */
>  
>      if (tbl_len == SMBIOS_TYPE_4_LEN_V30) {
>          t->core_count2 = t->core_enabled2 = cpu_to_le16(ms->smp.cores);
> -        t->thread_count2 = cpu_to_le16(ms->smp.threads);
> +        t->thread_count2 = cpu_to_le16(threads_per_socket);
>      }
>  
>      SMBIOS_BUILD_TABLE_POST;


