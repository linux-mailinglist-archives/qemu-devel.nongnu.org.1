Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0478386D3
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 06:43:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rS9ZH-00040n-DG; Tue, 23 Jan 2024 00:43:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rS9ZG-00040Y-4h
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 00:43:26 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rS9ZE-0007YY-Mj
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 00:43:25 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40e7e2e04f0so43393065e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 21:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705988602; x=1706593402; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lyIiC1EIiQskfLSoDkAPudnvFPb58Id/R1RX4I7i1uU=;
 b=Ers4Tg+xDM1xtoWL8TFXQj1CA/6Z8RaKzzE7eNS3S7pS1IFi1pGGyiu1ghGjf0xdwz
 NPPkRh5Dbgm4Z6Y4D+kkiJmjuH0CBSGDGmTEs9VNyrkXWhe9ELAbiF06y2XGCgUnwyAN
 16OeklgNoCgIjmJs3nFujPK9L3pDL+N5dLm1CLhmdxYAOBxHVb8SNIdLHETbBmtr32zc
 HMOykoHejydf/yESVIeyKCrGeLycbdiJvUqeSdVnj7Vi530HkZ2oKH9hq9cFXwAeor/J
 BtRY0aaV0Mu+TgDCqb2whUbVg9lRNV1KuoKwFWvBJa4UyYqY6DQS0Iv1AGe3w4rWvYeL
 juYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705988602; x=1706593402;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lyIiC1EIiQskfLSoDkAPudnvFPb58Id/R1RX4I7i1uU=;
 b=hAJFrr+U6C0VzOBJ1ihk1f+rvGPZvkYR/5Yz/U9sTw/N+94QhgPl4eEjN1LUWxoO1z
 GundhsNDAZ5yQE+8oivZA+l4JOia5FPb+Y4efnTFrn4eI3FbHgTAdaYPRiqJN4SHJGrt
 iXEIb8oz1UB6Qrodpf07NcDYF5SYpY+DdEBgUJgVnxB/FZJF1gAAaKxt6DdrPxpR4L31
 xne6ntqnx0ZMKD6E6T+fovskjTs/r0XGPtoP35pvSfWB2QeC1EcRI8mleVLkJv8ot2Cb
 Yg7HvJAScxOgFIFN4TVxdFN985JI4pRnxQLLMQn9cBTAv2IeQXaPD/AShnfBmIHA0ScH
 2UpQ==
X-Gm-Message-State: AOJu0Yz4PWhh52DdzWhIB4LtlMku2TeMYMQscl5XO5bJ3QgAVpCOhp3v
 wCwvVmgoXtUS5AsCTKfG8uj7JxTMdTkwcTEzjVp1E6M5m4C9wSgR2h271vXHS9w=
X-Google-Smtp-Source: AGHT+IGrZToKgn6ZXDHOyxq4nRmc6VnPbgd6V1B4eluB0fE8oZBVPs/53HJwiX8rI83tc86q7KSlwg==
X-Received: by 2002:a05:600c:19c8:b0:40e:4f81:3f68 with SMTP id
 u8-20020a05600c19c800b0040e4f813f68mr174026wmq.16.1705988602621; 
 Mon, 22 Jan 2024 21:43:22 -0800 (PST)
Received: from [192.168.69.100] ([176.187.194.78])
 by smtp.gmail.com with ESMTPSA id
 m35-20020a05600c3b2300b0040e541ddcb1sm41322468wms.33.2024.01.22.21.43.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jan 2024 21:43:22 -0800 (PST)
Message-ID: <687527ef-70c0-4cb7-bb3f-262e60556979@linaro.org>
Date: Tue, 23 Jan 2024 06:43:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] hw/riscv/virt.c: use g_autofree in create_fdt_virtio()
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
References: <20240122221529.86562-1-dbarboza@ventanamicro.com>
 <20240122221529.86562-6-dbarboza@ventanamicro.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240122221529.86562-6-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 22/1/24 23:15, Daniel Henrique Barboza wrote:
> Put 'name' declaration inside the loop, with g_autofree, to avoid
> manually doing g_free() in each iteration.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   hw/riscv/virt.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


