Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0D2832617
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 10:01:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQkka-0005VQ-5G; Fri, 19 Jan 2024 04:01:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=qHsI=I5=kaod.org=clg@ozlabs.org>)
 id 1rQkkY-0005V8-3k; Fri, 19 Jan 2024 04:01:18 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=qHsI=I5=kaod.org=clg@ozlabs.org>)
 id 1rQkkW-0005MX-0M; Fri, 19 Jan 2024 04:01:17 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TGYWC0jQ3z4xCg;
 Fri, 19 Jan 2024 20:01:11 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TGYW90CgVz4wxv;
 Fri, 19 Jan 2024 20:01:08 +1100 (AEDT)
Message-ID: <dd022b59-7572-4985-9088-e503399e9ca7@kaod.org>
Date: Fri, 19 Jan 2024 10:01:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ppc/pnv: Change powernv default to powernv10
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
References: <20240118141418.165107-1-npiggin@gmail.com>
 <20240118141418.165107-3-npiggin@gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240118141418.165107-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=qHsI=I5=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 1/18/24 15:14, Nicholas Piggin wrote:
> POWER10 is the latest IBM Power machine. Although it is not offered in
> "OPAL mode" (i.e., powernv configuration), so there is a case that it
> should remain at powernv9, most of the development work is going into
> powernv10 at the moment.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

May be we could drop support for power10_v1.0 and power9_v1.0 ? These
were bringup CPUs.

Anyhow,

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   hw/ppc/pnv.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 0297871bdd..b949398689 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -2242,8 +2242,6 @@ static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
>   
>       xfc->match_nvt = pnv_match_nvt;
>   
> -    mc->alias = "powernv";
> -
>       pmc->compat = compat;
>       pmc->compat_size = sizeof(compat);
>       pmc->dt_power_mgt = pnv_dt_power_mgt;
> @@ -2267,6 +2265,8 @@ static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
>       mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power10_v2.0");
>       compat_props_add(mc->compat_props, phb_compat, G_N_ELEMENTS(phb_compat));
>   
> +    mc->alias = "powernv";
> +
>       pmc->compat = compat;
>       pmc->compat_size = sizeof(compat);
>       pmc->dt_power_mgt = pnv_dt_power_mgt;


