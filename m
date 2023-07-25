Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9C67621CE
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 20:55:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qONAS-0000gE-Pt; Tue, 25 Jul 2023 14:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qONAO-0000fx-91
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 14:53:52 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qONAM-0003No-EF
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 14:53:52 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1b8b4749013so46132665ad.2
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 11:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690311229; x=1690916029;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sM8eErB49cPlDrp47Ve0ECL7DJit+f901dESu73Cu1c=;
 b=vCCREaeqlBCA6NonYmW4TxSKYskAC8Sx0ekE5sTv92w3OxZELg3w+JZOd/O2zx9p8o
 e7lWWOFFWAV3D+fnXGnOtZREPsF8Eq1oLc8nntexeHguuTvuqYOJUBITrOu8iNiA1/M7
 ZUptvFT6RZs3+Ntegtl1/YJGiRJ7Rc0fEmdgIV2WF/mYjuaiOy6XdeOuZOH1pMb0SSZL
 UNMjb4VcGq89vl0cEamMSDyDq4uySPFh40Gn0zWcls58vsjOW1RBCf9ZN/by0w7tlVij
 TaN/CCAOsxLHNKtUpPUtXibrcwDsACZOZB2qVa5s+EDNG0x9LgxpBUX1wPMZOQAoGHI5
 1A7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690311229; x=1690916029;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sM8eErB49cPlDrp47Ve0ECL7DJit+f901dESu73Cu1c=;
 b=hjqDQ8K/h69zq2rsOUzd1gEEYdV3urZnr5vQTiJP9VaSY0ROR05QOme0KgWL+ZGEUR
 +fRn/vFAg8fypX5pPOBzxTrTODQyrspqlbyA3HRNEBgNSFLVlEUcI8C3Xblg0U5tZ+k3
 wOorU7aZ9JXf3ltybEBF/Q4+xB9Vt4pDb0oUHaFeyRvfgokvrtcOLYEQFnf8MKnPDQsA
 PSvLh70A/SGsKWddRRVBTHydZj+xRJ0+KTZ7CSoe2V56/H2kM40AR3c8zFn5TihsXBvE
 ZoRh8a/9uGFtFhI8CK8481Ihb1mpOUUiOSH0vdswWxcpABlH2SY+8hJtzeXBtKS91zBy
 QCFA==
X-Gm-Message-State: ABy/qLbyLtEjlnWGvNvCiVG26YGcKYEsA+gmNj+zGmT0Jtx/7gR9u8BT
 n3/+Gwnhd73Frh1NMBzdw2Lrdw==
X-Google-Smtp-Source: APBJJlH37UF2Wrva0JX5y3VY9zX8XvmWv+1zDMTwRKosbfVgUgMOeYeBHlW1/sYz36zhph/sJfM0lA==
X-Received: by 2002:a17:902:d487:b0:1b6:68bb:6ad0 with SMTP id
 c7-20020a170902d48700b001b668bb6ad0mr18372plg.55.1690311228703; 
 Tue, 25 Jul 2023 11:53:48 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:a083:fa5e:b91b:bcc6?
 ([2602:ae:1598:4c01:a083:fa5e:b91b:bcc6])
 by smtp.gmail.com with ESMTPSA id
 o10-20020a170902bcca00b001b850c9af71sm11346276pls.285.2023.07.25.11.53.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jul 2023 11:53:48 -0700 (PDT)
Message-ID: <9fc36ebe-6ec4-23dd-bbb6-5333905f7d2f@linaro.org>
Date: Tue, 25 Jul 2023 11:53:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC] risc-v vector (RVV) emulation performance issues
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Jeff Law <jlaw@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
References: <0e54c6c1-2903-7942-eff2-2b8c5e21187e@ventanamicro.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <0e54c6c1-2903-7942-eff2-2b8c5e21187e@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 7/24/23 06:40, Daniel Henrique Barboza wrote:
> Hi,
> 
> As some of you are already aware the current RVV emulation could be faster.
> We have at least one commit (bc0ec52eb2, "target/riscv/vector_helper.c:
> skip set tail when vta is zero") that tried to address at least part of the
> problem.
> 
> Running a simple program like this:
> 
> -------
> 
> #define SZ 10000000
> 
> int main ()
> {
>    int *a = malloc (SZ * sizeof (int));
>    int *b = malloc (SZ * sizeof (int));
>    int *c = malloc (SZ * sizeof (int));
> 
>    for (int i = 0; i < SZ; i++)
>      c[i] = a[i] + b[i];
>    return c[SZ - 1];
> }
> 
> -------
> 
> And then compiling it without RVV support will run in 50 milis or so:
> 
> $ time ~/work/qemu/build/qemu-riscv64 -cpu rv64,debug=false,vext_spec=v1.0,v=true,vlen=128 
> ./foo-novect.out
> 
> real    0m0.043s
> user    0m0.025s
> sys    0m0.018s
> 
> Building the same program with RVV support slows it 4-5 times:
> 
> $ time ~/work/qemu/build/qemu-riscv64 -cpu 
> rv64,debug=false,vext_spec=v1.0,v=true,vlen=1024 ./foo.out
> 
> real    0m0.196s
> user    0m0.177s
> sys    0m0.018s
> 
> Using the lowest 'vlen' val allowed (128) will slow down things even further, taking it to
> ~0.260s.
> 
> 
> 'perf record' shows the following profile on the aforementioned binary:
> 
>    23.27%  qemu-riscv64  qemu-riscv64             [.] do_ld4_mmu
>    21.11%  qemu-riscv64  qemu-riscv64             [.] vext_ldst_us
>    14.05%  qemu-riscv64  qemu-riscv64             [.] cpu_ldl_le_data_ra
>    11.51%  qemu-riscv64  qemu-riscv64             [.] cpu_stl_le_data_ra
>     8.18%  qemu-riscv64  qemu-riscv64             [.] cpu_mmu_lookup
>     8.04%  qemu-riscv64  qemu-riscv64             [.] do_st4_mmu
>     2.04%  qemu-riscv64  qemu-riscv64             [.] ste_w
>     1.15%  qemu-riscv64  qemu-riscv64             [.] lde_w
>     1.02%  qemu-riscv64  [unknown]                [k] 0xffffffffb3001260
>     0.90%  qemu-riscv64  qemu-riscv64             [.] cpu_get_tb_cpu_state
>     0.64%  qemu-riscv64  qemu-riscv64             [.] tb_lookup
>     0.64%  qemu-riscv64  qemu-riscv64             [.] riscv_cpu_mmu_index
>     0.39%  qemu-riscv64  qemu-riscv64             [.] object_dynamic_cast_assert
> 
> 
> First thing that caught my attention is vext_ldst_us from target/riscv/vector_helper.c:
> 
>      /* load bytes from guest memory */
>      for (i = env->vstart; i < evl; i++, env->vstart++) {
>          k = 0;
>          while (k < nf) {
>              target_ulong addr = base + ((i * nf + k) << log2_esz);
>              ldst_elem(env, adjust_addr(env, addr), i + k * max_elems, vd, ra);
>              k++;
>          }
>      }
>      env->vstart = 0;
> 
> Given that this is a unit-stride load that access contiguous elements in memory it
> seems that this loop could be optimized/removed since it's loading/storing bytes
> one by one. I didn't find any TCG op to do that though. I assume that ARM SVE might
> have something of the sorts. Richard, care to comment?

Yes, SVE optimizes this case -- see

https://gitlab.com/qemu-project/qemu/-/blob/master/target/arm/tcg/sve_helper.c?ref_type=heads#L5651

It's not possible to do this generically, due to the predication. There's quite a lot of 
machinery that goes into expanding this such that each helper uses the correct host 
load/store insn in the fast case.


r~

