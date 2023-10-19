Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 328DB7CF436
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 11:43:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtPYJ-0004Ui-CL; Thu, 19 Oct 2023 05:42:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtPYF-0004ET-AI
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 05:42:47 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtPYD-0008MR-6P
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 05:42:47 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-507973f3b65so9971420e87.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 02:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697708563; x=1698313363; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cnz5jDoGJyh0DY4HjdQ/8ALKwdxQU6M15ROp/FZemDA=;
 b=T/GNi9HXdsfiEORdVRPm8bLFWieIUP/ldZILcHVTqGVKd255AJ8WNkcxQ0K9FQYejP
 Trw+oxYRun7OtLzV7hiD5hgX1o90gFzOIv6JrX7iFt+IuEEyLgENQTVBVaxLnnR+vVoQ
 5zAq1D3QQKq/bd+WWdezPRJw2nvTHmsdbnRBB7czLx3Oha8OEndNn2LJXr8JnCfdiwdH
 h1RJGCewYzjL2QYvA2AqtJtq/GcrC6gWUF3gJe5+NQhZKPVg/fdp/URgQGD9SwIaHHEN
 B/Sdx0hwwlilYRYQfVnl99+Ju8bzreR8OOq5bs3P5m8wGVd7pVcGqOq3rVDQPF/n+svj
 k9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697708563; x=1698313363;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cnz5jDoGJyh0DY4HjdQ/8ALKwdxQU6M15ROp/FZemDA=;
 b=eIpsvga9mRSOii7/Go5R5jzLQtVFGvOkw+TZuMBsoH+jz5Pw63apP/3L7uMk7ovr9r
 5HAMAJ7o/uDOYPVt+hbgJv5lpGu0KluxYVjNTc96CFwW9jmndUVKtyTSQsyKvBzzaXWE
 gB8oUwjsbv498n4xOlqbA70p9LpVi1eeQgoVm67JqlHEIodnTIgUWkdaOER/UWVWZ1xU
 p+97lc+mB5m0NDWtlhUrQhHWNmFP0qhOsYvDGN4nmnHNpCMpJnLt5zyRRGsTPRE3zQTa
 AST1AhKRyFZqUhyPVbDC2CKd+rV26zFU3kdSXFyLRonKuTbPYTXxBbC2jJviLogp6ZHm
 uHYw==
X-Gm-Message-State: AOJu0YxylhxATGsSuZYqJz12VvJVPtYWzE9UQdu3V+UKOM/xkKpVeyr+
 AahEYcZkaWu+LEQH/gwLTN12Tw==
X-Google-Smtp-Source: AGHT+IEfoOKhLdOoxSsfzybAqbEiRz5y/vWoPaPBbkag1IGjtD52iPVzXbS5MobunwIKwC0zrfqOYA==
X-Received: by 2002:ac2:5b9e:0:b0:507:99f8:4f5e with SMTP id
 o30-20020ac25b9e000000b0050799f84f5emr1044884lfn.12.1697708563149; 
 Thu, 19 Oct 2023 02:42:43 -0700 (PDT)
Received: from [192.168.69.115] (176-131-216-177.abo.bbox.fr.
 [176.131.216.177]) by smtp.gmail.com with ESMTPSA id
 z3-20020a5d6403000000b0032db430fb9bsm4030361wru.68.2023.10.19.02.42.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 02:42:42 -0700 (PDT)
Message-ID: <dfde3142-c2ee-2ad7-48e8-10e5ce16f8bc@linaro.org>
Date: Thu, 19 Oct 2023 11:42:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 06/61] target/hppa: Fix load in do_load_32
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
 <20231018215135.1561375-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231018215135.1561375-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 18/10/23 23:50, Richard Henderson wrote:
> The destination is TCGv_i32, so use tcg_gen_qemu_ld_i32
> not tcg_gen_qemu_ld_reg.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hppa/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


