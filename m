Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C005A789B5E
	for <lists+qemu-devel@lfdr.de>; Sun, 27 Aug 2023 06:34:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qa7Sz-0004z7-Ai; Sun, 27 Aug 2023 00:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qa7Su-0004yw-Vs
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 00:33:33 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qa7Ss-0001pt-Pp
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 00:33:32 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3a7f4f7a8easo1161526b6e.2
 for <qemu-devel@nongnu.org>; Sat, 26 Aug 2023 21:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693110809; x=1693715609;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LDliAzJebA/uNNF7IMlYzbSE0MgwlU5IZxRm6WFYT6Q=;
 b=xobb7UYN44IFdKshr79ljLI/tHCXGQc+x1WpVmpvFOCc8wHlSpasiE+OBKmL+G6OXC
 nvT7YwDb/z8L1JKMBqkYFhI7ccZX43yGEMhlrGhxtWHv2f/TbZ4hNxGc9Bzx77SEuSOk
 q0rw24uNSsc2iv1BiX6GPGqnhhxcEsPF4NVVm1+RbWPoJMb8hjhxVVhfXLDyST5vmG2Q
 IfP/cKcEz3mhieDgCJ1rGAERf2qpCDX4oT/tWLsg7PoivtyQWvvLr+Y6mVDSRCDmd4W+
 /zmTv6dihaWqc9aIE4R+JASKnyUrEuXL4IBM6GI7GVGI2aE/knRroa8KikQ8cgw1x6wR
 2kZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693110809; x=1693715609;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LDliAzJebA/uNNF7IMlYzbSE0MgwlU5IZxRm6WFYT6Q=;
 b=idz2pLmqLuKzV/6afph0xkuZZMk92yMvSXjCgi1iVPjbbkdY7bzJ+VDn2MCqZK9hkZ
 yuAkAIfPops7hb205gQWnF5kWOsEbKsqV9A213lgghs9DR2Gpq2nTWtzotxWSs/VkkwW
 5EvNEOJWxdoEMfYzOj5HSZS0yrwHldUxKSrRC+LQm3CtV39D7cwYapTJ7Re+KyDGV0JK
 2hlux91IDCAaEv4ZufiEVXFsbqix2/GLc2zItY+HkMezaqIuZ0jzl6Y2M7tV5DkgqTs1
 +sMIHaqj4gF3sGQ6PgZ0DqIoZpvmZKbyZki42BJRCIRsE2J63F+RAYmSQrfX8o1+OdqJ
 55zw==
X-Gm-Message-State: AOJu0Yzw/AUrsOATkoNflb6q1hK69IrytJRcVRy4C49G4S57pEiFdqTB
 IIwzpls/RF6aC9LbV3m/QDUigg==
X-Google-Smtp-Source: AGHT+IGLr14W88dvEywEQ8A88gIpm/Qck4raQU30L5RliEBV+5PDSFB9id0Dr6Ude6B5g2+CP6XZHw==
X-Received: by 2002:aca:1a13:0:b0:3a7:6213:6898 with SMTP id
 a19-20020aca1a13000000b003a762136898mr6832552oia.12.1693110809509; 
 Sat, 26 Aug 2023 21:33:29 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 fk11-20020a056a003a8b00b0068be1fcc8c3sm4077456pfb.77.2023.08.26.21.33.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Aug 2023 21:33:28 -0700 (PDT)
Message-ID: <ef33adde-54fa-5e21-e15b-971e981dab8b@linaro.org>
Date: Sat, 26 Aug 2023 21:33:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 02/10] target/tricore: Implement CRCN insn
Content-Language: en-US
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
Cc: anton.kochkov@proton.me
References: <20230826160242.312052-1-kbastian@mail.uni-paderborn.de>
 <20230826160242.312052-3-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230826160242.312052-3-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x234.google.com
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
> +static uint32_t crc_div(uint32_t crc_in, uint32_t data, uint32_t gen,
> +                        uint32_t n, uint32_t m)
> +{
> +    uint32_t i;
> +
> +    data = data << n;
> +    data = deposit32(data, m, 32 - m, 0);

This is data = extract32(data, 0, m), however...

> +    for (i = 0; i < m; i++) {
> +
> +        if (crc_in & (1u << (n - 1))) {
> +            crc_in <<= 1;
> +            if (data & (1u << (m - 1))) {

You only check a single bit of data here, always bit m-1.

> +                crc_in++;
> +            }
> +            crc_in ^= gen;
> +        } else {
> +            crc_in <<= 1;
> +            if (data & (1u << (m - 1))) {
> +                crc_in++;
> +            }
> +        }
> +        data <<= 1;
> +        data = deposit32(data, m, 32 - m, 0);

So why do you need to keep bits above m clear?
I think you should just shift left and let bits fall off the left naturally.

> +    return deposit32(crc_out, n, 32 - n, 0);

extract32(crc_out, 0, n);

> +}
> +
>   uint32_t helper_shuffle(uint32_t arg0, uint32_t arg1)
>   {
>       uint32_t resb;
> diff --git a/target/tricore/translate.c b/target/tricore/translate.c
> index 1947733870..bb7dad75d6 100644
> --- a/target/tricore/translate.c
> +++ b/target/tricore/translate.c
> @@ -6673,6 +6673,12 @@ static void decode_rrr_divide(DisasContext *ctx)
>           gen_helper_pack(cpu_gpr_d[r4], cpu_PSW_C, cpu_gpr_d[r3],
>                           cpu_gpr_d[r3+1], cpu_gpr_d[r1]);
>           break;
> +    case OPC2_32_RRR_CRCN:
> +        if (has_feature(ctx, TRICORE_FEATURE_162)) {
> +            gen_helper_crcn(cpu_gpr_d[r4], cpu_gpr_d[r1], cpu_gpr_d[r2],
> +                            cpu_gpr_d[r3]);
> +        }
> +        break;

trap if not feature 162.


r~

