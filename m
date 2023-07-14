Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A418B754165
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 19:53:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKMxz-0004Gb-57; Fri, 14 Jul 2023 13:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qKMxx-0004GN-Ep
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 13:52:29 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qKMxv-0008J1-Je
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 13:52:29 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fbea14700bso20426335e9.3
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 10:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689357146; x=1691949146;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1rmBn7AhhkWio8yFwMAxuJdA1v2kyYxvLeaFH9xAYaY=;
 b=E/YZVUxCqv/X3yO4vfUJZsKwEdf567F5obMCKb0zIEgJAxo8EeEP6k9MEFFbULJU3H
 5akE7OdW2J+8HnxMgzO1OlAWGu6B8XoVWpiSDDhZWZpK84r8LtZQULDAlwTskVcNIviN
 bdSwur/KygzsTF7byCSlpaK5oVhO2oP3B5pMkM67v9XJ7O/Lu9QaaML2eXznHrZfEZZ1
 YIu6bX/4DJJ8yfuiijyQVTZX1BmGHVJymNPP0Ga8ndVKiIP9BksFP/MK1nACYwwLLjO4
 qJEKKO8xHYufVIT+Vk0XlP5rcjT22xaB2fx2VB3Hjj5Icvcz4dzjfYTSqDm6bbLr1IaB
 SWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689357146; x=1691949146;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1rmBn7AhhkWio8yFwMAxuJdA1v2kyYxvLeaFH9xAYaY=;
 b=CW9Wvszcrv3MbRT6AmC/HzHABe7aKz+/NC1u/P57of8duocWUnLhYJ2U+gGHoqs6AD
 +SnEhhUIX2vVDb7rd6ZcmzuQBvlSyWOmsc6GD7uT+Kqs7AaYYmwxjfv6zskZ6/WNrrPG
 47XTT0iDUJD3jVVKeDOD3N1pZ97vk2bWN9ikQNpIB7xqtLcJ4OWBe4ORNo2gok84sUZe
 STAROQgpuL/QSAFetq8aobLXpSLCWFqSfsD1Rq2vOSa0qaY46xpln62YyhdS3rQBc78I
 jQt7s7XNcTfh7XZuyjXRy/6K0u5afxuY7S7tA0R/YnDK2Qi0Ww5aZ8/RLleQZdccfc3Q
 9BnA==
X-Gm-Message-State: ABy/qLYgJsYb2Ma/oNg17/DZ9J1v23jndqsVPuGO2df5u/2IyH26NJXA
 js+AyjfWvzy77NnUhrsrAZv2mgqZxJwQQUe9Gz0=
X-Google-Smtp-Source: APBJJlHPFZOZfxoXmtjvhdER157+ET3vtNMgioCalTytl8PS9xDSqieUJIWiQSWEeb/4Jnbsg4Ysgg==
X-Received: by 2002:a7b:c3d8:0:b0:3f6:91c:4e86 with SMTP id
 t24-20020a7bc3d8000000b003f6091c4e86mr4511324wmj.3.1689357145822; 
 Fri, 14 Jul 2023 10:52:25 -0700 (PDT)
Received: from [192.168.7.115] (m-109-111-99-24.andorpac.ad. [109.111.99.24])
 by smtp.gmail.com with ESMTPSA id
 n22-20020a7bc5d6000000b003fa968e9c27sm1891147wmk.9.2023.07.14.10.52.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Jul 2023 10:52:25 -0700 (PDT)
Message-ID: <869d9cf9-003a-b721-651c-b5bb82ed593d@linaro.org>
Date: Fri, 14 Jul 2023 19:52:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] target/sparc: Handle FPRS correctly on big-endian hosts
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20230714172602.397267-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230714172602.397267-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Hi Peter,

On 14/7/23 19:26, Peter Maydell wrote:
> In CPUSparcState we define the fprs field as uint64_t.  However we
> then refer to it in translate.c via a TCGv_i32 which we set up with
> tcg_global_mem_new_ptr().  This means that on a big-endian host when
> the guest does something to writo te the FPRS register this value
> ends up in the wrong half of the uint64_t, and the QEMU C code that
> refers to env->fprs sees the wrong value.  The effect of this is that
> guest code that enables the FPU crashes with spurious FPU Disabled
> exceptions.  In particular, this is why
>   tests/avocado/machine_sparc64_sun4u.py:Sun4uMachine.test_sparc64_sun4u
> times out on an s390 host.
> 
> There are multiple ways we could fix this; since there are actually
> only three bits in the FPRS register and the code in translate.c
> would be a bit painful to convert to dealing with a TCGv_i64, change
> the type of the CPU state struct field to match what translate.c is
> expecting.
> 
> (None of the other fields referenced by the r32[] array in
> sparc_tcg_init() have the wrong type.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Another in my occasional series of "fix an avocado failure on
> s390" Friday afternoon patches :-)

:)

> diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
> index a1c8fdc4d55..bddb9609b7b 100644
> --- a/target/sparc/gdbstub.c
> +++ b/target/sparc/gdbstub.c
> @@ -96,7 +96,10 @@ int sparc_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
>       case 83:
>           return gdb_get_regl(mem_buf, env->fsr);
>       case 84:
> -        return gdb_get_regl(mem_buf, env->fprs);
> +    {
> +        target_ulong fprs = env->fprs;
> +        return gdb_get_regl(mem_buf, fprs);

Why not return gdb_get_reg32() ?

> +    }


