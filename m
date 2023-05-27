Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7770A7135F8
	for <lists+qemu-devel@lfdr.de>; Sat, 27 May 2023 20:02:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2yEW-0001Wm-L8; Sat, 27 May 2023 14:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q2yEQ-0001Uc-Fm; Sat, 27 May 2023 14:01:35 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q2yEH-0005NA-PX; Sat, 27 May 2023 14:01:34 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6af8127031cso796147a34.2; 
 Sat, 27 May 2023 11:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685210484; x=1687802484;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y7wzSVRCxMJqVf9oOejwUNkyicyMFFsaeLKC1JSMlGE=;
 b=eEq3BC8n8jWgPpHKfBkQXMfZuNfyQKwNxkLpbu/zUM4I64ac2GDx9q1kfOBiCgQDmy
 s6WQLNm+LpxLInqvHl0mztzK0hQF8XORTY+iUUxjplbiZ6bx9LTAKIBIw0/b1Ndcgdhj
 brOEAShd+vEXtC+7M4EK5c45Iode6bAWPjijcHXTYdVtvlF3xNEXF3CDjTGkAIRCLs/Z
 aUpY9kFqEo1AM4WWtCUXRuAcSmiOPWA/4BFVhXK7LPqNu4QIicFKzIbnM0uv31tZr3sE
 Qwrq6to2q/49VM+2MurE94EGUruKnxlWrGVlAyhvtOqGoarTLT5/EPKdNjNrSakneFVu
 ZX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685210484; x=1687802484;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y7wzSVRCxMJqVf9oOejwUNkyicyMFFsaeLKC1JSMlGE=;
 b=LxPwxBDfcJ9ZULFYBR3Hq+9YBidmtu6FiMJNrLFsRPHrWue6osmJPGskfOWSfc2cnz
 ELPdSjWEMvjGBUYA288a3fqvQ/OKCAFij2ZFHgS8dwy+5rThFo3fLosW2LUbg0nY6Q06
 gNqlBfBlFYXw1WN+vPVHhdE61MqaK5xuoGA1p7Fh0dkPsj84NENs6zzzfiXU3VVS8HAh
 zHRlLp6VRdDwlXtHUgpZL5lCrxpieNds7xWbm9CsD227seu0/Lf/BKjf5PcHRSi207b6
 huNQHpYMBD3az8qHzfezsJBczJNZwTMTLXY7SYW2c7u6qnqOr7gFKLYQc8J04ioQKUOn
 PVwg==
X-Gm-Message-State: AC+VfDxS+X9ZWgOx4zjAztkaTcsYNAbuhN8g18TjYUTAyYMZZ9jOkOo9
 ik+YD71Xz7UhAANlJGBME58=
X-Google-Smtp-Source: ACHHUZ51HKjqHfIo80Aws26QmFXk0h0hFh5LO3VIIYri4W4ahT0ZDvvgYPZ8tKntHBE8dPSvqRKxxQ==
X-Received: by 2002:a05:6830:4dc:b0:6a4:2ad5:9aa0 with SMTP id
 s28-20020a05683004dc00b006a42ad59aa0mr2855025otd.20.1685210484220; 
 Sat, 27 May 2023 11:01:24 -0700 (PDT)
Received: from [192.168.68.107] (200-162-225-121.static-corp.ajato.com.br.
 [200.162.225.121]) by smtp.gmail.com with ESMTPSA id
 c25-20020a9d75d9000000b006ab13915cd4sm2918178otl.81.2023.05.27.11.01.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 May 2023 11:01:23 -0700 (PDT)
Message-ID: <0f728d8e-8965-98e3-70a9-948322113b81@gmail.com>
Date: Sat, 27 May 2023 15:01:20 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] pnv_lpc: disable reentrancy detection for lpc-hc
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Frederic Barrat <fbarrat@linux.ibm.com>,
 Alexander Bulekov <alxndr@bu.edu>
References: <20230526073850.2772197-1-clg@kaod.org>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230526073850.2772197-1-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x331.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.091,
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



On 5/26/23 04:38, Cédric Le Goater wrote:
> From: Alexander Bulekov <alxndr@bu.edu>
> 
> As lpc-hc is designed for re-entrant calls from xscom, mark it
> re-entrancy safe.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> [clg: mark opb_master_regs as re-entrancy safe also ]
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---


Queued in gitlab.com/danielhb/qemu/tree/ppc-next. Thanks,


Daniel

>   hw/ppc/pnv_lpc.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
> index 01f44c19ebba..605d3908617a 100644
> --- a/hw/ppc/pnv_lpc.c
> +++ b/hw/ppc/pnv_lpc.c
> @@ -734,10 +734,13 @@ static void pnv_lpc_realize(DeviceState *dev, Error **errp)
>       /* Create MMIO regions for LPC HC and OPB registers */
>       memory_region_init_io(&lpc->opb_master_regs, OBJECT(dev), &opb_master_ops,
>                             lpc, "lpc-opb-master", LPC_OPB_REGS_OPB_SIZE);
> +    lpc->opb_master_regs.disable_reentrancy_guard = true;
>       memory_region_add_subregion(&lpc->opb_mr, LPC_OPB_REGS_OPB_ADDR,
>                                   &lpc->opb_master_regs);
>       memory_region_init_io(&lpc->lpc_hc_regs, OBJECT(dev), &lpc_hc_ops, lpc,
>                             "lpc-hc", LPC_HC_REGS_OPB_SIZE);
> +    /* xscom writes to lpc-hc. As such mark lpc-hc re-entrancy safe */
> +    lpc->lpc_hc_regs.disable_reentrancy_guard = true;
>       memory_region_add_subregion(&lpc->opb_mr, LPC_HC_REGS_OPB_ADDR,
>                                   &lpc->lpc_hc_regs);
>   

