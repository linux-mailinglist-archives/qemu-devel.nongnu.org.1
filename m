Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3557B69DD
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 15:08:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnf7S-0003gU-9W; Tue, 03 Oct 2023 09:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnf7N-0003f2-Pc
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 09:07:18 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnf7L-0007jH-Tz
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 09:07:17 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-32483535e51so969723f8f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 06:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696338434; x=1696943234; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=soXVNOY75BLalkQB99WYxBZlBCKNbFdp/x82QwhocGM=;
 b=dut+lQG7LWmPoP4yYWNJovgTS/Rde7dclYSN3E00MT5LukRktSdr1Y+HMxuhfTnGcE
 gLv4nOqkf/MJNSAVpZGKFyqgkvVXPX/BtMDPDaBdF7+sCLz+LEhUcgbBmCds+MmzYZNe
 TYHXwuyUFddyfVvaQcYDjJ2yQWMj5LsKP8z5W3FlCXdzPt7njhHFx9sCBb0NKYx7zVA/
 bQ+UYFW7AUHJhWbVeLY40fZ7aX8nn3RWgdCLOhE9+cMYBbAArwLOLwlTiu+ypQxjdPaX
 DGJ0cf4I/XfgaWKmSNHqVpfFom2i6QfZQOvXmMTsZsvqLZ+Vbhue9W7rMPK2g3VI88GZ
 A2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696338434; x=1696943234;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=soXVNOY75BLalkQB99WYxBZlBCKNbFdp/x82QwhocGM=;
 b=nvew9DC60XhoOw49cM8O0LzeYEBGBewn+NQ8U8qH+ahlL0QxTQkEzlGoSs/SXk0lbM
 YY1eZFLFGfH3ohoAVQiwb96AT3VkG3apEBC+Gt2WLRSiTV3y8ZaCe/zSB8mr2Q8Zbouv
 qUHtMovRysuQsG9ifF4VI/R2/mRW8Rle+S7gTLWdSJCh2tqvWL0EuU7Jxc3WaHOyX/pk
 rNkWZUb8H0KVEpHwXJQ0VLhH2Mw+6pK6oTHeLLIX64QxnDrmzqIXQe226q83ce8aROMQ
 zMFMugL/aVstVPX4E01A2KF3I/xFYnptdnAlA5z81jJsT0qXsoRWjzsjwWiOaw2XV8pA
 PefQ==
X-Gm-Message-State: AOJu0YwzogIfw6D9SAt2b93j5aCJgd0YoUnMPKKvBVm7M+nQ1UuIpNnT
 /MSMZ7hW9MRaCH0ADIDY58Duew==
X-Google-Smtp-Source: AGHT+IE0Ozh6ksEkeYNOEobkS5+jSvo2nHFv8qZVw2+V/lI0AGjzPeIIDkT+Rm+c4RwRSAR1TCEB6Q==
X-Received: by 2002:adf:d086:0:b0:31f:b91f:23ef with SMTP id
 y6-20020adfd086000000b0031fb91f23efmr12922311wrh.51.1696338433090; 
 Tue, 03 Oct 2023 06:07:13 -0700 (PDT)
Received: from [192.168.69.115] (176-131-222-246.abo.bbox.fr.
 [176.131.222.246]) by smtp.gmail.com with ESMTPSA id
 j16-20020a056000125000b00326f5d0ce0asm1558162wrx.21.2023.10.03.06.07.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 06:07:12 -0700 (PDT)
Message-ID: <92c8b00d-157e-6a03-7629-c331cf41ffc5@linaro.org>
Date: Tue, 3 Oct 2023 15:07:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v6 18/19] linux-user/s390x: Add vdso
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, laurent@vivier.eu
References: <20230930021529.987950-1-richard.henderson@linaro.org>
 <20230930021529.987950-19-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230930021529.987950-19-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi Richard,

On 30/9/23 04:15, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/s390x/vdso-asmoffset.h |   2 +
>   linux-user/elfload.c              |   2 +
>   linux-user/s390x/signal.c         |   4 +-
>   linux-user/s390x/Makefile.vdso    |  11 +++++
>   linux-user/s390x/meson.build      |   6 +++
>   linux-user/s390x/vdso.S           |  61 ++++++++++++++++++++++++++
>   linux-user/s390x/vdso.ld          |  69 ++++++++++++++++++++++++++++++
>   linux-user/s390x/vdso.so          | Bin 0 -> 3464 bytes
>   8 files changed, 152 insertions(+), 3 deletions(-)
>   create mode 100644 linux-user/s390x/vdso-asmoffset.h
>   create mode 100644 linux-user/s390x/Makefile.vdso
>   create mode 100644 linux-user/s390x/vdso.S
>   create mode 100644 linux-user/s390x/vdso.ld
>   create mode 100755 linux-user/s390x/vdso.so


> diff --git a/linux-user/s390x/Makefile.vdso b/linux-user/s390x/Makefile.vdso
> new file mode 100644
> index 0000000000..e82bf9e29f
> --- /dev/null
> +++ b/linux-user/s390x/Makefile.vdso
> @@ -0,0 +1,11 @@
> +include $(BUILD_DIR)/tests/tcg/s390x-linux-user/config-target.mak
> +
> +SUBDIR = $(SRC_PATH)/linux-user/s390x
> +VPATH += $(SUBDIR)
> +
> +all: $(SUBDIR)/vdso.so
> +
> +$(SUBDIR)/vdso.so: vdso.S vdso.ld vdso-asmoffset.h
> +	$(CC) -o $@ -nostdlib -shared -Wl,-h,linux-vdso64.so.1 \
> +	  -Wl,--build-id=sha1 -Wl,--hash-style=both \
> +	  -Wl,-T,$(SUBDIR)/vdso.ld $<
> diff --git a/linux-user/s390x/meson.build b/linux-user/s390x/meson.build
> index 0781ccea1d..a7a25ed9ce 100644
> --- a/linux-user/s390x/meson.build
> +++ b/linux-user/s390x/meson.build
> @@ -3,3 +3,9 @@ syscall_nr_generators += {
>                        arguments: [ meson.current_source_dir() / 'syscallhdr.sh', '@INPUT@', '@OUTPUT@', '@EXTRA_ARGS@' ],
>                        output: '@BASENAME@_nr.h')
>   }
> +
> +vdso_inc = gen_vdso.process('vdso.so', extra_args: [
> +                                '-s', '__kernel_sigreturn',
> +                                '-r', '__kernel_rt_sigreturn'
> +                            ])
> +linux_user_ss.add(when: 'TARGET_S390X', if_true: vdso_inc)
> diff --git a/linux-user/s390x/vdso.S b/linux-user/s390x/vdso.S
> new file mode 100644
> index 0000000000..3332492477
> --- /dev/null
> +++ b/linux-user/s390x/vdso.S
> @@ -0,0 +1,61 @@
> +/*
> + * s390x linux replacement vdso.
> + *
> + * Copyright 2023 Linaro, Ltd.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include <asm/unistd.h>
> +#include "vdso-asmoffset.h"
> +
> +.macro endf name
> +	.globl	\name
> +	.type	\name, @function
> +	.size	\name, . - \name
> +.endm
> +
> +.macro raw_syscall n
> +        .ifne	\n < 0x100
> +	svc	\n
> +	.else
> +	lghi	%r1, \n
> +	svc	0
> +        .endif
> +.endm
> +
> +.macro vdso_syscall name, nr
> +\name:
> +	.cfi_startproc
> +	aghi	%r15, -(STACK_FRAME_OVERHEAD + 16)
> +	.cfi_adjust_cfa_offset STACK_FRAME_OVERHEAD + 16
> +	stg	%r14, STACK_FRAME_OVERHEAD(%r15)
> +	.cfi_rel_offset %r14, STACK_FRAME_OVERHEAD
> +	raw_syscall \nr
> +	lg	%r14, STACK_FRAME_OVERHEAD(%r15)
> +	aghi	%r15, STACK_FRAME_OVERHEAD + 16
> +	.cfi_restore %r14
> +	.cfi_adjust_cfa_offset -(STACK_FRAME_OVERHEAD + 16)
> +	br	%r14
> +	.cfi_endproc
> +endf	\name
> +.endm
> +
> +vdso_syscall __kernel_gettimeofday, __NR_gettimeofday
> +vdso_syscall __kernel_clock_gettime, __NR_clock_gettime
> +vdso_syscall __kernel_clock_getres, __NR_clock_getres
> +vdso_syscall __kernel_getcpu, __NR_getcpu
> +
> +/*
> + * TODO unwind info, though we're ok without it.
> + * The kernel supplies bogus empty unwind info, and it is likely ignored
> + * by all users.  Without it we get the fallback signal frame handling.
> + */
> +
> +__kernel_sigreturn:
> +	raw_syscall __NR_sigreturn
> +endf	__kernel_sigreturn
> +
> +__kernel_rt_sigreturn:
> +	raw_syscall __NR_rt_sigreturn
> +endf	__kernel_rt_sigreturn
> diff --git a/linux-user/s390x/vdso.ld b/linux-user/s390x/vdso.ld
> new file mode 100644
> index 0000000000..2a30ff382a
> --- /dev/null
> +++ b/linux-user/s390x/vdso.ld
> @@ -0,0 +1,69 @@
> +/*
> + * Linker script for linux x86-64 replacement vdso.
> + *
> + * Copyright 2023 Linaro, Ltd.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +VERSION {
> +        LINUX_2.6.29 {
> +        global:
> +                __kernel_gettimeofday;
> +                __kernel_clock_gettime;
> +                __kernel_clock_getres;
> +                __kernel_getcpu;
> +                __kernel_restart_syscall;

Where is __kernel_restart_syscall defined?

> +                __kernel_rt_sigreturn;
> +                __kernel_sigreturn;
> +        local: *;
> +        };
> +}


