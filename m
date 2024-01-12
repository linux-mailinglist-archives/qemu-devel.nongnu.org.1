Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F170882C701
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 23:09:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOPi7-0005jV-Pe; Fri, 12 Jan 2024 17:09:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rOPi6-0005jI-4q
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 17:09:06 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rOPi1-00021p-7F
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 17:09:03 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6d9c2db82b0so4051671b3a.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 14:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705097337; x=1705702137; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=drMaOxPFaFOqlHbnOCnwDSHSRJVJiurVSKIJ+Wm/9uM=;
 b=OwqnpRugRbrVN31R6oB07NR7BQc+iko83FjOopyx7Rv3uuCYKu0UVGpWSi+yvRjmuV
 UrgRroASZrqkyXPaS+a1wqW6dg57F1Lwvwaraq2IFzTb2/OMbeKNz5wMrhTNPzDPQFPV
 Tz3MDn2saZNX18/7PEDtPymPrUgphwdBCe7/i5wGbiKPwV7X/KR/IvJrJd4piD7F1Hnz
 WI4t7HBaxRBX6iTASUkyrMTBdS1wiECIgeDFwb3yicjxH4NegqUwEy16UZ6lZ0HnAWoV
 ZxCEp5pOZeB+hm6nTBp4JXwSEnpz9ImjsGa3vjUvpjEYiHP8gBPcxNomWkHtQzbe/L4E
 ysJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705097337; x=1705702137;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=drMaOxPFaFOqlHbnOCnwDSHSRJVJiurVSKIJ+Wm/9uM=;
 b=cwgUxk7qZbMKpo5BKE1kHlB5i5ZI4Lgy50voC1YpFNGvvdbc10cQIzqSCEoy/9KEpC
 5rgrj7DLyFr/Fqrx/U9JWuH/dlqp7Az9RiGcCX0yjFs/d+pLQeGsX+JZi8Rkkq+XdPzq
 s0vg0ad9PDnIwwEHSccch/+Cho/fYvKMT+t10i8vMWWtCtQd5lduP0GTDCyUz8KaWlTR
 ijZr1ogRd9SuHuflg+7KkjMcbRagovIcS9dCHFbM+bNx32S96MhW+gwASfQhk6rvayxR
 3yDpBxTQZrcYL/edI7aWaXslSygX2nVAT8G+Iq0Z23jHrFhHPQOSDqojqyj8UTE3ocg/
 /RwA==
X-Gm-Message-State: AOJu0Yzl5AP4jlGDruiwRCeyJrW+paRf7rnulP6BKxpJgQKPsG7r1ds7
 1d9+JzkRTNXEEIo44KWTTX3GDyUOtklFIQ==
X-Google-Smtp-Source: AGHT+IE4yJkQZLm6GFDsPsQy5WTGIpAnXHIraC1lKkKYk2Ur4un/tx4KdGQrjqsJRyf1P1d2G+l56A==
X-Received: by 2002:a05:6a21:788f:b0:19a:32cb:2d50 with SMTP id
 bf15-20020a056a21788f00b0019a32cb2d50mr1360480pzc.35.1705097337201; 
 Fri, 12 Jan 2024 14:08:57 -0800 (PST)
Received: from ?IPV6:2001:8004:2728:2ad6:e985:c1c8:a4fc:508?
 ([2001:8004:2728:2ad6:e985:c1c8:a4fc:508])
 by smtp.gmail.com with ESMTPSA id
 u13-20020a170902a60d00b001d4b73f60e4sm3641032plq.149.2024.01.12.14.08.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jan 2024 14:08:56 -0800 (PST)
Message-ID: <530e81af-c8d4-4aeb-95c0-ae754da56e72@linaro.org>
Date: Sat, 13 Jan 2024 09:08:53 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 9/9] target/hppa: Fix IOR and ISR on error in probe
Content-Language: en-US
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
References: <20240112102927.35406-1-deller@kernel.org>
 <20240112102927.35406-10-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240112102927.35406-10-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 1/12/24 21:29, deller@kernel.org wrote:
> From: Helge Deller<deller@gmx.de>
> 
> Put correct values (depending on CPU arch) into IOR and ISR on fault.
> 
> Signed-off-by: Helge Deller<deller@gmx.de>
> ---
>   target/hppa/op_helper.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

