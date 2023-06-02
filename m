Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC468720A13
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 21:58:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5Atz-0002vu-9U; Fri, 02 Jun 2023 15:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5Atl-0002tP-7E
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 15:57:26 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5Ati-0000qr-DI
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 15:57:20 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3f60e536250so27989035e9.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 12:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685735835; x=1688327835;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2fzGVoQwkh7n2rngSk+6D3F8Wf7TQnDaQMpjWQRrkLQ=;
 b=QuTLX1sWEoopaXqSbAJi3ehWxEZa+8oMoG3HwEhtBnauoAhra37ZG9Dp5RqO7nJy2X
 HU1F2lWbaPMyb7AYn4B1eIVcWo+WjedgdZrz7dB4LZdHCyb4YoSUG5/dJNC10O1TrUqh
 NAVidA6n3k09plLiTvYPyXjWMin03d9otNDSUSsWfJKhHbW06jC5+Qaot9NUolYO91a2
 jqopmJWc713c/bqQeNyOBrOcB6E8LUYtF+OSx2zvkffe1JxMguaQxE2JPc8iX7co9jWu
 K7pAl+Jt7TvVBD2NgtUNS1Xoc9n7l0UI1hO1L4e4maq9XcS8b6XdKuK2LW3LtBkX109H
 GJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685735835; x=1688327835;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2fzGVoQwkh7n2rngSk+6D3F8Wf7TQnDaQMpjWQRrkLQ=;
 b=Zuf276Nu0GzzXQRNJYf6vNRQd4wXqxnkKXwWnSzjvzXUoF9gTYOuo28l8YARYNpQkr
 VDDBNIwXWBvjb19xGoYzo1/zBZjm4fq3NwPWPDcSwt8P954L5amJRwojmeU505qJbBlW
 IYXc5keVlKVfOWVNbs451tMGIgt4P+T7HTGD8Ry+ehKbOkmM4vSjp2xg7tKuQYYGIocg
 gDqmrXPqUKi/hy0bKWEGupeGjCMXFhML2M2HHEC+DSS5l7VdZ/FYjk/GrHV8HxtrVfRj
 kwtKvwWICJ0CkTTta0sQwTew0sV649MBI1o3r5QN1YOX4ZAD43aFmFWDZvcZWe5J+tWs
 9g8A==
X-Gm-Message-State: AC+VfDwd4RYYxKxfrNA94Jn7lDv5e+CTkuJdtCY+LshnAS0BDG1scs4/
 RtgilDWufrmndcUbEfHoRwPBhA==
X-Google-Smtp-Source: ACHHUZ69X86o707raKUqmTunt5FgGnj72+33ulqusFHzrqcAxeySOCF6Yv5MNOOJ4WbYQYQ2LCQI1A==
X-Received: by 2002:a05:600c:1c9c:b0:3f6:286:95d with SMTP id
 k28-20020a05600c1c9c00b003f60286095dmr2844246wms.18.1685735835294; 
 Fri, 02 Jun 2023 12:57:15 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.218.254])
 by smtp.gmail.com with ESMTPSA id
 m24-20020a7bca58000000b003f4dde07956sm6480762wml.42.2023.06.02.12.57.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 12:57:14 -0700 (PDT)
Message-ID: <3a83c3a9-1fbb-d5e3-471f-0daa02d877eb@linaro.org>
Date: Fri, 2 Jun 2023 21:57:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH] target/arm: Fix return value from LDSMIN/LDSMAX 8/16 bit
 atomics
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-stable@nongnu.org
References: <20230602142219.1999756-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230602142219.1999756-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 2/6/23 16:22, Peter Maydell wrote:
> The atomic memory operations are supposed to return the old memory
> data value in the destination register.  This value is not
> sign-extended, even if the operation is the signed minimum or
> maximum.  (In the pseudocode for the instructions the returned data
> value is passed to ZeroExtend() to create the value in the register.)
> 
> We got this wrong because we were doing a 32-to-64 zero extend on the
> result for 8 and 16 bit data values, rather than the correct amount
> of zero extension.
> 
> Fix the bug by using ext8u and ext16u for the MO_8 and MO_16 data
> sizes rather than ext32u.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 18 ++++++++++++++++--
>   1 file changed, 16 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


