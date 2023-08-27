Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD31789FCF
	for <lists+qemu-devel@lfdr.de>; Sun, 27 Aug 2023 16:52:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaH7H-0001iH-ID; Sun, 27 Aug 2023 10:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qaH7F-0001hy-7K
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 10:51:49 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qaH7D-0001t1-1P
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 10:51:48 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-68a3e943762so2136506b3a.1
 for <qemu-devel@nongnu.org>; Sun, 27 Aug 2023 07:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693147905; x=1693752705;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZSCh7wV/J3Uuun5HaF+u63p4rU1eXdEmXmszkQfGLtw=;
 b=pMKxBUTQGROBhOlqI2Ggpw5gpMxRoIT6DwtFShSHH1eE2Ib69PQgrpv7iX63xxX8W3
 6F/MNgHQfD7uF9BTAdcEdFzjgC+alzu+eOYIWq97MdpSCQlNqwE4CnYBs6R3sXW/gBF6
 HooZgwGkYD6k9MFDqWo5E6bUamHyVILZ47BcGKMybciJdc8U+gZ3nRqVkTBzZ94+FQh1
 +uFNoGc35dwNmqVESULfVRNsbhvoJdqpBRluglhxsQEZNbR8JVcaKq9Fh5i0XXpjhyDs
 kCIC+w7JnGkMSJT/4Os/pDWXmjD4Tmz3W+j1wgCz9X8cX/dWc7cC84/gy7aU7Hn6QEkO
 cSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693147905; x=1693752705;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZSCh7wV/J3Uuun5HaF+u63p4rU1eXdEmXmszkQfGLtw=;
 b=Bgc65LoLbimK3clw8SFmpeXGn8CFGQ29/hfctZztgfttvMlN490El3XMFmJNw3I+vH
 g9qE0yHYuFpPnhwHgIr0d0vz8yyObnygGtHbQkPUBZ1p2IP9y3IRfYXzJSrUydSc2F+n
 dZ4cXGx2E51WREzyATjYteCSdFpvg6JAd+tNJiaW6r3MDYKNIAulyHrs80xQE9GvFl7x
 yKSYowa0kp9M5mJZASyO0wGwIm9SZBp08I/isiVv1JdAc+sPZmrPDz8DAETWnJIlh4ky
 6/wcDNeG9CCuBPW90opzMXVOxGyu6DW8PqFTbAnqda3Z8vV5DvyO5uX2xdQDF5DBXYur
 x6+Q==
X-Gm-Message-State: AOJu0YztJ4QBtbO8r6d2xGLCLK8ikF9PVkbHDUg0YSUyOUraHzzdaBZR
 Cgp7K/ZNjSyZaFBuad17AOGE1Q==
X-Google-Smtp-Source: AGHT+IHUjDQQy+nS5H5WWCmRBBUS4VD5oxHfqOmlC0R7lVKDt6+GBYDWMNQVbnJwKsltldNbDr7J0Q==
X-Received: by 2002:a05:6a00:600a:b0:68c:4ff1:3de9 with SMTP id
 fo10-20020a056a00600a00b0068c4ff13de9mr1227143pfb.17.1693147905289; 
 Sun, 27 Aug 2023 07:51:45 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 m17-20020a637111000000b00563826c66eesm5390076pgc.61.2023.08.27.07.51.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Aug 2023 07:51:44 -0700 (PDT)
Message-ID: <ccde9364-bde5-f8db-320d-8dfe5d6ef51b@linaro.org>
Date: Sun, 27 Aug 2023 07:51:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 05/10] target/tricore: Implement ftohp insn
Content-Language: en-US
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: qemu-devel@nongnu.org, anton.kochkov@proton.me
References: <20230826160242.312052-1-kbastian@mail.uni-paderborn.de>
 <20230826160242.312052-6-kbastian@mail.uni-paderborn.de>
 <5598bd01-6d2e-5661-8cb5-aa5a49b22ffd@linaro.org>
 <z2hqeuxwnmwuc7pxoogvxghk2ngs2oqdpms4n6iiqxwtpspsc6@qz6iu56qxv2d>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <z2hqeuxwnmwuc7pxoogvxghk2ngs2oqdpms4n6iiqxwtpspsc6@qz6iu56qxv2d>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 8/27/23 00:09, Bastian Koppelmann wrote:
> On Sat, Aug 26, 2023 at 09:55:05PM -0700, Richard Henderson wrote:
>> On 8/26/23 09:02, Bastian Koppelmann wrote:
>>> +uint32_t helper_ftohp(CPUTriCoreState *env, uint32_t arg)
>>> +{
>>> +    float32 f_arg = make_float32(arg);
>>> +    uint32_t result = 0;
>>> +    int32_t flags = 0;
>>> +
>>> +    if (float32_is_infinity(f_arg)) {
>>> +        if (float32_is_neg(f_arg)) {
>>> +            return  HP_NEG_INFINITY;
>>> +        } else {
>>> +            return  HP_POS_INFINITY;
>>> +        }
>>> +    } else if (float32_is_any_nan(f_arg)) {
>>> +        if (float32_is_signaling_nan(f_arg, &env->fp_status)) {
>>> +            flags |= float_flag_invalid;
>>> +        }
>>> +        result = float16_set_sign(result, arg >> 31);
>>> +        result = deposit32(result, 10, 5, 0x1f);
>>> +        result = deposit32(result, 8, 2, extract32(arg, 21, 2));
>>> +        result = deposit32(result, 0, 8, extract32(arg, 0, 8));
>>> +        if (extract32(result, 0, 10) == 0) {
>>> +            result |= (1 << 8);
>>> +        }
>>> +    } else {
>>> +        set_flush_to_zero(0, &env->fp_status);
>>> +        result = float32_to_float16(f_arg, true, &env->fp_status);
>>> +        set_flush_to_zero(1, &env->fp_status);
>>> +        flags = f_get_excp_flags(env);
>>> +    }
>>
>> All of this is standard behaviour.  All you need is the final else case.
> 
> Unfortunately not quite. For NANs the top 2 and lower 8 output mantissa bits need to be
> set to the top 2 and lower 8 input mantissa bits respectively. This behaviour is
> unique to ftohp and hptof, so I don't think we should specialize it in
> parts64_default_nan().

Ah, whereas softfloat grabs the top 10 mantissa bits.
This could use a comment to that effect.

Certainly you don't need to special case infinity though.


r~


