Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E89720AAE
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 23:00:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5Brn-0003qu-5D; Fri, 02 Jun 2023 16:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5Brk-0003qf-P6
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 16:59:20 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5Brj-0003tq-4u
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 16:59:20 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-30c2bd52f82so2575664f8f.3
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 13:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685739557; x=1688331557;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mZm+2Q99eZ96oVWicAojEX7M+GBKWEVCLo6QSsNrX94=;
 b=ZUVtQurXZXDSrW+CCaHsvVH7wXNgyOH/Q2pTWQzXTfhD3z6o/fhfL+8ShAoffKh2/z
 hNhkZzkK8UkJoxxb7hA5wjcwv9RG+xprDcM1o/kQfoLrykhNcPeKz8zxULZuW16i08iw
 m711SWfsg+Q0ayJsZgEWoGTg25IgZ8dRYHlunx4c6XZNnxR9dPX8NOmSCFyOkbkLL4Pv
 cCLRUgBjxlMG6Gu4HYyVcA0intIxsp/5gnLpqd4uqFPohn6n5Cipfn9ZoKDTvjlbsHUR
 lmJxvpTbvByveQ6DkRkWCwXwvIDmdbNNsN2zD5teQy46Pq9bQvOjfHUL2awJRHEVwBiM
 4Wfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685739557; x=1688331557;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mZm+2Q99eZ96oVWicAojEX7M+GBKWEVCLo6QSsNrX94=;
 b=SNJUNiuCojFU2OG7TuOhE1wDS+oHQEmeU2+jKWFcdBzFAVveXxK79Asf5hSMZ9wENG
 pTjzERx7y+qe5cWBqtco7cJ6sPwuRHNfPpb6XhZ6xjZcCcTpO9iYqPII8lnPqpuSLuqb
 an1ASGyAlggQcNuUw1yDb0vEtf1dUHUiG7bg6IMSNDidgzbgbbW2ck0QHhoIHiUK7gvx
 9mnycLXHXRyLGY/fF71CUPBjy7N4dT6DTXhejpZgJHh9YqM5w+A+0a1P7TfViHZHAjxJ
 Lh+SH6g0goo4KGjfOqMgyETXt5p+3zoi/OmEHtnC9ASVLqc3d4C4ztgAI2IlgifVXWmw
 xePA==
X-Gm-Message-State: AC+VfDw4tH9MEDRWUjLCZ02AXY9508YPVS6/YDKFoJdPfVw/j6PlUXH4
 NV2fopUp5G9PPb2e7p4BVjlqlQ==
X-Google-Smtp-Source: ACHHUZ7LejdViNRugi+stP6gB60kKVzxcHfz6NqFNM9IDjdEIvgdjXcAKDS2gfDvsKc+7Gcm9X7+6g==
X-Received: by 2002:a5d:4d01:0:b0:2ef:eb54:4dc0 with SMTP id
 z1-20020a5d4d01000000b002efeb544dc0mr869657wrt.51.1685739557689; 
 Fri, 02 Jun 2023 13:59:17 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.218.254])
 by smtp.gmail.com with ESMTPSA id
 cx14-20020a056000092e00b003078681a1e8sm2623820wrb.54.2023.06.02.13.59.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 13:59:17 -0700 (PDT)
Message-ID: <b585898f-86b1-9549-629f-838db52bf3c8@linaro.org>
Date: Fri, 2 Jun 2023 22:59:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 41/48] accel/tcg: Tidy includes for translator.[ch]
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <20230531040330.8950-42-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531040330.8950-42-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 31/5/23 06:03, Richard Henderson wrote:
> Reduce the header to only bswap.h and cpu_ldst.h.
> Move exec/translate-all.h to translator.c.
> Reduce tcg.h and tcg-op.h to tcg-op-common.h.
> Remove otherwise unused headers.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/translator.h | 6 +-----
>   accel/tcg/translator.c    | 8 +++-----
>   2 files changed, 4 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


