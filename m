Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4D878B64A
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 19:20:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qafue-0003hU-LL; Mon, 28 Aug 2023 13:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qafuc-0003hL-MN
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 13:20:26 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qafua-0006ve-I2
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 13:20:26 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-68c3b9f8333so1591021b3a.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 10:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693243223; x=1693848023;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FnotyBuQpX6ZzYhrVxn8pvXqrFF1i++N5oRo2mNCnyQ=;
 b=mt9F8GG37DVAyQmVnmFRG2YX/xJSzFMne1iD8c4Exc5wQ9+6mIFaGW5LQdZuearqlB
 E2xDsfC/Md/DO9ZVWMvXfy6MLQKXROwzg3FzjQ5V6o6F3FnGpiu7iqu+sLWELdwCc+0V
 N8LYxk6nzw2ppsjPJjRf/wgl4iPz3W/sbP5u+RP2YLGQiDcG//lSH31i+H8+QUPNbPnQ
 QB7RbfX7FlZzgcScKEIqbYwkWosze8dWLoxR6Zk94mqPd9lj8RquEpSDJ3VW9a44x8+c
 Sfpf7ATWubdCCF2MLKBQFHkXnloqZR5XxB+gYKMGSCCtfMhzR43vyRCkaEyqf88JX2I5
 jMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693243223; x=1693848023;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FnotyBuQpX6ZzYhrVxn8pvXqrFF1i++N5oRo2mNCnyQ=;
 b=LyyY4Rm4/cvJqCJX8RAldif8w+MNEYwC9FPWIEWDo6prZ5nYxzv1s5rmR+4aul3TkD
 x7/ypiDMVnbb1m7dRrflHBHbI32ICgjypIoRkUgq8s+b4yZT5YjQ3FDXDTjIeQdERkB4
 PXt9o1GxYb48rTA9vtLGvqARS/aHjzMriYjFFaLY50Peb7ERj9bBWw1Qmbqi11U1cZ3P
 NxgYfp+8xrCIKAV+OrV4X1ykbcmgkOTBwA+i5Qt6V432Ew5EuFJIe2xjrZpNQCVoh+cR
 kDZPUxsLN0VMvt5Ph/cYP/qEos5+SjRb383dR1gFnpEzkoNOi9URD7NqKmWhtXjbkQ92
 VAUQ==
X-Gm-Message-State: AOJu0Yyzwur9QFRg1eyVU3I8lUJry0aZ72ctHtNySsFkA3lM/8KdQoUa
 hzGiMEDwBIseEGLHULglLKBzhA==
X-Google-Smtp-Source: AGHT+IH9H5iTC1n9kNAXkbS2qVdJG7K+sUoRaSRKqn7ttZ5FJTVVKKlEf6JUxg2sWiCx3RbTJh3xvQ==
X-Received: by 2002:a05:6a00:2307:b0:68b:daf2:b2d2 with SMTP id
 h7-20020a056a00230700b0068bdaf2b2d2mr412748pfh.1.1693243222792; 
 Mon, 28 Aug 2023 10:20:22 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 z3-20020a63ac43000000b0056c41227d4dsm7546701pgn.90.2023.08.28.10.20.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 10:20:22 -0700 (PDT)
Message-ID: <6b11374b-7b19-0650-3fde-645cd8af710f@linaro.org>
Date: Mon, 28 Aug 2023 10:20:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 09/11] tcg/loongarch64: Lower vector saturated ops
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, WANG Xuerui <git@xen0n.name>
References: <20230828152009.352048-1-c@jia.je>
 <20230828152009.352048-10-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230828152009.352048-10-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.169,
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

On 8/28/23 08:19, Jiajie Chen wrote:
> Lower the following ops:
> 
> - ssadd_vec
> - usadd_vec
> - sssub_vec
> - ussub_vec
> 
> Signed-off-by: Jiajie Chen<c@jia.je>
> ---
>   tcg/loongarch64/tcg-target.c.inc | 32 ++++++++++++++++++++++++++++++++
>   tcg/loongarch64/tcg-target.h     |  2 +-
>   2 files changed, 33 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

