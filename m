Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8135789B63
	for <lists+qemu-devel@lfdr.de>; Sun, 27 Aug 2023 06:52:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qa7jo-00020v-2Y; Sun, 27 Aug 2023 00:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qa7jl-00020m-QR
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 00:50:57 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qa7jj-0004yv-JA
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 00:50:57 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1c06f6f98c0so17621195ad.3
 for <qemu-devel@nongnu.org>; Sat, 26 Aug 2023 21:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693111853; x=1693716653;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lSGVlC7u1qt5s9oQhiQBINflY7rbPKvEgrWH58kr7Tc=;
 b=ceipXptSu+mxfH9QBwhBwc5vA255o+5pnzJLeH2O5uvBNj7iKaFjD+8UEDoi2biqfZ
 ICFYZXy/sm+tqMG/y+TQQNTmj1OKKTJOzVBw1Tc9JKcC8Gdi9WSN3/s7DYfg+yseVBjt
 thu9oa31rIxZO8z+QZb0MIEvstqgNUePtFeJPsx8t/dg9CJaJlriirnSDw4KWVMGTEDX
 NOfc9oyxKYqLZzP5SUUrSbbavrBLZHzHbTc7mewTl3tBNW2Dsrwu/H5N+tPW52vvHbSj
 NrGdNkSfb86e0gOTzX7EzX8U17zqyTynFpFxoB4Z9MWXZO9iiNIflw7NfVt7K4+Xyl4D
 n23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693111853; x=1693716653;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lSGVlC7u1qt5s9oQhiQBINflY7rbPKvEgrWH58kr7Tc=;
 b=kXAGr+dlWWBNDbVd2DpWR+Z55F+CXuQGQjsMYhHBp8ZICJqAJw2YaPo6QF7uKwf/TV
 KJY4VAzk3V5GZJdSRbSeR9TJJn6pvjgFbL3n+KqJAkszALljrEDCItHeRUO5SJYRPj5F
 mPDIkbCsCPX+sr+Bly1K1ll3Vofyt7O+fPWawMi2u36wKr5eA/vgSQc9O8xk7EYWzwZv
 FOHqptsY6fPGvZJIz+KgkONRbOu5iH4Dfapxvv6yeaq4a2BaGmmZ3z9flVWYrdu0chd1
 gS3nYZyo886yC8st2fB586DOfFfsfMDF1Ndt0W1eJVFA4WX2OyRl+TYE93lYAUWBAvso
 vAwA==
X-Gm-Message-State: AOJu0Yx1o8ZOpw2xWqItMEjOolWxNSNYtWlf7AYzkQRXTNTSRtpOUVQE
 Kgq6TgEeOtFPA43QvQpWJRAOjw==
X-Google-Smtp-Source: AGHT+IFB74T+TVb2kr8r1w/pZ0BE5n9RzOVrQ+3eKmZpfFIHy8k/7Lc9HBpRcwQr2ZslFa/LEA1QHQ==
X-Received: by 2002:a17:902:ced1:b0:1b8:33d4:77f8 with SMTP id
 d17-20020a170902ced100b001b833d477f8mr28999875plg.23.1693111853523; 
 Sat, 26 Aug 2023 21:50:53 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 jh13-20020a170903328d00b001bbab888ba0sm4582084plb.138.2023.08.26.21.50.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Aug 2023 21:50:53 -0700 (PDT)
Message-ID: <f8f824f3-add2-a6ea-1e78-48aa9d1b6e56@linaro.org>
Date: Sat, 26 Aug 2023 21:50:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 04/10] target/tricore: Implement FTOU insn
Content-Language: en-US
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
Cc: anton.kochkov@proton.me
References: <20230826160242.312052-1-kbastian@mail.uni-paderborn.de>
 <20230826160242.312052-5-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230826160242.312052-5-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 8/26/23 09:02, Bastian Koppelmann wrote:
> +uint32_t helper_ftou(CPUTriCoreState *env, uint32_t arg)
> +{
> +    float32 f_arg = make_float32(arg);
> +    uint32_t result;
> +    int32_t flags = 0;
> +
> +    if (float32_is_any_nan(f_arg)) {
> +        result = 0;
> +        flags |= float_flag_invalid;
> +    } else if (float32_lt_quiet(f_arg, 0, &env->fp_status)) {
> +        result = 0;
> +        flags = float_flag_invalid;
> +    } else {
> +        result = float32_to_uint32(f_arg, &env->fp_status);
> +        flags = f_get_excp_flags(env);
> +    }

You should allow softfloat to diagnose the special cases, and negative -> 0 is standard 
behaviour.  Therefore:

     result = float32_to_uint32(f_arg, status);
     flags = f_get_excp_flags();

     if (flags) {
         if ((flags & float_flag_invalid)
             && !(get_float_exception_flags() & float_flag_invalid_cvti)) {
             /* invalid without cvti is nan input */
             result = 0;
         }
         f_update_psw_flags(...);
     } else {
         fs = 0;
     }


r~

