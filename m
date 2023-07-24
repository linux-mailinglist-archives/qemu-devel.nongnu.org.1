Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 795FB75FABA
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 17:24:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNxPP-0001Bf-S9; Mon, 24 Jul 2023 11:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qNxP6-00019T-Cy
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 11:23:21 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qNxP4-0001Gn-4z
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 11:23:19 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-31297125334so2828200f8f.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 08:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690212196; x=1690816996;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a8FLl+LyVMUJV42wTDR2fD16H+ZcdkGwiITqz6fjIRo=;
 b=CK0zuR5K+fSb4XWtesKDmedBfdoCaUMsIOjWsAJ98MB++ljJVyezgmEZzHee2nYLOU
 CnKyCp277NK++A+pf2hrkas76nhyIlmAFoASBcB0hbTfl0ixHxQIVIH0c/cN9bIFK9H6
 fclKTYebt1EA/8dmMdB3cnaJdsoivUFNLVHP+exZmyeJrooEj8Dwb5QaF9YehSk8uYqf
 +Mq6MrGDlyoas2CIbb1r0Bwd2dMbyQrWg8gz9I58X+PxLrY6WIZxbDvurUuedfe5tmmx
 capfdXyrv6eNUTJ0h9A0QjOLY30M/sbFvTcc5pF6OaiYLoSZITyc037I/Q8JgIvzicaA
 3NpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690212196; x=1690816996;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a8FLl+LyVMUJV42wTDR2fD16H+ZcdkGwiITqz6fjIRo=;
 b=T6WM2dHJ7qPwm20eAs3Bb/seOmiziKH6da76AHbwcrD5JXBB+PbCv4saCWZcwRKd+v
 iq+Nbd/U3TPVwCr0AbnCHy3dakSi7LgJzJdrru7f3SxW6MQkskS/y79RhD3PXtZLi/e6
 FIzXcvXvwR6YMVfsRrI4WMKlovzZZ69mvmYAO3P/PJK+zQx5JKz09N0nwEXB0ihsDuE5
 kaOUs3xZCR/bo1kosPmPVH+PAT43ZJx5gu7FnbbqwS1x889wtiwt4MG760yymPPhs6xb
 5lqrfb5RUIsgrlsdicl4ZYLl2R44wgdNmhOLqpItkBt0F9TJ6e2LSH4kiTuROlSFqAJA
 FQ5A==
X-Gm-Message-State: ABy/qLbkM00fPxHNPczD6oNBbDgQftLsO3D6WpNnU+qqPL98PUUiio6D
 LJn3bZXgEStUpeLZYXebQEU36A==
X-Google-Smtp-Source: APBJJlEtEHB8cgYHnuTK1jhcOfGbIrKYhlCTD8y7kr9lkTcuK6QW3Il/pqR53/01GzSTb3vBXJi3Ug==
X-Received: by 2002:a5d:6751:0:b0:315:7f1d:7790 with SMTP id
 l17-20020a5d6751000000b003157f1d7790mr8511487wrw.6.1690212196204; 
 Mon, 24 Jul 2023 08:23:16 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.210.255])
 by smtp.gmail.com with ESMTPSA id
 a12-20020a5d53cc000000b00313f9a0c521sm13216219wrw.107.2023.07.24.08.23.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jul 2023 08:23:15 -0700 (PDT)
Message-ID: <b2e8694b-af1a-777f-0b7b-8ecb44289093@linaro.org>
Date: Mon, 24 Jul 2023 17:23:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [RFC] risc-v vector (RVV) emulation performance issues
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Jeff Law <jlaw@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
References: <0e54c6c1-2903-7942-eff2-2b8c5e21187e@ventanamicro.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <0e54c6c1-2903-7942-eff2-2b8c5e21187e@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 24/7/23 15:40, Daniel Henrique Barboza wrote:
> Hi,
> 
> As some of you are already aware the current RVV emulation could be faster.
> We have at least one commit (bc0ec52eb2, "target/riscv/vector_helper.c:
> skip set tail when vta is zero") that tried to address at least part of the
> problem.


> First thing that caught my attention is vext_ldst_us from 
> target/riscv/vector_helper.c:
> 
>      /* load bytes from guest memory */
>      for (i = env->vstart; i < evl; i++, env->vstart++) {
>          k = 0;
>          while (k < nf) {
>              target_ulong addr = base + ((i * nf + k) << log2_esz);
>              ldst_elem(env, adjust_addr(env, addr), i + k * max_elems, 
> vd, ra);
>              k++;
>          }
>      }
>      env->vstart = 0;
> 
> Given that this is a unit-stride load that access contiguous elements in 
> memory it
> seems that this loop could be optimized/removed since it's 
> loading/storing bytes
> one by one. I didn't find any TCG op to do that though. I assume that 
> ARM SVE might
> have something of the sorts. Richard, care to comment?

Have you looked at the "tcg/tcg-op-gvec-common.h" API?

