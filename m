Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A64670E6CA
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 22:43:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Yqs-0001wX-KA; Tue, 23 May 2023 16:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1Yqr-0001w2-2r
 for qemu-devel@nongnu.org; Tue, 23 May 2023 16:43:25 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1Yqp-00079f-Hw
 for qemu-devel@nongnu.org; Tue, 23 May 2023 16:43:24 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-53404873a19so48801a12.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 13:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684874601; x=1687466601;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BMgov0LAt+U6Q3gImADTtS4AI5GTurQxkgpCyPXD2OA=;
 b=qKDqGNUtH/fbafGeG450B7kS+15Qwnpj9EYMpVSQc3KZZZZvYem1eyuUURD7o9wGIA
 LPzbKHzE7wiV5idv1trlnTQXAXaTeDol0pQD3bB5P4ZBdUpEmoP+KwGYqpBYtY5SEBHU
 ChHb0mXPxq5fjSxckEIfQHMzLc4lBVVB//TCL9nH8y86ocYeiXRpltXQttuHpM88pKJ8
 /Y0ArtQip2h2D9DEoMqYKPd79WHYuUzaUzLb55YxOeB/j8E36f4N77KHLX3/40uNe0Q/
 7B5dGBFZZAH9zP0rYTt0x+IH+myhtUulRmcQgYMQ3yNyO5dBK1H+hkJ2fC78mNGDPwXY
 Y/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684874601; x=1687466601;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BMgov0LAt+U6Q3gImADTtS4AI5GTurQxkgpCyPXD2OA=;
 b=WoKbcGmsx1vj1aX4m/x89mWMjP0sa5V0y/rfot7CWDSM4Zvk2agntE33MiqzqCh1Kf
 /XAjqs3WGzUkHaEzzZ4Ylz+LzzJ/zwnb5dRHSEe0kMGXidW2KywQnUL4YVgaKXzvNbg2
 wiHUxC5ERdXZsE4TXqG+mWr/GI1+zQ5n7i7aM78Ps9Aq8NOKwCokrx9+4lQqgfGYtHyh
 cIcA8VvZCnIAHeIHDvM0UGBcsSvPbgvpP32Bb5/4EOXWLFHFBSdOJxJEAOwXmsSSEN44
 vGG5TLmjVHt9W1Lw2oXgEgaXf9UT0Ymz723b/oZ+ZcYQfXv5PDiqMx0qhkZ9D/j+1BG4
 8lRw==
X-Gm-Message-State: AC+VfDzcSwzZ2AfEtODIQLgQxWfY3w+Jg2XbK7dwMbSXY65lZwKbzymf
 UmBLeiByWZTcQQ86AjFBG+q34w==
X-Google-Smtp-Source: ACHHUZ5TNmyOWleQUzceZWoCYWxuerW6RmgtFA5RC+6b1B+UgLM2YmjfTTecF1o9j30wZP4sWGEWTQ==
X-Received: by 2002:a17:902:da87:b0:1af:bdeb:a09c with SMTP id
 j7-20020a170902da8700b001afbdeba09cmr6419184plx.31.1684874601389; 
 Tue, 23 May 2023 13:43:21 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c13a:d73:4f88:3654?
 ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 b6-20020a170902d50600b001a95aef9728sm7235525plg.19.2023.05.23.13.43.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 13:43:20 -0700 (PDT)
Message-ID: <eb0615ee-31c1-1b88-02b7-f2ec189727ad@linaro.org>
Date: Tue, 23 May 2023 13:43:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 7/7] target/riscv: Remove pc_succ_insn from DisasContext
Content-Language: en-US
To: Weiwei Li <liweiwei@iscas.ac.cn>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 wangjunqiang@iscas.ac.cn, lazyparser@gmail.com
References: <20230523135939.299246-1-liweiwei@iscas.ac.cn>
 <20230523135939.299246-8-liweiwei@iscas.ac.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230523135939.299246-8-liweiwei@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 5/23/23 06:59, Weiwei Li wrote:
> pc_succ_insn is no longer useful after the introduce of cur_insn_len
> and all pc related value use diff value instead of absolute value.
> 
> Signed-off-by: Weiwei Li<liweiwei@iscas.ac.cn>
> Signed-off-by: Junqiang Wang<wangjunqiang@iscas.ac.cn>
> ---
>   target/riscv/translate.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

