Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A300747A47
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 01:13:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGpBo-0005FF-82; Tue, 04 Jul 2023 19:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qGpBk-0005Ez-LG; Tue, 04 Jul 2023 19:12:04 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qGpBj-000661-5y; Tue, 04 Jul 2023 19:12:04 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5634fbf0cf4so3891140eaf.3; 
 Tue, 04 Jul 2023 16:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688512321; x=1691104321;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/EjrLFPWii6HtYRTqtQaEXCBsfYhgUawsTUkXOk2lCY=;
 b=TUlz9W1s1oiN9I4tIXsC9W8YPw5psuntBuv9WPjXr1ab7fwMmlKF8TpaPHcO2YbeIZ
 3QFeciuoRoC0qVvCh6diRhfiAk11h86b+4b1s909WSSpcqubR4IBh95vw1MZ+2yGFP+y
 gL18laqQCdc4KnRj1qVuBSw91TfAdUGM55HPNonFdrineG30HygE2IJNFsbQt03VwdyR
 bqLvANgs1HREnwv8wrHeirJPLLCbQLpL+0c5JqmeTpNP4z7A/D0z1400GeNYKTHyTPOO
 mSsHOI78Xt4IOgAERc9nuoD+hotFvb2Ds5ZR1CSe2XDe/vKXIpWZdVeYO8Nw0BtqPV9f
 ZMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688512321; x=1691104321;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/EjrLFPWii6HtYRTqtQaEXCBsfYhgUawsTUkXOk2lCY=;
 b=XBInjDj/bmw5CtAv8YFNCEmZOZb0uOABnwwfbtJ0HEc8hLG37NJYAsvA11sN0gf4SK
 lVDKuRQT5UwFcOrXOG0r3oBGd8eIu0JmH9eNYNOCRyxe3o+tJ0Lc8pwTYPlxKYpt8mlq
 ynJLhybLMRUIZieDYH+Imb/sMK6gtOtlSOKcUc4G2uOdVc2Em/p/zTdMNQaZTpiH71KY
 Im9fwA9bUq34iywFva4wFdLbXtKkMXrKVJYbz7CFyzxSbTK9krWbb1s7KPceRSUnHnd3
 b3IbcbCElR/XmWiRtu8a1l3bZqTj1sT8GvR+ZUhCIb1K6dT4le9AHbSsa5dfxUb0xi1Q
 iajw==
X-Gm-Message-State: AC+VfDxqWTZzDIqPE5gPNGydk6BBFu17ZqX3s9EnRU9kkWIPt29nNlHA
 7wzVQMd4zerHJI5ZhcL6MzI=
X-Google-Smtp-Source: ACHHUZ6f+DqOakmtCcSDi8xB4OMD/LsqCzLXWMyZkFTlFazWN5QhfuaRKvauh9q1dw5Spaaokut7Lg==
X-Received: by 2002:a4a:2c04:0:b0:565:8b16:4042 with SMTP id
 o4-20020a4a2c04000000b005658b164042mr9373244ooo.2.1688512321097; 
 Tue, 04 Jul 2023 16:12:01 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-110.dial-up.telesp.net.br.
 [201.69.66.110]) by smtp.gmail.com with ESMTPSA id
 u44-20020a4a972f000000b005660ed0becesm3076144ooi.39.2023.07.04.16.11.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 16:12:00 -0700 (PDT)
Message-ID: <9948868b-82fa-d362-2601-9bd6cc54071f@gmail.com>
Date: Tue, 4 Jul 2023 20:11:57 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] pnv/xive: Allow mmio operations of any size on the ESB CI
 pages
Content-Language: en-US
To: Frederic Barrat <fbarrat@linux.ibm.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20230704144848.164287-1-fbarrat@linux.ibm.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230704144848.164287-1-fbarrat@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=danielhb413@gmail.com; helo=mail-oo1-xc34.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.09,
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

Queued in gitlab.com/danielhb/qemu/tree/ppc-next. Thanks,


Daniel

On 7/4/23 11:48, Frederic Barrat wrote:
> We currently only allow 64-bit operations on the ESB CI pages. There's
> no real reason for that limitation, skiboot/linux didn't need
> more. However the hardware supports any size, so this patch relaxes
> that restriction. It impacts both the ESB pages for "normal"
> interrupts as well as the ESB pages for escalation interrupts defined
> for the ENDs.
> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> ---
> 
> This should wrap-up the cleanup about mmio size for the xive BARs. The
> NVPG and NVC BAR accesses should also be relaxed but we don't really
> implement them, any load/store currently fails. Something to address
> when/if we implement them.
> 
>   hw/intc/xive.c  | 8 ++++----
>   hw/intc/xive2.c | 4 ++--
>   2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index f60c878345..c014e961a4 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -1175,11 +1175,11 @@ static const MemoryRegionOps xive_source_esb_ops = {
>       .write = xive_source_esb_write,
>       .endianness = DEVICE_BIG_ENDIAN,
>       .valid = {
> -        .min_access_size = 8,
> +        .min_access_size = 1,
>           .max_access_size = 8,
>       },
>       .impl = {
> -        .min_access_size = 8,
> +        .min_access_size = 1,
>           .max_access_size = 8,
>       },
>   };
> @@ -2006,11 +2006,11 @@ static const MemoryRegionOps xive_end_source_ops = {
>       .write = xive_end_source_write,
>       .endianness = DEVICE_BIG_ENDIAN,
>       .valid = {
> -        .min_access_size = 8,
> +        .min_access_size = 1,
>           .max_access_size = 8,
>       },
>       .impl = {
> -        .min_access_size = 8,
> +        .min_access_size = 1,
>           .max_access_size = 8,
>       },
>   };
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 4d9ff41956..c37ef25d44 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -954,11 +954,11 @@ static const MemoryRegionOps xive2_end_source_ops = {
>       .write = xive2_end_source_write,
>       .endianness = DEVICE_BIG_ENDIAN,
>       .valid = {
> -        .min_access_size = 8,
> +        .min_access_size = 1,
>           .max_access_size = 8,
>       },
>       .impl = {
> -        .min_access_size = 8,
> +        .min_access_size = 1,
>           .max_access_size = 8,
>       },
>   };

