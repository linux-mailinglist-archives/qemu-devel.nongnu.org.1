Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B9882C7D5
	for <lists+qemu-devel@lfdr.de>; Sat, 13 Jan 2024 00:06:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOQaD-00087a-9T; Fri, 12 Jan 2024 18:05:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1rOQa9-00087Q-Kp
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 18:04:57 -0500
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1rOQa5-0004vP-7O
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 18:04:57 -0500
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-203fb334415so4501557fac.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 15:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1705100690; x=1705705490;
 darn=nongnu.org; 
 h=message-id:to:from:cc:in-reply-to:subject:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=JtrWsXHcqdtCTKgVjDVeBeWKAPgeE2LLtsQmuJfDMIg=;
 b=aw4jz++5SFarO/c0zmZYpgTvWPzWBkng1Y1jrmYkrbFhkvLU/05l4aN7RqYW0zVaGH
 bOKN8toh2MRkFklOKm5gF1FngoXFYqc955PRwIYGRR7k+bzr3kiyDdB2DMFOf7wqA5GA
 oOKSkiDN/vpYcSECp8OVeO0tsExRjxweN2VXly8Ld/Nn6nm+Uvls64e6hJnv7/tQFiJ7
 4lh9C+YCpbaHpI7WNzVpopb+O/YOdCshgqhWaNCrEeeMgMc8ay82Mnjc/UL/6Q61BzsG
 jabpOxVlnJcYjRjchDLOIJHGdJoMvOLIw19jXBjN/UmP5/zEubSaq8xCyH5bcMNCt1lO
 5MgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705100690; x=1705705490;
 h=message-id:to:from:cc:in-reply-to:subject:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JtrWsXHcqdtCTKgVjDVeBeWKAPgeE2LLtsQmuJfDMIg=;
 b=uJr6ZDZP9GXbirr1k3wqD9HfNNHzbCAMpcuI5VSWphdu8LC+S5PJV9tzoVprihBcXr
 p1qRjsT5iS2ZGr0Qr1E1yKSyh2+1WyRgrQonenj5lvy8Icrnk/fNzgeEgLOeKvfSm/H4
 1f4/64F05k2iURsJBOo9ja6wa4DiW66QW5Zqiuy00tZGHn2oZ2bipPbWwuYB8nI6gohq
 /xVhzCmT7d9cln+bp8R1XwL+z98AYzA/5sCUf6ie/U2Y5JCivytL+EC3u3ozk0cwdcvq
 66FbD9gFB2PulVYdRvm/SDTL+MEbu08A9WUhdtbIqxNkoBoyvBAqfwhQG6QOFD6rKjQL
 A8Cw==
X-Gm-Message-State: AOJu0Yxa/wXi+soj5IwR6qbRvbSX5swFkdDWOCQhwbp/aEiGir7obPQu
 uZohHhhWrQWn9bEp8n8z0w7LFuUxxFp3Sg==
X-Google-Smtp-Source: AGHT+IEAbvKRDDSPcMfcbb9hEwtrVOmXmhXA/mhOQHV/K5NtvdwJAF7BxuLaFZwdY2MWz035n7NOfQ==
X-Received: by 2002:a05:6870:158a:b0:206:9742:eeb7 with SMTP id
 j10-20020a056870158a00b002069742eeb7mr2516534oab.65.1705100690398; 
 Fri, 12 Jan 2024 15:04:50 -0800 (PST)
Received: from localhost ([192.184.165.199]) by smtp.gmail.com with ESMTPSA id
 du9-20020a056a002b4900b006da2b1e4fabsm3662054pfb.163.2024.01.12.15.04.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 15:04:49 -0800 (PST)
Date: Fri, 12 Jan 2024 15:04:49 -0800 (PST)
X-Google-Original-Date: Fri, 12 Jan 2024 15:04:45 PST (-0800)
Subject: Re: [PULL 15/21] linux-user/riscv: Add vdso
In-Reply-To: <119848b9-0cd7-4d33-bc43-385c86069388@linaro.org>
CC: Vineet Gupta <vineetg@rivosinc.com>, qemu-devel@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>, philmd@linaro.org,
 ewlu@rivosinc.com, gnu-toolchain@rivosinc.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <mhng-d9fc5259-0fd0-4852-b66a-0c1ede5fda49@palmer-ri-x1c9>
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=palmer@dabbelt.com; helo=mail-oa1-x2f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, PP_MIME_FAKE_ASCII_TEXT=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, 12 Jan 2024 13:35:39 PST (-0800), Richard Henderson wrote:
> On 1/12/24 08:49, Vineet Gupta wrote:
>> Hi Richard, Alistair
>> 
>> On 10/30/23 14:17, Richard Henderson wrote:
>>> diff --git a/linux-user/riscv/Makefile.vdso b/linux-user/riscv/Makefile.vdso
>>> new file mode 100644
>>> index 0000000000..2c257dbfda
>>> --- /dev/null
>>> +++ b/linux-user/riscv/Makefile.vdso
>>> @@ -0,0 +1,15 @@
>>> +include $(BUILD_DIR)/tests/tcg/riscv64-linux-user/config-target.mak
>>> +
>>> +SUBDIR = $(SRC_PATH)/linux-user/riscv
>>> +VPATH += $(SUBDIR)
>>> +
>>> +all: $(SUBDIR)/vdso-32.so $(SUBDIR)/vdso-64.so
>>> +
>>> +LDFLAGS = -nostdlib -shared -fpic -Wl,-h,linux-vdso.so.1 -Wl,--build-id=sha1 \
>>> +	  -Wl,--hash-style=both -Wl,-T,$(SUBDIR)/vdso.ld
>>> +
>>> +$(SUBDIR)/vdso-32.so: vdso.S vdso.ld vdso-asmoffset.h
>>> +	$(CC) -o $@ $(LDFLAGS) -mabi=ilp32d -march=rv32g $<
>>> +
>>> +$(SUBDIR)/vdso-64.so: vdso.S vdso.ld vdso-asmoffset.h
>>> +	$(CC) -o $@ $(LDFLAGS) -mabi=lp64d -march=rv64g $<
>> 
>> So by default qemu ships the vdso binary. How can one rebuild it ?
>> 
>>  From skimming the build files it seems following ought to do it
>>      make update-linux-vdso
>> 
>> with a prior configure cmd like below with PATH pointing to the cross
>> compiler.
>> ../configure  --target-list=riscv64-linux-user
>> --cross-cc-riscv64=riscv64-unknown-linux-gnu-gcc
>
> Yes, that should do it.
>
>> But it doesn't, I'm sure we are missing something basis here.
>
> Do you get an error message?
> Did $(BUILD_DIR)/tests/tcg/riscv64-linux-user/config-target.mak get created properly?
>
>> For starters we saw something that seems like a thinko in
>> 
>> diff --git a/linux-user/riscv/vdso.S b/linux-user/riscv/vdso.S
>> -#define sizeof_reg     (__riscv_xlen / 4)
>> +#define sizeof_reg     (__riscv_xlen / 8)
>
> Oops.
>
>> As as aside, we also see that rt_sigreturn in kernel vdso elides the
>> explicit the call frame information. Again we naively don't know if that
>> is required in qemu.
>> 
>>      .text
>> ENTRY(__vdso_rt_sigreturn)
>>      .cfi_startproc
>>      .cfi_signal_frame
>>      li a7, __NR_rt_sigreturn
>>      ecall
>>      .cfi_endproc
>> ENDPROC(__vdso_rt_sigreturn)
>
> Perhaps it's not required, no.  But I'd consider the lack of info from the kernel to be a 
> bug.  Lack of it means places like gcc have to have special cases.

Ya, I agree.  We've tried to avoid too many RISC-V-specific hacks for 
this, but it's bitten me a few times in embedded codebases and it's 
always a headache.

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>

Thanks!

Looks like we've got essentially the same thing in Linux already, so I 
think we're safe over there.

>
>
>
> r~
>
> -- 
> You received this message because you are subscribed to the Google Groups "gnu-toolchain" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to gnu-toolchain+unsubscribe@rivosinc.com.
> To view this discussion on the web visit https://groups.google.com/a/rivosinc.com/d/msgid/gnu-toolchain/119848b9-0cd7-4d33-bc43-385c86069388%40linaro.org.
> For more options, visit https://groups.google.com/a/rivosinc.com/d/optout.

