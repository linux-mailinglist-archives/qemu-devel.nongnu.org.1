Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E83E75500D
	for <lists+qemu-devel@lfdr.de>; Sun, 16 Jul 2023 19:10:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qL5FR-0000gP-U7; Sun, 16 Jul 2023 13:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qL5FI-0000g5-OR
 for qemu-devel@nongnu.org; Sun, 16 Jul 2023 13:09:21 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qL5FH-00023h-9m
 for qemu-devel@nongnu.org; Sun, 16 Jul 2023 13:09:20 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fb4146e8fcso22175815e9.0
 for <qemu-devel@nongnu.org>; Sun, 16 Jul 2023 10:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689527357; x=1692119357;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jWfUOAxzk3NYe6hKcltvlcWfSf+Sv6koOgcnuhdQL6M=;
 b=fXLn4wSC9pYuiw7nguvAr9w/IJwhfkUmtpmbUrq4gKUkwVI7WUZIzTX9flubGZ8CH3
 c+9lSeDxlWDV1EhTQaapF7MJWUXvMjd1vW9CkUQCHVw8G04X1U2qjCK9eTREwey+xc1E
 c7viVjLCbh3IXOM1S/pmyd3uHr6494GllEYlyWFJhM9iUG+b8f7gbcEBDKnJeL9CVwTG
 I/mkDGtwUm9zW7mLgZLXr6JhUhPK59c0sRQt3giZPnn0DaKEJrPGE37Yh5m1X4tzYznF
 Mjuz6LXcZ5EuYY8kiH+8tQbixIaz5rFij/XsJmS5dRXGuI5buMzEo8SAHlAiJNCCbyRw
 GvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689527357; x=1692119357;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jWfUOAxzk3NYe6hKcltvlcWfSf+Sv6koOgcnuhdQL6M=;
 b=N7P3JE+BVH0NOeGjhioi7o53+rJoyU+YUlhgKQns1ooRD5ZLe6ieI9A57dY9HJ9OXu
 NY59NLO+AuBoyrh6NNsAr5LJMHUWCVN/UFuHETX4dobZw7zcOf3uCXs6fnTxAEfiBph8
 YLDmRYtaRDLvZoKEQ+q+z0T6LFyogAzsCFlw7bZ7Va/niarCIxv5Lw9n1BcisBZSQJkV
 pW3D2tFCclz6K6xXzFBL9e9Er/LKIEguLlQm9LKO0Ft0Cwxrxv7hZmuZHPwsc11kRc2f
 w3cLMbVroPUxxoB4X6DL6nPYzC9+++95IJxrmQVHxVm2olJsW7JfFNnrBLEC1Apgh52t
 tk7g==
X-Gm-Message-State: ABy/qLZWyGPfgGe9R0qT4FgDOK98WUsKfiO0z14eJu96cCjL4c8pJG9T
 44Qkiream3e+G2UekTStYNXP3g==
X-Google-Smtp-Source: APBJJlGNAr+dNUHqrl+I0FJL+yNG4YLcCtXq7ldjWZUpE6LipDeDwq6iC43XLwSANNFSaUWzoXXzzg==
X-Received: by 2002:a05:600c:44a:b0:3f9:68f:9c1a with SMTP id
 s10-20020a05600c044a00b003f9068f9c1amr6802591wmb.15.1689527357535; 
 Sun, 16 Jul 2023 10:09:17 -0700 (PDT)
Received: from [192.168.1.205] ([51.219.12.49])
 by smtp.gmail.com with ESMTPSA id
 h7-20020a5d5487000000b0030ae901bc54sm16822862wrv.62.2023.07.16.10.09.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Jul 2023 10:09:16 -0700 (PDT)
Message-ID: <1e89e4a8-8268-a46c-21d3-6fcb87ecaf8b@linaro.org>
Date: Sun, 16 Jul 2023 18:09:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] target/sparc: Handle FPRS correctly on big-endian hosts
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20230714172602.397267-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230714172602.397267-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 7/14/23 18:26, Peter Maydell wrote:
> +++ b/target/sparc/gdbstub.c
> @@ -96,7 +96,10 @@ int sparc_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
>       case 83:
>           return gdb_get_regl(mem_buf, env->fsr);
>       case 84:
> -        return gdb_get_regl(mem_buf, env->fprs);
> +    {
> +        target_ulong fprs = env->fprs;
> +        return gdb_get_regl(mem_buf, fprs);
> +    }

Surely no change at all here.  The compiler zero-extends uint32_t to target_ulong in the 
parameter to gdb_get_regl.


r~

