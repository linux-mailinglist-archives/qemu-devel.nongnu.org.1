Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5159182FB43
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 22:52:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPrLK-0008P6-AT; Tue, 16 Jan 2024 16:51:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPrL3-0008Nn-IK
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 16:51:18 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPrL0-0000P3-3y
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 16:51:16 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a298accc440so1274586566b.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 13:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705441871; x=1706046671; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G+HnxLHRBGIwiV9e70ZI9wLdaRdcO+zmP9fvOwmfEC4=;
 b=LnvMhJ0vx/mameGikA0f8rUhI7aXBB3KIFiyUwJ1dgwfPLl3V/pvleknbD5xTSqO6c
 7ACQnp9w7dLLUh38kaV7zmYM3R/Ied//S/ELIu71UIWFWs8kDMqiLT0cRiftsTMvl7Iv
 RpVtMFqV4/1t/YipClcCVK6/j1znnvC++jjp/EKm/v83Cul1quqkNWpq00WRzf+0b7Z/
 2xNl9RPiekQPvZpbAbmxoNrIZ8/cjWKxtsYxbgpDOy5gySdhuxs2Gy2ojjOdld4VvWpl
 fYg4PGDrIYKTpopwWNDwc9D5JXVqL5w4DX7t29zCRD8eHYuhGKzzYOK/938ALhaZPF5d
 BKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705441871; x=1706046671;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G+HnxLHRBGIwiV9e70ZI9wLdaRdcO+zmP9fvOwmfEC4=;
 b=ILQAq8mL0sbgBekc61EbXrQ+brQ3Vdx6jmt7BK2StIRsOUAqIlJrys6qaMH5HmHDie
 viJoJP9R+orC3pFNc+x+uGe4ulMwhsykntO5vyKwNOm1pByM3OYpftHA1zu+kOPS0PVx
 vgOIMH3ShHV7E8++2kQwu028POSIbG50fE5ZhFpAFwJDuQxzonz/VsN1S39GSLtQMOGk
 3fGgBfu/s5LT1KdN2ukgt+GT1OArGZXVN8qp2xXerJQqz2ZRPg+wKuu5p9bNiFTlxUjC
 PDOiYSFGbelvA4xnPhxpGeirji3BdntrAsF/ggBeGot+b7iTz4cP/ZXA9JzzPcQG8rbA
 M96w==
X-Gm-Message-State: AOJu0Ywq5AfCGrO1I6XC0SIWrZrm29PGAMVof6asyYsw8LuisV7geKAg
 0ZdJrxPvbAEsNuSBPi5c4ZNR2RoC3mhGKA==
X-Google-Smtp-Source: AGHT+IFbAXWDsw+9atBbBKRJodqZS4qR54a3ohOFh2q6Nqt1I8sDBI6UpPypQpwnniZaOGCST3EWwA==
X-Received: by 2002:a17:906:c24b:b0:a27:9fa9:4d9d with SMTP id
 bl11-20020a170906c24b00b00a279fa94d9dmr3926503ejb.104.1705441871548; 
 Tue, 16 Jan 2024 13:51:11 -0800 (PST)
Received: from [192.168.69.100] ([176.176.156.199])
 by smtp.gmail.com with ESMTPSA id
 cd6-20020a170906b34600b00a2c8e9918casm6378509ejb.198.2024.01.16.13.51.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jan 2024 13:51:11 -0800 (PST)
Message-ID: <d1adf68f-9396-4add-a024-aa18456e6e72@linaro.org>
Date: Tue, 16 Jan 2024 22:51:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 31/38] tcg/ppc: Use cr0 in tcg_to_bc and tcg_to_isel
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20240110224408.10444-1-richard.henderson@linaro.org>
 <20240110224408.10444-32-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240110224408.10444-32-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/1/24 23:44, Richard Henderson wrote:
> Using cr0 means we could choose to use rc=1 to compute the condition.
> Adjust the tables and tcg_out_cmp that feeds them.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/ppc/tcg-target.c.inc | 68 ++++++++++++++++++++--------------------
>   1 file changed, 34 insertions(+), 34 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


