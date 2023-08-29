Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBF578D00B
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:12:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7n2-0000oU-4l; Tue, 29 Aug 2023 19:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb3QV-0005LJ-Vg
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:26:57 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb3QS-0005Yp-99
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:26:54 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c1f8aaab9aso12393315ad.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 11:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693333610; x=1693938410;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KrMFM76V5jz06EPnBS0DwcOck84knlvpJHB8pBxYKYs=;
 b=o7EzGAcUV22uePD77U5gqzjcWmRW8sVJf2TO+wdxAwMyyxzp4xg22hISegyx4RFvMM
 wRNUI41JZY0jCf3Q5v3OQN5i9sbM+bxNr5gcW4VIMFBly/49pHtE4O4BW7+3WXMxt2Pg
 r74HxNqkRKjS1JkDIcnjnyjO2zXp7IZWXRZ4G4v0fjZXuMnZtmNTfB7YYcfQ5AhmICgm
 BvjBsWnrtpaDLNFZLqSDMrqTl5K2QJA8Dm/LhxbWO30sYwf8m0V4nA762FQD2pI1+7Mx
 bqLlbYKnkB8+2sxmX1QbM51Jqhi+TE61nfLXgNOgJ/IjWB87zvrh1RcAfeMKOSeeatbq
 +4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693333610; x=1693938410;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KrMFM76V5jz06EPnBS0DwcOck84knlvpJHB8pBxYKYs=;
 b=IC0JMuJLl5TmGV3Mg9th7ajoC4+FEQjufFaqXpH+34CaJjtYSHSW4e6nsYHfUWK+wE
 mmOizLMqQ0gZjDUQ5yMN4gSWOxUvtjNTaQf87++8zf3ZKNFcHQQEhKUTS8pG8/YnRNtJ
 PmtqtZI7uzZx/Kcdf8QNSlxjyKJG+EDKor8p+W1dBTQPoVfpRNV/syPH9AAHEORZ5eff
 gr530PNVMgpKxk0g6rfx0VtWn2S2rX0eD0MPHG/x1zCLxEPLxbok0DeYgoYAxsyYa1ZW
 N3/tCck/LrBwrL9oziGi1+MzQu2NjwJ5vHZ01eE5zjTDW9mbhzjyLNV69UaSC4vbnnid
 90BQ==
X-Gm-Message-State: AOJu0YzrBn6KhDS/kcVUTgufFTMG9Nh2c7+pG9yrgWKjhpi9pkQJSeDL
 vU7NUsEEeqWOA5yDxusuy9cOzA==
X-Google-Smtp-Source: AGHT+IGIPMCTUAqLdC+s8+ifqDOEiljOwJ7oaAx0F02fdM86sunboxeMZpXdnqYEAMg/owICgKIwFw==
X-Received: by 2002:a17:902:da81:b0:1b8:7e53:704 with SMTP id
 j1-20020a170902da8100b001b87e530704mr38635545plx.27.1693333610455; 
 Tue, 29 Aug 2023 11:26:50 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 o9-20020a170902bcc900b001b567bbe82dsm9603599pls.150.2023.08.29.11.26.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 11:26:49 -0700 (PDT)
Message-ID: <dad30d57-1afa-c034-b85d-b0f4391abf45@linaro.org>
Date: Tue, 29 Aug 2023 11:26:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 00/48] tcg patch queue
Content-Language: en-US
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Stefan Hajnoczi <stefanha@gmail.com>, "anjo@rev.ng" <anjo@rev.ng>
Cc: qemu-devel@nongnu.org
References: <20230824182854.1572951-1-richard.henderson@linaro.org>
 <CAJSP0QVY=bC3i+-20ek5q5KnQPgRVavFq0DK1+4m+fhpAO5fQw@mail.gmail.com>
 <zk2esxk4l3okthx5hg3egzvgsfp5e5jugsfstmenia5vcygym4@m4ui2pj7h4pv>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <zk2esxk4l3okthx5hg3egzvgsfp5e5jugsfstmenia5vcygym4@m4ui2pj7h4pv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

On 8/28/23 23:17, Bastian Koppelmann wrote:
>> I'm seeing a segfault in "make docker-test-tcg@debian-tricore-cross"
>> after this pull request.
> 
> git bisect points to:
> 
> commit fc15bfb6a6bda8d4d01f1383579d385acae17c0f
> Author: Anton Johansson <anjo@rev.ng>
> Date:   Mon Aug 7 17:57:03 2023 +0200
> 
>      include/exec: typedef abi_ptr to vaddr in softmmu
> 
>      In system mode, abi_ptr is primarily used for representing addresses
>      when accessing guest memory with cpu_[st|ld]*(). Widening it from
>      target_ulong to vaddr reduces the target dependence of these functions
>      and is step towards building accel/ once for system mode.
> 
>      Signed-off-by: Anton Johansson <anjo@rev.ng>
>      Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>      Message-Id: <20230807155706.9580-7-anjo@rev.ng>
>      Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
> index da10ba1433..f3ce4eb1d0 100644
> --- a/include/exec/cpu_ldst.h
> +++ b/include/exec/cpu_ldst.h
> @@ -121,8 +121,8 @@ static inline bool guest_range_valid_untagged(abi_ulong start, abi_ulong len)
>       h2g_nocheck(x); \
>   })
>   #else
> -typedef target_ulong abi_ptr;
> -#define TARGET_ABI_FMT_ptr TARGET_FMT_lx
> +typedef vaddr abi_ptr;
> +#define TARGET_ABI_FMT_ptr "%016" VADDR_PRIx
>   #endif
> 
> 
> Changeing typedef vaddr abi_ptr back to target_ulong fixes it.
> 
> The faulting TriCore insn is OPC1_32_BOL_ST_W_LONGOFF, that tries to write to
> guest addr 0xd0000124, which is in a valid memory region.

Right.  The traceback is

#6  0x000055555582c511 in mmu_lookup
     (env=0x555555e98ee0, addr=18446744072904253376, oi=32, ra=0, type=MMU_DATA_STORE, 
l=0x7ffff1888cc0) at ../src/accel/tcg/cputlb.c:1828
#7  0x000055555582f531 in do_st4_mmu
     (env=0x555555e98ee0, addr=18446744072904253376, val=0, oi=32, ra=0)
     at ../src/accel/tcg/cputlb.c:2991
#8  0x000055555582fe59 in cpu_stl_mmu
     (env=0x555555e98ee0, addr=18446744072904253376, val=0, oi=32, retaddr=0)
     at ../src/accel/tcg/cputlb.c:3138
#9  0x000055555583041d in cpu_stl_le_mmuidx_ra
     (env=0x555555e98ee0, addr=18446744072904253376, val=0, mmu_idx=0, ra=0)
     at ../src/accel/tcg/ldst_common.c.inc:118
#10 0x00005555558308b5 in cpu_stl_le_data_ra
     (env=0x555555e98ee0, addr=18446744072904253376, val=0, ra=0)
     at ../src/accel/tcg/ldst_common.c.inc:213
#11 0x0000555555830bf2 in cpu_stl_le_data
     (env=0x555555e98ee0, addr=18446744072904253376, val=0)
     at ../src/accel/tcg/ldst_common.c.inc:301
#12 0x00005555557a2ce2 in save_context_upper
     (env=0x555555e98ee0, ea=-805298240)
     at ../src/target/tricore/op_helper.c:2400
#13 0x00005555557a35ee in helper_call (env=0x555555e98ee0, next_pc=2147484092)
     at ../src/target/tricore/op_helper.c:2519

With

     void save_context_upper(CPUTriCoreState *env, int ea)

providing the signed address variable, which gets extended to 64-bits with the change to 
abi_ptr instead of converted to unsigned 32-bits in cpu_stl_le_data.

For the short-term, let's revert this patch.


r~


