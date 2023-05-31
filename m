Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3423D717957
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 10:00:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Gk1-0005OP-6m; Wed, 31 May 2023 03:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1q4Gjf-0005GB-B9
 for qemu-devel@nongnu.org; Wed, 31 May 2023 03:59:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1q4Gjd-00045n-Ew
 for qemu-devel@nongnu.org; Wed, 31 May 2023 03:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685519947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2O+Jx4IdFsZHQbd0kIw7FFRzVbFkJqN8dI78vnebFZA=;
 b=hle53L531bIMZzTquTebRG/1nYsgUPiD9TOgsZt88IuDcf//w85ro9YTuHigCiW2AUkzCA
 FMwvI9Wrdb3GXQ5n/72BrGqC6i8I2gFj1nthE7Q5OKvaOCrRHDwFIX+5UYb5SqB8abk1qz
 XfctYtswRULLBlsartEgZ9pjh8g/5FI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-ahsw6zLAPr6S-_n-bOgojg-1; Wed, 31 May 2023 03:59:05 -0400
X-MC-Unique: ahsw6zLAPr6S-_n-bOgojg-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-75b2c4b3e02so50134885a.1
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 00:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685519944; x=1688111944;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2O+Jx4IdFsZHQbd0kIw7FFRzVbFkJqN8dI78vnebFZA=;
 b=Bf3dUMphnhpxLY1STfRkKLknUnyeB4CC6oHy+ifdmuViMRseXFGD64LWjABU1jIucd
 4K/LsGSbTY9YqC+o5PRsYus3aaJYj923XRdonS2fJN7bZg48wwlDQyAVhdB2WV3GqiQe
 shdok4Iy+RuOd8JSYBwLzpEyvCrkLm06iw4xElDS8upEDCERewr0uHH2dtcmxxTbf5RH
 kgu+vizao7MjfHVbmkVUUoPtbt/c0sboNGfz918enJ37+2zJNl24I5s004yfVF/4LrTI
 aUGBb9S1njDufxRqonIxJebH/7zykMTwx6C+lE1jUY88sJgkQY4JdIEptaEShWj7NzdA
 feBA==
X-Gm-Message-State: AC+VfDw3cP4NvNA0NIp5w/Pc8iIkxKu0TTRoH1/wcFJkXOQgYLwra2L/
 dO3Y46ILcwfZ1zoWVpFk7q7ythX/POl/lWMzuVKos/Mmc2k1TPQcrB6NwQr8SS6IcJovW1SMZjj
 +z6qv7ZLVYdrgrtw=
X-Received: by 2002:a05:620a:8b85:b0:75b:23a1:d8c4 with SMTP id
 qx5-20020a05620a8b8500b0075b23a1d8c4mr5198213qkn.8.1685519944560; 
 Wed, 31 May 2023 00:59:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7ku3j1eeXdtIzhuCmSspBr1HghTU8Azy+Nv5mRw6Ss+Q4AQy5mpk2vwRO+nQ0+hFsK7zV7vg==
X-Received: by 2002:a05:620a:8b85:b0:75b:23a1:d8c4 with SMTP id
 qx5-20020a05620a8b8500b0075b23a1d8c4mr5198201qkn.8.1685519944318; 
 Wed, 31 May 2023 00:59:04 -0700 (PDT)
Received: from fc37-ani ([49.207.196.14])
 by smtp.googlemail.com with ESMTPSA id
 s11-20020ae9f70b000000b007594a7aedb2sm4838565qkg.105.2023.05.31.00.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 May 2023 00:59:03 -0700 (PDT)
Date: Wed, 31 May 2023 13:28:57 +0530 (IST)
From: Ani Sinha <anisinha@redhat.com>
To: Zhao Liu <zhao1.liu@linux.intel.com>
cc: "Michael S . Tsirkin" <mst@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, 
 Zhenyu Wang <zhenyu.z.wang@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 2/3] hw/smbios: Fix thread count in type4
In-Reply-To: <20230529164343.467793-3-zhao1.liu@linux.intel.com>
Message-ID: <674ecc04-cf72-cbf1-ddbf-611c65b57299@redhat.com>
References: <20230529164343.467793-1-zhao1.liu@linux.intel.com>
 <20230529164343.467793-3-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
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



On Tue, 30 May 2023, Zhao Liu wrote:

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

I see two patches sent out around this fix. The patch
[PATCH] hw/smbios: fix thead count field in type 4 table

looks correct to me. I NACK this patch.

>
> Fixes: c97294ec1b9e ("SMBIOS: Build aggregate smbios tables and entry point")
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  hw/smbios/smbios.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index d67415d44dd8..f80a701cdfc1 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -713,6 +713,7 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
>  {
>      char sock_str[128];
>      size_t tbl_len = SMBIOS_TYPE_4_LEN_V28;
> +    unsigned cpus_per_socket = ms->smp.max_cpus / ms->smp.sockets;
>

This is confusing. Looking at machine_parse_smp_config(), this is
essentially total number of threads per socket. Maybe a better naming is
threads_per_socket.

Regardless, this patch is confusing.

>      if (smbios_ep_type == SMBIOS_ENTRY_POINT_TYPE_64) {
>          tbl_len = SMBIOS_TYPE_4_LEN_V30;
> @@ -750,14 +751,14 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
>      t->core_count = (ms->smp.cores > 255) ? 0xFF : ms->smp.cores;
>      t->core_enabled = t->core_count;
>
> -    t->thread_count = (ms->smp.threads > 255) ? 0xFF : ms->smp.threads;
> +    t->thread_count = (cpus_per_socket > 255) ? 0xFF : cpus_per_socket;
>
>      t->processor_characteristics = cpu_to_le16(0x02); /* Unknown */
>      t->processor_family2 = cpu_to_le16(0x01); /* Other */
>
>      if (tbl_len == SMBIOS_TYPE_4_LEN_V30) {
>          t->core_count2 = t->core_enabled2 = cpu_to_le16(ms->smp.cores);
> -        t->thread_count2 = cpu_to_le16(ms->smp.threads);
> +        t->thread_count2 = cpu_to_le16(cpus_per_socket);
>      }
>
>      SMBIOS_BUILD_TABLE_POST;
> --
> 2.34.1
>
>


