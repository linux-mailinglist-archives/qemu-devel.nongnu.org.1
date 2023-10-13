Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 811997C87E0
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 16:31:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrJBn-0006eb-JI; Fri, 13 Oct 2023 10:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrJBk-0006SD-0H
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:30:53 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrJBg-0008LC-Qu
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:30:50 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c9bca1d96cso17460285ad.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 07:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697207447; x=1697812247; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1ezjW5nHXiXdPfRcv1vnFfHPeYIU+jiBtVyeYyfHeqM=;
 b=pNm4s/eczsYPXCkMLyddC7s/jxpGomdHXOyc/CrtdilCNGQasmdoGFKLkhz3heTR1Y
 8kguEtEwPxG4HTaVvennt1uC+VNv27IzRz8umchHLSvWxb6ShhuA6lDXyyo2M/ly5Zr5
 2foRAc3aEUf8x6e7l9Kihii/DQuBoc9XQdH8811SG+8Zj2uFlJWC1uE/MY60Oy7thGhh
 NMwTs/K4BAGOnx8jDEHuGwXXs5JOSlM0R64Lgmc1/6AMRlw8OZ7RC4zm8/fuHSFNaSU2
 /YgapuV4jsxV+ggZlmQWvleDlWgjO3qATCrkqEJuDHlh7Orfd9zv5X4okZkYsPoWtgxM
 QFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697207447; x=1697812247;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1ezjW5nHXiXdPfRcv1vnFfHPeYIU+jiBtVyeYyfHeqM=;
 b=fOkdZH2gKIMnp4VIwroexoBakaXIsiIVHKcw7uxGfxszKwU4kUMwMfJWS35X60xH1G
 GUX890O9zR757mc7I1vGDq88YIhTtG7O7KqEqfbUZ4VML1BgOX7EyZrRSqyMLDsawTSa
 1T7/SglKtMdcVIv/iwp8kcyZ4cGFEOGtKuQXYvcPJuKQRi/to9zE0e/lyz3DH8TQWNQp
 cdWPagxN9KuUy/Vm6CrXCWr7lvWip6R0VLIGuugu1UH0TqMvPDiNgCjFSWiVjpfkTtD1
 4fPT9sl1/lkmC5wRkYe5mF5f7tQrEY1Bm1nIUsEb6e+m44NzkNXwnGJOSrEKVxboZQTY
 xZew==
X-Gm-Message-State: AOJu0Yw2S0epdogQMrMBTmfE3lAr4Tosheyfh1IcswGmMsmzgbmB9Gyz
 fbaKhtVLh1xVF5mHKRSb2bQBJZ2XwKyU8h17vTM=
X-Google-Smtp-Source: AGHT+IGRc6AQrkHvoQB/GIdD4ju5ZG/XYJXQEMOWjaYH+sMZKue5A6fnh4J16BDDx+5/9YDGwv7vzA==
X-Received: by 2002:a17:902:d488:b0:1c8:9a60:387f with SMTP id
 c8-20020a170902d48800b001c89a60387fmr16204301plg.56.1697207447585; 
 Fri, 13 Oct 2023 07:30:47 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 e7-20020a17090301c700b001b3bf8001a9sm3958048plh.48.2023.10.13.07.30.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 07:30:47 -0700 (PDT)
Message-ID: <d6f1c791-99c6-4021-b786-df0d5dcf0487@linaro.org>
Date: Fri, 13 Oct 2023 07:30:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/16] target/nios2: Declare QOM definitions in
 'cpu-qom.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20231013140116.255-1-philmd@linaro.org>
 <20231013140116.255-10-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231013140116.255-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/13/23 07:01, Philippe Mathieu-Daudé wrote:
> "target/foo/cpu.h" contains the target specific declarations.
> 
> A heterogeneous setup need to access target agnostic declarations
> (at least the QOM ones, to instantiate the objects).
> 
> Our convention is to add such target agnostic QOM declarations in
> the "target/foo/cpu-qom.h" header.
> 
> Extract QOM definitions from "cpu.h" to "cpu-qom.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/nios2/cpu-qom.h | 19 +++++++++++++++++++
>   target/nios2/cpu.h     |  7 +------
>   2 files changed, 20 insertions(+), 6 deletions(-)
>   create mode 100644 target/nios2/cpu-qom.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

