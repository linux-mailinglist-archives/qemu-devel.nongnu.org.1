Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CED57C87DD
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 16:30:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrJB9-00063o-N1; Fri, 13 Oct 2023 10:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrJB7-00063a-9P
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:30:13 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrJB5-00086V-5A
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:30:12 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1c737d61a00so18386645ad.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 07:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697207408; x=1697812208; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f+dpcsIUxREci/eqFeZZG0+YDLk+RVgns/JgWLNaH8s=;
 b=INDeBgJdNvGkpgqori1DBh0rpVeLgO28tPeq6dpTkPKtOV50b0w5/v+Yj3vaGtadVX
 KoeMIrxlwFo3okvF3sZ5Zt6fEkb6IrXYqW5aNLf0weJ5kTvYghRJQNluFVRMDJ7Ufg38
 DcV1KmD1eKlzHT9FJqKl2Jzax8dt3x37udV05TzBrbGHY2RrBxHuyNAZGZ4SZ1y6mqjR
 62QoiESdTu71QHKJzO9ozcPpiYzb6Pc18I2QW1FEfWFqZQNOoGpZCt6jcLdkyHFXtzuQ
 g/vHHizYctQGCnaOD+0lJchYAkRwmZV+9J5fLDZxgzzmWBrvZumQRLFjs9pMdDfXOVjw
 P+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697207408; x=1697812208;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f+dpcsIUxREci/eqFeZZG0+YDLk+RVgns/JgWLNaH8s=;
 b=LXDXV2WxvA4++D41PceZKFv17dFCe6XC8dOmw5kD8GsNyAJGT+2/Vc27ocFKjH2bAQ
 CoSUnUviuQ/e7FmzkeePxB8IipbHuWOtYgjpMqDdO4S514/P0PSuLCsk3n2KZ3XDPr/F
 FNr4s6vp8mWbBqh+rp9xQN7DEzqtowdyfJWc7Nzcwa/p2NST9LYBIgyRd/dxpWX516OV
 pn2RGhWKmsOMpYhSpHIJkPT7zeIofYroHdmRaPD4M7rjHfzM6Dz+wd+41n+U7LDxqMvp
 kGLRsqRuWkKK+1yZy8+Uys26AbsPjzFzxqqCmwJyLEGSj0yT8XqXs0Krdx8DnJ6HQkcH
 PNrg==
X-Gm-Message-State: AOJu0Yy1rTLV7HOryuZFzRjp9vRd9W/TYgUAJqLPNnL4UVoAwu0rBPXz
 Z7CSCzwt8ofrKJpOMudqwJKn8tjtwPgxyC2Mtww=
X-Google-Smtp-Source: AGHT+IGz1p7/NEejqSI/Vfx+cCbZIP+Zq76QIe86R6uqXOhDXmqbIXCXKjozLZyHYrE3uTFF4OB0DQ==
X-Received: by 2002:a17:903:54d:b0:1c6:25c3:13d3 with SMTP id
 jo13-20020a170903054d00b001c625c313d3mr27408802plb.6.1697207408478; 
 Fri, 13 Oct 2023 07:30:08 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 e7-20020a17090301c700b001b3bf8001a9sm3958048plh.48.2023.10.13.07.30.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 07:30:08 -0700 (PDT)
Message-ID: <3862f391-7f49-4f77-8f15-2564144f0e7c@linaro.org>
Date: Fri, 13 Oct 2023 07:30:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/16] target/loongarch: Declare QOM definitions in
 'cpu-qom.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20231013140116.255-1-philmd@linaro.org>
 <20231013140116.255-9-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231013140116.255-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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
> Reviewed-by: Song Gao <gaosong@loongson.cn>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/loongarch/cpu-qom.h | 24 ++++++++++++++++++++++++
>   target/loongarch/cpu.h     | 10 +---------
>   2 files changed, 25 insertions(+), 9 deletions(-)
>   create mode 100644 target/loongarch/cpu-qom.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

