Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 052EC77332F
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 01:01:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT9Cj-0005Qv-7e; Mon, 07 Aug 2023 19:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT9Cg-0005QZ-WE
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 18:59:59 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT9Cf-0007IL-Fo
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 18:59:58 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-53fa455cd94so2937825a12.2
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 15:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691449195; x=1692053995;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rXCUaSDI0ctPjhMru7mmfWId1wOd0ZgvL2IhpBzNPNo=;
 b=q3egltkKUUn0Ry+Gt0TU4nll0QfqqEARkEUCPBAUF19tZ72nv4jRUB6ktGEye9jOI1
 Tno6Po/WD4LKg0Bw8A2GZlnlPRfQiwUbcW4S8B1c45NR8gzL7hPaPHjCEvZX0ThOEvoJ
 7dLtgNsOteE0locrVCGb+3totUHRbG/9ruKHef9uSChnAHO76vg6W1TvTVJ1Z4b+1NML
 FYQjO83Ep1Q05fJR8K/dsR7w8DdoXCzcBFSHiIufdMCvydDnmo8NTi6XQYJsy1yUQpY0
 K5D7wp9z7WSl07vMC40LuekVQtQuO7ws9qrJNhcdeC40OICg7a+4CKkFrkjL/D8/9iyO
 KtAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691449195; x=1692053995;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rXCUaSDI0ctPjhMru7mmfWId1wOd0ZgvL2IhpBzNPNo=;
 b=Y1l19c8LI0RwglPZIOR1a03GJmKB9WqIcNlYtn7Dq1tyg6e5s68biWGhc9+16Dcfic
 4duvu2feeeW/fUX34wFlMP9iuOw99DsmBTjHBmFw5Jx+bzyJfrQJCP/J/8c098wZN3nR
 je4OowCtIx651Y9aRHKeiLzdABgBG5zx3wg8gg2SZ5lBtZUb7eB1HlhhcRgSRTKke6YN
 99bGAdPEZuSMUmEg9PFpZLeSLovwpHM2o44UBQsxYsEE2fCTJ3mmRW04+s5lJy4uBN0j
 QluZYe/rB4TC+Ha6O5EZe85+SPccA6CAJbMS/OSh5niQKi0kaGd/wNdP1dT2Pq0KLD2h
 Omkg==
X-Gm-Message-State: AOJu0YzbO01yvOT2s5IPMWAwjNTtzIZP1sO6R3sBuDHeE4ZJ0Y+Lx3Jv
 ju17IzcdjVqm+avpVUWUdUD6rg==
X-Google-Smtp-Source: AGHT+IEvmuEWyPlfhUr3l8vKxLlJNk/9EBWHNyb1rd8Q+QSKxx0VYf1RCOuisQ8U2fiWejLiXtLEtg==
X-Received: by 2002:a17:90b:3713:b0:262:de1a:6028 with SMTP id
 mg19-20020a17090b371300b00262de1a6028mr7901599pjb.13.1691449195605; 
 Mon, 07 Aug 2023 15:59:55 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:e306:567a:e0a1:341?
 ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 o22-20020a17090ac09600b002638e5d2986sm9200059pjs.17.2023.08.07.15.59.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Aug 2023 15:59:55 -0700 (PDT)
Message-ID: <cb6a9e96-0767-9980-03a5-10d22aa0ec21@linaro.org>
Date: Mon, 7 Aug 2023 15:59:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] disas/riscv: Further correction to LUI disassembly
Content-Language: en-US
To: Richard Bagley <rbagley@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com, dbarboza@ventanamicro.com
References: <20230731183320.410922-1-rbagley@ventanamicro.com>
 <4b38596d-1db6-e03f-8b42-65c4464132ab@linaro.org>
 <CAARkPA_6=u6fM6F4RYC9Zdfw0iQ6sE5Zp1649gAr3_BBR-GRMg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAARkPA_6=u6fM6F4RYC9Zdfw0iQ6sE5Zp1649gAr3_BBR-GRMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.809,
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

On 8/7/23 15:01, Richard Bagley wrote:
> I do apologize, but I do not understand your remark at all. Could I trouble you to spell 
> this out.
> 
> In:
> +                snprintf(tmp, sizeof(tmp), "%d", dec->imm >> 12 & 0xfffff);
> 0xfffff is a mask which recovers the 20 bit field used to represent the immediate in the 
> instruction encoding.
> 
> You seem to be responding to the syntax, which is unrelated to my change.
> But I did notice it is the case that both GCC and LLVM disassemblers do not accept signed 
> integer arguments to LUI:
> lui r1, -1
> but instead require
> lui r1, 0xfffff

Your language is confusing.  Disassembler or assembler?  A disassembler would not "accept" 
but "output" arguments for LUI.

If the assembler rejects "lui r1, -1", that would be a bug, because the field *is* signed.

For the disassembler, the field *is* signed, therefore outputting a signed value is 
correct.  Outputting an unsigned hex value hides the fact that bit 31 is the sign.

To my mind this is exactly the same as emitting a signed value for the immediate in ADDI.


r~

