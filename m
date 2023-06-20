Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A82C736B99
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 14:09:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBaAz-0006Od-Qa; Tue, 20 Jun 2023 08:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBaAu-0006OU-Pj
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:09:33 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBaAt-000211-89
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:09:32 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9887ebe16d0so342432266b.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 05:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687262969; x=1689854969;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cSQCPevHqEJnNL0WkSumg2zyodiuNL0ut3EFC3hWWps=;
 b=llyQwIiFUTCFRotUKY9uyeb+MSxBEakZzz+P2ILfN4GY5cLOex+rRN+FuvfiiVsool
 NIIPgU46jbIz8b/XR5gDXffCq3GfQCBjalvaXUcCMRIDGZjGECT2G/DsSzgIIG5RNJ1g
 xOKnGDLY2q4/a43q6bKeo0RGyg06v76hT25mLEgZE0WDHQueyNIvIsnI32N9H+eqKvsj
 eFIo5qAEEzraW/SuL+t+sgmd8jRR6H+K6eF4+Wmlxoqc/zjcP+B7IL2TDoi3vyYIaWFZ
 TfUqsBSl1wYbX9UkyT3hfVurcfqxRSOVmyW98Q9TcG4s5EBpLvVJQtn5HGR7Azv/DoQW
 xqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687262969; x=1689854969;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cSQCPevHqEJnNL0WkSumg2zyodiuNL0ut3EFC3hWWps=;
 b=TY6DH2zYst/Qnpco2bYP/GTtkkNgOgUYl/CAkqRpb4t9/BGHFnB5TihibeqvZH9c6i
 x+F+Qn+sxpKQTDoGWYc11IdAjC4GucVkGBp5b+/k9d9fMZ9xOh8jXXaQnaxnnip/mH53
 CiisYiBi3EdmNZC+3XYzb7WCdIcYa4wAMFJkNVz01GFgaW5rLATLEtS6MVPrx9nuoS7a
 aWMHkSw7qlAAPrgykIIR8mgRC1fNRxuSASzsQ+rCoGzM6djVyl57g8zhe9C3qS7wfBTt
 T5Kr0qlx25hlkUUDUw+LAGgnLyPKAHEY+l6LCn4VhoRIDHqUAl5SsiooFiCkfJ3d6anI
 dlVw==
X-Gm-Message-State: AC+VfDwtvmMrA3OkLL2DzUflWn1rLaYfEvWAnr7bY/ybFCkVoMpJzHtY
 gnxVrYW51jX+fIEPufVpghoYr7JSaI1f9U1xvYeMsPP9
X-Google-Smtp-Source: ACHHUZ5ppgE1wiqqUcjL0sG/vUeeMEdfU+0gpPDWUAcTx1oYyPhGORt0R5x5fSA+VxScICcBlTpqwQ==
X-Received: by 2002:a17:906:7943:b0:987:e23f:6d7a with SMTP id
 l3-20020a170906794300b00987e23f6d7amr7723211ejo.25.1687262969581; 
 Tue, 20 Jun 2023 05:09:29 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 z21-20020a170906435500b00989014cd528sm1308488ejm.150.2023.06.20.05.09.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 05:09:29 -0700 (PDT)
Message-ID: <e77f9fde-7a9b-689a-1410-84dedfcb67fe@linaro.org>
Date: Tue, 20 Jun 2023 14:09:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 01/46] target/loongarch: Add LASX data type XReg
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230620093814.123650-1-gaosong@loongson.cn>
 <20230620093814.123650-2-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230620093814.123650-2-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/20/23 11:37, Song Gao wrote:
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index b23f38c3d5..347950b4d0 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -259,9 +259,23 @@ typedef union VReg {
>       Int128   Q[LSX_LEN / 128];
>   }VReg;
>   
> +#define LASX_LEN   (256)
> +typedef union XReg {
> +    int8_t   XB[LASX_LEN / 8];
> +    int16_t  XH[LASX_LEN / 16];
> +    int32_t  XW[LASX_LEN / 32];
> +    int64_t  XD[LASX_LEN / 64];
> +    uint8_t  UXB[LASX_LEN / 8];
> +    uint16_t UXH[LASX_LEN / 16];
> +    uint32_t UXW[LASX_LEN / 32];
> +    uint64_t UXD[LASX_LEN / 64];
> +    Int128   XQ[LASX_LEN / 128];
> +} XReg;

This is following the example of target/i386, and I think it is a bad example.

For Arm, we have one ARMVectorReg which covers AdvSIMD (128-bit) and SVE (2048-bit).
I would prefer if you just expand the definition of VReg to be 256 bits.



r~

