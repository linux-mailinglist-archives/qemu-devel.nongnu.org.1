Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA7378932D
	for <lists+qemu-devel@lfdr.de>; Sat, 26 Aug 2023 03:52:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZiS7-0008M3-2X; Fri, 25 Aug 2023 21:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qZiS5-0008Lh-BJ
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 21:51:01 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qZiS2-00080t-V3
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 21:51:01 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3a7d7df4e67so1035335b6e.1
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 18:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693014657; x=1693619457;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a6lr2dK5J7u6x1UPTAE7v1Frb33O5qPAAyMX6MursW8=;
 b=oqpgPehQDSsXFxPTjG7cJA44odPC1vnSsCSwr12m5Ae/CQ4jwKOdaapogVZTfE6AIx
 DLMm7MkKQig/7Q6WJDVuSAbGAKJreMMj3g1leBlAEtOCXM46fiVEf2Cu3bmDoU38sDDU
 PaqJsQvDeB+reD1/S3lvxi8ai8IZvOFt6N+XYz5kY6R7UcboA0D0PfoZPYQo22qTXIEw
 YdontCjEsYov1SAfbdgeQiSbOFfvv5n7bDOJNUV9DzEf8WRaVkrcFLR04ee3J+76emXp
 Z51Qe6uAI1zSi8vJFJHAQtVQR37/n5lvsMGsf7A1eClCCVCtRfVXdlGqn1WHJmO50+M4
 UwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693014657; x=1693619457;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a6lr2dK5J7u6x1UPTAE7v1Frb33O5qPAAyMX6MursW8=;
 b=ewO4XHE1+whw2MUoYKTLOjzR/rc83Zgzn1MUagjTBIc/410dJ60AKsY7la7QEi6l6o
 klBW2PiqDQ7CGRjlkOW1Vb4sZVRK46Jvz6MsC6466wrcX9WTBeqhX6NnOC42PbDCet1P
 EUDvSyYzgZI52FfFmeMzARqT0XZcxRXfaVBYWO0Ou//JI4hNyu6+ezkqpegC4tI7cIWD
 vJGMnd2xuxQgjTjhxU3mJezb1JrDJQ/DP4heFT7wi5zxeSndi5OZqWUK1KX0T9/Z6Plq
 4uxWvh+L2HiqaTrBx/S8RAGJHeRFbONmqH6URwJj2xltlSw5kag9cwazBNepxERuOpZX
 zBIA==
X-Gm-Message-State: AOJu0YwXJ2s3/btXafj/Ti4Gi+T3TCO2SYb+virg+IEtHx9f6wXJPZgh
 cskagCR+6Bd12eclRgZzhxmrig==
X-Google-Smtp-Source: AGHT+IED/eqBQCSwIaImDghheaGPGNHnycnhBVE/Pk55PJe8PS5yC6LFMps54kO50jIqw+gYsh9xcA==
X-Received: by 2002:a05:6808:140b:b0:3a7:459d:61bf with SMTP id
 w11-20020a056808140b00b003a7459d61bfmr5756251oiv.0.1693014657456; 
 Fri, 25 Aug 2023 18:50:57 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 i16-20020aa787d0000000b00682c864f35bsm2273611pfo.140.2023.08.25.18.50.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Aug 2023 18:50:56 -0700 (PDT)
Message-ID: <7a5adff2-cf6e-4c3a-95dc-787753258757@linaro.org>
Date: Fri, 25 Aug 2023 18:50:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC v5 04/10] linux-user: Implement native-bypass option support
Content-Language: en-US
To: Yeqi Fu <fufuyqqqqqq@gmail.com>, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
References: <20230825102009.1754699-1-fufuyqqqqqq@gmail.com>
 <20230825102009.1754699-5-fufuyqqqqqq@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230825102009.1754699-5-fufuyqqqqqq@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.57,
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

On 8/25/23 03:20, Yeqi Fu wrote:
> +#if defined(CONFIG_NATIVE_CALL)
> +    /* Set the library for native bypass  */
> +    if (native_lib_path) {
> +        if (g_file_test(native_lib_path, G_FILE_TEST_IS_REGULAR)) {
> +            GString *lib = g_string_new(native_lib_path);
> +            lib = g_string_prepend(lib, "LD_PRELOAD=");
> +            if (envlist_appendenv(envlist, g_string_free(lib, false), ":")) {
> +                fprintf(stderr,
> +                    "failed to append the native library to environment.\n");
> +                exit(EXIT_FAILURE);
> +            }
> +        } else {
> +            fprintf(stderr, "native library %s does not exist.\n",
> +                    native_lib_path);
> +            exit(EXIT_FAILURE);
> +        }
> +    }
> +#endif

Here you append to the existing LD_PRELOAD.

> +    /*
> +     * An error may occur when executing execv, stating that the
> +     * shared library from LD_PRELOAD cannot be preloaded on a
> +     * different arch. So, we find LD_PRELOAD and remove it from
> +     * envp before executing the execv.
> +     */
> +    if (native_bypass_enabled()) {
> +        i = 0;
> +        while (envp[i] != NULL) {
> +            if (strncmp(envp[i], "LD_PRELOAD=", 11) == 0) {
> +                for (int j = i; envp[j] != NULL; j++) {
> +                    envp[j] = envp[j + 1];
> +                }
> +            } else {
> +                i++;
> +            }
> +        }
> +    }

Here you simply remove LD_PRELOAD entirely.
At most you should only remove libnative.so.

I'm not at all sure that you should be modifying the target environment at all.  It's ok 
for simple testing, but it is definitely error prone.  There are a couple of different 
solutions:

(1) Dynamically modify /etc/ld.so.preload, similar to how we handle various /proc files.

(2) Merge libnative.so with vdso.so (and select one of two images depending on bypass 
enabled).


r~

