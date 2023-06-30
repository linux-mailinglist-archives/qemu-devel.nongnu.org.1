Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54439744021
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 18:52:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFHLm-000359-PG; Fri, 30 Jun 2023 12:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qFHLk-00033p-BP; Fri, 30 Jun 2023 12:52:00 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qFHLi-0002wL-PT; Fri, 30 Jun 2023 12:52:00 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6b87d505e28so1792864a34.2; 
 Fri, 30 Jun 2023 09:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688143917; x=1690735917;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YO8u5hLkU+PdcJaFlebChGnNseDzZTsI0KRkeTMChCc=;
 b=q83ZCGz7wLypJgeKxAmJpz2shTlnf/wzzc7fUu9Fc9YyjzGcDaWfNQeYfG5SGmkvXs
 8+0XwG1FdbX7hfJYDUlt+kBP9BbUCdOZXCnPXA3evSXsOAu9RvqqjWvRmmweXtd6yuX7
 uV9EU7c+CxOv7WnIVX2hBmmFyNv1mNaUow2V2SPMJzRmNWnLYhoveb/6wZS1aYjo7qki
 2Av7dl1ukn4KoMJHE0QNR1vL+BG5r7XUoBqOpg0XK1K4s6yPostvBmov5C85z2qTjfLo
 fgaFzfri34UVkupLFvGXKOEJ1yfsG3yMWZT/Sn4rmRokzSSt0MZOpA5nc7RDG6QJsJCj
 jtqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688143917; x=1690735917;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YO8u5hLkU+PdcJaFlebChGnNseDzZTsI0KRkeTMChCc=;
 b=NGM99cfmn7cdMVd4eKcTk7TgZr94Vo/BTleawkUbHp57dnyrAnw7rwXTk2jYrGF6v3
 iqQvx8e/WGDYnOtTS0YRfPGOCNR/nJn5LSBO2tF9/rerGCafEo56dggzxEqffzedxHJL
 05Vjfb4NuYdl63DGYchjsUztSXHp3r/XloWrEYY+s2UiT3DJwUzZYJv0MQmb0zqVTyUO
 KR6NbsuI8T4QzE/62SAZ0FiffE2Cfg3E3xwLGdGKbrCMU20hQlBt+4E52V7bQUTUKekc
 4qiDwkC+4KAL9Sc/e70kvGfPK+fYiw4hUAGVqw3okCmRD2pJ+epG3KyMyPyedIA+Ov1+
 1mEA==
X-Gm-Message-State: AC+VfDxKahzs/X+WppPinr2sBFRKHffuhoq9zLNZearXu4dvGJxovWd+
 LxOMVylywjUX0DMdWHZfTts=
X-Google-Smtp-Source: ACHHUZ5kWBxof7kIEraaKbHXKt99a2SfOjoZT49We3y4zBfe3hGWevHOX8nu27BjkI072zGaPAhinA==
X-Received: by 2002:a05:6808:1445:b0:39c:93ba:cb92 with SMTP id
 x5-20020a056808144500b0039c93bacb92mr4196400oiv.8.1688143917192; 
 Fri, 30 Jun 2023 09:51:57 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-110.dial-up.telesp.net.br.
 [201.69.66.110]) by smtp.gmail.com with ESMTPSA id
 r5-20020a056808210500b003a020d24d7dsm1488213oiw.56.2023.06.30.09.51.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 09:51:56 -0700 (PDT)
Message-ID: <2d049db0-48ac-14a2-13f3-644e42cd0716@gmail.com>
Date: Fri, 30 Jun 2023 13:51:54 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] pnv/psi: Allow access to PSI registers through xscom
Content-Language: en-US
To: Frederic Barrat <fbarrat@linux.ibm.com>, clg@kaod.org, joel@jms.id.au,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20230630102609.193214-1-fbarrat@linux.ibm.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230630102609.193214-1-fbarrat@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x32b.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.095,
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



On 6/30/23 07:26, Frederic Barrat wrote:
> skiboot only uses mmio to access the PSI registers (once the BAR is
> set) but we don't have any reason to block the accesses through
> xscom. This patch enables xscom access to the PSI registers. It
> converts the xscom addresses to mmio addresses, which requires a bit
> of care for the PSIHB, then reuse the existing mmio ops.
> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> ---

Queued in gitlab.com/danielhb/qemu/tree/ppc-next. Thanks,


Daniel

>   hw/ppc/pnv_psi.c | 31 +++++++++++++++++++++----------
>   1 file changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
> index 8aa09ab26b..46da58dff8 100644
> --- a/hw/ppc/pnv_psi.c
> +++ b/hw/ppc/pnv_psi.c
> @@ -121,8 +121,12 @@
>   #define PSIHB9_BAR_MASK                 0x00fffffffff00000ull
>   #define PSIHB9_FSPBAR_MASK              0x00ffffff00000000ull
>   
> +/* mmio address to xscom address */
>   #define PSIHB_REG(addr) (((addr) >> 3) + PSIHB_XSCOM_BAR)
>   
> +/* xscom address to mmio address */
> +#define PSIHB_MMIO(reg) ((reg - PSIHB_XSCOM_BAR) << 3)
> +
>   static void pnv_psi_set_bar(PnvPsi *psi, uint64_t bar)
>   {
>       PnvPsiClass *ppc = PNV_PSI_GET_CLASS(psi);
> @@ -769,24 +773,31 @@ static const MemoryRegionOps pnv_psi_p9_mmio_ops = {
>   
>   static uint64_t pnv_psi_p9_xscom_read(void *opaque, hwaddr addr, unsigned size)
>   {
> -    /* No read are expected */
> -    qemu_log_mask(LOG_GUEST_ERROR, "PSI: xscom read at 0x%" PRIx64 "\n", addr);
> -    return -1;
> +    uint32_t reg = addr >> 3;
> +    uint64_t val = -1;
> +
> +    if (reg < PSIHB_XSCOM_BAR) {
> +        /* FIR, not modeled */
> +        qemu_log_mask(LOG_UNIMP, "PSI: xscom read at 0x%08x\n", reg);
> +    } else {
> +        val = pnv_psi_p9_mmio_read(opaque, PSIHB_MMIO(reg), size);
> +    }
> +    return val;
>   }
>   
>   static void pnv_psi_p9_xscom_write(void *opaque, hwaddr addr,
>                                   uint64_t val, unsigned size)
>   {
>       PnvPsi *psi = PNV_PSI(opaque);
> +    uint32_t reg = addr >> 3;
>   
> -    /* XSCOM is only used to set the PSIHB MMIO region */
> -    switch (addr >> 3) {
> -    case PSIHB_XSCOM_BAR:
> +    if (reg < PSIHB_XSCOM_BAR) {
> +        /* FIR, not modeled */
> +        qemu_log_mask(LOG_UNIMP, "PSI: xscom write at 0x%08x\n", reg);
> +    } else if (reg == PSIHB_XSCOM_BAR) {
>           pnv_psi_set_bar(psi, val);
> -        break;
> -    default:
> -        qemu_log_mask(LOG_GUEST_ERROR, "PSI: xscom write at 0x%" PRIx64 "\n",
> -                      addr);
> +    } else {
> +        pnv_psi_p9_mmio_write(opaque, PSIHB_MMIO(reg), val, size);
>       }
>   }
>   

