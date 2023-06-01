Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E57971F3DE
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 22:31:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4owI-00084O-Lr; Thu, 01 Jun 2023 16:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q4owE-00083L-TN; Thu, 01 Jun 2023 16:30:26 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q4ow1-0001Xi-CK; Thu, 01 Jun 2023 16:30:26 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-555828f66deso951618eaf.0; 
 Thu, 01 Jun 2023 13:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685651410; x=1688243410;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U20J1xPcLoTRVvsFJ5+IaeKsRqrTrauTkGgGXOmTDRI=;
 b=lygxICQzdsSwjdTCQIeZsg9m/ewHIy2PARPMdqgUJdg8vojufDv1ZZ78RqGxb3CRMn
 ECPShEi3w0Bt7sc47vncxtLbtYfSOiPWmKMr/UZmiVEor8Gg2JQQwhj2bxcBUx2qUj8y
 MPxJIGUsIEpJ0U5nbfW9xPJDploTm6c8/Op8TTYY6nzsxWWwLz0SJtscvtdan8/YiZYp
 aFKPFLYORPfPk4v7CsH8xCb4ar3OzJGBcRdpnCHDrKLoIMhz84fjIAbd7qh2l4L6Ssnx
 hcf1Hyh6amNuNt2NGTn1MrvGA0lrQ/XPJQkyAk2VhOVFm3WBNOw83GoqNkDR/AoapIaR
 8l3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685651410; x=1688243410;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U20J1xPcLoTRVvsFJ5+IaeKsRqrTrauTkGgGXOmTDRI=;
 b=HVccq9BqsuANZvLigwgB7CdAG6USFaGl4aKBSQ6RZuh6Jo8O2Qidlj2tDUZbhhKrGS
 Ce26PONNcyVhOS3QvrOwWQ3uNk7NmpleakAemg0G1/u8gKMiLZeXIHNUb0dFm7mdY7Yv
 giKhGozFji0488UIDTkUgUyZUPNGL2Xp2/PfLvr2ePCVNwP/ZJqL3sOMIoCJO0oeoOmL
 h9Lo5FvfN41AY8EHyzVtWl6cJeP2qX775r6I076oiPbzp4S2nNvmIYKbij4gVSVE6JSc
 cgjMJYdzsj48Xy7A3bvVYk1rQAt17+bjmrVjkduirIqZ90LmjC7eJKZbN8S5rPO+hBZt
 eOtw==
X-Gm-Message-State: AC+VfDwL7KVwqcb3s15vquyuDunDvyzxoD+7vuUcolUbXaleaCenyujH
 bU3Zb1k+/eO4s7iCENvbA9E=
X-Google-Smtp-Source: ACHHUZ717NhavsSfTRwPAmy3nZm9sr3kShqrhM17Dl9RMihK/ST1cxLvYI5k+aqP8Ik13Q3TFSkNHw==
X-Received: by 2002:a4a:4f14:0:b0:555:4735:e801 with SMTP id
 c20-20020a4a4f14000000b005554735e801mr5795736oob.3.1685651410437; 
 Thu, 01 Jun 2023 13:30:10 -0700 (PDT)
Received: from [192.168.68.107] ([177.198.100.141])
 by smtp.gmail.com with ESMTPSA id
 l20-20020a4ad9d4000000b005526bfbf131sm7578252oou.26.2023.06.01.13.30.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 13:30:10 -0700 (PDT)
Message-ID: <dacb0b18-f43f-7101-1987-342ec89eaf82@gmail.com>
Date: Thu, 1 Jun 2023 17:30:07 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] pnv/xive2: Quiet down some error messages
Content-Language: en-US
To: Frederic Barrat <fbarrat@linux.ibm.com>, clg@kaod.org,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20230531150537.369350-1-fbarrat@linux.ibm.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230531150537.369350-1-fbarrat@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=danielhb413@gmail.com; helo=mail-oo1-xc2c.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.1,
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

On 5/31/23 12:05, Frederic Barrat wrote:
> When dumping the END and NVP tables ("info pic" from the HMP) on the
> P10 model, we're likely to be flooded with error messages such as:
> 
>    XIVE[0] - VST: invalid NVPT entry f33800 !?
> 
> The error is printed when finding an empty VSD in an indirect
> table (thus END and NVP tables with skiboot), which is going to happen
> when dumping the xive state. So let's tune down those messages. They
> can be re-enabled easily with a macro if needed.
> 
> Those errors were already hidden on xive/P9, for the same reason.
> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> ---
>   hw/intc/pnv_xive2.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index c80316657a..397679390c 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -163,7 +163,9 @@ static uint64_t pnv_xive2_vst_addr_indirect(PnvXive2 *xive, uint32_t type,
>       ldq_be_dma(&address_space_memory, vsd_addr, &vsd, MEMTXATTRS_UNSPECIFIED);
>   
>       if (!(vsd & VSD_ADDRESS_MASK)) {
> +#ifdef XIVE2_DEBUG
>           xive2_error(xive, "VST: invalid %s entry %x !?", info->name, idx);
> +#endif
>           return 0;
>       }
>   
> @@ -185,7 +187,9 @@ static uint64_t pnv_xive2_vst_addr_indirect(PnvXive2 *xive, uint32_t type,
>                      MEMTXATTRS_UNSPECIFIED);
>   
>           if (!(vsd & VSD_ADDRESS_MASK)) {
> +#ifdef XIVE2_DEBUG
>               xive2_error(xive, "VST: invalid %s entry %x !?", info->name, idx);
> +#endif
>               return 0;
>           }
>   

