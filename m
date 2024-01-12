Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C7D82C6C0
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 22:36:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOPC0-0001Xf-9P; Fri, 12 Jan 2024 16:35:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rOPBx-0001XX-SK
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 16:35:53 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rOPBu-0007da-25
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 16:35:51 -0500
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6dde528dbe8so2451065a34.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 13:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705095346; x=1705700146; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KpPY8lhBZwsC5fG5+3qx1mZ2RZbUVLePRQx2Jor1MAk=;
 b=VVA4zGvQcOPtEwYXQskc5PZ4RAilNi+SaVtVT2V04tn8KUeRH9NPhwpoPwH64nm+1h
 LNL330Ie4I2RmNAv8gz21eH3BV3BqaGF+aL0TEfnV0dIyJ7CcIchmx9N+K8zNxQPlsCU
 7iSL749LoO1mVfi2y/G5rNLmBzDvh/Fry9BwKFaaKxhxb0FpL+pOawYq/YfC6+y182YK
 AqPqJFE9pDzNnm3ZiJ1yniQGMz100rBjLdjjEqKg/Axr8makFrG4QHmtF0kmtuK2HnJj
 +L/ENgAwq3UIdgBMgrAH9DhrzcbHz9WbNkaRN1fD+BRczGTi4hsCjUrCOLBmJ26j/x2m
 iiHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705095346; x=1705700146;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KpPY8lhBZwsC5fG5+3qx1mZ2RZbUVLePRQx2Jor1MAk=;
 b=LUdGhoFxfIddsMpEUcmntRd0z2npkuW6MyRXIBOBnNgv/LsxOUvRW8LKx7QkVZPY8h
 PxylVaJSohPeeWXxzVDQmcVanBcJ2OJrztGJWKIyQBLXsDp7hiKAm8/QKezNQH8dtAU8
 50gjRKP6x7Dj4wSMIK8qlTBA0hpqiUC7cQK71kpWhnVXoqJMDBzZqF8iuXoHfmOQ3Ubl
 gaS14dQgS3GQtxKQCOfsD2XAWxcYZScTrk9w9FojtElacotl2EBmzH5jEFWTUginZZq1
 oG0pyHTZTyPA1BpMFDQyLGpZDHtSD60AeyGFbK36vmkUlE3/TKvYLe9DCiVjp4jOk221
 hTOQ==
X-Gm-Message-State: AOJu0YzO8h+AnBjpShUikAJTwEBP9PGSzHA9NBvFrE/jbo0FYKos1JsV
 a2GTWNMrQ0guM7cdbfJ+5E2pimY1hvtCzQ==
X-Google-Smtp-Source: AGHT+IH/4C8csd30HEZtjrQvHZhKhHzxZSJl6i4dS+QA0LGKF12xIZD9h2o63z4bsr4XmXJajZJV7g==
X-Received: by 2002:a05:6830:18ee:b0:6dc:97:186 with SMTP id
 d14-20020a05683018ee00b006dc00970186mr2459329otf.26.1705095346609; 
 Fri, 12 Jan 2024 13:35:46 -0800 (PST)
Received: from ?IPV6:2001:8004:2728:2ad6:e985:c1c8:a4fc:508?
 ([2001:8004:2728:2ad6:e985:c1c8:a4fc:508])
 by smtp.gmail.com with ESMTPSA id
 t19-20020a62ea13000000b006d9c0dd1b26sm3715196pfh.15.2024.01.12.13.35.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jan 2024 13:35:46 -0800 (PST)
Message-ID: <119848b9-0cd7-4d33-bc43-385c86069388@linaro.org>
Date: Sat, 13 Jan 2024 08:35:39 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 15/21] linux-user/riscv: Add vdso
Content-Language: en-US
To: Vineet Gupta <vineetg@rivosinc.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Edwin Lu <ewlu@rivosinc.com>, gnu-toolchain <gnu-toolchain@rivosinc.com>
References: <20231030211727.165090-1-richard.henderson@linaro.org>
 <20231030211727.165090-16-richard.henderson@linaro.org>
 <d5265d3a-7df7-4f93-93c4-a5d3a6251372@rivosinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <d5265d3a-7df7-4f93-93c4-a5d3a6251372@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
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

On 1/12/24 08:49, Vineet Gupta wrote:
> Hi Richard, Alistair
> 
> On 10/30/23 14:17, Richard Henderson wrote:
>> diff --git a/linux-user/riscv/Makefile.vdso b/linux-user/riscv/Makefile.vdso
>> new file mode 100644
>> index 0000000000..2c257dbfda
>> --- /dev/null
>> +++ b/linux-user/riscv/Makefile.vdso
>> @@ -0,0 +1,15 @@
>> +include $(BUILD_DIR)/tests/tcg/riscv64-linux-user/config-target.mak
>> +
>> +SUBDIR = $(SRC_PATH)/linux-user/riscv
>> +VPATH += $(SUBDIR)
>> +
>> +all: $(SUBDIR)/vdso-32.so $(SUBDIR)/vdso-64.so
>> +
>> +LDFLAGS = -nostdlib -shared -fpic -Wl,-h,linux-vdso.so.1 -Wl,--build-id=sha1 \
>> +	  -Wl,--hash-style=both -Wl,-T,$(SUBDIR)/vdso.ld
>> +
>> +$(SUBDIR)/vdso-32.so: vdso.S vdso.ld vdso-asmoffset.h
>> +	$(CC) -o $@ $(LDFLAGS) -mabi=ilp32d -march=rv32g $<
>> +
>> +$(SUBDIR)/vdso-64.so: vdso.S vdso.ld vdso-asmoffset.h
>> +	$(CC) -o $@ $(LDFLAGS) -mabi=lp64d -march=rv64g $<
> 
> So by default qemu ships the vdso binary. How can one rebuild it ?
> 
>  From skimming the build files it seems following ought to do it
>      make update-linux-vdso
> 
> with a prior configure cmd like below with PATH pointing to the cross
> compiler.
> ../configure  --target-list=riscv64-linux-user
> --cross-cc-riscv64=riscv64-unknown-linux-gnu-gcc

Yes, that should do it.

> But it doesn't, I'm sure we are missing something basis here.

Do you get an error message?
Did $(BUILD_DIR)/tests/tcg/riscv64-linux-user/config-target.mak get created properly?

> For starters we saw something that seems like a thinko in
> 
> diff --git a/linux-user/riscv/vdso.S b/linux-user/riscv/vdso.S
> -#define sizeof_reg     (__riscv_xlen / 4)
> +#define sizeof_reg     (__riscv_xlen / 8)

Oops.

> As as aside, we also see that rt_sigreturn in kernel vdso elides the
> explicit the call frame information. Again we naively don't know if that
> is required in qemu.
> 
>      .text
> ENTRY(__vdso_rt_sigreturn)
>      .cfi_startproc
>      .cfi_signal_frame
>      li a7, __NR_rt_sigreturn
>      ecall
>      .cfi_endproc
> ENDPROC(__vdso_rt_sigreturn)

Perhaps it's not required, no.  But I'd consider the lack of info from the kernel to be a 
bug.  Lack of it means places like gcc have to have special cases.



r~

