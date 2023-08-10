Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 136FA777DDE
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 18:14:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU8HJ-00089D-Fw; Thu, 10 Aug 2023 12:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <palmer@rivosinc.com>)
 id 1qU8HH-00088t-0c
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 12:12:47 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <palmer@rivosinc.com>)
 id 1qU8HF-0002VG-9L
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 12:12:46 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-686f19b6dd2so801931b3a.2
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 09:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691683963; x=1692288763; 
 h=content-transfer-encoding:mime-version:message-id:to:from:cc
 :in-reply-to:subject:date:from:to:cc:subject:date:message-id
 :reply-to; bh=vfaU3OrsYfQeVd17GEFviGDPcOOzJCDudRP+bkbgTvg=;
 b=Wemfs/38l9HHZN9QhCoNyCZl2z6yQEZ/7lr5AlFg+xpVh9GNISGILUYeOLCGRV3RBi
 ZWn1xOj3nZTZQO+d0tLB7xXdLu7g4+pkDftuw5675fx9ixSRXub0QD8//WDSJzuLtT1f
 RbUE+1In9FuAum47jgH+iP1p6GoesI1epfswSoMT9D23yMOD1ae9qeJ3qIKLZPhdHv2c
 dIYdzD2Y6S/EaheW1yU+FqLlT5ukAWbcwte6jQw17xdUKS33KnYq6B3Z19vCSDocuovj
 +fd/oYqDPGAZ6yjCRpy5bPNirRpUSHX6CRhaewozb6//uads9MKdaXtg+Dauar2ysNYh
 ncDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691683963; x=1692288763;
 h=content-transfer-encoding:mime-version:message-id:to:from:cc
 :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vfaU3OrsYfQeVd17GEFviGDPcOOzJCDudRP+bkbgTvg=;
 b=domXGjgzuD557My4a0Cnz8MxxC2zslHQUWKpOKszeApFKBh6SIdksNY8hvNcjNoEps
 JI208YF4LK5wiESqzlJLt+4aPjKKtf1WH+y+LtKkjJbjhDHBbmIKZtW88eNrFLNXMi3S
 93M+Ml7sfTTE+CjtBciR0L7XjGuLuChFUIqNrWvvLPH73Xgesyqk1zz8vwecCCgM/39R
 eGSLT7vMZD1OYUCmvgVjs9jWTD7V17m7yYFiY5OieAcGdSv+3WlnuyfkEvWjUXff2eCf
 kqTznO0HYOii7ePj1aNAFOPHsQgAZhrYIYUbEaFxAJtpw6RZIs7C5zVkHFcRzuAAxocd
 8mmA==
X-Gm-Message-State: AOJu0YzBdKk6DsEUqxi4bRt0GJmilhKJLqUl8Dg1qCfqVwWBDwCVevr7
 bcE16nZk0o3WbHQ4EnYoNyqdgg==
X-Google-Smtp-Source: AGHT+IGNMgKZ8oR5K80p2m3InV9yUW72L3cHtDdwMf4qCOR6gcov0j5PDDEiYy1GCdAMjklBUmlmtg==
X-Received: by 2002:a05:6a20:8f17:b0:133:faf4:ed2f with SMTP id
 b23-20020a056a208f1700b00133faf4ed2fmr3240750pzk.40.1691683963089; 
 Thu, 10 Aug 2023 09:12:43 -0700 (PDT)
Received: from localhost ([135.180.227.0]) by smtp.gmail.com with ESMTPSA id
 p16-20020aa78610000000b00682ad247e5fsm1769322pfn.179.2023.08.10.09.12.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Aug 2023 09:12:42 -0700 (PDT)
Date: Thu, 10 Aug 2023 09:12:42 -0700 (PDT)
X-Google-Original-Date: Thu, 10 Aug 2023 09:12:41 PDT (-0700)
Subject: Re: [PATCH] disas/riscv: Further correction to LUI disassembly
In-Reply-To: <20230810-c9e1f2783168b48bc07a1aa2@orel>
CC: rbagley@ventanamicro.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 dbarboza@ventanamicro.com
From: Palmer Dabbelt <palmer@rivosinc.com>
To: ajones@ventanamicro.com
Message-ID: <mhng-a6344a0c-8820-41b5-a015-b82b261b463d@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=palmer@rivosinc.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, 10 Aug 2023 08:31:46 PDT (-0700), ajones@ventanamicro.com wrote:
> On Mon, Jul 31, 2023 at 11:33:20AM -0700, Richard Bagley wrote:
>> The recent commit 36df75a0a9 corrected one aspect of LUI disassembly
>> by recovering the immediate argument from the result of LUI with a
>> shift right by 12. However, the shift right will left-fill with the
>> sign. By applying a mask we recover an unsigned representation of the
>> 20-bit field (which includes a sign bit).
>>
>> Example:
>> 0xfffff000 >> 12 = 0xffffffff
>> 0xfffff000 >> 12 & 0xfffff = 0x000fffff
>>
>> Fixes: 36df75a0a9 ("riscv/disas: Fix disas output of upper immediates")
>> Signed-off-by: Richard Bagley <rbagley@ventanamicro.com>
>> ---
>>  disas/riscv.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/disas/riscv.c b/disas/riscv.c
>> index 4023e3fc65..690eb4a1ac 100644
>> --- a/disas/riscv.c
>> +++ b/disas/riscv.c
>> @@ -4723,9 +4723,12 @@ static void format_inst(char *buf, size_t buflen, size_t tab, rv_decode *dec)
>>              break;
>>          case 'U':
>>              fmt++;
>> -            snprintf(tmp, sizeof(tmp), "%d", dec->imm >> 12);
>> -            append(buf, tmp, buflen);
>> -            if (*fmt == 'o') {
>> +            if (*fmt == 'i') {
>> +                snprintf(tmp, sizeof(tmp), "%d", dec->imm >> 12 & 0xfffff);
>
> Why are we correcting LUI's output, but still outputting sign-extended
> values for AUIPC?
>
> We can't assemble 'auipc a1, 0xffffffff' or 'auipc a1, -1' without getting
>
>  Error: lui expression not in range 0..1048575
>
> (and additionally for 0xffffffff)
>
>  Error: value of 00000ffffffff000 too large for field of 4 bytes at 0000000000000000
>
> either.
>
> (I see that the assembler's error messages state 'lui', but I was trying
> 'auipc'.)
>
> I'm using as from gnu binutils 2.40.0.20230214.
>
> (And, FWIW, I agree with Richard Henderson that these instructions should
> accept negative values.)

I'm kind of lost here, and you saying binutils rejects this syntax?  If 
that's the case it's probably just an oversight, can you file a bug in 
binutils land so folks can see?

>
> Thanks,
> drew
>
>
>> +                append(buf, tmp, buflen);
>> +            } else if (*fmt == 'o') {
>> +                snprintf(tmp, sizeof(tmp), "%d", dec->imm >> 12);
>> +                append(buf, tmp, buflen);
>>                  while (strlen(buf) < tab * 2) {
>>                      append(buf, " ", buflen);
>>                  }
>> --
>> 2.34.1
>>
>>

