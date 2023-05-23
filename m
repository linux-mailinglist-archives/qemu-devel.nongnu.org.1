Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2144E70DF55
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 16:34:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1T5E-0005u0-Mw; Tue, 23 May 2023 10:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1T5C-0005ta-O4
 for qemu-devel@nongnu.org; Tue, 23 May 2023 10:33:50 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1T5B-0005YV-4v
 for qemu-devel@nongnu.org; Tue, 23 May 2023 10:33:50 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1ae54b623c2so69313145ad.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 07:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684852427; x=1687444427;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xW6EJKqSttUwLGvWx/AHBaBDzMhMlQqLvyUnjCg6Cc8=;
 b=UPbzebddYrWmdGFEzEIVEKgVt7wRZD2LRXuJrb+DgJz6WiPFGZwkzCPgdBh2STa2LG
 NuV59Kf122JtkdgeuoB7FVnq6jiQlRg0Qlma95LCUMAs3qik0OnQitAJw0T3lu4EQLRm
 qhH8QCjJO0vTH2Ylq7cEk3bksMFYQHeriYsQ4HlMrDwv/6rAqduKmst2xhy0rjTF3duy
 FTGkTATz5oybJO1gJ2P8CriZXpAZSNkvWb0nH/KPJxRdVsN6QYbUnCKsv9U4urh95X+T
 /myBxekCIfP3oYNaVYyaFmUbdWZ/jqT/zFysn3uOYaO28Z7Vel/A5DqkcylmXXHAQdl7
 EoYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684852427; x=1687444427;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xW6EJKqSttUwLGvWx/AHBaBDzMhMlQqLvyUnjCg6Cc8=;
 b=Is/gJVFAU7MxYsuiUwcSQDniXx9zF8nKUUR9qGneuYygjg9YgodyHclwDyzdarkqKs
 cQkNAxjc9OstVK1w0qxS8jS82CBcj1tQqmlL6HPW89RoHbrQcA+dOPOSErFa0fDdfdYD
 hGLts//myBatIzMDaguluIpD6FInRVcRmorRH27xqO9DUbC8K25KxsZmT/bfRCJ9y/3J
 QfLTf77xeZu4yr1+wCTkg+LCKzU46bpHUucQPR1kekgfkWejbbtByR2AUtoWQAzP2eWg
 g+4JdoiNl3DGZGwNts6ipILVoHBuw4Y5Bkquu0DXfGvMF46KEuU8k2vpYYHjNxlB5g2N
 UaRg==
X-Gm-Message-State: AC+VfDxwwPwFNmWPjWA8Gf7Z30Anb1VH8ms4tFuJZSihpSr3IZlnCk/y
 1nHeLz0TSg7JFPzHVrnmrpYhWg==
X-Google-Smtp-Source: ACHHUZ4rnRldlJg9cQY6gGHlkRQ7xI69W/OmVK7rVvCp3HV4ZVpkOKk9sWKi5LytyJLEZJOPEprdMg==
X-Received: by 2002:a17:902:efd6:b0:1ae:5914:cbec with SMTP id
 ja22-20020a170902efd600b001ae5914cbecmr14111462plb.10.1684852427649; 
 Tue, 23 May 2023 07:33:47 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c13a:d73:4f88:3654?
 ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 q7-20020a170902dac700b001a6d4ffc760sm6874651plx.244.2023.05.23.07.33.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 07:33:47 -0700 (PDT)
Message-ID: <65f5f7e7-4685-1a63-1551-b71308c88021@linaro.org>
Date: Tue, 23 May 2023 07:33:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH] softfloat: use QEMU_FLATTEN to avoid mistaken isra
 inlining
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20230523131107.3680641-1-alex.bennee@linaro.org>
 <8920aa58-505c-92df-cff0-4ee232ca6f8b@eik.bme.hu>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <8920aa58-505c-92df-cff0-4ee232ca6f8b@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 5/23/23 06:57, BALATON Zoltan wrote:
> This solves the softfloat related usages, the rest probably are lower overhead, I could 
> not measure any more improvement with removing asserts on top of this patch. I still have 
> these functions high in my profiling result:
> 
> children  self    command          symbol
> 11.40%    10.86%  qemu-system-ppc  helper_compute_fprf_float64

You might need to dig in with perf here, but my first guess is

#define COMPUTE_CLASS(tp)                                      \
static int tp##_classify(tp arg)                               \
{                                                              \
     int ret = tp##_is_neg(arg) * is_neg;                       \
     if (unlikely(tp##_is_any_nan(arg))) {                      \
         float_status dummy = { };  /* snan_bit_is_one = 0 */   \
         ret |= (tp##_is_signaling_nan(arg, &dummy)             \
                 ? is_snan : is_qnan);                          \
     } else if (unlikely(tp##_is_infinity(arg))) {              \
         ret |= is_inf;                                         \
     } else if (tp##_is_zero(arg)) {                            \
         ret |= is_zero;                                        \
     } else if (tp##_is_zero_or_denormal(arg)) {                \
         ret |= is_denormal;                                    \
     } else {                                                   \
         ret |= is_normal;                                      \
     }                                                          \
     return ret;                                                \
}

The tests are poorly ordered, testing many unlikely things before the most likely thing 
(normal).  A better ordering would be

     if (likely(tp##_is_normal(arg))) {
     } else if (tp##_is_zero(arg)) {
     } else if (tp##_is_zero_or_denormal(arg)) {
     } else if (tp##_is_infinity(arg)) {
     } else {
         // nan case
     }

Secondly, we compute the classify bitmask, and then deconstruct the mask again in 
set_fprf_from_class.  Since we don't use the classify bitmask for anything else, better 
would be to compute the fprf value directly in the if-ladder.


> 11.25%     0.61%  qemu-system-ppc  helper_fmadds

This is unsurprising, and nothing much that can be done.
All of the work is in muladd doing the arithmetic.

> Unrelated to this patch I also started to see random crashes with a DSI on a dcbz 
> instruction now which did not happen before (or not frequently enough for me to notice). I 
> did not bisect that as it happens randomly but I wonder if it could be related to recent 
> unaligned access changes or some other TCG change? Any idea what to check?

No idea.


r~

