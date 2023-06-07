Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEC07262E7
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 16:35:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6uFm-0008Kl-Gm; Wed, 07 Jun 2023 10:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q6uFj-0008KR-Jz
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:35:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q6uFg-0006F3-LQ
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686148507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rAzzJy5d/L9+45hBgR0OYcQISzqFHH8VTgNzSjWMxX8=;
 b=F0DqPos9JXOcBwBfS6aeLrqJgLTOyZoRLlhsA0CdSePQhSAN5CXcHjVgRksblNGW7uTQOp
 qboExhHtGKlUC5GjSq9seb/2ciyA5Xu+1RwDMo7k8+lHRy4+1459Y5jfd8Us2qwB3VbUzV
 4IxDP1yGmc1qMmF4sqtozbJ+xADjb9k=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-ecDDRyI1NuSsSBYYlxGEcQ-1; Wed, 07 Jun 2023 10:35:06 -0400
X-MC-Unique: ecDDRyI1NuSsSBYYlxGEcQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-977d0333523so433676866b.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 07:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686148505; x=1688740505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rAzzJy5d/L9+45hBgR0OYcQISzqFHH8VTgNzSjWMxX8=;
 b=I/dpKVj+SW3VPNk0Khdb/3IP+KCZV4+HFTgT0lDswOpjCUy/LXrT0I7N0Fn1QG7p1X
 tdPZlhGHVv1ey1kwx1xSFAvrsUNsMLhGRxwF/O1vZ0k3rNqufIrsYXxEU/bstKbm9XYK
 gDayGbMF9Y2RYfk6zvUP5LBUCQURwJuSs74FQ1CEFxTfNFGPPpQp6DK74j9qy4qGluxJ
 EEp/PdWReo7AghYQrvu7uYQRwi0FZe7CzxCub5q90UBRy15VdEaAogtlj4PtuEIh9f9y
 5GEMRtCWL9+C5//EtNhKpHRwSU6Fo19RF4jgJDegexJYQSKkMMrMB8nAHz1qPuFB1/oN
 /Wwg==
X-Gm-Message-State: AC+VfDzDaOpSlyhwNHmJzeJYzBYkFQLKlWqIgMRyBJk6mlBIwf9ShQzQ
 ql5gX4p39pgC03y5+pLS4ACxbfDYcqN/cruA33JkR+TtZtU++wx+BHr4f7vvtKD9+v7w/NadFif
 IVuLem1Y/8MXOg8w=
X-Received: by 2002:a17:907:d88:b0:970:1bc9:2eeb with SMTP id
 go8-20020a1709070d8800b009701bc92eebmr7417328ejc.30.1686148505023; 
 Wed, 07 Jun 2023 07:35:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ555y+pEZC9ZoFRxJWTQ3ugVxPyBZA8VA5YIWOuHPdZb39Wl8QjCG3YRwgNpaNTat9vP1SgKQ==
X-Received: by 2002:a17:907:d88:b0:970:1bc9:2eeb with SMTP id
 go8-20020a1709070d8800b009701bc92eebmr7417315ejc.30.1686148504773; 
 Wed, 07 Jun 2023 07:35:04 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 w21-20020a170906185500b00968db60e070sm6932994eje.67.2023.06.07.07.35.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 07:35:04 -0700 (PDT)
Date: Wed, 7 Jun 2023 16:35:03 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>, Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [PATCH v2 1/3] hw/smbios: Fix smbios_smp_sockets caculation
Message-ID: <20230607163503.75aae205@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230601092952.1114727-2-zhao1.liu@linux.intel.com>
References: <20230601092952.1114727-1-zhao1.liu@linux.intel.com>
 <20230601092952.1114727-2-zhao1.liu@linux.intel.com>
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

On Thu,  1 Jun 2023 17:29:50 +0800
Zhao Liu <zhao1.liu@linux.intel.com> wrote:

> From: Zhao Liu <zhao1.liu@intel.com>
> 
> Here're 2 mistakes:
> 1. 003f230e37d7 ("machine: Tweak the order of topology members in struct
>    CpuTopology") changes the meaning of smp.cores but doesn't fix
>    original smp.cores uses. And because of the introduction of cluster,
>    now smp.cores means the number of cores in one cluster. So smp.cores
>    * smp.threads just means the cpus in a cluster not in a socket.

> 2. smp.cpus means the number of initial online cpus, not the total
>    number of cpus. For such topology calculation, smp.max_cpus
>    should be considered.
that's probably not relevant to the patch.


> 
> Since the number of sockets has already been recorded in smp structure,
> use smp.sockets directly.


I'd rephrase commit message to something like this:
---
CPU topology is calculated by ..., and trying to recalculate it here
with another rules leads to an error, such as 

 ... example follows ..

So stop reinventing the another wheel and use topo values that ... has calculated. 

> 
> Fixes: 003f230e37d7 ("machine: Tweak the order of topology members in struct CpuTopology")
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  hw/smbios/smbios.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index d2007e70fb05..d67415d44dd8 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -1088,8 +1088,7 @@ void smbios_get_tables(MachineState *ms,
>          smbios_build_type_2_table();
>          smbios_build_type_3_table();
>  
> -        smbios_smp_sockets = DIV_ROUND_UP(ms->smp.cpus,
> -                                          ms->smp.cores * ms->smp.threads);
> +        smbios_smp_sockets = ms->smp.sockets;
>          assert(smbios_smp_sockets >= 1);
>  
>          for (i = 0; i < smbios_smp_sockets; i++) {


