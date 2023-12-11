Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BD380DEBD
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 23:59:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCpE4-00026G-5H; Mon, 11 Dec 2023 17:58:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rCpE2-000261-8k
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 17:58:10 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rCpE0-0001cq-Oa
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 17:58:10 -0500
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6d9d59d6676so3779854a34.1
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 14:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702335487; x=1702940287; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9rlToK5lP6ee80zzg+71LHqF76MHi2bnwBdqidUpE0I=;
 b=two9D9uht5UTq0NB23oqgxaf4jH21ZktiZlbVrtXHQko/7FqMjkjbg2Utz1JfpA4ar
 lS5gRVBa3BNhbgjcmdf81sEUYCGGX6ZW+EWIIYVBNSYogFRL5iveHnAa3iNzElyP4xfb
 AyKRIrXqfA+c/waPDo6ERRNLuoE2nQEHOWN0F+AHqpl7y7X22gwxps20jcvoT6gcqo3c
 c7S9pQbmFIc04nOcLzsVqfgum2z8eXPImzqT3EHoGeplkzYaJXSx++BA+0YQxgMZg+6n
 UM/Z2d2VzQlavhHhM6EyPcF50YzauQSs2BDpLOjZihLj1GzDwsL01UbY4Yg4XyfL6qdN
 rz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702335487; x=1702940287;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9rlToK5lP6ee80zzg+71LHqF76MHi2bnwBdqidUpE0I=;
 b=qFr7PLcg7X/zSPABLCxAe5j0njysWn8yOb+taJtk6nUSnom1HSsQflf1E2WAX118Ak
 9n9+3O8iRKFEsIWlgFOTcxwhjA2oGAVxhfAVTbAFZoKMSnb07PxVZ0XZy5Ho1BeFU/KD
 g62PJJjxN1nDFIP/Ilu8OhrfMmubyBlHlBTy5Ft5VGwJKm6f7l0OpgSwIUe/dCoXUJc0
 qo/xo+QWgQOCwDrTQFKIyY6k4RcxebtAgY+Ty8uPkIAvZzDWXbwzOe3r2C2m+VeFkAoL
 K1x5r9oF8Kaz7qEXP6k8HxhZCgmvskKcvt56YdNS6feuYw4OWY+9gXAtdb0EBL5/eUq2
 G2jA==
X-Gm-Message-State: AOJu0Yxduag4IUCR1EadgTwkAsZNDDWaMNcNb2GkjIOZcdIH4b4RDLCn
 obzQSIPVJp+SM6i8/XPKqDCWFw==
X-Google-Smtp-Source: AGHT+IEGcFKjw0y0z1G4KI02Xs1jTuCp2FkyDoyR35uNNfvaw7/dOmbQkTE1fCr0yhkxdY3r4GPQEA==
X-Received: by 2002:a05:6830:140e:b0:6d9:decb:98f4 with SMTP id
 v14-20020a056830140e00b006d9decb98f4mr4447213otp.53.1702335487142; 
 Mon, 11 Dec 2023 14:58:07 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 y19-20020a056a00191300b006ce75111ce7sm6794237pfi.162.2023.12.11.14.58.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 14:58:06 -0800 (PST)
Message-ID: <9b95b437-71f8-4060-9c11-647c2c2a92e6@linaro.org>
Date: Mon, 11 Dec 2023 14:58:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/24] semihosting/uaccess: Avoid including 'cpu.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20231211212003.21686-1-philmd@linaro.org>
 <20231211212003.21686-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231211212003.21686-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
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

On 12/11/23 13:19, Philippe Mathieu-Daudé wrote:
> "semihosting/uaccess.h" only requires declarations
> from "exec/cpu-defs.h". Avoid including the huge "cpu.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/semihosting/uaccess.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

