Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C0082FDD8
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 00:53:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPtEO-00058N-Ae; Tue, 16 Jan 2024 18:52:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vineetg@rivosinc.com>)
 id 1rPtEL-00057y-0m
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 18:52:29 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vineetg@rivosinc.com>)
 id 1rPtEI-0002sL-Vg
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 18:52:28 -0500
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6dddba43d70so5181184a34.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 15:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705449145; x=1706053945;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cqtHPJVsptgRvwFHKx6xbzWK7I15xeMfzHoImRi2ZN4=;
 b=3ZcxNra23CJO0mI/cGx6y8QGtNerAYqF+bEuL8gb045+z9TatYeGnLfpnRDyQb4UnM
 CSZnm/zcYsggOSpXXE+gbKnVpCmngNgWjkzTmrQlG+E/V2ibOET23jO6sFoHZGSXMQRs
 rHr3XNhTRykbOy9W9gFC/x9qkNkTOjbGtGhldKNY3vzsp+RbSO+eUYgSTENljra82+eA
 /ARHk2PF9G8YLTmAHcYJsipVGfqBIIuFClorNlkTzHR0UE0Cb2blXMc+eSgwho5tmwLM
 TEWrfhpTJ8E8umOdv8OE0/UL+jyvhqLmX/w7kur7/fMtaRbNfM4B04uettmR4HqcViJS
 yaFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705449145; x=1706053945;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cqtHPJVsptgRvwFHKx6xbzWK7I15xeMfzHoImRi2ZN4=;
 b=LTiUXh6ne3LCTuRbs/snB5bIhJBSPexvZeCvUXHm/qS1mxXv3BiZIAY38kTLutaJ6L
 DU4ByxnuMz9SUkval2i4cstMfE0bfxOGH5WiDB0Znq6tPaF/5+IaN7oMAqKcosDuRqWD
 oHIOGGPSNHDdvOC4/9NUa6Srs39QgDhV4etx+EDdxFYMHNE+26ONY6u+ELEZlTqBkdWh
 BZUV/+RhFe4NA2R4QrmYcQpApz5HL6/jZwOa8Nma1uAT1WAUS0MxKelytyTygAfmQUT8
 +ovI/zZbq/plSO/qUKDVy1lUVgqj44UnZKxUWUCmKFXkImgKU2Uo1xa3lG4zhdE84wny
 Qk0Q==
X-Gm-Message-State: AOJu0YzQBRWrwJ1S63ewKHdEg/yw3jaEw1eoy9Oqk7uSZhHZ94nNGdrj
 jNirM+53oftd54WlleEBiL1Cmo9nIBaP5A==
X-Google-Smtp-Source: AGHT+IFznPzINpYrhQ7smXSO4SbTdmlrWbAefSp/iHLbxgB0IrPGQy1JkNqMp3WS9SMZfZYybcpyHg==
X-Received: by 2002:a9d:77cd:0:b0:6db:febb:163f with SMTP id
 w13-20020a9d77cd000000b006dbfebb163fmr8939540otl.44.1705449144908; 
 Tue, 16 Jan 2024 15:52:24 -0800 (PST)
Received: from [10.0.16.165] ([12.44.203.122])
 by smtp.gmail.com with ESMTPSA id
 e24-20020a63f558000000b005cf5cbac29asm6908100pgk.53.2024.01.16.15.52.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jan 2024 15:52:24 -0800 (PST)
Message-ID: <5c3856ea-644a-4d3c-a5a9-d03239ce5d06@rivosinc.com>
Date: Tue, 16 Jan 2024 15:52:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Vineet Gupta <vineetg@rivosinc.com>
Subject: Re: [PATCH 1/2] linux-user/riscv: vdso: fix call frame info in
 __vdso_rt_sigreturn
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>, Edwin Lu
 <ewlu@rivosinc.com>, gnu-toolchain <gnu-toolchain@rivosinc.com>
References: <20240115231552.3217789-1-vineetg@rivosinc.com>
 <f23eb285-16a8-44ee-991b-224b480dd91b@linaro.org>
Content-Language: en-US
In-Reply-To: <f23eb285-16a8-44ee-991b-224b480dd91b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=vineetg@rivosinc.com; helo=mail-ot1-x336.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 1/15/24 15:18, Richard Henderson wrote:
> On 1/16/24 10:15, Vineet Gupta wrote:
>> When testing gcc testsuite against QEMU v8.2 we found some additional
>> failures vs. v8.1.2.
>>
>> | FAIL: gcc.dg/cleanup-10.c execution test
>> | FAIL: gcc.dg/cleanup-11.c execution test
>> | FAIL: gcc.dg/cleanup-8.c execution test
>> | FAIL: gcc.dg/cleanup-9.c execution test
>>
>> All of these tests involve unwinding off signal stack and v8.2 did
>> introduce a vdso with sigreturn trampoline and associated unwinding
>> info. It seems that info is not correct and making it similar to
>> to one in the linux kernel fixes the above failures.
> So.. you didn't actually determine what might be off in the unwind info?

Not yet. I just tried what kernel had and that worked.

>
>> +	.cfi_startproc
>> +	.cfi_signal_frame
>> +       raw_syscall __NR_rt_sigreturn
>> +       .cfi_endproc
> No, this is wrong.  It indicates that the unwind info is present and trivial.

Ok it seems the issue is really subtle.

With 8.2 trunk, the NOP needed before signal trampoline seems to be be
factored into the unwind info for sigrestorer.

    0000003c 0000000000000098 00000000 CIE
      Version:               3
      Augmentation:          "zRS"
      Code alignment factor: 1
      Data alignment factor: -4
      Return address column: 64
      Augmentation data:     1b
      DW_CFA_def_cfa: r2 (sp) ofs 832
      DW_CFA_offset_extended: r64 at cfa-528
      DW_CFA_offset: r1 (ra) at cfa-520
      DW_CFA_offset: r2 (sp) at cfa-512
    ...
      DW_CFA_offset: r63 (ft11) at cfa-24
      DW_CFA_nop
      DW_CFA_nop

    000000d8 0000000000000010 000000a0 FDE cie=0000003c
    pc=000000000000066c..0000000000000678
                                                                                                                                     
    ^^^    <--- NOP included
      DW_CFA_nop
      DW_CFA_nop
      DW_CFA_nop

    0000000000000664 <__vdso_flush_icache>:
     664:    00000513              li    a0,0
     668:    00008067              ret
     66c:    00000013              nop                 <--- this NOP

    0000000000000670 <__vdso_rt_sigreturn>:
     670:    08b00893              li    a7,139
     674:    00000073              ecall


This is due to the .cfi_startproc bracketing. If we move the nop out of
the .cfi_{start,end}proc, things start to work as well.

    diff --git a/linux-user/riscv/vdso.S b/linux-user/riscv/vdso.S
    index 4b4e34aeea51..8c9f1038cb8c 100644
    --- a/linux-user/riscv/vdso.S
    +++ b/linux-user/riscv/vdso.S
    @@ -92,6 +92,8 @@ endf __vdso_flush_icache
     
            .cfi_endproc
     
    +       nop
    +
     /*
      * Start the unwind info at least one instruction before the signal
      * trampoline, because the unwinder will assume we are returning
    @@ -178,8 +180,6 @@ endf __vdso_flush_icache
            .cfi_offset     62, B_FR + 30 * sizeof_freg
            .cfi_offset     63, B_FR + 31 * sizeof_freg     /* f31 */
     
    -       nop
    -
     __vdso_rt_sigreturn:
            raw_syscall __NR_rt_sigreturn
     endf __vdso_rt_sigreturn


This changes the cfi info slightly as follows:

000000d8 0000000000000010 000000a0 FDE cie=0000003c
pc=0000000000000670..0000000000000678  <-- excludes nop
  DW_CFA_nop
  DW_CFA_nop
  DW_CFA_nop


0000000000000664 <__vdso_flush_icache>:
 664:    00000513              li    a0,0
 668:    00008067              ret
 66c:    00000013              nop

0000000000000670 <__vdso_rt_sigreturn>:
 670:    08b00893              li    a7,139
 674:    00000073              ecall

I concur this is still not 100% explanation of why things are going off,
but I have exact same nop quirk for glibc ARC sigrestorer.
Would an updated patch along those lines be more palatable.

Thx,
-Vineet

