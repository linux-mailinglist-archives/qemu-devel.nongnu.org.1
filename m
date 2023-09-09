Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A86A799A2C
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 19:08:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf1Pg-00021u-QB; Sat, 09 Sep 2023 13:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf1Pc-00021L-Nr
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 13:06:25 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf1Pa-0007Xo-90
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 13:06:24 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1c39a4f14bcso4051255ad.3
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 10:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694279180; x=1694883980; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DhcxzShv8pTqMAbPNLJcydTvX4DZLbB11NbkviOrefQ=;
 b=utTpyIzK9BOr2QmBCHFjy1Xb7pm/mBPMnhiozgVx25haypne3x/jPTAue7gMjCjae+
 F4t4X+gc1GTM25YyUhiW88lhl0M9aQdL77dGwN3Xy98s/zOhp59J2cqITlLxuczPx64z
 OhdrK+g8KU+muJb9NVTtqc8NKZ8BVb7AteuZUmbOPf7587tdCi3CYa0CK8XCOCCntBZ6
 DGw9ZlKot6SduPTySxLHfIBXu8iODALbTuQEembe+dq4BwdT65WP+YfO1DuUgfyjQC8i
 SxQuK4FMHn0jpFU/AN+wTY/fpZJmopC0w4Ivr+vHhwmNeba9/ws+XE6qIctXy8fUAoCZ
 KFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694279180; x=1694883980;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DhcxzShv8pTqMAbPNLJcydTvX4DZLbB11NbkviOrefQ=;
 b=gvKtb0Z9Mtxv4EIDGZYA8tJTw4HLlKVdnaclwwacBqWqkRpf76RCgmGOkFINBMkR6d
 JdlIVpPf1MKGlEg9S5Ef+NoqBEqcw7u5lMPkR1LEs6/9DPWHZI9oU19vkeYksBMazzVl
 y1YjcSQwvdfNsnt6kgqJ+mzzRXJAAXJQ4nT2nkRLmTOhcigVNkgYN3hXoKFASQWgHW6w
 sAS3oKgmEkBzcmvll895iYFq8sVXTF7vBeNXkK0/IkJOI99gEiHh/0fs40Ha9XK45AxI
 f2qzv9QpPVOwzGGFIeZnjRa4pkasuRzK4q3DmnRjMVzJDRJpqSS0lPhsyzxMJ/mkSrtE
 xkuQ==
X-Gm-Message-State: AOJu0YwRbHxCrEiObWAZ+Rkg30e1Q3vulM0so9z80CbMzMkLC6HgStux
 xwjM664XBQLSXkMpq++xPayNig==
X-Google-Smtp-Source: AGHT+IFdg3xbH+OHI1jMv/5/7BaDswGHQ306UHXFgZ0xokBKaeKS4iSsYl24QBeey6xxXStWGxr3qg==
X-Received: by 2002:a17:903:24c:b0:1a9:b8c3:c2c2 with SMTP id
 j12-20020a170903024c00b001a9b8c3c2c2mr6528446plh.37.1694279179772; 
 Sat, 09 Sep 2023 10:06:19 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 g24-20020a1709029f9800b0019ee045a2b3sm3462919plq.308.2023.09.09.10.06.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Sep 2023 10:06:19 -0700 (PDT)
Message-ID: <28b64da1-6c0f-012e-1af9-ac27a8581f6f@linaro.org>
Date: Sat, 9 Sep 2023 10:06:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 13/14] target/arm: Implement the CPY* instructions
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230907160340.260094-1-peter.maydell@linaro.org>
 <20230907160340.260094-14-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230907160340.260094-14-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/7/23 09:03, Peter Maydell wrote:
> +void HELPER(cpyp)(CPUARMState *env, uint32_t syndrome, uint32_t wdesc,
> +                  uint32_t rdesc, uint32_t move)
> +{
> +    int rd = mops_destreg(syndrome);
> +    int rs = mops_srcreg(syndrome);
> +    int rn = mops_sizereg(syndrome);
> +    uint32_t rmemidx = FIELD_EX32(rdesc, MTEDESC, MIDX);
> +    uint32_t wmemidx = FIELD_EX32(wdesc, MTEDESC, MIDX);
> +    bool forwards = true;
> +    uintptr_t ra = GETPC();
> +    uint64_t toaddr = env->xregs[rd];
> +    uint64_t fromaddr = env->xregs[rs];
> +    uint64_t copysize = env->xregs[rn];
> +    uint64_t stagecopysize, step;
> +
> +    check_mops_enabled(env, ra);
> +
> +    if (copysize > 0x007FFFFFFFFFFFFFULL) {
> +        copysize = 0x007FFFFFFFFFFFFFULL;
> +    }

CPYFP does not have the same saturation as CPYP.

Again, you would do better if 'move' was a parameter for an inline, so that the tests can 
be folded away.

> +void HELPER(cpym)(CPUARMState *env, uint32_t syndrome, uint32_t wdesc,
> +                  uint32_t rdesc, uint32_t move)
> +{
> +    /* Main: we choose to copy until less than a page remaining */
> +    CPUState *cs = env_cpu(env);
> +    int rd = mops_destreg(syndrome);
> +    int rs = mops_srcreg(syndrome);
> +    int rn = mops_sizereg(syndrome);
> +    uint32_t rmemidx = FIELD_EX32(rdesc, MTEDESC, MIDX);
> +    uint32_t wmemidx = FIELD_EX32(wdesc, MTEDESC, MIDX);
> +    uintptr_t ra = GETPC();
> +    bool forwards;
> +    uint64_t toaddr, fromaddr, copysize, step;
> +
> +    check_mops_enabled(env, ra);
> +
> +    /* We choose to NOP out "no data to copy" before consistency checks */
> +    if (env->xregs[rn] == 0) {
> +        return;
> +    }
> +
> +    check_mops_wrong_option(env, syndrome, ra);
> +
> +    if ((int64_t)env->xregs[rn] < 0) {
> +        forwards = true;
> +        toaddr = env->xregs[rd] + env->xregs[rn];
> +        fromaddr = env->xregs[rs] + env->xregs[rn];
> +        copysize = -env->xregs[rn];
> +    } else {
> +        forwards = false;
> +        copysize = env->xregs[rn];
> +        /* This toaddr and fromaddr point to the *last* byte to copy */
> +        toaddr = env->xregs[rd] + copysize - 1;
> +        fromaddr = env->xregs[rs] + copysize - 1;
> +    }

You're passing 'move' but not using it.  I would have expected that here.


r~

