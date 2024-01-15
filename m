Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C20682E2A6
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 23:34:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPVX3-0001OP-GH; Mon, 15 Jan 2024 17:34:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rPVWw-0001Nr-DP
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 17:34:07 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rPVWu-0007SW-Sq
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 17:34:06 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d3f29fea66so51016145ad.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 14:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705358043; x=1705962843; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DTkAivCuD0DfeRNB96V/DsWva2aPG7hLD46T4T7sevc=;
 b=hRCEXBruNjlvWJDAJ2X6neMnAd/jBE5dDfmqg2Mwgz40dbEUSBEuYFFVj+OUiQYyv5
 lw7dde8UVD0LeHJx1leb7vwml/mGi6Ti0hrnwihvITblIbWet8DtGwnGRMj9/WjH7OL7
 xnz/4gQIle1AJO7ehcTTnv0LG0TOQmbe3JKxVHFBjEntZUuQiTBhla9RsZdUMDoDVLCt
 cBb/TTpgfA38p+ig8KUawMbjeHaANmjZbSXVLtzEPBLB4jaI2/l5LlTkKyh466Iqe31T
 AZVCeeEOChS+D6tGGhgEUmuBUJrDCIst6yHSjUBb5i5QA5DCMk+I3Vhfr7CRg3msXvfn
 IYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705358043; x=1705962843;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DTkAivCuD0DfeRNB96V/DsWva2aPG7hLD46T4T7sevc=;
 b=NGfc6QZOp5kGuS3AVokn3oTOlVDD1B8MKRX1jZQh+87YpKuHRSoXJvf3IF3Fnkgfpm
 C5kkgswjZDqWp9833yKUUb+rERWP3RmaXJtOrRUfa58B1bIw23WBVTM6LChBFCxQ5NJk
 pIblzys+Dlpi9ZuSvhpTLJXzM9f2lvRkUVJ71cCy0JaPfIS7gCHf84c/kb3/xJP+VVij
 E7WQ7E6A/WlOtxRbMc+SMyJJcBdP406jfiPVJ7TRxoWkw2y5ZD7QPzgpzvwI8/nzx0u0
 Wl1eaku808/z2xUa3iUFMwdWScbjWpCsYIIV8CPn3zOQ9O0YTSizVEIeS8zpuCPOAVtV
 ye+w==
X-Gm-Message-State: AOJu0YwQz4cQouo7AM8dSH4fS/oXmCbtqVxuzi4AsjpHL/JFC92hyuxW
 tg72IOGKvE+Buy+S20RCGByi7xV7i9EEyQ==
X-Google-Smtp-Source: AGHT+IHeOACsTR/DqaSBJ4MSbaAdv2b9ZSQqq1r/OcJx2j3o9XJhChG/imaCsMYQlW3HwxYYG+ncuA==
X-Received: by 2002:a17:903:40d1:b0:1d4:20b8:abf9 with SMTP id
 t17-20020a17090340d100b001d420b8abf9mr3459296pld.54.1705358042073; 
 Mon, 15 Jan 2024 14:34:02 -0800 (PST)
Received: from ?IPV6:2001:8004:2738:1dd9:85fe:4dd3:358e:ec4?
 ([2001:8004:2738:1dd9:85fe:4dd3:358e:ec4])
 by smtp.gmail.com with ESMTPSA id
 e17-20020a170902f1d100b001d54c6f5ac5sm8104235plc.263.2024.01.15.14.33.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jan 2024 14:34:01 -0800 (PST)
Message-ID: <895f5218-00b5-48ca-adeb-e3a6efd112a1@linaro.org>
Date: Tue, 16 Jan 2024 09:33:54 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] target/riscv: add 'vlenb' field in cpu->cfg
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 max.chou@sifive.com
References: <20240115222528.257342-1-dbarboza@ventanamicro.com>
 <20240115222528.257342-2-dbarboza@ventanamicro.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240115222528.257342-2-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 1/16/24 09:25, Daniel Henrique Barboza wrote:
> Our usage of 'vlenb' is overwhelming superior than the use of 'vlen'.
> We're using 'vlenb' most of the time, having to do 'vlen >> 3' or
> 'vlen / 8' in every instance.
> 
> In hindsight we would be better if the 'vlenb' property  was introduced
> instead of 'vlen'. That's not what happened, and now we can't easily get
> rid of it due to user scripts all around. What we can do, however, is to
> change our internal representation to use 'vlenb'.
> 
> Add a 'vlenb' field in cpu->cfg. It'll be set via the existing 'vlen'
> property, i.e. setting 'vlen' will also set 'vlenb'.
> 
> We'll replace all 'vlen >> 3' code to use 'vlenb' directly. Start with
> the single instance we have in target/riscv/cpu.c.
> 
> Signed-off-by: Daniel Henrique Barboza<dbarboza@ventanamicro.com>
> ---
>   target/riscv/cpu.c     | 4 +++-
>   target/riscv/cpu_cfg.h | 1 +
>   2 files changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

