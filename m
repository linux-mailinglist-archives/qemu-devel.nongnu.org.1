Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23547745DC4
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:51:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGJvy-0005Ta-S7; Mon, 03 Jul 2023 09:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qGJvQ-00056S-93; Mon, 03 Jul 2023 09:49:08 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qGJv5-0006nV-8F; Mon, 03 Jul 2023 09:48:51 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-1b0419f758eso2787569fac.1; 
 Mon, 03 Jul 2023 06:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688392123; x=1690984123;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fILVI2qzxbGc2Lz0QleemnPOle2TPjME8ApMt9R5Hoc=;
 b=VKjpvdfaQ0ebyE2u4pAY9nuao6NAbVh0liMkN4CKKt84AxDFfjUrJiFUz+0q/nZv1J
 s/y6dmOjSlIRuUJGDlomJGjedM1amI9e3wuYHxlj1/B86kjiLgYC3YaMX3gzQzzDely2
 08eVmisaqXbA8wuxxaufwLV+V1KOlHFEyXNja2dgZoUipXur8/kvgDOBMIVe9S6lXMGW
 xnF6MOC0cXTzzNOyKUAqnY+HAzp6sLgjpt0ihe3lfpfFTLA7l/3xyggmCEgfz6cN+XZg
 viCLGIZS9Skaf+AhmFeAeWiuffy+inz239YmCd6uCmC7kTj7ABZXvvk4XNPMvfJGL6Lj
 y23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688392123; x=1690984123;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fILVI2qzxbGc2Lz0QleemnPOle2TPjME8ApMt9R5Hoc=;
 b=JmWnilobdzAI0rj6RbfK6+em9Vv7hfx3ip2eKM3pSVQ0hA0oqBXabpWicSBiwzA10k
 27EYjoptGN3s/AvmpyfXpsSvGkQiFZRi4o3WD6KadWeg+3yWrYzCMZXf/vu5V00dcZN5
 9avfNtOte6nVVdmPBebLhZYT7Q1qHItEht3Jy3mIyhvUnqoaPhcEG8hzg2jszgKA1AhZ
 XQSHz2pX4fYe1NXoLbzdg5/1TTgbFDNc2vJikhSRBB4H/tWOiUQjA9pWHGsKXFak+/b/
 N1zsd/dxV/hUKKjrIks6NpN5lINptmj4Rfy69nLDvt1/A03/nxR6psnsP/XCCJysmrWe
 MWTg==
X-Gm-Message-State: AC+VfDyrCWU3SkbroDZxrhXjOFrIFw+Gd+79T0G4dqFGy2oRf50mqczV
 O72VteNQR53JYdWMjPmUc6s=
X-Google-Smtp-Source: APBJJlFQKH5N5GSKUgg1edJiV1z5mzXTD7rx5lPweoIEn0he/o3Zw6fj4yc7MjRuanBwh43qbmxuKQ==
X-Received: by 2002:a05:6870:1694:b0:1b0:73e5:514f with SMTP id
 j20-20020a056870169400b001b073e5514fmr5673006oae.24.1688392123170; 
 Mon, 03 Jul 2023 06:48:43 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-110.dial-up.telesp.net.br.
 [201.69.66.110]) by smtp.gmail.com with ESMTPSA id
 cv13-20020a056870c68d00b001aaa093932bsm12281863oab.11.2023.07.03.06.48.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jul 2023 06:48:42 -0700 (PDT)
Message-ID: <10eb1e8e-9d14-f426-9ddb-872b84f9a3c7@gmail.com>
Date: Mon, 3 Jul 2023 10:48:40 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] pnv/xive2: Fix TIMA offset for indirect access
Content-Language: en-US
To: Frederic Barrat <fbarrat@linux.ibm.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20230703080858.54060-1-fbarrat@linux.ibm.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230703080858.54060-1-fbarrat@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=danielhb413@gmail.com; helo=mail-oa1-x2e.google.com
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



On 7/3/23 05:08, Frederic Barrat wrote:
> Direct TIMA operations can be done through 4 pages, each with a
> different privilege level dictating what fields can be accessed. On
> the other hand, indirect TIMA accesses on P10 are done through a
> single page, which is the equivalent of the most privileged page of
> direct TIMA accesses.
> 
> The offset in the IC bar of an indirect access specifies what hw
> thread is targeted (page shift bits) and the offset in the
> TIMA being accessed (the page offset bits). When the indirect
> access is calling the underlying direct access functions, it is
> therefore important to clearly separate the 2, as the direct functions
> assume any page shift bits define the privilege ring level. For
> indirect accesses, those bits must be 0. This patch fixes the offset
> passed to direct TIMA functions.
> 
> It didn't matter for SMT1, as the 2 least significant bits of the page
> shift are part of the hw thread ID and always 0, so the direct TIMA
> functions were accessing the privilege ring 0 page. With SMT4/8, it is
> no longer true.
> 
> The fix is specific to P10, as indirect TIMA access on P9 was handled
> differently.
> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> ---

Queued in gitlab.com/danielhb/qemu/tree/ppc-next. Thanks,


Daniel

> Changelog:
> v2: rename function and variable
>      rebase to Danel's ppc-next
> 
> hw/intc/pnv_xive2.c | 20 ++++++++++++++++++--
>   1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index e8ab176de6..82fcd3ea22 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -1590,6 +1590,18 @@ static uint32_t pnv_xive2_ic_tm_get_pir(PnvXive2 *xive, hwaddr offset)
>       return xive->chip->chip_id << 8 | offset >> xive->ic_shift;
>   }
>   
> +static uint32_t pnv_xive2_ic_tm_get_hw_page_offset(PnvXive2 *xive,
> +                                                   hwaddr offset)
> +{
> +    /*
> +     * Indirect TIMA accesses are similar to direct accesses for
> +     * privilege ring 0. So remove any traces of the hw thread ID from
> +     * the offset in the IC BAR as it could be interpreted as the ring
> +     * privilege when calling the underlying direct access functions.
> +     */
> +    return offset & ((1ull << xive->ic_shift) - 1);
> +}
> +
>   static XiveTCTX *pnv_xive2_get_indirect_tctx(PnvXive2 *xive, uint32_t pir)
>   {
>       PnvChip *chip = xive->chip;
> @@ -1612,14 +1624,16 @@ static uint64_t pnv_xive2_ic_tm_indirect_read(void *opaque, hwaddr offset,
>                                                 unsigned size)
>   {
>       PnvXive2 *xive = PNV_XIVE2(opaque);
> +    hwaddr hw_page_offset;
>       uint32_t pir;
>       XiveTCTX *tctx;
>       uint64_t val = -1;
>   
>       pir = pnv_xive2_ic_tm_get_pir(xive, offset);
> +    hw_page_offset = pnv_xive2_ic_tm_get_hw_page_offset(xive, offset);
>       tctx = pnv_xive2_get_indirect_tctx(xive, pir);
>       if (tctx) {
> -        val = xive_tctx_tm_read(NULL, tctx, offset, size);
> +        val = xive_tctx_tm_read(NULL, tctx, hw_page_offset, size);
>       }
>   
>       return val;
> @@ -1629,13 +1643,15 @@ static void pnv_xive2_ic_tm_indirect_write(void *opaque, hwaddr offset,
>                                              uint64_t val, unsigned size)
>   {
>       PnvXive2 *xive = PNV_XIVE2(opaque);
> +    hwaddr hw_page_offset;
>       uint32_t pir;
>       XiveTCTX *tctx;
>   
>       pir = pnv_xive2_ic_tm_get_pir(xive, offset);
> +    hw_page_offset = pnv_xive2_ic_tm_get_hw_page_offset(xive, offset);
>       tctx = pnv_xive2_get_indirect_tctx(xive, pir);
>       if (tctx) {
> -        xive_tctx_tm_write(NULL, tctx, offset, val, size);
> +        xive_tctx_tm_write(NULL, tctx, hw_page_offset, val, size);
>       }
>   }
>   

