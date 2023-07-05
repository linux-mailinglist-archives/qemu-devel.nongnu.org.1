Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD7B7489D1
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 19:05:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH5w2-0006iw-6X; Wed, 05 Jul 2023 13:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qH5vn-0006iR-Jh; Wed, 05 Jul 2023 13:04:43 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qH5vm-0000YK-2V; Wed, 05 Jul 2023 13:04:43 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1b3da531a56so1506701fac.1; 
 Wed, 05 Jul 2023 10:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688576676; x=1691168676;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OkPAjK/zLaem8tGMszmFGNGWxr1ccjPV1u8hILCllX0=;
 b=bAuOm5LSHxZ4KKWSeqhmOiA6PXODYQm5R6bZnSjZRuT2OQXIq7umwqckthaDIEydjr
 UpI0pu1YNAOmVO+FsCydhyzGQCWsOoAxJfaWIIADwogrsYGodHS7XP5Qme5kKWvFbQHL
 LG7pEdhculpWjsiceaVATt5dZW2NPuwiBEAftAo6bW1EBHfe6+T9zo3LK2/bq9A63suP
 atUsSEoZq8xQ2YNCND2gs+Zek3WYr7YuHRVQ0YJ7KWcL/ko7ogGd7dT6DiP8p0Rcotpr
 TFbq3C1eEo0cABbDwvmwcHAbvM3bezmyM3Zz4eZ+HIKNtJd2rTC9Jb6YOi+mcuV7dFpA
 YEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688576676; x=1691168676;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OkPAjK/zLaem8tGMszmFGNGWxr1ccjPV1u8hILCllX0=;
 b=QXxDU3vNMm5rQUROdYmIpNw6+zmTokt+KgdlOR0wy8IkHFEeYH9X1xHXwuIxHbFzsk
 qCG0x0C5EAh6DSVrIDwXbVekMTVb956c1P7C92srcGQjADnvc/c4iuEKwR6I62bzJF/4
 LDpdCb7PdyxyTc9zEtd+aPnvVbyYuxa0QshI0eJkEeCjocLGnT80ouz6jcZYnGZjD+4/
 i7sEdunp4TJxjDeyqHrjGP6xDUTm7i6bYluCVk5goroQ1XtdyfcWEa97V5x8K2Ez9LJ4
 E5CK83Xtbc5Iveq2nloxHbxYX8DM02cd63nV5Y9fDGsNaVK6lGRwu0+UTmu50nrsYlN+
 zX8Q==
X-Gm-Message-State: AC+VfDzOPy7qBej+uOcEubldxFZcECbA3PDCSdptlxd0ngA/Vay5fwtb
 EYzrhz+wNZGgUsVmADfjUV8=
X-Google-Smtp-Source: ACHHUZ77iZwEnGOzd45t7E8j9VTToK02j/1ggyKSC8iKp/9a4x/hHuQRdx5Fs1ecR6WZaOE2pTvokA==
X-Received: by 2002:a05:6870:ee14:b0:1b0:7661:dd18 with SMTP id
 ga20-20020a056870ee1400b001b07661dd18mr21912209oab.23.1688576676164; 
 Wed, 05 Jul 2023 10:04:36 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-110.dial-up.telesp.net.br.
 [201.69.66.110]) by smtp.gmail.com with ESMTPSA id
 bd6-20020a056870d78600b001ad21a705a8sm15332940oab.49.2023.07.05.10.04.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 10:04:35 -0700 (PDT)
Message-ID: <4f250f88-1f3d-857e-a866-4d7ae2a7964a@gmail.com>
Date: Wed, 5 Jul 2023 14:04:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] pnv/xive2: Always pass a presenter object when accessing
 the TIMA
Content-Language: en-US
To: Frederic Barrat <fbarrat@linux.ibm.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20230705081400.218408-1-fbarrat@linux.ibm.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230705081400.218408-1-fbarrat@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=danielhb413@gmail.com; helo=mail-oa1-x29.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.089,
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

On 7/5/23 05:14, Frederic Barrat wrote:
> The low-level functions to access the TIMA take a presenter object as
> a first argument. When accessing the TIMA from the IC BAR,
> i.e. indirect calls, we currently pass a NULL pointer for the
> presenter argument. While it appears ok with the current usage, it's
> dangerous. And it's pretty easy to figure out the presenter in that
> context, so this patch fixes it.
> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> ---
>   hw/intc/pnv_xive2.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index 82fcd3ea22..bbb44a533c 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -1624,6 +1624,7 @@ static uint64_t pnv_xive2_ic_tm_indirect_read(void *opaque, hwaddr offset,
>                                                 unsigned size)
>   {
>       PnvXive2 *xive = PNV_XIVE2(opaque);
> +    XivePresenter *xptr = XIVE_PRESENTER(xive);
>       hwaddr hw_page_offset;
>       uint32_t pir;
>       XiveTCTX *tctx;
> @@ -1633,7 +1634,7 @@ static uint64_t pnv_xive2_ic_tm_indirect_read(void *opaque, hwaddr offset,
>       hw_page_offset = pnv_xive2_ic_tm_get_hw_page_offset(xive, offset);
>       tctx = pnv_xive2_get_indirect_tctx(xive, pir);
>       if (tctx) {
> -        val = xive_tctx_tm_read(NULL, tctx, hw_page_offset, size);
> +        val = xive_tctx_tm_read(xptr, tctx, hw_page_offset, size);
>       }
>   
>       return val;
> @@ -1643,6 +1644,7 @@ static void pnv_xive2_ic_tm_indirect_write(void *opaque, hwaddr offset,
>                                              uint64_t val, unsigned size)
>   {
>       PnvXive2 *xive = PNV_XIVE2(opaque);
> +    XivePresenter *xptr = XIVE_PRESENTER(xive);
>       hwaddr hw_page_offset;
>       uint32_t pir;
>       XiveTCTX *tctx;
> @@ -1651,7 +1653,7 @@ static void pnv_xive2_ic_tm_indirect_write(void *opaque, hwaddr offset,
>       hw_page_offset = pnv_xive2_ic_tm_get_hw_page_offset(xive, offset);
>       tctx = pnv_xive2_get_indirect_tctx(xive, pir);
>       if (tctx) {
> -        xive_tctx_tm_write(NULL, tctx, hw_page_offset, val, size);
> +        xive_tctx_tm_write(xptr, tctx, hw_page_offset, val, size);
>       }
>   }
>   

