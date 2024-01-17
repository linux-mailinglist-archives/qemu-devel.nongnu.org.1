Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB4282FF40
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 04:21:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPwSo-0005yZ-9u; Tue, 16 Jan 2024 22:19:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rPwSm-0005yN-SM
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 22:19:36 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rPwSl-0007uR-D5
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 22:19:36 -0500
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6ddf26eba3cso4430663a34.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 19:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705461574; x=1706066374; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4EXKt+GWoeA0mBj9/mEyqKCVfmm0eArITsuHMH83Dck=;
 b=BRitukPFVXUY0dicGPQfeBTX8E1SKjXfuYew8QHFBrOUuGK35dqQEMyT2eHCxGrBPx
 3LF/smr0IP1KsffDEq46XRRPfK/wnvGAAxX3bHcn5avxCtQZtP/lnxPSoZdarINEFfVp
 59hfxYU9qhqn0ZfMf6C3xC6byjlgcF3VDXLUuIbficS1ElEItf2g12wKa0Vt+HOmdsNA
 8tbGj96eDNTwHSR8jGpsOMGiBJs9ArTdVr0fxcLE524Cxw/NzJjoAtn60rGsCFdgnLjZ
 +a3eAp04xL0V0MfpUjSMhjzqteNtRA0ZfiakIq/rO5DozJykhwRs0JOURpOHhwA5t/7h
 Ri5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705461574; x=1706066374;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4EXKt+GWoeA0mBj9/mEyqKCVfmm0eArITsuHMH83Dck=;
 b=ZkLRy9N4SCWx9bPBZoYspYLFKWtJlB6k6wbMqps9tSzAYBh7QjoH3hDBA7LoW4tPJB
 2H3jPVpYIAItSuaYr/A3tHBvzRFFPRj8ANP9t2MAuoa9T94EBPovho+FTZ0MyOi2lvEx
 A9yRKXj00dwIr70XRFa9RHUw+2udHvAXlG+kw4p4q/bGKyG/E+khrMXO1YMaYdgLG5bT
 zTO0w2b8CFoF5BbTZA9d01JquJszz9ZYiL4c08dAQ+rIOvMdTgOFowZ7HJPdabltwTUJ
 6hPQPXWG0sFr1uiMYI0R4AMH7UowLCYP/Auttn10n1W8X478x+W0svYvfQXW0BrJqNjY
 4dMg==
X-Gm-Message-State: AOJu0YzmeeSstOByAxNMLT1lxGf19yxAkE/fC68timVHV2HB6/6W5fjC
 8HQHBvQcczgoQwmU3gFRrSgXL8bwRpAh+A==
X-Google-Smtp-Source: AGHT+IGGjF7NX2/zzI7IR80TmEBPyJz6AZvZV0x2hMhBWm0zt8FXiaFe9oNL/Sa36IKcdnkC9bnNSg==
X-Received: by 2002:a05:6808:16a4:b0:3bc:3b46:1898 with SMTP id
 bb36-20020a05680816a400b003bc3b461898mr8903675oib.91.1705461573944; 
 Tue, 16 Jan 2024 19:19:33 -0800 (PST)
Received: from [192.168.1.13] ([43.252.112.169])
 by smtp.gmail.com with ESMTPSA id
 oh6-20020a17090b3a4600b0028cc9afaae9sm12749671pjb.34.2024.01.16.19.19.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jan 2024 19:19:33 -0800 (PST)
Message-ID: <38b4bb14-3846-458e-871f-6a60cc69719b@linaro.org>
Date: Wed, 17 Jan 2024 14:19:28 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/38] target/s390x: Improve general case of disas_jcc
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20240110224408.10444-1-richard.henderson@linaro.org>
 <20240110224408.10444-16-richard.henderson@linaro.org>
 <b6a05a23-9f83-4a62-9f60-1ac5234cde31@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <b6a05a23-9f83-4a62-9f60-1ac5234cde31@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 1/17/24 09:19, Philippe Mathieu-Daudé wrote:
>> +        case 0x4 | 0x1: /* cc == 1 || cc == 3 => (cc & 1) != 0 */
>> +            cond = TCG_COND_TSTNE;
>> +            c->u.s32.b = tcg_constant_i32(1);
> 
> Don't we need to AND?
> 
>                c->u.s32.a = tcg_temp_new_i32();
>                tcg_gen_andi_i32(c->u.s32.a, cc_op, 1);

No, that's the TSTNE cond there.


r~

