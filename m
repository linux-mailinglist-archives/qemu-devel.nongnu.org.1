Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E462974B1C6
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 15:29:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHlWZ-00035J-1t; Fri, 07 Jul 2023 09:29:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHlWX-000350-2T
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 09:29:25 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHlWV-0000Pg-Ha
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 09:29:24 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-51e28cac164so5114318a12.1
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 06:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688736561; x=1691328561;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9VkJ4Pdq4yUi3J0pZANSENhIls9zz/anwcgwLWOU3JI=;
 b=ei+mqfdG9RcKZFvsH8E+U508vA0ne79JJsc61H4gFxdX1KEpixHhL/5CCkk2p1emoM
 6QHbnl3JUMKkOuYyIN6HOBpkAUbkC3hFvDb/8tP7NcO1M5i743OyQ3nirss2Ex4MkKO5
 Yg22uPuRgntHQsf8dKucp6EfKSYAvGt9RV+dGGP6XPOp02ws40AhPVHye54UYMNectC2
 ywzcwGfktLFvnkFSbAGHf4wjz36HEfAMH/Y7HxfGfKmRuZ6Bvn5ZC7RzP5MKFWLquLv4
 vibWANvut7lI53QEGbJb9VjBMfV2bTI8ZDK+K7UeGhIo63uqmpMe6wdkdHDXgvkh8hL0
 ERdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688736561; x=1691328561;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9VkJ4Pdq4yUi3J0pZANSENhIls9zz/anwcgwLWOU3JI=;
 b=gfuLWgEZ7YnVGOCk3P2mNXCMaiw/p4MPoAFDuf1CbTF+P/rs7sI6tiD+ccSl4rZUNE
 yVfjE1r+eHoIaowAXljt9Rl+Bxso8eSp4u0A5G2tr8c5K6ETXyfGLmQHedGsTvRFDoYi
 WqqcTgQh3tY6pA9Ri7J1JOs8xtnwP7NXpdqV824Ia+WjzS/8ycVsELxCp/A2IB+jnxpZ
 bNd1OJ1jlOwlN2YO42+Q4EZvDXZWb+sjlkd0EV3OIt1O7C/8grtGuY1YzqjBCccxhFNH
 IErinPzy+x3eIwRAeXqjytwT4g9xsUTzB8nw1L1bqOvRm0NPGlG4Zw3tn2hgG7+qZ4ES
 r1Sw==
X-Gm-Message-State: ABy/qLaagwgEqzvDKPlGE44/ZrGbe465gUzqSPHA/XlsYL2CxAfvNwn6
 mZwXQVcUdKVx11XA2ErHsxhIZQ==
X-Google-Smtp-Source: APBJJlH3sfSI0RorF6HEqol3KIIBPZjaSFPFiULXh8LZxGVqcHsWNJw2P0c+8A1EhfIOp9PuP4l1yA==
X-Received: by 2002:a17:906:77db:b0:992:1ecb:d296 with SMTP id
 m27-20020a17090677db00b009921ecbd296mr5054620ejn.12.1688736561156; 
 Fri, 07 Jul 2023 06:29:21 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.215.192])
 by smtp.gmail.com with ESMTPSA id
 rh16-20020a17090720f000b00988be3c1d87sm2196257ejb.116.2023.07.07.06.29.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 06:29:20 -0700 (PDT)
Message-ID: <d7095f65-6943-689f-1b25-31f33ba7458a@linaro.org>
Date: Fri, 7 Jul 2023 15:29:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] tcg: Fix info_in_idx increment in layout_arg_by_ref
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-stable@nongnu.org
References: <20230707102955.5607-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230707102955.5607-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 7/7/23 12:29, Richard Henderson wrote:
> Off by one error, failing to take into account that layout_arg_1
> already incremeneted info_in_idx for the first piece.  We only
> need care for the n-1 TCG_CALL_ARG_BY_REF_N pieces here.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 313bdea84d2 ("tcg: Add TCG_CALL_{RET,ARG}_BY_REF")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1751
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


