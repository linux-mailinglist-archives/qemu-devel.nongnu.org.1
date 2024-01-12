Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6350D82C807
	for <lists+qemu-devel@lfdr.de>; Sat, 13 Jan 2024 00:39:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOR5l-0006bY-6v; Fri, 12 Jan 2024 18:37:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vineetg@rivosinc.com>)
 id 1rOR5i-0006bP-Qf
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 18:37:34 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vineetg@rivosinc.com>)
 id 1rOR5d-0004qI-1a
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 18:37:34 -0500
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3bbd6e3795eso5439286b6e.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 15:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705102647; x=1705707447;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iiqV41JBaQf78r7S04NtkJddMSBSsCAwwv/RTPtPL4I=;
 b=xRNxiOkLVKfCvONGaEsjZWOKLGH3LbJft5Ojj5bUyZvp0kr+uul3naLzzqfFF6r0eg
 7zjH8aF6YCi/pkBRA8IKNo69Bz2IWW0I7Fj9YXjLbsLfX0ID6uGj/V1pTS48cjGRtK5O
 Xh0coILuLZUYqJ0MET/k/DEZMlP6fTR7YC1tz1qOnm1CqDbn4KWCozhokpxE6U1dSYhH
 qvz26OUX7cAnCnD9Ty6c5sanli0vYg+TnGa7h+l7jX0u23v3ibDAI6hwML23yYhAb8HP
 DBQhaIzkBPwj/obENbS0HrlBpmJlNVlqfPF5hOCzNt6yYVdrUMVlFaId66kYUjPEPzP6
 EZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705102647; x=1705707447;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iiqV41JBaQf78r7S04NtkJddMSBSsCAwwv/RTPtPL4I=;
 b=bE5fgAPUKhw2VD9Ob6sZ7UDqMDJz1xMhrDP105EKArZHLBHzaUvTq5nw5uQ9uXLqdl
 /iAZdI2G3a2pEj+uOefaDK+mqADLge3Cs4lzr6eGZvvqn5QNJZnOmSqGk9mXSd8lRq5c
 0SI+2NzhTQzc24aR/GHInWl1ugqTB6ncXSaNJB3UZJxY1/SBfCQeAXR1SmubV46ytj6Z
 WAEDbYCidBzDPKMDic1xGX6Oz+HJRctAE6xecllTq5ps3fFkeetYfnquaNNJtqKZ1+We
 fUkoWjrX/AFiaXdnFmAL3WJr+cQP4k84bCEA8eFGQyvanMaXGQpwon4DSl8XNjQzA8js
 8erw==
X-Gm-Message-State: AOJu0YyZbkfbzcgbyi8UoaDbmfodfSzJk8/EgK5WiQjrkD5Dfi3d+f+/
 SRbtMv1MgLARFJBvjfpPWFD7VNk/m3FjtA==
X-Google-Smtp-Source: AGHT+IGXSPB6v9QuUeXLo462Hk60Xn3KDO85nndFXisQjq02Fbb+HkYANC3r4KKaFs9CcaNPgqgxMw==
X-Received: by 2002:a05:6808:16aa:b0:3bc:3d58:288f with SMTP id
 bb42-20020a05680816aa00b003bc3d58288fmr1828037oib.10.1705102647436; 
 Fri, 12 Jan 2024 15:37:27 -0800 (PST)
Received: from [192.168.50.117] (c-24-5-188-125.hsd1.ca.comcast.net.
 [24.5.188.125]) by smtp.gmail.com with ESMTPSA id
 sc4-20020a17090b510400b0028cefda6fa2sm4836179pjb.24.2024.01.12.15.37.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jan 2024 15:37:27 -0800 (PST)
Message-ID: <b84e0809-669f-49c9-8163-847485cfe7e4@rivosinc.com>
Date: Fri, 12 Jan 2024 15:37:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 15/21] linux-user/riscv: Add vdso
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Edwin Lu <ewlu@rivosinc.com>, gnu-toolchain <gnu-toolchain@rivosinc.com>,
 Palmer Dabbelt <palmer@rivosinc.com>
References: <20231030211727.165090-1-richard.henderson@linaro.org>
 <20231030211727.165090-16-richard.henderson@linaro.org>
 <d5265d3a-7df7-4f93-93c4-a5d3a6251372@rivosinc.com>
 <119848b9-0cd7-4d33-bc43-385c86069388@linaro.org>
Content-Language: en-US
From: Vineet Gupta <vineetg@rivosinc.com>
In-Reply-To: <119848b9-0cd7-4d33-bc43-385c86069388@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=vineetg@rivosinc.com; helo=mail-oi1-x229.google.com
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



On 1/12/24 13:35, Richard Henderson wrote:
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
>> So by default qemu ships the vdso binary. How can one rebuild it ?
>>
>>  From skimming the build files it seems following ought to do it
>>      make update-linux-vdso
>>
>> with a prior configure cmd like below with PATH pointing to the cross
>> compiler.
>> ../configure  --target-list=riscv64-linux-user
>> --cross-cc-riscv64=riscv64-unknown-linux-gnu-gcc
> Yes, that should do it.
>
>> But it doesn't, I'm sure we are missing something basis here.
> Do you get an error message?
> Did $(BUILD_DIR)/tests/tcg/riscv64-linux-user/config-target.mak get created properly?

It was indeed, but invoking make wasn't doing anything.

Weirdly enought, after (yet another) clean rebuild the vdso does seem to
build.
So the vdso is subsumed into the qemu binary ? I mean do we need to
rebuild qemu after the vdso rebuild. Something in the build dependency
is off for sure.
Sorry but do u have a cmdline for dummies to rebuild vdso and then qemu.

Thing is something is definitely off with 8.2.

With 2 setups of riscv-gnu-toolchain and everything being same except
for qemu (v8.2 and v8.1.2) we see 4 additional failures in gcc testsuite.
These all pertain to unwinding off signal stack

                 ========= Summary of gcc testsuite =========
| # of unexpected case/ # of unique unexpected case
|          gcc |         g++ |     gfortran |
rv64imafdc_zba_zbb_zbs_zicond/  lp64d/ medlow |  40 /    19 |   23 /     8 |   72 /    12 |       # v8.2
rv64imafdc_zba_zbb_zbs_zicond/  lp64d/ medlow |  36 /    15 |    7 /     4 |      - |             # v8.1.2

FAIL: gcc.dg/cleanup-10.c execution test
FAIL: gcc.dg/cleanup-11.c execution test
FAIL: gcc.dg/cleanup-8.c execution test
FAIL: gcc.dg/cleanup-9.c execution test

Now if only I could rebuild vdso/qemu with the revert of following and
the reg size change.
     2021-07-06 468c1bb5cac9 linux-user/riscv: Add vdso  


>
>> For starters we saw something that seems like a thinko in
>>
>> diff --git a/linux-user/riscv/vdso.S b/linux-user/riscv/vdso.S
>> -#define sizeof_reg     (__riscv_xlen / 4)
>> +#define sizeof_reg     (__riscv_xlen / 8)
> Oops.

Thx for taking care of that.


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
> Perhaps it's not required, no.  But I'd consider the lack of info from the kernel to be a 
> bug.  Lack of it means places like gcc have to have special cases.

