Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7918873E050
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 15:16:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDm4L-0003Pl-6v; Mon, 26 Jun 2023 09:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qDm4D-0003J1-AW
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:15:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qDm4B-0005Z9-5z
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687785337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jqE6L9equjuRDpXRwMcpi501KIIiUiTT7qGfw8nB+oI=;
 b=XyHIO8P01mXZ+J/iomgFDNRwZsylytF27bMFzRqLz0g5cE3Eipwt4gP5D+lN8RncC2aF15
 7rXxoEf4YDI3GMVzZ21e5cAboW5qmodqQstlKsWK2gNluVcBzqxlMA4+sPWj88PWw9XUix
 ntV2wmkmJkHGVv7fGFdrh1dPRSsGMeM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-4VF5H5TDOkqXOJeKL_MzCw-1; Mon, 26 Jun 2023 09:15:34 -0400
X-MC-Unique: 4VF5H5TDOkqXOJeKL_MzCw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-98933d4d4c1so202214966b.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 06:15:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687785332; x=1690377332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jqE6L9equjuRDpXRwMcpi501KIIiUiTT7qGfw8nB+oI=;
 b=PbkOOo37TC2H/H5WfjdlXtd+t65uS7knkRQH7LEzVysaawfWrEvt+KRS4uF7Mx4kwZ
 Vb3GWfDI3gAHU8PFHss73A0R7YA126umrZMINQeM96YcQrDNYyR1N31sZ1eneOmJIJzG
 XFKWuXCreuSHaq2XiUf3skAQ6cTMjFWGq5xl9J0S8i0xenRRksGosytfuCkNJZlUtvJt
 JKu6FdKcFl/DpVqvJYwfet7Qk/zL4YPjyCwhpTn3Hl97tlcqYuh2E71XIyrXd2wXoBdZ
 rX/oT0j4cgp8BAqJ4F1+IuyMKnr0UUXQ05l0g1UN+eHEdpftLybQUxLhH7KnralE39oo
 /lJg==
X-Gm-Message-State: AC+VfDyr3nJMQQYy3gfXmIcJoOR2Alypt9BUEkdIv0GAce9LMwjG3PBn
 OxZ+8f48FN087xjldmTwklPG296hDzBeSVLkwNJNmb4xkCJDYU80jDAc74b9VKzLjzAQZRbeOsh
 mN3Y3oFO0M3izCaU=
X-Received: by 2002:a17:907:72c2:b0:991:b2a2:e424 with SMTP id
 du2-20020a17090772c200b00991b2a2e424mr2514224ejc.76.1687785332289; 
 Mon, 26 Jun 2023 06:15:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5nczV1kXduCoDaRY3jzA7r0c1XLIWMrZF2IDwHRqLp0K02eXE0sQqyJFQKaBP8ln/mYlg+rg==
X-Received: by 2002:a17:907:72c2:b0:991:b2a2:e424 with SMTP id
 du2-20020a17090772c200b00991b2a2e424mr2514207ejc.76.1687785332050; 
 Mon, 26 Jun 2023 06:15:32 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 e2-20020a170906080200b00986f9c830efsm3255022ejd.156.2023.06.26.06.15.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 06:15:31 -0700 (PDT)
Date: Mon, 26 Jun 2023 15:15:30 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Tao Su <tao1.su@linux.intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, xiaoyao.li@intel.com,
 lei4.wang@intel.com, qian.wen@intel.com
Subject: Re: [PATCH 5/7] target/i386: Add few security fix bits in
 ARCH_CAPABILITIES into SapphireRapids CPU model
Message-ID: <20230626151530.24524700@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230616032311.19137-6-tao1.su@linux.intel.com>
References: <20230616032311.19137-1-tao1.su@linux.intel.com>
 <20230616032311.19137-6-tao1.su@linux.intel.com>
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

On Fri, 16 Jun 2023 11:23:09 +0800
Tao Su <tao1.su@linux.intel.com> wrote:

> From: Lei Wang <lei4.wang@intel.com>
> 
> Latest stepping (8) of SapphireRapids has bit 13, 14 and 15 of
> MSR_IA32_ARCH_CAPABILITIES enabled, which are related to some security
> fixes.
> 
> Add version 2 of SapphireRapids CPU model with those bits enabled also.

don't we need to update stepping value to 8 as well?

> 
> Signed-off-by: Lei Wang <lei4.wang@intel.com>
> Signed-off-by: Tao Su <tao1.su@linux.intel.com>
> ---
>  target/i386/cpu.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index b5321240c6..f84fd20bb1 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -3854,8 +3854,17 @@ static const X86CPUDefinition builtin_x86_defs[] = {
>          .model_id = "Intel Xeon Processor (SapphireRapids)",
>          .versions = (X86CPUVersionDefinition[]) {
>              { .version = 1 },
> -            { /* end of list */ },
> -        },
> +            {
> +                .version = 2,
> +                .props = (PropValue[]) {
> +                    { "sbdr-ssdp-no", "on" },
> +                    { "fbsdp-no", "on" },
> +                    { "psdp-no", "on" },
> +                    { /* end of list */ }
> +                }
> +            },
> +            { /* end of list */ }
> +        }
>      },
>      {
>          .name = "Denverton",


