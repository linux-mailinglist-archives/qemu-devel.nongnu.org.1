Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E764789FCE
	for <lists+qemu-devel@lfdr.de>; Sun, 27 Aug 2023 16:51:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaH5V-0000KX-BR; Sun, 27 Aug 2023 10:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qaH5T-0000KC-I7
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 10:49:59 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qaH5R-0001NQ-69
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 10:49:59 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3a9b41ffe11so1454062b6e.2
 for <qemu-devel@nongnu.org>; Sun, 27 Aug 2023 07:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693147796; x=1693752596;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7YonvlolZCMg8yoPuDigYoDZjYbKNIhIk/pUW8d5/NI=;
 b=u7wPAgXp6FwUPlVMsn5tpp15I9oZ4/F6XhVf+XJdBYNE4cOm5bQnTIkfkNqR8ZvbF7
 ZhClG0B4lMViVYv/nZQJ2ppAUIGBmyDuD8e77ctyey7r0Cy2dB+MmIqAbQ4qETsMDPU4
 Nag6nvKpsWtH3/aYxH53cpyTQ+5ehnv8Hci+3uizgibw21FENcK6qUVJ+Mf6Njpn0GoS
 s9HE+l25EotFgOmLjz/umfrmu2x/BZF/JdMq0YfnKYWi3j/GG9Fu21wLeoh9LhKaAqV5
 pkSpLyBOTvXTcR5+rkkeEQPqvZ+/ST0Ymn9awMCdgK1HiYmVHqgsNkiKmANx5fwfk6eh
 T+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693147796; x=1693752596;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7YonvlolZCMg8yoPuDigYoDZjYbKNIhIk/pUW8d5/NI=;
 b=C2NkSoSDg4DsBptRb2HCrN0nKXi29wlY4VkwMTudrqY04VSECWpXopOT+b3Vp8sxAt
 diqXHyDUZn0smhC5LGVBHRNmLfs0ngoPIR2SApmxKG2bcXlGRMwwbNo5gFIHdmAWF8xx
 zdz8VMHm3v/2r/kDuASFvrHXtNpYmyVtdiVQ2uM5Orxm04CO3A9Za2ugrXd3+RunbUgO
 hMlwrEF3hU8IaExJDlz5XOeJjZzjxrzCtjGbdyvkJX6wIyIPN6vB2ggvWICk3LAVgghv
 eaLDrjSsGHiMU43fmzQLzLJD+gNKBlaW2RSkh5LgFBU+BDw/MyMrjCTa0nKrMlWZSdvr
 Sjgg==
X-Gm-Message-State: AOJu0YxXPhb84SqbHZUiz0+bU0A4vBnStazkbLaI48S2uzvYsyTP0f51
 KiS5tud0qoFDkDgMUlw6Xu8lQ4jhXiMmQ6kJndM=
X-Google-Smtp-Source: AGHT+IF16POOg3iqpTOaBJ4zGJsVkrcCITXGkuNSMPcc9jA0YjtfwQ4CzZpR/hoBLSfiYwdLvVvmLg==
X-Received: by 2002:a05:6808:1a02:b0:3a7:4b9a:43c2 with SMTP id
 bk2-20020a0568081a0200b003a74b9a43c2mr10812562oib.13.1693147795847; 
 Sun, 27 Aug 2023 07:49:55 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 y14-20020a63ad4e000000b0052c9d1533b6sm5404871pgo.56.2023.08.27.07.49.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Aug 2023 07:49:55 -0700 (PDT)
Message-ID: <58ad531d-82aa-d0fe-a830-a41f5b465cb1@linaro.org>
Date: Sun, 27 Aug 2023 07:49:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 04/10] target/tricore: Implement FTOU insn
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: qemu-devel@nongnu.org, anton.kochkov@proton.me
References: <20230826160242.312052-1-kbastian@mail.uni-paderborn.de>
 <20230826160242.312052-5-kbastian@mail.uni-paderborn.de>
 <f8f824f3-add2-a6ea-1e78-48aa9d1b6e56@linaro.org>
 <a5atencg3p7r5yad5ybg75c6clr6ofk24xm2j2yw2pct6wb6bs@5onnabp3kkyg>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <a5atencg3p7r5yad5ybg75c6clr6ofk24xm2j2yw2pct6wb6bs@5onnabp3kkyg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x235.google.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.414,
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

On 8/27/23 04:07, Bastian Koppelmann wrote:
> On Sat, Aug 26, 2023 at 09:50:51PM -0700, Richard Henderson wrote:
>> On 8/26/23 09:02, Bastian Koppelmann wrote:
>>> +uint32_t helper_ftou(CPUTriCoreState *env, uint32_t arg)
>>> +{
>>> +    float32 f_arg = make_float32(arg);
>>> +    uint32_t result;
>>> +    int32_t flags = 0;
>>> +
>>> +    if (float32_is_any_nan(f_arg)) {
>>> +        result = 0;
>>> +        flags |= float_flag_invalid;
>>> +    } else if (float32_lt_quiet(f_arg, 0, &env->fp_status)) {
>>> +        result = 0;
>>> +        flags = float_flag_invalid;
>>> +    } else {
>>> +        result = float32_to_uint32(f_arg, &env->fp_status);
>>> +        flags = f_get_excp_flags(env);
>>> +    }
>>
>> You should allow softfloat to diagnose the special cases, and negative -> 0
>> is standard behaviour.  Therefore:
> 
> You're right. However, there is one special case, negative -> 0 ought to raise
> float_flags_invalid.

https://gitlab.com/qemu-project/qemu/-/blob/master/fpu/softfloat-parts.c.inc?ref_type=heads#L1162

Already done.  As I say, this is all standard IEEE behaviour.


r~

