Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F227366FA
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:08:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXKK-0000zp-52; Tue, 20 Jun 2023 05:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBXKG-0000zJ-9M
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:07:01 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBXKD-0007qD-Tw
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:06:59 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5189f49c315so4671511a12.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 02:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687252016; x=1689844016;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uEXy/sFbNilZkusZAAfg0sxo7ANWRwlcWgIGsfEGbpE=;
 b=ECrUITd9L5kwoLST9rrbIvbOCvORuaZuBCYN/cXF9mb0PViwibuE/YiRCL3yByQn87
 w/j5WjS81wnEnrqMoVhxxp0XhE0ys32Aprz4PF7k3hMLG6kfkoCYSredIMFMiv/Vb6i0
 HY6l3zWTrffuU0SLC+U+Peigoagx0zZfizFAO42Ovt41p13Pwfrj9y26G3hzPcCmPCd6
 0H+TDmukxVR71ZrxPa8x6ep0RSydP5Hnlg4BH69YPm+LbqrPkVIhOVt7BeQeqsju402B
 11z7NM+GIZyJhomKSgE97L9rG9fmcBu4b/bUVf6GyxUC7ZrVguku8VxMwRpZ4D+Ouv3K
 aGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687252016; x=1689844016;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uEXy/sFbNilZkusZAAfg0sxo7ANWRwlcWgIGsfEGbpE=;
 b=NKxCpw+RrRjLT7t60a1WIQY/4Wzgnxk0Jk0qnNIQNC4BnVC0wALNlVL2L89QVqa/5a
 AywBNAOsxWjpW1VbVmVUe41W61YUYGWS52/Ye/NyBypqe5TmWFZA0UaN6JLJlorB+OMQ
 kfx/kDvPFQckFTv9Y/poHs/ekioeAEMvvbccuow/iPuL/c2kqEBq9rfgcAtxCJU//XpW
 i1e2kZIvtZucpZ4omteNsTDCXGBDyn33iQwbqOWdyruxzseEeNdQnXo9DJ8rtf60zPt1
 NQIVej6o2CSn1/ceRwpMgKXROyVNNn8u2tawOFd8i72Btt9NDKWrIJ/ywVxE2OIFfjDR
 8JPw==
X-Gm-Message-State: AC+VfDxrvr/OgB3KtWSKGZwJd1iGp+plSSrLON9zLeRfKp0PJAFT1+dQ
 MHxg69Kj9pTfzpsWINmPSuCgSQ==
X-Google-Smtp-Source: ACHHUZ73sKnOfDgwWh7Zy13/uXy/Z0lTJkQmAUq1vMVyKWMjITGvQ9EUcGneAJBrBeu97YhkhFi6Rg==
X-Received: by 2002:a17:906:da8a:b0:96f:e45f:92e9 with SMTP id
 xh10-20020a170906da8a00b0096fe45f92e9mr10060744ejb.16.1687252016017; 
 Tue, 20 Jun 2023 02:06:56 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 t4-20020a17090605c400b009663582a90bsm1019233ejt.19.2023.06.20.02.06.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 02:06:55 -0700 (PDT)
Message-ID: <9de0430e-c74e-27fd-6f8a-c858a70fbba8@linaro.org>
Date: Tue, 20 Jun 2023 11:06:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 08/34] target/arm/tcg: Un-inline VFP translation helpers
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20230619154302.80350-1-philmd@linaro.org>
 <20230619154302.80350-9-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230619154302.80350-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/19/23 17:42, Philippe Mathieu-Daudé wrote:
> In order to restrict lookup_cp_reg() and set_rmode() helpers
> to VFP translation, un-inline gen_lookup_cp_reg and gen_set /
> gen_restore_rmode.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/tcg/translate.h     | 22 +++-------------------
>   target/arm/tcg/translate-vfp.c | 21 +++++++++++++++++++++
>   2 files changed, 24 insertions(+), 19 deletions(-)

While set_rmode is vfp, lookup_cp_reg is not.
However, you could uninline lookup_cp_reg to translate.c.


r~

