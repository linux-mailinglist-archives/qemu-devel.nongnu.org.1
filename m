Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F25D582FDFE
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 01:25:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPtjY-0001yI-5s; Tue, 16 Jan 2024 19:24:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rPtjW-0001y9-2p
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 19:24:42 -0500
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rPtjU-00077Z-BL
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 19:24:41 -0500
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3608e206f27so57412955ab.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 16:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705451073; x=1706055873; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fJPBcW286TIjVIvRhVP20qsxklLFEYJCpBKvQs3Bl5A=;
 b=w0n+59+bB71C0ukpnsqyjiZPxy5Sv4QmbyonkLpoH2W3G8ge0VKyv6caWRiVBRYO8W
 6o2HEnzqEylOHfrQfFm9Nr3gNwyQRuYUWm65OCuytO++i6/GC1b1rWIQiZjk8SZJ8J6W
 ytEXX06idruwTWBN9NwikoIuntgo1i2N9b55mep+AGpR+u6MwcFStWsZPs5t/d4WSzsE
 fkSltWJg5/7k9aKh+EAXoUD23tx0Hv0fhCvQB8emIzCsgmK1uqA5aHJ8PyGhqMDFRXd9
 v3dmKMJGNeDbMD98zPSuoP3wLGhE/j/9qzpY7S7KXTXu7XBMRpiuUabKWHTaUA/1uXo8
 I92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705451073; x=1706055873;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fJPBcW286TIjVIvRhVP20qsxklLFEYJCpBKvQs3Bl5A=;
 b=fxcFEkiLwOLSz220mH/x4nLszB40nEHy4F4pqDGQf6I/VifvI8DQO6LNHpEkeO+Dc8
 CH5jkycw+LxlVBe2x1MwcJfwnKkVFV+hK9TLYshu51HIwo00G7p2Cm6wftfdXEGVhi3P
 IvuntrgxZuOmsCCe5fets32ugtFwojCZDxKn2QPaEgpqSUp+6K0HyvKs+/qlhE/rw5UB
 kn5OBrfrMITJoG+NxqdgRaIuJgcE+trl15GbnotNIGhtB9df/nDjxrcwR2Od7j+OORNg
 0J1qXVsvvWQFYb5qUuZjQOGXJOogn+X25RnjJas3jovZuH6MLV58c0O7ABsfZw6BU1ow
 JzVw==
X-Gm-Message-State: AOJu0YznCFvCwuZD3K5UQg9VKy8Do6lNz8Tb44VWcCxw8/9Xu6dHmakY
 VB5ad03O/1xuOothdm6XiI5t0L9vd7dfqg==
X-Google-Smtp-Source: AGHT+IE+VuOt9wfAiZG6Yb8wY8izn7IPIJ3cK7HznP54qHD8a/vCDabGUReVREi6F6vZwnHDfSvA2w==
X-Received: by 2002:a05:6e02:11a4:b0:35f:ecf9:96ba with SMTP id
 4-20020a056e0211a400b0035fecf996bamr8502951ilj.11.1705451073124; 
 Tue, 16 Jan 2024 16:24:33 -0800 (PST)
Received: from ?IPV6:2001:8004:2738:1dd9:b8c3:7ceb:bfcc:14d9?
 ([2001:8004:2738:1dd9:b8c3:7ceb:bfcc:14d9])
 by smtp.gmail.com with ESMTPSA id
 l11-20020a633e0b000000b005ceac534e47sm10720441pga.51.2024.01.16.16.24.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jan 2024 16:24:32 -0800 (PST)
Message-ID: <7d31f4d8-7f9c-4ed0-878e-ea904ec3e7e6@linaro.org>
Date: Wed, 17 Jan 2024 11:24:24 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] linux-user/riscv: vdso: fix call frame info in
 __vdso_rt_sigreturn
Content-Language: en-US
To: Vineet Gupta <vineetg@rivosinc.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>, Edwin Lu
 <ewlu@rivosinc.com>, gnu-toolchain <gnu-toolchain@rivosinc.com>
References: <20240115231552.3217789-1-vineetg@rivosinc.com>
 <f23eb285-16a8-44ee-991b-224b480dd91b@linaro.org>
 <5c3856ea-644a-4d3c-a5a9-d03239ce5d06@rivosinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <5c3856ea-644a-4d3c-a5a9-d03239ce5d06@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12f;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 1/17/24 10:52, Vineet Gupta wrote:
> Ok it seems the issue is really subtle.
> 
> With 8.2 trunk, the NOP needed before signal trampoline seems to be be
> factored into the unwind info for sigrestorer.
> 
>      0000003c 0000000000000098 00000000 CIE
>        Version:               3
>        Augmentation:          "zRS"
>        Code alignment factor: 1
>        Data alignment factor: -4
>        Return address column: 64
>        Augmentation data:     1b
>        DW_CFA_def_cfa: r2 (sp) ofs 832
>        DW_CFA_offset_extended: r64 at cfa-528
>        DW_CFA_offset: r1 (ra) at cfa-520
>        DW_CFA_offset: r2 (sp) at cfa-512
>      ...
>        DW_CFA_offset: r63 (ft11) at cfa-24
>        DW_CFA_nop
>        DW_CFA_nop
> 
>      000000d8 0000000000000010 000000a0 FDE cie=0000003c
>      pc=000000000000066c..0000000000000678
>                                                                                                                                       
>      ^^^    <--- NOP included
>        DW_CFA_nop
>        DW_CFA_nop
>        DW_CFA_nop
> 
>      0000000000000664 <__vdso_flush_icache>:
>       664:    00000513              li    a0,0
>       668:    00008067              ret
>       66c:    00000013              nop                 <--- this NOP
> 
>      0000000000000670 <__vdso_rt_sigreturn>:
>       670:    08b00893              li    a7,139
>       674:    00000073              ecall
> 
> 
> This is due to the .cfi_startproc bracketing. If we move the nop out of
> the .cfi_{start,end}proc, things start to work as well.
> 
>      diff --git a/linux-user/riscv/vdso.S b/linux-user/riscv/vdso.S
>      index 4b4e34aeea51..8c9f1038cb8c 100644
>      --- a/linux-user/riscv/vdso.S
>      +++ b/linux-user/riscv/vdso.S
>      @@ -92,6 +92,8 @@ endf __vdso_flush_icache
>       
>              .cfi_endproc
>       
>      +       nop
>      +
>       /*
>        * Start the unwind info at least one instruction before the signal
>        * trampoline, because the unwinder will assume we are returning
>      @@ -178,8 +180,6 @@ endf __vdso_flush_icache
>              .cfi_offset     62, B_FR + 30 * sizeof_freg
>              .cfi_offset     63, B_FR + 31 * sizeof_freg     /* f31 */
>       
>      -       nop
>      -
>       __vdso_rt_sigreturn:
>              raw_syscall __NR_rt_sigreturn
>       endf __vdso_rt_sigreturn
> 
> 
> This changes the cfi info slightly as follows:
> 
> 000000d8 0000000000000010 000000a0 FDE cie=0000003c
> pc=0000000000000670..0000000000000678  <-- excludes nop
>    DW_CFA_nop
>    DW_CFA_nop
>    DW_CFA_nop
> 
> 
> 0000000000000664 <__vdso_flush_icache>:
>   664:    00000513              li    a0,0
>   668:    00008067              ret
>   66c:    00000013              nop
> 
> 0000000000000670 <__vdso_rt_sigreturn>:
>   670:    08b00893              li    a7,139
>   674:    00000073              ecall
> 
> I concur this is still not 100% explanation of why things are going off,
> but I have exact same nop quirk for glibc ARC sigrestorer.
> Would an updated patch along those lines be more palatable.

No.

The explanation is right there in the block comment: "Start the unwind info at least one 
instruction before...".  The unwind info is taken from that nop insn.

By moving the nop outside the unwind info, you remove the effect of the unwind info, as 
the nop is now outside of any unwind blocks.  It is the same as removing all of the unwind 
info entirely, which results in the (current) libgcc fallback information being used.


r~

