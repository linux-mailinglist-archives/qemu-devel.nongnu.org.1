Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B79827438A0
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 11:47:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFAi5-0003Ux-T3; Fri, 30 Jun 2023 05:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFAi4-0003UA-2R
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 05:46:36 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFAi1-0001dA-9k
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 05:46:35 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fb4146e8ceso18452505e9.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 02:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688118391; x=1690710391;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jqrk00x0V4ig0mQBvovnGth9baJqCnkMFwxtTKTNwN0=;
 b=INav9GGtM0W+MNLN+uiZ/8bt0s23NAvr3aEov2zxNm7jk8qWaQJw5lORr/TEbmcRh3
 DwNZ7SGWURQfx+ki8obbvSpc+95YiooB4cBsStgaaqrw/2lCHUG+9p/5SardJdS78k6c
 86/hfdSstaPZlImqvOV5PzsSttjAtbxGBcDTWy0DH3Le9RldcW57EHt01sEc4enCMi3q
 SNLNAsZ+iF3mJ67/imrNPuOg1INQQ0xLi1einSLaBcfArygH9dANYHZbbo0X+f6kx0Zl
 Xoo0AqLIGHZVhaDYA3UVWDhuRt9dvN/CT0b3Ae8rKZqSafmlcKJdUm0FTDe6qT2kHEsG
 OAPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688118391; x=1690710391;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jqrk00x0V4ig0mQBvovnGth9baJqCnkMFwxtTKTNwN0=;
 b=SZaht7fxymeuwWQZAmMEzEplmwZlvETyGfGcIXcL8Mbwe6L2s7230ZvKP5klWbpn9J
 AoTatONt6OwCt2taYKeoehkwvzc5T6vl0pO4pStpFpBBjcDz2a6GhO6A7ToGphlMuCYG
 nBXBE0stVj/gpkv8dZQ92drAaHHnivlv9oC6pWjcpvn854n0HSXefZ2KAQreIBLN7VKz
 fNHIdA+EGFR/lY5iE8FViROk+BLz51uCHUDysrcOqzhZRrT+q9KW2omTJ2Z7rbC/ZEMq
 Xbt4kzrS5ljsNlSsJZHzXex2Hl4sEwtucx1Mf2/aUzhW4osFHcUoyOgGagAWdyGGfE7w
 ibRw==
X-Gm-Message-State: AC+VfDykgxmYm5zIrfaeNQx5F5RsQrjfOYnqjflIXyv87u+Qt0hKjfYr
 za5ESGA+blkMZXxPVAO2LosMnA==
X-Google-Smtp-Source: ACHHUZ6E0Lps4JFkeZVhCh60wlWXPgpPajAuKxWowOB8S5DcZwsmweBQ0HoL4Xo58T/Tjzuqw40RPw==
X-Received: by 2002:a7b:cc15:0:b0:3fb:abd0:2b52 with SMTP id
 f21-20020a7bcc15000000b003fbabd02b52mr1504224wmh.13.1688118391438; 
 Fri, 30 Jun 2023 02:46:31 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 n20-20020a7bcbd4000000b003fb739d27aesm10423683wmi.35.2023.06.30.02.46.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 02:46:31 -0700 (PDT)
Message-ID: <69901e50-52e8-f937-a848-53b8042c2eeb@linaro.org>
Date: Fri, 30 Jun 2023 11:46:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 3/3] DO NOT MERGE: tests/tcg/riscv64: Add test for
 fcvtmod.w.d
Content-Language: en-US
To: Christoph Muellner <christoph.muellner@vrull.eu>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Jeff Law <jeffreyalaw@gmail.com>, Tsukasa OI <research_trasio@irq.a4lg.com>,
 liweiwei@iscas.ac.cn, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Rob Bradford <rbradford@rivosinc.com>
References: <20230630091303.1676486-1-christoph.muellner@vrull.eu>
 <20230630091303.1676486-4-christoph.muellner@vrull.eu>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230630091303.1676486-4-christoph.muellner@vrull.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 6/30/23 11:13, Christoph Muellner wrote:
> From: Christoph Müllner<christoph.muellner@vrull.eu>
> 
> This patch introduces a test for Zfa's fcvtmod.w.d instruction.
> The test cases test for correct results and flag behaviour.
> Note, that the Zfa specification requires fcvtmod's flag behaviour
> to be identical to a fcvt with the same operands (which is also
> tested).
> 
> DO NOT MERGE!!!
> Although this test works just fine, it requires a toolchain
> that supports the Zfa extension. Unless this is available
> this patch cannot be merged.
> DO NOT MERGE!!!

That's what

   /* fcvtmod.w.d rd, rs1, rtz = 1100001 01000 rs1 001 rd 1010011 */
   asm(".insn r, 0x53, 0x1, 0x61, %0, %1, f8" : "=r"(ret) : "f"(fpr));

is for.

> +    __asm__ __volatile__("fmv.d.x %0, %1" : "=fp"(fpr) : "r"(inp));

Always "f" not "fp".  "fp" is *two* constraints, "f" and "p", and the second is incorrect.


r~

