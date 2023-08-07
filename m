Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BADE772EBE
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 21:35:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT5zp-0004NE-Nc; Mon, 07 Aug 2023 15:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT5zn-0004Mn-TX
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 15:34:27 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT5zm-0002dP-Dq
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 15:34:27 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1bc63ef9959so17299635ad.2
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 12:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691436864; x=1692041664;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wkStjdsOBVLyZU4QQaZkHyakNEe/6w+urdxXywEIdpg=;
 b=IiKLtk4E2DjA05vExnWli1dfhgEg0pLbhrKAqFhfuOCDqJ+FNj14F2QWwg5fsOVFWr
 r9sQS24EeHPc8U0qquSlZDOoVR20dzpXMHTfr42cXxzH0FuPFUvfG1wGN2ipL8mQDmIf
 OAJ8A3RHO1eTp+2cIgzP74BGXwVHV2tWb9B0ESBS1Cx0IwYE4TSdSueZfdw7Xx2GkPHN
 5bQwr0+rYlcf5vX4QtGzHGWm+AQAigsbR0hYnvRwrJUQPIeUdg8a4XywqXViIHefVedG
 JpA0SNSzpum5yh6FAppGREidUws4O6z6ccXxAjE2f1FZutVBevt+s53YXxx5Iq+99kVa
 NU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691436864; x=1692041664;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wkStjdsOBVLyZU4QQaZkHyakNEe/6w+urdxXywEIdpg=;
 b=aX41NWnxc1fxELFB/9I6MSeAne5sABAhIUoweMaTgigePoJSkAVPtUm6YEO+mNqKkX
 qqRHk4IfI7b8dH1LUIo8yrHD8c4HsjamMskVZuGk5jJ03fKc5UTlS0TquqofCeufI6qi
 LXnaYwalNkR/PlaQexIiQgzkIWUpoNX5ZmH9BkUFsee1bnXySXtedMALvNPF7hoEjhQY
 M7YcBKZdE56V/gDw3nSVPKybaquVsbuBBl79f+QthMdvmsNOmzIkKnn+xt5/5RvfOKIH
 mnydm2rX44OiRUa8CxKzRenAOrS1elMOPk2t8mb2Ge81fhw+ltnqMRrIfLX4E2XEDI6k
 n7FA==
X-Gm-Message-State: AOJu0Yxp3q1wvOTlAj0Mg6KjIf8e6LELePWhzwqdrur+SYddSDaxRvvw
 Z93rQFaXh7IjmaJweEHy45/ixg==
X-Google-Smtp-Source: AGHT+IGoQtljZgBqF9ULdjjQxyD0eHVv1+EVoaplDtrhe7DHC2MHyUP207wPit1rEn/+xrsf6v9I/w==
X-Received: by 2002:a17:902:ce86:b0:1bc:5d0:e8db with SMTP id
 f6-20020a170902ce8600b001bc05d0e8dbmr12184121plg.62.1691436864523; 
 Mon, 07 Aug 2023 12:34:24 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:e306:567a:e0a1:341?
 ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 ja4-20020a170902efc400b001b8013ed362sm7312469plb.96.2023.08.07.12.34.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Aug 2023 12:34:24 -0700 (PDT)
Message-ID: <df348946-7092-3211-c088-2bb4f798ad88@linaro.org>
Date: Mon, 7 Aug 2023 12:34:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 5/6] target/loongarch: Support LoongArch32 DMW
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: yijun@loongson.cn, shenjinyang@loongson.cn, Song Gao
 <gaosong@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>
References: <20230807094505.2030603-1-c@jia.je>
 <20230807094505.2030603-6-c@jia.je>
 <21b780f0-baa1-c006-2e82-b646442d86f2@linaro.org>
 <b6da05fc-8eea-70d9-20ac-e6cb9d8ea440@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <b6da05fc-8eea-70d9-20ac-e6cb9d8ea440@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.809,
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

On 8/7/23 10:32, Jiajie Chen wrote:
>>>       uint8_t da = FIELD_EX64(env->CSR_CRMD, CSR_CRMD, DA);
>>>       uint8_t pg = FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PG);
>>>   +    /* Truncate high 32 bits for LA32 */
>>> +    if (env->mode == LA32) {
>>> +        address = (uint32_t)address;
>>> +    }
>>
>> You need to do this in the translator, because this also depends on VA32L* and the 
>> current priv level.
> Could you please elaborate on this? I am checking LA32 and VA32L* in 
> get_physical_address() currently, the current priv level is read from mmu_idx(or 
> alternatively, read from env->CSR_CRMD), and I am unsure how to do this in the translator.

In insn_trans/trans_memory.c.inc, gen_load, we compute the address,


>     TCGv addr = gpr_src(ctx, a->rj, EXT_NONE);
> 
>     if (a->imm) {
>         TCGv temp = tcg_temp_new();
>         tcg_gen_addi_tl(temp, addr, a->imm);
>         addr = temp;
>     }

One would use

     if (ctx->va32) {
         tcg_gen_ext32u_tl(temp, addr);
         addr = temp;
     }

to zero-extend the address.  You would want to create no more than one temporary for the 
entire computation.

You would need to modify all of the places which generate an address for tcg_gen_qemu_*: 
gen_load*, gen_store*, gen_ldptr, gen_stptr.  Also trans_fmemory.c.inc and trans_lsx.c.inc.

I would strongly suggest creating helper functions, so that all of the addition and 
extension is done in one place, and not in lots of places as we do now.

If this sounds like more work than just changing get_physical_address, and it is.  But it 
works better with the softmmu tlb.  If you clear upper bits late, then you get false 
conflicts in the tlb, and extra tlb fills.



r~

