Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D185722451
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 13:13:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6898-00032i-EB; Mon, 05 Jun 2023 07:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q6895-000322-8V; Mon, 05 Jun 2023 07:13:07 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q6893-0004Mc-Me; Mon, 05 Jun 2023 07:13:06 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-1a2d06d587eso1316509fac.2; 
 Mon, 05 Jun 2023 04:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685963584; x=1688555584;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=621MdsZ1h+SAU0SWx+iCKIf6ghU7ZKBixRuVFT3Dq+E=;
 b=kdrDyif2impiI2Y5u1CiO3Gh1D0g7C0qZLNGgR6b+TG19GWixZDw++/C901uGqXx+o
 QKkYvGobdOMuiNjeCMpzAgEAR2mBEPimGKioKxJCFNbAEZzw/b8DpbchBEDezApQqKuY
 HrgfIwzUJInJIhHet07BxYLGNBgCLISyMphl6TtlH6IU3dJ+RQ5HyLWKf/quVw9YbKh4
 Y7/eys6i4J7Wk9PVhHutXrydomvAf6Uuc/1EVdCRIbhCJhQy30WqNWe+CTWIW+d/MHYk
 gumaNHt0VrXdK4T2ZUPXp8CKV3dq2f3pNT3Lr2R97DmJXoe5ob9LvdR5jA36g2h20Kp7
 8Myw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685963584; x=1688555584;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=621MdsZ1h+SAU0SWx+iCKIf6ghU7ZKBixRuVFT3Dq+E=;
 b=h2TkUKp1V3mmNV9WlfpiYJKVfYTluyemsAtHsDpdvUPk/UbegtFE1Cqos4Bm2UKoJD
 QgcshNiLH/Y97stRXtLBMLeWJMxzI7pI70hHfPgcIZ8Nb38NAHnArxOWcAj6BQO9OIrN
 zTR/gyLgxkwF+MNW/8cT8KZhbJcOmtjHqabUrkAsC4lYBvn+X6KWpSQGXkxoQDsXJvt9
 rOhzMTMlVBhPCKckR75ZRrlDqCoWuWBFGFcHBcwf8UnfAy9kHMpLymK64ATPs31KxWIU
 9xZF+GM1zITcp1//d5iW+ztAcV/45TnS53LSiFUw+47u59lVSwqb0jPHvKuFraAqH2AZ
 OIFw==
X-Gm-Message-State: AC+VfDzXxIEimBW05mQ9z8gL42og8N3/QhvinbQI2MV7YOwnBKg2uYme
 kyD/IO3LhOQiZCxp9zYqdkU=
X-Google-Smtp-Source: ACHHUZ5vX55wJU68yY8KMHCiBqf3NjtDm5JToNR/6SF4rgLTacW06sCm0OIO289UHVIbIWnUDKEwLg==
X-Received: by 2002:a05:6870:4295:b0:19e:fae6:c9ab with SMTP id
 y21-20020a056870429500b0019efae6c9abmr6232231oah.57.1685963583886; 
 Mon, 05 Jun 2023 04:13:03 -0700 (PDT)
Received: from [192.168.68.107] ([177.170.117.52])
 by smtp.gmail.com with ESMTPSA id
 x16-20020a05683000d000b006ad3ed04973sm3215252oto.8.2023.06.05.04.13.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 04:13:03 -0700 (PDT)
Message-ID: <1e882015-d1c6-32f8-00ff-baea827fa454@gmail.com>
Date: Mon, 5 Jun 2023 08:13:00 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1] target/ppc: Support directed privileged doorbell
 interrupt (SDOOR)
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20230530130526.372701-1-npiggin@gmail.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230530130526.372701-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=danielhb413@gmail.com; helo=mail-oa1-x33.google.com
X-Spam_score_int: 14
X-Spam_score: 1.4
X-Spam_bar: +
X-Spam_report: (1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Queued in gitlab.com/danielhb/qemu/tree/ppc-next. Thanks,


Daniel

On 5/30/23 10:05, Nicholas Piggin wrote:
> BookS msgsndp instruction to self or DPDES register can cause SDOOR
> interrupts which crash QEMU with exception not implemented.
> 
> Linux does not use msgsndp in SMT1, and KVM only uses DPDES to cause
> doorbells when emulating a SMT guest (which is not the default), so
> this has gone unnoticed.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> Another stable candidate.
> 
>   target/ppc/excp_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index fea9221501..add2bc6bfe 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -1539,6 +1539,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
>       case POWERPC_EXCP_DSEG:      /* Data segment exception                   */
>       case POWERPC_EXCP_ISEG:      /* Instruction segment exception            */
>       case POWERPC_EXCP_TRACE:     /* Trace exception                          */
> +    case POWERPC_EXCP_SDOOR:     /* Doorbell interrupt                       */
>           break;
>       case POWERPC_EXCP_HISI:      /* Hypervisor instruction storage exception */
>           msr |= env->error_code;
> @@ -1584,7 +1585,6 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
>       case POWERPC_EXCP_PERFM:     /* Embedded performance monitor interrupt   */
>       case POWERPC_EXCP_VPUA:      /* Vector assist exception                  */
>       case POWERPC_EXCP_MAINT:     /* Maintenance exception                    */
> -    case POWERPC_EXCP_SDOOR:     /* Doorbell interrupt                       */
>       case POWERPC_EXCP_HV_MAINT:  /* Hypervisor Maintenance exception         */
>           cpu_abort(cs, "%s exception not implemented\n",
>                     powerpc_excp_name(excp));

