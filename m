Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 506AF742669
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 14:28:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEqjs-0001pl-Ty; Thu, 29 Jun 2023 08:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qEqje-0001na-LX
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 08:26:55 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qEqjc-0005CP-UH
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 08:26:54 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-1b06da65bdbso515261fac.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 05:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1688041611; x=1690633611;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y7r0OeYIr1fG0wYCNwKuZFFQ5Vylz1EugEMx2PQEN/o=;
 b=KIkCAPlyF7vS8UWS7Hgf9L0TFY+qi+iI8E1KkH5ZM3lj4KnO6t36WAV1RgnMTnbJWI
 oRQrGaCb5mAko6/nphGlcZwpvaBYrFUPpPPhbp5M0d6C4/4GSaOtPbKiB9jj+EjKX9Tl
 ob0yqW/NKeLDir8OQWq9i3dgomiaNihCwb9hHDFR9cHf0tO9cQRpGVVvSl/76mm9ZzNw
 nVdkfgIPj2AKIS69giNsvwQzPuejCVVKty7YudND9DqaGg8e/qqETckYsy2KF39YeYeG
 xwGe23ryVP8ZQStlQYbMX5fdmoAka+IwEwzyxnfUvj56RS1fr4m5rTrI6ya49mM9HQeZ
 gbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688041611; x=1690633611;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y7r0OeYIr1fG0wYCNwKuZFFQ5Vylz1EugEMx2PQEN/o=;
 b=IT7u6TZZGQobKKDf5ZgNhTec0IDNfiH64IVAI8P4fwe/ISItX+Odbomno+86TAOjqV
 yqLRG4X2aOVadgk/MXYgBoKSSBNDHgTD+OSzRDciUWQSmSlkT9LkDSyiB7YDpyV2cPt9
 JE35TMQ8BYxmulUoKzbbQrcCaKzpBIJkCk8GZpnR5BFD4wPqzV/0+2OSQz3QgAJ36faM
 qlwjkPWI7W+Ble2eE6advGt4i1CTi/4qFSD77CKs5GvI64itCrNUa369POA10sw+dKSc
 KT8H1R9L7iGaTvJAZJbKDHJ+Bel6RCG2uyA9q/rd/0EUbz0aKS9dP2X4UR4K2v+e+KYL
 QfTQ==
X-Gm-Message-State: AC+VfDx7Xeoa8d+TRDglLbZgfWNDi6y78bAganG31jHbyAPB7OHGMjGn
 ZUpzZ8GEsB7YmaMKZVDgFseMwA==
X-Google-Smtp-Source: ACHHUZ54ttLdzMavlNWxCUCP94Kwre8pItvZKfbNXOv56HSOKyP7pcIJrKJGfd6rV709E95rmLRomQ==
X-Received: by 2002:a05:6870:e353:b0:1a6:d839:928a with SMTP id
 a19-20020a056870e35300b001a6d839928amr25493574oae.8.1688041611301; 
 Thu, 29 Jun 2023 05:26:51 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-110.dial-up.telesp.net.br.
 [201.69.66.110]) by smtp.gmail.com with ESMTPSA id
 en41-20020a05687007a900b001a9eb707366sm7550061oab.15.2023.06.29.05.26.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 05:26:50 -0700 (PDT)
Message-ID: <057c335b-a614-95c9-953d-d9eaa793d529@ventanamicro.com>
Date: Thu, 29 Jun 2023 09:26:46 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] hw/riscv/virt: Fix 'controller' typo
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liweiwei@iscas.ac.cn>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20230629121103.87733-1-philmd@linaro.org>
 <20230629121103.87733-2-philmd@linaro.org>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230629121103.87733-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x32.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

Phil,

I've fixed this typo a few weeks ago. qemu-trivial picked it up.


Thanks,

Daniel

On 6/29/23 09:11, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/riscv/virt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index ed4c27487e..68ccd0bde1 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1692,7 +1692,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>                                     virt_set_aia);
>       object_class_property_set_description(oc, "aia",
>                                             "Set type of AIA interrupt "
> -                                          "conttoller. Valid values are "
> +                                          "controller. Valid values are "
>                                             "none, aplic, and aplic-imsic.");
>   
>       object_class_property_add_str(oc, "aia-guests",

