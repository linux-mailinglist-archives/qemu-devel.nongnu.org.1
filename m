Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CE371A0FF
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 16:52:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4jdq-0000m7-SZ; Thu, 01 Jun 2023 10:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4jdp-0000lv-JW
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 10:51:05 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4jdl-0004iT-TR
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 10:51:05 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1b01d3bb571so4122495ad.2
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 07:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685631060; x=1688223060;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ADxdaf120RRlsuYU+GFR6xzszWSZcLsh+bs1NIJtiZw=;
 b=ftZjAb19b1kNiKDdGuXw+lI92CqzGBxB3eU9Q6SqKSJbLWZdqczd6QlxWyqaS5EdXf
 0LYB+cEixM55o8XK/N9MB4MYryHgvhNfyMHO8pJLgMsTSr4oZDd/tD2AmPHBROcAPf95
 lOdLScRXpY/t6FTjTaCybSAguY2vaB6a8FMx4VbHkcL3Ut5AwnNmn6rj/FTxBfXgS5rR
 +uUiJrh9uqUS3QsVJocFXIFdclNyLRc2fDdZ64rMXQS2P4zwj4e7b0chtpzNoD2HFm1r
 5hTOdZljBcsv+9IVTpJEf7yLk9ZBSZiUypGiUVDQbBzSu+MbtK5uLjiJdM+n0Lbyfc8H
 N4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685631060; x=1688223060;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ADxdaf120RRlsuYU+GFR6xzszWSZcLsh+bs1NIJtiZw=;
 b=b3vNkxoG1yJZVSrcw8Fz/uzcUiySP3K215sMF72ViCPqkt9KZc5Gj1ZwuQnPijV7tc
 9DLsFt4O4vDd/4Bn9CWZqAZC0/GySlUHSt/ztbmb13J5HpD/LHWYu9mRHIdHgCtY2n7+
 Iar3LNm+LWJ8Doy2fnxtwVFQYlyq03VB0VZg4dw5IrFXO2eqfszAc2vXDzM1oT5Z550E
 ImtXGit30dJpll6BEDFuoomG4JqEXnt3wFLWVbm3oSa61L5dgvyJMV1MDNj9jX8s0jiE
 kMtNsAbUgY6oXaMEbgO1VYiqt21EevnygD9sVwMP2fjaIG5xphSk9aIZaExJtGY7loMx
 9hkg==
X-Gm-Message-State: AC+VfDwHlgU+hIOV0ANJUpB3x9OxgOg5q5Sars6uCaL7u3nsPrQe+ZzD
 KQR4nZP/0pthdF+TiECy9zjOqw==
X-Google-Smtp-Source: ACHHUZ4zxs6YUOjJWqAcm2CEwxAJuin/Hlpe6P4dSui1OLaf+GFat5e0ldzKRHX5Tj+08n7hqJg7Eg==
X-Received: by 2002:a17:902:e5c2:b0:1ab:63e:67b0 with SMTP id
 u2-20020a170902e5c200b001ab063e67b0mr6685308plf.54.1685631060318; 
 Thu, 01 Jun 2023 07:51:00 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c935:f07f:4b59:7091?
 ([2602:ae:1598:4c01:c935:f07f:4b59:7091])
 by smtp.gmail.com with ESMTPSA id
 b21-20020a170902d31500b001a221d14179sm3556135plc.302.2023.06.01.07.50.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 07:50:59 -0700 (PDT)
Message-ID: <392a7a42-bf1d-c9c6-4e11-2ff68036dd10@linaro.org>
Date: Thu, 1 Jun 2023 07:50:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/1] hw/arm/sbsa-ref: add XHCI controller on PCIe
Content-Language: en-US
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>, rad@semihalf.com,
 peter.maydell@linaro.org
Cc: quic_llindhol@quicinc.com, marcin.juszkiewicz@linaro.org,
 chenbaozi@phytium.com.cn, qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20230601063737.464751-1-wangyuquan1236@phytium.com.cn>
 <20230601063737.464751-2-wangyuquan1236@phytium.com.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230601063737.464751-2-wangyuquan1236@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 5/31/23 23:37, Yuquan Wang wrote:
> The current sbsa-ref cannot use EHCI controller which is only
> able to do 32-bit DMA, since sbsa-ref doesn't have RAM below 4GB.
> Hence, this add an XHCI on PCIe to provide a usb controller with 64-bit
> DMA capablity.
> 
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> ---
>   hw/arm/sbsa-ref.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index de21200ff9..a33cd80d69 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -668,6 +668,8 @@ static void create_pcie(SBSAMachineState *sms)
>   
>       pci_create_simple(pci->bus, -1, "bochs-display");
>   
> +    pci_create_simple(pci->bus, -1, "qemu-xhci");

Better to use TYPE_QEMU_XHCI.
Need to remove the EHCI controler.


r~

