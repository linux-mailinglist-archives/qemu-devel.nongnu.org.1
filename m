Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB71746C5D
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 10:50:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGbjY-0007CU-Hx; Tue, 04 Jul 2023 04:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGbjT-0007BU-Uu
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:49:59 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGbjR-0002Gp-97
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:49:59 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4fb7b2e3dacso8286868e87.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 01:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688460595; x=1691052595;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ovUK5r6WkxckU54kEEZk0b5zNC6FPII5kvScAKe9LXs=;
 b=rL/8RRislOmdsYifE6E3b7jkV9Cm3aL6DbilM055MQ2qerzfyF0rMUvHiJbY3xzzYl
 Qg+bvrb5mfxOD1Z+r6CiQc/i+ZmnMaPGOBwUeyq/nX5Sy/GYwHpXZfuRC6WZClR6TYWi
 hgwV1/PjGbo/xUbP6v6uqrIQx4hr4hhfUJ4SKQkNBcm3Mb64bw43zhHMCoatedBcLFxo
 TZb5xoZnVc9e7AFDo5WcGtnUAjVrcuFrERMtYNrXMGu9qwKgPOQadNfk/dKn/ZvadXwi
 0vsriANO9dvNCy24IIUh0LxroZrGKk9lkRkCFAwjjhrGbaF5k99L5p/kCPjKqANhC28A
 D3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688460595; x=1691052595;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ovUK5r6WkxckU54kEEZk0b5zNC6FPII5kvScAKe9LXs=;
 b=fY+tr0Dj2OZ+UIpy9zV+ZCAn4j+3pIR11MHVHsoDzRZug/jnEqyUyyQqWzHM01g/+t
 Xn5aYogOyvjL1zmjVpJjdH9OixL1cW3ZImeoyRhk+qHlU047MsUYB8JXFrxWT0eMun/p
 ej2HQLZhjU+ntOHBcYQ2Raz/mfmxfCKXFfKdd2XjryhheMsbB5HvIRyf2ymsT1Q4K9fJ
 3jamx3eh+MQzOWunZPDh+9kSKsvWAAm8GeC+JYWXRdeEUNFA7k0WsncGiN7QKpSy6oRP
 xZVPms/HMcLvyEfa7vxFZkDUHTN/6izXCEfucdi1HGKJwvKjAOQm7ODsSE6+NNkkF9Rd
 RMDQ==
X-Gm-Message-State: ABy/qLbgj1JvML3gunru3T7bFL6RxBHukAFUX3k/+SRZbqh1J7FBgTtl
 anlyunK3E7Adcm0+OoKjfBS9yQ==
X-Google-Smtp-Source: APBJJlEdC/mljqkZJB0BbPEyaFQeD9nos84sVjeNpdYnobcvy+bw4vzvt9N3qiJ7exJCYn2zGIcSZw==
X-Received: by 2002:a05:6512:34c4:b0:4f8:6d53:a68f with SMTP id
 w4-20020a05651234c400b004f86d53a68fmr7410881lfr.64.1688460595060; 
 Tue, 04 Jul 2023 01:49:55 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.157.122])
 by smtp.gmail.com with ESMTPSA id
 z24-20020a05600c221800b003fa96fe2bd9sm24350872wml.22.2023.07.04.01.49.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 01:49:54 -0700 (PDT)
Message-ID: <e42417b6-e4d1-5137-85d6-837dd438d862@linaro.org>
Date: Tue, 4 Jul 2023 10:49:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 03/13] ppc440: Add a macro to shorten PCIe controller DCR
 registration
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
References: <cover.1688421085.git.balaton@eik.bme.hu>
 <e8ae82b0b6c10e48acbc297fa15d9e5f4befc9d2.1688421085.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <e8ae82b0b6c10e48acbc297fa15d9e5f4befc9d2.1688421085.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 4/7/23 00:02, BALATON Zoltan wrote:
> It is more readable to wrap the complex call to ppc_dcr_register in a
> macro when needed repeatedly.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/ppc/ppc440_uc.c | 76 +++++++++++++++++-----------------------------
>   1 file changed, 28 insertions(+), 48 deletions(-)


> +#define PPC440_PCIE_DCR(s, dcrn) \
> +    ppc_dcr_register(&(s)->cpu->env, (s)->dcrn_base + (dcrn), s, \

'(s), \'

> +                     &dcr_read_pcie, &dcr_write_pcie)
> +
> +

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


